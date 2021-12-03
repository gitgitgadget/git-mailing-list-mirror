Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E349C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 03:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378353AbhLCDwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 22:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348654AbhLCDwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 22:52:00 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F8C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 19:48:36 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m9so2242372iop.0
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31XrHvDBeu3CkIVE3G4CzWutK8SScP+e6U9gpVvE+eY=;
        b=f/8MVidWSWf76zjqgUf+fiyyKMgk/iPe96ngpoijuGyqhFf9lGfw77ElrHQu5FJPKL
         vy2GbWoQDXrgu9l4xYveNXjlxd9LKsHh/Zb6bKP7IkgnapN/ay7Pq7HSbe4tb4VTG4Sh
         C8SylsFVuuFNpFNHSzlz1wcuApPlCTLCfc1p//a0Msg8sYGemSGRH0mD4apRXVXUHclK
         rqFSuGKxOYu5ZiHZMVzou2mePbKDFmr/a7bmjdjbhuefQyg5Yq2dO1w2vKvbm2vEdzNY
         pONRgFeh7F0HZ7YVhWnfJXj0h5KKqLRrUtPvlHtRfZ3hJSfUcrwyoX7I3t6MvIzoGx5a
         QN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=31XrHvDBeu3CkIVE3G4CzWutK8SScP+e6U9gpVvE+eY=;
        b=PRrVtcE5aGk29PYcvvtqc21hJHfbY6nkKzOt+Fx8AoGXPCQenVuuHypdvS9umH7pCm
         k5dTrBDuk2GEbQuoH5o/DSxHPJq2H4Ikkf4FyFmAvj+JBqFE/JepoeX7dGVNip2guj+E
         fWHxkS5110G6ADgFgO1RmhT4+iSPpLUWP8+l//xaiz9QvSK6XvLX+pNYMyCtw24op/sd
         bEliWebBzr9MQ6nO8wIgk19UknAGykWE+HCThVeOxoqb/FdCjHBs3mY0/aplfrMBzCcJ
         Oh7nwqlP89x+CEt7dKRapuVwAmKhwsC5C9i0ZLVpv4o73zt6fwWCk2b4+2D4xvNr/tea
         8y4Q==
X-Gm-Message-State: AOAM5323wLDtw91UgEOByA1kI4SbRuTcLiplHVVOQDsr4pkrs2pR9MA4
        gX7LN8VaSVF3KkAvRICAbN7zCXUrsuv6nA==
X-Google-Smtp-Source: ABdhPJwnzpLDlHe/cdxV85UjNNbp0TWWTDSxbkbzu0GWCtUMeQs/jPBeQa/0F4APvbYa7gCDCjG0+A==
X-Received: by 2002:a05:6602:42:: with SMTP id z2mr19491788ioz.208.1638503315813;
        Thu, 02 Dec 2021 19:48:35 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id x2sm975639ilv.65.2021.12.02.19.48.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 19:48:35 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] worktree: send "chatty" messages to stderr
Date:   Thu,  2 Dec 2021 22:44:19 -0500
Message-Id: <20211203034420.47447-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0
In-Reply-To: <20211203034420.47447-1-sunshine@sunshineco.com>
References: <20211203034420.47447-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order in which the stdout and stderr streams are flushed is not
guaranteed to be the same across platforms or `libc` implementations.
This lack of determinism can lead to anomalous and potentially confusing
output if normal (stdout) output is flushed after error (stderr) output.
For instance, the following output which clearly indicates a failure due
to a fatal error:

    % git worktree add ../foo bar
    Preparing worktree (checking out 'bar')
    fatal: 'bar' is already checked out at '.../wherever'

has been reported[1] on Microsoft Windows to appear as:

    % git worktree add ../foo bar
    fatal: 'bar' is already checked out at '.../wherever'
    Preparing worktree (checking out 'bar')

which may confuse the reader into thinking that the command somehow
recovered and ran to completion despite the error.

This problem crops up because the "chatty" status message "Preparing
worktree" is sent to stdout, whereas the "fatal" error message is sent
to stderr. One way to fix this would be to flush stdout manually before
git-worktree reports any errors to stderr.

However, common practice in Git is for "chatty" messages to be sent to
stderr. Therefore, a more appropriate fix is to adjust git-worktree to
conform to that practice by sending its "chatty" messages to stderr
rather than stdout as is currently the case.

