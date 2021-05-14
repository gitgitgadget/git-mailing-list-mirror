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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D86AC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F836143D
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhENMQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhENMQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:16:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B2C061763
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso26202286otb.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bx6OfZhevHB5IntTsT1ruLiFaeaivhIOEP3a1TGRqgE=;
        b=lALa7VVX3KoiAjdKlpNY7dFGeVWZR5BSqiK096K5tJjX0rwNYI666wLFsZr3gX2x5y
         1aur7a+PYXmMqM9FAtJKflejTLtZNZEo2QQ4sP55FdXNSJWTMEiS8OGrDIGYnsb0QC6t
         lUNH4BP84CLJYX3EtfIuvkeeblGv0mH0PqdX5o8D/Tmuivdm46TEtTfKM6wROJ8xS4PK
         XXlwLUHyySxCY2E7PhMMWbvZEXkP7uaRG/8g7mKRAu1wDnHEZF9sKpBsAPXAc7DYexON
         5hh23bPD8Gm7NTk3fAltWvL7kSmtWqgVGpIpDCa2RDAr/y0Wejyi5mljtK0HpUr6wfnP
         +qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bx6OfZhevHB5IntTsT1ruLiFaeaivhIOEP3a1TGRqgE=;
        b=kuFmIUUHkZ4t5Bh9Q6kcbKXEczr00R99DosNhUb12kk9fZ+vi90WbVVRKlYpHtHGsF
         +ZB+pJUNdoRLgUfjjreWOWNTDGVK1elTiFss0dgaPsLEUHWiXi/7ZNSzUKk/Hd8JEaGr
         EvS/s3bZRkN3zjz0ukU/Grsrp8BiML4IzmSZoWzYkxb5gNVdIcd+DArB2WdXT6o3yC2D
         VtFNanrBLSrOBwTGo9NYrF/hUyEr42q4CCWw5dpPQZOVp5Q//zrG/PArWF4+cch6BGad
         UDSK20d5mJXoCrYl4cJB3YEqJK1DMkXGGx7MwAld9nnLVGhOgLTErjkvi8GMjtZd0MxP
         8h6w==
X-Gm-Message-State: AOAM533+fAHf8HS6zwAukOrwX+qUp1XqewfSBYlXjsBM1/4ZLb5eUUCt
        1WTT4idPaNmXsQ/JsBbeuLi3nh/9onT8NA==
X-Google-Smtp-Source: ABdhPJzY9GFdcz1RxtmS0x3vgrQp4UXtLKE8BjhbcQBh3Fi9aXfoyGaQjMHJu7LhtkT4pyGNCj0Kcg==
X-Received: by 2002:a9d:12a5:: with SMTP id g34mr6876072otg.204.1620994494469;
        Fri, 14 May 2021 05:14:54 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 19sm1143488oiy.11.2021.05.14.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/11] doc: asciidoctor: cleanup man page hack
Date:   Fri, 14 May 2021 07:14:35 -0500
Message-Id: <20210514121435.504423-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's basically nothing we need from the original
orig_convert_inline_anchor(), so let's remove calls to it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 2ed92c3055..f23c5628a5 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -4,7 +4,6 @@ require 'asciidoctor/converter/manpage'
 
 module Asciidoctor
   class Converter::ManPageConverter
-    alias orig_convert_inline_anchor convert_inline_anchor
     def convert_inline_anchor(node)
       case node.type
       when :xref
@@ -26,8 +25,10 @@ module Asciidoctor
         end
 
         "\e\\fB%s\e\\fR[%d]" % [node.text, footnote.index]
+      when :ref, :bibref
+        ''
       else
-        orig_convert_inline_anchor(node)
+        nil
       end
     end
   end
-- 
2.31.1

