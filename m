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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C1C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E9E6128A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEUWir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhEUWio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:44 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27AC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x15so21063936oic.13
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzr2uGo16UQuc9KlAb5i7OgS3/aiPV44qHIRlKqN+ng=;
        b=JKv06sNjCS630xq/a1GsyLc0mu0FaEsI765TiwHv6VQBfrWYk+vvbmgvtPwZixgQW1
         q6MNcS8oH+lANqjjMni+zlpV8ZJ2uqf+0PopDiwCvXZelGSfaDU9fRVgCBcm8AYVdt1b
         4C4cDXg9omH3DE+GDRGvXRmtDoIIfr8bVgp6xT5njc/JGygTj7wWosm3thsKvdjhffOz
         UhuR7MGHP2GTdPtfWZTm/nqlkTwHaMgFZ97JGTF83iC9uxEfK2VSjThOhyZ6VerUG6H5
         Hy4JMHelw3XAazZ2Ly8pu/x02JaPKOHdW+Hc/1cE6giymwKUkjrWw1sEkBPBgQ+dPgbV
         q7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzr2uGo16UQuc9KlAb5i7OgS3/aiPV44qHIRlKqN+ng=;
        b=cBT1RBlgY9zjEI3Crt8zcWQFl65Jfpn86r1eQtK5nZDmhMAWPy+D4stum4yj9sIb3L
         VJVfgpE3L9IH7wb+cbuVOszNc7lo0GTWcVer6C1T1QVt9NM0mS4oMkAhGASxziFp8Yzf
         UbJunYxiqjLdUYZ+KE+Jx5yvbZ7pjJdwxwkvKJd+DTN7U5Yyh+wcTiW2/iQMMWkUDkCZ
         MZyxlC0UtmcgqAjzPBlnjrEKI4T3cY5G0Yt1e31l+xx/sANcv6ELGYm9veOdOikORSp4
         g6PTh5K4nWpexjPOaX1YQ28dkGBoU7UPyxgvpc7BsVZLvf0hYQLtr2LgQtoPfmF4Zp3F
         ESMg==
X-Gm-Message-State: AOAM531DtwsF5aygvRYfoImo7ve/kZUhsN7HZYPEx+03vFU2SQpuVxi8
        ZM4hBsX3e8O8Q6XS1FOmeirFEKNe0qvisA==
X-Google-Smtp-Source: ABdhPJxop10CVp6FIeFvPtYWXg2cOx+6jjuqjOWvG9vQRPggZaerEXgc8tR74q40hxjb5oHzmkpd8Q==
X-Received: by 2002:aca:d07:: with SMTP id 7mr3846252oin.100.1621636638914;
        Fri, 21 May 2021 15:37:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id a18sm1159945oiy.24.2021.05.21.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/12] doc: asciidoctor: improve string handling
Date:   Fri, 21 May 2021 17:36:59 -0500
Message-Id: <20210521223701.526547-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using printf style formatting (more familiar to git developers), and
also here document.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index a678704e17..3282d59a48 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -7,20 +7,20 @@ Asciidoctor::Extensions.register do
   inline_macro :linkgit do
     if doc.doctype == 'book'
       process do |parent, target, attrs|
-        "<ulink url=\"#{target}.html\">" \
-        "#{target}(#{attrs[1]})</ulink>"
+        '<ulink url="%1$s.html">%1$s(%2$s)</ulink>' % [target, attrs[1]]
       end
     elsif doc.basebackend? 'html'
       prefix = doc.attr('git-relative-html-prefix')
       process do |parent, target, attrs|
-        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>) % [target, attrs[1]]
       end
     elsif doc.basebackend? 'docbook'
       process do |parent, target, attrs|
-        "<citerefentry>\n" \
-          "<refentrytitle>#{target}</refentrytitle>" \
-          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-        "</citerefentry>"
+        <<~EOF.chomp % [target, attrs[1]]
+        <citerefentry>
+        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
+        </citerefentry>
+        EOF
       end
     end
   end
-- 
2.32.0.rc0

