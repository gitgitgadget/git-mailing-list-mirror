Received: from mta206-ab1.mtasv.net (mta206-ab1.mtasv.net [50.31.205.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FB3EFFD7
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.31.205.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867440; cv=none; b=oK+kf5YRzmALV8BNb/tt17mas+s6iWrJVMLiYzj+fM8qlk7eUhtoqzkHNcfl+cw7ClcPA45INDc9Fjw32J543kJhZnBA1OC8fSdO2e9YAcBNGO4tKuYQXfu77YQjupZCRcWJ6PAXNUblxt4ab5ivApWMOyTb83Q/KAyaz1wRt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867440; c=relaxed/simple;
	bh=lhjlkOn5qBJ5RMeFZtZiHcqYWq1awgPwX+23byl5SjY=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpfrXI4aiNiWmMvgfL4a7ZwKtjOKz3Gbd+48Sccid8cOZkvqabvQeGYfODR2vsenXMc8PWVO0EqCV2jv60pDJhPuT/5+LZzveBnX/WIK5WE91Hqm7VyjJfQAeS1NaUC3E8zrflml0SvQ8IpuQ4XBKo75H25CAg6ZGBbiwrufKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=k/mu96mn; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=gAIpWU78; arc=none smtp.client-ip=50.31.205.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="k/mu96mn";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="gAIpWU78"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=6If8wsEC/v//S7s9Y3kBZg+jVKJp+lxmG4W5TziXbd4=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1785867243; x=1786472043;
	b=k/mu96mnCOmeh9UdNHQ6vUinQ//p5cxpw+zjpbLA1ovPheJf14wtS5JI27v2XfZp32qMAAg9w
	V8qVToTw57YveS38KRnKA4ny8FZtVdY5OLgpsrAZIUmy6rrwmU766ru8X7XQ6ryrQqyacyk83ZN
	x6YWb9M1MwqeR+ItrgCx15y9WbN+jJ578US8qxhzTcRgvxca1/wsXB212cwTa/V6NYLp9B552hM
	U40o1Z9WOsQUcsdPb9qW99DQNtRLiRjkCbpIj55ANUYsla1d7WdYjyUcVzAe9I8fiNrfUITzh8m
	ShEQ4YITLbRsfZgg7tsuOpfZDNi8Y57La27At9P//XQQ==;
Received: from ip-172-26-33-169.us-east-2.compute.internal (172.26.33.169)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.241.71) 
  with ESMTP id 46389639903011f1bf100242f0c6b017 for <git@vger.kernel.org>;
  Tue, 4 Aug 2026 18:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1785867243; x=1786040043;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=6If8wsEC/v//S7s9Y3kBZg+jVKJp+lxmG4W5TziXbd4=;
	b=gAIpWU78asOZzwzkzwd4RX94zubB7qG1NGEBuIG6tJXLaR77aom+Pmg5USiNsuO3u2/tnwcVMo3
	U/MaTkj9NIhHNtVbtIlF84NKGVRD7zpX2F/2EcpX24nbiXNciUsx4GB+afD64IpG3agmj2u7oWZ7u
	rglL1EHD89COZMXjub0=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Tue, 04 Aug 2026 18:14:03 +0000
Subject: [PATCH v2 3/4] worktree: run post-worktree-remove hook when pruning
Message-Id: <6d4b2080-d7d9-4a87-a295-9c001d8a0290@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine
	<sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804181358.532970-1-domen@cachix.org>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <20260804181358.532970-1-domen@cachix.org>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 6d4b2080-d7d9-4a87-a295-9c001d8a0290
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.GKNHnz1G98lKNxmiLdxyZA.EQj7M0UBNjWR4XR-uQz0dlRakvpeUre55WIwa3y4Y1Mxp5NV5oZTW1dOSST7ZF72kqFEA08xfXfUKALTx8Bt6pGB5BArgDuvEeI0GPKm0h6wAGFivsoSs1INxtEjVYzxfs-tqPGoWHu3WgfhNzTgDSO0NrxTJwPJHl3o5th3to8r9_gLeB8aADtvIUp-mT1S
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: mta206-ab1
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A working tree can also disappear via "git worktree prune", e.g.
after the user deleted the working tree directory manually. Tooling
that tears down per-worktree state wants to observe those deletions
the same way as an explicit "git worktree remove".

Run the post-worktree-remove hook once for each administrative entry
that "git worktree prune" removes, including duplicate entries pruned
during deduplication. The hook is not run with --dry-run, and a
failing hook is reflected in the exit status of the command.

should_prune_worktree() so far returned the path of the worktree's
.git file only for entries that are kept. Also return it when pruning
an entry whose gitdir file points to a location that no longer
exists, which is the common case of a manually deleted working tree,
so that the hook can be given the path. For entries whose path cannot
be determined at all (missing or corrupt gitdir file), the hook
receives an empty string instead. The one other caller of
should_prune_worktree() already frees the path unconditionally.

Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
---
 Documentation/githooks.adoc | 23 +++++-----
 builtin/worktree.c          | 48 ++++++++++++++------
 t/t2401-worktree-prune.sh   | 88 +++++++++++++++++++++++++++++++++++++
 worktree.c                  |  1 -
 worktree.h                  |  6 +--
 5 files changed, 139 insertions(+), 27 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 9573b8c1f5..fdf697b12f 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -237,16 +237,19 @@ post-worktree-remove
 ~~~~~~~~~~~~~~~~~~~~
=20
 This hook is invoked by linkgit:git-worktree[1] after a working tree
-has been deleted by `git worktree remove`. The hook is given two
-parameters: the absolute path of the removed working tree and its
-identifier (the name of its former administrative directory in
-`$GIT_DIR/worktrees/`).
-
-The working tree no longer exists when the hook runs.
-
-This hook cannot affect the outcome of `git worktree remove`, other
-than that the hook's exit status becomes the exit status of the
-command.
+has been deleted by `git worktree remove`, and once for each working
+tree pruned by `git worktree prune`. The hook is given two parameters:
+the absolute path of the removed working tree and its identifier (the
+name of its former administrative directory in `$GIT_DIR/worktrees/`).
+
+The working tree no longer exists when the hook runs. For working
+trees pruned by `git worktree prune`, the first parameter may be the
+empty string if the path could not be determined from the leftover
+administrative files.
+
+This hook cannot affect the outcome of `git worktree remove` or
+`git worktree prune`, other than that the hook's exit status becomes
+the exit status of the command.
=20
 This hook can be used to tear down per-worktree development
 environments or to unregister the working tree from external tools.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dc456fcac7..e0c37039ac 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -185,12 +185,27 @@ static int run_post_worktree_remove_hook(const char *=
path, const char *id)
 	return run_hooks_opt(the_repository, "post-worktree-remove", &hook_opt);
 }
