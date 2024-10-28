Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106321E0DA7
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142603; cv=none; b=ezv0sILvidy3lScc23eF5uYvq/lD/+PljOOwtdUMliB292NBzk63Hw3nVSkWEY4QAsY5OsYfzQBDzvigWN9Jf6rO7OQDjye5fH/Zn/5d5fbCPVRIYyT0tFwQBgXM2m0CiOTPOSxAgPFSnzeBXN2gZudSY/Ce6+LvxjPW2jXLwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142603; c=relaxed/simple;
	bh=ziF2VJ90fCNJ1VJT5YlQtfUuks6wOfzfgDVLpvDJKiI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ1gYecgqdx7xL3pjVw2Iv9EraNG2wJMH7Z4ITJO69RDBpGHb905yptlsILojP+ghRNcmeMm8b+QxCPMyJyVAt3zVpczCzXaPCnEBfGemlbbAIrZhVw4R1DNnNiEEtslG8a0Yqw4RW/5LAIcs5929yNWF3C04TPfeBlkM3em2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nKcjhPAn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nKcjhPAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730142598; x=1730401798;
	bh=hbz/9E5sL0Y+heWiqGSRsXUjrzjF0gjDnw2r0eCuoPw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nKcjhPAnaqcqk6PcjzenPTcbBI26XkSqF1obRXW9krwUXhXdCkvWyDsolltgpcDFX
	 cwj9eT4/T5uLK6Upq3921zy8/iGaa68u47TQDXiiR915f+4yQwLCRUp812bdWBU3Sf
	 eG8lK2WRSAxP1gwqIhkwAraDVkBOWMg85Q3z0TtjMifvqNiDu8zEG7Gqoc2OE0gwFl
	 IR//V0E523Vs2L84bpdbsRPnCuxcW+9YX6bVjk9o/Eb3RdxB1CQG14YdCuGQ+4VYoS
	 DOJaNsZ3V36OE0MoqlxXhDBbMVl1XmYmhhD5ezykqnPnDDqMAuRG1Arm0JFa5BmC0r
	 Hd9Uzsoahh3qQ==
Date: Mon, 28 Oct 2024 19:09:52 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 3/5] worktree: add tests for worktrees with relative paths
Message-ID: <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me>
In-Reply-To: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 6e9ea7c974715680ac0984381c2590e8275ec700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch expands the test coverage by adding cases that specifically
handle relative paths. These tests verify correct behavior in a variety
of operations, including: adding, listing, pruning, moving, and
repairing worktrees with relative paths configured.

This also adds a test case for reinitializing a repository that has
relative worktrees.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 t/t0001-init.sh            | 17 +++++++++++++----
 t/t2400-worktree-add.sh    | 41 +++++++++++++++++++++++++++++++++++++++++
 t/t2401-worktree-prune.sh  |  3 ++-
 t/t2402-worktree-list.sh   | 22 ++++++++++++++++++++++
 t/t2403-worktree-move.sh   | 22 ++++++++++++++++++++++
 t/t2406-worktree-repair.sh | 26 ++++++++++++++++++++++++++
 6 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..e21b9aa5e7f4599af8b20165b50=
896c9a49ba7ea 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -435,6 +435,7 @@ sep_git_dir_worktree ()  {
 =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
 =09git init mainwt &&
 =09test_commit -C mainwt gumby &&
+=09git -C mainwt config worktree.useRelativePaths "$([ "$2" =3D "relative"=
 ] && echo true || echo false)" &&
 =09git -C mainwt worktree add --detach ../linkwt &&
 =09git -C "$1" init --separate-git-dir ../seprepo &&
 =09git -C mainwt rev-parse --git-common-dir >expect &&
@@ -442,12 +443,20 @@ sep_git_dir_worktree ()  {
 =09test_cmp expect actual
 }
=20
-test_expect_success 're-init to move gitdir with linked worktrees' '
-=09sep_git_dir_worktree mainwt
+test_expect_success 're-init to move gitdir with linked worktrees (absolut=
e)' '
+=09sep_git_dir_worktree mainwt absolute
 '
=20
-test_expect_success 're-init to move gitdir within linked worktree' '
-=09sep_git_dir_worktree linkwt
+test_expect_success 're-init to move gitdir within linked worktree (absolu=
te)' '
+=09sep_git_dir_worktree linkwt absolute
+'
+
+test_expect_success 're-init to move gitdir with linked worktrees (relativ=
e)' '
+=09sep_git_dir_worktree mainwt relative
+'
+
+test_expect_success 're-init to move gitdir within linked worktree (relati=
ve)' '
+=09sep_git_dir_worktree linkwt relative
 '
=20
 test_expect_success MINGW '.git hidden' '
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798c6d023909cec771e5b74e983af5ea..630c13230b3cc762ce8d943e22b=
e8891aa2b1871 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1207,4 +1207,45 @@ test_expect_success '"add" with initialized submodul=
e, with submodule.recurse se
 =09git -C project-clone -c submodule.recurse worktree add ../project-5
 '
