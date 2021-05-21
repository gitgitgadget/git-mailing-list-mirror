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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB749C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D79D613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEUWis (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhEUWiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249EC06138A
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h9so21141034oih.4
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqbscAW2JC4oyXeOj4nR2hALeI+2Kpda4E3q52opqv4=;
        b=g0NzynA/m1pxVrrQ/rmDOMgOuttALxb2s738WnMfXy6wKg5tv2RpBa/CbKuOgcKLAW
         /VznuQPvkg7jwsoXNJPCVQ7E0XsfTmlap4OQsikZwK9g2Y39pkZjQeDg1vQNY9ENqz0H
         fvklvXrzoVymRSrc9EOV7YbIuz6mQwU6g6G0/CBYPhNVws8UaRu4cEY+dSsNn3ageGK0
         FHkpQcaz31lcLTI4PTeDqS18SuZkCDiOhMQWm/AGbIGJbz2ZgV2m5vOTETOLAya1TzQ5
         1Qq5pMOANzKr45BXa/kPtTl8f2Xwuz2yA77/yiirs5rYpbf3c2NxWfRd/cnVsuCfnNtF
         h7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqbscAW2JC4oyXeOj4nR2hALeI+2Kpda4E3q52opqv4=;
        b=W/SHaRIpsNOZ3CsVzif9AfEtDnznh+MN3fuhpC5Evast8yuVNvkgt+R+mvMbgfxsQE
         AIsHuGaqCu1xvtiTDmInB7BORrNZFKfOkxWxHij3CiXD7a6ZBCwl4hrYeiixE/UqRfBx
         XB10xeIw9GBClL3pRpEmKkKC9RYc+GY73V9c7gj3eq30faY3EOYjm9zkg/M3rAVYbcCp
         Cc/ILYj7uuNCuwWVU/uWC/TwG3nlmTiigmxSXoieZK/8J9wKstkd/FyUv53mXjwvSG7Z
         Zz4BYpj5CFE6uGE/sY6urD7XyLDuXoK6m7Xr00xdlTCfSXTWikGaSFY3C//Z9lsLrT2x
         W/ZQ==
X-Gm-Message-State: AOAM533hOLyt0vcsFGlXAL9/Q37Ed/hcP7QSeqHMgjfcY41dVdKI1rcH
        RkwXhFtvOI2bJ87oF/CxZV1MULXo3wL3Sg==
X-Google-Smtp-Source: ABdhPJynlOySO3SuqstNUMtkPNOzqZJCrfi/MQd+pdZ01MguvcPx916gQ9Er364L8N3F4vIyqFfwsg==
X-Received: by 2002:a54:448a:: with SMTP id v10mr3812876oiv.133.1621636640601;
        Fri, 21 May 2021 15:37:20 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i4sm922688oih.13.2021.05.21.15.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/12] doc: asciidoctor: split the format from the code
Date:   Fri, 21 May 2021 17:37:00 -0500
Message-Id: <20210521223701.526547-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
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

