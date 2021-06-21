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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE87C49EA2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C710660C3F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhFURBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhFURA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:58 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E29C061147
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id m137so20531165oig.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0s4njrIt3tCUCYYUzOQcT6rb/SPi97kT/IWsqkAKHA=;
        b=q/c1D4uPer4+a1U/426jJygQrarSmg9cY8BdcB8tnSbKNL0nLUulIYOsSi7abJccPH
         puRzVdTbImaHiNLRaEB/vwHpFvxlVahPi1ESbmvZNSptzqZULyh7Rw6XSdvM1pqmnOXP
         75Ky5pu1kIePtQUovdLrve6B6cUkxs8v8kwzaii2PovBWWhG4K6K1A4r50YrffK9g9Y2
         xjXgfDBggcbTn99K5ggJBCuXtMXL6fV+gF37qA8pFZRJgovzvVmK9QVnGNlnGw9QqFNM
         YUbcUgvtIuJI8N9qsDbyYm9YMUOU2J3AoxuhIfSEmdzPjYLlo7AetktSV/UeshzJnOLC
         3TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0s4njrIt3tCUCYYUzOQcT6rb/SPi97kT/IWsqkAKHA=;
        b=Yi/YJunDqWFK8BzVj6sM/it7HIWfOuJvsAvngU54UhIqh6z8V5mt0JIRHgI/RZCSn0
         6rn4UOhM7RFF/uo9h31xA3LNrtt1kkY9Jy7fhBxLzJa8AjgQEU0PpAAUmYQUdZXE4cWA
         T12iXmPeBm/OnOPQ4LrmiPIoYd/+Qb3W3kWVj9lAnPBNMAh7LmzxNTqh1zHT88eEHTpx
         zA8h+LqpTHOGVK4P01zaBCsdDyqLxn5FOC6lkRz8W97dwxYTCsNl2fUbGuyIxg6siMWD
         SzAeCo5qK3dwrrRtWl0AoTlJZiQFC/E92bkdY5ezBckGuuJ6JUoSFJfojvLYRwBLRAvG
         Vb7w==
X-Gm-Message-State: AOAM533zpCGeQdM1buqAagvW0MiCE8Sdes6YqIpoTn/jEUi+HMW3fcoK
        jI3wqU4jWrTnOVbDrOsQbtJTFqDOthkUhw==
X-Google-Smtp-Source: ABdhPJyU+7YIC0nBGDhl7Y9EN5nAMuBU6LL6olG3Mp91yEUkBfjdOzOWavZJ5m0yXZN6p9noXU795Q==
X-Received: by 2002:aca:d5cd:: with SMTP id m196mr24681630oig.138.1624293097257;
        Mon, 21 Jun 2021 09:31:37 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 5sm121257oot.29.2021.06.21.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/23] doc: asciidoctor: refactor macro registration
Date:   Mon, 21 Jun 2021 11:30:56 -0500
Message-Id: <20210621163110.1074145-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to execute extra code every time the process block is
called.

In Ruby the lexical scope is shared, so we can define variables in the
register block scope, and all the rest will inherit those variables.

Based on the doctype and basebackend one of three blocks is selected for
the inline_macro. However, the conditionals will be run only once.

In the end Ruby will only run the code between `process do end`, nothing
else.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index c77b6de350..a678704e17 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -2,15 +2,21 @@ require 'asciidoctor/extensions'
 
 Asciidoctor::Extensions.register do
 
+  doc = document
+
   inline_macro :linkgit do
-    process do |parent, target, attrs|
-      if parent.document.doctype == 'book'
+    if doc.doctype == 'book'
+      process do |parent, target, attrs|
         "<ulink url=\"#{target}.html\">" \
         "#{target}(#{attrs[1]})</ulink>"
-      elsif parent.document.basebackend? 'html'
-        prefix = parent.document.attr('git-relative-html-prefix')
+      end
+    elsif doc.basebackend? 'html'
+      prefix = doc.attr('git-relative-html-prefix')
+      process do |parent, target, attrs|
         %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
-      elsif parent.document.basebackend? 'docbook'
+      end
+    elsif doc.basebackend? 'docbook'
+      process do |parent, target, attrs|
         "<citerefentry>\n" \
           "<refentrytitle>#{target}</refentrytitle>" \
           "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-- 
2.32.0

