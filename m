Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC19C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKBHyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBHyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B425283
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so43125438ejc.4
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igsSRhnfRZbcip5u6/zolBid4FtSk2cCM2Yty0T41sg=;
        b=SKfyM11/x4E4TSoE4kxPBRF2wvds7RdKy2wBNMDYpu5XmEati3M399NwSXokFzdtDv
         2IIBishSQH6kFjg8Nr4s/7PGp17V32X0yT6+ZxDWy7BEuxwEDbBg/VRINkHByM4wJ0G9
         f40aTD01gnJgBfmXrCAWwdLVI7grv2bbJQZh+RxXcvdSrHn7QVhG7+buJBRqtF3HMLDS
         Vd5FI2KcHuYMHhsvzd63X8yfnptLrJY/n37PZw2FPFDUi82r3x2cBrdl2dM2G3czPY/i
         VRsXDkPVKB7sxVBQ9dzL/UkI5IZMKFuCikElNrSjoVldzIsHS1kopznDw+ETl+oI8OEk
         +SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igsSRhnfRZbcip5u6/zolBid4FtSk2cCM2Yty0T41sg=;
        b=VGpuqst3QxMM5H+AvM8mv2ok1i76MdYry1Piea3MfkuhIhDzd75E1hRp+Xm5Zn4Euk
         Y6gr0pkpeTeLpbVQXQ+N/nkrHDWAOa+javoqwf+Y2iN4Dyfr9jMosbyRBzvLT5glK8B1
         UzSSouqz8RgyCpzrlrLOex15lPzObKc5ISu/s1fV4G6pd5ZRC3/pLWc3ncwI3HdBRANo
         dhc/KnAPt4NdBovRb85SMKY3a4AZpW2YNadv0l+cvsBPbNioxp2COtg/XZFT/yQ0ZN7N
         n/B8sZO119kqQX/zhhEyojLwq1Sf6AM8g+2odHZlOWKz+jtdnAlL+qpKUiHl85lGDEZN
         atYQ==
X-Gm-Message-State: ACrzQf2JFggsidkHegIiP1x9mi+37iMZk5zZ57GDlm1p8XGKDT0wghze
        MW/lVlFsQM3cIOyjK95FBx2yk+oXLrEx1g==
X-Google-Smtp-Source: AMsMyM65XlXsLhfva9OMIVbwjMuaiHQsVsw1rqnA8g6r0s8BZpQ1FM3aP76fAm40cgavUhH0ROhnzg==
X-Received: by 2002:a17:907:8c81:b0:7ad:f0ae:f4b4 with SMTP id td1-20020a1709078c8100b007adf0aef4b4mr6510661ejc.563.1667375650215;
        Wed, 02 Nov 2022 00:54:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] submodule tests: add tests for top-level flag output
Date:   Wed,  2 Nov 2022 08:53:59 +0100
Message-Id: <patch-2.8-cda36b5b6e0-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exhaustively test for how combining various "mixed-level" "git
submodule" option works. "Mixed-level" here means options that are
accepted by a mixture of the top-level "submodule" command, and
e.g. the "status" sub-command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7400-submodule-basic.sh  |  10 +++
 t/t7422-submodule-output.sh | 169 ++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100755 t/t7422-submodule-output.sh

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a989aafaf57..eae6a46ef3d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -579,6 +579,16 @@ test_expect_success 'status should be "modified" after submodule commit' '
 	grep "^+$rev2" list
 '
 
