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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B67C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76D4611ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhD0Kjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbhD0KjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD24C06175F
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i129so4567288wma.3
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QN6IoYgsXRlIFjD2anwV4qxoUNjIfgsLOwgcYKTrNEo=;
        b=laHofaR2gmlwridBAm0TNnrmT2A7ijz3vg11r38p4TRknE0YkCJ30cveOSzoWKAGrh
         fj16JhfLhN9juowEVKNWzU9s2sNGlKLzLg0YhZcEiy8u9PmXAZaDlZUwnsVo11tdxxmp
         2H6vvuHwEVBY6nDFFSU4rUOjmaqlg1J3GXLdfEckKxlqymfrQuFf4iqD0jhL7sHBmCwI
         y2OP/KSCdx+r4FueMgMUwDvcciRbSTcQBh4YqltKXGrug+qylA/MpVRFrd0E3VtwH8/I
         wsooFuRa8QTMUMzWf7ZAQDygYZ0JJJGIgl1wrOTwQYr2k2N+m5tvBSe8dVJa1h23xbAe
         tmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QN6IoYgsXRlIFjD2anwV4qxoUNjIfgsLOwgcYKTrNEo=;
        b=qW5GBTqQpdxu6SKLDD1j25WSsaDW4bQ+JBVFEZ/yPEhCHBpKrN1uT7HG59zPOTIhi4
         qyw7lFhAT5+edHF3X0Arje+KFrO+YxaVYJa88N5f2I3epjU20icY71YZ/8sMA7fPNxPh
         N9jsi8eaVvyc0ACPHBfcbNAzufKHpkPqIsKfa2rxKvaB872yt78ODmUgevtwamiyS7w6
         NAuk+5tA5uzBf4yf1yMX6bU5asZp3LjG8+nKWhvLJKwVk7WKQ+j1gphKVjCXv7XENh+L
         Et1run3y4Ke829r/c/KrGpusDpJU3zHT6+D4mO7jqhGiHa+jkjDKyws0mpMcjjEyO/nz
         h5uA==
X-Gm-Message-State: AOAM531T4eEtr1QP9NtbNq3IIeVR0u9ja4Ud8Ts95f5gaMMJCJpMdwQR
        kic6FVjv/6S7/a/7/lEs5cmf7jWDoOM=
X-Google-Smtp-Source: ABdhPJwUS5UXMC+2cbG/xIj37p3KKVwksmeTmSMW8G9/8RJOpcYcF20e5lFEq1Ew9EX8afQgiXAvNA==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr3612406wmc.100.1619519906170;
        Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm175261wrt.51.2021.04.27.03.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:25 -0700 (PDT)
Message-Id: <e6222944a3eb441d44ab6c7d1e9b873f5546220a.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:03 +0000
Subject: [PATCH v2 02/21] t/helper/ref-store: initialize oid in resolve-ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index bba5f841c6ab..01d8f3285dc8 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -118,7 +118,7 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
-	struct object_id oid;
+	struct object_id oid = { 0 };
 	const char *refname = notnull(*argv++, "refname");
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
-- 
gitgitgadget

