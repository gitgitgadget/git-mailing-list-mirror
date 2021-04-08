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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6039CC43461
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3748B6105A
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhDHPEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhDHPEr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D661AC061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a7so3640198eju.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpq308t+h17CsQKKzze7TVCCrvUv5ln1zLVamrI/oSU=;
        b=P9J8bRMubSBmGiOynh54uddXQNtmaLjnmSThhS3mQ0zJTV1Al4Ur61yiXzQvFyWep4
         cA/90ItTiETK7XPib6r/it+EENhlZYvt7G3l4OR9X/W2RQJCwEFARjyqPgIcO2q+ZkMm
         pY1E7MHaou9DI/xbUzIEdlbbH1aAdEvU3rozZqmQmEHXlC1N9J0Ehvq85o4BcqO+YNow
         IIOKfsX/BMLWpNjKARfJbzEVcAuP33Tm3vDQqfwqxB6NtieqeGOsdhd5YDnrasGR7PiW
         +oRs99j5aLTKTT/06yraF58QvACAJDwjvkeJXfnCgM8OshqW5zQ8uy+dMAp2zdgk9LcY
         INLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpq308t+h17CsQKKzze7TVCCrvUv5ln1zLVamrI/oSU=;
        b=f7FUyMbYUs6d55bMVWunioxTigbiiJUs/1df4mRPhGpqcUbxaGDJUDVe/bkJ8n5IZG
         b89m752VnKmf2GHODJ4mPPbZW+YeBzBIkeBkkJtMdaruNzJ3isicbqXu1ZfXrJfmwz2w
         e7ItLa5uYUvi3UX7YoF6LMUNQD8MGziYyA6d7kRUiRd+XXPfJN4LAS3VcDGVGvzzx/ua
         Btx2+wQOkG5/jqaoBriqrdOfgIOnAmtz++F2cAtbdwxvHv7zcLFo2vnhg1UwspQVubWe
         zovz8O7wY337j6N5QGTAPS5uyJFnivFxO5ITGGX6GJX0agEbyTjomHY26Btw9Ne1WMsC
         VQcw==
X-Gm-Message-State: AOAM531XkFb83EIoAbbo+hEggrdnEmND28CmT/BYgsWm921Kt0QEqJIF
        98wFcLqZ/bOGNvchSrgGyvfJizk4gz7Taw==
X-Google-Smtp-Source: ABdhPJw2OXs+Gso2ilMik8VHmuJ4vTqaXy4zOijfEYrXi4j+xh7m04t12+L+l6lB82NocOY9Dmuo1A==
X-Received: by 2002:a17:906:360c:: with SMTP id q12mr10930351ejb.519.1617894274083;
        Thu, 08 Apr 2021 08:04:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:33 -0700 (PDT)
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
Subject: [PATCH v5 2/9] userdiff style: declare patterns with consistent style
Date:   Thu,  8 Apr 2021 17:04:17 +0200
Message-Id: <patch-02.10-22e48f33b6-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
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
index 650f421d63..33b0ce4020 100644
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
2.31.1.527.g9b8f7de2547

