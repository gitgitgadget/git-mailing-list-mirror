Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC8C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiBXFsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBXFsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:48:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50816BCE4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:47:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c9so833521pll.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaghvTKVuxaxh8MsTeOjjXrZgUTP2ThDdUBjs8+u1Ys=;
        b=hjyQkb+ZS0tEsvn275vLIHYiBI0H0EGTKM1fJAg4fQxCaktuljDW5nDV1vSx8OEBDv
         hT4+h/WOyxgOChruC8SpSkbjTax1u0hanKh+HyWUDtLfmh1e3lcDQu+9HVqGuhZ2p/S3
         3Ng43bcav5mvCuF1VJwC0GaWFI9u520iY9hcVLkEcAk9QZK9gWOaEL/OkZl1T517MjBa
         0ncP3y++CtHH07D0r59AcQ12s9UrpV7VVGPnqWdDFBH0gVsFG1A8H1poS8CdVEONg5ad
         Andd6+AY4dxKL9p6n6b+ZYnBpGljTViCWbts2dLXpwykeBJ/zgsD1cTYAKlLOKBEwUT1
         wnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaghvTKVuxaxh8MsTeOjjXrZgUTP2ThDdUBjs8+u1Ys=;
        b=OKCUMJcfarUKaPN/cB5BDQrVQylRt/ZlPBwimNwEpK4waOMPvFtEQlIuRr6nIvKhyE
         c7FUfhQtGK5iAAP6No0mX71mmN74Rzh8DDdnq15F7WZK8ovhLLQTdGxCX4zuJ31tDyil
         r7k9uVgm3s5EfT+znZO+5cA9tJ8Fc9e5PxjjjisiShkd8Jp2G4cz54pYOqZGz2yzSMf9
         /8nf2WjhKh9Mgd/6B2k5U7vHBbmrzjzr0DDtpi74ekJPANDZqcdX3p6BvE9I7KbFO1Vw
         fJsSn9F5gm2IXYA0VwgxYBcHpjipIiej4FRIYdBM5Yrxjv3EBbMiSN1VsyMRBabc2x6w
         9Jyw==
X-Gm-Message-State: AOAM533uMy0PuAsa22ptEeRmz14R+NK5icDVZW1V3Wt7lXCtm8u5vT6y
        tx/8OxfeGdrWYkpMnZhUJxb7ZDC16ADaboXMUJ0=
X-Google-Smtp-Source: ABdhPJxAqMMMc0vI9aEW5TAR7Z2gfRXYeF1Qouhpd9wmbbZJPxAHs/eCf1qAxL44AxceDM2gadqIIA==
X-Received: by 2002:a17:902:ab92:b0:14d:8c80:dbff with SMTP id f18-20020a170902ab9200b0014d8c80dbffmr1007306plr.89.1645681654742;
        Wed, 23 Feb 2022 21:47:34 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.99])
        by smtp.gmail.com with ESMTPSA id f12sm1497817pfv.106.2022.02.23.21.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:47:34 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 1/2] t0001-t0028: avoid pipes with Git on LHS
Date:   Thu, 24 Feb 2022 11:17:19 +0530
Message-Id: <20220224054720.23996-2-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224054720.23996-1-shivam828787@gmail.com>
References: <20220224054720.23996-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes ignore error codes of LHS command and thus we should not use
them with Git in tests. As an alternative, use a 'tmp' file to write
the Git output so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0000-basic.sh            | 10 ++++++----
 t/t0022-crlf-rename.sh      |  4 ++--
 t/t0025-crlf-renormalize.sh |  4 ++--
 t/t0027-auto-crlf.sh        | 12 ++++++------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b007f0efef..b5fa76059b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1089,7 +1089,8 @@ test_expect_success 'update-index D/F conflict' '
 	mv path2 path0 &&
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
-	numpath0=$(git ls-files path0 | wc -l) &&
+	git ls-files path0 >tmp &&
+	numpath0=$(wc -l <tmp) &&
 	test $numpath0 = 1
 '
 
@@ -1104,12 +1105,13 @@ test_expect_success 'very long name in the index handled sanely' '
 	>path4 &&
 	git update-index --add path4 &&
 	(
-		git ls-files -s path4 |
-		sed -e "s/	.*/	/" |
+		git ls-files -s path4 >tmp &&
+		sed -e "s/	.*/	/" tmp |
 		tr -d "\012" &&
 		echo "$a"
 	) | git update-index --index-info &&
-	len=$(git ls-files "a*" | wc -c) &&
+	git ls-files "a*" >tmp &&
+	len=$(wc -c <tmp) &&
 	test $len = 4098
 '
 
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index c1a331e9e9..9fe9891251 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -24,8 +24,8 @@ test_expect_success setup '
 
 test_expect_success 'diff -M' '
 
-	git diff-tree -M -r --name-status HEAD^ HEAD |
-	sed -e "s/R[0-9]*/RNUM/" >actual &&
+	git diff-tree -M -r --name-status HEAD^ HEAD >tmp &&
+	sed -e "s/R[0-9]*/RNUM/" tmp >actual &&
 	echo "RNUM	sample	elpmas" >expect &&
 	test_cmp expect actual
 
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index 81447978b7..f7202c192e 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -22,8 +22,8 @@ test_expect_success 'renormalize CRLF in repo' '
 	i/lf w/lf attr/text=auto LF.txt
 	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
 	EOF
-	git ls-files --eol |
-	sed -e "s/	/ /g" -e "s/  */ /g" |
+	git ls-files --eol >tmp &&
+	sed -e "s/	/ /g" -e "s/  */ /g" tmp |
 	sort >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index c5f7ac63b0..0feb41a23f 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -311,8 +311,8 @@ checkout_files () {
 		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF_nul.txt
 		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF_nul.txt
 		EOF
-		git ls-files --eol crlf_false_attr__* |
-		sed -e "s/	/ /g" -e "s/  */ /g" |
+		git ls-files --eol crlf_false_attr__* >tmp &&
+		sed -e "s/	/ /g" -e "s/  */ /g" tmp |
 		sort >actual &&
 		test_cmp expect actual
 	'
@@ -359,12 +359,12 @@ test_expect_success 'ls-files --eol -o Text/Binary' '
 	i/ w/crlf TeBi_126_CL
 	i/ w/-text TeBi_126_CLC
 	EOF
-	git ls-files --eol -o |
+	git ls-files --eol -o >tmp &&
 	sed -n -e "/TeBi_/{s!attr/[	]*!!g
 	s!	! !g
 	s!  *! !g
 	p
-	}" | sort >actual &&
+	}" tmp | sort >actual &&
 	test_cmp expect actual
 '
 
@@ -617,8 +617,8 @@ test_expect_success 'ls-files --eol -d -z' '
 	i/lf w/ crlf_false_attr__LF.txt
 	i/mixed w/ crlf_false_attr__CRLF_mix_LF.txt
 	EOF
-	git ls-files --eol -d |
-	sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
+	git ls-files --eol -d >tmp &&
+	sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" tmp |
 	sort >actual &&
 	test_cmp expect actual
 '
-- 
2.25.1

