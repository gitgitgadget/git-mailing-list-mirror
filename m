Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AC9C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3435E20738
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN6O7SUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgH0IXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgH0IXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1EC06121A
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s1so4920882iot.10
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/03OoE4WkbIsJYkdY0Cc19qSUlFqHgdfByfEkRUqR84=;
        b=AN6O7SUsNJCOx9cEkU2fNmUP5n1pLPxHEgA3ZicRXsoYQO7IOBwZ6vspoilDvYofrJ
         tTrTeHNVOWVAaEWKVZ7IE/xSQVF19RFtaOpRhrpgfZdsWptO/HolstrCZD+2hPSRqBus
         QTKhWnfuncvDYcVLt/eptIaxhpUxw58WF8BRXpAEsJh/FD9dp9MtEWpX7ycb27X23ku6
         X0Cqb+pYB/+E9IRPTLVxc4HmrCjr0pFVJ9RpxR0BQ+Z8WEPNcWmmTd1VTDf2V52VQ8K5
         Mqn1+3i6F6Fv8QT8ul+DnV6vUTQmTIMjHdPcyvQVGbuTwu1PtM9ZeMaCZpSK4eRzAh2C
         ZWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/03OoE4WkbIsJYkdY0Cc19qSUlFqHgdfByfEkRUqR84=;
        b=KVRb4Liy2c4dY/sAnoWzG7e7ouKESAX14WGv7ukTnRC2x4oHSBqgGzJRw6bvHvFJnE
         nPDHJmLk67Y5ROesDPZ2UL3JjnP3qXBsUkp1urxoi4Z3pV3lO2PgV845R3pJ2N+4ivhl
         QLhGWmWPC6C9ZacH8G0Qz4jIh8f0R+sXd12U6LoCDLxR96ZfZOLxCSgbUZRqBNEeAP4x
         z58E/I6ViYVNZaGCbjuyKP3AG8CRDKG6lJITi+gPgOE04GAUZrb/UVFnOFxXBtdU7LnV
         oBdnf8A+xlQsS4uBv8n+7M+Cnzy0JG4oD4wJhDTFFIR3zUXzbJ2ktfNosxBYsx3FD0tG
         9YKA==
X-Gm-Message-State: AOAM531zEC3XMZD0R7azr/7S6bRw3qrfMW56l31+GPHZj8+reSngdmGY
        mQgfx/ibyU1SNVkXTSiWD3OsZL1kfzI=
X-Google-Smtp-Source: ABdhPJxZytyJVgcbqbEo4bXocBQVhvjP1gKXX27yTzASg4mIQ2cvSr2KQsJIFwBRO4BKxYueogPuDg==
X-Received: by 2002:a02:3445:: with SMTP id z5mr18101180jaz.134.1598516587111;
        Thu, 27 Aug 2020 01:23:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n15sm816553ioc.15.2020.08.27.01.23.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:23:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/5] worktree: teach "repair" to fix outgoing links to worktrees
Date:   Thu, 27 Aug 2020 04:21:27 -0400
Message-Id: <20200827082129.56149-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.461.g40977abb40
In-Reply-To: <20200827082129.56149-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The .git/worktrees/<id>/gitdir file points at the location of a linked
worktree's .git file. Its content must be of the form
/path/to/worktree/.git (from which the location of the worktree itself
can be derived by stripping the "/.git" suffix). If the gitdir file is
deleted or becomes corrupted or outdated, then Git will be unable to
find the linked worktree. An easy way for the gitdir file to become
outdated is for the user to move the worktree manually (without using
"git worktree move"). Although it is possible to manually update the
gitdir file to reflect the new linked worktree location, doing so
requires a level of knowledge about worktree internals beyond what a
user should be expected to know offhand.

Therefore, teach "git worktree repair" how to repair broken or outdated
.git/worktrees/<id>/gitdir files automatically. (For this to work, the
command must either be invoked from within the worktree whose gitdir
file requires repair, or from within the main or any linked worktree by
providing the path of the broken worktree as an argument to "git
worktree repair".)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 14 ++++--
 builtin/worktree.c             |  7 ++-
 t/t2406-worktree-repair.sh     | 86 ++++++++++++++++++++++++++++++++++
 worktree.c                     | 74 +++++++++++++++++++++++++++++
 worktree.h                     | 11 +++++
 5 files changed, 187 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index acb0ea1c2e..a43a0af0af 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree remove' [-f] <worktree>
-'git worktree repair'
+'git worktree repair' [<path>...]
 'git worktree unlock' <worktree>
 
 DESCRIPTION
@@ -114,7 +114,7 @@ and no modification in tracked files) can be removed. Unclean working
 trees or ones with submodules can be removed with `--force`. The main
 working tree cannot be removed.
 
