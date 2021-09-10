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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE043C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BD6600AA
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhIJUJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhIJUJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:09:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B8C0613C1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w29so3481650wra.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FYc7gP4ouZ+tmGy3TTaguZ1NmPWmn5xw+ch3KO8SFuM=;
        b=nxl8mhHThitMAdDXiXCw+ycm7mANf24I/hWJJ5V0eREVPCkKhlmy7VQSGtbwvsSjKO
         ph+K9grSYg0gteAbmqaoDkYtVV2P5J8Nm3nZL3DWZd6lWig122qhNmfemK2FXjAt78WC
         LmudoY3Ttd2TwmvWq3j5M3SPq9RWX4/+9HoyeDe2C8CJfAukN6/RfuG2whVyyG/MMOW6
         sq0WB9IZyfsDe4/wNY1MiX3pnmwvaAgtCknXLBxEN7YWCTlTGK1NKmsnGJWA8pdNFhc5
         Ac3rsUYiu3wXKUDKmB3UUgz8BAiMbZon2lY9u+H2oM7/+XP4TytT5mO179Yud6nKrxoR
         inaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FYc7gP4ouZ+tmGy3TTaguZ1NmPWmn5xw+ch3KO8SFuM=;
        b=RQJH/qVS2KpjEqO22gYaDP4F/rYe6PcPGKEy2sa/9m/0aeq8VPs641LqgqrS3QWNRS
         JmgybgqRlA0U8+xtnLxei04ISxOMFoaVrtzo4PmHfqIguWhvgNkb3lAxebw95ZfdXegX
         lQRXWxe6eFo3LN0H0JsQzi02Z+NEUzx2A0zcA3I9vcte8V+C344A40lFMiw+W/3DtyEF
         MUPP5LWHpM+l9LGNbHKosLAgFquMJMJzqttXiZmAGcMchFGMVrwRjZ1uMF0vFs2Mdfxr
         c6yHYfvc0ia/koBxiOdArOg39RautYAsKkneySnllE9IlsKhZ1j9o1j7eeybyF5PUDjr
         R4Sg==
X-Gm-Message-State: AOAM533yoVGleR1Tz2WQdH4WxNIqsWEyuWGdO17MD6QAQ56ZcNX1bVTA
        psuUwxCb/o9WRElwTMvUu1vQbM7QjxI=
X-Google-Smtp-Source: ABdhPJxufPzSnQDNtbC9hZAQJjX/7Hj217EYbRwgjyzn4Jmvjf7COJvU1sXmALQbqW6m3XaKZNe+Pw==
X-Received: by 2002:adf:e34a:: with SMTP id n10mr11557703wrj.320.1631304468717;
        Fri, 10 Sep 2021 13:07:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c23sm5210112wmb.37.2021.09.10.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:48 -0700 (PDT)
Message-Id: <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:42 +0000
Subject: [PATCH v8 9/9] ssh signing: test that gpg fails for unknown keys
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

Test that verify-commit/tag will fail when a gpg key is completely
unknown. To do this we have to generate a key, use it for a signature
and delete it from our keyring aferwards completely.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7510-signed-commit.sh | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 8df5a74f1db..d65a0171f29 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -71,7 +71,25 @@ test_expect_success GPG 'create signed commits' '
 	git tag eleventh-signed $(cat oid) &&
 	echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
 	test_line_count = 1 oid &&
-	git tag twelfth-signed-alt $(cat oid)
+	git tag twelfth-signed-alt $(cat oid) &&
+
+	cat >keydetails <<-\EOF &&
+	Key-Type: RSA
+	Key-Length: 2048
+	Subkey-Type: RSA
+	Subkey-Length: 2048
+	Name-Real: Unknown User
+	Name-Email: unknown@git.com
+	Expire-Date: 0
+	%no-ask-passphrase
+	%no-protection
+	EOF
+	gpg --batch --gen-key keydetails &&
+	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
+	git tag thirteenth-signed &&
+	DELETE_FINGERPRINT=$(gpg -K --with-colons --fingerprint --batch unknown@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
+	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
+	gpg --batch --yes --delete-keys unknown@git.com
 '
 
 test_expect_success GPG 'verify and show signatures' '
@@ -110,6 +128,13 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_success GPG 'verify-commit exits failure on unknown signature' '
+	test_must_fail git verify-commit thirteenth-signed 2>actual &&
+	! grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	grep -q -F -e "No public key" -e "public key not found" actual
+'
+
 test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 	git verify-commit eighth-signed-alt 2>actual &&
 	grep "Good signature from" actual &&
@@ -338,6 +363,8 @@ test_expect_success GPG 'show double signature with custom format' '
 '
 
 
+# NEEDSWORK: This test relies on the test_tick commit/author dates from the first
+# 'create signed commits' test even though it creates its own
 test_expect_success GPG 'verify-commit verifies multiply signed commits' '
 	git init multiply-signed &&
 	cd multiply-signed &&
-- 
gitgitgadget
