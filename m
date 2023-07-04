Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697FEB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 19:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGDTsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 15:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGDTse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 15:48:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159CC10CF
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 12:48:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668709767b1so3180950b3a.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688500113; x=1691092113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZRFVJJ9dt03v8zmZtRj+gUeEXMClaX5WxUe8HzgvKY=;
        b=olYhEF5vq5hCNrTjsWxLEXo7pMYAYmmLdSs7f0HcHm/NrDTkWufKbTFwWE7XW0Wq2C
         SIeq2S/mgu1gbWZTxPEj8Xpi77Q9Y+vFJyPal5OBKFiRFQVctz5LmOdlu8R+CJojFriu
         aV8ykfxqpPy2GqqRe93cpgX98Z8d65T6o2uzCN36HnvXdtqzkn9Z8TVsRj8e+DmtN8hO
         ezMyCLbpfXzSeuEFr+KK7iSEK+CN4om9Glkq3KUDFpIWBWMPiL24gEfxD+Y7ap3aZ2cQ
         waxTbZNcXT5lDHSUz18tOvq0a4VfbqBQdyFgG2C26lbRzqc3Ds8IneNpRrAfewXk+krW
         2ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688500113; x=1691092113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZRFVJJ9dt03v8zmZtRj+gUeEXMClaX5WxUe8HzgvKY=;
        b=hm3aIh6I56NeEYxfX3tH30OJzMwmC8LzRloVnElELzkOd58c6DmgwN/dBeCMwpvdgt
         Eq1aWXAJzVg1vW1YRnQUR3ZOBjIdxa7s/Onnrp+fDDdSzH/3CIIbx7zVqm0XMsMV01Bb
         oT1xqZYRDAOfS+4cFt1rKTreeJIu8c/DNEqYxA3gGiFpBw+GJ4cobfnq3nnp0+J+RceA
         zFKEqmo/dK1UcZ4A/xQE23pI005YNVtAZI9Swq6VLbw7JLTCeaMNoxMWaalASoMpX7AP
         BCA7rLzAownMs0YoO1E35m5evWDoznGUyTRhWupj1keBILGnxTZzBDVsVK9THMtV4FoA
         U2Ng==
X-Gm-Message-State: ABy/qLaaIB1guEx7KoMivVtm0g4FV27AHFzXP3s1dvYQVy4FvCTZoAUE
        aro3tBVpd5mQd1mA+wZGJKNbtNbeedmazA==
X-Google-Smtp-Source: APBJJlEclTLvaK7u97QrjMsTgEmC31s0pz76XSi4HcNjoGoWWZYiZFIWNejUPMZ1XhoakoMl7/BFkw==
X-Received: by 2002:a05:6a00:2e2a:b0:67e:5edd:e6e7 with SMTP id fc42-20020a056a002e2a00b0067e5edde6e7mr13651033pfb.9.1688500113092;
        Tue, 04 Jul 2023 12:48:33 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b006579b062d5dsm9952938pfb.21.2023.07.04.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 12:48:32 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 2/2] push: advise about force-pushing as an alternative to reconciliation
Date:   Tue,  4 Jul 2023 13:47:47 -0600
Message-ID: <20230704194756.166111-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704194756.166111-1-alexhenrie24@gmail.com>
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
 <20230704194756.166111-1-alexhenrie24@gmail.com>
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
 builtin/push.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6f8a8dc711..8e70046304 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -301,21 +301,25 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
 
 static const char message_advice_pull_before_push[] =
 	N_("Updates were rejected because the tip of your current branch is behind\n"
-	   "its remote counterpart. Integrate the remote changes (e.g.\n"
-	   "'git pull ...') before pushing again.\n"
+	   "its remote counterpart. Use 'git pull' to integrate the remote changes\n"
+	   "before pushing again, or use 'git push --force-with-lease' to delete the\n"
+	   "remote changes and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-	   "counterpart. Check out this branch and integrate the remote changes\n"
-	   "(e.g. 'git pull ...') before pushing again.\n"
+	   "counterpart. Check out this branch and use 'git pull' to integrate the\n"
+	   "remote changes before pushing again, or use\n"
+	   "'git push --force-with-lease' to delete the remote changes and replace\n"
+	   "them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_fetch_first[] =
-	N_("Updates were rejected because the remote contains work that you do\n"
-	   "not have locally. This is usually caused by another repository pushing\n"
-	   "to the same ref. You may want to first integrate the remote changes\n"
-	   "(e.g., 'git pull ...') before pushing again.\n"
+	N_("Updates were rejected because the remote contains work that you do not\n"
+	   "have locally. This is usually caused by another repository pushing to\n"
+	   "the same ref. Use 'git pull' to integrate the remote changes before\n"
+	   "pushing again, or use 'git push --force-with-lease' to delete the\n"
+	   "remote changes and replace them with your own.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
@@ -327,10 +331,11 @@ static const char message_advice_ref_needs_force[] =
 	   "without using the '--force' option.\n");
 
 static const char message_advice_ref_needs_update[] =
-	N_("Updates were rejected because the tip of the remote-tracking\n"
-	   "branch has been updated since the last checkout. You may want\n"
-	   "to integrate those changes locally (e.g., 'git pull ...')\n"
-	   "before forcing an update.\n");
+	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
+	   "been updated since the last checkout. Use 'git pull' to integrate the\n"
+	   "remote changes before pushing again, or use\n"
+	   "'git push --force-with-lease' to delete the remote changes and replace\n"
+	   "them with your own.\n");
 
 static void advise_pull_before_push(void)
 {
-- 
2.41.0

