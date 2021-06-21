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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8033FC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DAB60C3F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhFURBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhFURA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDD6C061768
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so18382585otl.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSpY4rrSAldk6nX7Pwkxsvdujt5vODKYlbtF97lHXFU=;
        b=qvB375+nI5i20SdDc08FFz6bSfL7UPiXhREnb7b18+XiCzSkO8n3XwJPnbRgoEK+uI
         pRSMufl8J/PmeJfycfWv/NKhQQEH+K0Hmx1/jPeWubR37IWFOmDGz7bCKmjjfTn84g+0
         DUzEcW4EqvUCVVP87heDm/hmItLIpRM29mXJ2Tf7Iy/NYyhqPXGWCvE1p9a6P5EEuBKe
         60hxF+d3DdbGyg9YE44k2dMKRquoWDbI2gizT5pa3KUsm8tfxTlZbKxkEs3pGBDQeYso
         zAtctWjWtuypbTdNg552URoHsLrZ77ZRZtl9D4U98g01Rim+eBibXqhQyoJPXzwF8VGd
         0wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSpY4rrSAldk6nX7Pwkxsvdujt5vODKYlbtF97lHXFU=;
        b=mmrm8OFUTZdOiwGkpq2vo7GOAugmFyz0zqj3KTphgPjzV9rSeiTHJHFPo+l9+W8RJo
         5Qb07MK9PlwpP3Bf4tb5r6IxC1Gc4/ExvkGG8z+zLkj78aavIx/QHfN2pkmUdVrO2N6p
         qBOt3VlhhjB/COwwsEakQjPIhtvcu7iHrky4vbs1mZ/8/TXduyqj4+t/3lcoUyzGGPqe
         1+D6F0S3gyynZQPy5NxUYleQqtSZDRtlNzYLNK3KJDh3o/wPkcxggeqDHYQZ9CLwikG7
         AY1xzdZ7ZuUczsPEoM9TQoO2FXCVzpr/htd7nyLXE99G6TlZ4kFqpRh6jJssbjll8Zak
         cM6A==
X-Gm-Message-State: AOAM532tqNQisf8HMEHL2j3VHl6KnYnYeiV55dio/IT4v+6R3nzkVKZ+
        q8X8grXywadz0Wo6w2VY30DQh/92mlVP4Q==
X-Google-Smtp-Source: ABdhPJwInjzXwCd3y3iMw0v3OeOTWiwAoZT9oIlE1XRfmaTUJ5a+A7gaJWwexJQIBZlGej8ThZNo+w==
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr21183559otq.73.1624293095435;
        Mon, 21 Jun 2021 09:31:35 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i133sm3601998oia.2.2021.06.21.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/23] doc: asciidoctor: use html-prefix only for html
Date:   Mon, 21 Jun 2021 11:30:55 -0500
Message-Id: <20210621163110.1074145-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

