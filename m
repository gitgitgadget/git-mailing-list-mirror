Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6EDC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791196108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhE1UL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE1UL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:11:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E67C06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:20 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p24-20020a05683019d8b0290399e8a3aa60so102991otp.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UWKu6cp+G2Etnoa18VCXade1cftECju3TqEKmznjBM=;
        b=YQnAHys36V7a6O5+g+piuiilIjbaw+Al8X0/2J5eLKFyJB2wu5qR/ZFCr2himWAw5l
         +TbhVNcaClcaqldAD5GmKJmERBJtVXmcLPq/suXWhmc22Uxw0xOs7O7cqABECHfdvlah
         hioWtRxp6P7MyEV+4p3xqPs64N4jAJ7OqJ6JGfNZkq7Y/MHbbKWxhf0bat0ZHn0RWOq7
         BtTx4pIWn7RijzI1AJJxR7ZILK9OjCxoIWDQsaFrnUANAFabilUpmqI2IPePV06F15oC
         5UkzVT45+vS/lgSti2HInDkRby9MHv0i8w1Ud+cXMHW3PnE2PHnOG8MF+np9/T1I+Akn
         Q4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UWKu6cp+G2Etnoa18VCXade1cftECju3TqEKmznjBM=;
        b=B1UAZVs7X1bpMfBjLnl3j2o3Ar9wJMAnx3nSu5vK2Fgbz3zZUxKhWQceGoOq6MZfuo
         9JksY76y/VaiFO9DoUdOThp7rkaWDALIMWOiP2Z0tZ10bD8mgtj2wN7Xs4JqSG3/dGO1
         hXTS3oh8SopEkk9zryFvY9IJKs9rm0Pyavku+bBcGfxK++lmuo4QuHrnrnJgNm1hSSrR
         rSOlaCvWlF8pDHvbPSu+Gfo1AWBylt2j9LwsrM0DlFJQfo7t3Z2DGMuE0PujB9o907+2
         FB1wKYV8R0B770Y7RKkZdUyyv4wPBK0VncWzpXtqydGNvh/f/9Bxf1kkpERKMbUbvD0s
         Wt1w==
X-Gm-Message-State: AOAM53360QwZRu+R0U9aiyCsSQTJiDrmseUjek+me5bPsm3EUzrTIdVw
        U4BIOi/NZqHkKLCYmrnFlchCLyxnkZ5GLA==
X-Google-Smtp-Source: ABdhPJwtgyFAgaVZvC3NGi28odRjEaHkfDoo7r+FyTPjhnTUN3EZbxRfoFd9dD8aEr1cYGLBJtMYTw==
X-Received: by 2002:a9d:459a:: with SMTP id x26mr8333746ote.337.1622232619743;
        Fri, 28 May 2021 13:10:19 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z6sm1328273oiz.39.2021.05.28.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:19 -0700 (PDT)
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
Subject: [PATCH 02/11] push: move code to setup_push_simple()
Date:   Fri, 28 May 2021 15:10:05 -0500
Message-Id: <20210528201014.2175179-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid doing unnecessary things and simplify it in further
patches.

The code is copied exactly as-is; no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7045e4ef0c..d173c39283 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,10 +225,38 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
-	if (triangular)
-		setup_push_current(remote, branch);
-	else
-		setup_push_upstream(remote, branch, triangular, 1);
+	if (triangular) {
+		if (!branch)
+			die(_(message_detached_head_die), remote->name);
+		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+	} else {
+		if (!branch)
+			die(_(message_detached_head_die), remote->name);
+		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
+			die(_("The current branch %s has no upstream branch.\n"
+			    "To push the current branch and set the remote as upstream, use\n"
+			    "\n"
+			    "    git push --set-upstream %s %s\n"),
+			    branch->name,
+			    remote->name,
+			    branch->name);
+		if (branch->merge_nr != 1)
+			die(_("The current branch %s has multiple upstream branches, "
+			    "refusing to push."), branch->name);
+		if (triangular)
+			die(_("You are pushing to remote '%s', which is not the upstream of\n"
+			      "your current branch '%s', without telling me what to push\n"
+			      "to update which remote branch."),
+			    remote->name, branch->name);
+
+		if (1) {
+			/* Additional safety */
+			if (strcmp(branch->refname, branch->merge[0]->src))
+				die_push_simple(branch, remote);
+		}
+
+		refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
+	}
 }
 
 static int is_workflow_triangular(struct remote *remote)
-- 
2.32.0.rc0

