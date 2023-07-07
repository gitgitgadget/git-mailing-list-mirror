Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8914EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 05:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjGGFnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 01:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGGFn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 01:43:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EDE1BE8
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 22:43:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7658430eb5dso156821285a.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688708607; x=1691300607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AeJM2MW61pCLyMZ1lrX8eQ/79HFymObe4v3IQn3/QQ=;
        b=a9a1Gc2ZeMG4s5LmYpOmrVULqcng7kECqsZxFnF+rXLmzyXja9ioRAixSRSjxc9WCM
         GKNUbYhEkWaoeitxCEaZVWQNefLnpY84eML161WxF03Ww1ulKz/YO/UY8pgngrmXZdX/
         KcLk0VRtSihjWV8E952pmcGxm18RJXJqyCFyUfbad506xKkb7rX/YYfHkzVq+dCsVAGN
         Iu/ULor9fOfRSRyiPngDeXAWX0tEFfQsbAyqWkITXmWr0wyIctyBFBmxBQf8PteS77mH
         tKUIXe7enODwXF2RyTOdkqYVUm7IuQeVYQZnUhl//IIiqFx78pALFzakopvrZh39GiVi
         ywhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708607; x=1691300607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AeJM2MW61pCLyMZ1lrX8eQ/79HFymObe4v3IQn3/QQ=;
        b=kTdbVYM41BqxkbKiTOoduZ8sDwsUZW/4cnsqvlaub90prv+jVXd2YFPuXC7W/D5ojp
         FzyQ7PalWAV4SJ3tmXff05VxRUagz74e4S2+00gwcriMGMeR3sSy6+IhN2yYao+csuvs
         6+aVMf7g8FzHapl3Xxqr/poUWu26eqSCaQxqnwbx97OEGSElhqkzKiAUGVNnNgjN8V96
         6iB2qphYy+03x0ZbRdyIXyKs3DDCyGRKTI5ZHOAFCs7RhPgl1r39wbIATC/+Rk1TzZoC
         LT38aBXWNO8HIt86sqlJuqrN1NSvmIIOchjXKdRzKbRbbB7XgZRbPWN3RrrNErZZd4ub
         9wEA==
X-Gm-Message-State: ABy/qLaAZeZX6ILXheN3kHl0VUW1omG/5Nk0JQEty4Xqd/Ijizjj0MH7
        VAAyJCyUo2sSEYjC17e16Nq1a3Jambg=
X-Google-Smtp-Source: APBJJlGG5icrT7xueCm5yITfeeLn7647HLf6vFWqyetfsxzSHrtfb75pzs5e9ap66tXQVkrraKUdZA==
X-Received: by 2002:a05:620a:c4c:b0:767:6854:e92d with SMTP id u12-20020a05620a0c4c00b007676854e92dmr5238291qki.44.1688708607012;
        Thu, 06 Jul 2023 22:43:27 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id r8-20020a635d08000000b00553dcfc2179sm2132568pgb.52.2023.07.06.22.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:43:26 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 2/2] push: advise about force-pushing as an alternative to reconciliation
Date:   Thu,  6 Jul 2023 23:42:48 -0600
Message-ID: <20230707054257.3366355-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707054257.3366355-1-alexhenrie24@gmail.com>
References: <20230706040111.81110-1-alexhenrie24@gmail.com>
 <20230707054257.3366355-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, don't put `git pull` in an awkward parenthetical, because
`git pull` can always be used to reconcile branches and is the normal
way to do so.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/push.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6f8a8dc711..b2f0a64e7c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -301,21 +301,24 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
 
 static const char message_advice_pull_before_push[] =
 	N_("Updates were rejected because the tip of your current branch is behind\n"
-	   "its remote counterpart. Integrate the remote changes (e.g.\n"
-	   "'git pull ...') before pushing again.\n"
+	   "its remote counterpart. Use 'git pull' to integrate the remote changes\n"
+	   "before pushing again, or use 'git push --force' to delete the remote\n"
+	   "changes and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-	   "counterpart. Check out this branch and integrate the remote changes\n"
-	   "(e.g. 'git pull ...') before pushing again.\n"
+	   "counterpart. Check out this branch and use 'git pull' to integrate the\n"
+	   "remote changes before pushing again, or use 'git push --force' to delete\n"
+	   "the remote changes and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_fetch_first[] =
-	N_("Updates were rejected because the remote contains work that you do\n"
-	   "not have locally. This is usually caused by another repository pushing\n"
-	   "to the same ref. You may want to first integrate the remote changes\n"
-	   "(e.g., 'git pull ...') before pushing again.\n"
+	N_("Updates were rejected because the remote contains work that you do not\n"
+	   "have locally. This is usually caused by another repository pushing to\n"
+	   "the same ref. Use 'git pull' to integrate the remote changes before\n"
+	   "pushing again, or use 'git push --force' to delete the remote changes\n"
+	   "and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
@@ -327,10 +330,10 @@ static const char message_advice_ref_needs_force[] =
 	   "without using the '--force' option.\n");
 
 static const char message_advice_ref_needs_update[] =
-	N_("Updates were rejected because the tip of the remote-tracking\n"
-	   "branch has been updated since the last checkout. You may want\n"
-	   "to integrate those changes locally (e.g., 'git pull ...')\n"
-	   "before forcing an update.\n");
+	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
+	   "been updated since the last checkout. Use 'git pull' to integrate the\n"
+	   "remote changes before pushing again, or use 'git push --force' to delete\n"
+	   "the remote changes and replace them with your own.\n");
 
 static void advise_pull_before_push(void)
 {
-- 
2.41.0

