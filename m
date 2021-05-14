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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66678C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4653861406
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhENL5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhENL5t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 07:57:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52235C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:37 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so5084253otp.4
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RFBlhMgpyZpA/ZONYGLWsJTLeqpmosbKmwfuSpvfoc=;
        b=j2jYYmLcXbTSVtXcnVWvdee7OF8QnZoe64larvxlzh6/BOQd8DEchhgv5zFEXIU29r
         uSu6oBZIAUEHpS5+lveMEoDVks8jT4GYUSXiEQM4l6QBCX4ByNzrlV/uOIuZl4Qoqt4a
         /Icw+7TWAbThAn81sQ3VP16LSnn3NINwmUQ8VyipCKyN/7iExOFP4Zk7EFcda5/vFOco
         JGo4qOHJ+nBYhpvf4NLoXAY5++yzT3CpspQyVUlXlkL8dCfWfA4zTKGUUTo8jTl0zc/q
         aS4lzYEm7vMI6s41x1xRFIWQvctw9bb+Cug7xBe5ylrWBZyY/ruApxNVZtLmA1gCWj8U
         SxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RFBlhMgpyZpA/ZONYGLWsJTLeqpmosbKmwfuSpvfoc=;
        b=W0LU89MIgBSmMbL5oADBBQD1mo1ToALw3VaJpsacqIQzebVY8qGV9Bta1sTvnpezr6
         oqQ5Lzi6fFC9XYGTeYA8f6onbWKPpEJbPSY8VaAUSZjV9cZNIk1oKd3S/GWK/rM9Ni2S
         erUa1xZzzzq1oD2mpXy4Blt7fgq2fRpwQL/Z8nHoOnqaptQCuz0Dhs/3G3SdXqcJtSbB
         DkgbiCn1l94xGt9p45OM7qszIhHetTiZASlwuY/1gSeexkXrfoPAUlqnlWGGVvFI5zKo
         iAYoESDg+2as9HA9gTZZlKNqfoPmJ7ZH87efjkaBu6MFSIBFePK5POa72d8F6K5QxypD
         c/Ig==
X-Gm-Message-State: AOAM530uKdsZ5J4e5L/T7nF51F6VyNMT093PwTU1NNpA4sF+Ad1A/VD5
        SfuMHTS+as+rcHuwhc05hoHlUoQ+UGgY6A==
X-Google-Smtp-Source: ABdhPJzfC6CDjFuXuIYumDnCT/bLLfmQDPx7P7S4NdZvfcvvTggZ1IORqaVzi5c5s1uLJ5GMLInTZQ==
X-Received: by 2002:a05:6830:4014:: with SMTP id h20mr39633756ots.62.1620993396568;
        Fri, 14 May 2021 04:56:36 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j26sm749863otk.11.2021.05.14.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:56:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/5] doc: improve asciidoc dependencies
Date:   Fri, 14 May 2021 06:56:28 -0500
Message-Id: <20210514115631.503276-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514115631.503276-1-felipe.contreras@gmail.com>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

asciidoc needs asciidoc.conf, asciidoctor asciidoctor-extensions.rb.

Neither needs the other.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 46d9b98dac..0f59cc0853 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -139,7 +139,7 @@ ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
-ASCIIDOC_DEPS = asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
@@ -194,6 +194,7 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
-- 
2.31.1

