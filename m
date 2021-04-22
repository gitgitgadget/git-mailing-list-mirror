Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39419C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0738B61222
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhDVPTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhDVPS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EBFC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 66so7069339qkf.2
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJwbUc78YqmzkapRpqUxn8jTO7PGV0uZYBEfCqFIw+E=;
        b=LxGSdPVqnD1iP5Qtdn1lk2QIrV58c55DpX1YWD+LFMiBc0ZNtm1ACMDrydCm5eprNe
         jyHqYtUfSIfrK2YJXcitwfUftla3xnkg99I2ejKIsI64viQcsrd+on49JXkErCkyK5HL
         ML1i5R+q1jB2de1B8+veAEONEQcp1pxgozFeImU6EfLsw7L2hUg0BEhG/YXlsPBFH8qn
         MPnm122Wi+ZWci1Q7PWwahyrLNC/MDQsIk+ZkB8o/zm7DP8Hx7/dGAefWN8sK1UPFzon
         DiYAV76+CkcaJNJtvk+z7VhyYVIHRuNAPBj1m6fET0Htj4Cj7yyitT6pZPlCwX3XnWGO
         ZsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJwbUc78YqmzkapRpqUxn8jTO7PGV0uZYBEfCqFIw+E=;
        b=n+rxwlfa1AW/XxRVRQqU46NkHHEX9y2/eZUAEtSj08UlgCNsg7Be7+SX2r6bzrGH+w
         ZdZC9kizKXIpj12+8A+/jY9gTWvm9IQWb7/NOqkcDUnLbvSXNLmstj2bP0Qv9we1NSUe
         SmKFWnMOs2DFfMUamG9YCSzRwZifTyhTptORO+6LuYxV3tz0C+J0+VRtaHW6LhSeFrUa
         V9/dDdt6gY9e9nspwmT1uJClfT6EdapAW3CfEhsTvWHDXn+IMLZU0Z+h0bS6sIf80oEz
         M46dkP3V2+AY7VcEy66lB+2dkr6xpXxD7zuzSM2DnTP/2aPKfbCZJxr7LcARzdErrLa0
         KC3g==
X-Gm-Message-State: AOAM533l0Vbi+pvnpy3+a4vUj1edvhH8mSQ9tTideSYl8cXnim2Qoygr
        i4ljtFvrvF5Lx/b+dmIvHb/RFb+Gd/7cug==
X-Google-Smtp-Source: ABdhPJw/AATdordA8uVnjLdQ0BKwec46YkV8Ech4ODgwOUI6FQ6i+VnZILaGkr+CgJog47IUWmNf/Q==
X-Received: by 2002:a37:6801:: with SMTP id d1mr4143025qkc.363.1619104700234;
        Thu, 22 Apr 2021 08:18:20 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l16sm2348909qkg.91.2021.04.22.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:18:19 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
Subject: [PATCH 6/7] parallel-checkout: add tests related to .gitattributes
Date:   Thu, 22 Apr 2021 12:17:52 -0300
Message-Id: <3a0845fdbb0481ead96b15be472df636bcf73aee.1619104091.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619104091.git.matheus.bernardino@usp.br>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to confirm that the `struct conv_attrs` data is correctly
passed from the main process to the workers, and that they can properly
convert the blobs before writing them to the working tree.

Also check that parallel-ineligible entries, such as regular files that
require external filters, are correctly smudge and written when
parallel-checkout is enabled.