There may be concern that relocating messages from stdout to stderr
could break existing tooling, however, these messages are already
internationalized, thus are unstable. And, indeed, the "Preparing
worktree" message has already been the subject of somewhat significant
changes in 2c27002a0a (worktree: improve message when creating a new
worktree, 2018-04-24). Moreover, there is existing precedent, such as
68b939b2f0 (clone: send diagnostic messages to stderr, 2013-09-18) which
likewise relocated "chatty" messages from stdout to stderr for
git-clone.

[1]: https://lore.kernel.org/git/CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com/T/

Reported-by: Baruch Burstein <bmburstein@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c         | 14 +++++++-------
 t/t2401-worktree-prune.sh  | 14 +++++++-------
 t/t2402-worktree-list.sh   |  2 +-
 t/t2406-worktree-repair.sh | 30 ++++++++++++------------------
 4 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1..a57fcd0f3c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -72,7 +72,7 @@ static void delete_worktrees_dir_if_empty(void)
 static void prune_worktree(const char *id, const char *reason)
 {
 	if (show_only || verbose)
-		printf_ln(_("Removing %s/%s: %s"), "worktrees", id, reason);
+		fprintf_ln(stderr, _("Removing %s/%s: %s"), "worktrees", id, reason);
 	if (!show_only)
 		delete_git_dir(id);
 }
