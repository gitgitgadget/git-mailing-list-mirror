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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBBAC433E6
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C60B619EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhCXBtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhCXBtS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47198C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so22771377wrc.3
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMawoFm7GuNo/SuXnBFOHXnnMr5j69BXZz5LvaNVzL4=;
        b=nTOPBhMZiBIBFPaRYlb2XNLhXiv9f9UQjNa226DEsqw4Jr9v38AdrnwYAR0jqE3OE6
         IHqyQf1osf6IofGc97l3MkaqllRL7UnlPpxRAI2aA1XezNYYcdffy1ejb50DijaNfsWW
         PChID3JTty+7/QD17GpeG7h9bmxJaxDG73Q3MRH6yobj+46LImDTcGGxeimQaw3HU7/u
         /6EA+2390stp0fQOgfvOTMjG2/rpByyeRcTj4IUV9XUV1BB6D8gaQNEIFnzmfKuOE+2q
         6/sOqWLLU1PBCO6RZp1wXWmVCKByb9inXElWZ1O/J4DsDFetgnXucu6D8fFfcgoxGYiX
         tncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMawoFm7GuNo/SuXnBFOHXnnMr5j69BXZz5LvaNVzL4=;
        b=MIo9CKVzM0X7SAPE67noN4zgJlifNjpyV20mZjGBTj6Fb20loVkhoauGUMhsynlDE5
         D7qqcpuWx0lZdZCCuxT9teYk1wH85pGc3GFJDsR1tpPu4kXMSm9A8Qb4zRVBHeF7AOFy
         umLD00m++wG7nBmiueNpsLS+IVTBLJZes5JYXqekQntg/rCh0Av5iv6pwmP1iQ2/sTOk
         pZFJBsFeoQzg5f4nG8ysp/CbC027F+h1Pb5memuX2DFMCs+6EqGiM39DrqPbDTNKR5rV
         eRw3Mr2hKuWfUPXzeWRU+mnoDt2xExrCCmQJo0n7SJO358Xa9aJQwbTtpxziyzi5ZXS5
         3WhA==
X-Gm-Message-State: AOAM533C3rRCSpyPWArzHJ8NoRa3rT6b10LNQY6aUrkwxhv6LMaThfbp
        ulfbyOdrIJbK6Ar6DWmDDrcFmijdVgKN+Q==
X-Google-Smtp-Source: ABdhPJzif3w+WlVRzhRb0dJFAJXpcjgBNADS6ekt9k9AAeKGIv6aURXjb0SKxZn21LKEj+ELk0Kp5w==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr724825wrt.426.1616550556713;
        Tue, 23 Mar 2021 18:49:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:16 -0700 (PDT)
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
Subject: [PATCH v4 03/10] userdiff style: declare patterns with consistent style
Date:   Wed, 24 Mar 2021 02:48:45 +0100
Message-Id: <patch-03.11-faf1a824f05-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
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
2.31.0.366.ga80606b22c1

