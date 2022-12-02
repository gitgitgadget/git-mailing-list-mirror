Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F1C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLBLxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiLBLxc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85663C7D3E
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gu23so10964037ejb.10
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1dDjD/7/CXFHmg2sg4/yoq8+PwRjsbj38fU78LD7E4=;
        b=hDjcL7PBk0Meut7abH3dLBbEuWG9+s1HP2hrTroXpMH7/BZUIY3CFBFKjNDS+XvABq
         6kxCiDSNTv/ik4EErPnNNVutSLFTyhpT2CGEVJAgnYQPE5QfFqTpwnuR9R4T7w9oag0T
         Acqt/F/HOBv9YWwRdsQr7kgeyw8TSkidttutGlbZPsA/lspuoUQSWVlJFhrb/+BhlLHq
         xDPE4ATxEN2Xqczy/4taOlHOPTMdBA8F18IEbOM2a1yucoz4qgpgsQCExgVQQPBGkrTi
         oxGTe+ARgMyo1GyjO3ClQUqWeF1QQlUD+7GWWd81ufbKa2Gji6sYoDLKZu7obAn0ZqNW
         QsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1dDjD/7/CXFHmg2sg4/yoq8+PwRjsbj38fU78LD7E4=;
        b=NF/Bn8mIwg3zDiLmZ93iajJiaCF7jrhsIYFFATs7ZDyjkqtYzeeSZtMZWys7d7qs0a
         M8MWR6e3ELwHpjgolYLysON6WKtTW/RCvLS8q9g1xi54u8PnnvhGWW0rpLY/Dbp8VRcs
         QC+Wqwig6lyro6vod6jDxC3btkkZHC48iVW88ALOPowETtGLeQ7zm3OmTfs7tKmeHaGH
         eBPgKg/g4JsYBkR0Qf8WYKTYBh+HnRSJH1SxYuzDCGWia9zFCT5jbNMbDEQnhsijJZ3s
         FatQ2146+pnp+b/81Ukx+Wjm14SdXx5C0yQRnJWigb78h0CR6pGRJrLqbS2u81jFPfGF
         Ctyg==
X-Gm-Message-State: ANoB5pliKx1XA159QhmQsKAwFNCtxkxCKpqCz7+CpJp0CcqC1GgWRPkQ
        FBlWOPQTmeVZq/MRU7rdA8AqmnqsZq32kA==
X-Google-Smtp-Source: AA0mqf7E4S3A7jxVTo6FKo4H+vq2OewuuAgRA3j+o5qs29RhBLL55c7sa2LWwYPLIENP/fXIq2fwjQ==
X-Received: by 2002:a17:906:9f10:b0:7ad:86f9:1d70 with SMTP id fy16-20020a1709069f1000b007ad86f91d70mr38434327ejc.179.1669981986533;
        Fri, 02 Dec 2022 03:53:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/8] auto-crlf tests: don't lose exit code in loops and outside tests
Date:   Fri,  2 Dec 2022 12:52:35 +0100
Message-Id: <patch-v3-2.8-394d5e46494-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the functions which are called from within
"test_expect_success" to add the "|| return 1" idiom to their
for-loops, so we won't lose the exit code of "cp", "git" etc.

Then for those setup functions that aren't called from a
"test_expect_success" we need to put the setup code in a
"test_expect_success" as well. It would not be enough to properly
&&-chain these, as the calling code is the top-level script itself. As
we don't run the tests with "set -e" we won't report failing commands
at the top-level.

The "checkout" part of this would miss memory leaks under
SANITIZE=leak, this code doesn't leak (the relevant "git checkout"
leak has been fixed), but in a past version of git we'd continue past
this failure under SANITIZE=leak when these invocations had errored
out, even under "--immediate".

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0027-auto-crlf.sh | 60 +++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index a94ac1eae37..23f2e613401 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -70,7 +70,8 @@ create_NNO_MIX_files () {
 				cp CRLF        ${pfx}_CRLF.txt &&
 				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
 				cp LF_mix_CR   ${pfx}_LF_mix_CR.txt &&
-				cp CRLF_nul    ${pfx}_CRLF_nul.txt
+				cp CRLF_nul    ${pfx}_CRLF_nul.txt ||
+				return 1
 			done
 		done
 	done
@@ -101,7 +102,8 @@ commit_check_warn () {
 	do
 		fname=${pfx}_$f.txt &&
 		cp $f $fname &&
-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
+		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err" ||
+		return 1
 	done &&
 	git commit -m "core.autocrlf $crlf" &&
 	check_warning "$lfname" ${pfx}_LF.err &&
@@ -121,15 +123,19 @@ commit_chk_wrnNNO () {
 	lfmixcr=$1 ; shift
 	crlfnul=$1 ; shift
 	pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
-	#Commit files on top of existing file
-	create_gitattributes "$attr" $aeol &&
-	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
-	do
-		fname=${pfx}_$f.txt &&
-		cp $f $fname &&
-		printf Z >>"$fname" &&
-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
-	done
+
+	test_expect_success 'setup commit NNO files' '
+		#Commit files on top of existing file
+		create_gitattributes "$attr" $aeol &&
+		for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
+		do
+			fname=${pfx}_$f.txt &&
+			cp $f $fname &&
+			printf Z >>"$fname" &&
+			git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err" ||
+			return 1
+		done
+	'
 
 	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
 		check_warning "$lfwarn" ${pfx}_LF.err
@@ -163,15 +169,19 @@ commit_MIX_chkwrn () {
 	lfmixcr=$1 ; shift
 	crlfnul=$1 ; shift
 	pfx=MIX_attr_${attr}_aeol_${aeol}_${crlf}
-	#Commit file with CLRF_mix_LF on top of existing file
-	create_gitattributes "$attr" $aeol &&
-	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
-	do
-		fname=${pfx}_$f.txt &&
-		cp CRLF_mix_LF $fname &&
-		printf Z >>"$fname" &&
-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
-	done
+
+	test_expect_success 'setup commit file with mixed EOL' '
+		#Commit file with CLRF_mix_LF on top of existing file
+		create_gitattributes "$attr" $aeol &&
+		for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
+		do
+			fname=${pfx}_$f.txt &&
+			cp CRLF_mix_LF $fname &&
+			printf Z >>"$fname" &&
+			git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err" ||
+			return 1
+		done
+	'
 
 	test_expect_success "commit file with mixed EOL onto LF crlf=$crlf attr=$attr" '
 		check_warning "$lfwarn" ${pfx}_LF.err
@@ -294,12 +304,10 @@ checkout_files () {
 	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
-		rm crlf_false_attr__$f.txt &&
-		if test -z "$ceol"; then
-			git checkout -- crlf_false_attr__$f.txt
-		else
-			git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
-		fi
+		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
+			rm -f crlf_false_attr__$f.txt &&
+			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
+		'
 	done
 
 	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
-- 
2.39.0.rc1.981.gf846af54b4b