@@ -418,24 +418,24 @@ static void print_preparing_worktree_line(int detach,
 	if (force_new_branch) {
 		struct commit *commit = lookup_commit_reference_by_name(new_branch);
 		if (!commit)
-			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+			fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 		else
-			printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
+			fprintf_ln(stderr, _("Preparing worktree (resetting branch '%s'; was at %s)"),
 				  new_branch,
 				  find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
 	} else if (new_branch) {
-		printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
 		struct strbuf s = STRBUF_INIT;
 		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
 		    ref_exists(s.buf))
-			printf_ln(_("Preparing worktree (checking out '%s')"),
+			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
 				  branch);
 		else {
 			struct commit *commit = lookup_commit_reference_by_name(branch);
 			if (!commit)
 				die(_("invalid reference: %s"), branch);
-			printf_ln(_("Preparing worktree (detached HEAD %s)"),
+			fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
 				  find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
 		}
 		strbuf_release(&s);
@@ -1006,7 +1006,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 static void report_repair(int iserr, const char *path, const char *msg, void *cb_data)
 {
 	if (!iserr) {
-		printf_ln(_("repair: %s: %s"), msg, path);
+		fprintf_ln(stderr, _("repair: %s: %s"), msg, path);
 	} else {
 		int *exit_status = (int *)cb_data;
 		fprintf_ln(stderr, _("error: %s: %s"), msg, path);
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index a615d3b483..3d28c7f06b 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -19,7 +19,7 @@ test_expect_success 'worktree prune on normal repo' '
 test_expect_success 'prune files inside $GIT_DIR/worktrees' '
 	mkdir .git/worktrees &&
 	: >.git/worktrees/abc &&
-	git worktree prune --verbose >actual &&
+	git worktree prune --verbose 2>actual &&
 	cat >expect <<EOF &&
 Removing worktrees/abc: not a valid directory
 EOF
@@ -34,7 +34,7 @@ test_expect_success 'prune directories without gitdir' '
 	cat >expect <<EOF &&
 Removing worktrees/def: gitdir file does not exist
 EOF
-	git worktree prune --verbose >actual &&
+	git worktree prune --verbose 2>actual &&
 	test_cmp expect actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -45,7 +45,7 @@ test_expect_success SANITY 'prune directories with unreadable gitdir' '
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
 	chmod u-r .git/worktrees/def/gitdir &&
-	git worktree prune --verbose >actual &&
+	git worktree prune --verbose 2>actual &&
 	test_i18ngrep "Removing worktrees/def: unable to read gitdir file" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -55,7 +55,7 @@ test_expect_success 'prune directories with invalid gitdir' '
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
-	git worktree prune --verbose >actual &&
+	git worktree prune --verbose 2>actual &&
 	test_i18ngrep "Removing worktrees/def: invalid gitdir file" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -65,7 +65,7 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
 	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
-	git worktree prune --verbose >actual &&
+	git worktree prune --verbose 2>actual &&
 	test_i18ngrep "Removing worktrees/def: gitdir file points to non-existent location" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -101,7 +101,7 @@ test_expect_success 'prune duplicate (linked/linked)' '
 	git worktree add --detach w2 &&
 	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
 	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
-	git worktree prune --verbose >actual &&
+	git worktree prune --verbose 2>actual &&
 	test_i18ngrep "duplicate entry" actual &&
 	test -d .git/worktrees/w1 &&
 	! test -d .git/worktrees/w2
@@ -114,7 +114,7 @@ test_expect_success 'prune duplicate (main/linked)' '
 	git -C repo worktree add --detach ../wt &&
 	rm -fr wt &&
 	mv repo wt &&
-	git -C wt worktree prune --verbose >actual &&
+	git -C wt worktree prune --verbose 2>actual &&
 	test_i18ngrep "duplicate entry" actual &&
 	! test -d .git/worktrees/wt
 '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 4012bd67b0..c8a5a0aac6 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -134,7 +134,7 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
 	git worktree list >out &&
 	grep "/prunable  *[0-9a-f].* prunable$" out &&
 	! grep "/unprunable  *[0-9a-f].* unprunable$" out &&
-	git worktree prune --verbose >out &&
+	git worktree prune --verbose 2>out &&
 	test_i18ngrep "^Removing worktrees/prunable" out &&
 	test_i18ngrep ! "^Removing worktrees/unprunable" out
 '
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index f73741886b..5c44453e1c 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -45,9 +45,8 @@ test_corrupt_gitfile () {
 	git worktree add --detach corrupt &&
 	git -C corrupt rev-parse --absolute-git-dir >expect &&
 	eval "$butcher" &&
-	git -C "$repairdir" worktree repair >out 2>err &&
-	test_i18ngrep "$problem" out &&
-	test_must_be_empty err &&
+	git -C "$repairdir" worktree repair 2>err &&
+	test_i18ngrep "$problem" err &&
 	git -C corrupt rev-parse --absolute-git-dir >actual &&
 	test_cmp expect actual
 }
@@ -130,10 +129,9 @@ test_expect_success 'repair broken gitdir' '
 	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
 	rm .git/worktrees/orig/gitdir &&
 	mv orig moved &&
-	git worktree repair moved >out 2>err &&
+	git worktree repair moved 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_i18ngrep "gitdir unreadable" out &&
-	test_must_be_empty err
+	test_i18ngrep "gitdir unreadable" err
 '
 
 test_expect_success 'repair incorrect gitdir' '
@@ -141,10 +139,9 @@ test_expect_success 'repair incorrect gitdir' '
 	git worktree add --detach orig &&
 	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
 	mv orig moved &&
-	git worktree repair moved >out 2>err &&
+	git worktree repair moved 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_i18ngrep "gitdir incorrect" out &&
-	test_must_be_empty err
+	test_i18ngrep "gitdir incorrect" err
 '
 
 test_expect_success 'repair gitdir (implicit) from linked worktree' '
@@ -152,10 +149,9 @@ test_expect_success 'repair gitdir (implicit) from linked worktree' '
 	git worktree add --detach orig &&
 	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
 	mv orig moved &&
-	git -C moved worktree repair >out 2>err &&
+	git -C moved worktree repair 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_i18ngrep "gitdir incorrect" out &&
-	test_must_be_empty err
+	test_i18ngrep "gitdir incorrect" err
 '
 
 test_expect_success 'unable to repair gitdir (implicit) from main worktree' '
@@ -163,9 +159,8 @@ test_expect_success 'unable to repair gitdir (implicit) from main worktree' '
 	git worktree add --detach orig &&
 	cat .git/worktrees/orig/gitdir >expect &&
 	mv orig moved &&
-	git worktree repair >out 2>err &&
+	git worktree repair 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_must_be_empty out &&
 	test_must_be_empty err
 '
 
@@ -178,12 +173,11 @@ test_expect_success 'repair multiple gitdir files' '
 	sed s,orig2/\.git$,moved2/.git, .git/worktrees/orig2/gitdir >expect2 &&
 	mv orig1 moved1 &&
 	mv orig2 moved2 &&
-	git worktree repair moved1 moved2 >out 2>err &&
+	git worktree repair moved1 moved2 2>err &&
 	test_cmp expect1 .git/worktrees/orig1/gitdir &&
 	test_cmp expect2 .git/worktrees/orig2/gitdir &&
-	test_i18ngrep "gitdir incorrect:.*orig1/gitdir$" out &&
-	test_i18ngrep "gitdir incorrect:.*orig2/gitdir$" out &&
-	test_must_be_empty err
+	test_i18ngrep "gitdir incorrect:.*orig1/gitdir$" err &&
+	test_i18ngrep "gitdir incorrect:.*orig2/gitdir$" err
 '
 
 test_expect_success 'repair moved main and linked worktrees' '
-- 
2.34.1.173.g76aa8bc2d0

