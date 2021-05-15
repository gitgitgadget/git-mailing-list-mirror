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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A594EC43460
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860D9613BB
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhEOL6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhEOL6X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11BC06174A
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so1566827otp.11
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apjKSujSu4w8CQegGCTqnVAiw/yjz7fz3BaJnD9wLwI=;
        b=QhHVgR4FU/FW81BMtjGo78R4qZ6t8P4Kqc9EocfqGcF1QxmiiExU62SZMkvjAZn3xw
         JEv7exS575NfFbAkQ+77M1pz0T7Ncj6V71CAB97W5DT+s0i4EvjNp8M8rWk0/1Qu/+71
         qxl44ogSbEu1Py9sNEzKPixx552TTXTX0ep2jBichHFenQcOhk2N06I8duDgP9ycvcZi
         Drn0BcO3Fdw2o6vrWpVi41Z3vBBqAIFsQG3AIpRL9pl+DO3VsHzdl1m/Z/LpzYbx5Jx0
         MB+3X2lFKzGnUidMq6fcJm1JFD97bv8zHK9zJLtrLcfsbzVAKTFm36EOkXxUrtWR5p0i
         9Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apjKSujSu4w8CQegGCTqnVAiw/yjz7fz3BaJnD9wLwI=;
        b=H1FyaxeC7DOSSIA47TQVvhTHWIt4IeyS7sryixUBo6mxF+0JQ/ji1yyTa+YKms5QBr
         2XLUO+wCQwIT7MaUT9g7i1ZaTiwbBQOkVY2tqMcM6Xln/Kp9w1A33FFSXOEuQX4Ocrti
         3kNuNtS/21BR8aswdGowpBsMRSbuh92bw6W27CI2ZKncgTtw3PtSQnpuFHe+mmRTJcZs
         XbIBKrL3uWDXHM2anKs5MDUZ+TSsDFMZZDcLCKcE/BuBsPvu12oVx4fGr3kN7J1HwJBA
         g7WonHCqUac94oOvbhmskgy9JYrrFRvxn4fNd5CSJpMhceN9/Ek8L9soG1z7h2QzbOmL
         sOAA==
X-Gm-Message-State: AOAM530BCsunu27IORLq3j2Lq5OdYBsgIX7OOYeQCxwfcCQAaRzD+nH1
        WN7JYdbsy14ovF/jO2X+BIQ1pPLgu2hDmQ==
X-Google-Smtp-Source: ABdhPJxOSALS6hsf3edPSeririyvzVDJ/7vzW5miBRY0c91QAaDZANrnMzZKYgcP6a8srMdDHqjLMQ==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr44587177otb.257.1621079829378;
        Sat, 15 May 2021 04:57:09 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a14sm1880969otl.52.2021.05.15.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/12] doc: asciidoctor: refactor macro registration
Date:   Sat, 15 May 2021 06:56:50 -0500
Message-Id: <20210515115653.922902-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
2.31.1

