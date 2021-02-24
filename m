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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA70C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2330664F03
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhBXTxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhBXTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B9CC061797
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r3so3028542wro.9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXtGFsgRGxvA9gGTTtAzLV/ceeBxBqYANef/qRpivO8=;
        b=cLPVh9k+RzdiYTpcBXhDMUXOovBWH67UY40wMRdrjNxb70siJUz+awzoWnN4Zos/ki
         Clx/CHmRDltGXfHCpFLbMkN5S4H1Dh6TMlC0IS8w4usk9U9ptTDwno3KSSVy6/cfzMIs
         +JrYdrBZtKSh3samgs1D7Nc10U4BJcBIjyftO7pMDSOwiYkl3eHslO6x3xZ43GQMc+D5
         LKFPIMjgF/VXMNowtaD1AOEL/fKsTI7sJze8oFHv+BEVfKPimZEnbfx5xRW33a0vFGEG
         2kRk+1et4LrF3rYIbVHIylOov5asZgHLJ4rkVjB1srUjnAfFEvcIVvUGaadwi+dxn2+D
         9SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXtGFsgRGxvA9gGTTtAzLV/ceeBxBqYANef/qRpivO8=;
        b=C/T9+gqiJ6Oi6DeTfDDt4UiFNPHWTNjQp9pCc2tqG91KCr1llFT38CQrF+42QaqyE/
         syT0+ZPed5Gf60R03V5lSRrcnC+3DgQWJFKBP3yXShk+RITwSMqQyqNH4pBk88j+nA4g
         Ij17YRvMdpz+vTLYbwn5MMLt5eqeujqeAB9qKrlhJcxVwqoeY77FueEsN/O2blrjw5pR
         jq9m1s7WDjNO3JNKKRG/UE0xW8zyW2YzQGSeHQHJBdYtRhLApu7iqisVuIeDNO2xJyBQ
         Mjtp6YvKLK6jYMmcgOZsMkfDvba6F3DSKKFRyBHQpdvBUnN8FJw/3GCrIt8N1+f4PVqE
         VPCQ==
X-Gm-Message-State: AOAM532IRdB+TTtfJs/AlzQqRhz+cybz3SSkb9usfY1rtj5uruYu1gmr
        inPkaRFrduEgf8sOecyrrI2eOEyP+FDXbQ==
X-Google-Smtp-Source: ABdhPJxx7fbXgAc+yWweROPtaCTl8+Hhp6JcNCZCDFN9A0tW6AFpLy+cNxlrpQK+bkrAWQbaHb6X6A==
X-Received: by 2002:adf:a2d3:: with SMTP id t19mr26148052wra.299.1614196320144;
        Wed, 24 Feb 2021 11:52:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:59 -0800 (PST)
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
Subject: [PATCH v3 09/35] blame tests: don't rely on t/t4018/ directory
Date:   Wed, 24 Feb 2021 20:51:03 +0100
Message-Id: <20210224195129.4004-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) so that the blame tests don't rely
on stealing the contents of "t/t4018/fortran-external-function".

I'm about to change that file in a subsequent commit. Just moving the
relevant test file here inline is the easiest solution, and I think
also the most readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 29ce89090d8..04a2c58594c 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -482,12 +482,22 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 test_expect_success 'setup -L :funcname with userdiff driver' '
 	echo "fortran-* diff=fortran" >.gitattributes &&
 	fortran_file=fortran-external-function &&
-	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
-	cp "$orig_file" . &&
+	cat >$fortran_file <<-\EOF &&
+	function RIGHT(a, b) result(c)
+
+	integer, intent(in) :: ChangeMe
+	integer, intent(in) :: b
+	integer, intent(out) :: c
+
+	c = a+b
+
+	end function RIGHT
+	EOF
 	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
 	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >"$fortran_file" &&
+	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
+	mv "$fortran_file".tmp "$fortran_file" &&
 	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
 	git commit -m "change fortran file"
-- 
2.30.0.284.gd98b1dd5eaa7

