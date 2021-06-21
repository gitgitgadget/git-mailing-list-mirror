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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E0C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A02460FE3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhFURBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhFURAy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7119C0A3BDC
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:34 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso18275950oto.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sz1cqSk0JoeiXps2woNgIyYetAQ3k7A+QrGUTePIGg=;
        b=l0zXVUS7sKKP95twQ1Ll9aO9ArnoUrPO91nkIKy3YKmaFAoljT8uNU+6lRCjoCXl95
         InPEVwo+EcPA4Hd61/CaTKREuKe8M5sR7ZqzxBRPkZLX0aTbxVe/W6ztWNQebCHIBtIg
         SwNAzS1IulsmFaB/JNQlOkJ8KU9KEQBdmeCK+wR1yGQxuMYRuuqUpHnP9ZLCGj5sxytV
         yr3GkPmAOzKKFiv/bJdUVxaKqnPiLD68bnsrXcUssIkBdaDVVusDjAhrcivlWvRFUv/8
         U/8k0GcXoYstwBRdwfP+k5wW5IpPySR9wW8ekggOT6gcCCpBSOH8uaB1hx3ZePUrhua9
         /v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sz1cqSk0JoeiXps2woNgIyYetAQ3k7A+QrGUTePIGg=;
        b=f6nVGitR6Ak0jwGlDkRtFhQ74oUOndid/yeQ+golyRl+HSHuBxMGaGnvt370S6d2rJ
         /cnng1wVrrGwCVrHDzudGhE2lBDriLckVeJEFQBv52yOhmaCNt2ay/WEKAIIdmi4d4wh
         Hmio53ya9SNUedHkfAP4+86pQz5qtMHCVzeP0a5V6XVFfV6IoiEMxcVx+3AszkMNJUG5
         jWxxOeaoikzBoNrP8ESDey0RBvNaBXY4QAw9sHTyZOSts3vJuFm+NUeAqM1fZtB4Pf6I
         vsdNHTs3hmyJlHOZlMRMLqoHcU9bFmrpqyjTOTurSjc/i2CWm3Y8XM7Px5rUfcnMrxx0
         VuHQ==
X-Gm-Message-State: AOAM531qDO7nhl1nkzbnwFbcqUJa/XwNv4zg9ybudNuBSZVTKdJit0VG
        9KpjMTtUlpcVGSB5ywyX+gmEBJKO72XWHA==
X-Google-Smtp-Source: ABdhPJxUqFAau7dcpMEG8ojcQYU4qH/OBX0FmLW/FbwtSJD5Bg/e3113ZqAfpSCnn4NrXVMjt3ORNw==
X-Received: by 2002:a9d:6acb:: with SMTP id m11mr21259133otq.246.1624293093788;
        Mon, 21 Jun 2021 09:31:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l7sm3995499otu.76.2021.06.21.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/23] doc: asciidoctor: reorganize extensions
Date:   Mon, 21 Jun 2021 11:30:54 -0500
Message-Id: <20210621163110.1074145-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

