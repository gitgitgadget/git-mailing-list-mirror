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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA33C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFE46101A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFHJCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhFHJCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72D4C0617A6
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so19647463otl.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYqVKGFDzhF3oKkFkIFyWHNPSjXukCSwLZ4oy0905Nk=;
        b=K6d3YK1W22lwyVZkh8eN0tTDo4axE84Sz7Lly4G2y0HiTzWx+jVKvZbNbEd5eSkoX6
         OC/TpnIwHeP6f+JdCZJiVHtVo1hvg9i5dMfNlkEtZM35ZF3PmKXRheFIOIevLAHSvQiR
         cqRX3Lh+bS9AMFeaWfsxUkn3IVUm5GoBX7jScKjyxHYAyg8zvdzvO91PsuO47c1HtGKK
         eJeCPV7Y3HrHuR0UB19Q/IaoYdayNYTcynPiNXjWw/sjdUXCJBuz+irPu5m48uRATXQp
         bKZwQJ+iZNqY5KEJCIfGOP4993cNKUVEMyKq23CIj7y/RSpHnHV78ihaGZIYMGJntawO
         Xnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYqVKGFDzhF3oKkFkIFyWHNPSjXukCSwLZ4oy0905Nk=;
        b=nxLsYYTe+eDMKPhgiIxbNGE8eONeO99oZnYZRB2fsug6rjAszH5P4wkfsv6y5UmiTI
         u+QlLsgTWBBYrjysBAmIPDhBEtIPKxXrPEE1WZKltDPgckjiQAWYTh6rHwut3jOzAWUn
         Ktf5GpNkczJ0/F+q7INmMl7XxqWDWkZBrZZLhvoz5ZPO2du/f6HhAea6LIhHg4FGH3cM
         GHHOni5sVdwcG3XmIgngW+k+ZAr1y2DwOwQQpJrQfjBfNGc+itNrgWjBIQBNEO+je+qv
         2qjZAsu5NQ7V2AFWIXO05Wxb09OyjSADu78A54vKF5KCpikLh15WQObEPByDmBwUFqcX
         ofxQ==
X-Gm-Message-State: AOAM532aYqlX9+VSkp0r2j+j/33u8eX163bz8eqN5Czbk5l+ZcDbelRd
        fSvoWyo5MY8z3Tf9LEGkuZ/IOnM7kAWnrQ==
X-Google-Smtp-Source: ABdhPJw6UkOVxjC1XZKZ6/uUxcHIy57gHlfgvmN9SHJiRNSm/5j6avy18FmsEj2IgPCUX1KluMuHMQ==
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr9959519otq.82.1623142843003;
        Tue, 08 Jun 2021 02:00:43 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 3sm42082otu.52.2021.06.08.02.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/12] doc: asciidoctor: reorganize extensions
Date:   Tue,  8 Jun 2021 04:00:21 -0500
Message-Id: <20210608090026.1737348-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to create verbose classes, we can do the same with a
simple block.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 34 +++++++++++--------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 3dea106d00..f998a42249 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,26 +1,22 @@
 require 'asciidoctor/extensions'
 
-module Git
-  module Documentation
-    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      def process(parent, target, attrs)
-        prefix = parent.document.attr('git-relative-html-prefix')
-        if parent.document.doctype == 'book'
-          "<ulink url=\"#{prefix}#{target}.html\">" \
-          "#{target}(#{attrs[1]})</ulink>"
-        elsif parent.document.basebackend? 'html'
-          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
-        elsif parent.document.basebackend? 'docbook'
-          "<citerefentry>\n" \
-            "<refentrytitle>#{target}</refentrytitle>" \
-            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-          "</citerefentry>"
-        end
+Asciidoctor::Extensions.register do
+
+  inline_macro :linkgit do
+    process do |parent, target, attrs|
+      prefix = parent.document.attr('git-relative-html-prefix')
+      if parent.document.doctype == 'book'
+        "<ulink url=\"#{prefix}#{target}.html\">" \
+        "#{target}(#{attrs[1]})</ulink>"
+      elsif parent.document.basebackend? 'html'
+        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+      elsif parent.document.basebackend? 'docbook'
+        "<citerefentry>\n" \
+          "<refentrytitle>#{target}</refentrytitle>" \
+          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
+        "</citerefentry>"
       end
     end
   end
-end
 
-Asciidoctor::Extensions.register do
-  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
 end
-- 
2.32.0.2.g41be0a4e50

