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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E0C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37320613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhEUWic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhEUWib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:31 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD779C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:06 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b25so21168474oic.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcHlKLi9XHJ5zeaM219u//KyMDQfD2a0BXuqf+hmn8M=;
        b=YjK7mZ2tTIqpNMsfRS7GBxnjVwM/zYX0YNwRpRdGsXI/6UhYjSqWvM6v/8yZxPr1J9
         gFIqjwIxsN6IQRtut5wYTnVLBzR1sXz8tXHh0BYxqbpoBb7EdO+Z3WCc6RD0ElTcscP4
         6z1yEC8Z3gnidmm54HjRvRn+1SYURvjZhTzAWKSvcjWobdh2u137wEN3O+HEPW8aoK2w
         JgZjNNz+rblYu7AC70Tr9R8n+3U303bw4zRxCRFqtYxM17IWIZ2CWnJefUDU2yMUMANk
         B5h4EZYRzfEfaw2+FOir26dM96fo6lf/nRWiwxO31WRzS0OghpCCLRDEVYy4QGKofNUm
         Sc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcHlKLi9XHJ5zeaM219u//KyMDQfD2a0BXuqf+hmn8M=;
        b=KFIbKQFBp05BtK/v3kyBkcdDn1B4B8dHnGU99alUSkNHJ0cuIEZUR3cewuf54JEhCo
         tchesLArf6akVAT3lKIk+I/Ogza4tkvhapy+gmssHOm4NXxAWR3wZT7t003zx34YWHIk
         xr12FTzC9HTywbnU7fyXmBzsTJn1IkAslpfjM1c6GCRbMYS7ySiEb7byHq4spdfdTHcP
         h+EDAW4M8AU5Hl1YcZ8hK4/Ou+kEIrZu3fEHemYF9yTn1i7l3Oy6BMLQJqnT1tHN02Xw
         kL+wqJ2RKjx+h73OVFVq2AREXefxSw0tiZvorfATZ1md9ui5p+K4qSyA2QcLY3z/dDYn
         NQuA==
X-Gm-Message-State: AOAM5309AOZ4aPLyq92Q1+ICNNU+C85SL5OBSDIqCJSm/FMaBv0box1n
        T+GdbfwoIwL7Uvjl3Xg7oh0bpmIdsu3EVQ==
X-Google-Smtp-Source: ABdhPJzOFDcn8GgCfHltCke4arhqigRtXVpzr+ZeN95wvuJJNNAYxAf9B79hWstm3WJbsXq8iAfomQ==
X-Received: by 2002:aca:44a:: with SMTP id 71mr3656863oie.39.1621636626017;
        Fri, 21 May 2021 15:37:06 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p1sm1609375otk.58.2021.05.21.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/12] doc: use --stringparam in xmlto
Date:   Fri, 21 May 2021 17:36:51 -0500
Message-Id: <20210521223701.526547-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

