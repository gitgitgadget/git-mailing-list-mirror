Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1843C4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993956101E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhG1ThG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhG1Tg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1DC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j2so3880124wrx.9
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h40kB1ZUz4iK3X+QXunk8obylMPpRXIzIDERXHHokwk=;
        b=hTn3gJJakXtOACYg1gUBjHBctH81oEkvCPBzX9IJ5K9HuneD0f6PzIyKrCuZqxYayw
         hQ2RYiUIm1dK7EIP9LWlYq0WlYBAOict3509nxpT1zZ/YMFmauhI58glbKk3E10JyaOD
         PtpB0gIawBYus+QYvDqm6ji1Pi0lKCSsiSIfbG/6y2JMwyNGH20uIgm8Yua48wKuclNz
         AoNGeR9UIgJOT6xu8R0Fnqy08JZT2bDFVYsarEw1Ill8oVeAWrSiOjn3OFCK1gtB02RQ
         rl+Ew1haz5HS0dFxMmGJ9uqobMy7NRWu9jsqAp+RLGHpQy8qkB/krlQU7vVvu1lr66mw
         e3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h40kB1ZUz4iK3X+QXunk8obylMPpRXIzIDERXHHokwk=;
        b=aVwFL9re/WpN9oPVqwXuEGqRJ7ebb1VsFnLl58clZa1IobLAP5Y0Hh7BT7x6K1Kz5f
         HwSs/EszFhX8N5N8r97ToBvEZ79lRIWsexzP3sqUUagT2yvoZc26BNq11R6+PXNtp2qe
         t3EBPREIJSWK80aPm4dQCj1jtmST9MvE88uSPF9ruBEHTV0QkPDC5rswTFBDThmxh490
         VfazsIS6w4LZlNDLAr8nPBMbjc/n2zdqmX3jnG9/AQupLKhnwiZhshtT4XZfGIctcmiv
         sP5KmaI95erXNBgiSOxcBL0R8z8oCD2RTzSZBwvWyknm81eBEk2unYa3r1FUgyz36MeK
         7jkg==
X-Gm-Message-State: AOAM532XhRoVM74jU5IP9falxGcpM8qufSDtspS+J+Bd4TOGNK6hGqZZ
        Ez2nhUUIl7JdJOBFDnoPWPy5LVtPGW0=
X-Google-Smtp-Source: ABdhPJyn6jHycTRp4GAp9kG0API/sV+JaZGZOsfvlynjXEiRwYww0rhTm+K0uwqRLqtH5z6TgocF7w==
X-Received: by 2002:adf:d087:: with SMTP id y7mr903842wrh.323.1627501015365;
        Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12sm722955wrm.62.2021.07.28.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
Message-Id: <01da9a079348e965b00e9ff6cea75dbc74028123.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:47 +0000
Subject: [PATCH v6 7/9] ssh signing: duplicate t7510 tests for commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7528-signed-commit-ssh.sh | 398 +++++++++++++++++++++++++++++++++++
 1 file changed, 398 insertions(+)
 create mode 100755 t/t7528-signed-commit-ssh.sh

diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
new file mode 100755
index 00000000000..e2c48f69e6d
--- /dev/null
+++ b/t/t7528-signed-commit-ssh.sh
@@ -0,0 +1,398 @@
+#!/bin/sh
+
+test_description='ssh signed commit tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPGSSH 'create signed commits' '
+	test_oid_cache <<-\EOF &&
+	header sha1:gpgsig
+	header sha256:gpgsig-sha256
+	EOF
+
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+
+	echo 1 >file && git add file &&
+	test_tick && git commit -S -m initial &&
+	git tag initial &&
+	git branch side &&
+
+	echo 2 >file && test_tick && git commit -a -S -m second &&
+	git tag second &&
+
+	git checkout side &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -m "third on side" &&
+
+	git checkout main &&
+	test_tick && git merge -S side &&
+	git tag merge &&
+
+	echo 4 >file && test_tick && git commit -a -m "fourth unsigned" &&
+	git tag fourth-unsigned &&
+
+	test_tick && git commit --amend -S -m "fourth signed" &&
+	git tag fourth-signed &&
+
+	git config commit.gpgsign true &&
+	echo 5 >file && test_tick && git commit -a -m "fifth signed" &&
+	git tag fifth-signed &&
+
+	git config commit.gpgsign false &&
+	echo 6 >file && test_tick && git commit -a -m "sixth" &&
+	git tag sixth-unsigned &&
+
+	git config commit.gpgsign true &&
+	echo 7 >file && test_tick && git commit -a -m "seventh" --no-gpg-sign &&
+	git tag seventh-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
+	git tag seventh-signed &&
+
+	echo 8 >file && test_tick && git commit -a -m eighth -S"${SIGNING_KEY_UNTRUSTED}" &&
+	git tag eighth-signed-alt &&
+
+	# commit.gpgsign is still on but this must not be signed
+	echo 9 | git commit-tree HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag ninth-unsigned $(cat oid) &&
+	# explicit -S of course must sign.
+	echo 10 | git commit-tree -S HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag tenth-signed $(cat oid) &&
+
+	# --gpg-sign[=<key-id>] must sign.
+	echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag eleventh-signed $(cat oid) &&
+	echo 12 | git commit-tree --gpg-sign="${SIGNING_KEY_UNTRUSTED}" HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag twelfth-signed-alt $(cat oid)
+'
+
+test_expect_success GPGSSH 'verify and show signatures' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	test_config gpg.mintrustlevel UNDEFINED &&
+	(
+		for commit in initial second merge fourth-signed \
+			fifth-signed sixth-signed seventh-signed tenth-signed \
+			eleventh-signed
+		do
+			git verify-commit $commit &&
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned sixth-unsigned \
+			seventh-unsigned ninth-unsigned
+		do
+			test_must_fail git verify-commit $commit &&
+			git show --pretty=short --show-signature $commit >actual &&
+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in eighth-signed-alt twelfth-signed-alt
+		do
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			grep "${KEY_NOT_TRUSTED}" actual &&
+			echo $commit OK || exit 1
+		done
+	)
+'
+
+test_expect_success GPGSSH 'verify-commit exits success on untrusted signature' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git verify-commit eighth-signed-alt 2>actual &&
+	grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
+	! grep "${BAD_SIGNATURE}" actual &&
+	grep "${KEY_NOT_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	test_config gpg.minTrustLevel fully &&
+	git verify-commit sixth-signed
+'
+
+test_expect_success GPGSSH 'verify-commit exits success with low minTrustLevel' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	test_config gpg.minTrustLevel marginal &&
+	git verify-commit sixth-signed
+'
+
+test_expect_success GPGSSH 'verify-commit exits failure with high minTrustLevel' '
+	test_config gpg.minTrustLevel ultimate &&
+	test_must_fail git verify-commit eighth-signed-alt
+'
+
+test_expect_success GPGSSH 'verify signatures with --raw' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	(
+		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
+		do
+			git verify-commit --raw $commit 2>actual &&
+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
+		do
+			test_must_fail git verify-commit --raw $commit 2>actual &&
+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in eighth-signed-alt
+		do
+			git verify-commit --raw $commit 2>actual &&
+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	)
+'
+
+test_expect_success GPGSSH 'proper header is used for hash algorithm' '
+	git cat-file commit fourth-signed >output &&
+	grep "^$(test_oid header) -----BEGIN SSH SIGNATURE-----" output
+'
+
+test_expect_success GPGSSH 'show signed commit with signature' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git show -s initial >commit &&
+	git show -s --show-signature initial >show &&
+	git verify-commit -v initial >verify.1 2>verify.2 &&
+	git cat-file commit initial >cat &&
+	grep -v -e "${GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.commit &&
+	grep -e "${GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.gpg &&
+	grep -v "^ " cat | grep -v "^gpgsig.* " >cat.commit &&
+	test_cmp show.commit commit &&
+	test_cmp show.gpg verify.2 &&
+	test_cmp cat.commit verify.1
+'
+
+test_expect_success GPGSSH 'detect fudged signature' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git cat-file commit seventh-signed >raw &&
+	sed -e "s/^seventh/7th forged/" raw >forged1 &&
+	git hash-object -w -t commit forged1 >forged1.commit &&
+	test_must_fail git verify-commit $(cat forged1.commit) &&
+	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
+	grep "${BAD_SIGNATURE}" actual1 &&
+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual1 &&
+	! grep "${GOOD_SIGNATURE_UNTRUSTED}" actual1
+'
+
+test_expect_success GPGSSH 'detect fudged signature with NUL' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git cat-file commit seventh-signed >raw &&
+	cat raw >forged2 &&
+	echo Qwik | tr "Q" "\000" >>forged2 &&
+	git hash-object -w -t commit forged2 >forged2.commit &&
+	test_must_fail git verify-commit $(cat forged2.commit) &&
+	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
+	grep "${BAD_SIGNATURE}" actual2 &&
+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual2
+'
+
+test_expect_success GPGSSH 'amending already signed commit' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git checkout fourth-signed^0 &&
+	git commit --amend -S --no-edit &&
+	git verify-commit HEAD &&
+	git show -s --show-signature HEAD >actual &&
+	grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH 'show good signature with custom format' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
+	cat >expect.tmpl <<-\EOF &&
+	G
+	FINGERPRINT
+	principal with number 1
+	FINGERPRINT
+
+	EOF
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show bad signature with custom format' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	cat >expect <<-\EOF &&
+	B
+
+
+
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show untrusted signature with custom format' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	cat >expect.tmpl <<-\EOF &&
+	U
+	FINGERPRINT
+
+	FINGERPRINT
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show untrusted signature with undefined trust level' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	cat >expect.tmpl <<-\EOF &&
+	undefined
+	FINGERPRINT
+
+	FINGERPRINT
+
+	EOF
+	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show untrusted signature with ultimate trust level' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	cat >expect.tmpl <<-\EOF &&
+	fully
+	FINGERPRINT
+	principal with number 1
+	FINGERPRINT
+
+	EOF
+	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show lack of signature with custom format' '
+	cat >expect <<-\EOF &&
+	N
+
+
+
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'log.showsignature behaves like --show-signature' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	test_config log.showsignature true &&
+	git show initial >actual &&
+	grep "${GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH 'check config gpg.format values' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+	test_config gpg.format ssh &&
+	git commit -S --amend -m "success" &&
+	test_config gpg.format OpEnPgP &&
+	test_must_fail git commit -S --amend -m "fail"
+'
+
+test_expect_failure GPGSSH 'detect fudged commit with double signature (TODO)' '
+	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
+	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
+		sed -e "s/^$(test_oid header)//;s/^ //" | gpg --dearmor >double-sig1.sig &&
+	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
+	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
+	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/$(test_oid header) /;2,\$s/^/ /" \
+		double-combined.asc > double-gpgsig &&
+	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
+	git hash-object -w -t commit double-commit >double-commit.commit &&
+	test_must_fail git verify-commit $(cat double-commit.commit) &&
+	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
+	grep "BAD signature from" double-actual &&
+	grep "Good signature from" double-actual
+'
+
+test_expect_failure GPGSSH 'show double signature with custom format (TODO)' '
+	cat >expect <<-\EOF &&
+	E
+
+
+
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.commit) >actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_failure GPGSSH 'verify-commit verifies multiply signed commits (TODO)' '
+	git init multiply-signed &&
+	cd multiply-signed &&
+	test_commit first &&
+	echo 1 >second &&
+	git add second &&
+	tree=$(git write-tree) &&
+	parent=$(git rev-parse HEAD^{commit}) &&
+	git commit --gpg-sign -m second &&
+	git cat-file commit HEAD &&
+	# Avoid trailing whitespace.
+	sed -e "s/^Q//" -e "s/^Z/ /" >commit <<-EOF &&
+	Qtree $tree
+	Qparent $parent
+	Qauthor A U Thor <author@example.com> 1112912653 -0700
+	Qcommitter C O Mitter <committer@example.com> 1112912653 -0700
+	Qgpgsig -----BEGIN PGP SIGNATURE-----
+	QZ
+	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBDRYcY29tbWl0dGVy
+	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMNd+8AoK1I8mhLHviPH+q2I5fIVgPsEtYC
+	Q AKCTqBh+VabJceXcGIZuF0Ry+udbBQ==
+	Q =tQ0N
+	Q -----END PGP SIGNATURE-----
+	Qgpgsig-sha256 -----BEGIN PGP SIGNATURE-----
+	QZ
+	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBIBYcY29tbWl0dGVy
+	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN/NEAn0XO9RYSBj2dFyozi0JKSbssYMtO
+	Q AJwKCQ1BQOtuwz//IjU8TiS+6S4iUw==
+	Q =pIwP
+	Q -----END PGP SIGNATURE-----
+	Q
+	Qsecond
+	EOF
+	head=$(git hash-object -t commit -w commit) &&
+	git reset --hard $head &&
+	git verify-commit $head 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual
+'
+
+test_done
-- 
gitgitgadget

