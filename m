Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A17BC433E1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43B46198A
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCSTZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSTY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 15:24:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC401C06175F
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:24:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t9so10189515wrn.11
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iwuLh8vUp66xPFg4atTDb6/Qpqib2k+e5+EdO5JGjsA=;
        b=LjmyP9C+ok3TUIGaNZOkn3qaO5RZBQheSIkgaWdEk95QRQOImQMb0PnGVBmK/sdaxo
         AGSnv/9olU2k66puF04dji5PaQmJN4QOYVQ2S/sGgmeN/SeZx3eAad1NwD+pxjb2OhpZ
         EhZf3DNieppIgHI98ptiw6dViAMFCoT094duLAa7BEYxofDGRYyzNB7mr7JtxLV008+V
         9/9UxnQe/w7ixUmg15QjlzYQMHSZTkMh2/YYrZsv+pI1mk+X8inHwuYEhaHxCOjECR8h
         yHPTEFtqjJe00aJSXOImBpQaT2NhNj/XJf+raOvsocXpG3b3MJrBqQKkZ3fYOaRqiCEF
         br3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iwuLh8vUp66xPFg4atTDb6/Qpqib2k+e5+EdO5JGjsA=;
        b=i/neZyYDuwUQ5fXfQSG/A/oRsTIS2aSvwuWnux+d0yaTYvreuuUeEkJHez0IbT1byD
         yI9RWx/MiwlGDDJCVNUc3+SBuXHw16EaY1GnF8IU5NIWbCHiX9LcJ3cLPs4YsR9yBaL6
         U38Eavxv2NefIo7DSMQtt+kLMK8y56IDbtZ1ph7HmAl1kgUkF25jqimRCN4v5VumcfQ6
         uMeUbqRTO/rr1tIK0ArImPRfyg14N++tZTNOewSlcWVW3UtUwNrB2wG2V5SxmoZQj9bc
         5BFMvUfAaYa+MUxQtb1rdEUvI40DxzNzFPQRsIHDu6RbEM9Q8QK7JLYPFQhfk8dTLAPj
         YmPw==
X-Gm-Message-State: AOAM531MZ8f/DvW4j1ayp6HNO3DkghagG3baT5zbamuCsxGWxRqW+bXI
        Q5jhnqmalcjxK+G1Dh+/CJw3z1+flJE=
X-Google-Smtp-Source: ABdhPJzV16pxUjtkaF21rjFupyR2ORtn4a6RqBsG191BRJxdr+MbPpfdYIWxud7NiLst3r3otPpdQw==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr6065976wrq.39.1616181896217;
        Fri, 19 Mar 2021 12:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm11582062wrs.81.2021.03.19.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:24:55 -0700 (PDT)
Message-Id: <a31a147a34f809cb1eaa973890c7d50eb5a3ffb8.1616181893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.982.v2.git.git.1616181893.gitgitgadget@gmail.com>
References: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com>
        <pull.982.v2.git.git.1616181893.gitgitgadget@gmail.com>
From:   "krush11 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 19:24:53 +0000
Subject: [PATCH v2 2/2] replaced test -f and test ! -f
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Krushnal Patel <krushnalpatel11@gmail.com>,
        krush11 <krushnalpatel11@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: krush11 <krushnalpatel11@gmail.com>

test -f relates to 'must exist as a file' and similarly,
test ! -f relates to 'must not exist as a file'.
So, test -f can be replaced with test_path_exists and test ! -f can be replaced by test_path_is_missing.

Signed-off-by: Krushnal Patel <krushnalpatel11@gmail.com>
---
 t/t7300-clean.sh | 376 +++++++++++++++++++++++------------------------
 1 file changed, 188 insertions(+), 188 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a599c4210085..d1777ff084e6 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -28,15 +28,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so &&
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so &&
 	git update-index --no-skip-worktree .gitignore &&
 	git checkout .gitignore
 '
@@ -46,15 +46,15 @@ test_expect_success 'git clean' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -63,15 +63,15 @@ test_expect_success 'git clean src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -80,15 +80,15 @@ test_expect_success 'git clean src/ src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ src/ &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -97,16 +97,16 @@ test_expect_success 'git clean with prefix' '
 	mkdir -p build docs src/test &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
 	(cd src/ && git clean) &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file src/test/1.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists src/test/1.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -162,16 +162,16 @@ test_expect_success 'git clean -d with prefix and path' '
 	mkdir -p build docs src/feature &&
 	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
 	(cd src/ && git clean -d feature/) &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test_path_is_file src/part3.c &&
