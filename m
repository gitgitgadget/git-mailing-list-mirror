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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA90C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E542F613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhGNMNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbhGNMNO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E7C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3739702wmh.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fVs2xmf5ZNVEBlPeWdiZYf1jmPx5igYOim4nj3jUmIs=;
        b=XOHEn6xzO0quVI9TUxFvJvGwYLHd7b9OHC41Ye4ryzQJJnjIaN/bD6X0zlgiRyDNLc
         6CE4XCvN0YLuNJIgZdYOQi57s33ZmPiykeNVwSyvyshGgNNEUHxF0XaR7CzzVJGHFelD
         K+tB0XTx+QNIv6jdQhgXynCRaM2RYrByu90gHZfA59vu8iJZNuPf4wDTalvv3WRviL4S
         0ggMYsnmEV5a7pNO6FYNYFA0f5uS01O4yCdmFC5nF8iV5cekXTCj3hL+atLC28yzSmFG
         s8HXvMKK2xTkUSH35goUKTmG4AP59zX3lj230dEs9TUqX9dvxRNxnmC3Xp5UCwTbaUXP
         E8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fVs2xmf5ZNVEBlPeWdiZYf1jmPx5igYOim4nj3jUmIs=;
        b=R5m2kZGv9KzHunK4nBKng/UE846AfC62XSadJ8mmEkqRJEaqAMoByT2fQDuNYGfbev
         M7FsX5JRNyHdw+0lsZReVd96/SZX1rFlSmidxOgU+FjkZKBInR27PA/VTpstl2YAeuaZ
         YFkGoyeXsLPu7BarADX4aWG5jUT0qvR2hoHfozZOpN55ULjlBMo6JiCgRKMm1HOqaDzt
         gSCeWMKakczb8cpcnDF6Ny2AGX87jemvNNx0dBvF5FQgH5c//ntPl0gX4UTq+2HXIWpm
         NwLx9m2zXnhkb0BhxkYRkXVbL956XIEM/3JNC4+d/GLz0Jr7tC7NGqUca4cZlnC7gbJ+
         +xJg==
X-Gm-Message-State: AOAM5300zkZQoX5tcWHqw6Q4B4gVzAl8xSPI2Tug/JPAhL1iXHuzGyA2
        sT0dxZoWOtZxXT7XZW4DYmIxHE/i1rE=
X-Google-Smtp-Source: ABdhPJzqQ6X0q+q8FRD+LGefkB/Njhv10t7dfsuNRTwiojeNoC6vAVOSQxHXtzRQmrVLI1KMQ6a8KQ==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr10038759wme.107.1626264620129;
        Wed, 14 Jul 2021 05:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm2383883wrx.17.2021.07.14.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:19 -0700 (PDT)
Message-Id: <33330fda441d85b13f1c5dcc5e42c89cc727715a.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:13 +0000
Subject: [PATCH v3 9/9] ssh signing: add more tests for logs, tags & push
 certs
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
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t4202-log.sh                   |  23 +++++
 t/t5534-push-signed.sh           | 101 +++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 +++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa35936..41767627ad0 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1616,6 +1616,16 @@ test_expect_success GPGSM 'setup signed branch x509' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSSH 'setup sshkey signed branch' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b signed-ssh main &&
+	echo foo >foo &&
+	git add foo &&
+	git commit -S -m signed_commit
+'
+
 test_expect_success GPGSM 'log x509 fingerprint' '
 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
 	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
@@ -1628,6 +1638,13 @@ test_expect_success GPGSM 'log OpenPGP fingerprint' '
 	test_cmp expect actual
 '
 
+test_expect_success GPGSSH 'log ssh key fingerprint' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	ssh-keygen -lf  "${SIGNING_KEY_PRIMARY}" | awk "{print \$2\" | \"}" >expect &&
+	git log -n1 --format="%GF | %GP" signed-ssh >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
@@ -1640,6 +1657,12 @@ test_expect_success GPGSM 'log --graph --show-signature x509' '
 	grep "^| gpgsm: Good signature" actual
 '
 
+test_expect_success GPGSSH 'log --graph --show-signature ssh' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	git log --graph --show-signature -n1 signed-ssh >actual &&
+	grep "${GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index bba768f5ded..37c97756032 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -137,6 +137,53 @@ test_expect_success GPG 'signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPGSSH 'ssh signed push sends push certificate' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	# discard the update list
+	cat >/dev/null
+	# record the push certificate
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi &&
+
+	cat >../push-cert-status <<E_O_F
+	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
+	KEY=${GIT_PUSH_CERT_KEY-nokey}
+	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
+	E_O_F
+
+	EOF
+
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
+	git push --signed dst noop ff +noff &&
+
+	(
+		cat <<-\EOF &&
+		SIGNER=principal_1
+		KEY=FINGERPRINT
+		STATUS=G
+		NONCE_STATUS=OK
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
+	) | sed -e "s|FINGERPRINT|$FINGERPRINT|" >expect &&
+
+	noop=$(git rev-parse noop) &&
+	ff=$(git rev-parse ff) &&
+	noff=$(git rev-parse noff) &&
+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_cmp expect dst/push-cert-status
+'
+
 test_expect_success GPG 'inconsistent push options in signed push not allowed' '
 	# First, invoke receive-pack with dummy input to obtain its preamble.
 	prepare_dst &&