=20
-static void prune_worktree(const char *id, const char *reason)
+static int prune_worktree(const char *id, const char *dotgit,
+			  const char *reason)
 {
+	struct strbuf path =3D STRBUF_INIT;
+	int ret;
+
 	if (show_only || verbose)
 		fprintf_ln(stderr, _("Removing %s/%s: %s"), "worktrees", id, reason);
-	if (!show_only)
-		delete_git_dir(id);
+	if (show_only)
+		return 0;
+
+	delete_git_dir(id);
+
+	/* path stays empty when the worktree path cannot be determined */
+	if (dotgit) {
+		strbuf_addstr(&path, dotgit);
+		strbuf_strip_suffix(&path, "/.git");
+	}
+	ret =3D run_post_worktree_remove_hook(path.buf, id);
+	strbuf_release(&path);
+	return ret;
 }
=20
 static int prune_cmp(const void *a, const void *b)
@@ -215,18 +230,22 @@ static int prune_cmp(const void *a, const void *b)
 	return strcmp(x->util, y->util);
 }
=20
-static void prune_dups(struct string_list *l)
+static int prune_dups(struct string_list *l)
 {
 	int i;
+	int ret =3D 0;
=20
 	QSORT(l->items, l->nr, prune_cmp);
 	for (i =3D 1; i < l->nr; i++) {
 		if (!fspathcmp(l->items[i].string, l->items[i - 1].string))
-			prune_worktree(l->items[i].util, "duplicate entry");
+			ret |=3D prune_worktree(l->items[i].util,
+					      l->items[i].string,
+					      "duplicate entry");
 	}
+	return ret;
 }
=20
-static void prune_worktrees(void)
+static int prune_worktrees(void)
 {
 	struct strbuf reason =3D STRBUF_INIT;
 	struct strbuf main_path =3D STRBUF_INIT;
@@ -234,19 +253,22 @@ static void prune_worktrees(void)
 	char *path;
 	DIR *dir;
 	struct dirent *d;
+	int ret =3D 0;
=20
 	path =3D repo_git_path(the_repository, "worktrees");
 	dir =3D opendir(path);
 	free(path);
 	if (!dir)
-		return;
+		return 0;
 	while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
 		char *path;
 		strbuf_reset(&reason);
-		if (should_prune_worktree(d->d_name, &reason, &path, expire))
-			prune_worktree(d->d_name, reason.buf);
-		else if (path)
+		if (should_prune_worktree(d->d_name, &reason, &path, expire)) {
+			ret |=3D prune_worktree(d->d_name, path, reason.buf);
+			free(path);
+		} else if (path) {
 			string_list_append_nodup(&kept, path)->util =3D xstrdup(d->d_name);
+		}
 	}
 	closedir(dir);
=20
@@ -254,12 +276,13 @@ static void prune_worktrees(void)
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
 	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
-	prune_dups(&kept);
+	ret |=3D prune_dups(&kept);
 	string_list_clear(&kept, 1);
=20
 	if (!show_only)
 		delete_worktrees_dir_if_empty();
 	strbuf_release(&reason);
+	return ret;
 }
