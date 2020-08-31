Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EBAC433E7
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF57F208A9
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQA+WUci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgHaG7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgHaG7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA6C061575
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:05 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so157988iln.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeleVG5QWBADD71UFNx3R9XYWNYyjagl2iGZ6X64uOM=;
        b=tQA+WUcijG7h2tO+f/RvMEFbTUjp7/UvQcSZGDxCXW73xi1kDFzzkcUaG6/hSdeesr
         CH8zgkfGsAIPfkGqAJJ99hN8hGyOqvoMrOb8lTE0G2lFBlh8wkjO6jaTdLXtFZ79YG9u
         r42H714amvMAZ1WbZF2MnK1ERV0JfMAd0qIIrp9DQyFX1dD3tMw9jJVL1uFaaIk/+tg/
         noyq0eJOSB52RuKyxjyXJHaA3VnCdAIpjokEodEH6lw5oy/Eb4r17ADNy5cUnXOTULNE
         ieUheBeaFNoNoKI1yj0n/uZ7PHEyDRFZgYRD9EHllBbfFDeDbk1+79r4wlA8mq6jHu3G
         raSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JeleVG5QWBADD71UFNx3R9XYWNYyjagl2iGZ6X64uOM=;
        b=LY5gxszCkHHQp1tk+4BtygkwbO25rKtoLaDlQFatTG/eBrcEeBrKsxyQLMkfAqa0mb
         NidTchxr4u1wTsMCKXXeA0iiJXcvKU2ILCx6iE3xhFNG4WHeeagutKkZ0aKIzX0Qhc/D
         VW6kT/esgiq0PUkLUzEr1VI655pZs0hokYZNtCk7Ru4MHj5Ry5rikeQw8Fu1fN8vCG3c
         F6VOGQ2DSDsrD1cvbaHDB6EFk9Ki+Tmq4jYa23glp2D/k4fC1IAaLJ0b7zodtmTR8gpm
         Qu4f0CGUFzJYLTF8cl3NMUGwaJHgMJohjE0IgQrzjc2Go1d32/eAqUUMM+WLnNQoimpD
         jbCA==
X-Gm-Message-State: AOAM532M8S9hLFY6lagP3XDptT3UsZmE8mGV3nxeC+LC8fnhkE5vMXFP
        annH5/LewiX/yEP57Sid3HzupGBMaY4=
X-Google-Smtp-Source: ABdhPJwkPbDuGGI+R9glNcf3gnvivhmzJmJtanACfZfyCNXe5hmvnqaGuYDub0AOGpW1ge51ok0+Sg==
X-Received: by 2002:a05:6e02:f4e:: with SMTP id y14mr220242ilj.255.1598857141798;
        Sun, 30 Aug 2020 23:59:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id x1sm1878615ilo.50.2020.08.30.23.59.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:59:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] add "git worktree repair" command
Date:   Mon, 31 Aug 2020 02:57:55 -0400
Message-Id: <20200831065800.62502-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.531.g41c3d8a546
In-Reply-To: <20200827082129.56149-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which adds a "git worktree repair" command
and which fixes bugs with "git init --separate-git-dir" related to
worktrees.

Changes since v1:

* employ proper terminology s/gitlink/gitfile/g (junio[2])
* tighten documentation slightly (junio[2])
* rename callback function and typedef s/cb/fn/g (junio[2])
* give concrete callback function more meaningful name (junio[2])
* employ explicit name for callback data (junio[2])
* explicitly check that worktree path is directory, not file, and bail
  with meaningful error message; add associated test (junio[2])
* fix empty-function style violation (junio[2])
* refine worktree repair callback typedef (sunshine)
* pacify GCC -Werror=main (dscho[3])
* pacify Sparse s/0/NULL/ (ramsay[4])

[1]: https://lore.kernel.org/git/20200827082129.56149-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/xmqqlfi0qaru.fsf@gitster.c.googlers.com/
[3]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2008280413450.56@tvgsbejvaqbjf.bet/
[4]: https://lore.kernel.org/git/8d4b4011-b8a2-c0e0-a3f2-28c7bbec040b@ramsayjones.plus.com/

