Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8928EB
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078207; cv=none; b=pecGuCPimgFEQiZru/Hfu3RyvjUg+nDhdIzpFDehnzws3vIDUGl9DF3G3roABRzbInhueffbHH7BOKCb7lVPkPmmfuMdKPkrlHN5PnlUTOWHAD6ZGYe/WTsY7l+QAVVAATVKuzWp3IEbopYk20PKEJpTzqmpNjArwXiQ5rjJHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078207; c=relaxed/simple;
	bh=Hd6P+grLI0lTWj66YAudcVHRTDUUZ2OcX1yzg+xAN5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4J+ASs5tL2yFH+6QhBzxMrZonYZQ9uhjJURasM2RpP8qX4/EIJfAw7qovmVWXWGyIzhf6nWMNiEzBsbW5mDdXhiMtA3kKHJ+bdd7szC7ybaL1dEVxExiVqssLPrX5ovCDKn0hO40zyi02De1ocaCfERxdq6gp4kwo8qS2n0QwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=lXoPODvV; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="lXoPODvV"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id sduPsOJu5TJlasduUsL2Ej; Mon, 23 Sep 2024 07:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1727078107;
	bh=Hd6P+grLI0lTWj66YAudcVHRTDUUZ2OcX1yzg+xAN5k=;
	h=From:To:Cc:Subject:Date;
	b=lXoPODvVKzFRNBRkw87UiibRRnc4kn38TvHAv/UwWabvmruSItatYtHg2+RX4JHDX
	 yPJ65KARCIidByMOKWwAJ9PVaTOoqmmOGMX7I5tddAsqUcYr+h4wVhmiceUHt15+Bk
	 nYFvo3PNagbjt1+zNIDXXw5T2Q0M1xhE40Gz28TiZ2kV53IYsV9ayEQwA6g6l9Rdik
	 fhN9O5FUvsYCv6jxXxPfhi0T9p83E78j5LKyfvuYc9ddBsLfHnfiDcNJmedE7lbDTE
	 ZnmCL3GXQ+wmGajDLxBmiDblSujwWlQFPXs26PPOnIt6zvWROweH3GQ4Jbs11CNsUa
	 MieHcsmNJf0wQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=MZRquY/f c=1 sm=1 tr=0 ts=66f11edb
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=so_Squwb14Lb8nFQa3oA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: repair copied repository and linked worktrees
Date: Mon, 23 Sep 2024 03:54:16 -0400
Message-ID: <20240923075416.54289-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAUkMuED0mxov3j+FRNPk1UKia2tN/l68hfSu1EUEyivyXhYl+n28kYzJp5rvVrfSAQa9sfat9fjl09ap+jYgMVddmDMl97EaKLIuhGSzMoT/+hb8+d7
 36qL4QG0VEitO2+MluXF2/2qDGHTA69tdEoRHPuk5DwmipNlm8OTytIZzcfX9Ed50M6uAZtKE0r1Oljh4URrKKjfxBYj0332Qf+2MLjGK0kT8Wp4X8M5DnRy
 aPnxWcMupa5opdraq5bgjUFsOUrm/Gz1IRD+gZe1oUYPaEJFkWwgt6GTMPniL0ws

From: Eric Sunshine <sunshine@sunshineco.com>

For each linked worktree, Git maintains two pointers: (1)
<repo>/worktrees/<id>/gitdir which points at the linked worktree, and
(2) <worktree>/.git which points back at <repo>/worktrees/<id>. Both
pointers are absolute pathnames.

Aside from manually manipulating those raw files, it is possible to
easily "break" one or both pointers by ignoring the "git worktree move"
command and instead manually moving a linked worktree, moving the
repository, or moving both. The "git worktree repair" command was
invented to handle this case by restoring these pointers to sane values.

For the "repair" command, the "git worktree" manual page states:

  Repair worktree administrative files, if possible, if they have
  become corrupted or outdated due to external factors.

The "if possible" clause was chosen deliberately to convey that the
existing implementation may not be able to fix every possible breakage,
and to imply that improvements may be made to handle other types of
breakage.

A recent problem report[*] illustrates a case in which "git worktree
repair" not only fails to fix breakage, but actually causes breakage.
Specifically, if a repository / main-worktree and linked worktrees are
*copied* as a unit (rather than *moved*), then "git worktree repair" run
in the copy leaves the copy untouched but botches the pointers in the
original repository and the original worktrees.

For instance, given this directory structure:

  orig/
    main/ (main-worktree)
    linked/ (linked worktree)

if "orig" is copied (not moved) to "dup", then immediately after the
manual copy operation:

  * orig/main/.git/worktrees/linked/gitdir points at orig/linked/.git
  * orig/linked/.git points at orig/main/.git/worktrees/linked
  * dup/main/.git/worktrees/linked/gitdir points at orig/linked/.git
  * dup/linked/.git points at orig/main/.git/worktrees/linked

So, dup/main thinks its linked worktree is orig/linked, and worktree
dup/linked thinks its repository / main-worktree is orig/main.