=20
 static int prune(int ac, const char **av, const char *prefix,
@@ -278,8 +301,7 @@ static int prune(int ac, const char **av, const char *p=
refix,
 			   0);
 	if (ac)
 		usage_with_options(git_worktree_prune_usage, options);
-	prune_worktrees();
-	return 0;
+	return prune_worktrees();
 }
=20
 static char *junk_work_tree;
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index f8f28c76ee..74a80c1a8d 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -119,6 +119,94 @@ test_expect_success 'prune duplicate (main/linked)' '
 	test_path_is_missing .git/worktrees/wt
 '
=20
+test_expect_success 'prune invokes post-worktree-remove hook' '
+	test_hook post-worktree-remove <<-\EOF &&
+	echo $* >hook.actual
+	EOF
+	git worktree add --detach flushed &&
+	rm -rf flushed &&
+	git worktree prune &&
+	echo $(pwd)/flushed flushed >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'prune invokes post-worktree-remove hook once per work=
tree' '
+	test_hook post-worktree-remove <<-\EOF &&
+	echo $* >>hook.actual
+	EOF
+	git worktree add --detach first &&
+	git worktree add --detach second &&
+	rm -rf first second hook.actual &&
+	git worktree prune &&
+	{
+		echo $(pwd)/first first &&
+		echo $(pwd)/second second
+	} >hook.expect &&
+	sort hook.actual >hook.sorted &&
+	test_cmp hook.expect hook.sorted
+'
+
+test_expect_success 'prune --dry-run does not invoke post-worktree-remove =
hook' '
+	git worktree add --detach dry &&
+	rm -rf dry &&
+	test_when_finished "git worktree prune" &&
+	test_hook post-worktree-remove <<-\EOF &&
+	>hook.ran
+	EOF
+	git worktree prune --dry-run &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'pruned entry with unknown path gives empty hook argum=
ent' '
+	test_hook post-worktree-remove <<-\EOF &&
+	echo "[$1][$2]" >hook.actual
+	EOF
+	mkdir -p .git/worktrees/broken &&
+	: >.git/worktrees/broken/gitdir &&
+	git worktree prune &&
+	echo "[][broken]" >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'failing post-worktree-remove hook fails prune' '
+	test_hook post-worktree-remove <<-\EOF &&
+	exit 1
+	EOF
+	git worktree add --detach doomed &&
+	rm -rf doomed &&
+	test_must_fail git worktree prune &&
+	test_path_is_missing .git/worktrees/doomed
+'
+
+test_expect_success 'prune duplicate invokes post-worktree-remove hook' '
+	test_when_finished rm -fr .git/worktrees w1 w2 &&
+	test_hook post-worktree-remove <<-\EOF &&
+	echo $* >>hook.actual
+	EOF
+	rm -f hook.actual &&
+	git worktree add --detach w1 &&
+	git worktree add --detach w2 &&
+	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
+	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
+	git worktree prune &&
+	echo $(pwd)/w1 w2 >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'post-worktree-remove hook gets absolute path with rel=
ative worktrees' '
+	test_when_finished "rm -rf relhook" &&
+	git init relhook &&
+	test_commit -C relhook base &&
+	test_hook -C relhook post-worktree-remove <<-\EOF &&
+	echo $* >hook.actual
+	EOF
+	git -C relhook worktree add --relative-paths --detach wt &&
+	rm -rf relhook/wt &&
+	git -C relhook worktree prune &&
+	echo $(pwd)/relhook/wt wt >hook.expect &&
+	test_cmp hook.expect relhook/hook.actual
+'
+
 test_expect_success 'not prune proper worktrees inside linked worktree wit=
h relative paths' '
 	test_when_finished rm -rf repo wt_ext &&
 	git init repo &&
diff --git a/worktree.c b/worktree.c
index 30125827fd..6a9d943874 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1004,7 +1004,6 @@ int should_prune_worktree(const char *id, struct strb=
uf *reason, char **wtpath,
 		if (stat(file.buf, &st) || st.st_mtime <=3D expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"))=
;
 			rc =3D 1;
-			goto done;
 		}
 	}
 	*wtpath =3D strbuf_detach(&dotgit, NULL);
diff --git a/worktree.h b/worktree.h
index 1075409f9a..dde8fc2be4 100644
--- a/worktree.h
+++ b/worktree.h
@@ -105,9 +105,9 @@ const char *worktree_prune_reason(struct worktree *wt, =
timestamp_t expire);
=20
 /*
  * Return true if worktree entry should be pruned, along with the reason f=
or
- * pruning. Otherwise, return false and the worktree's path in `wtpath`, o=
r
- * NULL if it cannot be determined. Caller is responsible for freeing
- * returned path.
+ * pruning. Otherwise, return false. In both cases the path of the
+ * worktree's `.git` file is returned in `wtpath`, or NULL if it cannot
+ * be determined. Caller is responsible for freeing returned path.
  *
  * `expire` defines a grace period to prune the worktree when its path
  * does not exist.
--=20
2.54.0
