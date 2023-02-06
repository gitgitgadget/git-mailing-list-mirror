Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3349C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBFWos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFWoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF03029D
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso10113236wms.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zqExQtP1qYKBqvIbdKZsbCZpnNwEIKpl9IKUPo9vhs=;
        b=HnAyfU/+4ViIj0D+cUAX1hXz1WCOt/Yp71pNNI3zp+ODfcJ8NqDSQc+bzkNjJrYG1f
         XBuSjzPJkCzjTBUcItYyo0XlRlFYzAVcfAk9ZWWRCrmlz4JdA1Z6MAR04h00vdHktcEj
         m8jRIMfHD4zQF9OCqfR0LbMOLPnUQgThQEv9aPim2qltyyzr3P4T9BM1qitISaxPX6IB
         Qlv67SePTDBuHYcHwClNf71qETuy5ZVACLF4a7DlX1cFIbV9QSec3zW1NZHf0GgfysFk
         bvEm7BgPWJR9fS0N2balPsiv7qMf/e4KiuXlbG6YdNGo1MRN+isJULW3eCciyE0rxEtM
         aNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zqExQtP1qYKBqvIbdKZsbCZpnNwEIKpl9IKUPo9vhs=;
        b=qDxOp+SuMBbasyznTJq/YLC8SGGTnxzLSB5n+6I1LdkrJrPTPcVqgtm3OdnN9xQPDN
         H7k0/lPHNKF4K6f+c3auPjoobrNMu7d3d/71LMHK9UBdrALN4ekTEW9c+gY6F/zc0L4n
         lSvJ/7MB43wJJh4PJpH6d1+CtVAx+iipKlv9tasapkK5e6BA+QhvzCcn28hE8KPWCF4O
         3I8Fp+zqHMxbhibLhb0U+EO9y1aHxa5RozTkhxj+cfe2k7nshkgkKP/uYNDxkUL4sQ17
         3+848M/MqQ+GfuHMnwjkLm1V5+0za3xqlHAqIZYMbs+jWzAVQ5MeQGqiyGlDRTjyu5zA
         BFSQ==
X-Gm-Message-State: AO0yUKXU+6Z4yftQBYesTgOie+T6hU++b/vX1gcj4Gn379tPG0ToosMk
        uT7xWko3XppTSGKpEeAfb4DOcuzsdIPi4Mzv
X-Google-Smtp-Source: AK7set/G1YSHVaph1oREazNI5skDOB0mOjYUBJi38v5w0bNFdQa2qtNDWBtBNfxcPY6VH+SpwxYsaA==
X-Received: by 2002:a05:600c:43d2:b0:3d3:513c:240b with SMTP id f18-20020a05600c43d200b003d3513c240bmr1160279wmn.7.1675723483576;
        Mon, 06 Feb 2023 14:44:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm6657643wrx.48.2023.02.06.14.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/6] auto-crlf tests: don't lose exit code in loops and outside tests
Date:   Mon,  6 Feb 2023 23:44:28 +0100
Message-Id: <patch-v5-1.6-66d0f91e6aa-20230206T224200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
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

For checkout_files() we could run one test_expect_success() instead of
the 5 we run now in a loop.

But as this function added in [1] is already taking pains to split up
its setup into phases (there are 5 more "test_expect_success()" at the
end of it already, see [1]), let's follow that existing convention.

1. 343151dcbdf (t0027: combinations of core.autocrlf, core.eol and text, 2014-06-29)

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
2.39.1.1425.gac85d95d48c

