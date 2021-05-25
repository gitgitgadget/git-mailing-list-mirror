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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A496C47085
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBDB6142C
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEYKuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhEYKtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:47 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDAC061342
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso17514002otu.10
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehDHJukYh7b8FbgY3eX3Ifyv88n/KEhHnL/0usgot2w=;
        b=hIJXElLD0xeftZxcbW+ozTXARKWq+s8edoJuyUfPjvoomaBX0eCryGIJCUhzk6m662
         JvEyGb9ka3mCukQM6RozwL5RYaP8PmTx8LIr7SUgZY43LufKhZquXT7GMC01IlJGPxNL
         7WiU20RaS9WjXGTbwAh3wILHu47EAl944UtwmtjaVVr6YZ9jRGO1fNMODDryryx/1W08
         MOrz25owh9qQ2hEQ0ZwhRF8jy2OJcMgoURyv1BFaUCvAmdJEPap2ybGrw7KZJpsIpIth
         FbaSTh5leGb49GfVggnv4y3zpBOyPw7DTp10EFjpBbCfSmJXlvRmBysFfzegSVt1L7xg
         wM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehDHJukYh7b8FbgY3eX3Ifyv88n/KEhHnL/0usgot2w=;
        b=PEiPJjXx+Nd3I8YblLAEhxkj+9bcRy822edigvhjuWlSgHONuSqbk5m/SWcna4GSPV
         5DdLPS3n3AFf5DYugWQ9wzuyK8RoP5mr8acWmv0lvLE8SIqJsHeOKUoDZBNJjv8tDvmC
         V+5DG64sJ6e7UKIGqOxfO7sCQ0u4hsWb8sY0nhrsTzLaJkg3G4q3zfRtwxteo8OeGtVG
         v0KoBhRC4mMVm16ItVF4rTEaRsYkQ6YS4PkmsnV8QkDEoZ9c2uza/ALLx4bermsqj2IH
         BR64BVJQ3zpSUOjH3m95aUpuFAAFdC2p5EV7vcQ+IuGKb1kP/vKOk7oHRxOUn6ei3Wum
         oQNA==
X-Gm-Message-State: AOAM532rENN7eBCsNRDqdwFzhwbTpdGe/1zGos+VM3nOacBp2HKFGoOr
        ybyTDYqge+lLKd4Uqjd4T069LqLzVHYHWA==
X-Google-Smtp-Source: ABdhPJzrijus/S44e/eBkbTWrBOkk9esCoxvtWmW8nux4KNiwgp2l+BLhL/fThnr2oualIcGtRBNCw==
X-Received: by 2002:a9d:6e7:: with SMTP id 94mr20349447otx.366.1621939694457;
        Tue, 25 May 2021 03:48:14 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i2sm3667603oto.66.2021.05.25.03.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/12] doc: asciidoctor: reorganize extensions
Date:   Tue, 25 May 2021 05:47:57 -0500
Message-Id: <20210525104802.158336-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to create verbose classes, we can do the same with a
simple block.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 34 +++++++++++--------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 3dea106d00..f998a42249 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,26 +1,22 @@
 require 'asciidoctor/extensions'
 
-module Git
-  module Documentation
-    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      def process(parent, target, attrs)
-        prefix = parent.document.attr('git-relative-html-prefix')
-        if parent.document.doctype == 'book'
-          "<ulink url=\"#{prefix}#{target}.html\">" \
-          "#{target}(#{attrs[1]})</ulink>"
-        elsif parent.document.basebackend? 'html'
-          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
-        elsif parent.document.basebackend? 'docbook'
-          "<citerefentry>\n" \
-            "<refentrytitle>#{target}</refentrytitle>" \
-            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-          "</citerefentry>"
-        end
+Asciidoctor::Extensions.register do
+
+  inline_macro :linkgit do
+    process do |parent, target, attrs|
+      prefix = parent.document.attr('git-relative-html-prefix')
+      if parent.document.doctype == 'book'
+        "<ulink url=\"#{prefix}#{target}.html\">" \
+        "#{target}(#{attrs[1]})</ulink>"
+      elsif parent.document.basebackend? 'html'
+        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+      elsif parent.document.basebackend? 'docbook'
+        "<citerefentry>\n" \
+          "<refentrytitle>#{target}</refentrytitle>" \
+          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
+        "</citerefentry>"
       end
     end
   end
-end
 
-Asciidoctor::Extensions.register do
-  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
 end
-- 
2.32.0.rc0

