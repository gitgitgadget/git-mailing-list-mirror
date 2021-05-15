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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C1EC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3016A61354
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhEOL6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhEOL6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:16 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC8C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:00 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so1641640oto.0
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbWoYgvt/tW5xz3bC9UhkyBUsad/cCPG2DBw/TN8na8=;
        b=bC/OLc6LOTDzZPqVWShrcTik50QqIlXErkkyi6f79ZnvFRyhDSQLeJqxC4RGy/VhFH
         YCRfBdSeI/vzzTIGMSiCMNZONMGCA4xS1B1TScyn4fHDZ03aKygDZpE+BZGWJzRHryTi
         tFFED6rKSTUllUdp4NwyjssugRh81U1jVYXekfPGtBX8gRRZD6dM2/IbssOGhwmxmbX2
         cccxxYyy0/Lo3KEUROIeC/5uxxyt7Nn6umMg8gpM4ubhymB4rzuSk9X8CGXRZHvINGRZ
         JsV+QdOhw4VmYzUTJvN48vfWcIY2t2Tvimn+jkI4hppXtxl/Dkyh2DOOCeHjbAkj3eMX
         AK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbWoYgvt/tW5xz3bC9UhkyBUsad/cCPG2DBw/TN8na8=;
        b=RI7+xXbNm9B3EnOI0SQWryCfPmmUCTegi10e+pkndcc469Ua1/S63CamqJw4KnZO2z
         l+GKnMc10gBBBUlEv3XXOrwmw7a/wEM4sD07lEz28vShpGq/yMho0FKJnfNeOzC8+2eB
         mR+PauDwTrGfAis+6o2LFyIG9dCSr7SfIH4KwczGzSndONp+6JT5FBSMF1S7rhWethA0
         9p3UK6YHnv4bEAwUuvsnA+SqDlntj5NSh0lyyosWn2JrQfcNLAwjTa8kX3ONc8EfqylC
         M7tTkrtSW/Elavm2L4HsxBlY5WY5uKgEiusmeolcVq8XTU91SiFi5ioFmLHPSrzcWFOI
         ciUg==
X-Gm-Message-State: AOAM530cqYZJmgrpyjFE3CC5nEFfJ5hy2Z6e4u8PdBMD+Ay1k3l1WexU
        y1LTWbN7tEvU3vNwAPSSCLgRlaVDMQFApA==
X-Google-Smtp-Source: ABdhPJw8eq1uR6LZmevpfNgnyWVM9lcfpIBpaq0E9XLP7e2PwYE/z9yuxIMg8KT9k1XPxHS880TS6Q==
X-Received: by 2002:a9d:192e:: with SMTP id j46mr14730746ota.346.1621079819945;
        Sat, 15 May 2021 04:56:59 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id d185sm1727310oib.25.2021.05.15.04.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:56:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/12] doc: simplify version passing
Date:   Sat, 15 May 2021 06:56:44 -0500
Message-Id: <20210515115653.922902-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code to pass the version of the man page comes from 2007:
7ef195ba3e (Documentation: Add version information to man pages,
2007-03-25). However, both asciidoc and asciidoctor already do this by
default.

Asciidoctor doesn't read manversion, but there's no need since both
tools just join mansource and manversion.

Let's do that ourselves and get rid of a bunch of code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile                  |  3 +--
 Documentation/asciidoc.conf             | 19 -------------------
 Documentation/asciidoctor-extensions.rb | 17 -----------------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 84643a34e9..47053c78f8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -137,8 +137,7 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanversion=$(GIT_VERSION) \
-		-amanmanual='Git Manual' -amansource='Git'
+		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 3e4c13971b..60f76f43ed 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -51,25 +51,6 @@ ifdef::doctype-manpage[]
 endif::doctype-manpage[]
 endif::backend-docbook[]
 
-ifdef::doctype-manpage[]
-ifdef::backend-docbook[]
-[header]
-template::[header-declarations]
-<refentry>
-<refmeta>
-<refentrytitle>{mantitle}</refentrytitle>
-<manvolnum>{manvolnum}</manvolnum>
-<refmiscinfo class="source">{mansource}</refmiscinfo>
-<refmiscinfo class="version">{manversion}</refmiscinfo>
-<refmiscinfo class="manual">{manmanual}</refmiscinfo>
-</refmeta>
-<refnamediv>
-  <refname>{manname}</refname>
-  <refpurpose>{manpurpose}</refpurpose>
-</refnamediv>
-endif::backend-docbook[]
-endif::doctype-manpage[]
-
 ifdef::backend-xhtml11[]
 [attributes]
 git-relative-html-prefix=
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a00803..70a0956663 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -23,26 +23,9 @@ module Git
         end
       end
     end
-
-    class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
-      def process document, output
-        if document.basebackend? 'docbook'
-          mansource = document.attributes['mansource']
-          manversion = document.attributes['manversion']
-          manmanual = document.attributes['manmanual']
-          new_tags = "" \
-            "<refmiscinfo class=\"source\">#{mansource}</refmiscinfo>\n" \
-            "<refmiscinfo class=\"version\">#{manversion}</refmiscinfo>\n" \
-            "<refmiscinfo class=\"manual\">#{manmanual}</refmiscinfo>\n"
-          output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
-        end
-        output
-      end
-    end
   end
 end
 
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
-  postprocessor Git::Documentation::DocumentPostProcessor
 end
-- 
2.31.1

