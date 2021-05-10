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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9BDC43619
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9B7610A0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhEJLM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhEJK6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FAC034601
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so3308903edt.13
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdJ38rmc4h3OspcE3tqBRHJN4DMweqr2IhcLvwhr5sA=;
        b=MRD3TIbIdYlg1dCUby89+WCjqMH+z5JR4hMwsWklPmBWvkYZnccg1BuxWlEvtFkDYg
         PmgpMcq5RQHRE1DfeGNueRhufyD6B4bmLoV8nepkg3jBtOyb7PkIIehLT6tL9bPCBnmG
         vpWyb8eWGIbGCdyI1FNPSLVWhIswwN1PhJTOMRVw52GTS9k4qmt4pBXUMkzPdUqRmYlA
         lg8YWyIGHgqsUr6db5rgg3W0Fuyd0uRV7ZcmJ62VcM4P2aFAVr4GG9gZvQeBd+ztlkg9
         RUtx6QA06Z6HIQXR13QkSAJPd0/bruvjK4NlrFcKotCbEJxBSlxzaSvYyMls8BU6sTc0
         irQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdJ38rmc4h3OspcE3tqBRHJN4DMweqr2IhcLvwhr5sA=;
        b=Le3c5Q8rHh4FVTIvvBBkkl1YvHsT04CFfMabIWx2HGf8quU5NFfwVnHGNqMWI7MB4a
         34EO6LqMvRgMVJIFH7RVYlDYBDk+Vch/VOpya/NF1Bu7jqMdRghiMe2M9ly16KpkgxV1
         zv4aKDIse80tGdtlE8UOKbCznDLtZMP/K3PHU2FhIWXF1ZHnerBcRZ6S8yVx6/uAYhF4
         p7n5+20JIYsyI6ipud1/7VLwo9zHtFmnL4am3GihGUxVe7xb2w9U0cjIwk58SmtlHVIU
         Fu/QgWtQwEBulQkd0xaB2sOWejxwPndfOtpM55KZsnLXMKexJojeCk75hXN9YcY6zBEU
         kzQw==
X-Gm-Message-State: AOAM5300+hpBN5v7VtxqNQckv2M5ktfp0DhhzNbtCN1RciTqmgxSzU9y
        C9eOJiuT5sfHmFmTVDWcXbzwsfAs1XQ/aw==
X-Google-Smtp-Source: ABdhPJxbTQjq446JsQ84TTqNUEWjXmqbxRA8RG2psJo5EDUarm3VoDMhqLTWQ0QLodND768tc+bQWA==
X-Received: by 2002:a50:8a99:: with SMTP id j25mr28188957edj.253.1620643831009;
        Mon, 10 May 2021 03:50:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] Makefile: split up the deceleration of PERL_DEFINES
Date:   Mon, 10 May 2021 12:50:20 +0200
Message-Id: <patch-4.6-2cdefbe920c-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com> <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split the declaration of PERL_DEFINES across multiple line, making
this easier to read.

In 07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10)
when PERL_DEFINES was added only the RUNTIME_PREFIX was put on its own
line the rest weren't formatted like that for consistency. Let's do
that to make this consistent with most of the rest of this Makefile.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3ed6828de67..4f68f5e1dba 100644
--- a/Makefile
+++ b/Makefile
@@ -2270,7 +2270,10 @@ perl_localedir_SQ = $(localedir_SQ)
 
 ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
-PERL_DEFINES = $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
+PERL_DEFINES =
+PERL_DEFINES += $(PERL_PATH_SQ)
+PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
+PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
-- 
2.31.1.838.g924d365b763