"git worktree repair" is reasonably simple-minded; it wants to trust
valid-looking pointers, hence doesn't try to second-guess them. In this
case, when validating dup/linked/.git, it finds a legitimate repository
pointer, orig/main/.git/worktrees/linked, thus trusts that is correct,
but does notice that gitdir in that directory doesn't point at
dup/linked/.git, so it (incorrectly) _fixes_
orig/main/.git/worktrees/linked/gitdir to point at dup/linked/.git.
Similarly, when validating dup/main/.git/worktrees/linked/gitdir, it
finds a legitimate worktree pointer, orig/linked/.git, but notices that
its .git file doesn't point back at dup/main, thus (incorrectly) _fixes_
orig/linked/.git to point at dup/main/.git/worktrees/linked. Hence, it
has modified and broken the linkage between orig/main and orig/linked
rather than fixing dup/main and dup/linked as expected.

Fix this problem by also checking if a plausible .git/worktrees/<id>
exists in the *current* repository -- not just in the repository pointed
at by the worktree's .git file -- and comparing whether they are the
same. If not, then it is likely because the repository / main-worktree
and linked worktrees were copied, so prefer the discovered plausible
pointer rather than the one from the existing .git file.

[*]: https://lore.kernel.org/git/E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au/

Reported-by: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  2 +-
 t/t2406-worktree-repair.sh     | 19 ++++++++++++++++
 worktree.c                     | 40 +++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 2a240f53ba..70437c815f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -157,7 +157,7 @@ will reestablish the connection. If multiple linked worktrees are moved,
 running `repair` from any worktree with each tree's new `<path>` as an
 argument, will reestablish the connection to all the specified paths.
 +
-If both the main worktree and linked worktrees have been moved manually,
+If both the main worktree and linked worktrees have been moved or copied manually,
 then running `repair` in the main worktree and specifying the new `<path>`
 of each linked worktree will reestablish all connections in both
 directions.
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index edbf502ec5..7686e60f6a 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -197,4 +197,23 @@ test_expect_success 'repair moved main and linked worktrees' '
 	test_cmp expect-gitfile sidemoved/.git
 '
 
+test_expect_success 'repair copied main and linked worktrees' '
+	test_when_finished "rm -rf orig dup" &&
+	mkdir -p orig &&
+	git -C orig init main &&
+	test_commit -C orig/main nothing &&
+	git -C orig/main worktree add ../linked &&
+	cp orig/main/.git/worktrees/linked/gitdir orig/main.expect &&
+	cp orig/linked/.git orig/linked.expect &&
+	cp -R orig dup &&
+	sed "s,orig/linked/\.git$,dup/linked/.git," orig/main.expect >dup/main.expect &&
+	sed "s,orig/main/\.git/worktrees/linked$,dup/main/.git/worktrees/linked," \
+		orig/linked.expect >dup/linked.expect &&
+	git -C dup/main worktree repair ../linked &&
+	test_cmp orig/main.expect orig/main/.git/worktrees/linked/gitdir &&
+	test_cmp orig/linked.expect orig/linked/.git &&
+	test_cmp dup/main.expect dup/main/.git/worktrees/linked/gitdir &&
+	test_cmp dup/linked.expect dup/linked/.git
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 30a947426e..7d1b60ff9f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -683,6 +683,7 @@ void repair_worktree_at_path(const char *path,
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
 	char *backlink = NULL;
+	char *inferred_backlink = NULL;
 	const char *repair = NULL;
 	int err;
 
@@ -698,12 +699,24 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
+	inferred_backlink = infer_backlink(realdotgit.buf);
 	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
 	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-		if (!(backlink = infer_backlink(realdotgit.buf))) {
+		if (inferred_backlink) {
+			/*
+			 * Worktree's .git file does not point at a repository
+			 * but we found a .git/worktrees/<id> in this
+			 * repository with the same <id> as recorded in the
+			 * worktree's .git file so make the worktree point at
+			 * the discovered .git/worktrees/<id>. (Note: backlink
+			 * is already NULL, so no need to free it first.)
+			 */
+			backlink = inferred_backlink;
+			inferred_backlink = NULL;
+		} else {
 			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
 			goto done;
 		}
@@ -712,6 +725,30 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
+	/*
+	 * If we got this far, either the worktree's .git file pointed at a
+	 * valid repository (i.e. read_gitfile_gently() returned success) or
+	 * the .git file did not point at a repository but we were able to
+	 * infer a suitable new value for the .git file by locating a
+	 * .git/worktrees/<id> in *this* repository corresponding to the <id>
+	 * recorded in the worktree's .git file.
+	 *
+	 * However, if, at this point, inferred_backlink is non-NULL (i.e. we
+	 * found a suitable .git/worktrees/<id> in *this* repository) *and* the
+	 * worktree's .git file points at a valid repository *and* those two
+	 * paths differ, then that indicates that the user probably *copied*
+	 * the main and linked worktrees to a new location as a unit rather
+	 * than *moving* them. Thus, the copied worktree's .git file actually
+	 * points at the .git/worktrees/<id> in the *original* repository, not
+	 * in the "copy" repository. In this case, point the "copy" worktree's
+	 * .git file at the "copy" repository.
+	 */
+	if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
+		free(backlink);
+		backlink = inferred_backlink;
+		inferred_backlink = NULL;
+	}
+
 	strbuf_addf(&gitdir, "%s/gitdir", backlink);
 	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
 		repair = _("gitdir unreadable");
@@ -727,6 +764,7 @@ void repair_worktree_at_path(const char *path,
 	}
 done:
 	free(backlink);
+	free(inferred_backlink);
 	strbuf_release(&olddotgit);
 	strbuf_release(&gitdir);
 	strbuf_release(&realdotgit);
-- 
2.46.1

