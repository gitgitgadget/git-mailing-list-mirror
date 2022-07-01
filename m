Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D25C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiGAKbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiGAKb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:31:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78576E90
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:31:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d17so2540133wrc.10
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKMBG8ZUg9WAWbr55ZDUV2YGk+lqcOygTbWC8S7UoYg=;
        b=f5fUGu1nO09fayhBoHkexA4JY2rQHtLRhj0r9+YFosVqGez6gB8rBU/Glwu0BLVuk+
         xVeUdjbJ/uxTebkuyvzLuS92yjbuMyFLEeocJqgevhjztjNaoR6VTZQNaRUrsPhoPm14
         svqKX865xiRyIImMXhFkD/zu49B4c17+s7fjpAamDkK8R6UfoopxFdcQgJsOoY5B8ZyU
         3jKgUC7fRhnBnLmEt9WDf0faoIhtZfnfM0/TvoBzTYU5sv/kC4EGF0xiPnz42aXIfxao
         T+wzhudDg2zV4k9/jtltw7axzTXYyOFCHIn+m/JsDUKG7ztbrLnhaNItujxzfrT8qYuT
         CVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKMBG8ZUg9WAWbr55ZDUV2YGk+lqcOygTbWC8S7UoYg=;
        b=Ulj0218FTM6gXYR2vS8Gmr4Kz2VZVhIKBXVfhSHKqGd9AsFfqVugY5wF1nJdPYrBe8
         vmkpM7Cdqjm/DpKq7nHIi5tL/ZViFUzdKQZ+W0ltTKN7UsbnvC9SMQUuQG3SUQuA79Ly
         cn41rea2tOi8y4RSBPqtY5ykKQxD1hiis38GzyKouGS29TM+jhrjFM+J2eGemjYDKtY0
         bgVgxrYsAcQmgNIEWi+xlu/90YFxE783ZcVb6vcf6ySoSowJfQqmbjmmvLzkccd2hk/x
         3kvfOjh2cgBjVYAW53eS1b8EHlA+tPSvLakoVhPeh4DUHTV844vNym4z0kNlkrlA21ms
         7qaA==
X-Gm-Message-State: AJIora/C4mLig81xsx1f9qBmKds5SmUEJBnlQ8n3SY90MQePhw4ktcFf
        VF6gHIvWdMxftvHMw3M4VR3PMhgGtPNwhw==
X-Google-Smtp-Source: AGRyM1vyMyq5JsWcyDlJ/xeMSTY7+m3RUCWxchWBzSbKTXKE+gQmQK2FYVxwCmgv2vnWAdAIzjdwOA==
X-Received: by 2002:a5d:698a:0:b0:21a:3972:7a60 with SMTP id g10-20020a5d698a000000b0021a39727a60mr12638161wru.549.1656671485740;
        Fri, 01 Jul 2022 03:31:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c12c600b0039c811077d3sm9712790wmd.22.2022.07.01.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:31:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] cocci: catch unused "strbuf" using an xmalloc() pattern
Date:   Fri,  1 Jul 2022 12:30:57 +0200
Message-Id: <patch-v3-2.4-6324d3956ed-20220701T102506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no current matches for this rule, but it will match both:

	struct strbuf *buf = xmalloc(sizeof(struct strbuf));
	strbuf_init(buf, 0);
	strbuf_release(buf);

And:

	struct strbuf *buf;

	buf = xmalloc(sizeof(struct strbuf));
	strbuf_init(buf, 0);
	strbuf_release(buf);

Note that we'd also match a strbuf_init() before the xmalloc(), but
we're not seeking to be so strict as to make checks that the compiler
will catch for us redundant, and saying we'll match either "init" or
"xmalloc" lines makes the rule simpler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/unused.cocci | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
index bc26d39b313..43942f3cd4f 100644
--- a/contrib/coccinelle/unused.cocci
+++ b/contrib/coccinelle/unused.cocci
@@ -22,6 +22,8 @@ type T;
 identifier I;
 // STRBUF_INIT
 constant INIT_MACRO =~ "^STRBUF_INIT$";
+// x[mc]alloc() etc.
+identifier MALLOC1 =~ "^x?[mc]alloc$";
 // strbuf_init(&I, ...) etc.
 identifier INIT_CALL1 =~ "^strbuf_init$";
 // strbuf_release()
@@ -37,15 +39,25 @@ identifier REL1 =~ "^strbuf_release$";
 // ... or "struct STRBUF buf = STRBUF_INIT;" ...
 |
 - T I = INIT_MACRO;
+|
+// ... or "struct strbuf *buf = xmalloc(...)" etc. ...
+- T I = MALLOC1(...);
 )
 
 // ... Optionally followed by lines that make no use of "buf", "&buf"
 // etc., but which ...
 <... when != \( I \| &I \)
      when strict
+(
 // .. (only) make use of "buf" or "&buf" to call something like
 // "strbuf_init(&buf, ...)" ...
 - \( INIT_CALL1 \)( \( I \| &I \), ...);
+|
+// .. or to follow-up a "struct strbuf *buf" with e.g. "buf =
+// xmalloc(...)" (which may in turn be followed-up by a
+// "strbuf_init()", which we'll match with INIT_CALL1) ...
+- I = MALLOC1(...);
+)
 ...>
 
 // ... and then no mention of "buf" or "&buf" until we get to a
-- 
2.37.0.900.g4d0de1cceb2

