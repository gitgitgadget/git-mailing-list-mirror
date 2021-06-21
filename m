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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71265C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B9C60FE3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhFURBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhFURAs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C192C061283
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:24 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso9111519otp.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/eJfYuyMWyiWCOPrsfaoAoWCt8w0977TTw8ALPI2Ad8=;
        b=NehW/dNP6WCBV2xIB4UQlRJrUPbZzMkDiP0Jtez/+m7X7tBxBFGidzQeNYMXDEQ5fG
         v4tmZX48F5Ys6sWErdKXrduTimJV7R+JgUJRNIw+841kKgmoOdscWhJTIBQUN/W0o+ld
         DK22wYqXPWl/hL4PZxfrPIL2WmgTopc4nLCeopdOFK2rg26C/kiAyZ9+kSb2w8nfecaI
         UG4j/UnSVpd+h3zcZw34bGtdXAUyzylmiz+lvUpnncLR1RH8vuiAoB5uJERugIdg/b2t
         NKad5AKgnR0sv+grBVzexAf7C8Sv7cP/g1A6CyR7yB3j6PgH0a6oNdNrG0bu1xnt8czK
         yD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/eJfYuyMWyiWCOPrsfaoAoWCt8w0977TTw8ALPI2Ad8=;
        b=Pa+AxDOqOyKavd0CaPMQlynx8IaOzjr9IEOLNHW1MefGWZtPj4+PplifhaTvkQrJD9
         DEl2DL9aMA+tCWwFtmuVw3FjoqDjtiWOvTLhOBvGC8YNANsisnVMjHbymLbPR5z0gNHm
         1jFnT9mlkVFhFwgwFZnsuIfsfgGz3bLeByxARq3prW1a3qals5OFoGbsFDpgoynI410u
         J+XjPO7dqZHFCpq1qQhomYxVxWHdRGOdy2j+PovliL0GERvnxcRFAuFLI48xZ/KHmCP1
         7I9K+yy5cb8mdWW1M6jvglJAz6NrnvkOTRb54DG+kqpKZyJ0IjqO6HmNBzciv59NhNKO
         uiMg==
X-Gm-Message-State: AOAM5323hB1RIf6gFqOf+cw+EWau0YPivx/oOGINghqZuty9dt2ePvTh
        fZ6n6kW+xcLWfIG1OKYQG8mmoBWK8OomZw==
X-Google-Smtp-Source: ABdhPJwdsJmNcssum160Dofv+TMO1L4BRH0XCLrVnsLCMSvXejPtFsCk3+xeuL7TDbnvCp46KhW/4A==
X-Received: by 2002:a9d:264a:: with SMTP id a68mr22230647otb.50.1624293083684;
        Mon, 21 Jun 2021 09:31:23 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p4sm4003398oth.30.2021.06.21.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:23 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/23] doc: use --stringparam in xmlto
Date:   Mon, 21 Jun 2021 11:30:49 -0500
Message-Id: <20210621163110.1074145-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

