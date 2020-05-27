Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B294C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270DC2075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkPADG3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbgE0ReQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390994AbgE0ReO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:34:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60694C03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:34:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so16493723wrn.11
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=CeQw1oTw85cmZtM9faGk8LN07ohrx63jTjd3ZUclmDE=;
        b=lkPADG3GevWrlO0e/94Ft5ACOcmZf8abnTK1bHhc/LkNvbW0tHdFe9rItjg07UCWZH
         GFEzDn77WiEWxeXndB1kjhEqkxWQH+viYz3vw0HrEemYUPj9yOl5hn5rzhiZJ3+ExmPw
         DQe6SoIICRO+sPTSj1cvuJQ496qzTBL2iLKzlV8v7MryU/xwU7w/EhCiMS+pR77OSYI0
         s+fJ7XfNZ7AGQIu1ifCshtw6lirPBh8vLbw55S1kPuLYxlN7+cFPLUXGocaLMZtM3/FB
         aOx73pYNPnk6Spwy0qONw1WUOwlNgufFyhLK3PWYAe8BgCh8a6ZEsifjj8n4lNOhulQz
         cC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=CeQw1oTw85cmZtM9faGk8LN07ohrx63jTjd3ZUclmDE=;
        b=ZiPT8qP3SyEVEVlze6RaVXBNMCPsgl5iNUQFao+eHaqDV6/FyJPX8olYgQGugLQo1q
         cdOh3zUwioechqf8f/3610tgXbq0X2KzsnImrruX1ATN0M3Ei/hSbvIK+m1M0SehroE6
         HYyoLa5Wj+rDHeKj4CqK80JiIoTW+DtxQOEJfuKxHorxn5APEVqHac7ymlNP3ac6Gsc7
         sVeJ75fNJvceoAo9AHC46H+zOMmMnC1+K5I92JSLti5KXoA2eT5khI/t/9yx8Yj4xJEu
         SEFdSHoSD/bckXvsIPtTTMc3rRTWdl0eyuWljKGZOX8NXziji0hEDLr/+6I4O2xUhPmP
         i55Q==
X-Gm-Message-State: AOAM53121K//YRyX69Rh0F6+HggP/CmunaarcCEV6+7FgzknO79C9AMI
        xvbMROgmfcebFcDuKr2eayU72hTM
X-Google-Smtp-Source: ABdhPJzMhXAVCRRhVcl+wDjWKOjTC5MNAmNTtzufRQ2Apy7yppOvRGa7JSSdtWqsUxsHEaPWkPGgng==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr3269090wrn.217.1590600853044;
        Wed, 27 May 2020 10:34:13 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id h196sm3524807wme.22.2020.05.27.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:34:12 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v4 5/5] rebase: add --reset-author-date
Date:   Wed, 27 May 2020 18:33:56 +0100
Message-Id: <20200527173356.47364-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527173356.47364-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200527173356.47364-1-phillip.wood123@gmail.com>
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
 t/t3436-rebase-more-options.sh | 34 ++++++++++++++++++++++------------
 3 files changed, 27 insertions(+), 14 deletions(-)

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
index cf86240bc8..911587690b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1519,8 +1519,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index a3f9d5b41a..5ee193f333 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -137,22 +137,22 @@ test_expect_success '--committer-date-is-author-date works when committing confl
 # Checking for +0000 in author time is enough since default
 # timezone is UTC, but the timezone used while committing
 # sets to +0530.
-test_expect_success '--ignore-date works with apply backend' '
+test_expect_success '--reset-author-date works with apply backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --apply --ignore-date HEAD^ &&
+	git rebase --apply --reset-author-date HEAD^ &&
 	git log -1 --pretty=%ai >authortime &&
 	grep "+0000" authortime
 '
 
-test_expect_success '--ignore-date works with merge backend' '
+test_expect_success '--reset-author-date works with merge backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --ignore-date -m HEAD^ &&
+	git rebase --reset-author-date -m HEAD^ &&
 	git log -1 --pretty=%ai >authortime &&
 	grep "+0000" authortime
 '
 
-test_expect_success '--ignore-date works after conflict resolution' '
-	test_must_fail git rebase --ignore-date -m \
+test_expect_success '--reset-author-date works after conflict resolution' '
+	test_must_fail git rebase --reset-author-date -m \
 		--onto commit2^^ commit2^ commit2 &&
 	echo resolved >foo &&
 	git add foo &&
@@ -161,17 +161,17 @@ test_expect_success '--ignore-date works after conflict resolution' '
 	grep +0000 authortime
 '
 
-test_expect_success '--ignore-date works with rebase -r' '
+test_expect_success '--reset-author-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
-	git rebase -r --root --ignore-date &&
+	git rebase -r --root --reset-author-date &&
 	git log --pretty=%ai >authortime &&
 	! grep -v "+0000" authortime
 '
 
-test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
 	test_must_fail git rebase -m --committer-date-is-author-date \
-		--ignore-date --onto commit2^^ commit2^ commit3 &&
+		--reset-author-date --onto commit2^^ commit2^ commit3 &&
 	git checkout --theirs foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -181,16 +181,26 @@ test_expect_success '--ignore-date with --committer-date-is-author-date works' '
 	! grep -v "+0000" authortime
 '
 
-test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
-		git rebase -i --strategy=resolve --ignore-date \
+		git rebase -i --strategy=resolve --reset-author-date \
 		--committer-date-is-author-date side side &&
 	git log -1 --pretty=%ai >authortime &&
 	git log -1 --pretty=%ci >committertime &&
 	test_cmp authortime committertime &&
 	grep "+0000" authortime
  '
 
+test_expect_success '--ignore-date is an alias for --reset-author-date' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
+	git rebase -m --ignore-date HEAD^ &&
+	git log -2 --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime >output &&
+	test_line_count = 2 output
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.26.2

