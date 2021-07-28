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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE4C432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADEA6101E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhG1ThE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1ThA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:37:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4CC061765
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g15so3918597wrd.3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q8Lm8j+TrHCn9qNr1KefHUTJfsSHrABeJYx/C/WjU1s=;
        b=ASpUM5WUtjVaP5h6E89ws5pFk4IzY3Tpa+BY8Yz4PKff9Mzirsrp4bG2devgMzhk6x
         gtoO/OSZvP19ZEUeeGOMP+xoPOxfzyqKk9LvUC7bHS2PgeuwCcHdD+VfXjW5Z/vMGKoS
         pJyLTnZYDqv3gyjis4xKCe2Jr0xlORDXoTZX0EzKD5nYHvAFll+l8GQY6rWi4zVwDRob
         INA5VcBXda56ply6T9BA9IvcjZfOL2gaXG54RWWDEmgnXmbIbBJX12uXsoQHzorCa6Dk
         3wUKfbAHCgN+inAg1oY4HenS1mTn42Q1PeiPE5NwDlbXWAocgga7RUhURpZyFwltznN2
         ov7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q8Lm8j+TrHCn9qNr1KefHUTJfsSHrABeJYx/C/WjU1s=;
        b=r7rvTYy0HFBwFf3iEwzVEzscl4ibXFyZstozn36H88zMRAKzzAkZvcrzU3SW3F9GCJ
         ZtKgc6hBecCGhuOQ3rNfLWICEKE7fMU4IOS8f/PV1vqGn7i4MVKlL95BXNeNw6hxU5ZA
         Nc9jWb7EsARsgcU26NecqRn8VxvH6V6LY79uLueY7/KfTjc5W7uZtGkYWeyynToirgwh
         DSbEJdESToPrxKSFRnZPI8PH+L7sAdxG2VjFQ646KvwFH+JgjlP0meSmfY9B3zIrBu8z
         gGUiVce+BjztseSmyfFiviuyCzr1TLWNKVpFsPXjr36iapOBTVhxmSUOu5cV1iAhF/GM
         T1kg==
X-Gm-Message-State: AOAM531r5udG2aeV8ZbOtpDJ8GG12XnqUo2LfbR4gE5h48a88wLlsrkd
        xAbZekbyYjLTpjoZMGqEUF3Lj34AuEg=
X-Google-Smtp-Source: ABdhPJwl8SY24DgAOh6Rpw5clMy3aLtmBC1i2zpCt6PD5bxa4an9meLPQpFu5o9JsCMiRs9xGXFmIQ==
X-Received: by 2002:a5d:6184:: with SMTP id j4mr968832wru.340.1627501015972;
        Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm899903wmb.40.2021.07.28.12.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
Message-Id: <d9707443f5cdd77688cc41df0b15780d9c787eb7.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:48 +0000
Subject: [PATCH v6 8/9] ssh signing: add more tests for logs, tags & push
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
 t/t4202-log.sh                   |  23 +++++
 t/t5534-push-signed.sh           | 101 +++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 +++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 39e746fbcbe..afd7f2516ee 100755
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 signed-ssh >actual &&
+	grep "${GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index bba768f5ded..d590249b995 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -137,6 +137,53 @@ test_expect_success GPG 'signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPGSSH 'ssh signed push sends push certificate' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+		SIGNER=principal with number 1
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
+	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+		SIGNER=principal with number 1
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
index 00000000000..05bf520a332
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
+	git verify-tag --raw sixth-signed 2>actual &&
+	grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${BAD_SIGNATURE}" actual &&
+	echo sixth-signed OK
+'
+
+test_expect_success GPGSSH 'verify multiple tags ssh' '
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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
+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
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

