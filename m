Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61FEC61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 05:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCMFFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 01:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMFFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 01:05:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0872006E
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:05:01 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso6078610otr.5
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678683900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3esmLJHui7TFtQDwQw8xmiYaMjghPEuMDC4MWK1l5hU=;
        b=ZnpYXkYo8fA+/a9DUq5FKvp09N10cYrMxP4OrA9Bi/C0fqbibjOusG6HrSvan+fav1
         Or0CznkpInMRvgOMnGok6pdEqv9fuQ0sgB6VBHW9KjTS6lfSaoWychOcVMJ6u4oA7K+Z
         HCqUNhcc5b6n86rdXq+wSAEo9SemSuZR5J8aKgkBM6WaaFPAB7ZaR9CYBa5dkz3Tsuxa
         Vdonfs+qIEwfGVlupiHVQey6e1r5gI2KczQYLfjK5zq/2898QtesI3vbQ5Fqi8nIcxZN
         toIYr34A2lSSJ5eHL7c4Ui/Hr1ryzmLZqAPVMq/1fsGna28E3fWgQYHwGnrHgP4f26kt
         AoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678683900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3esmLJHui7TFtQDwQw8xmiYaMjghPEuMDC4MWK1l5hU=;
        b=id5yj5RwSENRRPL9h0WwZMv54Dvdw2U9Q/HUzHcXOg7SDdQFEhDRSgu5A2WyOUL2Nr
         va3vBIfbfQtxgB39XrjnRYa0AkZFfCMDkcAfC1pABQ5s0q6EPpQ+qX5ud+BLeaI5tc4Y
         Sb7Tb0ylaFNf3IvOQGVulgBdrK9WQxfWHMTRnEQRve1MWReGYKpkdKrlAaiWtB74FTce
         PK9LRy5GtAhy8oRj+g9x9/WExveeIiK6XWsiftOVJ+oyEjs5GAB4+76G8Ua/Js1ct2IV
         nYqepvDErhDg3UslRaIOuyLujgUmQYJvNGfYotBoV6TtWvY0DeauzIEkZyvQ2R6qUFSR
         CdkQ==
X-Gm-Message-State: AO0yUKU9Q22o90Np4hSQOX5RkVyYo/5ulGZ8TNy8ZsMSxn2QvpMFlusE
        7yyVulqnbkROwJ6IJ/Xdkw8K1QnbnGQ=
X-Google-Smtp-Source: AK7set+4cZKrYlFk2IbhVih3SIAohem+NwOi0qmJSZnNAeZV+SSz6NXIrEzIbpC326sFiMpatc+J2A==
X-Received: by 2002:a9d:6147:0:b0:684:dc1c:fe85 with SMTP id c7-20020a9d6147000000b00684dc1cfe85mr15155434otk.36.1678683900394;
        Sun, 12 Mar 2023 22:05:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l32-20020a056830336000b006941ecefc34sm2785533ott.18.2023.03.12.22.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 22:04:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: encoding: simplify BOM addition
Date:   Sun, 12 Mar 2023 23:04:59 -0600
Message-Id: <20230313050459.3465060-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 79444c9294 (utf8: handle systems that don't write BOM for UTF-16,
2019-02-12) some prereqs were added (NO_UTF16_BOM and NO_UTF32_BOM) in
order to conditionally add BOMs for the systems that need them.

But we don't need to check that prereq every time we are going to write
some text.

Let's check the requirement only once and generate write_utf{16,32}
accordingly.

Cc: Brian M. Carlson <sandals@crustytoothpaste.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/lib-encoding.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
index 2dabc8c73e..15aea597be 100644
--- a/t/lib-encoding.sh
+++ b/t/lib-encoding.sh
@@ -1,25 +1,25 @@
 # Encoding helpers
 
-test_lazy_prereq NO_UTF16_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
-'
+if test "$(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c)" = 6
+then
+	add_utf16_bom () { printf '\376\377'; }
+else
+	add_utf16_bom () { :; }
+fi
 
-test_lazy_prereq NO_UTF32_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
-'
+if test "$(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c)" = 12
+then
+	add_utf32_bom () { printf '\0\0\376\377'; }
+else
+	add_utf32_bom () { :; }
+fi
 
 write_utf16 () {
-	if test_have_prereq NO_UTF16_BOM
-	then
-		printf '\376\377'
-	fi &&
+	add_utf16_bom &&
 	iconv -f UTF-8 -t UTF-16
 }
 
 write_utf32 () {
-	if test_have_prereq NO_UTF32_BOM
-	then
-		printf '\0\0\376\377'
-	fi &&
+	add_utf32_bom &&
 	iconv -f UTF-8 -t UTF-32
 }
-- 
2.39.2.13.g1fb56cf030

