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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B6C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2E86128A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhEUWid (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhEUWic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:32 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA9C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so19425400otp.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZY08OiHT1yl6uv7E2pgFnP7wdYDcAdVofYB9KZKxJz0=;
        b=RtlYQMey3OHgZPGCEOT0lUayyolOD2YsZPeDRA9hxWuF1bkTYoQBiTBtwp1+CyKhzq
         1CfvzccWEqAXLgQyrNAfbRRZzOwT8BBYqSuONGWnfKcRAd2LY6Y9zOz/fXO25r8VndjU
         CcfhdaDK/9SvuGD1pwezsNxK+iAdHEZsH9/RIlscuMiKhpMi0O3aZGNtmS4ARcOTFROY
         praZ4H/UIw0E5XIrd+7//2hpAlviK50q9hYq43Ipayw2OfMAXUSq+RaaaXbf/XuC0DSo
         fDcVhAgbkO1GWGVD3qrBEPPItk+aYeTBpSPC2OfbLExsRoY6JZkBmGhLDp6WihXEISfU
         /vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZY08OiHT1yl6uv7E2pgFnP7wdYDcAdVofYB9KZKxJz0=;
        b=h/yy4M540Sz97rypZslk5cu2WL7oaGCER7/sblYqMcwRBGHg1t1u7a622Y9VcUx2Jb
         Xzb7sGnYntrVLSBu38qszQBYEtQ0iOsmbbdCbFHDw9M/3Ue5ezPXBf2TVRGM18+8IC+T
         bqKl/RMhrtAa/mRitm/5lzmeNUyw3GRgocmx1N9WVn5szrL09SQ7eHBPSp4eTCT/7an3
         Tu4knO99AHuYAkrVGudjqRuS4WroDvIpK6hURVWYz+vDZVW86P6kWenhk+YMAWUt42eH
         EwU7gIFFfcJKpaaPhaTUq9H8JFI+8KOS5OFuxHrT+SHc9iE3m3UohV/qppiEM4RnkTOW
         hPnQ==
X-Gm-Message-State: AOAM530MDfekfqWWlizA/9d50W1367/fTCdmmKdkmUEgTv9gvM3jkE/b
        O6kUyCxgiUl7pJRRRmmlUtknr8Ei4KELeQ==
X-Google-Smtp-Source: ABdhPJykp93hphR0ZHVTCpI/FarNa0u9wOtMBt2rLzSm9Uws/TPgb94m6PWLIN9NPN+Dr7zqugifQw==
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr10355388otp.81.1621636627610;
        Fri, 21 May 2021 15:37:07 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id n5sm1567695otq.69.2021.05.21.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/12] doc: simplify version passing
Date:   Fri, 21 May 2021 17:36:52 -0500
Message-Id: <20210521223701.526547-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

