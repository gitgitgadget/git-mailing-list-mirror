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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C559BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A906061184
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFHJDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:03:43 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43726 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHJDm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:03:42 -0400
Received: by mail-oi1-f174.google.com with SMTP id x196so20482431oif.10
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmD+5dtCCLMEdfFbyjK4kgRAyRTMUWSMUYBmSL4WVIU=;
        b=QLI/11wVvaUod/HWrSIZ6RMEKteD2QKek9Zfx6oJ+fnXLyYZn60Zm7AbdYUvBzMCQc
         n/qq7fsZTIY30TjV11tfWVLKD0aNHImEZZYiyo+I2g/30h9b/yWJYRq0xiKYRIF7Jmwe
         vCE6J4M+jT92VZ9dqqitrRGHU3vQMTGkYaKkf+y+BeOeXJoEvanKvk8Q0noqGVss5Xdg
         8NgvBWnI6AujZLyprvBqcYCAGbj94mP7DD8c9JU6f+AD/yTwCvfV9pNnU32/qiMMdSbd
         c2GqsBQxyYfvMMks0ovOzXwTAPGFzOrA/Vp35b+rF0g3ugsPCXjhghG4CaGFOoMvoTPf
         ohfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmD+5dtCCLMEdfFbyjK4kgRAyRTMUWSMUYBmSL4WVIU=;
        b=peKa8zQG0LYJ9+GXFrX58Q5W/I5BhBe6yH8TDN4NVhpxl3c9SPrV4Vrr0HzfHJi4QZ
         ohjtjRG5cxouuUIBh9VHUN0CBXbHLIKVlIiE/bDCGi1PyvB5kwE+FO6xkbIKbNi9M/Y0
         hrPktvBZtCCA/8BTRf7k4jzpCLiFLgYNcgn0CZamhnl0lIk8YDBGCwkxmzh0j6I8RoDU
         dxAHOD/4mhHclKqJVXKPcDFg5sYj+D2e9jjk+Mr0u5J7m6rR51T20ajGdniL2LOpsb6M
         0XFnIxMsSe7bSPufUX+Nofc6Q63PFYaOf+PsqeSPCcZC2HyVL2bOOeyQI5vmjWsikEYC
         DWQQ==
X-Gm-Message-State: AOAM531exKa/1j3lm4CdahXuxBR6VtcYBLuDvX4kHdaf/YtQ4BoZ3E/t
        4cM+3m7gBa/y0tCrEg5onQ7ZYdWhwgKg1w==
X-Google-Smtp-Source: ABdhPJwjpCX/a9ef8ohiOqdiWVcUw5ejuK84GxV1PmGk3+2Lc3+Di95NzQtJoOmpPvxEyz3OLs/usQ==
X-Received: by 2002:aca:4795:: with SMTP id u143mr2021076oia.165.1623142849288;
        Tue, 08 Jun 2021 02:00:49 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h2sm1198881oog.16.2021.06.08.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/12] doc: asciidoctor: split the format from the code
Date:   Tue,  8 Jun 2021 04:00:25 -0500
Message-Id: <20210608090026.1737348-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we don't have to specify the block to execute on every
conditional.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 3282d59a48..51981af13c 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -6,22 +6,22 @@ Asciidoctor::Extensions.register do
 
   inline_macro :linkgit do
     if doc.doctype == 'book'
-      process do |parent, target, attrs|
-        '<ulink url="%1$s.html">%1$s(%2$s)</ulink>' % [target, attrs[1]]
-      end
+      format = '<ulink url="%1$s.html">%1$s(%2$s)</ulink>'
     elsif doc.basebackend? 'html'
       prefix = doc.attr('git-relative-html-prefix')
-      process do |parent, target, attrs|
-        %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>) % [target, attrs[1]]
-      end
+      format = %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>)
     elsif doc.basebackend? 'docbook'
-      process do |parent, target, attrs|
-        <<~EOF.chomp % [target, attrs[1]]
-        <citerefentry>
-        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
-        </citerefentry>
-        EOF
-      end
+      format = <<~EOF.chomp
+      <citerefentry>
+      <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
+      </citerefentry>
+      EOF
+    else
+      return
+    end
+
+    process do |_, target, attrs|
+      format % [target, attrs[1]]
     end
   end
 
-- 
2.32.0.2.g41be0a4e50

