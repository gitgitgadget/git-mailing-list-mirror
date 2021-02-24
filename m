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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E603C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4396564F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhBXTx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhBXTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A2C0617A7
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so3037046wrd.6
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOfhct70mj0/lRM5+pXeLT20kW9w8bK9KR3a20Tq3vc=;
        b=L6waIUu5LRNsF9mv8LFQXIXbZ3j8dgJmGatdDOYPJeKOxWkKNDuN9WOC0vA26jN5Eu
         4Msuy5n0+/QWuIOcQPsX7tntUFJC3R/SxstKNqOPvgLAxOt2Xyn6QNstUD20G6qM8pNP
         8mVG+npzwV5vZX69OG3ZZzxkEiZV1cDjMyYTuPbcxCwJrrGrxT0dwZ+5kMbLeQMv5Nxj
         x5VtuA8FFQPcOkfR+4Y7hiFh+pibreSI8tV0ywi1MRYn3iqK2tZhNYO1OFuJ3od10n+z
         6X5MH2tWxhK0qa8sWAXCVpA8/uAaCM20n2/WzH0PHTmT55+c5IqUI1O6K1ahTWPNVk97
         CphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOfhct70mj0/lRM5+pXeLT20kW9w8bK9KR3a20Tq3vc=;
        b=EiY8tcC2he+BnsScdDbULA1kSK4jewWklO8A0aTcjJKUIFQjJl2jBMCLLO2VgmAPfN
         hy3bFG+PIaoBC54s3OgGqkA+Bk8tqtyaVAh0ijijwe7ZzPFLdgIbMx9qAbW06OKzUXEy
         Oo/UGWAaPBVfyAGIbSuRTmgrhpW6pPxwfHNkZoPI7njV5xl5nLcpuikLAu9bTxiFBwNv
         woKa47heLG9aeoBVoPQ7bVm4PUYfI2EnnenmCJwA/EKvm3fWAybOvvn56tXBDCe8z2wL
         7gf7wJ+Yhn9C+IrOYW4OMnK0qcZAks7nYvGecxoQTZRn8kSFyRRFakx3chGZ1L1CrNAF
         A1/w==
X-Gm-Message-State: AOAM531hBrUNfq5cRaiy/Gs9YO/0s4yzKukMaPHin+Br2YfUz37crzN8
        AdbZRwV2990fkAwS+kGoy7Oc3yw6v8tHDw==
X-Google-Smtp-Source: ABdhPJwA01WzQA3fdxlc4ACJn1q5xgmzkN2WMNV6MEmn/pSKwbR1cKOVPoymbWovoSqxBXVYFF0ugg==
X-Received: by 2002:a05:6000:1101:: with SMTP id z1mr33844626wrw.110.1614196320943;
        Wed, 24 Feb 2021 11:52:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:00 -0800 (PST)
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
Subject: [PATCH v3 10/35] blame tests: simplify userdiff driver test
Date:   Wed, 24 Feb 2021 20:51:04 +0100
Message-Id: <20210224195129.4004-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) to use the --author support recently
added in 999cfc4f45 (test-lib functions: add --author support to
test_commit, 2021-01-12).

We also did not need the full fortran-external-function content. Let's
cut it down to just the important parts, and further modify it to
demonstrate that the fortran-specific userdiff function is in effect
by adding "DO NOT MATCH ..." and "AS THE ..." lines surrounding the
"RIGHT" one. This is to check that we're using the userdiff "fortran"
driver, as opposed to the default driver.

The test also left behind a .gitattributes files, let's clean it up
with "test_when_finished".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 04a2c58594c..d3b299e75cb 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -479,32 +479,26 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
 '
 
-test_expect_success 'setup -L :funcname with userdiff driver' '
-	echo "fortran-* diff=fortran" >.gitattributes &&
-	fortran_file=fortran-external-function &&
-	cat >$fortran_file <<-\EOF &&
+test_expect_success 'blame -L :funcname with userdiff driver' '
+	cat >file.template <<-\EOF &&
+	DO NOT MATCH THIS LINE
 	function RIGHT(a, b) result(c)
+	AS THE DEFAULT DRIVER WOULD
 
 	integer, intent(in) :: ChangeMe
-	integer, intent(in) :: b
-	integer, intent(out) :: c
-
-	c = a+b
-
-	end function RIGHT
 	EOF
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
-	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
-	mv "$fortran_file".tmp "$fortran_file" &&
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
-	git commit -m "change fortran file"
-'
 
-test_expect_success 'blame -L :funcname with userdiff driver' '
-	check_count -f fortran-external-function -L:RIGHT A 7 B 1
+	fortran_file=file.f03 &&
+	test_when_finished "rm .gitattributes" &&
+	echo "$fortran_file diff=fortran" >.gitattributes &&
+
+	test_commit --author "A <A@test.git>" \
+		"add" "$fortran_file" \
+		"$(cat file.template)" &&
+	test_commit --author "B <B@test.git>" \
+		"change" "$fortran_file" \
+		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
+	check_count -f "$fortran_file" -L:RIGHT A 3 B 1
 '
 
 test_expect_success 'setup incremental' '
-- 
2.30.0.284.gd98b1dd5eaa7

