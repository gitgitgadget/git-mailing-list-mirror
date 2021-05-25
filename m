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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6E0C4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BE56142B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhEYKuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhEYKtw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:52 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61010C061756
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:21 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so28116751oth.8
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqbscAW2JC4oyXeOj4nR2hALeI+2Kpda4E3q52opqv4=;
        b=Q9HZ9oCexh3Kf4FWf3thisfwtcnYOXpP5rm5b/4QcuqnAwoAKIlKb55EAh5mPqVduE
         WQVMQAmAm4hK5tMBYvqv8a0Qp/RPd2/fNQdj+8bAuUupElShuU8mNpccYlVUGGDSsaQG
         3bvykG9W6CUOhz+oGsktsDlzoCkCEDEPHMKEAtlxuENcCqKGAfXnyXcv6fO1pDvvSCcP
         E1eo0KUHT3kSIHWLjAmurxDKg+x/1OBySNY9Jp0m3cQppvHaxFzflP0gL9mQK/wx6Wyl
         /4KghYoN19hge+PWE73mZa8yFIVe/baf1Rgf6vCd+vQHWJqDGKuCr32yyOYUcilzDeE4
         LWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqbscAW2JC4oyXeOj4nR2hALeI+2Kpda4E3q52opqv4=;
        b=BlQDSRLt8aOU1e+eGXLNFxYlSSBgsItEl7Qgx59JT2EXBhR//WR9cjEKlAwEsxrIry
         tTA08owWTAo7AmEaoTu8WbdAXV/gMm+7SxqIWTEiEyBb7TZcOOWw3kncVbgYDixM5QLu
         eiSDWVkqiKwDeUur4ErK576Ro2kZrkuWhRH6lTaGOTE6uayG3uU0ewJe43QGJyrqESVz
         MoOSZmIFAqK0F1GBS6+d0tWBG7zIdkfuSzAraHcRPnk7BwixaoqjwpA1oRfLhSDgeKay
         lUWnkWQElv+P++rQHgbc0g5AxkV+Z6MaFMheuzMXwiRMSejbzd7CdB6e8MX4zxHWP2aH
         06ow==
X-Gm-Message-State: AOAM5329QgmIiKqLejh+MzboMgvVx60eh8LnNDptJJ7y59i/Lj2EyB6z
        75mrFuwQDxJCktpezC+2owunFmjSWH4anQ==
X-Google-Smtp-Source: ABdhPJzeHZBfgUAIOsyOxO85ZfhnxfmaVn1o7B1178yVuJlJQt68kNvjqMVLUzYDArb5j5fX9iPikg==
X-Received: by 2002:a9d:121:: with SMTP id 30mr12438575otu.299.1621939700517;
        Tue, 25 May 2021 03:48:20 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q14sm3397470ota.31.2021.05.25.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 11/12] doc: asciidoctor: split the format from the code
Date:   Tue, 25 May 2021 05:48:01 -0500
Message-Id: <20210525104802.158336-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

