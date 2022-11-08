Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A3C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiKHOLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiKHOKx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:10:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2F62D1
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k2so38960546ejr.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XRH/Boj0goJ2MwneX+dSzDfB9fjvhsiqjSBbbL/axQ=;
        b=o+kh1byQblgxO4XY6ivLwxqTOUxmAIg1+Gi/tTzj421KRo+UIiJSOIZ6tmyc0ZAWgK
         chD1viMaut0gfFIwFTARmBfd7/3arnalIMqryehTVhh9i6sSS4nfO+7ZhPrTjwUMFomi
         g4Jr4wMGpqbUoxDBTCEsrcY4vwUM7Y4P2/OPMHoWMFKLHlv41RI7WunxEX9vSw43WVZ2
         jockj4mkENvjOWU0z/yrwFiYjYwFs6hjigVO7p02dzT/veZdh9Ktk9vPxpmKcKtawyCz
         THJRuf+3YmhTxE1A54xtNiB8nv/S/8223gFPRVZqKe15jhjSJI1w7D3h5zHO2zb4npxV
         sRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XRH/Boj0goJ2MwneX+dSzDfB9fjvhsiqjSBbbL/axQ=;
        b=0OpSDjh6qMsZz81uW8lCCBMzy7p6YCdBu1dzTxkRNXCLJ2coMjIp7t6luYrFFUvmjl
         me4vGkGVBHqzi1skPKhQdqVI0nfQxYZFyflNdRIsKa9lOvJFdLDh/YIbuOsL42lo/gjv
         NfsLyrFA87JummykJoO8Q8H6H3NPpYswW1aEfKanBqsrdLzJDq2tYyCgFkNcEQMDj/DP
         XCCbNOiI+2EczN1IDY7eg7sadKxSrW9z1DsF6cmWR+flS+VOHXCZOW4PlnKyu8wm0K/f
         qEEksxjkgaQ7bkxV+gRto7hTZAxabKNGBCI4FhiuwKQlBMbekH8PDJPvm/ebkfDFTKhT
         FEow==
X-Gm-Message-State: ACrzQf0UiFiWP207S5Me1yHaqYQ5H3mqytVqaEvSd/VLqYUhfaMcLd4t
        zeqEkpT2skvOh2xXQd0AlVI2fmDrKj7L3A==
X-Google-Smtp-Source: AMsMyM4SZ/w0VP+4ewuBx/ihQWa71bCYjLmWz2rI9fiv+4aVJd1jNPm3JoMle1l9YgKCca6ZW8Kyfw==
X-Received: by 2002:a17:907:2da3:b0:7ad:ffba:a8e4 with SMTP id gt35-20020a1709072da300b007adffbaa8e4mr32389571ejc.684.1667916650792;
        Tue, 08 Nov 2022 06:10:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] submodule tests: add tests for top-level flag output
Date:   Tue,  8 Nov 2022 15:10:33 +0100
Message-Id: <patch-v2-2.9-5508c27f653-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
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
index 00000000000..1e9cdf1a68e
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
+	# dirty
+	for d in S.D X/S.D
+	do
+		echo dirty >"$d"/A.t || return 1
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
+		# Not different with SHA-1 and SHA-256, just (ab)using
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
2.38.0.1464.gea6794aacbc

