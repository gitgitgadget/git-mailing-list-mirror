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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4FC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E742761404
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhEYKts (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhEYKtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:40 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27EC061756
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h9so29882241oih.4
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZY08OiHT1yl6uv7E2pgFnP7wdYDcAdVofYB9KZKxJz0=;
        b=gsLiE8p60edlcrhp79r1x330FTwqYm7OqAAMavAeVfmTIGHISi47HkTC8nJhZDzBH8
         n3qQgZUm3tEfkkDKzgBEKgp4bmQyeLr2vVZcesEBeVc4iI+d+Ukabx8jK9hs9eZHX/bj
         GqIY70GZQDVcj7fxKZzYh29gKkqLb5/Xanw7SG9GWhQzA1rL+T3Pxrdf/Gvspdw/e1ow
         /rAHR/LnDXqKc8vwp3Q3owi0EXySkzSqxnC0rDQrZlmfgHNpCjjgRC6WGLlVTii5aYik
         ukL67R2kosZ6ETElPGm8kYi1vfPzxkZu63Qi+JV8l28UkDXQPYnVHVyMf/xTdfHi/cmw
         +3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZY08OiHT1yl6uv7E2pgFnP7wdYDcAdVofYB9KZKxJz0=;
        b=Zzp0zvUjJFQpw0sLYGnWOiZ8hfIWAU0aolT6ESiPzDyyG+hGGJI1ew8oSpvsPqGyBq
         RqPtzEk/J5moWfyQkfBSXYFbHKwoDybKiEXlqmd34hw0ZyiVh6EGSdGwWBWi7jNuKOnn
         GERjprBChBRivuEdW13i3G+VxdU3x3qkQEaF3cJjEKFTsePfLMpbm4p93qV5k1HEJAFY
         hw/xyIfvFrAz3UqBL4HUaElriMOk1eF8cteXqio6M+DsUAlr789K65vO9W6pYJSw4QB7
         CRAZbbdHLK++HNI1mQ97Q28MH+MJA7kMvxBIIAE+No+n82C8p9eaAkCul/ZFXBudd3XN
         Hvvw==
X-Gm-Message-State: AOAM5300jr53vTIsCT+HKVArBfNm+/trOiOrjVMTMDJZXnzK4UcJ4Xz5
        h6LTY/7MjnbX20jg6ZwUpm+qfAQRtDIZYw==
X-Google-Smtp-Source: ABdhPJxFQ3Es5HYQSZPeSO1ggxWSoYczgVJVCnY3SMnBbr8Dob5bLQwesf2mzgIVr/cpZayV4fJLfw==
X-Received: by 2002:a54:4113:: with SMTP id l19mr2311128oic.38.1621939688471;
        Tue, 25 May 2021 03:48:08 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p22sm3386489oop.7.2021.05.25.03.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/12] doc: simplify version passing
Date:   Tue, 25 May 2021 05:47:53 -0500
Message-Id: <20210525104802.158336-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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

