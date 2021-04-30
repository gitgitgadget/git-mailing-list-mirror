Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0243C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8B461476
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhD3Vlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhD3Vlq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:46 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573CC06138B
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:57 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id r13so184129qvm.7
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24zXgh5ERhP6WetWcVX1R2rce49VOwH6kleFlHsnwFc=;
        b=ViMFUUz4FWBPu9AXek/WW0+RdZmhaAIMRs5dW6VsyvPrw0BExgaThYfDXLbBtaCXZ0
         DgCcC2UwptrTSFwfse56gNYWLZ/IAG3s0BYXOL4EohCG8a8ybB79RrBNtMYBVdklSyBB
         f//6EoE7sPtolaYF41tpwvJeYg8x6d1ADE1bHoYzftwBwJpmN1FSfa6SLdprcylDIXfz
         JokFezsdGD5fcxpveBtTDTohRsJXmsQaIShEi9ytSyBGifZn8r20hgucoKLBBWZBCEnv
         +y0EU26vCVmgs50jY31rb16cu6N57AcatSm9sJPhKL9c5/EcraZQWVQgU/wraiIlwOsa
         4nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24zXgh5ERhP6WetWcVX1R2rce49VOwH6kleFlHsnwFc=;
        b=cX7zjMC6rKTRgEjsZ4SVEmaKiHW5m5XsPZlFQEmweSLVBSfX2YhyZ2pl2ylh0rlZuR
         d/c3a7srYrFyxzktMz4KpZfah2Yv5UNDBOSf9h0xIdWgEc2cjRpFmDnhBPNSk6QLxgGF
         b/6QUSD6Vvj5Fa+oQb5+KyWYi+++uZ15NaZhY1b9MhTapd3zCqP8OQszTcsx4BrPZ5BN
         iePDp3bHVm2+MZdd5q4yYg2naK67o2JIROOl87YxJ6xOPkxJcgCaFEvK3NWy3whm0RqK
         H8zflwWWch2+09YVwU87nqq/hMDrJhy3QwipMTf2U2c3tGlXpXw6enY0QaQFS96ElzlV
         T5tw==
X-Gm-Message-State: AOAM53276YpTJ5lFM4He9qPXKTO4Vdvge584VVggDFi7zktd40gEJzPO
        /VH7K9Roro3LB74oMSYoFLA+l8YD1ioGow==
X-Google-Smtp-Source: ABdhPJyHldMVGydbhIyVXeKmGy67hFYh2B2HN9pApQCygeJ6QjecOCqSEetb+Hs2cQAe10T8q0jsng==
X-Received: by 2002:a05:6214:2467:: with SMTP id im7mr7962359qvb.59.1619818856627;
        Fri, 30 Apr 2021 14:40:56 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 7/8] parallel-checkout: add tests related to .gitattributes
Date:   Fri, 30 Apr 2021 18:40:34 -0300
Message-Id: <bc584897e648cd95ce3c003b5a61d62604bac9e3.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
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

Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t2082-parallel-checkout-attributes.sh | 194 ++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

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

