Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21567C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BD161354
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhEOL6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhEOL6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:12 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319E8C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:56:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so1585927oth.5
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raFWYFYkVE4caVIeSt2SrGvqtr2T1dX0y+bluv07/iM=;
        b=vPSMJTO+udG1y7ioISFqIEcrRZtib4SpHp2XhrwO3QIhR5H2rG0S6r7x3yZ8+2P0Rr
         Xa4ZldBA/VewcNj5361NT86esfZVtZo5WO1C4Fmj6g54OBIc0OqTXut41ku8pWKCDXV1
         +Ru/viPw868HQ+vDsJePcUWBIFmrfSpnWJ6a1RaiFDK4yHFjoZeGd+/R90fy3XXfswOp
         OTj91oBz3pPhgluVxS9qnvEpvmOHcXBQfgLASGzop6L2spIfKdVl8mkH3oBjQ1USbkV4
         5e97THvT8lbwvCJuO/UEBQHp7AlR9tRaskae+VQh5dswo/+Zo/4+dAteySbePW15828o
         ySqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raFWYFYkVE4caVIeSt2SrGvqtr2T1dX0y+bluv07/iM=;
        b=qc5N7qqGnVDpcCLrxvGxmUEBJBA3hJQ1AmEfPBt3174hDSm/hW//puraUz3d3lNwkv
         gdLbUv8XfnF9F5UOn7xUaZkskVZufUQ4D/pm1HEQQavIzH7+8ZfSC7Lmp+Ett9XRQM+0
         R5gvn5lgYPQ+opZQ5n4IUhgshSFOvmLuWnir25togVmxGGDHqbsG0+inUNFk1HMxoBwM
         Ha2D8I/HLQcmPkGA4zAbfGbSQbG9AGRboF2dpvHgGUvGg7NzNoWsUzyzxggN4TmlF6gs
         8AQIUvEwOj3YAWbv3YfpzdsN1tH7iocnQUFpwSRu8Dyq9nhEqxSIzC4F72p2Yes+mp1q
         akrw==
X-Gm-Message-State: AOAM530gmAMEgI2dRI0H1L9sAV4a6t5SI4InrZ/+4cxZpkdvSaZ/OOmr
        udhW7oqa49lFz4wPVeYPiWJ0ysn5UjAcFw==
X-Google-Smtp-Source: ABdhPJwg8+tLeebXl8NL3ztXYLdfPBRAnl4pXkPEcUx8jj5/uqletqvBLYJjJkrrYgoV8nkWFyPLvw==
X-Received: by 2002:a9d:8d6:: with SMTP id 80mr9788302otf.33.1621079818416;
        Sat, 15 May 2021 04:56:58 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 16sm1932006otu.79.2021.05.15.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:56:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/12] doc: use --stringparam in xmlto
Date:   Sat, 15 May 2021 06:56:43 -0500
Message-Id: <20210515115653.922902-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
-- 
2.31.1

