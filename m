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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD003C433E9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A3F64F03
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhBXTwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBXTwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:52:35 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937D1C061786
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i7so3838936wmb.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoTF4NS9jZeI481ZRfTXc0a3qzceIJGMckMFcQv8w54=;
        b=nN6qqUlr5AHzOrpVHLisXc6dI8oxA8dQrX77tgmrXQhBoc+7FK17O6aLRPWNsOa1cW
         9rAo97toNAAScNzkTCzKqwxHu/z9Kr+exekgldUG6SzPwRSnGx92+w+z/g8g3Een4U35
         Xh9TZok4bdi1AqIccoMxd/oFkyJfGZzNxfGz1ZL2qWplm63smoF1BI2uyp1vvzYD1/zN
         H+MnQ4z2uhv1ctudKm5hKb2tZ8JVD2/1NxPHV+S07mmdc8BtmpYx1ef95/9gZfRq6vH2
         Ny9ISnt5n8bEgHOqPiteWeU91+ttNkE6LHX8F7bW7Cz/T42DtmIb7/zUYw5ryuNBdh5k
         NAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoTF4NS9jZeI481ZRfTXc0a3qzceIJGMckMFcQv8w54=;
        b=AG/uEQNC0GGF0yQFF3SW63cqsshgD1ImEm3jocbfyRE1pEDMTuobQL3RfU2C2Sd11R
         M+4QPDCRT9LneupkEIzii8Zj3ld2MEFPXM1SNasaeyCk3LIB/qz13nQ+sipCBo2hQPrU
         1RPx0S6c4r1SnXszMkumY2wOAouj6yMcVefzPsI2TVDL0F17Rmm7tH+eVu7ZEHhqRj6t
         WBE6IFqDVgdeyrTaYNxaFROVS1UrwYVyxmqJOm6FZ36hL0fkSkNutPG0YZdOu2jsGGZ+
         ZemKbkjmWI8Ct6dKj8Aoen3p+V7jH3bFNb69qoi5GtS65FyJibm7IKPJY8bA4suKo/9b
         8OKw==
X-Gm-Message-State: AOAM531WGl11iqXZpdrH8z6parCgWojUDXPaUflgS+UDJEZ6QEJ4B/Xc
        5kTNjzKt9Z7whZpuhxvWQUaIODUFY1SYtA==
X-Google-Smtp-Source: ABdhPJxf1Ygxzz2dF5H9jKk3ZBOe3UDVyyWhxopvzfI9rZzVGcB1fGWXH22aFZNuKWvgdBfWXjxopQ==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr5209251wmc.189.1614196313860;
        Wed, 24 Feb 2021 11:51:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:53 -0800 (PST)
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
Subject: [PATCH v3 02/35] userdiff style: re-order drivers in alphabetical order
Date:   Wed, 24 Feb 2021 20:50:56 +0100
Message-Id: <20210224195129.4004-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address some old code smell and move around the built-in userdiff
drivers so they're both in alphabetical order, and now in the same
order they appear in the gitattributes(5) documentation.

The two started drifting in be58e70dba (diff: unify external diff and
funcname parsing code, 2008-10-05), and then even further in
80c49c3de2 (color-words: make regex configurable via attributes,
2009-01-17) when the "cpp" pattern was added.

There are no functional changes here, and as --color-moved will show
only moved existing lines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 76 +++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index c147bcbb173..c92cbcc0540 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -44,6 +44,44 @@ PATTERNS("bash",
 	 /* -- */
 	 /* Characters not in the default $IFS value */
 	 "[^ \t]+"),
+PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
+	 "[={}\"]|[^={}\" \t]+"),
+PATTERNS("cpp",
+	 /* Jump targets or access declarations */
+	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
+	 /* functions/methods, variables, and compounds at top level */
+	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
+PATTERNS("csharp",
+	 /* Keywords */
+	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
+	 /* Methods and constructors */
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 /* Properties */
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	 /* Type definitions */
+	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	 /* Namespace */
+	 "^[ \t]*(namespace[ \t]+.*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+IPATTERN("css",
+	 "![:;][[:space:]]*$\n"
+	 "^[:[@.#]?[_a-z0-9].*$",
+	 /* -- */
+	 /*
+	  * This regex comes from W3C CSS specs. Should theoretically also
+	  * allow ISO 10646 characters U+00A0 and higher,
+	  * but they are not handled in this regex.
+	  */
+	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
+	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
+),
 PATTERNS("dts",
 	 "!;\n"
 	 "!=\n"
@@ -191,46 +229,8 @@ PATTERNS("rust",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
-PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
-	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
-PATTERNS("cpp",
-	 /* Jump targets or access declarations */
-	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
-	 /* functions/methods, variables, and compounds at top level */
-	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
-PATTERNS("csharp",
-	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
-	 /* Properties */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
-	 /* Type definitions */
-	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
-	 /* Namespace */
-	 "^[ \t]*(namespace[ \t]+.*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
-IPATTERN("css",
-	 "![:;][[:space:]]*$\n"
-	 "^[:[@.#]?[_a-z0-9].*$",
-	 /* -- */
-	 /*
-	  * This regex comes from W3C CSS specs. Should theoretically also
-	  * allow ISO 10646 characters U+00A0 and higher,
-	  * but they are not handled in this regex.
-	  */
-	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
-	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
-),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
2.30.0.284.gd98b1dd5eaa7

