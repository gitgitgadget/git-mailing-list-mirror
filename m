Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E42C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D4320759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="o5QgZgf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbgKDUeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbgKDUed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:33 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8E6C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:33 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n63so7647965qte.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lbaPV17AcHOGfhR/neKqPzAHtfoFiFxXZYHRMTvLD8=;
        b=o5QgZgf7KQxSeI5C94ldI4JU7VxtOrlP2GHoxW5hd7R6k3dbQ16FPJbf+/FbdAA6a8
         1M+Jp/tTltPGjgsViZj/zGCYLCbwvBu4SIu9DTHJBAAWI9AWQvkalUO8OA47U7pexfl1
         hH2LF+G1NIeUOZaRKgOycLj73J+JuhR9KR03vCb+Ru6wcmlvi/VfNIA+OD+0khIUFEf7
         IImWNAJh9LJI6E5DoyNPCxLf8zH7c8lTahnlEhf7963LhbvGWLBmUVBDP7wBjJwadZUg
         ugmXKA/uOcF5MgqSf+NyNJ+njodbMrnZecogRgFfeHhfaKCGFL//QuvWDTqkoCnrhhhm
         LJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lbaPV17AcHOGfhR/neKqPzAHtfoFiFxXZYHRMTvLD8=;
        b=Nkyqjv4397jcNDq1lFfrIs/HujLS7q0m+kbwkEq4cSYCjy5oZTEff4nN2ro6GWobYh
         gskBrQTB8JRTrd/WZb5A44V1AXvd77ik4XjiP/xqZJ93SRO0s9NVLwGtwEpcV8g9216s
         NbENdXMOGDzkK2p1GF5+YnlRdOx6E7Uc4esdCIUi5N85PDeJk7SvkHSySKXiLt9iXiGi
         T7WFRc3w2oVw03EkxdvyrVEnwfkQnRhPC5KmT0UYosy4kvrq1lNuIr+5hL6bQD9CWvnG
         /qpaH/de4W0/Btu4BAy5vT3J9pn4gc1Rp7+kC99KoF7masBbr4owZEaY5xAvXW3dYzs1
         N0bg==
X-Gm-Message-State: AOAM530g21yb6XcYFoG1VaTEMNblBeNYcQvqKM6UGNKlPp0It07irkGp
        erriVgjcNmplNp1wou0y21fMzjQGzSGIEA==
X-Google-Smtp-Source: ABdhPJyXB6LgX2oMFLXK6GOgocfca3CHluYsNNX1gE7Kqf4StpiAvlaEkc4SXT5CZu8GemKDwCb4vg==
X-Received: by 2002:ac8:5755:: with SMTP id 21mr21701049qtx.109.1604522071693;
        Wed, 04 Nov 2020 12:34:31 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:30 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 18/19] parallel-checkout: add tests related to .gitattributes
Date:   Wed,  4 Nov 2020 17:33:17 -0300
Message-Id: <86fccd57d50dc97203f677a420a553d3f776fee0.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to confirm that `struct conv_attrs` data is correctly passed
from the main process to the workers, and that they properly smudge
files before writing to the working tree. Also check that
non-parallel-eligible entries, such as regular files that require
external filters, are correctly smudge and written when
parallel-checkout is enabled.

Note: to avoid repeating code, some helper functions are extracted from
t0028 into a common lib file.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-encoding.sh                       |  25 ++++
 t/t0028-working-tree-encoding.sh        |  25 +---
 t/t2082-parallel-checkout-attributes.sh | 174 ++++++++++++++++++++++++
 3 files changed, 200 insertions(+), 24 deletions(-)
 create mode 100644 t/lib-encoding.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
new file mode 100644
index 0000000000..c52ffbbed5
--- /dev/null
+++ b/t/lib-encoding.sh
@@ -0,0 +1,25 @@
+# Encoding helpers used by t0028 and t2082
+
+test_lazy_prereq NO_UTF16_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
+'
+
+test_lazy_prereq NO_UTF32_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
+'
+
+write_utf16 () {
+	if test_have_prereq NO_UTF16_BOM
+	then
+		printf '\376\377'
+	fi &&
+	iconv -f UTF-8 -t UTF-16
+}
+
+write_utf32 () {
+	if test_have_prereq NO_UTF32_BOM
+	then
+		printf '\0\0\376\377'
+	fi &&
+	iconv -f UTF-8 -t UTF-32
+}
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index bfc4fb9af5..4fffc3a639 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -3,33 +3,10 @@
 test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-encoding.sh"
 
 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
 
