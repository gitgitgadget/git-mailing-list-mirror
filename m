Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC8C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBB161006
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356301AbhGSRWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377646AbhGSRQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:16:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EEDC061341
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:36:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so13401475wmi.2
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0gA+6c06Ck1dGUqiyXYxQ+5t2XkOrLb/KZ/tsuEgYxw=;
        b=KPBJlmyFGAglyta6oG+sM3V4iq+iCllPrRhh10P73rPDxIcg1RhVZBnijcZGfBSswt
         dj4PPuf0pAiDBNp+wIecp/Bv13PQTiVzyh4b30hPSc9J+Ags8No3SRBIHWeTbCDtulsN
         pCJBJjkuwqvWtpKRxp/VECXPEvogAoPZa6BVdQBPf3qJyGKEejJnrJzNB9bM5YBPEw7y
         ESHFtbmd8uRQYNC79RvGUhT/6gl45gMVzRUvkaRCLsl82bBteJBR+Qj0A088nI4sk++7
         bUZKAnqIZyepp+kLBPHEqx6LfXT5IOuGrnOEoZ7IhYtSh5tZ3XarF7KYmkGrS/ybgCER
         Io8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0gA+6c06Ck1dGUqiyXYxQ+5t2XkOrLb/KZ/tsuEgYxw=;
        b=oAFLcVeMKtxByQ3DZ9+bS1m+T4GWTpw33tT9Hy8RZXoXEkLtJ9ZGLYPMz/7TDIsB7L
         ejrUxK7nMSk+yLD/MNAuiwFjav56/wHfe2VRVlb7RFu/XsEbcbefW/xGWYF4Wp3fhcdP
         J41ptLpZ0w9+bWqMX4EeTUQY31L4+7OM1jNct5jii1rAoVF6hQtJNApZ/gb7jr6qGs/a
         py9QB5L6P21F7dWspvcNmFcJYntkj/Pm/dDaouz9xUSi9rjaEYK0LGlDom6tfaey1tYN
         kcu5pqFJDaWoqWaUGfI7YnD1FfJqYwHncUiJipGu1pz1hB6eVTlBPw8Ez2fANgbE2tes
         kkfg==
X-Gm-Message-State: AOAM5305qAGzyPx7l9OLZ7RRbQsrPx6Pjt9N+HGKO38gNibV02BfG7tu
        NsaBALSG1rwOMlgta7rUO2NnFtCM0AI=
X-Google-Smtp-Source: ABdhPJxfj8BZdZkhmhLFksoC4In6NkypMH+smmMosgCYSYjtdd+vp1lfAOgg/Kea7/wD0MQnZa5Xvg==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr32653196wmc.43.1626717203500;
        Mon, 19 Jul 2021 10:53:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm5288707wmc.12.2021.07.19.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:53:23 -0700 (PDT)
Message-Id: <pull.1053.git.git.1626717202616.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 17:53:22 +0000
Subject: [PATCH] refs/debug: quote prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This makes the empty prefix ("") stand out better.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs/debug: quote prefix
    
    This makes the empty prefix ("") stand out better.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1053%2Fhanwen%2Fquote-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1053/hanwen/quote-prefix-v1
Pull-Request: https://github.com/git/git/pull/1053

 refs/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 7db4abccc34..1a7a9e11cfa 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -232,7 +232,8 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
 	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
 	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
 	diter->iter = res;
-	trace_printf_key(&trace_refs, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
+	trace_printf_key(&trace_refs, "ref_iterator_begin: \"%s\" (0x%x)\n",
+			 prefix, flags);
 	return &diter->base;
 }
 

base-commit: 75ae10bc75336db031ee58d13c5037b929235912
-- 
gitgitgadget
