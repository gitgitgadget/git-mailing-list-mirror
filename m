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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A22C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CB160FE3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhFURBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhFURBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB8C0A54D9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:44 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w127so20555295oig.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZI3NPb1Q/y1xzuJK56HIE/dyxJYTraiUZ1N5xlql2k=;
        b=QaJtJmzHKGHcDLX3ccgK93geHduYHtLmDij1szXQksG2buzUserVrAIReMVfARdW+g
         ocUIRixmHtNuMxCQg5ef1C2yoVDt3d4tFb/1e7+iJBeqhcF6or0T2nTD5A5aKe5A1955
         aEwjW5VkUeGZ+pkSREQb5uXJz7X0WrF1tjCcRpqK1tOrYxBaghrZdf2cI2Y/5iVnH96w
         rCdNVSTlJmZ0sA9gd2Y3vOiExEKAaDQW3REZvWygR5EUavWCS4RMeOwtzQJ/MqZ3/0SE
         hdySGIGmosNxgIYz2YRMCsgHn9DDvfz4SvqnZIWC/lrzAK9tIA9X1SxSpvdl1e9fHuKH
         ewXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZI3NPb1Q/y1xzuJK56HIE/dyxJYTraiUZ1N5xlql2k=;
        b=NCBej8sDtSLODxd1+UbB8mtHpRunxxzqejWk1xwH8OkxF8KMPds3VfhmYrINI9742f
         Fbmk8egSiKDhwqTilHoKWByeyEQ1rjP/XAkBcx2gXDWy2uFM6K8RzF/fQrvlhtuHoqSB
         QXdZbvvRYoAfzpXOiz/4un1KPJu9Szpi3IBlhRErWDjoq/fzGu59KsrZtwRAS0Ju2bhm
         C2DqW+3qwWmogLHFg+rDwkG7CgBvF+FnDiA+VSniKC3wVeJFXVOrZLxqpqT6vuI4OdBz
         nqVIs104iAirDYPxFfdbQri9T8hSs2toJOEVKH1RqGPMBav2NYUnyKI6j+zycYGpMQBO
         4OEA==
X-Gm-Message-State: AOAM531VDfFX/uAARzgCqhRHcaQnosGC38UPos0Pgy2SFu/IQXxG10SM
        dE4z5dUibiTZ2e+I0h3bfNPg4Xw0PeKSZQ==
X-Google-Smtp-Source: ABdhPJxP3No515xDn6PRY8TfkKabtCWTrTY5vUMmkr1W5m+iSrXp3WE4i2MAKQgL/zoVbHvEvXn0hQ==
X-Received: by 2002:aca:2410:: with SMTP id n16mr24434151oic.56.1624293103736;
        Mon, 21 Jun 2021 09:31:43 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v8sm3945136oth.69.2021.06.21.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/23] doc: asciidoctor: split the format from the code
Date:   Mon, 21 Jun 2021 11:30:58 -0500
Message-Id: <20210621163110.1074145-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

