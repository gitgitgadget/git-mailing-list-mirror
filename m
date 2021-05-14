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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E293C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C896143D
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhENMQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhENMQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:16:02 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB6C061756
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:50 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so6290545oop.12
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ii0dTt7ug845laR78U44NZhJl16Ht0FJG8Qq8pxOKc=;
        b=XxTz1cUfprMbJiKg64Khy6TRZlE7LpWeKhg8PgtaIXNG4pV2PxuC4uM89poOKwabNx
         eQz4k7lJQyWgizjjJpgEomkBNKNcBHADTvQwXxI/JZRPXufGlsZCcexJqt2/Rgx365Ej
         FCKwZQp9S/EDfaJn3JqVu4KTpDjQ8a0XU6TeK3NqmG3VkBuwCPcwWBXJykpLDroBEV63
         2g6YoRJu9np9aEZTsJcZwfmyalnZyxlcpVeipf+kXrJ9U3CAZ2D8+QuC7/bxMmCvqXgB
         cfrYfIurWus0AAm3TkKN3sIU8lzaAMdtmKELVz5eBnbm2MExbBpT4oIMEJdrzdoLOFLt
         InYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ii0dTt7ug845laR78U44NZhJl16Ht0FJG8Qq8pxOKc=;
        b=IHJw9V3iuYLjcUXf6WJsrq3QwQYucnJaNpDQPGOES16XRt4wLn23Eqezi9sZMirXCm
         2nD1CUyjask2tMGXvEkDldnrZ6WgokJ8xlTJ8H9pmpIUtQW5Sq+pgjkU+sVyZIV7d3W4
         qY0kNDMRwAvaWA/UROT0Hxqp5yjiyOIwfFC5Cyb1sHfXLiYfB4QpZfWqmIQki1PIL2E6
         as0plP313u7r7gBEkymc65gHG4qKeduflXSMvQ8AGJYxZRlPT0C4sF5QktFfdjGom+m3
         tPJVVZodLKzIvdq/3yEuxE/SZr0s/vAogQll1KgWnHDZZuasgUFWYTupB5egSAVQLq6D
         l8/g==
X-Gm-Message-State: AOAM531LYxYJqzoKWQgLs6V5jaH24u8VKTshPtYsib1aD5s1uh1Fpaqg
        RoMdhiVB71W2SOqCCPm9PzV6I6CeY/vOOQ==
X-Google-Smtp-Source: ABdhPJx+A6TwhG0fih1/gLGk9qylXvJJQw3YUr8BQak/hsip2QsFNIMyP/zZfO+Gbg97lLHAYlCtHA==
X-Received: by 2002:a4a:abc8:: with SMTP id o8mr36385666oon.77.1620994489925;
        Fri, 14 May 2021 05:14:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a14sm1249257otl.52.2021.05.14.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/11] doc: asciidoctor: add hack for xrefs
Date:   Fri, 14 May 2021 07:14:32 -0500
Message-Id: <20210514121435.504423-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docbook manpage stylesheets convert cross-references with format the
'section called “%t”'. I personally prefer the asciidoctor version, but
for now add a hack to minimize the diff.

Thanks to the extensibility of Ruby we can override corresponding method
in the man page converter.

This fixes doc-diffs like:

          --worktree-attributes
              Look for attributes in .gitattributes files in the working tree as
  -           well (see the section called “ATTRIBUTES”).
  +           well (see ATTRIBUTES).

This can easily be removed later once we are confortable with the
asciidoctor version.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 11937c2c1d..b2bbb318ad 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,5 +1,22 @@
 require 'asciidoctor'
 require 'asciidoctor/extensions'
+require 'asciidoctor/converter/manpage'
+
+module Asciidoctor
+  class Converter::ManPageConverter
+    alias orig_convert_inline_anchor convert_inline_anchor
+    def convert_inline_anchor(node)
+      case node.type
+      when :xref
+        return node.text if node.text
+        refid = node.attributes['refid']
+        'the section called &#8220;%s&#8221;' % refid.gsub('_', ' ')
+      else
+        orig_convert_inline_anchor(node)
+      end
+    end
+  end
+end
 
 module Git
   module Documentation
-- 
2.31.1

