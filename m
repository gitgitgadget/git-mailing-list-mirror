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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE2C4332D
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B6D64DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhBOPtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhBOPpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA0C0617A7
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a132so171541wmc.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjeNuzWy9TWdtoiWG4G6TTkUp8BfzkGi9G+pVLPgKzY=;
        b=Swm8+Sboh6LrPsY84UDnOhlsDAqZefNVyUnL1gk+JOuKo13TDUcIF80OZug0T4BJ7C
         owGdF8W7KAMOEqtHctb7dAy2r8cYI2Z3Tu/Vl2V1DCwE/MNJksSHsOggUNVBVlP7GHt0
         pZzjxRtBLpfewWlCrLR49VGv0ml+Cg6534g4B3Qg7kdq9EkE3xr5rFdjp2gboDiHOzaZ
         Vd2aSt9hUeb51o0+syFpgapgsSwIvtWLEkSka+u6tx01miAGHgyGUoH9K9yZzRaBR5tg
         kK0T3nEFNGQ3seM7zTi4Vt0sQtC1HVVzlPaF5Ddwg9bXWDTM4xAgO6u5FhaZ6l8k2M8A
         501g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjeNuzWy9TWdtoiWG4G6TTkUp8BfzkGi9G+pVLPgKzY=;
        b=MP1uLlU9LKJr3fyFax+WEyazj1qaewxiJbcc8qN1jb8gXIrrb+FO5y0o02MOXlIuLu
         9AWoNFi5BGDfViuu4/GA7E7TTHlSdQ2w9OxfSpn9SWK9WBGMgFnpT20giN1mnc0qklwi
         JLThZ+7wItH3TSPEpxtMZXa/v2dLGqVoyGmdqeEd++oM3jq6v6PsR6E9bOZ+YqFMqwTV
         TrTaj4nxPHUooy0CHVO73oNnQRkyHReEh+m3YHEj/isJFjB1ix5mFpVhV3oBqrUaA6NY
         zdm9ketZgXECB3mwTscd9PBxKo6Fbv/K0eTSvjAoQGAlb92MXjCUwJqzCJkXf6DG/snS
         /ZkQ==
X-Gm-Message-State: AOAM532+CeZDkXDXiGj9aupNpvMcg/bvtfDEGh1ibri5gXHasxiXc0FU
        tyDgm6eKLcN7rJROoBaN7IPdkHEy5BMuLQ==
X-Google-Smtp-Source: ABdhPJzKrcmLUbLGi6Boiup9riKLDKNAKdDaYVK4ik94iCBh618zj19h+c+LgiuOQjXCXkKukfDQVQ==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr14636195wmb.53.1613403888055;
        Mon, 15 Feb 2021 07:44:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:47 -0800 (PST)
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
Subject: [PATCH v2 03/27] userdiff style: declare patterns with consistent style
Date:   Mon, 15 Feb 2021 16:44:03 +0100
Message-Id: <20210215154427.32693-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
index c92cbcc054..c7aaf7094f 100644
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