Eric Sunshine (5):
  worktree: add skeleton "repair" command
  worktree: teach "repair" to fix worktree back-links to main worktree
  worktree: teach "repair" to fix outgoing links to worktrees
  init: teach --separate-git-dir to repair linked worktrees
  init: make --separate-git-dir work from within linked worktree

 Documentation/git-worktree.txt |  26 ++++-
 builtin/init-db.c              |  26 +++++
 builtin/worktree.c             |  30 ++++++
 t/t0001-init.sh                |  28 ++++++
 t/t2406-worktree-repair.sh     | 179 +++++++++++++++++++++++++++++++++
 worktree.c                     | 135 +++++++++++++++++++++++++
 worktree.h                     |  23 +++++
 7 files changed, 445 insertions(+), 2 deletions(-)
 create mode 100755 t/t2406-worktree-repair.sh

Interdiff against v1:
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a43a0af0af..f70cda4b36 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -121,8 +121,8 @@ become corrupted or outdated due to external factors.
 +
 For instance, if the main working tree (or bare repository) is moved,
 linked working trees will be unable to locate it. Running `repair` in
-the recently-moved main working tree will reestablish the connection
-from linked working trees back to the main working tree.
+the main working tree will reestablish the connection from linked
+working trees back to the main working tree.
 +
 Similarly, if a linked working tree is moved without using `git worktree
 move`, the main working tree (or bare repository) will be unable to
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6a94d20a2e..cd3e760541 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -661,7 +661,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			if (chdir(mainwt.buf) < 0)
 				die_errno(_("cannot chdir to %s"), mainwt.buf);
 			strbuf_release(&mainwt);
-			git_dir = strbuf_detach(&sb, 0);
+			git_dir = strbuf_detach(&sb, NULL);
 		}
 		strbuf_release(&sb);
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 19bbc246ad..8165343145 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1030,13 +1030,14 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
-static void repair_cb(int iserr, const char *path, const char *msg, void *cb_data)
+static void report_repair(int iserr, const char *path, const char *msg, void *cb_data)
 {
-	if (!iserr)
+	if (!iserr) {
 		printf_ln(_("repair: %s: %s"), msg, path);
-	else {
+	} else {
+		int *exit_status = (int *)cb_data;
 		fprintf_ln(stderr, _("error: %s: %s"), msg, path);
-		*(int *)cb_data = 1;
+		*exit_status = 1;
 	}
 }
 
@@ -1050,10 +1051,10 @@ static int repair(int ac, const char **av, const char *prefix)
 	int rc = 0;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	repair_worktrees(repair_cb, &rc);
+	repair_worktrees(report_repair, &rc);
 	p = ac > 0 ? av : self;
 	for (; *p; p++)
-		repair_worktree_at_path(*p, repair_cb, &rc);
+		repair_worktree_at_path(*p, report_repair, &rc);
 	return rc;
 }
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 87bd8fc526..1fe468bfe8 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -17,6 +17,16 @@ test_expect_success 'skip missing worktree' '
 	test_must_be_empty err
 '
 
+test_expect_success 'worktree path not directory' '
+	test_when_finished "git worktree prune" &&
+	git worktree add --detach notdir &&
+	rm -rf notdir &&
+	>notdir &&
+	test_must_fail git worktree repair >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep "not a directory" err
+'
+
 test_expect_success "don't clobber .git repo" '
 	test_when_finished "rm -rf repo && git worktree prune" &&
 	git worktree add --detach repo &&
@@ -27,7 +37,7 @@ test_expect_success "don't clobber .git repo" '
 	test_i18ngrep ".git is not a file" err
 '
 
