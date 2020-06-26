Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B5C433E3
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD6720DD4
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gglXqnnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFZJzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgFZJzp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 05:55:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA2C08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so8522040wmm.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=zdd4uzL07QQkSUhYrhj09jsizeB8uUKt4M+BPkOkgNg=;
        b=gglXqnnAyBsKOoEXuoQk7fIIezJ032rp18rrIV61eNw1qlqRkImmWSv/zu2hrNZPqy
         btrnggDdLk1qhOHJhjWmVQ4WlpKlwLo9oiPPMcffq71cKBciVVFm/pHSUoJAjrCLXn13
         3sQkWfvNKF18NuR17e6oGUBQejPgat8Hx+U8c9POJpzI0PhYVCaXnNez2+h6Fulg8E0l
         P052EXvXGjuKVV+yTaBfJ9N2htIGrNoSr6yGEEmqBmndenIyMHpUm281rWMnS/QYG4jT
         yST85liHMk5RMIljMnf7Cpu65B8KmWzA2g3ApED9nhlYLY7w7MPdxZFFtfo4+SqWZxM3
         yPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=zdd4uzL07QQkSUhYrhj09jsizeB8uUKt4M+BPkOkgNg=;
        b=DwLvAKRBjur49AgM0Jvj5Xs34mwr0qG7N3y0//+Tdu1npL1xw7WHXE53hORqb65OyX
         DMePOuGZ+SUdDneRMyoCvD48P+iuKc3jPjWy0n+j1qZkaOU5lbbLqujYOv/BSUQo5yEt
         ZCK2eGXyNluSGy6nwP6CTf0C87tOcQcbJzt2o64rZYDhScOkQwve2vYtgSV5DBJPlwag
         puiskUXBE0Rzykif+m/qMm7XVxG7mAAdPXlYiCt1ywqeK8gAQXAVXlhfbi0nt9DeH0py
         S1jgV8S01Y8EOSMxLoimQ/OUluriVOAMe0LMxn13zCXiSBwlucQLucWyzq1uy2y3SLJ3
         IRhw==
X-Gm-Message-State: AOAM530+yVh8eq1RFOPoxHfAKEu6J4j/PRNSPtvXId4WrHVTpMs0cLb7
        eCRtd6gjv8mqCw837T+uD60=
X-Google-Smtp-Source: ABdhPJxjBEdNUgLT8Gvcu2CN6wfyAQmIAB4/r6rCfb4M6esojKWk8yHPLu1WaQDfUNdeCc6uTj5GCA==
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr2470572wmi.128.1593165344047;
        Fri, 26 Jun 2020 02:55:44 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id n14sm14327755wro.81.2020.06.26.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 02:55:43 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v5 5/5] rebase: add --reset-author-date
Date:   Fri, 26 Jun 2020 10:55:28 +0100
Message-Id: <20200626095528.117524-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626095528.117524-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The previous commit introduced --ignore-date flag to rebase -i, but the
name is rather vague as it does not say whether the author date or the
committer date is ignored. Add an alias to convey the precise purpose.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt   |  1 +
 builtin/rebase.c               |  6 ++++--
 t/t3436-rebase-more-options.sh | 34 +++++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e2717e20e6..a5f82913fb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -450,6 +450,7 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 890dd4c588..3fe33beef4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1505,8 +1505,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_BOOL(0, "ignore-date", &options.ignore_date,
-			 "ignore author date and use current date"),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 N_("ignore author date and use current date")),
+		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
+				N_("synonym of --reset-author-date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 0ede2b8900..5b8963272a 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -117,53 +117,61 @@ test_ctime_is_ignored () {
 	! grep -v +0000 authortime
 }
 
-test_expect_success '--ignore-date works with apply backend' '
+test_expect_success '--reset-author-date works with apply backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --apply --ignore-date HEAD^ &&
+	git rebase --apply --reset-author-date HEAD^ &&
 	test_ctime_is_ignored -1
 '
 
-test_expect_success '--ignore-date works with merge backend' '
+test_expect_success '--reset-author-date works with merge backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --ignore-date -m HEAD^ &&
+	git rebase --reset-author-date -m HEAD^ &&
 	test_ctime_is_ignored -1
 '
 
-test_expect_success '--ignore-date works after conflict resolution' '
-	test_must_fail git rebase --ignore-date -m \
+test_expect_success '--reset-author-date works after conflict resolution' '
+	test_must_fail git rebase --reset-author-date -m \
 		--onto commit2^^ commit2^ commit2 &&
 	echo resolved >foo &&
 	git add foo &&
 	git rebase --continue &&
 	test_ctime_is_ignored -1
 '
 
-test_expect_success '--ignore-date works with rebase -r' '
+test_expect_success '--reset-author-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
-	git rebase -r --root --ignore-date &&
+	git rebase -r --root --reset-author-date &&
 	test_ctime_is_ignored
 '
 
-test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
 	test_must_fail git rebase -m --committer-date-is-author-date \
-		--ignore-date --onto commit2^^ commit2^ commit3 &&
+		--reset-author-date --onto commit2^^ commit2^ commit3 &&
 	git checkout --theirs foo &&
 	git add foo &&
 	git rebase --continue &&
 	test_ctime_is_atime -2 &&
 	test_ctime_is_ignored -2
 '
 
-test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
 		PATH="./test-bin:$PATH" git rebase -i --strategy=test \
-				--ignore-date --committer-date-is-author-date \
-				side side &&
+				--reset-author-date \
+				--committer-date-is-author-date side side &&
 	test_ctime_is_atime -1 &&
 	test_ctime_is_ignored -1
  '
 
+test_expect_success '--ignore-date is an alias for --reset-author-date' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
+	git rebase -m --ignore-date HEAD^ &&
+	test_ctime_is_ignored -2
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.27.0

