Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB0C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25B72072D
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0xT5V0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgHaG7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHaG7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:08 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FC1C061236
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id u126so4763855iod.12
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTE4ITPVf8njHTROTxm3oXPhL6Y6OWgYs8COmJqEeWI=;
        b=S0xT5V0Jx/SQjbpOAApTYauMQ64mj28dmPiAUQUnHxeVn8LAKwmDwkCqXpGKMM1RFX
         aWgkNsGvaocw0IhOMj3ZW0ts+Xv7FxNrYRgPViTamiJuCb1okBQzV1pMReFhJA+g1tRI
         HlNofpnqMRYOKI4zwnIcBEd9kR8RjsoLTBEFMjsXq14024cKJdedK2aiL1qMIcZ0BD0R
         WZ5TtWn2OF4NxodD3ciD0rer1673/M/K2R3aTj6wrjaUgWW0sbahvDXJ3XFl7RlbBtkt
         otoAC4PdJ36pPz3/T044UngoG1Wd3nE+rlcAXoh+6mfMryW3tSPLaZIbfyewEU2mbuut
         1LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MTE4ITPVf8njHTROTxm3oXPhL6Y6OWgYs8COmJqEeWI=;
        b=gkIKg7QUxPYKHveanID+cMIGYxVYSpigrIeSNxha94+BD1lVVFRzFEfQPQCmva6ahu
         nAaAR8oW0vgZthLG7TameFhvLYFtPhbRtR3+ZP+X983zLtrghWaaA7SRn0cvD09mdUYl
         EuSNfQ0dOABnGlHr3hndTIm6OklcYU91BU3aXMohijEEKCacfAjUdmbZaP7Sglt4dXHN
         rgSCn9jJFV9haqbjZTki9/wv3+Vu5Zh6rpTX/OApisyMSUnPy+xQuhMiHch5RUZy6XE0
         ko6PSP27bA6ci1qqU6m140IBAnSvobP/Isa7FEOJnRzMXjUh1Q7Bir2Rr1pU4zLtfetJ
         05xA==
X-Gm-Message-State: AOAM530FJyyxZcsF01eJ2/wNRNgz3wiFQqC+SDteAl+3KYh4iEfBeT0a
        7ewWt5FlhowtUJ+xgqkPBTZ1q2UY/VU=
X-Google-Smtp-Source: ABdhPJx7aBhvcRIoJ8Bz+8ZfggAXQWAfdxRKhWzY8C8jW4mwiPSfkGplWnpx9hspgw7eqsCnGM36yA==
X-Received: by 2002:a02:820b:: with SMTP id o11mr26084jag.136.1598857145451;
        Sun, 30 Aug 2020 23:59:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id x1sm1878615ilo.50.2020.08.30.23.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:59:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] worktree: teach "repair" to fix outgoing links to worktrees
Date:   Mon, 31 Aug 2020 02:57:58 -0400
Message-Id: <20200831065800.62502-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.531.g41c3d8a546
In-Reply-To: <20200831065800.62502-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200831065800.62502-1-sunshine@sunshineco.com>
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
 worktree.h                     | 12 +++++
 5 files changed, 188 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 34fe47cecd..f70cda4b36 100644
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
 the main working tree will reestablish the connection from linked
 working trees back to the main working tree.
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
index 68b0032428..8165343145 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1043,15 +1043,18 @@ static void report_repair(int iserr, const char *path, const char *msg, void *cb
 
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
 	repair_worktrees(report_repair, &rc);
+	p = ac > 0 ? av : self;
+	for (; *p; p++)
+		repair_worktree_at_path(*p, report_repair, &rc);
 	return rc;
 }
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index ef59cdce95..1fe468bfe8 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -90,4 +90,90 @@ test_expect_success 'repair .git file from bare.git' '
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
+test_expect_success 'repo not found; .git file broken' '
+	test_when_finished "rm -rf orig moved && git worktree prune" &&
+	git worktree add --detach orig &&
+	echo /invalid >orig/.git &&
+	mv orig moved &&
+	test_must_fail git worktree repair moved >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep ".git file broken" err
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
index 3ad93cc4aa..46a5fb8447 100644
--- a/worktree.c
+++ b/worktree.c
@@ -632,3 +632,77 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_data)
 		repair_gitfile(*wt, fn, cb_data);
 	free_worktrees(worktrees);
 }
+
+static int is_main_worktree_path(const char *path)
+{
+	struct strbuf target = STRBUF_INIT;
+	struct strbuf maindir = STRBUF_INIT;
+	int cmp;
+
+	strbuf_add_real_path(&target, path);
+	strbuf_strip_suffix(&target, "/.git");
+	strbuf_add_real_path(&maindir, get_git_common_dir());
+	strbuf_strip_suffix(&maindir, "/.git");
+	cmp = fspathcmp(maindir.buf, target.buf);
+
+	strbuf_release(&maindir);
+	strbuf_release(&target);
+	return !cmp;
+}
+
+/*
+ * Repair <repo>/worktrees/<id>/gitdir if missing, corrupt, or not pointing at
+ * the worktree's path.
+ */
+void repair_worktree_at_path(const char *path,
+			     worktree_repair_fn fn, void *cb_data)
+{
+	struct strbuf dotgit = STRBUF_INIT;
+	struct strbuf realdotgit = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf olddotgit = STRBUF_INIT;
+	char *backlink = NULL;
+	const char *repair = NULL;
+	int err;
+
+	if (!fn)
+		fn = repair_noop;
+
+	if (is_main_worktree_path(path))
+		goto done;
+
+	strbuf_addf(&dotgit, "%s/.git", path);
+	if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
+		fn(1, path, _("not a valid path"), cb_data);
+		goto done;
+	}
+
+	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
+	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
+		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
+		goto done;
+	} else if (err) {
+		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
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
+		fn(0, gitdir.buf, repair, cb_data);
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
index 4fcb01348c..ff7b62e434 100644
--- a/worktree.h
+++ b/worktree.h
@@ -100,6 +100,18 @@ typedef void (* worktree_repair_fn)(int iserr, const char *path,
  */
 void repair_worktrees(worktree_repair_fn, void *cb_data);
 
+/*
+ * Repair administrative files corresponding to the worktree at the given path.
+ * The worktree's .git file pointing at the repository must be intact for the
+ * repair to succeed. Useful for re-associating an orphaned worktree with the
+ * repository if the worktree has been moved manually (without using "git
+ * worktree move"). For each repair made or error encountered while attempting
+ * a repair, the callback function, if non-NULL, is called with the path of the
+ * worktree and a description of the repair or error, along with the callback
+ * user-data.
+ */
+void repair_worktree_at_path(const char *, worktree_repair_fn, void *cb_data);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.28.0.531.g41c3d8a546

