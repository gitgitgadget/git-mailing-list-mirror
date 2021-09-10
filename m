Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A4C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075BB611F0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhIJUJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhIJUJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:09:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14343C061760
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so4265127wrb.3
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Ll769iSMccIK5vF2QvnKVwZu12eY878rVQTVc6OvCc=;
        b=Bjv3FD7I1PMzowwhLY/EdECuBm4W5JkcrvFxw+MxoTDajBSQA9VN9gar45WTLUVEEn
         HgdDfMAPgNOBwkLdMgW8ZnsbBiDhKo/9M3SqTATql8m1OLCLMJGxNikwsWiwKfWYZ6WW
         eAyL6S8ZMWAjYBCS0X1IIUfvr5v73f1YJ0RJWuqmTJ+VquMrNBas2rNGnD91e+aTfP2s
         2l9IOkfQUkM25PD2lhCSzhqq9M7yRFW3iof/qgVkbMXbp5N2M7HfKU5GJty6rGxOWWBD
         MjJ7BhBsY/GdkKqYL4G6bgdRKq35yO5W1YfdvTmlYYL4+DTm089YLeKMpkSSQkXnS43h
         xgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Ll769iSMccIK5vF2QvnKVwZu12eY878rVQTVc6OvCc=;
        b=IK5seTimzaoA1hux2dE1WPQHzPcJSNnsSpvYn+zLaw9+85OUe1CVK+JRkVNLEfETpv
         oStIEw6ge7KncBDMMupVqklukV/89h1tSlEj/0nC7Fbb2lGCk+SLJRZWNFF+jKxt1Mtz
         RnLAmQeb7VmmA6WUPGOxomvbDtRo5qs/nDY8ggrPFceVEjLKeGxSv6HZO5cbsG7ornB8
         ungCMeAXO6DseO6aIEyApkL16kP3c0RTL1HypK02ocGTHxTlz9VE3tKTi7vSomHm/atC
         8oWFk3QL5GYkHEJ0pyRyqr/NEG/scccuWZYkZMTUpn7d6JkoCRuO7WNVYnMNUFzdHC5Y
         KcXg==
X-Gm-Message-State: AOAM532ZzVCdLGv2MdXgG3gdMWG9hcjUvVvcYyjh31Go6LDPrsulZxoq
        8h0GJ/fZQJbYYTFmM1/kbYxj3oNGUAc=
X-Google-Smtp-Source: ABdhPJz0Tj3zVI9zSCswAax8povcLc8a3pnwnivxTXFSln6YYyGhCMsv4Jdd8QOYE1KgTeDQbj4Kuw==
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr11673411wrb.128.1631304467673;
        Fri, 10 Sep 2021 13:07:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm5112548wrr.69.2021.09.10.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:47 -0700 (PDT)
Message-Id: <c8e21dc97f1bd19f57876a72604d3be098afa10a.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:40 +0000
Subject: [PATCH v8 7/9] ssh signing: duplicate t7510 tests for commits
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
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fabian@stelzer.cloud>,
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
index 00000000000..badf3ed3204
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
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
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
+	echo 8 >file && test_tick && git commit -a -m eighth -S"${GPGSSH_KEY_UNTRUSTED}" &&
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
+	echo 12 | git commit-tree --gpg-sign="${GPGSSH_KEY_UNTRUSTED}" HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag twelfth-signed-alt $(cat oid)
+'
+
+test_expect_success GPGSSH 'verify and show signatures' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_config gpg.mintrustlevel UNDEFINED &&
+	(
+		for commit in initial second merge fourth-signed \
+			fifth-signed sixth-signed seventh-signed tenth-signed \
+			eleventh-signed
+		do
+			git verify-commit $commit &&
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned sixth-unsigned \
+			seventh-unsigned ninth-unsigned
+		do
+			test_must_fail git verify-commit $commit &&
+			git show --pretty=short --show-signature $commit >actual &&
+			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in eighth-signed-alt twelfth-signed-alt
+		do
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
+			echo $commit OK || exit 1
+		done
+	)
+'
+
+test_expect_success GPGSSH 'verify-commit exits failure on untrusted signature' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit eighth-signed-alt 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_config gpg.minTrustLevel fully &&
+	git verify-commit sixth-signed
+'
+
+test_expect_success GPGSSH 'verify-commit exits success with low minTrustLevel' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	(
+		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
+		do
+			git verify-commit --raw $commit 2>actual &&
+			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
+		do
+			test_must_fail git verify-commit --raw $commit 2>actual &&
+			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			echo $commit OK || exit 1
+		done
+	) &&
+	(
+		for commit in eighth-signed-alt
+		do
+			test_must_fail git verify-commit --raw $commit 2>actual &&
+			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
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
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git show -s initial >commit &&
+	git show -s --show-signature initial >show &&
+	git verify-commit -v initial >verify.1 2>verify.2 &&
+	git cat-file commit initial >cat &&
+	grep -v -e "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.commit &&
+	grep -e "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.gpg &&
+	grep -v "^ " cat | grep -v "^gpgsig.* " >cat.commit &&
+	test_cmp show.commit commit &&
+	test_cmp show.gpg verify.2 &&
+	test_cmp cat.commit verify.1
+'
+
+test_expect_success GPGSSH 'detect fudged signature' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git cat-file commit seventh-signed >raw &&
+	sed -e "s/^seventh/7th forged/" raw >forged1 &&
+	git hash-object -w -t commit forged1 >forged1.commit &&
+	test_must_fail git verify-commit $(cat forged1.commit) &&
+	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
+	grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
+'
+
+test_expect_success GPGSSH 'detect fudged signature with NUL' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git cat-file commit seventh-signed >raw &&
+	cat raw >forged2 &&
+	echo Qwik | tr "Q" "\000" >>forged2 &&
+	git hash-object -w -t commit forged2 >forged2.commit &&
+	test_must_fail git verify-commit $(cat forged2.commit) &&
+	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
+	grep "${GPGSSH_BAD_SIGNATURE}" actual2 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual2
+'
+
+test_expect_success GPGSSH 'amending already signed commit' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout fourth-signed^0 &&
+	git commit --amend -S --no-edit &&
+	git verify-commit HEAD &&
+	git show -s --show-signature HEAD >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH 'show good signature with custom format' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
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
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	cat >expect.tmpl <<-\EOF &&
+	U
+	FINGERPRINT
+
+	FINGERPRINT
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show untrusted signature with undefined trust level' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	cat >expect.tmpl <<-\EOF &&
+	undefined
+	FINGERPRINT
+
+	FINGERPRINT
+
+	EOF
+	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
+	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'show untrusted signature with ultimate trust level' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	cat >expect.tmpl <<-\EOF &&
+	fully
+	FINGERPRINT
+	principal with number 1
+	FINGERPRINT
+
+	EOF
+	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
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
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_config log.showsignature true &&
+	git show initial >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH 'check config gpg.format values' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
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

