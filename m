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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B5EC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9891F61057
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhEaTxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhEaTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21CC061342
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:45 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so12051417otg.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6URlOP1ONBZ6Vqo+XShekSQNy6aEwQTFBhGxFSlmDVY=;
        b=cGrG/oZgBME1ma4PSJ5AREeT63Hadn0meBRoEZxiAPCpOVL9r6PzvFnC3B1nEiDmIl
         36IxjNuYZU6o/e96gNSqxKTy1UK2nm6guAYVsTvfNyukC/E7GTZn9rEMxReSO3oRnywx
         UDrwDonMNjvFopMLVzmfJmBorUPB0K7HbfrlHCU21nz2Ut2SKjbhNTAFY2jwROk2vLrC
         nG4vdW/44DKsjur6UZ4mg7zYQ4aX8yQYp3f+G6A1Gtckij5BeZeGz3kQYpTrADjOr+gk
         mz89zg9fyTyHwOnp4nMtfOPlkfDXjmQtWlk6OUXoKX267G0ry49rcobmd1QRtixE04gW
         Qp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6URlOP1ONBZ6Vqo+XShekSQNy6aEwQTFBhGxFSlmDVY=;
        b=BU1jQnV3hQjTlBwlPotBH+xBt322OJ9Ul0wxJpJYepFNZGsShtqBwvvB8zFB6K0q5n
         vIxq1xYdP2UHSfjQDErq0QkF7ODNKQDszne+sxbYDsVjy/io8Tct8LzG2tjd945UaE6R
         G/6C3npjK4zbZzfTgw90PEeiZKh9xxp5IgeQTOfm8swgpEIJCD2UfA1a0f3PWeuBF4Ia
         80zwN2iDKmApQ/1uUo2TXtREX7AKSur92ovtSB6i/fP6tmhvDsb8DDxFpRBYaDL5Sy6M
         GWGEmwZhD1rTfdd59gDuRY4VVqZgzPtEYB6e/PSrKgMXeS+kJHPz31zOaGPscqxHPqLv
         I/pw==
X-Gm-Message-State: AOAM531G7reaKW42GyHyI1+DIalky4+zXuDTtPUaWDdiDVu2lmX1rxow
        xCkpj/yUNxDmv3jLI+Ghq0EdoJx9aFdvUw==
X-Google-Smtp-Source: ABdhPJxMCkZjh2RaJgGISatlVNLd1Vd2M9pblEj1s7t/ZYxbIZEufWdb2Zb3S6Ht803kjar2F2b1cw==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr3209687otu.83.1622490705160;
        Mon, 31 May 2021 12:51:45 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q14sm3265785ota.31.2021.05.31.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/13] push: only check same_remote when needed
Date:   Mon, 31 May 2021 14:51:23 -0500
Message-Id: <20210531195124.218325-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index a873f8da92..f3916c66d1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -205,8 +205,8 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
-	int same_remote = remote == remote_get(NULL);
 	const char *dst;
+	int same_remote;
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -226,6 +226,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		die(_(message_detached_head_die), remote->name);
 
 	dst = branch->refname;
+	same_remote = remote == remote_get(NULL);
 
 	switch (push_default) {
 	default:
-- 
2.32.0.rc0

