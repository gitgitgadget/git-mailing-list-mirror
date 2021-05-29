Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6319CC47093
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0D86124B
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhE2HNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhE2HNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:13:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CA0C061761
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:25 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id y76so6622833oia.6
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCVlMZmaZD9qdqc84YY4Mycvu+XQsMSNAHihq6hja7o=;
        b=OemvcyPlBML11Kb0FkV4r6a65kdwZEM9NCI5+mlCC6GdWoWoJX48t/8DW1aFCqI69D
         fXKs12axUDPdzYOMOEm45sdUzfwnYCCpPbjC6jkos/Zng3KluZjvCOMTvG1Nk0LD7mP1
         iS4UYCK75/FvySAo82pFNb1XwCL36arfzib8//nMGCefLwQyS/3dPSUdNVfexyt5mCUV
         6P+VvDgB9Pf1SLfbQ3dH+kJAT3wSk1GLf72PCSWlRAWhIffU2VNRWoaV6GUICZIgyHj4
         PO3U3kZflzPXC6IWulT589ASEcYUoLbDRmkaek8q++ji3sEm6Jr4wcY/icGaOASiy1Rr
         nfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCVlMZmaZD9qdqc84YY4Mycvu+XQsMSNAHihq6hja7o=;
        b=HdLKtQ8I0Rg1Qt8xAXcgykC4lS13BuXqCaMBU4L170pA1vqdqbRc5Ruy5lOemkp9fE
         vqFf1X0JfWJgZyv/iGpmcwm39OmzYHUfvLTpUEx7jbiPtNQYDrUPAxPCYemIrGqIuUo2
         F2tACk11qd+i4DAZPNrXeLLHkJJ8BuM1jeQabtNqm8UyanFfYAVufj6Ef3Hf5veVR8r9
         SIGh3HXo25Si1bSfvKxAEGXqd4JjBx2Gmz1CpyGqjNFHitxzASnTZUg2Kj61uZrjek2d
         XsCZsJN0IuHwvr9ool7kYW4DA1inNbQPn5Atd8d038JkaqSC/BqtOOxQLuLzvTFLaJQi
         MFwQ==
X-Gm-Message-State: AOAM531E1rog4LkFOISQBl5U5k90oIsvU9xx/MKWCWJna5OT40lZUIIZ
        V5ltl+KvsjshzRSRNSXtcENh2ghhDtSh/Q==
X-Google-Smtp-Source: ABdhPJyjOyZ/P4buStLuFLB9BpSr0F7i9/9Ie2oz0W48SQQpeo8i4VJmylhZUTbbXaCzsW+Fo1BzXw==
X-Received: by 2002:aca:c6cc:: with SMTP id w195mr8336147oif.83.1622272285127;
        Sat, 29 May 2021 00:11:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o18sm1620280otp.61.2021.05.29.00.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/6] push: remove unused code in setup_push_upstream()
Date:   Sat, 29 May 2021 02:11:14 -0500
Message-Id: <20210529071115.1908310-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now it's not used for the simple mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 73fe083682..0961826269 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -186,7 +186,7 @@ static const char message_detached_head_die[] =
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int triangular, int simple)
+				int triangular)
 {
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
@@ -207,12 +207,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
-	if (simple) {
-		/* Additional safety */
-		if (strcmp(branch->refname, branch->merge[0]->src))
-			die_push_simple(branch, remote);
-	}
-
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
 }
 
@@ -271,7 +265,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular, 0);
+		setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-- 
2.32.0.rc0

