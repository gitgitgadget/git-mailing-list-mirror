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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE81C4707E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC2A61176
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhEUWbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhEUWbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:31:11 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB71C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z3so21078377oib.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EngQxQ8pAxLlJBn/CT0/ygSPsaAUFbJgCPVI7msVSrE=;
        b=TrfQJ8N2w/PZfUfatb1HzibtfmMUhdQ2DgiFQIJStFuGzKRXy8oK0GdeoYJYfPxyzZ
         FOQPSoZ6MA2f+/kFqs8SUWKkbJmctFNy8cCm/NMFmwAguuXBfopKQUdtc/HYIo9hF4ck
         t5WULQvdPK0oHehowmwVdxL/PYZ2RqUL+ZUCXvpFEMZ46AAtzKAOh4Rx+6oH/DjkOR59
         ixH5xOuuUK29U66MgsG0Mv8PoR8jBlsY1ioV1VTjZAlnUrxHGkd2PvaP+wFHZpSBazL8
         YQtn0n2wHZzWSvDria4AC7HvHNdez5fkXsDbh7NAe2vAbwB4zDdNW6x5m9K3OZ6GEetn
         TB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EngQxQ8pAxLlJBn/CT0/ygSPsaAUFbJgCPVI7msVSrE=;
        b=QYD3tsrtzNbJoh0DyWGjWn1NCRooHKXhqqXXX07UMA5Hc0/7BCGEc6658Z+WBID2IG
         SBWgFE/oWIyx2Dw/XFmriCoQlrrH71DNx4hUimTHKLsF1kyaiFW5TeB5MPPam0HG4nlP
         mI3IzaZvFmnXLVtoePmySMnlhGKo9Ndw5lOXlPujXh9FYqcZgqmbO3OLkjTVya5cMSiC
         EYt4dnmlM4zerGcw0hkv1nxtumVQ4jIseoCygUOEPqYnacgpxQdjcDyFuK24lMkmqGUa
         u4KvTRmmr0aLungL7Lzdo/IPKdyf31MclKXGhCdbOXJzw51yzNoxQ+M5/f321Ouy/8kz
         WN7A==
X-Gm-Message-State: AOAM532hHB7BjW2HZRh7vXmDFtXFrlS/wURcarVaXBpMaqOdLW2uYjTR
        rrrsDnj4T8rQ7OXoO9R0CAoPpbmbec72pg==
X-Google-Smtp-Source: ABdhPJxtCtkrRKA4z5pNaZdNtSRmI5b9VReFhB5RNjOCBvn+Q8Y3qPSXp3BIAF3Zxdufth+Vjumjig==
X-Received: by 2002:aca:2311:: with SMTP id e17mr3708664oie.160.1621636186269;
        Fri, 21 May 2021 15:29:46 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y34sm1555536ota.16.2021.05.21.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:29:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/5] doc: improve asciidoc dependencies
Date:   Fri, 21 May 2021 17:29:38 -0500
Message-Id: <20210521222941.525901-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521222941.525901-1-felipe.contreras@gmail.com>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