-repair::
+repair [<path>...]::
 
 Repair working tree administrative files, if possible, if they have
 become corrupted or outdated due to external factors.
@@ -123,6 +123,13 @@ For instance, if the main working tree (or bare repository) is moved,
 linked working trees will be unable to locate it. Running `repair` in
 the recently-moved main working tree will reestablish the connection
 from linked working trees back to the main working tree.
++
+Similarly, if a linked working tree is moved without using `git worktree
+move`, the main working tree (or bare repository) will be unable to
+locate it. Running `repair` within the recently-moved working tree will
+reestablish the connection. If multiple linked working trees are moved,
+running `repair` from any working tree with each tree's new `<path>` as
+an argument, will reestablish the connection to all the specified paths.
 
 unlock::
 
@@ -317,7 +324,8 @@ in the entry's directory. For example, if a linked working tree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
 `/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/test-next`
-instead.
+instead. Better yet, run `git worktree repair` to reestablish the connection
+automatically.
 
 To prevent a `$GIT_DIR/worktrees` entry from being pruned (which
 can be useful in some situations, such as when the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 62e33eb7f5..19bbc246ad 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1042,15 +1042,18 @@ static void repair_cb(int iserr, const char *path, const char *msg, void *cb_dat
 
 static int repair(int ac, const char **av, const char *prefix)
 {
+	const char **p;
+	const char *self[] = { ".", NULL };
 	struct option options[] = {
 		OPT_END()
 	};
 	int rc = 0;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (ac)
-		usage_with_options(worktree_usage, options);
 	repair_worktrees(repair_cb, &rc);
+	p = ac > 0 ? av : self;
+	for (; *p; p++)
+		repair_worktree_at_path(*p, repair_cb, &rc);
 	return rc;
 }
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 9379a63130..87bd8fc526 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -80,4 +80,90 @@ test_expect_success 'repair .git file from bare.git' '
 	test_cmp expect actual
 '
 
+test_expect_success 'invalid worktree path' '
+	test_must_fail git worktree repair /notvalid >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep "not a valid path" err
+'
+
+test_expect_success 'repo not found; .git not file' '
+	test_when_finished "rm -rf not-a-worktree" &&
+	test_create_repo not-a-worktree &&
+	test_must_fail git worktree repair not-a-worktree >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep ".git is not a file" err
+'
+
+test_expect_success 'repo not found; .git link broken' '
+	test_when_finished "rm -rf orig moved && git worktree prune" &&
+	git worktree add --detach orig &&
+	echo /invalid >orig/.git &&
+	mv orig moved &&
+	test_must_fail git worktree repair moved >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep ".git link broken" err
+'
+
+test_expect_success 'repair broken gitdir' '
+	test_when_finished "rm -rf orig moved && git worktree prune" &&
+	git worktree add --detach orig &&
+	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+	rm .git/worktrees/orig/gitdir &&
+	mv orig moved &&
+	git worktree repair moved >out 2>err &&
+	test_cmp expect .git/worktrees/orig/gitdir &&
+	test_i18ngrep "gitdir unreadable" out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'repair incorrect gitdir' '
+	test_when_finished "rm -rf orig moved && git worktree prune" &&
+	git worktree add --detach orig &&
+	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+	mv orig moved &&
+	git worktree repair moved >out 2>err &&
+	test_cmp expect .git/worktrees/orig/gitdir &&
+	test_i18ngrep "gitdir incorrect" out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'repair gitdir (implicit) from linked worktree' '
+	test_when_finished "rm -rf orig moved && git worktree prune" &&
+	git worktree add --detach orig &&
+	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+	mv orig moved &&
+	git -C moved worktree repair >out 2>err &&
+	test_cmp expect .git/worktrees/orig/gitdir &&
+	test_i18ngrep "gitdir incorrect" out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'unable to repair gitdir (implicit) from main worktree' '
+	test_when_finished "rm -rf orig moved && git worktree prune" &&
+	git worktree add --detach orig &&
+	cat .git/worktrees/orig/gitdir >expect &&
+	mv orig moved &&
+	git worktree repair >out 2>err &&
+	test_cmp expect .git/worktrees/orig/gitdir &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'repair multiple gitdir files' '
+	test_when_finished "rm -rf orig1 orig2 moved1 moved2 &&
+		git worktree prune" &&
+	git worktree add --detach orig1 &&
+	git worktree add --detach orig2 &&
+	sed s,orig1/\.git$,moved1/.git, .git/worktrees/orig1/gitdir >expect1 &&
+	sed s,orig2/\.git$,moved2/.git, .git/worktrees/orig2/gitdir >expect2 &&
+	mv orig1 moved1 &&
+	mv orig2 moved2 &&
+	git worktree repair moved1 moved2 >out 2>err &&
+	test_cmp expect1 .git/worktrees/orig1/gitdir &&
+	test_cmp expect2 .git/worktrees/orig2/gitdir &&
+	test_i18ngrep "gitdir incorrect:.*orig1/gitdir$" out &&
+	test_i18ngrep "gitdir incorrect:.*orig2/gitdir$" out &&
+	test_must_be_empty err
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 029ce91fdf..6ade4f0d8b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -624,3 +624,77 @@ void repair_worktrees(worktree_repair_cb *cb, void *cb_data)
 		repair_dotgit(*wt, cb, cb_data);
 	free_worktrees(worktrees);
 }
+
+static int is_main_worktree_path(const char *path)
+{
+	struct strbuf target = STRBUF_INIT;
+	struct strbuf main = STRBUF_INIT;
+	int cmp;
+
+	strbuf_add_real_path(&target, path);
+	strbuf_strip_suffix(&target, "/.git");
+	strbuf_add_real_path(&main, get_git_common_dir());
+	strbuf_strip_suffix(&main, "/.git");
+	cmp = fspathcmp(main.buf, target.buf);
+
+	strbuf_release(&main);
+	strbuf_release(&target);
+	return !cmp;
+}
+
+/*
+ * Repair <repo>/worktrees/<id>/gitdir if missing, corrupt, or not pointing at
+ * the worktree's path.
+ */
+void repair_worktree_at_path(const char *path,
+			     worktree_repair_cb *cb, void *cb_data)
+{
+	struct strbuf dotgit = STRBUF_INIT;
+	struct strbuf realdotgit = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf olddotgit = STRBUF_INIT;
+	char *backlink = NULL;
+	const char *repair = NULL;
+	int err;
+
+	if (!cb)
+		cb = repair_noop_cb;
+
+	if (is_main_worktree_path(path))
+		goto done;
+
+	strbuf_addf(&dotgit, "%s/.git", path);
+	if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
+		cb(1, path, _("not a valid path"), cb_data);
+		goto done;
+	}
+
+	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
+	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
+		cb(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
+		goto done;
+	} else if (err) {
+		cb(1, realdotgit.buf, _("unable to locate repository; .git link broken"), cb_data);
+		goto done;
+	}
+
+	strbuf_addf(&gitdir, "%s/gitdir", backlink);
+	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
+		repair = _("gitdir unreadable");
+	else {
+		strbuf_rtrim(&olddotgit);
+		if (fspathcmp(olddotgit.buf, realdotgit.buf))
+			repair = _("gitdir incorrect");
+	}
+
+	if (repair) {
+		cb(0, gitdir.buf, repair, cb_data);
+		write_file(gitdir.buf, "%s", realdotgit.buf);
+	}
+done:
+	free(backlink);
+	strbuf_release(&olddotgit);
+	strbuf_release(&gitdir);
+	strbuf_release(&realdotgit);
+	strbuf_release(&dotgit);
+}
diff --git a/worktree.h b/worktree.h
index 7d085c7b91..9cb7f05741 100644
--- a/worktree.h
+++ b/worktree.h
@@ -100,6 +100,17 @@ typedef void worktree_repair_cb(int iserr, const char *path, const char *msg,
  */
 void repair_worktrees(worktree_repair_cb *, void *cb_data);
 
+/*
+ * Repair administrative files corresponding to the worktree at the given path.
+ * The worktree's .git link pointing at the repository must be intact for the
+ * repair to succeed. Useful for re-associating an orphaned worktree with the
+ * repository if the worktree has been moved manually (without using "git
+ * worktree move"). For each repair made or error encountered while attempting
+ * a repair, the callback, if non-NULL, is called with the path of the worktree
+ * and a description of the repair or error, along with the callback user-data.
+ */
+void repair_worktree_at_path(const char *, worktree_repair_cb *, void *cb_data);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.28.0.461.g40977abb40