Note: to avoid repeating code, some helper functions are extracted from
t0028 into a common lib file.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-encoding.sh                       |  25 +++
 t/t0028-working-tree-encoding.sh        |  25 +--
 t/t2082-parallel-checkout-attributes.sh | 194 ++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 24 deletions(-)
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
index f970a9806b..82905a2156 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -6,33 +6,10 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
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
index 0000000000..2525457961
--- /dev/null
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -0,0 +1,194 @@
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
+	set_checkout_config 2 0 &&
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
+		test_checkout_workers 2 git reset --hard &&
+		hexsz=$(test_oid hexsz) &&
+		grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
+		grep "\\\$Id\\\$" B
+	)
+'
+
+test_expect_success 'parallel-checkout with re-encoding' '
+	set_checkout_config 2 0 &&
+	git init encoding &&
+	(
+		cd encoding &&
+		echo text >utf8-text &&
+		write_utf16 <utf8-text >utf16-text &&
+
+		echo "A working-tree-encoding=UTF-16" >.gitattributes &&
+		cp utf16-text A &&
+		cp utf8-text B &&
+		git add A B .gitattributes &&
+		git commit -m encoding &&
+
+		# Check that A is stored in UTF-8
+		git cat-file -p :A >A.internal &&
+		test_cmp_bin utf8-text A.internal &&
+
+		rm A B &&
+		test_checkout_workers 2 git checkout A B &&
+
+		# Check that A (and only A) is re-encoded during checkout
+		test_cmp_bin utf16-text A &&
+		test_cmp_bin utf8-text B
+	)
+'
+
+test_expect_success 'parallel-checkout with eol conversions' '
+	set_checkout_config 2 0 &&
+	git init eol &&
+	(
+		cd eol &&
+		printf "multi\r\nline\r\ntext" >crlf-text &&
+		printf "multi\nline\ntext" >lf-text &&
+
+		git config core.autocrlf false &&
+		echo "A eol=crlf" >.gitattributes &&
+		cp crlf-text A &&
+		cp lf-text B &&
+		git add A B .gitattributes &&
+		git commit -m eol &&
+
+		# Check that A is stored with LF format
+		git cat-file -p :A >A.internal &&
+		test_cmp_bin lf-text A.internal &&
+
+		rm A B &&
+		test_checkout_workers 2 git checkout A B &&
+
+		# Check that A (and only A) is converted to CRLF during checkout
+		test_cmp_bin crlf-text A &&
+		test_cmp_bin lf-text B
+	)
+'
+
+# Entries that require an external filter are not eligible for parallel
+# checkout. Check that both the parallel-eligible and non-eligible entries are
+# properly writen in a single checkout operation.
+#
+test_expect_success 'parallel-checkout and external filter' '
+	set_checkout_config 2 0 &&
+	git init filter &&
+	(
+		cd filter &&
+		write_script <<-\EOF rot13.sh &&
+		tr \
+		  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" \
+		  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM"
+		EOF
+
+		git config filter.rot13.clean "\"$(pwd)/rot13.sh\"" &&
+		git config filter.rot13.smudge "\"$(pwd)/rot13.sh\"" &&
+		git config filter.rot13.required true &&
+
+		echo abcd >original &&
+		echo nopq >rot13 &&
+
+		echo "A filter=rot13" >.gitattributes &&
+		cp original A &&
+		cp original B &&
+		cp original C &&
+		git add A B C .gitattributes &&
+		git commit -m filter &&
+
+		# Check that A (and only A) was cleaned
+		git cat-file -p :A >A.internal &&
+		test_cmp rot13 A.internal &&
+		git cat-file -p :B >B.internal &&
+		test_cmp original B.internal &&
+		git cat-file -p :C >C.internal &&
+		test_cmp original C.internal &&
+
+		rm A B C *.internal &&
+		test_checkout_workers 2 git checkout A B C &&
+
+		# Check that A (and only A) was smudged during checkout
+		test_cmp original A &&
+		test_cmp original B &&
+		test_cmp original C
+	)
+'
+
+# The delayed queue is independent from the parallel queue, and they should be
+# able to work together in the same checkout process.
+#
+test_expect_success PERL 'parallel-checkout and delayed checkout' '
+	write_script rot13-filter.pl "$PERL_PATH" \
+		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
+
+	test_config_global filter.delay.process \
+		"\"$(pwd)/rot13-filter.pl\" --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
+	test_config_global filter.delay.required true &&
+
+	echo "abcd" >original &&
+	echo "nopq" >rot13 &&
+
+	git init delayed &&
+	(
+		cd delayed &&
+		echo "*.d filter=delay" >.gitattributes &&
+		cp ../original W.d &&
+		cp ../original X.d &&
+		cp ../original Y &&
+		cp ../original Z &&
+		git add -A &&
+		git commit -m delayed &&
+
+		# Check that *.d files were cleaned
+		git cat-file -p :W.d >W.d.internal &&
+		test_cmp W.d.internal ../rot13 &&
+		git cat-file -p :X.d >X.d.internal &&
+		test_cmp X.d.internal ../rot13 &&
+		git cat-file -p :Y >Y.internal &&
+		test_cmp Y.internal ../original &&
+		git cat-file -p :Z >Z.internal &&
+		test_cmp Z.internal ../original &&
+
+		rm *
+	) &&
+
+	set_checkout_config 2 0 &&
+	test_checkout_workers 2 git -C delayed checkout -f &&
+	verify_checkout delayed &&
+
+	# Check that the *.d files got to the delay queue and were filtered
+	grep "smudge W.d .* \[DELAYED\]" delayed.log &&
+	grep "smudge X.d .* \[DELAYED\]" delayed.log &&
+	test_cmp delayed/W.d original &&
+	test_cmp delayed/X.d original &&
+
+	# Check that the parallel-eligible entries went to the right queue and
+	# were not filtered
+	! grep "smudge Y .* \[DELAYED\]" delayed.log &&
+	! grep "smudge Z .* \[DELAYED\]" delayed.log &&
+	test_cmp delayed/Y original &&
+	test_cmp delayed/Z original
+'
+
+test_done
-- 
2.30.1

