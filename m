Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DCC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFA6206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYXTvS86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFQIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40833 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfLFQIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so7863807wmi.5
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=g/MhRBzkiypceIxVnALCyjM1eHKvec54D0R09F/4Whc=;
        b=PYXTvS868GhfwLg418zKY2UQgis2vrJBw6ZZPaOzos53rKoRxJCzVUslkWQ46/Vu2x
         Uoe77sSF+ghiV64zBGPJlv4MkfvIrxozn+hVbZHpsHQfrsX0f1DXklDrwiEN60dD2w0w
         x+ZpbysQGJcsemKHGWqdWy+at2BY1qjyRVB1kXiB7rhbwGVYAXCWZVj9Po/1VbRXBUab
         MKTjQTbmAz+f3whm6F8EWoIoIKVZOVK8c6gV1ScXRUemcLxhbvQ2Vy+0TKnY6v7ZUh7k
         tbVpccqvSaw6C73RdKGmgQnpCDDTMGHbiyg7/K/HoYB2VbpLJPUjDilOLTWkPHJ6zGo2
         bn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=g/MhRBzkiypceIxVnALCyjM1eHKvec54D0R09F/4Whc=;
        b=dKXLRFqP+p2QGyjj2+TJvpFXGGq1svy+y5nd/F2shdu5ip116/1exOz6H7TF0edxg7
         kj6/oKlVt9fWBMVjfKkOnvmGZwkclvbhNc1Oj6m/6WBuEYbH+Gl3egTbBMuZu7Y7DoEq
         Z/GJLfmNY7MJwO8Qj6X64XgzZSBYeq35aXbZgT1bjPp7hblq0DunUWvl6kQ8uAt1MEEw
         ANPr4sbHDBcIUaq+qdbblutGRV+ggjp/1OMCDh/KxHR5upplUk2m9oy4AFmqG2P6/vfZ
         s4l9GMeIlkBUMU4SJOY93laQGc2IiT30HZuwO5cDutuF95Qmo7BDIYvqgMMznBxCZJwo
         MnWg==
X-Gm-Message-State: APjAAAURMpn5iqk/sCGkqczpdm4fQctwXm2sWE19lpqSlO7b0ix4IHnH
        WIvE0XDlea7cXx6khuz9e1PzoqP+
X-Google-Smtp-Source: APXvYqyYhKpOZzuqgTCpBT6qxxiAM4kuo3RUi9ovsBgb/0TmBrpmyWtNJ6+pfvGMDI/CpPp2KQLl/Q==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr9357712wmo.48.1575648518819;
        Fri, 06 Dec 2019 08:08:38 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:38 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 9/9] [RFC] rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