-test_lazy_prereq NO_UTF16_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
-'
-
-test_lazy_prereq NO_UTF32_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
-'
-
-write_utf16 () {
-	if test_have_prereq NO_UTF16_BOM
-	then
-		printf '\376\377'
-	fi &&
-	iconv -f UTF-8 -t UTF-16
-}
-
-write_utf32 () {
-	if test_have_prereq NO_UTF32_BOM
-	then
-		printf '\0\0\376\377'
-	fi &&
-	iconv -f UTF-8 -t UTF-32
-}
-
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
new file mode 100755
index 0000000000..6800574588
--- /dev/null
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+
+test_description='parallel-checkout: attributes
+
+Verify that parallel-checkout correctly creates files that require
+conversions, as specified in .gitattributes. The main point here is
+to check that the conv_attr data is correctly sent to the workers
+and that it contains sufficient information to smudge files
+properly (without access to the index or attribute stack).
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
+. "$TEST_DIRECTORY/lib-encoding.sh"
+
+test_expect_success 'parallel-checkout with ident' '
+	git init ident &&
+	(
+		cd ident &&
+		echo "A ident" >.gitattributes &&
+		echo "\$Id\$" >A &&
+		echo "\$Id\$" >B &&
+		git add -A &&
+		git commit -m id &&
+
+		rm A B &&
+		git_pc 2 0 2 reset --hard &&
+		hexsz=$(test_oid hexsz) &&
+		grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
+		grep "\\\$Id\\\$" B
+	)
+'
+
+test_expect_success 'parallel-checkout with re-encoding' '
+	git init encoding &&
+	(
+		cd encoding &&
+		echo text >utf8-text &&
+		cat utf8-text | write_utf16 >utf16-text &&
+
+		echo "A working-tree-encoding=UTF-16" >.gitattributes &&
+		cp utf16-text A &&
+		cp utf16-text B &&
+		git add A B .gitattributes &&
+		git commit -m encoding &&
+
+		# Check that A (and only A) is stored in UTF-8
+		git cat-file -p :A >A.internal &&
+		test_cmp_bin utf8-text A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp_bin utf16-text B.internal &&
+
+		# Check that A is re-encoded during checkout
+		rm A B &&
+		git_pc 2 0 2 checkout A B &&
+		test_cmp_bin utf16-text A
+	)
+'
+
+test_expect_success 'parallel-checkout with eol conversions' '
+	git init eol &&
+	(
+		cd eol &&
+		git config core.autocrlf false &&
+		printf "multi\r\nline\r\ntext" >crlf-text &&
+		printf "multi\nline\ntext" >lf-text &&
+
+		echo "A text eol=crlf" >.gitattributes &&
+		echo "B -text" >>.gitattributes &&
+		cp crlf-text A &&
+		cp crlf-text B &&
+		git add A B .gitattributes &&
+		git commit -m eol &&
+
+		# Check that A (and only A) is stored with LF format
+		git cat-file -p :A >A.internal &&
+		test_cmp_bin lf-text A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp_bin crlf-text B.internal &&
+
+		# Check that A is converted to CRLF during checkout
+		rm A B &&
+		git_pc 2 0 2 checkout A B &&
+		test_cmp_bin crlf-text A
+	)
+'
+
+test_cmp_str()
+{
+	echo "$1" >tmp &&
+	test_cmp tmp "$2"
+}
+
+# Entries that require an external filter are not eligible for parallel
+# checkout. Check that both the parallel-eligible and non-eligible entries are
+# properly writen in a single checkout process.
+#
+test_expect_success 'parallel-checkout and external filter' '
+	git init filter &&
+	(
+		cd filter &&
+		git config filter.x2y.clean "tr x y" &&
+		git config filter.x2y.smudge "tr y x" &&
+		git config filter.x2y.required true &&
+
+		echo "A filter=x2y" >.gitattributes &&
+		echo x >A &&
+		echo x >B &&
+		echo x >C &&
+		git add -A &&
+		git commit -m filter &&
+
+		# Check that A (and only A) was cleaned
+		git cat-file -p :A >A.internal &&
+		test_cmp_str y A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp_str x B.internal &&
+		git cat-file -p :C >C.internal &&
+		test_cmp_str x C.internal &&
+
+		rm A B C *.internal &&
+		git_pc 2 0 2 checkout A B C &&
+		test_cmp_str x A &&
+		test_cmp_str x B &&
+		test_cmp_str x C
+	)
+'
+
+# The delayed queue is independent from the parallel queue, and they should be
+# able to work together in the same checkout process.
+#
+test_expect_success PERL 'parallel-checkout and delayed checkout' '
+	write_script rot13-filter.pl "$PERL_PATH" \
+		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
+	test_config_global filter.delay.process \
+		"\"$(pwd)/rot13-filter.pl\" \"$(pwd)/delayed.log\" clean smudge delay" &&
+	test_config_global filter.delay.required true &&
+
+	echo "a b c" >delay-content &&
+	echo "n o p" >delay-rot13-content &&
+
+	git init delayed &&
+	(
+		cd delayed &&
+		echo "*.a filter=delay" >.gitattributes &&
+		cp ../delay-content test-delay10.a &&
+		cp ../delay-content test-delay11.a &&
+		echo parallel >parallel1.b &&
+		echo parallel >parallel2.b &&
+		git add -A &&
+		git commit -m delayed &&
+
+		# Check that the stored data was cleaned
+		git cat-file -p :test-delay10.a > delay10.internal &&
+		test_cmp delay10.internal ../delay-rot13-content &&
+		git cat-file -p :test-delay11.a > delay11.internal &&
+		test_cmp delay11.internal ../delay-rot13-content &&
+		rm *.internal &&
+
+		rm *.a *.b
+	) &&
+
+	git_pc 2 0 2 -C delayed checkout -f &&
+	verify_checkout delayed &&
+
+	# Check that the *.a files got to the delay queue and were filtered
+	grep "smudge test-delay10.a .* \[DELAYED\]" delayed.log &&
+	grep "smudge test-delay11.a .* \[DELAYED\]" delayed.log &&
+	test_cmp delayed/test-delay10.a delay-content &&
+	test_cmp delayed/test-delay11.a delay-content
+'
+
+test_done
-- 
2.28.0

