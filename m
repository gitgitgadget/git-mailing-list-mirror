Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CFFC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiCBR2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiCBR2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D81DFB8
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i8so3896568wrr.8
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37n3U3cASYystLlv+L5dlRBXBl9W6X/QMZRmlX/BCY8=;
        b=Ty3XEYkcHyanE/BY6SVJpzFtb1/i/cJQ5Dc7K+SqT+tfPVIZw1ZKKOGKC6v7zRsYf1
         pHCuwoospi0xEmwV3x4eA3DSxUp58n911feOYb1/CP7GPUufuj+lqPXUj7LXfbmahQef
         WimcEphYTstRfji5yc3OxdTU8oCFl9VNXJciBQLUHZA4gTXjVBTFwbPzj00LEzdD2zhb
         rqPnOdWBN6czsnPH6rMjFNZ2/crSHLOkAkm61pUZ9wF4LVT8INc4PwDFRTnc8eAx/RzQ
         hVj6zFluiJABKDtn3RoaL+NeGfjwKADEX0jRvZhzxISYfW2OdwfkS49US691O60rnczM
         s+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37n3U3cASYystLlv+L5dlRBXBl9W6X/QMZRmlX/BCY8=;
        b=OweZ7u4WfsQVQ85c0acT+Oy5Ds6q1Fywa7YoLoPhWtdUq6nvaY2eIReC81cztS82Vx
         hyztMpFxHxbmt8XWEZ3E6xkC+ntW8M6nvsyEF28DJDgX7IMRoqefybIt+HyJcpGCJB5D
         RMfCAaHXKLesW2+FSAx350tXa1/v2ZfYy9BVE7190te/3A/JGMa+C0vPs9blc7V7YhwF
         QbTadM+irigKMtCWuQlREnmOYEYrB+gQRhVFGl+M12GOSpAJtXsNTtXiha4gb/L7/GrS
         I40zjdJPnoQOWbefukwTjOywzFUnQhQHsMYbr95prHLLtjZz9uFzE5otciQjEjvDT/FQ
         NQng==
X-Gm-Message-State: AOAM531Mog6THdSJt/4n+oSO1+V0qcRpV2mPOruIutBITLOnimWuW0xq
        BbfpmOdztAT4nLvvNYhScz0kR+RNdDt/bQ==
X-Google-Smtp-Source: ABdhPJyWOwt2AAZ63/DlahEupFqbOsCXKfe8/ZVxzxOx0jEp6S/Jw7uXRNl2MjbFiBImLIIXKc4sdA==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id r11-20020adfc10b000000b001edc40f7f91mr23709167wre.276.1646242054377;
        Wed, 02 Mar 2022 09:27:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/15] diff tests: don't ignore "git diff" exit code in "read" loop
Date:   Wed,  2 Mar 2022 18:27:14 +0100
Message-Id: <patch-05.15-b1aeac3f68e-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a test pattern that originated in f1af60bdba4 (Support 'diff=pgm'
attribute, 2007-04-22) so that we'll stop using "git diff" on the
left-hand-side of a pipe, and thus ignoring its exit code.

Rather than use intermediate files let's rewrite these tests to a much
simpler but more exhaustive "test_tmp" where we'll ignore certain
fields in the output.

Note that this is not a faithful conversion of the previous
"read/test" in some cases, as we were ignoring more fields there than
we strictly needed to. Now we'll "test_cmp" everything we can, and
only ignore the likes of paths to $TEMPDIR etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4020-diff-external.sh | 104 ++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 879ee04d291..1219f8bd4c0 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -24,16 +24,12 @@ test_expect_success setup '
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment' '
-
-	GIT_EXTERNAL_DIFF=echo git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff >out &&
+	cut -d" " -f1,3- <out >actual &&
+	test_cmp expect actual
 
 '
 
@@ -52,15 +48,14 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
 test_expect_success SYMLINKS 'typechange diff' '
 	rm -f file &&
 	ln -s elif file &&
-	GIT_EXTERNAL_DIFF=echo git diff  | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z120000 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	} &&
+
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 120000
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual &&
+
 	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff >actual &&
 	git diff >expect &&
 	test_cmp expect actual
@@ -70,15 +65,13 @@ test_expect_success 'diff.external' '
 	git reset --hard &&
 	echo third >file &&
 	test_config diff.external echo &&
-	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
+
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 100644
+	EOF
+	git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success !SANITIZE_LEAK 'diff.external should apply only to diff' '
@@ -101,16 +94,12 @@ test_expect_success 'diff attribute' '
 
 	echo >.gitattributes "file diff=parrot" &&
 
-	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
-
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 100644
+	EOF
+	git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
@@ -132,16 +121,12 @@ test_expect_success 'diff attribute' '
 
 	echo >.gitattributes "file diff=color" &&
 
-	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
-
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 100644
+	EOF
+	git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
@@ -159,14 +144,26 @@ test_expect_success 'diff attribute and --no-ext-diff' '
 test_expect_success 'GIT_EXTERNAL_DIFF trumps diff.external' '
 	>.gitattributes &&
 	test_config diff.external "echo ext-global" &&
-	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-env
+
+	cat >expect <<-EOF &&
+	ext-env file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff >out &&
+	cut -d" " -f1-2,4- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'attributes trump GIT_EXTERNAL_DIFF and diff.external' '
 	test_config diff.foo.command "echo ext-attribute" &&
 	test_config diff.external "echo ext-global" &&
 	echo "file diff=foo" >.gitattributes &&
-	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-attribute
+
+	cat >expect <<-EOF &&
+	ext-attribute file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff >out &&
+	cut -d" " -f1-2,4- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'no diff with -diff' '
@@ -212,7 +209,12 @@ test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
 	touch file.ext &&
 	git add file.ext &&
 	echo with extension > file.ext &&
-	GIT_EXTERNAL_DIFF=echo git diff file.ext | grep ......_file\.ext &&
+
+	cat >expect <<-EOF &&
+	file.ext file $(git rev-parse --verify HEAD:file) 100644 file.ext $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff file.ext >out &&
+	cut -d" " -f1,3- <out >actual &&
 	git update-index --force-remove file.ext &&
 	rm file.ext
 '
-- 
2.35.1.1226.g8b497615d32

