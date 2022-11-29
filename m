Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1349AC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 14:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiK2OJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiK2OJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 09:09:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508859FF3
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n21so34024642ejb.9
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8wDyZgg9QMEoWmHITR0hjRGFfAsuwOwI7fxLXhJfso=;
        b=hwEhj+H7gER4FoAr1PKHQD4b45lXtN4vOcJjBjGYCNHrsqtO1KHeXdhCIgKg9y7KEf
         0ArDCQGAhwfv5p5lglR3e5WOg8GavrIJAPK/5rNxQKib6S2lU+N5QXTkmUVEgvmmD6O8
         wMoxLYHvmS8rVRwuY2JSljd56kBN8EWzufrEqD+EFjF5POg2uPuVNdzqDK66zmcHt5cY
         Ehc2rIEYnPXL89o8mxTDKCnWCYDs4ik/wZ51kH6RmtlOR9yDJT92SZ/XQcFdB+zT6qn0
         r41q27RWdO+ukcx7h0+lBP2n34UkjE7kQboBuwfcj2ruqcc7py3eb6VuRM/gg6DTjNBB
         9YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8wDyZgg9QMEoWmHITR0hjRGFfAsuwOwI7fxLXhJfso=;
        b=b6J0tG2xracDHAEyNdxul1MVZXYYV97kUaVYIN+J8xqZmuuuqWFUbU2lEmj4La97qo
         y2Fqke8tiicwInPrOHmDsw6YQ+tOl7m/ilgC1KvWUkVakDjOLmXyurBU0h18iykd1SK1
         z74mAlR17h4BqCx212oWvFH6gSziqLBV0tXkC0NRZT/yL6E+0H+LNin8ySRlkGCHVitD
         6mToKACJWpRXzRF43MQw9USuhP+nmgbKd7v+Xvct6HgfMcYkncsSMQKvdqrWiL8qRok3
         0iOVljAKzI3OAI5RsS4FIe794TbWlhyioaUjT0qowfKVytvk7KxsTDy6YZZl7v86ed7i
         OJSQ==
X-Gm-Message-State: ANoB5pk8O29Ph7WXFD6J7buls7Y7bSkDCcmzgXyfPwqwLNXQPR3oS43X
        D4PQbmdCz33k4/NaIHuLKwPpnAe+ose28Q==
X-Google-Smtp-Source: AA0mqf7FBSJb5wH4YKmzBkM1EMqElmaFgE+7u5Zy492obdGe8eeA5DaQqhgFt68/A7Qp6C8ypAsnpA==
X-Received: by 2002:a17:906:1e8a:b0:7b2:b992:694d with SMTP id e10-20020a1709061e8a00b007b2b992694dmr42920674ejj.651.1669730963085;
        Tue, 29 Nov 2022 06:09:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id be14-20020a0564021a2e00b00463597d2c25sm6307907edb.74.2022.11.29.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:09:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] Documentation/Makefile: narrow wildcard rules to our known files
Date:   Tue, 29 Nov 2022 15:09:17 +0100
Message-Id: <patch-v2-4.4-f1bc3c16904-20221129T140159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.993.g0c499e58e3b
In-Reply-To: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
References: <20221127224251.2508200-1-psmith@gnu.org> <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of declaring that we'll generate e.g. any "%.1" from a
corresponding "%.xml" let's narrow that list down to only our known
manpage files, and likewise for %.xml.

We already generated e.g. "man1" on the basis of "$(DOC_MAN1)", we
just weren't keeping track of what we were generating exactly in the
these middle steps.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 89929e3d60b..f84b54ac093 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -356,14 +356,14 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 $(DOC_MANN): manpage-base-url.xsl $(wildcard manpage*.xsl)
-%.1 : %.xml
-	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
-%.5 : %.xml
-	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
-%.7 : %.xml
-	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
-
-%.xml : %.txt $(ASCIIDOC_DEPS)
+define doc-mann-rule
+$$(DOC_MAN$(1)) : %.$(1) : %.xml
+	$$(QUIET_XMLTO)$$(XMLTO) -m $$(MANPAGE_XSL) $$(XMLTO_EXTRA) man $$<
+
+endef
+$(eval $(foreach n,1 5 7,$(call doc-mann-rule,$(n))))
+
+$(MAN_XML): %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
 user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
-- 
2.39.0.rc0.993.g0c499e58e3b

