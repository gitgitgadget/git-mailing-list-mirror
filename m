Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40624C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1EE20866
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRnfN4sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHLT2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgHLT2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:28:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F7AC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:28:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u128so1521961pfb.6
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsicD/rzFZ3xRwZOm6B78uZiPUQAuH9hwQ66exr7NtY=;
        b=BRnfN4sf5zFGyXbHl3aj9dwisHMcR40iTKtzeUgLjaub2lrQj3HVMKrd9+IULCaopQ
         9+nJ/Hz1iKtQw46vPhCd5CCLovi/wplIPJi7ILvG3w98zVIyYYGa0eGx3Ln21ZAf7Djn
         jHDFzYGLFnH98tajeKeKTCJk8HzSw75gpNr5FPnZnLWgOCod+sAG+I0tFM2pbPEAdZ9H
         vZ14+zu4oSQY204ypy2smsHA1T86/25I9UZSQN/bc6rWfyWJ9/37sFJfc8okupp+FHxf
         osJ1nZ9ZWWNTVq+b/pqZFKvCIZXJ6iTwPDEQOdELjnN1mYAO7093viczjpux0tE+WSNE
         b2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsicD/rzFZ3xRwZOm6B78uZiPUQAuH9hwQ66exr7NtY=;
        b=N9XhzfhnHVU4FZy89p0fTBvlx7i6G6MilkLOgziCXNOhW2TKkqi/F48DRog3T6rMnB
         rVBroreeFErwl3HgbkFW/rTXAj6Vr1I7JYOjoADxUb/xBtz846Q2PmlKFpOWJdKrdyLu
         v7JRYz1rn89wiGRJGMtGfBQGDgobIhUvPJ2VgWhc5C9JF24tW2wl13J0dy9aebVOjNEY
         td3kk4ekBRdC9ZtTFOsaHcIyp1I74zdHEYesj4Jtlq19q8llrIplEeIevTsa5j/IjZlW
         m40+Ti32Rt9Rx1PBOsiLT+wiLyPWUVjqyL10nvFeRYhewG4TXWnNZPZhqEwImzX39Ecc
         508A==
X-Gm-Message-State: AOAM531r/WEMtmBXHT7tulJDQoQ+DBBffKz0LZdb5eBJ6um4tu5mnFUR
        maGYVGiJiEhIv5Neww1xvv0=
X-Google-Smtp-Source: ABdhPJx+NDAxycueV3uQUNlb/mqy2N0mFfpkfA21CMBJ2ZRGKGRI8zuJGIFff1oiPKeQNuC+Fzbp3Q==
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr986017pfc.130.1597260482831;
        Wed, 12 Aug 2020 12:28:02 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id f3sm3463334pfj.206.2020.08.12.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:28:02 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@taylorr.com>
Subject: [PATCH v2 3/4] t7401: change indentation for enhanced readability
Date:   Thu, 13 Aug 2020 00:57:36 +0530
Message-Id: <20200812192737.13971-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812192737.13971-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the indentation of expected outputs for enhanced readability of
the tests.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Taylor Blau <me@taylorr.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 128 +++++++++++++++++------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 53943c9cc9..dd0e88fc6a 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -39,10 +39,10 @@ test_expect_success 'added submodule' "
 	git add sm1 &&
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 0000000...$head1 (2):
-  > Add foo2
+	* sm1 0000000...$head1 (2):
+	  > Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -53,10 +53,10 @@ test_expect_success 'added submodule (subdirectory)' "
 		git submodule summary >../actual
 	) &&
 	cat >expected <<-EOF &&
-* ../sm1 0000000...$head1 (2):
-  > Add foo2
+	* ../sm1 0000000...$head1 (2):
+	  > Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -74,10 +74,10 @@ test_expect_success 'added submodule (subdirectory with explicit path)' "
 		git submodule summary ../sm1 >../actual
 	) &&
 	cat >expected <<-EOF &&
