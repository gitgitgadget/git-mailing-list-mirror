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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E20C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FDF6124B
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFHJDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:03:38 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45632 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHJDh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:03:37 -0400
Received: by mail-ot1-f48.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso6604535oto.12
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaDsQYfkMbT/iOJTVoIrfWA9/K4LWKG47YzxXAjIOOE=;
        b=X/UdI6LqUBHK/Z+ixV9JXiXlM7U3GnWzz16kZ6UTWzxSTy1B0TGzVNWOchuQ+0t0D9
         bLd+I+kqJAESh3v3Ae7XWAfUAhwMY+H5244sZw0S/s/bcWC/0e+RkRjrqm2Sg4jM99Ez
         /9KC2rV3xj0Syap2oGKCvdDVKm6Pc14Ppz+0HS3xIC5k9Y8rW2MK6CBIbO6pFL4tfL/h
         oVIz7UG6y0GLUvCK15qeFuFj7r6+GpXje9DmPmFaklafG+ZkYz4a8rPyHScfd7nqMPns
         3wag2aWYtGOxfvlXVFNFnqmMdZ/tvYMHweoS+SlpIqAfe+Hkk63pVOMs76rVPmAiuaQt
         sWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaDsQYfkMbT/iOJTVoIrfWA9/K4LWKG47YzxXAjIOOE=;
        b=iyfra1LbwTlZGuHwpEx/E5dcSQngo0qJ1FHAJAh1lmL1LSYp1lZ1inWOxZUb1p7Bnx
         /LQvx0MMpj1LDXbnVlm0MxpPN4XR9cwD+ACIYdPSpE1OCl2r2jhqjVAwLUuaSG2A2jcc
         wHDPo8kLeQLHWzu3nJGUbq6Jr9B7FUO1351y3Cse8W2Td07lyBOFCTij6F07bVOrcCAQ
         4PfY7yu3MFNk8J6iTiFwluhkHr6rgqO1zLj/P7h6y+6aZTawb5R+/JGAxbGCj1foW4cl
         TpEnyNOrXU1Hzjpaxy7bvbAz48hbVufsVeI7NUaJXDLmLNCH1pArIo6eIzrSPppGGmPN
         MZWQ==
X-Gm-Message-State: AOAM531nFykrLOUNRM3kw8QHB7lzj/fKKrlDmtv08uVOyNwEMxUlnrQU
        00iLgAh+dXhLaZgJRpPc7ObpPs3g3DoETg==
X-Google-Smtp-Source: ABdhPJy1JegH4+ltQXId/Mj0tKWL0Z5zlBcMvFyL/RD4UsBF8lU4vvtaR75HTI47zLLe6hCEv0srHg==
X-Received: by 2002:a05:6830:270a:: with SMTP id j10mr5390945otu.26.1623142844636;
        Tue, 08 Jun 2021 02:00:44 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o14sm2787564oik.29.2021.06.08.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/12] doc: asciidoctor: use html-prefix only for html
Date:   Tue,  8 Jun 2021 04:00:22 -0500
Message-Id: <20210608090026.1737348-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

