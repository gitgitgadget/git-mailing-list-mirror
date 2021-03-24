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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0AEC433E3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA98619F6
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhCXBtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhCXBtR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8523AC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z2so22800559wrl.5
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeRuP+pS+/sm1sC22MtdQd0TRkDMjgEXIT6yIo7QtMw=;
        b=P/hiU8bMv9cN/dkl+0pdDfCSXjvfALM+6Va/tX2ihK2LhYEaJK43gRicEJJKfl/EPY
         Xl1xAB4MKpzZuZcKaiGm2kXWDaH81zNd0VB4ZBWf6Xva0do2k6nL9EjLqvACtxtLPYX5
         z5rWkx8xLZBh6yWTXWYB1S+NV74aY2vdEmJbA3ySlYP4yWwAihWVLVvmUNRgyzQ0g4BC
         SQ/7QZ3Wcf4ZHvGQCIn2PrVebhiyfbNRHrr4y8xXmFTBFTJ5hCW4vhJNc14+dmBBK2el
         tSl4ux/Q2a8Obas52lDPHJyTQOyIj4A8cHjK9MU1UI+gjJCJWh+KBBft5AxQvH3A0SVd
         hxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeRuP+pS+/sm1sC22MtdQd0TRkDMjgEXIT6yIo7QtMw=;
        b=rObdBhvdJRQHVxt6TPMlj/XRIFvNhY5KoSxNIugfwG/asCaYWwlSmX8N0KKflFWZcR
         P4bdqIQnXeW7MEVtFDAYGigC2W+MbgpSPDsseUfOywLCd7IpMIdlFXxLcv5cTcdr/Sq3
         fa3HNgZnkE38JDUIAU+MIqQ3RE32kquKc6yIAehS18Kx4AjHI2akm4ISRmthFQ+XhOUw
         vwJCqscI0gt6U7OfyIjZ/2hQMktvguC+SS27OzZ8VD4SMfinTttBpIPWqFCoZXZcha4g
         TQlvvlM1Tq3J/7qdt0NDbebVqzgbLLUlPmLVVjn+quqbHd4I2HtJ+ng46rtat4Au5vLX
         eCAQ==
X-Gm-Message-State: AOAM533SR4nIeLmYs5xlUmtiSzE5ozXt3KVynbAiz4WO6fWNRu2S2ytG
        H1ANTttCpNxpPV3Og1ZbvCwDVxOwkRiPWQ==
X-Google-Smtp-Source: ABdhPJyt8MDdrSie5gOuYB9L/CvRoh/P/RL6xYx7UQDTS9E8R7M3dMlYFfrE3TQPzRj4ADcxFgoEzw==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr749412wrv.15.1616550555940;
        Tue, 23 Mar 2021 18:49:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:15 -0700 (PDT)
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
Subject: [PATCH v4 02/10] userdiff style: re-order drivers in alphabetical order
Date:   Wed, 24 Mar 2021 02:48:44 +0100
Message-Id: <patch-02.11-149387155bc-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
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
2.31.0.366.ga80606b22c1