@@ -276,6 +323,60 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPGSSH 'fail without key and heed user.signingkey ssh' '
+	test_config gpg.format ssh &&
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	# discard the update list
+	cat >/dev/null
+	# record the push certificate
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi &&
+
+	cat >../push-cert-status <<E_O_F
+	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
+	KEY=${GIT_PUSH_CERT_KEY-nokey}
+	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
+	E_O_F
+
+	EOF
+
+	test_config user.email hasnokey@nowhere.com &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "" &&
+	(
+		sane_unset GIT_COMMITTER_EMAIL &&
+		test_must_fail git push --signed dst noop ff +noff
+	) &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
+	git push --signed dst noop ff +noff &&
+
+	(
+		cat <<-\EOF &&
+		SIGNER=principal_1
+		KEY=FINGERPRINT
+		STATUS=G
+		NONCE_STATUS=OK
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
+	) | sed -e "s|FINGERPRINT|$FINGERPRINT|" >expect &&
+
+	noop=$(git rev-parse noop) &&
+	ff=$(git rev-parse ff) &&
+	noff=$(git rev-parse noff) &&
+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_cmp expect dst/push-cert-status
+'
+
 test_expect_success GPG 'failed atomic push does not execute GPG' '
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
new file mode 100755
index 00000000000..2148a246385
--- /dev/null
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -0,0 +1,161 @@
+#!/bin/sh
+
+test_description='signed tag tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPGSSH 'create signed tags ssh' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
+
+	echo 1 >file && git add file &&
+	test_tick && git commit -m initial &&
+	git tag -s -m initial initial &&
+	git branch side &&
+
+	echo 2 >file && test_tick && git commit -a -m second &&
+	git tag -s -m second second &&
+
+	git checkout side &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -m "third on side" &&
+
+	git checkout main &&
+	test_tick && git merge -S side &&
+	git tag -s -m merge merge &&
+
+	echo 4 >file && test_tick && git commit -a -S -m "fourth unsigned" &&
+	git tag -a -m fourth-unsigned fourth-unsigned &&
+
+	test_tick && git commit --amend -S -m "fourth signed" &&
+	git tag -s -m fourth fourth-signed &&
+
+	echo 5 >file && test_tick && git commit -a -m "fifth" &&
+	git tag fifth-unsigned &&
+
+	git config commit.gpgsign true &&
+	echo 6 >file && test_tick && git commit -a -m "sixth" &&
+	git tag -a -m sixth sixth-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag -s -m 6th sixth-signed HEAD^ &&
+	git tag -m seventh -s seventh-signed &&
+
+	echo 8 >file && test_tick && git commit -a -m eighth &&
+	git tag -u"${SIGNING_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
+'
+
+test_expect_success GPGSSH 'verify and show ssh signatures' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	(
+		for tag in initial second merge fourth-signed sixth-signed seventh-signed
+		do
+			git verify-tag $tag 2>actual &&
+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+		do
+			test_must_fail git verify-tag $tag 2>actual &&
+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in eighth-signed-alt
+		do
+			git verify-tag $tag 2>actual &&
+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			grep "${KEY_NOT_TRUSTED}" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+
+test_expect_success GPGSSH 'detect fudged ssh signature' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	git cat-file tag seventh-signed >raw &&
+	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
+	git hash-object -w -t tag forged1 >forged1.tag &&
+	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
+	grep "${BAD_SIGNATURE}" actual1 &&
+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual1 &&
+	! grep "${GOOD_SIGNATURE_UNTRUSTED}" actual1
+'
+
+test_expect_success GPGSSH 'verify ssh signatures with --raw' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	(
+		for tag in initial second merge fourth-signed sixth-signed seventh-signed
+		do
+			git verify-tag --raw $tag 2>actual &&
+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
+		do
+			test_must_fail git verify-tag --raw $tag 2>actual &&
+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $tag OK || exit 1
+		done
+	) &&
+	(
+		for tag in eighth-signed-alt
+		do
+			git verify-tag --raw $tag 2>actual &&
+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			! grep "${BAD_SIGNATURE}" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+
+test_expect_success GPGSSH 'verify signatures with --raw ssh' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	git verify-tag --raw sixth-signed 2>actual &&
+	grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${BAD_SIGNATURE}" actual &&
+	echo sixth-signed OK
+'
+
+test_expect_success GPGSSH 'verify multiple tags ssh' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	tags="seventh-signed sixth-signed" &&
+	for i in $tags
+	do
+		git verify-tag -v --raw $i || return 1
+	done >expect.stdout 2>expect.stderr.1 &&
+	grep "^${GOOD_SIGNATURE_TRUSTED}" <expect.stderr.1 >expect.stderr &&
+	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+	grep "^${GOOD_SIGNATURE_TRUSTED}" <actual.stderr.1 >actual.stderr &&
+	test_cmp expect.stdout actual.stdout &&
+	test_cmp expect.stderr actual.stderr
+'
+
+test_expect_success GPGSSH 'verifying tag with --format - ssh' '
+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
+	cat >expect <<-\EOF &&
+	tagname : fourth-signed
+	EOF
+	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'verifying a forged tag with --format should fail silently - ssh' '
+	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
+	test_must_be_empty actual-forged
+'
+
+test_done
-- 
gitgitgadget
