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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68862C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3871264DEC
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBOPrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhBOPp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DEC061797
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o15so6573459wmq.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cd/CBUBPlCvzF+wJ5Lvk1J3llf30X2BLyNz99QdKeJs=;
        b=pNG1OgrVKYGhf2tL4EVwigQjV/e86CIyOAmf00gGRc7ZTG6kUvc7yBH24q6fAtNRuX
         vs4h8bV4QGfQhstbgQ9Q4aUYFJ3/EWqsMK11M6r/LiGVg4i2r49wY/vo3oI2sr4R2kl3
         5H1ryn0RXSQ5Yjz80+8+J0/mevtVmbWZ1II6fkwMXYbCPq9Cx7dUHS1yBAKAsLyLXVzQ
         wdizG37ILVri7XfuedqvHfVCkuIkIPk0sVe3BSVvmKdvm3JLcyyBtLoCcOuK64sXJHUE
         /D1W954fYeAHWVwAoBec8mXs4cr4HTDq6LzPohv3raSIKc8a3sdaSBnHZVF7nw14YHbp
         7fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cd/CBUBPlCvzF+wJ5Lvk1J3llf30X2BLyNz99QdKeJs=;
        b=YM1fRK9rwIJ2ZPuo3UJk11fCi8R2PmSWEAQJhy+A1exPsw8xs9xxxwVKRYWU17zO6V
         5r74hByYEoj07ZrHkWh8OGwTaZ4JjkkhnOWl4kt/EVzgzCy+r5igkpSR0hWo79wVNfJy
         P22V/p2074E+u9EEF6G3/s+sezKqaFfbdey/lFOV54pJCKOx4Pm7LLFb8MHVyQSFVGoP
         fMjY2AE51Yd/Ryc/BrpLe/lEq3XJ0JDP0QeVwDTUmQZkb7ZQEFBLreZuh59r5neGVfV2
         Y2pKjx0C18ICQmkZnERVu6rrGXIH1wMCowd4y30Qea7cI29YBiwtJy/c+r2s9d5/LtTt
         0vzQ==
X-Gm-Message-State: AOAM5335zbL1Ij6xpyOmXcGfbXmsQNWLpCpbcOGOeHGGh0I9SzxPoW1E
        LhIMo5p0RgpMBcpxBWSJdSWvD1seTYjo5A==
X-Google-Smtp-Source: ABdhPJzD63Y5JWLuli7Hr+4UIB+Oa806r7TU2agThSt9NkXu3wdjFliC1iQcsfP76q8uYWGd5SHsqg==
X-Received: by 2002:a05:600c:4c95:: with SMTP id g21mr14876471wmp.144.1613403887207;
        Mon, 15 Feb 2021 07:44:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:46 -0800 (PST)
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
Subject: [PATCH v2 02/27] userdiff style: re-order drivers in alphabetical order
Date:   Mon, 15 Feb 2021 16:44:02 +0100
Message-Id: <20210215154427.32693-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
index c147bcbb17..c92cbcc054 100644
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

