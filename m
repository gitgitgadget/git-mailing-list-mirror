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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F11FC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDCC6128E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhG0NP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhG0NPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:15:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD4C0613CF
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so1406396wmd.0
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VsX8aje9d9W0eTw8WLMAfBlbOVOcMc/JGcM1KgRET+c=;
        b=H7eS/rXXohy/S4gFfn70CSDqWsTf0vqUMMDRLR1rYYbCh0jM2dzo9aMNuevJKixG+m
         BcjeOYSVGHRxX4ZyeLLr2IOnaSlEdGvjVtWXEhWaPV772mRfaUNPGtmjfV+jwf8c+L/p
         Uz7zTqkiXUHXakH8k1U3dualCLuNoTMSpabQPNSBqOeEHI7ytk0zt6SMt17Vo2GeMTOf
         51nl849m+zI95LEUBaliWeLHCPTgvU8HDQd9c9z97Lzc7Egd6iiRMkxwtrpclr6qBqLV
         Z6EGl+XNiWGpcCHx9wE4gvJRCclWoMHHIbTmKtYnMiFCgj0PYMZHj3wAWFGmHIKL8quY
         BG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VsX8aje9d9W0eTw8WLMAfBlbOVOcMc/JGcM1KgRET+c=;
        b=TkmpX55TU4ZzUQnAP509kPjZkRzn8BhBahFAFCxQT4nrsjPsJZKJ95TgUiFdAU3Jh+
         K/IXqMqPJXgjOhIBq9n6U9hRNhAilZ6gsHxTMbA97MBY/R2J6IClEf85uORMLSnnzIZW
         cHbgHHzRVbMAuNAavpBEY5k7oz7YnYJk1V0kNFankdWeeFIeeEGQfXdUh36Htei5lQbt
         lDc3BIPYbIk5yepHIcXpra1p5PlSKn+OBHtDZT1EWQ+qqJVU1mULu/5D4FSZxMQA+PRw
         A3yE/uWmvEz1XLdpyjonY9ZLnkZT1nBKc+/u+eFNMKXprP0MgikDzvKIzF4iAmagx8h4
         8I4w==
X-Gm-Message-State: AOAM5317papY76pu2fovDS0GQ36wUwPleAYt1yEYaomZkjZGVFGxdRTk
        9TNoCmT93owv8sphr2DKKKUYI5EGZ5A=
X-Google-Smtp-Source: ABdhPJxTcmALhd/YVqarwKXZVOv5dfnrbEAoWaiZYW9WYA0WUG9tH2pSlTv7voUyrGR4kqXu+vIt7A==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr3274304wmk.71.1627391750661;
        Tue, 27 Jul 2021 06:15:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm3214576wrh.16.2021.07.27.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:15:50 -0700 (PDT)
Message-Id: <eb677b1b6a89dd8dd52bd5b77ba4c2799bb29ad7.1627391744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
        <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 13:15:41 +0000
Subject: [PATCH v5 6/9] ssh signing: add test prereqs
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

generate some ssh keys and a allowedSignersFile for testing

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 9fc5241228e..b4fbcad4bf3 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -87,6 +87,33 @@ test_lazy_prereq RFC1991 '
 	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
 '
 
+test_lazy_prereq GPGSSH '
+	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
+	test $? != 127 || exit 1
+	echo $ssh_version | grep -q "find-principals:missing signature file"
+	test $? = 0 || exit 1;
+	mkdir -p "${GNUPGHOME}" &&
+	chmod 0700 "${GNUPGHOME}" &&
+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
+	ssh-keygen -t rsa -b 2048 -N "" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
+	ssh-keygen -t ed25519 -N "super_secret" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
+	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"\\\"principal with number \" NR \"\\\" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
+	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
+'
+
+SIGNING_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
+SIGNING_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
+SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
+SIGNING_KEY_PASSPHRASE="super_secret"
+SIGNING_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
+
+GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
+GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
+KEY_NOT_TRUSTED="No principal matched"
+BAD_SIGNATURE="Signature verification failed"
+
 sanitize_pgp() {
 	perl -ne '
 		/^-----END PGP/ and $in_pgp = 0;
-- 
gitgitgadget

