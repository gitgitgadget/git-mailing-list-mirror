Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43BC4167B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiLSKTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiLSKTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A767A444
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h7so8115936wrs.6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkJc9eqTpdyDPlRvb1ytBD3B3Qe5O9YcBLOiAN00L14=;
        b=cOf8Dk19+294ALj+Ehtlchs0PbO9kemKxg9Ds4yyHnNe8kxxcwTeg+kYez6z7NKBOo
         qfXinNxEG1Nn/2+EUM1mzKY54HtjdZQ9cIqmDZWVz/mbaEkfbhgC7pHIdGUzKPxLiKiy
         6UZQ28FCUqA2YqVPSb5IrQycXiBR01//BGReadeayIYEBrRt9mwTOgBpGWPH1o1Lxl53
         wXQnzr0iY3lk2izx/MjUqqIb8kkZtwr8QTuvWvqDtc4IJyIn2o4CH5rW1jK5MznL7p+K
         9R3JrM8FRKs8kpOrPAaBAHosLPtHaEgVg155W/EElR9vAel0Fx8Ec43YohAj098LCX+B
         RT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkJc9eqTpdyDPlRvb1ytBD3B3Qe5O9YcBLOiAN00L14=;
        b=AZF1mi7SpVCxy89dxwB4QWqid2QEg++5giD+Co3k/CC4Isq9Q0RaoTSOxRjjmeaik9
         5/YAhz8LGTgoD4I+PfLdQ0ViNOeZm/LkkrN/OCrQYcMbgs/PgWQv+VCiqvKE9haah7ox
         MG7DlHhvIMrBQGYzoPEvZQLGvu8HhwKXeiMGEnkgjptCTDOIyYvND5sQKdVaklLnR7uh
         bOqvr8bstqJP56FJfsflM6l6jyroSQX6pjKlNe1cLzB3Tm8Ly7rirzAB9cU+iAHqSWLB
         vRQgEbv4KpG6CT2jweT6Ky52UHhybGcDjHW36c5c9QlDXO1ddg2RCZcp+AixCGTJaB9j
         jOSg==
X-Gm-Message-State: ANoB5pmvDGLLw1042Yu8N5DbAxq4Js8fA7SDzpzwKFStRwzu8Q8FGTAU
        EtD7kXrmlLslMMqF5XUAX3ctoHZmoeq3aw==
X-Google-Smtp-Source: AA0mqf4+9NL6xI1DeXbgqdnWJdUbZDUjzYuKCT+Wn5gBZI83xXZc4FrhOcnM7IkZRqDCoQK4V5Nlzw==
X-Received: by 2002:a5d:65d1:0:b0:242:6006:7d06 with SMTP id e17-20020a5d65d1000000b0024260067d06mr23674141wrw.30.1671445174576;
        Mon, 19 Dec 2022 02:19:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] auto-crlf tests: don't lose exit code in loops and outside tests
Date:   Mon, 19 Dec 2022 11:19:24 +0100
Message-Id: <patch-v4-1.6-68d276dd421-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
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
 t/t0027-auto-crlf.sh | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index a94ac1eae37..2f57c8669cb 100755
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
@@ -289,17 +299,17 @@ checkout_files () {
 	lfmixcrlf=$1 ; shift
 	lfmixcr=$1 ; shift
 	crlfnul=$1 ; shift
-	create_gitattributes "$attr" $ident $aeol &&
-	git config core.autocrlf $crlf &&
+	test_expect_success "setup config for checkout attr=$attr ident=$ident aeol=$aeol core.autocrlf=$crlf" '
+		create_gitattributes "$attr" $ident $aeol &&
+		git config core.autocrlf $crlf
+	'
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
2.39.0.1071.g97ce8966538

