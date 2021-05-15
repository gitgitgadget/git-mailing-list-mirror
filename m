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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B740C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EF4613BB
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhEOL6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhEOL6V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FEC061761
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so1586109oth.5
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgEvKmc077hG4bm8gYHUHuo+y9Iyra6rLQgekB1DkjQ=;
        b=LpdaCrUmXTDPaO/Nd209jP+29Si8jP7xFDpLB0wVKAxYHwtYjj6Kd9wQJjs/EiZkPe
         JAzTLtYUlarw8j3tXiZ7mnwXGLAUk4FtdxVwfPh4hx/ZrRSx3KscOaVpMIvOnIA+6iiX
         SxxNYlWh8LgyPg2Q7pOfGhdN4tAo3kNjF3qBG0hiq9ld5adEE37b/h5mh3NrkL+fLfjS
         ZcgZbNxdroo/E3Z9u9QkkL8qbNXd6ApuNZcr5LEW8TnAuVdxjcldt1T85byuCRI+doKE
         YbbEnnIpK/mul68BfgclflRlyAwOsLzdfvEKG2RQIBblry5IJ22aq8+p6oC5JlcoKI2J
         lAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgEvKmc077hG4bm8gYHUHuo+y9Iyra6rLQgekB1DkjQ=;
        b=dX7vJLsbNu7p13nienaoBbqJ3FhCRcHq2J7XN0T6uqdCZo5S6vdJPr2jk41W6AqaBU
         LDFbW8xBk/IlGWq5XT8p9xWBHLG1ClZfjc3TDkDBptDCpKlYUfF1j26PpeneFar5EWNT
         GP5XC2NCF6aaG5lH+HgAbCzcxBW+xp6KP4BAArZ47simqv/zip33p+HrIXP4iZg4gB2c
         OR7bUuhBKyyECLFbJSqdYHNS0ExuBCG0ePvYfIqYi9Vf7fSd3oHJK2cexHLdqu9XtLzc
         fu7xV1j/HrdnJ5HNd7B4Y6H81+ogw/VAgUJZ6p1IE03KsG91TvU7jERTdTl1E8DRbvcE
         ehxw==
X-Gm-Message-State: AOAM530TGXTfqnMyXNWddhoF9VsBYWfuVnT1OrE5g6YhHNIxV1ml40e0
        9Mtiiw5pF6lUmovvnUnJU6+2C5dVvkoYtw==
X-Google-Smtp-Source: ABdhPJzb8NPEvkXRYeqjM+MphXFOPg0IpSe9KD6/kJYYDmTmM81DbVbp8L3O0LD5Mnz+35r4HfIvuA==
X-Received: by 2002:a05:6830:33ea:: with SMTP id i10mr42824458otu.212.1621079826321;
        Sat, 15 May 2021 04:57:06 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a12sm1897932oti.12.2021.05.15.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/12] doc: asciidoctor: reorganize extensions
Date:   Sat, 15 May 2021 06:56:48 -0500
Message-Id: <20210515115653.922902-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
2.31.1