Date:   Fri,  6 Dec 2019 16:06:14 +0000
Message-Id: <20191206160614.631724-10-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since the inception of CHERRY_PICK_HEAD in d7e5c0cbfb ("Introduce
CHERRY_PICK_HEAD", 2011-02-19) 'rebase -i' has removed it when there are
conflicts. The rationale for this was that the rebase wanted to handle
the conflicts itself. However sometimes (e.g. after an edit command) the
user wants to commit the conflict resolution before making some other
changes or running some tests. Without CHERRY_PICK_HEAD the authorship
information is lost when the user makes the commit. Fix this by leaving
CHERRY_PICK_HEAD when we're not amending.

Note that this changes the output of `git status`. The advice to run
`git reset` is not appropriate for rebase as we do not allow partial
commits.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    This has semantic conflicts with ra/rebase-i-more-options as it does not
    respect the options passed to rebase when the user commits
    
    I haven't checked how this affects the shell prompt in contrib yet, I
    suspect it may need changing to cope the presence of CHERRY_PICK_HEAD
    during a rebase.
    
    I'd like to change the existing authorship tests to rely on the "Original
    Author" changes here, but they are a web of hidden interdependencies which is
    hard to untangle.

 sequencer.c                   |  12 ++--
 t/t3404-rebase-interactive.sh | 104 +++++++++++++++++++++++++---------
 t/t7512-status-help.sh        |   2 -
 3 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 64242f4ce7..624e96c930 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -372,11 +372,15 @@ static void print_advice(struct repository *r, int show_hint,
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
 		/*
-		 * A conflict has occurred but the porcelain
-		 * (typically rebase --interactive) wants to take care
-		 * of the commit itself so remove CHERRY_PICK_HEAD
+		 * A conflict has occurred but the porcelain wants to take care
+		 * of the commit itself so remove CHERRY_PICK_HEAD. Note that we
+		 * do not do this for interactive rebases anymore in order to
+		 * preserve the author identity when the user runs 'git commit'
+		 * to commit the conflict resolution rather than relying on
+		 * 'rebase --continue' to do it for them.
 		 */
-		unlink(git_path_cherry_pick_head(r));
+		if (!is_rebase_i(opts))
+			unlink(git_path_cherry_pick_head(r));
 		return;
 	}
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5afa6f28cd..5cd7db18f8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -33,31 +33,35 @@ Initial setup:
 # in the expect2 file for the 'stop on conflicting pick' test.
 
 test_expect_success 'setup' '
-	test_commit A file1 &&
-	test_commit B file1 &&
-	test_commit C file2 &&
-	test_commit D file1 &&
-	test_commit E file3 &&
-	git checkout -b branch1 A &&
-	test_commit F file4 &&
-	test_commit G file1 &&
-	test_commit H file5 &&
-	git checkout -b branch2 F &&
-	test_commit I file6 &&
-	git checkout -b conflict-branch A &&
-	test_commit one conflict &&
-	test_commit two conflict &&
-	test_commit three conflict &&
-	test_commit four conflict &&
-	git checkout -b no-conflict-branch A &&
-	test_commit J fileJ &&
-	test_commit K fileK &&
-	test_commit L fileL &&
-	test_commit M fileM &&
-	git checkout -b no-ff-branch A &&
-	test_commit N fileN &&
-	test_commit O fileO &&
-	test_commit P fileP
+	(
+		GIT_AUTHOR_NAME="Original Author" &&
+		GIT_AUTHOR_EMAIL="original.author@example.com" &&
+		test_commit A file1 &&
+		test_commit B file1 &&
+		test_commit C file2 &&
+		test_commit D file1 &&
+		test_commit E file3 &&
+		git checkout -b branch1 A &&
+		test_commit F file4 &&
+		test_commit G file1 &&
+		test_commit H file5 &&
+		git checkout -b branch2 F &&
+		test_commit I file6 &&
+		git checkout -b conflict-branch A &&
+		test_commit one conflict &&
+		test_commit two conflict &&
+		test_commit three conflict &&
+		test_commit four conflict &&
+		git checkout -b no-conflict-branch A &&
+		test_commit J fileJ &&
+		test_commit K fileK &&
+		test_commit L fileL &&
+		test_commit M fileM &&
+		git checkout -b no-ff-branch A &&
+		test_commit N fileN &&
+		test_commit O fileO &&
+		test_commit P fileP
+	)
 '
 
 # "exec" commands are run with the user shell by default, but this may
@@ -252,12 +256,12 @@ test_expect_success 'stop on conflicting pick' '
 	-A
 	+G
 	EOF
-	cat >expect2 <<-\EOF &&
+	cat >expect2 <<-EOF &&
 	<<<<<<< HEAD
 	D
 	=======
 	G
-	>>>>>>> 5d18e54... G
+	>>>>>>> $(git rev-parse --short HEAD)... G
 	EOF
 	git tag new-branch1 &&
 	test_must_fail git rebase -i master &&
@@ -1628,6 +1632,52 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_i18ngrep "middle of a rebase -- cannot amend." err
 '
 
+test_expect_success 'correct error message for partial commit after confilct' '
+	test_when_finished "git rebase --abort" &&
+	git checkout D &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	echo x >file1 &&
+	echo y >file2 &&
+	git add file1 file2 &&
+	test_must_fail git commit file1 2>err &&
+	test_i18ngrep "cannot do a partial commit during a rebase." err
+'
+
+test_expect_success 'correct error message for commit --amend after conflict' '
+	test_when_finished "git rebase --abort" &&
+	git checkout D &&
+	(
+		set_fake_editor &&
+		FAKE_LINES=3 &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	echo x>file1 &&
+	test_must_fail git commit -a --amend 2>err &&
+	test_i18ngrep "middle of a rebase -- cannot amend." err
+'
+
+test_expect_success 'correct authorship and message after conflict' '
+	git checkout D &&
+	(
+		set_fake_editor &&
+		FAKE_LINES=3 &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	echo x >file1 &&
+	git commit -a &&
+	git log --pretty=format:"%an <%ae>%n%ad%n%B" -1 D >expect &&
+	git log --pretty=format:"%an <%ae>%n%ad%n%B" -1 HEAD >actual &&
+	test_cmp expect actual &&
+	git rebase --continue
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index c1eb72555d..2adceb35e2 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -148,7 +148,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
   (use "git rebase --abort" to check out the original branch)
 
 Unmerged paths:
-  (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   main.txt
@@ -176,7 +175,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
   (all conflicts fixed: run "git rebase --continue")
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
 
 	modified:   main.txt
 
-- 
2.24.0