-test_corrupt_gitlink () {
+test_corrupt_gitfile () {
 	butcher=$1 &&
 	problem=$2 &&
 	repairdir=${3:-.} &&
@@ -43,30 +53,30 @@ test_corrupt_gitlink () {
 }
 
 test_expect_success 'repair missing .git file' '
-	test_corrupt_gitlink "rm -f corrupt/.git" ".git link broken"
+	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken"
 '
 
 test_expect_success 'repair bogus .git file' '
-	test_corrupt_gitlink "echo \"gitdir: /nowhere\" >corrupt/.git" \
-		".git link broken"
+	test_corrupt_gitfile "echo \"gitdir: /nowhere\" >corrupt/.git" \
+		".git file broken"
 '
 
 test_expect_success 'repair incorrect .git file' '
 	test_when_finished "rm -rf other && git worktree prune" &&
 	test_create_repo other &&
 	other=$(git -C other rev-parse --absolute-git-dir) &&
-	test_corrupt_gitlink "echo \"gitdir: $other\" >corrupt/.git" \
-		".git link incorrect"
+	test_corrupt_gitfile "echo \"gitdir: $other\" >corrupt/.git" \
+		".git file incorrect"
 '
 
 test_expect_success 'repair .git file from main/.git' '
-	test_corrupt_gitlink "rm -f corrupt/.git" ".git link broken" .git
+	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken" .git
 '
 
 test_expect_success 'repair .git file from linked worktree' '
 	test_when_finished "rm -rf other && git worktree prune" &&
 	git worktree add --detach other &&
-	test_corrupt_gitlink "rm -f corrupt/.git" ".git link broken" other
+	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken" other
 '
 
 test_expect_success 'repair .git file from bare.git' '
@@ -94,14 +104,14 @@ test_expect_success 'repo not found; .git not file' '
 	test_i18ngrep ".git is not a file" err
 '
 
-test_expect_success 'repo not found; .git link broken' '
+test_expect_success 'repo not found; .git file broken' '
 	test_when_finished "rm -rf orig moved && git worktree prune" &&
 	git worktree add --detach orig &&
 	echo /invalid >orig/.git &&
 	mv orig moved &&
 	test_must_fail git worktree repair moved >out 2>err &&
 	test_must_be_empty out &&
-	test_i18ngrep ".git link broken" err
+	test_i18ngrep ".git file broken" err
 '
 
 test_expect_success 'repair broken gitdir' '
diff --git a/worktree.c b/worktree.c
index 6ade4f0d8b..46a5fb8447 100644
--- a/worktree.c
+++ b/worktree.c
@@ -573,11 +573,11 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 }
 
 /*
- * Repair worktree's /path/to/worktree/.git link if missing, corrupt, or not
+ * Repair worktree's /path/to/worktree/.git file if missing, corrupt, or not
  * pointing at <repo>/worktrees/<id>.
  */
-static void repair_dotgit(struct worktree *wt,
-			  worktree_repair_cb *cb, void *cb_data)
+static void repair_gitfile(struct worktree *wt,
+			   worktree_repair_fn fn, void *cb_data)
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf repo = STRBUF_INIT;
@@ -589,19 +589,24 @@ static void repair_dotgit(struct worktree *wt,
 	if (!file_exists(wt->path))
 		return;
 
+	if (!is_directory(wt->path)) {
+		fn(1, wt->path, _("not a directory"), cb_data);
+		return;
+	}
+
 	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
 	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
 
 	if (err == READ_GITFILE_ERR_NOT_A_FILE)
-		cb(1, wt->path, _(".git is not a file"), cb_data);
+		fn(1, wt->path, _(".git is not a file"), cb_data);
 	else if (err)
-		repair = _(".git link broken");
+		repair = _(".git file broken");
 	else if (fspathcmp(backlink, repo.buf))
-		repair = _(".git link incorrect");
+		repair = _(".git file incorrect");
 
 	if (repair) {
-		cb(0, wt->path, repair, cb_data);
+		fn(0, wt->path, repair, cb_data);
 		write_file(dotgit.buf, "gitdir: %s", repo.buf);
 	}
 
@@ -610,34 +615,37 @@ static void repair_dotgit(struct worktree *wt,
 	strbuf_release(&dotgit);
 }
 
-static void repair_noop_cb(int iserr, const char *path, const char *msg,
-			   void *cb_data) {}
+static void repair_noop(int iserr, const char *path, const char *msg,
+			void *cb_data)
+{
+	/* nothing */
+}
 
-void repair_worktrees(worktree_repair_cb *cb, void *cb_data)
+void repair_worktrees(worktree_repair_fn fn, void *cb_data)
 {
 	struct worktree **worktrees = get_worktrees();
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
-	if (!cb)
-		cb = repair_noop_cb;
+	if (!fn)
+		fn = repair_noop;
 	for (; *wt; wt++)
-		repair_dotgit(*wt, cb, cb_data);
+		repair_gitfile(*wt, fn, cb_data);
 	free_worktrees(worktrees);
 }
 
 static int is_main_worktree_path(const char *path)
 {
 	struct strbuf target = STRBUF_INIT;
-	struct strbuf main = STRBUF_INIT;
+	struct strbuf maindir = STRBUF_INIT;
 	int cmp;
 
 	strbuf_add_real_path(&target, path);
 	strbuf_strip_suffix(&target, "/.git");
-	strbuf_add_real_path(&main, get_git_common_dir());
-	strbuf_strip_suffix(&main, "/.git");
-	cmp = fspathcmp(main.buf, target.buf);
+	strbuf_add_real_path(&maindir, get_git_common_dir());
+	strbuf_strip_suffix(&maindir, "/.git");
+	cmp = fspathcmp(maindir.buf, target.buf);
 
-	strbuf_release(&main);
+	strbuf_release(&maindir);
 	strbuf_release(&target);
 	return !cmp;
 }
@@ -647,7 +655,7 @@ static int is_main_worktree_path(const char *path)
  * the worktree's path.
  */
 void repair_worktree_at_path(const char *path,
-			     worktree_repair_cb *cb, void *cb_data)
+			     worktree_repair_fn fn, void *cb_data)
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf realdotgit = STRBUF_INIT;
@@ -657,24 +665,24 @@ void repair_worktree_at_path(const char *path,
 	const char *repair = NULL;
 	int err;
 
-	if (!cb)
-		cb = repair_noop_cb;
+	if (!fn)
+		fn = repair_noop;
 
 	if (is_main_worktree_path(path))
 		goto done;
 
 	strbuf_addf(&dotgit, "%s/.git", path);
 	if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
-		cb(1, path, _("not a valid path"), cb_data);
+		fn(1, path, _("not a valid path"), cb_data);
 		goto done;
 	}
 
 	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
 	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
-		cb(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
+		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err) {
-		cb(1, realdotgit.buf, _("unable to locate repository; .git link broken"), cb_data);
+		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
 		goto done;
 	}
 
@@ -688,7 +696,7 @@ void repair_worktree_at_path(const char *path,
 	}
 
 	if (repair) {
-		cb(0, gitdir.buf, repair, cb_data);
+		fn(0, gitdir.buf, repair, cb_data);
 		write_file(gitdir.buf, "%s", realdotgit.buf);
 	}
 done:
diff --git a/worktree.h b/worktree.h
index 9cb7f05741..ff7b62e434 100644
--- a/worktree.h
+++ b/worktree.h
@@ -89,27 +89,28 @@ int validate_worktree(const struct worktree *wt,
 void update_worktree_location(struct worktree *wt,
 			      const char *path_);
 
-typedef void worktree_repair_cb(int iserr, const char *path, const char *msg,
-				void *cb_data);
+typedef void (* worktree_repair_fn)(int iserr, const char *path,
+				    const char *msg, void *cb_data);
 
 /*
  * Visit each registered linked worktree and repair corruptions. For each
- * repair made or error encountered while attempting a repair, the callback, if
- * non-NULL, is called with the path of the worktree and a description of the
- * repair or error, along with the callback user-data.
+ * repair made or error encountered while attempting a repair, the callback
+ * function, if non-NULL, is called with the path of the worktree and a
+ * description of the repair or error, along with the callback user-data.
  */
-void repair_worktrees(worktree_repair_cb *, void *cb_data);
+void repair_worktrees(worktree_repair_fn, void *cb_data);
 
 /*
  * Repair administrative files corresponding to the worktree at the given path.
- * The worktree's .git link pointing at the repository must be intact for the
+ * The worktree's .git file pointing at the repository must be intact for the
  * repair to succeed. Useful for re-associating an orphaned worktree with the
  * repository if the worktree has been moved manually (without using "git
  * worktree move"). For each repair made or error encountered while attempting
- * a repair, the callback, if non-NULL, is called with the path of the worktree
- * and a description of the repair or error, along with the callback user-data.
+ * a repair, the callback function, if non-NULL, is called with the path of the
+ * worktree and a description of the repair or error, along with the callback
+ * user-data.
  */
-void repair_worktree_at_path(const char *, worktree_repair_cb *, void *cb_data);
+void repair_worktree_at_path(const char *, worktree_repair_fn, void *cb_data);
 
 /*
  * Free up the memory for worktree(s)
-- 
2.28.0.531.g41c3d8a546

