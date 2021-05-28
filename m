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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1E6C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765F96108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhE1UMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhE1UL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:11:58 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBBC06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:23 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id j26-20020a4adf5a0000b029020eac899f76so1208919oou.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6E3jwfyxvztmmKlwDcEESjllAMSZL66YuaKO1v1Tr8=;
        b=TeErNd7g83EgF8GwNuLMrdMKW3Xa1H2a3BYdxiCluh5vAltYVe46QFKU7ymGEtvylI
         zgEyyOM6HVzcI2Zv/HqIVNjQeWhvvNQkyP/ifTmgIpjWfVYugQkTZIoEac18wIWwxecT
         KB8KxChjvf0f9hCkDEqz7yyedU+Q5gfzPg+2D4WWEKxiHvr3Jz4wTBi0B17OvYgqX7fL
         VVdRgWmGx8J22Ra99oMWPNuf3KlnrbcIBAMKQ8qEwSbn08jNIXHqXV5qLYZDucfMe5cK
         TPYCNYJv96tQsyrTIl/j9gFEc+OySV4otXLSmOIL7SBUriPtEGwCvZx+KiQhGZY67upW
         Ar8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6E3jwfyxvztmmKlwDcEESjllAMSZL66YuaKO1v1Tr8=;
        b=A1YQDGa6UhFRX0PkrOrCt87/eAWJ06zpggkmykGgUz6O+eciv5guPXfPqWV6Zw5ehH
         pJGIgedCiNyI9X/ctT+aziARkj9CvmNB04HedrLPyr2VwAOO90c2Z6nVeDOrs61rKbSb
         fvPnVLgZv2t6ClurGjzrTFZYKKMuo8X2eeV9sWnC0XerLxhsPI/fd+C0ZEgVdjkjAAf1
         9oEkenyyaSXuCQ89CjkFT2Gq10uvS2WnUgxXPy0518A+kSpYyYIq6eupnxtk2A+rTgt5
         mVWykf7CwtS4gdSc+QXUunHPB5AlGSmEejHWwT9i+7SsAuUsWlbEQXT9uPtlIfxfuS6/
         ErCQ==
X-Gm-Message-State: AOAM530DA/2q4KICKpYqC2fh50L3FDovfif78Ooy5iF5v2QeSfSNAbx7
        gpC/0fAdwdp/Qi+OoiAPSH/R2LsAgJKxuw==
X-Google-Smtp-Source: ABdhPJy3M45mQs2YraIrGsmISFcqAvZaJk6F/2giBfSrSQ4fKBl3PxlUaydtUnm4V4FXBQOBPQCn1w==
X-Received: by 2002:a4a:dc4e:: with SMTP id q14mr8430093oov.43.1622232622645;
        Fri, 28 May 2021 13:10:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c32sm1291284otu.13.2021.05.28.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:22 -0700 (PDT)
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
Subject: [PATCH 04/11] push: simplify setup_push_simple()
Date:   Fri, 28 May 2021 15:10:07 -0500
Message-Id: <20210528201014.2175179-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch->refname can never be different from branch->merge[0]->src.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 9c807ed707..73fe083682 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,14 +225,10 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
-	const char *dst;
-
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
-	if (triangular) {
-		dst = branch->refname;
-	} else {
+	if (!triangular) {
 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 			die(_("The current branch %s has no upstream branch.\n"
 			    "To push the current branch and set the remote as upstream, use\n"
@@ -248,10 +244,8 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		/* Additional safety */
 		if (strcmp(branch->refname, branch->merge[0]->src))
 			die_push_simple(branch, remote);
-
-		dst = branch->merge[0]->src;
 	}
-	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
+	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
 static int is_workflow_triangular(struct remote *remote)
-- 
2.32.0.rc0

