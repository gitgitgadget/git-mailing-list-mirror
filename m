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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D88C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DCE6142C
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEYKuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhEYKtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:49 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05042C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d21so29820062oic.11
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzr2uGo16UQuc9KlAb5i7OgS3/aiPV44qHIRlKqN+ng=;
        b=vffLvgmfFS9wb4jDPZoMWjW0LBwQ0WKuvPka+EOo+wHTaEQoqLXNa0krIgUSfANdSC
         xm+qe1WSq+ks3g0kr5SpLhoAD5X/JqgQ6xhLCsb8+yUIh7wPrXjcFaGz7KyCdFKkcVML
         rSRuHJv5poyBWjwjZBDg/o7p2T8tVSwRirHkcRfTAbYwbvxbrQeahMN8Xxtdh56z+lmu
         dlNbR2RB39F7TdbWEJEvd72wPphJ918hgCmwFevaZlh1UGM5sA2jYH9hY7423Wz+W/US
         ZoyJWaI/sZIMv6Ic/FMc5pMXrnoQLM2dy2MuN1adpdBx5g2ZKoGxV9c3yQ5FCH2Jp42H
         GQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzr2uGo16UQuc9KlAb5i7OgS3/aiPV44qHIRlKqN+ng=;
        b=WvgJXLiMvuwKvDsfwqd5PmpQtdhCiXpovDPgO/q6JVZmkwnY4bTl6KwWsF5nUc/55h
         k9Xlf/3HFwAB2RqpXNUXzsX0rBi1rlzIxUQKNDTtkecxrcuGZKso3TSLygqqzznQBz9r
         i1JftzjjLJfGOQTIqNp627My32GWHY6Hv0h/kiA7b5olIeQge9b/eyF4GSVWDBoo3xU2
         dbWQDvJXsVCtzvjvz+EA/bTilgxea+xpOMi1MDUql6JgDvAa1qp77jSUIl5qXGkfay8E
         EJsyR15UXeYKuOIDROn2ucdWmdFUGzvNBwzEq7U4kO6TiS1qxDFuY0773osVeFtPJ9Ya
         eLtg==
X-Gm-Message-State: AOAM533j0keroaw7eNrbfkG8nK9W63fdDO4MGhkCjZMPVdJHm0LzMoKl
        U5UBNB70Bz9I49shVDK0YY1ZFc+EWzpaIA==
X-Google-Smtp-Source: ABdhPJy0azPHDK2RrGwVbt4sMCfrEirKPKBQK+Y2d1my647pc9zV2WycIUx+EGedH2IqSBNkuePjTA==
X-Received: by 2002:a05:6808:8a:: with SMTP id s10mr2336623oic.66.1621939699149;
        Tue, 25 May 2021 03:48:19 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m19sm3431802oov.10.2021.05.25.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/12] doc: asciidoctor: improve string handling
Date:   Tue, 25 May 2021 05:48:00 -0500
Message-Id: <20210525104802.158336-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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

