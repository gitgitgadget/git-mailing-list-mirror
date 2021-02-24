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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D43C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAB564F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhBXT5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhBXTx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE9C061223
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h98so3027962wrh.11
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gGJSV4KxLtrBBgeCEs4RL+dZPUAVeroChKdibGZHPc=;
        b=Y9Pvsdz1JS2pJOJZVen5IeI0g4lqgDqPCzt+df6EMqRmWblRgXJE95QXvDozQl1ON4
         PENZC96o+iy8kQAm6CCUhp4zrQlVsdnJU67u6V1tDjgDebfSXUEOb4PDJWP6ts8ssZF9
         Mg9Gvzk5u56xkozoYdbmnnFRvLTphtWqjDVRf9x3YMIvm5mgax9+PfttSDvdBSp2fpFw
         JEg590E6qc6S+XDdsHwEoCknQAKVIz9A+gfQuRFED9WLBJe89s3VDDqe14MXk33vma3g
         aALlw0L+knU5KAUYg4LoV6WZ9dxYGXlKNNhWt/5fgiCIVZyYCDt4nxvxO4qzVELynS6H
         3V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gGJSV4KxLtrBBgeCEs4RL+dZPUAVeroChKdibGZHPc=;
        b=MEQCtcEMJEB9/NzrmUOqxyg2SNP0NkLQqe7pb5cGgTIHoiZmS242FwrgDBxXAOmiud
         fSTaXzphcAtjXdV/nqTWK4QMcB8Ruqf+cZyWgFqOHJneDzan7ipyUERfTJp3nv5eKRAO
         0rq2EMgj2HxNGZPmvxPWbqJ4OuNxsKNZvWGIGrQRHm+7nvtlyK3Ku+4a2yFq9RsD5eCF
         fCFkfT/Ths8LRdDd8WyEn/TLsHJJpIWhp2lVtwh4aiMhYdd00TPQb1HCCa2wIClE6M5H
         pcHTO92j85DG3Xsn36I2x9/amiQyWWcSTIFK2qoaKdFfZfmJ0XosakJ8+KkgtcT5r+9S
         FBPQ==
X-Gm-Message-State: AOAM530rvogACf/MnHAFSMFU4gIM/BVI7PdfwtGNoFFOrrKfVQueUSUR
        PbO2qBI1b4Qq2CUHziM54IgtJjwNLaY/4g==
X-Google-Smtp-Source: ABdhPJyQrO7Kid1bpX8K7h0BU5IFJXyeEdpk1Qni/h8J4tqzcrRoDbsf/6dxCaMSRSdBpMcbmTVYmw==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr20824847wrp.61.1614196329686;
        Wed, 24 Feb 2021 11:52:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:09 -0800 (PST)
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
Subject: [PATCH v3 20/35] userdiff tests: assert that new built-in drivers have tests
Date:   Wed, 24 Feb 2021 20:51:14 +0100
Message-Id: <20210224195129.4004-21-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an assertion to the userdiff test framework to check that
everything except a narrow whitelist of existing built-in patterns has
tests.

Since this test framework was added we've added new patterns without
any tests. Let's make it obvious in the future in the diff for such
patches that they should have those tests.

For anything with tests we can skip the "does the pattern compile?"
test, as the actual tests will check that for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index b80546b4d7f..a3058fda130 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -15,6 +15,19 @@ test_expect_success 'setup' '
 	sort <builtin-drivers >builtin-drivers.sorted &&
 	test_cmp builtin-drivers.sorted builtin-drivers &&
 
+	# Do not add anything to this list. New built-in drivers should have
+	# tests
+	cat >drivers-no-tests <<-\EOF &&
+	ada
+	bibtex
+	csharp
+	html
+	objc
+	pascal
+	ruby
+	tex
+	EOF
+
 	# for regexp compilation tests
 	echo A >A.java &&
 	echo B >B.java
@@ -22,7 +35,12 @@ test_expect_success 'setup' '
 
 for p in $(cat builtin-drivers)
 do
-	test_expect_success "builtin $p pattern compiles" '
+	P=$(echo $p | tr 'a-z' 'A-Z')
+	if grep -q $p drivers-no-tests
+	then
+		test_set_prereq NO_TEST_FOR_DRIVER_$P
+	fi
+	test_expect_success NO_TEST_FOR_DRIVER_$P "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index \
 			A.java B.java 2>msg &&
@@ -119,11 +137,17 @@ test_diff_funcname () {
 	'
 }
 
+>drivers-had-no-tests
 for what in $diffpatterns
 do
 	test="$TEST_DIRECTORY/t4018/$what.sh"
 	if ! test -e "$test"
 	then
+		git -C t4018 ls-files ':!*.sh' "$what*" >other-tests &&
+		if ! test -s other-tests
+		then
+			echo $what >>drivers-had-no-tests
+		fi
 		continue
 	fi &&
 
@@ -135,4 +159,8 @@ do
 	. "$test"
 done
 
+test_expect_success 'we should not have new built-in drivers without tests' '
+	test_cmp drivers-no-tests drivers-had-no-tests
+'
+
 test_done
-- 
2.30.0.284.gd98b1dd5eaa7

