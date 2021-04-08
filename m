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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42AC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224DD610F9
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhDHPEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhDHPEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3886C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so2838637edd.4
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRJuW7H4YQZnbbZkqFt7TviHuo/lv8u9yJCh6cdE75M=;
        b=m9IwSbkEXRXwyzB+kJwzB/HTsBbbAqW3eycKeYiBfIGKaQhSC4h61wGidOB9XQ26sb
         z69S/1UnlWU3oSZahTjsX7Y8Xmuqk7BHKry6iyIhpoCzMbqRcPuV/g9hjwNdp8I5TPjq
         NjmMkoIoc+NSNUp1m19nPaUHsrJQ6UWzaXUeFCLDymbBGUc/C6rTJzK3AhUZPxZJzxPh
         QvaF5lK8G1Eny1UIaW6Yx5T5sY8XC4yQxahPr8REvwPyjm8GFOgiL7/IC0q8KETnO/jC
         owkbQujHmWN5Q3ASlqBxgwwZm2d+xHyq6qWE45FrX7zsOYMRWQ4L1vsMFOsH3YMmYN+A
         RPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRJuW7H4YQZnbbZkqFt7TviHuo/lv8u9yJCh6cdE75M=;
        b=E4BD7exO9zRVuZdnRecsphh+9imH3gcRkiLGoiX0bse48ua8IUnMSis4YHkoFw027x
         7dJFFFqGHIa6VRyDBPMqS22vwSYlrnV8lXx7aOqK/s2ckaPhWv2Rt5DQV8hNU/22JCH3
         Fj2JLOO5xsztFgBpG2RFeayKISG3z3K09IRq4Y8B6UULoe62ozsSyPqPQH/poK1fMj+K
         2YghAmJpZ1lgHF1VuVhGXpxzmWWmfhj5o33lk778Bupkq0iDhW7kzmVzX1dBMnCW0MCk
         EwIvrhYi9PfkO8eopMM2VgtYSxjuEltPX9RRI4iH9E4ZdIK75ue6iahEaS+xz2XU+o04
         Tx2Q==
X-Gm-Message-State: AOAM530WemJTLr4Lom5zRLEAckmjbQWxvJd0v6qWuyl5uQOCd7zWZvn3
        KcrLavQpl8Gjo7YicUCcgLRs4eMJzi3VNw==
X-Google-Smtp-Source: ABdhPJx3vtQpwNLDQbJ92t2CwYnNXqHVN+AM9bH9KcKK2/RsZHePQLvd4JvNMKdBngOoFnCrXUkaDg==
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr11873547edc.360.1617894273124;
        Thu, 08 Apr 2021 08:04:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:32 -0700 (PDT)
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
Subject: [PATCH v5 1/9] userdiff style: re-order drivers in alphabetical order
Date:   Thu,  8 Apr 2021 17:04:16 +0200
Message-Id: <patch-01.10-2f7a7b2897-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
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
index 3f81a2261c..650f421d63 100644
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
2.31.1.527.g9b8f7de2547