-* ../sm1 0000000...$head1 (2):
-  > Add foo2
+	* ../sm1 0000000...$head1 (2):
+	  > Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -87,20 +87,20 @@ head2=$(add_file sm1 foo3)
 test_expect_success 'modified submodule(forward)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head1...$head2 (1):
-  > Add foo3
+	* sm1 $head1...$head2 (1):
+	  > Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success 'modified submodule(forward), --files' "
 	git submodule summary --files >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head1...$head2 (1):
-  > Add foo3
+	* sm1 $head1...$head2 (1):
+	  > Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -111,10 +111,10 @@ test_expect_success 'no ignore=all setting has any effect' "
 	git config diff.ignoreSubmodules all &&
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head1...$head2 (1):
-  > Add foo3
+	* sm1 $head1...$head2 (1):
+	  > Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual &&
 	git config --unset diff.ignoreSubmodules &&
 	git config --remove-section submodule.sm1 &&
@@ -133,11 +133,11 @@ head3=$(
 test_expect_success 'modified submodule(backward)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head2...$head3 (2):
-  < Add foo3
-  < Add foo2
+	* sm1 $head2...$head3 (2):
+	  < Add foo3
+	  < Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -146,25 +146,25 @@ head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(backward and forward)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head2...$head4 (4):
-  > Add foo5
-  > Add foo4
-  < Add foo3
-  < Add foo2
+	* sm1 $head2...$head4 (4):
+	  > Add foo5
+	  > Add foo4
+	  < Add foo3
+	  < Add foo2
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success '--summary-limit' "
 	git submodule summary -n 3 >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head2...$head4 (4):
-  > Add foo5
-  > Add foo4
-  < Add foo3
+	* sm1 $head2...$head4 (4):
+	  > Add foo5
+	  > Add foo4
+	  < Add foo3
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -179,20 +179,20 @@ mv sm1-bak sm1
 test_expect_success 'typechanged submodule(submodule->blob), --cached' "
 	git submodule summary --cached >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head4(submodule)->$head5(blob) (3):
-  < Add foo5
+	* sm1 $head4(submodule)->$head5(blob) (3):
+	  < Add foo5
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
 	git submodule summary --files >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head5(blob)->$head4(submodule) (3):
-  > Add foo5
+	* sm1 $head5(blob)->$head4(submodule) (3):
+	  > Add foo5
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -201,9 +201,9 @@ git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head4(submodule)->$head5(blob):
+	* sm1 $head4(submodule)->$head5(blob):
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -213,10 +213,10 @@ head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head4...$head6:
-  Warn: sm1 doesn't contain commit $head4_full
+	* sm1 $head4...$head6:
+	  Warn: sm1 doesn't contain commit $head4_full
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -224,10 +224,10 @@ commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head5(blob)->$head6(submodule) (2):
-  > Add foo7
+	* sm1 $head5(blob)->$head6(submodule) (2):
+	  > Add foo7
 
-EOF
+	EOF
 	test_i18ncmp expected actual
 "
 
@@ -236,9 +236,9 @@ rm -rf sm1
 test_expect_success 'deleted submodule' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -251,22 +251,22 @@ test_expect_success 'create second submodule' '
 test_expect_success 'multiple submodules' "
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success 'path filter' "
 	git submodule summary sm2 >actual &&
 	cat >expected <<-EOF &&
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
@@ -274,24 +274,24 @@ commit_file sm2
 test_expect_success 'given commit' "
 	git submodule summary HEAD^ >actual &&
 	cat >expected <<-EOF &&
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 	test_cmp expected actual
 "
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
 	test_i18ncmp - actual <<-EOF
-* sm1 $head6...0000000:
+	* sm1 $head6...0000000:
 
-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9
 
-EOF
+	EOF
 "
 
 test_expect_success 'fail when using --files together with --cached' "
-- 
2.28.0

