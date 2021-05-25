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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E26C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAF361404
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhEYKuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhEYKuA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:50:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE425C06138D
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:28 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b25so29920195oic.0
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlTK0LbCLdZHM3tR8WpR9GRnFxhsvXWBAS9HWgerdoM=;
        b=D0227bqOcEPYTwmzAdKO1Y2jC4F9gwARjfm0uHj+1qSHX5bn1XVBEgyr8ZPnWlaot3
         ESMLiMbsESjv+mqU197lscX1PWEX6Vg6VUbSrdyM6yN2BTp8+2Qmu4DS9JzAPxWM3z4e
         BoE7zqhDkR2ys/OY+f4cDxVlisZEWBpLSnSQapaoAJZx1OVAEUs3UA6wVknMZrot2yIC
         7iYmVTbleAgGqDZ8gVvGnKc+DVYHye3SOF9KoAHbfXs6k2tnWyM4iel4ef1YARAu8KTZ
         M7YfrN8nhdAtXUPCiRG14XpURRwB4h2iocLJHHnQ7HG+KlDde3hmaDPtNmK6cNk0tWWr
         2Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlTK0LbCLdZHM3tR8WpR9GRnFxhsvXWBAS9HWgerdoM=;
        b=DPzRzqZOmGeUFlSoGIeSA9ZKxxJdu3USGMZvOIl9fSCOYuh9L1oUIxX26cvHbdgSJQ
         5/H3KKOtOezxThfuB9E3ubk1u8IMv3O5R59UuZJkiszG8MbQQavogP4ekd7BpHwvPTCU
         k0mbX1VdL1xzDgb49Kg6A7PF2EDfLavCg0Yc3WaNcc6VQ/jXLWk92+Uy2kiI1HJ0Xi2L
         Xi0O6TD2pqE/Ig9zHl2JDQVlFj6Rmu72MrlZtaZWuP3a8yZ9G32t/axq6QxxSpGj2U9I
         COStIaMkx53aWzBK5jnFdgikJ7n81WPzceH1+flpwkFYGfJquoj6sd/nihXcLRNJyhxL
         h1vA==
X-Gm-Message-State: AOAM530DWedjBE1Vm8j1CFdcm8cISQG0uTYmSqlarbYTICX889tvFJVN
        jOMePYVpAIlbrBQFVPTdwKH44RyzU/qhgg==
X-Google-Smtp-Source: ABdhPJyN6ZnREcGMcimDVtQzr7KyCUOXoH2eyHUF2uSmToN7YbnHHR/RxwdKVpOcZaymh2bj8L5Y8A==
X-Received: by 2002:a54:4594:: with SMTP id z20mr2362729oib.100.1621939697340;
        Tue, 25 May 2021 03:48:17 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z15sm3685403otp.20.2021.05.25.03.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/12] doc: asciidoctor: refactor macro registration
Date:   Tue, 25 May 2021 05:47:59 -0500
Message-Id: <20210525104802.158336-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

