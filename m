Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D33EC001E0
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 04:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjGFEBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 00:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFEBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 00:01:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412719A0
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 21:01:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e3b15370so208030b3a.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688616101; x=1691208101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AeJM2MW61pCLyMZ1lrX8eQ/79HFymObe4v3IQn3/QQ=;
        b=l1RgNFRUWpmxyfgU1XFNBJtl26/G2TxOMVBU0383CCxI/RULE4fse5bWOOSPqPT8od
         97NM6XpN91s18kd30tQo7ZHRNIcpYHvosgPggG3hiWZUZ86HZtWxLzAaEPFlgmMJUuKV
         DwoKc0yfig0ZfQma6bPb6QOSPiFxS8peCdtrOX18CbikssTo4AtJJYiwDX/jItSxlghD
         P1x/hyjeT2AUWVrseEjSkdW6ygAsmWdfE7NGldXVXrFRAOMJf4UIdZFsMdH0BKfs7IgJ
         UncUmhBlP7XKd+uPm0DG+mVKaK+pYM80MgSiJpEpgx50ekxEfap+R8kNr5OrMmnCJT/W
         ehqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688616101; x=1691208101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AeJM2MW61pCLyMZ1lrX8eQ/79HFymObe4v3IQn3/QQ=;
        b=izzStXHwqniV/PreZrGsAypryLXLQ2esIsZ96kd7mOD4aFf04K7+Tcf5JeEHDSaQsZ
         ty7ozfplnkm1G3AQCYtivDuQBGVvu6BQUhdfok9eDxwLgvRm0vJVUP9lSaywXHPsqP7y
         v3/hhAvypM3KOdnDvwGeAgtGAL3aKWRYZNvXTylKLVonfD8FO/n4GcBY+V+V3CjuTtSk
         0DYXACK6sXQgaod/jpbkhtkfia8W0+hoRYGAmbkqZ7zBwFcbjhqkGgsfX2EKSIqQaA0I
         fxkjfSky4wXoKuv9aomSnDrbLN/IPmjrRfd7CAtaiOw9+PT9/Tcf9Kxx5XH/IGGy43nT
         Zazg==
X-Gm-Message-State: ABy/qLY89/ipUh3nbdEwvX5D5nOUerL1E5AsrMeGNVXcj2WxhTdxi+o4
        lIp8kpBqom/GOxMq2DsJm/nRug0aWvMbCw==
X-Google-Smtp-Source: APBJJlE55pOio5n2QQTB/3uTco5h1mHg1gy7PvDpsC2F5aQbK2c+TGLDGRZ3/t2QpjE0DYATlKF1wQ==
X-Received: by 2002:a05:6a20:94:b0:12d:d615:9279 with SMTP id 20-20020a056a20009400b0012dd6159279mr535084pzg.25.1688616100929;
        Wed, 05 Jul 2023 21:01:40 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id j24-20020a63cf18000000b00548d361c137sm303913pgg.61.2023.07.05.21.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:01:40 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 2/2] push: advise about force-pushing as an alternative to reconciliation
Date:   Wed,  5 Jul 2023 22:01:03 -0600
Message-ID: <20230706040111.81110-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706040111.81110-1-alexhenrie24@gmail.com>
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com>
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

