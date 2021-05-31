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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC5C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E403606A5
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhEaTxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhEaTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E67C061761
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j75so13240900oih.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dM/vcJtcCTnsgieWfjKS9QmxIRDhtjTu4AEpdHnLJ2w=;
        b=IAWPfuR3MPEV3gAsdqFQrzGk//nTGvElOU+c5tbMaqLxi0aRld/Mmh44SEiohDNsTW
         J+urfb0V9HfD48t82gXEB1fKfEroW84OJ57+dbf/DxmINJg4+xwfYgcFkPDUpSA3o5JE
         dsx/AtS+toO51XB5iqu+jkkaHG7fH/2/eN/TN2bZsrRmANtlr4gDtnXB4OagNgoY76DO
         z1gl9s+ASDt2zVheJWBmhKsvIGRyRmyOf3fLW9b1f0s/CRN2vGY6kUbmWRVgiQOw6iKq
         cfuCsnzpMKAGu3zBJ71eZ3k4EGXeknsbagV8dTUZ8QSQItSHj55agEmeFu+uUxjlO9/N
         LtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dM/vcJtcCTnsgieWfjKS9QmxIRDhtjTu4AEpdHnLJ2w=;
        b=Ea2iN02XcdyKP/pUIzA6+v6RfIF/mOXF7Hdp8D7BW77o4euMr9alX+fCbuC8Uw1Oli
         fYLRv68Lohyne7RKDygLHw0mQ9GMWGyZXk7okKYtaZATv2YJar+tYCjUKNFKX+C+unxv
         75qrkNUzZlGqhEAI4karSFDXV4+/pgJ1CpZqCEx9AqyvrdfVq9ZCLub4lNhZj+zJ6q83
         S+29IjvC3uNG4+Eq/eabgLCIDCeqyo4QQXrmwOx1N4ke/fcAOd2a6rLvfI79jjl/eclN
         2KqkjKhkj96ALDdEItwjd3HSCBgpiPBOfCidvderBIJBgXAKsLXmFcjwpXMVGHNrMWPv
         ti1A==
X-Gm-Message-State: AOAM533Te+W/MlFeHkuyqobRSMC8UZ5MYj8FtWJFk10caZQvJOwhCLVq
        nCCvna5FrTuzEs/Ti8eYW4b1DUA4ev/FXw==
X-Google-Smtp-Source: ABdhPJyEgFnjfo6j14j5jH3Cy/i24jOyxOfsvMP+nSFWplroOk+Ayce4EjQkbeNwkwOYxGiIG3E/og==
X-Received: by 2002:a05:6808:b08:: with SMTP id s8mr436258oij.162.1622490692913;
        Mon, 31 May 2021 12:51:32 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x9sm3240317oto.79.2021.05.31.12.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/13] push: factor out null branch check
Date:   Mon, 31 May 2021 14:51:15 -0500
Message-Id: <20210531195124.218325-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No need to do it in every single function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index f64b7100f0..8fcbd2878d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -206,8 +206,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 				int same_remote)
 {
 	const char *upstream_ref;
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	upstream_ref = get_upstream_ref(branch, remote->name);
 	if (!same_remote)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
@@ -220,16 +218,11 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
-
 	if (same_remote) {
 		const char *upstream_ref;
 
@@ -266,6 +259,9 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 	}
 
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
-- 
2.32.0.rc0