-	test ! -f src/feature/file.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_exists src/part3.c &&
+	test_path_is_missing src/feature/file.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -181,16 +181,16 @@ test_expect_success SYMLINKS 'git clean symbolic link' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	ln -s docs/manual.txt src/part4.c &&
 	git clean &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f src/part4.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part4.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -198,13 +198,13 @@ test_expect_success 'git clean with wildcard' '
 
 	touch a.clean b.clean other.c &&
 	git clean "*.clean" &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.clean &&
-	test ! -f b.clean &&
-	test_path_is_file other.c
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.clean &&
+	test_path_is_missing b.clean &&
+	test_path_exists other.c
 
 '
 
@@ -213,15 +213,15 @@ test_expect_success 'git clean -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test_path_is_file src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_exists src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -230,15 +230,15 @@ test_expect_success 'git clean -d' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
 	test ! -d docs &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -247,16 +247,16 @@ test_expect_success 'git clean -d src/ examples/' '
 	mkdir -p build docs examples &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
 	git clean -d src/ examples/ &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test ! -f src/part3.c &&
-	test ! -f examples/1.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing examples/1.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -265,15 +265,15 @@ test_expect_success 'git clean -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -x &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test ! -f obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -282,14 +282,14 @@ test_expect_success 'git clean -d -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
 	test ! -d docs &&
-	test ! -f obj.o &&
+	test_path_is_missing obj.o &&
 	test ! -d build
 
 '
@@ -299,14 +299,14 @@ test_expect_success 'git clean -d -x with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x -e src &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test_path_is_file src/part3.c &&
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_exists src/part3.c &&
 	test ! -d docs &&
-	test ! -f obj.o &&
+	test_path_is_missing obj.o &&
 	test ! -d build
 
 '
@@ -316,15 +316,15 @@ test_expect_success 'git clean -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -X &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test_path_is_file src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test ! -f obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_exists src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -333,14 +333,14 @@ test_expect_success 'git clean -d -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test_path_is_file src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test ! -f obj.o &&
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_exists src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_is_missing obj.o &&
 	test ! -d build
 
 '
@@ -350,14 +350,14 @@ test_expect_success 'git clean -d -X with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X -e src &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test ! -f obj.o &&
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_is_missing obj.o &&
 	test ! -d build
 
 '
@@ -381,29 +381,29 @@ test_expect_success 'clean.requireForce and -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test_path_is_file Makefile &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test_path_is_file a.out &&
-	test_path_is_file src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists Makefile &&
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_exists a.out &&
+	test_path_exists src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
 test_expect_success 'clean.requireForce and -f' '
 
 	git clean -f &&
-	test_path_is_file README &&
-	test_path_is_file src/part1.c &&
-	test_path_is_file src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test_path_is_file docs/manual.txt &&
-	test_path_is_file obj.o &&
-	test_path_is_file build/lib.so
+	test_path_exists README &&
+	test_path_exists src/part1.c &&
+	test_path_exists src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_exists docs/manual.txt &&
+	test_path_exists obj.o &&
+	test_path_exists build/lib.so
 
 '
 
@@ -446,10 +446,10 @@ test_expect_success 'nested git work tree' '
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -d &&
-	test_path_is_file foo/.git/index &&
-	test_path_is_file foo/hello.world &&
-	test_path_is_file baz/boo/.git/index &&
-	test_path_is_file baz/boo/deeper.world &&
+	test_path_exists foo/.git/index &&
+	test_path_exists foo/hello.world &&
+	test_path_exists baz/boo/.git/index &&
+	test_path_exists baz/boo/deeper.world &&
 	! test -d bar
 '
 
@@ -488,12 +488,12 @@ test_expect_success 'should not clean submodules' '
 	git checkout before_sub2 &&
 	>to_clean/should_clean.this &&
 	git clean -f -d &&
