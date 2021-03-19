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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A8C433E2
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7896197D
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCSTZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhCSTZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 15:25:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5DC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:24:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x16so10199673wrn.4
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AsKfijQXM3eZHEWe750P1PwrnjivVV0XbPW10M2u0Kg=;
        b=WNL43JcfORNivGPgk9GFIJ/0PcJ0HLiw3HFWwJLXyC+HkAjnQYtnPKq9Gqz1Ref9sv
         XT1iRrjAusjjPasjvy65snnUJWM489VQrFRmHMExp/vllsfh4Ppuyotk5aVj3CIEWQ/1
         uUE1A3tK0QQi8jadbOYHDtGEl0Frx65BY4UzGy3z62yF081msAK9Lz6Bc7cnOR/Oq7iv
         spH/c3RiqROe0/RFTuozbhyzqjHr+ZGr4DF5NH8rTEi3dZttyUennY0aEjv0hFl6JzkX
         pobC02PSSA3xcURAkosESVdc167yoggDAc0vOnEYJT53sfL1PKda//lGlRLLqWupBOFf
         k7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AsKfijQXM3eZHEWe750P1PwrnjivVV0XbPW10M2u0Kg=;
        b=f3m20nLl3lKO7yR3/Z/SpzEFN+0D1K9YcJKQDGJon+5hmSaYFTjh49ufEKzs3A06kq
         cEvd4wE3SdXW/S4Eu3VgnKh8nYDuNEdnEChV2IIlhSV7mN6i7ShkoBna84oAEF999i4k
         hIMI5Ri/rcYSB1WkDyrS1owdIKQnJf7dCdOtUkb7Y96RlHaV8P0Mup/eaayYiHffN1Nh
         3Dp33Y+jgTD25QpZxh66b5PAeRz1i4k0814RtMX2mWHkRIDzvrauHQfcoPax7nFiE4gT
         R0yd7sU0qf0ZsXAw3zOe2VYuY1h1pWBL3xiGMR6peyK2E1fPBxf6Sdqdu6gm7wF/ysd+
         NwoA==
X-Gm-Message-State: AOAM530pKQJIv7Vol1yfqdS1PX5egHKbIPa+VTTJ6sfMZ1KPtJ0O+rHG
        ktc7M4qbLhn7BBulFhdDyHf2hC2ITZ0=
X-Google-Smtp-Source: ABdhPJyyI0hoBh+cOWaZbGxJkM70xhm0SF/wuAtR4meyiCBtIaLTP4mxJRhjC/JaLVnzijp/0Ja4ZQ==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr6176916wrn.349.1616181895613;
        Fri, 19 Mar 2021 12:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm10022166wrj.62.2021.03.19.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:24:55 -0700 (PDT)
Message-Id: <e5f92e3882cd32627d1dcba1271263c93b699b21.1616181893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.982.v2.git.git.1616181893.gitgitgadget@gmail.com>
References: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com>
        <pull.982.v2.git.git.1616181893.gitgitgadget@gmail.com>
From:   "krush11 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 19:24:52 +0000
Subject: [PATCH v2 1/2] replace test -f with test_path_is_file
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

Although  has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace  with test_path_is_file so that future developers
will have a better experience debugging these test cases.

Signed-off-by: Krushnal Patel  <krushnalpatel11@gmail.com>
---
 t/t7300-clean.sh | 276 +++++++++++++++++++++++------------------------
 1 file changed, 138 insertions(+), 138 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a74816ca8b46..a599c4210085 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -28,15 +28,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so &&
 	git update-index --no-skip-worktree .gitignore &&
 	git checkout .gitignore
 '
@@ -46,15 +46,15 @@ test_expect_success 'git clean' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -63,15 +63,15 @@ test_expect_success 'git clean src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -80,15 +80,15 @@ test_expect_success 'git clean src/ src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ src/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -97,16 +97,16 @@ test_expect_success 'git clean with prefix' '
 	mkdir -p build docs src/test &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
 	(cd src/ && git clean) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
 	test ! -f src/part3.c &&
-	test -f src/test/1.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file src/test/1.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -162,16 +162,16 @@ test_expect_success 'git clean -d with prefix and path' '
 	mkdir -p build docs src/feature &&
 	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
 	(cd src/ && git clean -d feature/) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
 	test ! -f src/feature/file.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -181,16 +181,16 @@ test_expect_success SYMLINKS 'git clean symbolic link' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	ln -s docs/manual.txt src/part4.c &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
 	test ! -f src/part4.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -198,13 +198,13 @@ test_expect_success 'git clean with wildcard' '
 
 	touch a.clean b.clean other.c &&
 	git clean "*.clean" &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.clean &&
 	test ! -f b.clean &&
-	test -f other.c
+	test_path_is_file other.c
 
 '
 
@@ -213,15 +213,15 @@ test_expect_success 'git clean -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -230,15 +230,15 @@ test_expect_success 'git clean -d' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
 	test ! -d docs &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -247,16 +247,16 @@ test_expect_success 'git clean -d src/ examples/' '
 	mkdir -p build docs examples &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
 	git clean -d src/ examples/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
 	test ! -f src/part3.c &&
 	test ! -f examples/1.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -265,15 +265,15 @@ test_expect_success 'git clean -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -x &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
+	test_path_is_file docs/manual.txt &&
 	test ! -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file build/lib.so
 
 '
 
@@ -282,10 +282,10 @@ test_expect_success 'git clean -d -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
 	test ! -d docs &&
@@ -299,12 +299,12 @@ test_expect_success 'git clean -d -x with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x -e src &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
-	test -f src/part3.c &&
+	test_path_is_file src/part3.c &&
 	test ! -d docs &&
 	test ! -f obj.o &&
 	test ! -d build
@@ -316,15 +316,15 @@ test_expect_success 'git clean -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -X &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
 	test ! -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file build/lib.so
 
 '
 
@@ -333,13 +333,13 @@ test_expect_success 'git clean -d -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
 	test ! -f obj.o &&
 	test ! -d build
 
@@ -350,13 +350,13 @@ test_expect_success 'git clean -d -X with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X -e src &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
+	test_path_is_file docs/manual.txt &&
 	test ! -f obj.o &&
 	test ! -d build
 
@@ -381,29 +381,29 @@ test_expect_success 'clean.requireForce and -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
 test_expect_success 'clean.requireForce and -f' '
 
 	git clean -f &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
 	test ! -f a.out &&
 	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -446,10 +446,10 @@ test_expect_success 'nested git work tree' '
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -d &&
-	test -f foo/.git/index &&
-	test -f foo/hello.world &&
-	test -f baz/boo/.git/index &&
-	test -f baz/boo/deeper.world &&
+	test_path_is_file foo/.git/index &&
+	test_path_is_file foo/hello.world &&
+	test_path_is_file baz/boo/.git/index &&
+	test_path_is_file baz/boo/deeper.world &&
 	! test -d bar
 '
 
-- 
gitgitgadget

