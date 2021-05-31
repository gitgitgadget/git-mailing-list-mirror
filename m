Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23182C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B6060231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhEaRlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhEaRko (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04BC068EFE
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c3so11516825wrp.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vKr65b+on4TR/vJaTuuFSTcpoTqJKotIxNl1EpLZOMw=;
        b=h3SJYN+zjwx2jMnsEy1txH4tu/+UdTJgGLILR1G/rBuKT+8RRvCVlXAKgpwkM9AAqc
         YIamhfowZ1ca/wa83x5X5fY8qWtYANrDZEVqDDOTsBUh7jND55u/tTKF7R+Qkx47lHHc
         LqztOfgTIHq7E74LKnEmLdKIRELlHRsif1gxAq2kkvhCr/ahZ9mFbZNhcdQ1F7qotJUu
         z6l4DGug4iwF9rlHbZ6TUVBx247N0FarbPYZnUi9h0x3piZGTUdBdipwaFeFfChddhFS
         Qkd672dQs0585t59s1rDHJQkVPsqXqRpwvIWMycIgsMGJ2xwIJjLDv+AVyThO1vIdmGl
         JZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vKr65b+on4TR/vJaTuuFSTcpoTqJKotIxNl1EpLZOMw=;
        b=GtgVnqg3Bf/FDKbnml0MvFHBUee0SoddXDFCLlExCEk7nA6UO35WTlPWQO4wjpbiTK
         qI9dxv/9env/QiIbv2u1jrCttBFfjmE53SLd9QR3U7nFYRHElpMJ2z7oRzZlquF8L1DG
         8tovzg2TURQUGBRF57RaRGIMgPyga9o/L7dpDKuq62wE0nSD0vjAn/NOyCwVfBNMqgKy
         WCFnesOnFsMrMVAVSfCDPqcz1zGEr8xB348g3U6uSPzb13nRc8hsu/tCPRmF1RI6nRnY
         zMKHy4LtJFZl8B7M/ANxoE+24Ye9aWNHbOYpQA6q2ynOub6gMX+YDjO7Fx4gjx5nmrHz
         ys3g==
X-Gm-Message-State: AOAM533/dnwb6AuOQzVdMXMBeH62/krwo1pGAp2R61KzO2YLdPa/96BF
        eHB85iAmQ9UEsUAE8oNssMvF7NLo/wY=
X-Google-Smtp-Source: ABdhPJyW0SDlLXN03MZ/rLh68PtM+mQjXgAjHiLKP49Zr43NlgpAvdY089Z7M+6ht6T4jVclTawbCg==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr22567407wrs.213.1622480200498;
        Mon, 31 May 2021 09:56:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm250132wra.60.2021.05.31.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:40 -0700 (PDT)
Message-Id: <7c6ef1dcadfca62081c4b55b78c53bf1d5ae7fe7.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:17 +0000
Subject: [PATCH v3 02/22] t/helper/ref-store: initialize oid in resolve-ref
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will print $ZERO_OID when asking for a non-existent ref from the
test-helper.

Since resolve-ref provides direct access to refs_resolve_ref_unsafe(), it
provides a reliable mechanism for accessing REFNAME, while avoiding the implicit
resolution to refs/heads/REFNAME.

Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index bba5f841c6ab..b314b81a45b2 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -118,7 +118,7 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
-	struct object_id oid;
+	struct object_id oid = *null_oid();
 	const char *refname = notnull(*argv++, "refname");
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
-- 
gitgitgadget