-	test_path_is_file repo/.git/index &&
-	test_path_is_file repo/hello.world &&
-	test_path_is_file sub1/.git &&
-	test_path_is_file sub1/hello.world &&
-	test_path_is_file sub2/.git &&
-	test_path_is_file sub2/hello.world &&
+	test_path_exists repo/.git/index &&
+	test_path_exists repo/hello.world &&
+	test_path_exists sub1/.git &&
+	test_path_exists sub1/hello.world &&
+	test_path_exists sub2/.git &&
+	test_path_exists sub2/hello.world &&
 	test_path_is_missing to_clean
 '
 
@@ -506,8 +506,8 @@ test_expect_success POSIXPERM,SANITY 'should avoid cleaning possible submodules'
 	chmod 0 possible_sub1/.git &&
 	>to_clean/should_clean.this &&
 	git clean -f -d &&
-	test_path_is_file possible_sub1/.git &&
-	test_path_is_file possible_sub1/hello.world &&
+	test_path_exists possible_sub1/.git &&
+	test_path_exists possible_sub1/hello.world &&
 	test_path_is_missing to_clean
 '
 
@@ -517,7 +517,7 @@ test_expect_success 'nested (empty) git should be kept' '
 	mkdir to_clean &&
 	>to_clean/should_clean.this &&
 	git clean -f -d &&
-	test_path_is_file empty_repo/.git/HEAD &&
+	test_path_exists empty_repo/.git/HEAD &&
 	test_path_is_missing to_clean
 '
 
@@ -559,9 +559,9 @@ test_expect_success 'giving path in nested git work tree will NOT remove it' '
 		test_commit msg bar/baz/hello.world
 	) &&
 	git clean -f -d repo/bar/baz &&
-	test_path_is_file repo/.git/HEAD &&
+	test_path_exists repo/.git/HEAD &&
 	test_path_is_dir repo/bar/ &&
-	test_path_is_file repo/bar/baz/hello.world
+	test_path_exists repo/bar/baz/hello.world
 '
 
 test_expect_success 'giving path to nested .git will not remove it' '
@@ -573,7 +573,7 @@ test_expect_success 'giving path to nested .git will not remove it' '
 		test_commit msg hello.world
 	) &&
 	git clean -f -d repo/.git &&
-	test_path_is_file repo/.git/HEAD &&
+	test_path_exists repo/.git/HEAD &&
 	test_path_is_dir repo/.git/refs &&
 	test_path_is_dir repo/.git/objects &&
 	test_path_is_dir untracked/
@@ -589,7 +589,7 @@ test_expect_success 'giving path to nested .git/ will NOT remove contents' '
 	) &&
 	git clean -f -d repo/.git/ &&
 	test_path_is_dir repo/.git &&
-	test_path_is_file repo/.git/HEAD &&
+	test_path_exists repo/.git/HEAD &&
 	test_path_is_dir untracked/
 '
 
@@ -663,11 +663,11 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	touch foo/bar foo/baz foo/a/aa/ignoreme foo/b/ignoreme foo/b/bb/1 foo/b/bb/2 &&
 	git clean -df &&
 	test_path_is_dir foo &&
-	test_path_is_file foo/bar &&
+	test_path_exists foo/bar &&
 	test_path_is_missing foo/baz &&
-	test_path_is_file foo/a/aa/ignoreme &&
+	test_path_exists foo/a/aa/ignoreme &&
 	test_path_is_missing foo/a/aa/aaa &&
-	test_path_is_file foo/b/ignoreme &&
+	test_path_exists foo/b/ignoreme &&
 	test_path_is_missing foo/b/bb
 '
 
@@ -688,9 +688,9 @@ test_expect_success 'git clean -d skips nested repo containing ignored files' '
 
 	git clean -fd &&
 
-	test_path_is_file nested-repo-with-ignored-file/.git/index &&
-	test_path_is_file nested-repo-with-ignored-file/ignoreme &&
-	test_path_is_file nested-repo-with-ignored-file/file
+	test_path_exists nested-repo-with-ignored-file/.git/index &&
+	test_path_exists nested-repo-with-ignored-file/ignoreme &&
+	test_path_exists nested-repo-with-ignored-file/file
 '
 
 test_expect_success 'git clean handles being told what to clean' '
-- 
gitgitgadget