+test_expect_success '"submodule --cached" command forms should be identical' '
+	git submodule status --cached >expect &&
+
+	git submodule --cached >actual &&
+	test_cmp expect actual &&
+
+	git submodule --cached status >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'the --cached sha1 should be rev1' '
 	git submodule --cached status >list &&
 	grep "^+$rev1" list
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
new file mode 100755
index 00000000000..3ac56c23f72
--- /dev/null
+++ b/t/t7422-submodule-output.sh
@@ -0,0 +1,169 @@
+#!/bin/sh
+
+test_description='submodule --cached, --quiet etc. output'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t3100.sh
+
+setup_sub () {
+	local d="$1" &&
+	shift &&
+	git $@ clone . "$d" &&
+	git $@ submodule add ./"$d"
+}
+
+normalize_status () {
+	sed -e 's/-g[0-9a-f]*/-gHASH/'
+}
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	setup_sub S  &&
+	setup_sub S.D &&
+	setup_sub S.C &&
+	setup_sub S.C.D &&
+	setup_sub X &&
+	git add S* &&
+	test_commit C &&
+
+	# recursive in X/
+	git -C X pull &&
+	GIT_ALLOW_PROTOCOL=file git -C X submodule update --init &&
+
+	# dirty p
+	for d in S.D X/S.D
+	do
+		echo dirty >S.D/A.t || return 1
+	done &&
+
+	# commit (for --cached)
+	for d in S.C* X/S.C*
+	do
+		git -C "$d" reset --hard A || return 1
+	done &&
+
+	# dirty
+	for d in S*.D X/S*.D
+	do
+		echo dirty >"$d/C2.t" || return 1
+	done &&
+
+	for ref in A B C
+	do
+		# Not different with SHA-1 and SHA-256, just (ab)usign
+		# test_oid_cache as a variable bag to avoid using
+		# $(git rev-parse ...).
+		oid=$(git rev-parse $ref) &&
+		test_oid_cache <<-EOF || return 1
+		$ref sha1:$oid
+		$ref sha256:$oid
+		EOF
+	done
+'
+
+for opts in "" "status"
+do
+	test_expect_success "git submodule $opts" '
+		sed -e "s/^>//" >expect <<-EOF &&
+		> $(test_oid B) S (B)
+		>+$(test_oid A) S.C (A)
+		>+$(test_oid A) S.C.D (A)
+		> $(test_oid B) S.D (B)
+		>+$(test_oid C) X (C)
+		EOF
+		git submodule $opts >actual.raw &&
+		normalize_status <actual.raw >actual &&
+		test_cmp expect actual
+	'
+done
+
+for opts in \
+	"status --recursive"
+do
+	test_expect_success "git submodule $opts" '
+		sed -e "s/^>//" >expect <<-EOF &&
+		> $(test_oid B) S (B)
+		>+$(test_oid A) S.C (A)
+		>+$(test_oid A) S.C.D (A)
+		> $(test_oid B) S.D (B)
+		>+$(test_oid C) X (C)
+		> $(test_oid B) X/S (B)
+		>+$(test_oid A) X/S.C (A)
+		>+$(test_oid A) X/S.C.D (A)
+		> $(test_oid B) X/S.D (B)
+		> $(test_oid B) X/X (B)
+		EOF
+		git submodule $opts >actual.raw &&
+		normalize_status <actual.raw >actual &&
+		test_cmp expect actual
+	'
+done
+
+for opts in \
+	"--quiet" \
+	"--quiet status" \
+	"status --quiet"
+do
+	test_expect_success "git submodule $opts" '
+		git submodule $opts >out &&
+		test_must_be_empty out
+	'
+done
+
+for opts in \
+	"--cached" \
+	"--cached status" \
+	"status --cached"
+do
+	test_expect_success "git submodule $opts" '
+		sed -e "s/^>//" >expect <<-EOF &&
+		> $(test_oid B) S (B)
+		>+$(test_oid B) S.C (B)
+		>+$(test_oid B) S.C.D (B)
+		> $(test_oid B) S.D (B)
+		>+$(test_oid B) X (B)
+		EOF
+		git submodule $opts >actual.raw &&
+		normalize_status <actual.raw >actual &&
+		test_cmp expect actual
+	'
+done
+
+for opts in \
+	"--cached --quiet" \
+	"--cached --quiet status" \
+	"--cached status --quiet" \
+	"--quiet status --cached" \
+	"status --cached --quiet"
+do
+	test_expect_success "git submodule $opts" '
+		git submodule $opts >out &&
+		test_must_be_empty out
+	'
+done
+
+for opts in \
+	"status --cached --recursive" \
+	"--cached status --recursive"
+do
+	test_expect_success "git submodule $opts" '
+		sed -e "s/^>//" >expect <<-EOF &&
+		> $(test_oid B) S (B)
+		>+$(test_oid B) S.C (B)
+		>+$(test_oid B) S.C.D (B)
+		> $(test_oid B) S.D (B)
+		>+$(test_oid B) X (B)
+		> $(test_oid B) X/S (B)
+		>+$(test_oid B) X/S.C (B)
+		>+$(test_oid B) X/S.C.D (B)
+		> $(test_oid B) X/S.D (B)
+		> $(test_oid B) X/X (B)
+		EOF
+		git submodule $opts >actual.raw &&
+		normalize_status <actual.raw >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_done
-- 
2.38.0.1280.g8136eb6fab2

