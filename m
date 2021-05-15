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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE8C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E15613BE
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhEOL6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhEOL60 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60375C061760
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d21so2031841oic.11
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vs+U+Bfnb+fyY7OD/4TdfbLYOyIyvSPGeQ78H8t66Nw=;
        b=DSQ/BnXLHR1r/MyZRUT98t+jPdznlJzkfJslad2+YZZcfpPW9CkP8XpMguzK/9dIUu
         8tL4lWRx7ZDUMn4xI30olonZSglMiAQ5Oho5x5FgvcDNTD0D2F/SenUALqqR1ng4pqu/
         Y78FzhwXhiEnaT16gQ943kUYqoYWuJgubyfPAYVVqENyMPYxFimCEViSrtfTDEm5HIs9
         Tx7gh1+WHy2PhfkIcYgng33+8Zwm+ledfGH6F8bdUwE1HiR78TnzWrudKPQKwtQdj6kH
         j+TyXd4f0GpLSBnZqiWPA50Xb0x05i2TQ6Vrkz7NbqJZPDo8LWJVb8yz4zhKYRkTRnYW
         vQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vs+U+Bfnb+fyY7OD/4TdfbLYOyIyvSPGeQ78H8t66Nw=;
        b=SOXhVViZpX1Rqcu8mJ/Z1K8vGV/5bu1OCrBiysTGFb3GeNCxJBeydqENvV/UTXa01s
         AnLD/gfGLt7kkxBmOS/tbd6QP5KzucZ2R62aTZQHdVO+ob2nX87EO1SVh0tIa7hr34Uy
         uJ9VwZmlsCzVJfmZWOtgodEI2zQ3sJGbAH3R4W8IadhlAbslN+YUDB/WWf6w8oAhRsfy
         4RA2ZggRR27an0QBhBvnpPGyuqqwb2GFmojwhnOpIHhQaWd3hrezRaibhWs/+jhDUA9t
         cngE87BqgBK9EZmZxAJBcIZlLgP5IUhIuVhnX8KAChQqiL+eFeuiNGOyAEqm6bweSHqT
         +AsA==
X-Gm-Message-State: AOAM530CVQU+YJSpg/nc0tXtvvrjv7u783lpL/ZDVRQCb1bQPqCmUk9/
        GSnV7yuzssk+hkXXx5xNnG34WpcT6TTBKw==
X-Google-Smtp-Source: ABdhPJx36bNO38OJ4CfXi/I+ChonAi9mCPD/G5cECQ7RYZWUgKO3S7vBtTkQGEx1zd8IXu0qZ8JTOA==
X-Received: by 2002:aca:490d:: with SMTP id w13mr9688443oia.140.1621079832534;
        Sat, 15 May 2021 04:57:12 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id e26sm1669143oig.9.2021.05.15.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/12] doc: asciidoctor: split the format from the code
Date:   Sat, 15 May 2021 06:56:52 -0500
Message-Id: <20210515115653.922902-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
index eb2326d05a..f7696f19f6 100644
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
-        <<~EOF % [target, attrs[1]]
-        <citerefentry>
-        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
-        </citerefentry>
-        EOF
-      end
+      format = <<~EOF
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
2.31.1

