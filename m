Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA5CC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5BB60EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbhHCNqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhHCNqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D02C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 06:46:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z4so25415627wrv.11
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G/IA2WOxOrK1uyk5drgZ3Smmg4we8wLdb4C/7+oruhI=;
        b=FqEYDr91EX3Zxp0YCnLFK37MnZdhGZz1BG5rj4bn11KPdsMWM9qMn4M5S81q9prB5D
         9mOxJ0TQwYeLhBGSfI4yEs5VuqFiiHfsEX4SZ2cJFTmOBZtJmszQwG3VgiMI1f5v3QYS
         FVIJwIq+PDGnymytafmsDWnLZB0LfbMslir1DBVOPybHwOl/6+0bhXwTFP6bllzlQw60
         lrSDg1d4WnEz4fB7ytwThDM5PT4tmVCbJXPgTIXI/PUhnqHwsEXrficxnOMfJmeGngZz
         hChJIy3jPWhToeDeEP/KOfiuzRaFYakcWXywdwdkaPePr+2yXto5YwGJ60d4seIJ+7mh
         6yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G/IA2WOxOrK1uyk5drgZ3Smmg4we8wLdb4C/7+oruhI=;
        b=Gf4wrXhN6EA8LC4yVo49A/h+MNCvdfZ6lRdgBmH5LUcJ4n3QKhDxmkHb9dd4gzCcMK
         kdjgNZdXMdYFp1Cw5dzAmEYJaawSirRWXpF0HfqPwYy2SZG7kBBY755b2APxQ7P3Dp53
         xoWNhq53Oo+bWs730XXfx8afB8yxKxGpH9JXEMsjAfHLVFtWF4/B+tMuWFKJ6KwAzQzN
         ZyV+IJ/5TYYB9/58E1ogJmnQoLuYuE26J+JyUaIoh/3J3WQVUFKP5cWnkHBib3VrSuh+
         a9lo9pXPV5C+pxM3zacxD2vqeQUvA46uTbiyvOEt95nNGugTaumLoJkvVkvzRRk3sxhb
         KyuA==
X-Gm-Message-State: AOAM532WO4UEaQhd+G8gVv5V9O+nSjjwNYgQU7h57ltlsdaCkPTqUSMc
        k8G9+Ppd5H6muQipP/ON6SVanKhlD+Y=
X-Google-Smtp-Source: ABdhPJw1+w8c01L+8U/VgUdKPRKisfZ5+uhE5GFl0HrZimpjxW8T8ZRUylEEmVMMvKAxgpwxUlYiqQ==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr23403611wrq.58.1627998365695;
        Tue, 03 Aug 2021 06:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm2637594wmc.47.2021.08.03.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:46:03 -0700 (PDT)
Message-Id: <fe98052a3ea76ae63fa7070f8490d16ccb8514e6.1627998358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 13:45:51 +0000
Subject: [PATCH v7 2/9] ssh signing: add test prereqs
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
        Fabian Stelzer <fs@gigacodes.de>,
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

