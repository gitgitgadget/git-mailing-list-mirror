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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43958C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BF1613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEUWim (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhEUWil (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92925C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso19473691ote.1
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmDs9Vqb5zhFDtU71E+DNwzSqZWSR1qVPgovOloFuMw=;
        b=lz6d7sQKwx+UUcAipdQ3nB5BNTh2UJb/79DD5rE0qgxs8wPVGmuG4X4cSagnzeOcP1
         +6sA+MaTcyBZUWqUcOSt44rZuElN2t0BiDvshh2b0uxDMiHkCBSsg8E5BsgNmha1mB0q
         yButU0WjJXm1aYNgQIB2qE+JzrC9saZHQpcWuuypdGL0uB9jMLoxtQFLjHRo4mPUPlnU
         muOjM/LcaoLwg1AbiO0jO5bLVrAqy6P6ZOyTSHjEpSbGswS8sgRrmCYHb2QoQornWkKy
         YiAKEIY61eclafW/c9t+ultiBQwhLpkJFgz6VWptgQVNEPiOSLLQ29+2LdXLcgmoRAUr
         10zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmDs9Vqb5zhFDtU71E+DNwzSqZWSR1qVPgovOloFuMw=;
        b=VONBGNqHcT+FONrRY76zGsUw0k6e6hm/wkyb43gCiV2ViLua2SXtGMKWqy/5fggbxA
         aMjq+NJJHFvsRkglOIfCgo9mHfoLbWvDTWgcgVEd+n4uQbB7sX2sOzQyWqrtAm02F1by
         98luNvp3v5GMfzW2I/2npEhGR+ITjeiAny0Tg4jJGHFmHLTUrHl/KZs/y52lY8iySu7a
         VQyCX8rvkPCnGcYsXfSM0z01k14Q3O2AfHRB0+/lmjWXvGwLJl4ZFB/e25DZelMMxY+m
         TKGvWBYhgoHkNAH2dj5YvDM0VYkT1os9c+VyY4JaidLfE4CoWjVPKRiipRSd9Fr/Dg7x
         cc3A==
X-Gm-Message-State: AOAM533usztKIr5UPwEp6LLjaoumELPxqzP2RcMB6FhVqJZ8BPuh6DDu
        in2AzaYfpcxet3YVXJ3lGYyW+HsnXvMSwQ==
X-Google-Smtp-Source: ABdhPJwri9Lm5lUWS0OWlT+xwiqph79nZVtnIlF+/7s9xckLGSL6DwPtqk7ruFG2hm9B5HI3N1ROKg==
X-Received: by 2002:a9d:721e:: with SMTP id u30mr10305545otj.250.1621636635767;
        Fri, 21 May 2021 15:37:15 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id k21sm1523764otr.3.2021.05.21.15.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/12] doc: asciidoctor: use html-prefix only for html
Date:   Fri, 21 May 2021 17:36:57 -0500
Message-Id: <20210521223701.526547-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is what asciidoc.conf does.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index f998a42249..c77b6de350 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -4,11 +4,11 @@ Asciidoctor::Extensions.register do
 
   inline_macro :linkgit do
     process do |parent, target, attrs|
-      prefix = parent.document.attr('git-relative-html-prefix')
       if parent.document.doctype == 'book'
-        "<ulink url=\"#{prefix}#{target}.html\">" \
+        "<ulink url=\"#{target}.html\">" \
         "#{target}(#{attrs[1]})</ulink>"
       elsif parent.document.basebackend? 'html'
+        prefix = parent.document.attr('git-relative-html-prefix')
         %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
       elsif parent.document.basebackend? 'docbook'
         "<citerefentry>\n" \
-- 
2.32.0.rc0

