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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08281C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D028A64F0F
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhBXTw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhBXTwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:52:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65681C061788
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t15so3022040wrx.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QfWIlWwkjr8ie94frouiQ0xnqcBC5QYrhNbYMgvsYU8=;
        b=bBAG0zRewXgn39GXtf+D7ESk6q1HFgF0/+k9MLixUYRN8KjWCBrEg1wcY1W6UO7MLJ
         hKXHmdfUJ+sSS9Nm0tfKzQCzN3naRIFinK2jgCRUMe8iyvqC/MwrJS7236fCpxrT4GkP
         r629Eo9ZEqnqcbR2DleriOwu2XO8VCborgtxFzb6XvCcl706aDqNnhSOljb5cv0K2ZM+
         cupSzQMRLuq4cpfo3UebQj24Wqt189fHomON/TQQb/rnWvBiKgOVF/WxN3/dAAASsCe9
         GJTV4+NFOpXa2UTDCG+zyMShfWBORFmgR2EOmnaqM9uQPHsJUzvDf7JnW5v3b69ISAle
         LUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfWIlWwkjr8ie94frouiQ0xnqcBC5QYrhNbYMgvsYU8=;
        b=pxd3aqIWZCjI/jFAV2pcUcs/fXH/3TP6xJBQXIRwF1C+X2hJD6lv3d3oEGa8tvLLkt
         XeZpE9qG8oXexJPEncqVQAzdFQUk/TIogZFIipTYyvXRR72LOPi/tu42UbEDap6vZhcY
         XKIV1s/1rL0gGGo0nrN+Yf8XfAED/6w0M5s8I3Uw88tk6inPKIbR7mf8OxljoKtq/9Ap
         cx08JpD9zPxCgEvsqDfWbFxUz0+vOlB+EL6YsNWyD7DfJE+VkWYVTvCgSLW9EmdRxFOo
         HpIpYOiovW6vdW8dRji9VBBsV1IfTi6AEtRnXUhSl6ccgw4Uuvvbj+tFUVg7SYckjUh3
         QM8g==
X-Gm-Message-State: AOAM532ub9wWE1DZiG/FtJZaq29on9MQmI7T5quxV3wClY842jBOXH+a
        pHZEAkZHl6t+kmvQ85Otb1fGzEeF3RwAjA==
X-Google-Smtp-Source: ABdhPJxfLYl51UHlOKJFLXIwxUij86EH+kRHqj4AsnQatMRB5pELDUsq10FSOhQBMJ+9VHp3zUB6LQ==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr20824076wrp.61.1614196314820;
        Wed, 24 Feb 2021 11:51:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/35] userdiff style: declare patterns with consistent style
Date:   Wed, 24 Feb 2021 20:50:57 +0100
Message-Id: <20210224195129.4004-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those patterns which were declared with a regex on the same
line as the "PATTERNS()" line to put that regex on the next line, and
add missing "/* -- */" separator comments between the pattern and
word_regex.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index c92cbcc0540..c7aaf7094f8 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -44,7 +44,9 @@ PATTERNS("bash",
 	 /* -- */
 	 /* Characters not in the default $IFS value */
 	 "[^ \t]+"),
-PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
+PATTERNS("bibtex",
+	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
+	 /* -- */
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("cpp",
 	 /* Jump targets or access declarations */
@@ -121,7 +123,9 @@ IPATTERN("fortran",
 	  * they would have been matched above as a variable anyway. */
 	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
 	 "|//|\\*\\*|::|[/<>=]="),
-IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
+IPATTERN("fountain",
+	 "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
+	 /* -- */
 	 "[^ \t-]+"),
 PATTERNS("golang",
 	 /* Functions */
@@ -132,7 +136,9 @@ PATTERNS("golang",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
 	 "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&\\^=?|&&|\\|\\||<-|\\.{3}"),
-PATTERNS("html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
+PATTERNS("html",
+	 "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
+	 /* -- */
 	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
@@ -144,6 +150,7 @@ PATTERNS("java",
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
+	 /* -- */
 	 "[^<>= \t]+"),
 PATTERNS("matlab",
 	 /*
@@ -152,6 +159,7 @@ PATTERNS("matlab",
 	  * that is understood by both.
 	  */
 	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
+	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
@@ -212,13 +220,15 @@ PATTERNS("php",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
 	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"),
-PATTERNS("python", "^[ \t]*((class|(async[ \t]+)?def)[ \t].*)$",
+PATTERNS("python",
+	 "^[ \t]*((class|(async[ \t]+)?def)[ \t].*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
 	 /* -- */
-PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
+PATTERNS("ruby",
+	 "^[ \t]*((class|module|def)[ \t].*)$",
 	 /* -- */
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
-- 
2.30.0.284.gd98b1dd5eaa7

