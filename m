Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5ACC47090
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637D361222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhE2HrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhE2Hq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:58 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A3C061760
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j75so6666610oih.10
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNGxtTHrXhk1qF+aVsp+4wORJp4iaEyikU5jiM0MEkI=;
        b=og9UUzVmHbX5nT4aVTmhdgk6jzeU/o03yNm9rhYSQrh6DFKlIO0l1z1BNwzxTudTZ6
         pE7KT3wgMtpL9ocv2qMKZ/fwZrrjiEPPsqfTeR4d9iD2IecK0GoY8SkU5mfELXqYx6XN
         n0a3nUWSvz+zv82pqn8yxduqGUBxIsQc/RA4dnqytnHxykgAK+udqn1BD/TIDDRbR0PB
         PXSA4jMb5JHOkppt2ip+iOIGBK1CINxVFBwdFbZGrtIsx8Cq0MAWy3RzjKoQuK+paFKg
         u3/Q1RC29QHTipnMm5oeAhHm+5PGeWJgjR8jI0WvUgY3h1Vw5VBg2Q5rRkdFEgc3o1dJ
         yy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNGxtTHrXhk1qF+aVsp+4wORJp4iaEyikU5jiM0MEkI=;
        b=N5rkjHP6XVucEvhogMbB/H+v6Gk+zfhvWBVcSkUEuCYAIorJRxoenRh2ST++FHNiej
         pvAUvHQ1AzaFg+2gIKzftyFmp8Ubd1rnjk0nYSuclB3M849YTp81sIlp+ncKn/TeqK2k
         C/ysGJN30udrSgYPZX64Yl8Tzt2JS+3VdKkHfC1iGazzgKNsJHCbo2fINHt0AvMpTRWY
         GWrwsP1oFJFiis8dY33kMYGkPB2JGnQMh1JmqHxVOhXxowMbjIN/2CkNEhIWL4SH6uSD
         oK4vi02tpew+GDTwNdU+Ld4Sour8N5l+GgjKrufYM9GaCsa8BDXvhlKevcu0Qe1Aasz1
         GVYA==
X-Gm-Message-State: AOAM531m2QQnUah0Mh6qxpvDhJEor08zHbGU6Gg/dzCm86GyYUK6/64x
        zg19HCROyjpHG2QpJrYAXhtrWF3pyNx0qA==
X-Google-Smtp-Source: ABdhPJweEo0N7Ap8m3fG2RDivu8SX0vvSjqPDtp/LR+ECoY+h5LlKOvRtan0/LLT4dOTJidvpi4PGQ==
X-Received: by 2002:a05:6808:1414:: with SMTP id w20mr11274702oiv.136.1622274316281;
        Sat, 29 May 2021 00:45:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d67sm1559426oia.56.2021.05.29.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/15] push: fix Yoda condition
Date:   Sat, 29 May 2021 02:44:54 -0500
Message-Id: <20210529074458.1916817-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to check if remote is the same as the branch remote, not the
other way around.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7485522807..468ccc1067 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -204,7 +204,7 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 
 static int is_workflow_triangular(struct remote *remote)
 {
-	return remote_get(NULL) != remote;
+	return remote != remote_get(NULL);
 }
 
 static void setup_default_push_refspecs(struct remote *remote)
-- 
2.32.0.rc0

