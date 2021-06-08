Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D8EC48BCD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194836101A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFHJCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhFHJC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:26 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54CC06178B
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:33 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j17-20020a0568200231b029024900620310so3577700oob.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8/eyV1qb+6mgBqjY/qSKB6syPC8l5ytbfE60lrcFfM=;
        b=U1eGASghxaSOhfgJcuk8gTDtaPuaqJvDqByDd0awyY2iH1lj24F/61zlNsdu0tCdAK
         NP9SKk9nViDrUbu7qPscSUXHqyVrRN7Mvy7Jx+lpHSNvkuzl9B2usCmGwif5HX8ZJ6I7
         F7B93QlipJLDmdnvyf1/HzoV96X9UawM0F8nu/iSOcE0zwflMEuXJ6MQntDaiASwXT+i
         yWP8mMMrh+ZKbgCMyqtZ+vmDSgdh7hQYq4ltzy49VP4DaFaw5DpBF9HShdB4OuUTP7Ng
         FYrV2a1YbNDGYqYK1z05n+YGX+CbvYouZt/0pD9aaI57+LiO83SAOaw5UUGtyzEVIZf4
         gjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8/eyV1qb+6mgBqjY/qSKB6syPC8l5ytbfE60lrcFfM=;
        b=TYzgGHky6wx5MBf3pw0KRM85ULseQSt3Dwq+78CObKujgofkENG4m/ZVWIA2eGpMcV
         2Hv+Tq6q6I2sERuUiXRTvDk3ZenRxDE6ofeekxKUTQ2iT1q9fFlA38zYeDl/wcuiexNO
         VFwyEx1bWsjV9teEaGrOAcPMAkqguUB/CEx9P/IZ6dPPyOgrY55UCbZqntMPxHRNci+u
         wCEESk0EzPHn81SVFsNF0TS9N1rHEYzB0eJfybZPBip6mlmDWTn62KvUfzkQVz1HwfdC
         +nuIsgc1gX3xpTR6D6eL1fgWDtbP3gGNZeyL0PQDX9gUu+WisLDeOmFZRNgnubqbPwoE
         T76A==
X-Gm-Message-State: AOAM531WGfLeCHzXpqu8n922a6ux+cJ8NGBzZaU8L0dMwIgsKT+ABpka
        ub2KCo3nPE0bwgzRsB+98fkDVhv1jHnxiA==
X-Google-Smtp-Source: ABdhPJznJD26wR6l0UF1ZFuMCYBNdD+uS+5//waLrRANXV3s72iuOU7WJtxFLNEydoSF+QCbCT1SSA==
X-Received: by 2002:a4a:3e8e:: with SMTP id t136mr16642151oot.83.1623142832811;
        Tue, 08 Jun 2021 02:00:32 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x2sm1803950oog.10.2021.06.08.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/12] doc: use --stringparam in xmlto
Date:   Tue,  8 Jun 2021 04:00:16 -0500
Message-Id: <20210608090026.1737348-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 50d9bbba92 (Documentation: Avoid use of xmlto --stringparam,
2009-12-04) introduced manpage-base-url.xsl because ancient versions of
xmlto did not have --stringparam.

However, that was more than ten years ago, no need for that complexity
anymore.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/.gitignore              |  1 -
 Documentation/Makefile                |  8 ++------
 Documentation/manpage-base-url.xsl.in | 10 ----------
 3 files changed, 2 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/manpage-base-url.xsl.in

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 9022d48355..e9f8d693b1 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -10,7 +10,6 @@ howto-index.txt
 doc.dep
 cmds-*.txt
 mergetools-*.txt
-manpage-base-url.xsl
 SubmittingPatches.txt
 tmp-doc-diff/
 GIT-ASCIIDOCFLAGS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index bf1f66b3eb..84643a34e9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -176,7 +176,7 @@ endif
 ifndef MAN_BASE_URL
 MAN_BASE_URL = file://$(htmldir)/
 endif
-XMLTO_EXTRA += -m manpage-base-url.xsl
+XMLTO_EXTRA += --stringparam man.base.url.for.relative.links='$(MAN_BASE_URL)'
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
@@ -342,7 +342,6 @@ clean:
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
-	$(RM) manpage-base-url.xsl
 	$(RM) GIT-ASCIIDOCFLAGS
 
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
@@ -351,10 +350,7 @@ $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
-manpage-base-url.xsl: manpage-base-url.xsl.in
-	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
-
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
+%.1 %.5 %.7 : %.xml $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
diff --git a/Documentation/manpage-base-url.xsl.in b/Documentation/manpage-base-url.xsl.in
deleted file mode 100644
index e800904df3..0000000000
--- a/Documentation/manpage-base-url.xsl.in
+++ /dev/null
@@ -1,10 +0,0 @@
-<!-- manpage-base-url.xsl:
-     special settings for manpages rendered from newer docbook -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- set a base URL for relative links -->
-<xsl:param name="man.base.url.for.relative.links"
-	>@@MAN_BASE_URL@@</xsl:param>
-
-</xsl:stylesheet>
-- 
2.32.0.2.g41be0a4e50

