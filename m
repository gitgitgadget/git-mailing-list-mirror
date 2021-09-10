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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE457C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF99A611EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhIJUI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhIJUI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:08:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B5DC061757
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y132so2010670wmc.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G/IA2WOxOrK1uyk5drgZ3Smmg4we8wLdb4C/7+oruhI=;
        b=fDsSJnjVRoCyNZpsNe59RnU6mgaoR0jz/RaVv5GlmwiOXKLUnvz0nda7RZoayH8eAP
         Ix9VoMvoW+I7OQIy3VQtlwYkwbppUQJ2cZv6HWQhprmXaOHMKwIj+An/veqaQ6UVBHD/
         W1HPYOL07FsaWsT719KmNzJnlgzVsecR8rNWgMZ2yAXR3Zq3xyoOeiTpfPbaX8wE52qq
         OJfXORG5+gVBCDxW/gYEJY/BEXBFvNVh6C91JmlN3xim2SVXJfFxF9D5fpbW5/NQ55hr
         9dDr7wQeA5qTbNMapjMNvJ2UPH64nc+4FkRWTZdjeJiCNscl+JKqEt8J/g5P1WYGNnbd
         KUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G/IA2WOxOrK1uyk5drgZ3Smmg4we8wLdb4C/7+oruhI=;
        b=UefG3mjL44c+4QpgvgT4HGexkuUCFY/qr5lX18GFMsbVBC2ZDfJWloOMgZkvHOmgk1
         8bwKPNZDZHPp/pcXWCluEPqc6g96xZYYOCK0jwxFDdmSdh/s0jH9+laYYM14aGdSe0II
         X0DmAWqPF2UI6+KJKAVMKZvK+4Kgpy9ARcc9SOHj/OJjTo1z7SBi4wkntuwi+VreeDml
         jtFuIS9WjDCQe28i/YnrQ9V4NjsbH5uK6yjORZ3nRkSaEDATHkVmqGfUxRpMUVVkWxR7
         T0eg0mXeA/74mRYnYUQVayfAXyIe8Br7UvQ+UIZSKahtDOjKcA7gchnk4Hn+Fm+7Urcj
         ddDQ==
X-Gm-Message-State: AOAM530HdlujHqK2p/V+bUdByQiY1M6hPNQ83TKSqBvAoyQei97EiQ6Y
        sZOKIeZQYOTp86DQ8GX/YleGEl8VtRs=
X-Google-Smtp-Source: ABdhPJzsIWG2lx5vya/mSNxBPCSVgxu6o6lS9yDTv9zgzZKq2VVInvL0g2USVwmLhflV3u0wvZzITw==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr10015452wmq.21.1631304464642;
        Fri, 10 Sep 2021 13:07:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm4901346wmq.10.2021.09.10.13.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:44 -0700 (PDT)
Message-Id: <d08327ecb259296eb899a1e2c9fdda04fa8a0521.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:35 +0000
Subject: [PATCH v8 2/9] ssh signing: add test prereqs
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

Generate some ssh keys and a allowedSignersFile for testing

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 9fc5241228e..f99ef3e859d 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -87,6 +87,34 @@ test_lazy_prereq RFC1991 '
 	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
 '
 
+GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
+GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
+GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
+GPGSSH_KEY_PASSPHRASE="super_secret"
+GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
+
+GPGSSH_GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
+GPGSSH_GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
+GPGSSH_KEY_NOT_TRUSTED="No principal matched"
+GPGSSH_BAD_SIGNATURE="Signature verification failed"
+
+test_lazy_prereq GPGSSH '
+	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
+	test $? != 127 || exit 1
+	echo $ssh_version | grep -q "find-principals:missing signature file"
+	test $? = 0 || exit 1;
+	mkdir -p "${GNUPGHOME}" &&
+	chmod 0700 "${GNUPGHOME}" &&
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
+	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
+	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
+	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+'
+
 sanitize_pgp() {
 	perl -ne '
 		/^-----END PGP/ and $in_pgp = 0;
-- 
gitgitgadget

