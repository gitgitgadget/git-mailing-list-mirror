Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91358EB64DD
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGBUKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjGBUKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 16:10:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E411BCD
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 13:09:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so136734a12.1
        for <git@vger.kernel.org>; Sun, 02 Jul 2023 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688328548; x=1690920548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0wikYPxhqmtd1gjY4qi1CRmOqoMplLxkpvwS1Ihiy0=;
        b=Yx8v3WWCeSCcO+U6ub/JzyuUitZX9lPiOpjfcya/9i7GlVurk6l+AI5BtsRNOX8lxm
         UzIpj+p1W+cJN1Ey3OceDS7DOcjPRT+5CXtQJDVCrDOJAB7mFEmjY82aHGrx4RacBx7E
         P9JLv91JmFOR6+ygI6r1YkgeGR5wWIeZmm7gvoprcwwcJivBKfQUN6yJWzex/nNfgZu/
         yuE0BIT5t3Ua4rN4aOOtKXJm+ULdIBrBd56qMDjKL8tgaPbZl4z2NXUPtXo7Tx6p8gG/
         yHMDKwvSF4IvNpNcU6UGCd7F6eQg44s4Fs8Z0Yu10tRYaIWjidI1JXPO1vl/O4CwTOgG
         Kdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688328548; x=1690920548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0wikYPxhqmtd1gjY4qi1CRmOqoMplLxkpvwS1Ihiy0=;
        b=TnDsLrOn+Gr+i/RmHs4rGbKhzrh1ow43fOxlqU6dwuODvCJuGZDkm5vEbyOypdmj9I
         HE8qqjaX1/sf/bwQ5n2ymoe9KPWBl0+aHbsxED1EV4RY54YF15fHzkh9voznhPc3UatO
         K1TXVYOCJ7B7Vd3iWiYtzHuYFwXsuBBA0xsy5ft14ObIRGaBoc97AKZUXFGxwV6hGZQ1
         io3GFbFgl2g4j57FwrVJXRRRupzmmPa+0TDCePahSShEyQHcptzz+D2cqqqDGSZGkui7
         Qbvwct+jdV3DYeMIaDumzOAfm/27ohCNUMG/XMDaS0XIhsm8fCtj+MVpO0qX7ZZUR7Gr
         aBXg==
X-Gm-Message-State: AC+VfDxvARkRHEdTKS/tUoc2SckQLlyeG5zZYKck0maoYd9HPyJi62kK
        PVL+HBHY5r9ItqmMHF2LcDuuAccbXQc=
X-Google-Smtp-Source: ACHHUZ5on+aFmPeS2k98UsIbAUFL5T5t7xbzf6xixblk+/owm6swqdQEtt4MXtWt8RLW9gAu59RhQQ==
X-Received: by 2002:a05:6a20:3ca5:b0:10b:bf2d:71bb with SMTP id b37-20020a056a203ca500b0010bbf2d71bbmr13675453pzj.27.1688328548344;
        Sun, 02 Jul 2023 13:09:08 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id c14-20020aa78c0e000000b0067b24701daasm9342937pfd.86.2023.07.02.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:09:07 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 2/2] push: advise about force-pushing as an alternative to reconciliation
Date:   Sun,  2 Jul 2023 14:08:17 -0600
Message-ID: <20230702200818.1038494-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702200818.1038494-1-alexhenrie24@gmail.com>
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
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
 builtin/push.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6f8a8dc711..9441c71bb0 100644
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
+	   "remote changes before pushing again, or use 'git push --force' to\n"
+	   "delete the remote changes and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_fetch_first[] =
 	N_("Updates were rejected because the remote contains work that you do\n"
 	   "not have locally. This is usually caused by another repository pushing\n"
-	   "to the same ref. You may want to first integrate the remote changes\n"
-	   "(e.g., 'git pull ...') before pushing again.\n"
+	   "to the same ref. Use 'git pull' to integrate the remote changes before\n"
+	   "pushing again, or use 'git push --force' to delete the remote changes\n"
+	   "and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
@@ -328,9 +331,10 @@ static const char message_advice_ref_needs_force[] =
 
 static const char message_advice_ref_needs_update[] =
 	N_("Updates were rejected because the tip of the remote-tracking\n"
-	   "branch has been updated since the last checkout. You may want\n"
-	   "to integrate those changes locally (e.g., 'git pull ...')\n"
-	   "before forcing an update.\n");
+	   "branch has been updated since the last checkout. Use 'git pull' to\n"
+	   "integrate the remote changes before pushing again, or use\n"
+	   "'git push --force' to delete the remote changes and replace them\n"
+	   "with your own.\n");
 
 static void advise_pull_before_push(void)
 {
-- 
2.41.0

