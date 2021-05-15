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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46836C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EDA613BE
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhEOL6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhEOL6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE92C061756
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u144so2063493oie.6
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olozIVNhVgtSAXctiCjsf3xwZ45sV7h/dHKCx2S9C38=;
        b=Td6jZetiilfzhPTxyubHL+FFp8NkxqIlE45mI6YY/+2Tgx6WMZobQ6WMAWVBD3n9r0
         fnVdk9T0x5hI80WYwAZcEAT9wONcdVUITKVfrmkGpWNdC+N4FXWE4en5kRJl3AaHm6/r
         tjaEnHOA+tM1dhsbfJW/Iw5Yl8/tPf9wCAlYrNKadmHerjvGF9+KMlPlF67oOxt+pJzY
         wgwFsDijTsR0MFrmATl0vNUHAh+2BXHFia5oGCGoRe9xd9aq4OaAIJVW1UlzTgzOLYZN
         W5me2l7+wqeXDPh/S7I0tz/gKADuqUT7/tdIkK3uXazSAiMfMU3v6cVrKeYZGpeRBj8B
         5kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olozIVNhVgtSAXctiCjsf3xwZ45sV7h/dHKCx2S9C38=;
        b=AG2jsE3go3tG57+yax2+KX70IUYgUdPtfGmfPj9Pf5DvNuYRPBJR29yIZeYPJDSybP
         c4Pq0KEyNlr8kXblqU23lAty1JfqHiSYiijNsHeDGqiCudtdtUKP/Q4FqVCUvn08kTRk
         QwbpxlWyYSjZz3O4dGrmrAJTndHI+G63uBTwWr4wZa52IUMp2PIfDWd/k0jcNVSbfvuL
         St/pp6MXF4xjY2Y6yYAFlyjN0NM6WIkCOQTUitpMvqs2Ms7duqnBxCjql9OyjDEkUr/p
         /2Spyd3pHcoIDMg6hbyqf1qVSsOn16GYgDkIN8V90uibNtLZZARbCeVR+jCyWQ2Y+L8s
         WThg==
X-Gm-Message-State: AOAM531B5V+WFHobcZNnu02OqiFL8Psckpk9surmSmIYNTy1R36ETH3P
        SOFvZYvk6fq5mZK5+PFZ/pLNAJuwixW6Cw==
X-Google-Smtp-Source: ABdhPJwy1Bc1Nqwy8hGZp7SVNu0zCT3a4YeKH43CPxuxb4H+A3PDQHmlbTwmC914oed0sMstAMushg==
X-Received: by 2002:aca:b605:: with SMTP id g5mr16694183oif.127.1621079830906;
        Sat, 15 May 2021 04:57:10 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id u13sm1879830oop.40.2021.05.15.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/12] doc: asciidoctor: improve string handling
Date:   Sat, 15 May 2021 06:56:51 -0500
Message-Id: <20210515115653.922902-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using printf style formatting (more familiar to git developers), and
also here document.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index a678704e17..eb2326d05a 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -7,20 +7,20 @@ Asciidoctor::Extensions.register do
   inline_macro :linkgit do
     if doc.doctype == 'book'
       process do |parent, target, attrs|
-        "<ulink url=\"#{target}.html\">" \
-        "#{target}(#{attrs[1]})</ulink>"
+        '<ulink url="%1$s.html">%1$s(%2$s)</ulink>' % [target, attrs[1]]
       end
     elsif doc.basebackend? 'html'
       prefix = doc.attr('git-relative-html-prefix')
       process do |parent, target, attrs|
-        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>) % [target, attrs[1]]
       end
     elsif doc.basebackend? 'docbook'
       process do |parent, target, attrs|
-        "<citerefentry>\n" \
-          "<refentrytitle>#{target}</refentrytitle>" \
-          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-        "</citerefentry>"
+        <<~EOF % [target, attrs[1]]
+        <citerefentry>
+        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
+        </citerefentry>
+        EOF
       end
     end
   end
-- 
2.31.1