=20
+test_expect_success 'can create worktrees with relative paths' '
+=09test_when_finished "git worktree remove relative" &&
+=09git config worktree.useRelativePaths false &&
+=09git worktree add --relative-paths ./relative &&
+=09cat relative/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09test_cmp expect actual &&
+=09cat .git/worktrees/relative/gitdir >actual &&
+=09echo "../../../relative/.git" >expect &&
+=09test_cmp expect actual
+
+'
+
+test_expect_success 'can create worktrees with absolute paths' '
+=09git config worktree.useRelativePaths true &&
+=09git worktree add ./relative &&
+=09cat relative/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/relative" >expect &&
+=09test_cmp expect actual &&
+=09git worktree add --no-relative-paths ./absolute &&
+=09cat absolute/.git >actual &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'move repo without breaking relative internal links' '
+=09test_when_finished rm -rf repo moved &&
+=09git init repo &&
+=09(
+=09=09cd repo &&
+=09=09git config worktree.useRelativePaths true &&
+=09=09test_commit initial &&
+=09=09git worktree add wt1 &&
+=09=09cd .. &&
+=09=09mv repo moved &&
+=09=09cd moved/wt1 &&
+=09=09git status >out 2>err &&
+=09=09test_must_be_empty err
+=09)
+'
+
 test_done
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 976d048e3efc74be9cd909ce76d552b3944d2e10..5eb52b9abbf29514dc082c260eb=
b7a5e8e63aae0 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -120,11 +120,12 @@ test_expect_success 'prune duplicate (main/linked)' '
 =09! test -d .git/worktrees/wt
 '
=20
-test_expect_success 'not prune proper worktrees when run inside linked wor=
ktree' '
+test_expect_success 'not prune proper worktrees inside linked worktree wit=
h relative paths' '
 =09test_when_finished rm -rf repo wt_ext &&
 =09git init repo &&
 =09(
 =09    cd repo &&
+=09    git config worktree.useRelativePaths true &&
 =09    echo content >file &&
 =09    git add file &&
 =09    git commit -m msg &&
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 33ea9cb21ba07c9563530b54da06753eaa993fe2..780daa6cd6351f8fa9434619cc2=
12aade8f01420 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -261,6 +261,7 @@ test_expect_success 'broken main worktree still at the =
top' '
 '
=20
 test_expect_success 'linked worktrees are sorted' '
+=09test_when_finished "rm -rf sorted" &&
 =09mkdir sorted &&
 =09git init sorted/main &&
 =09(
@@ -280,6 +281,27 @@ test_expect_success 'linked worktrees are sorted' '
 =09test_cmp expected sorted/main/actual
 '
=20
+test_expect_success 'linked worktrees with relative paths are shown with a=
bsolute paths' '
+=09test_when_finished "rm -rf sorted" &&
+=09mkdir sorted &&
+=09git init sorted/main &&
+=09(
+=09=09cd sorted/main &&
+=09=09test_tick &&
+=09=09test_commit new &&
+=09=09git worktree add --relative-paths ../first &&
+=09=09git worktree add ../second &&
+=09=09git worktree list --porcelain >out &&
+=09=09grep ^worktree out >actual
+=09) &&
+=09cat >expected <<-EOF &&
+=09worktree $(pwd)/sorted/main
+=09worktree $(pwd)/sorted/first
+=09worktree $(pwd)/sorted/second
+=09EOF
+=09test_cmp expected sorted/main/actual
+'
+
 test_expect_success 'worktree path when called in .git directory' '
 =09git worktree list >list1 &&
 =09git -C .git worktree list >list2 &&
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 901342ea09b51a8e832f1109fbb737df84283aa2..6ce9ed3f1e6b3f73d2a290e7702=
33eec30221fe5 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -247,4 +247,26 @@ test_expect_success 'not remove a repo with initialize=
d submodule' '
 =09)
 '
=20
+test_expect_success 'move worktree with absolute path to relative path' '
+=09git config worktree.useRelativePaths false &&
+=09git worktree add ./absolute &&
+=09git worktree move --relative-paths absolute relative &&
+=09cat relative/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual &&
+=09git config worktree.useRelativePaths true &&
+=09git worktree move relative relative2 &&
+=09cat relative2/.git >actual &&
+=09echo "gitdir: ../.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'move worktree with relative path to absolute path' '
+=09git config worktree.useRelativePaths true &&
+=09git worktree move --no-relative-paths relative2 absolute &&
+=09cat absolute/.git >actual &&
+=09echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
+=09test_cmp expect actual
+'
+
 test_done
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 7686e60f6ad186519b275f11a5e14064c905b207..84451e903b2ef3c645c0311faf0=
55c846588baf6 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -216,4 +216,30 @@ test_expect_success 'repair copied main and linked wor=
ktrees' '
 =09test_cmp dup/linked.expect dup/linked/.git
 '
=20
+test_expect_success 'repair absolute worktree to use relative paths' '
+=09test_when_finished "rm -rf main side sidemoved" &&
+=09test_create_repo main &&
+=09test_commit -C main init &&
+=09git -C main worktree add --detach ../side &&
+=09echo "../../../../sidemoved/.git" >expect-gitdir &&
+=09echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
+=09mv side sidemoved &&
+=09git -C main worktree repair --relative-paths ../sidemoved &&
+=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitfile sidemoved/.git
+'
+
+test_expect_success 'repair relative worktree to use absolute paths' '
+=09test_when_finished "rm -rf main side sidemoved" &&
+=09test_create_repo main &&
+=09test_commit -C main init &&
+=09git -C main worktree add --relative-paths --detach ../side &&
+=09echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
+=09echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
+=09mv side sidemoved &&
+=09git -C main worktree repair ../sidemoved &&
+=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+=09test_cmp expect-gitfile sidemoved/.git
+'
+
 test_done

--=20
2.47.0


