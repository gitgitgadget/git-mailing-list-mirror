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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AE6C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C661040
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhG1ThC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhG1Tg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6DEC0613CF
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k4so2157496wms.3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=11uONsMbX1Y4NAW6fsPSg9w4k7oOv+YVzUQVmspL6jo=;
        b=bFFUv1mz3NV97ElizkRNmdzngOyfS/m55k852CFcgjj+GGExMrRdn+i3qKrqSVGkD0
         Dcx/KY9C0DPJc9dElrudUl/7v+U6wOHgyoP3g+vQVYn5na/gFpkA8c1yRLQDozSA3Wf9
         RdOKFwB8WzYXuRDLCMnXjM65ESpJXcrV0Fc+HHVF6DoyLWApQ9sq6clAviT2+A//1GVD
         CyVLHPehUM6JuW1V377mF9GI1h2pB41or2zUwKB6FejREmZ4jDUd9LVOomdaw603PuGa
         /KBpCSzZN15BgaIqCmUHOlATgYPuzrsUnunph7X95D4+4bwzhVJOgg1WEdMQZhPbLaso
         Kmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=11uONsMbX1Y4NAW6fsPSg9w4k7oOv+YVzUQVmspL6jo=;
        b=T3rKKrlyhKQX34RoOw+V55My2udWqnlLnORyp2kJyXlfFwj2MnjMegT3PbRRPSWUOE
         eB8G3jHUyZHQYDmE6s2Bgyy8siUBxFpH5Jqntay5SamnddcSiycOSsTCP+8R1oWCGgx8
         iX/OpORNwy3cwLY79wbgMdStX8rJEuSDGjo/XgYHfo203SS7vfNVoqJi9VU6UoOXsofV
         e1nGHXE6KYg4Oul6Yt296ik99s7exBkUu7LmeqP8ZH8E+0HEztx3vrC7ybE4WT0CdQoM
         sa/WIe5by0Pnop1bmWe523dBKPW5yX0v4/HQaU6XMurWsia3Pp17ur8L+feiv7d/vcF5
         D7Jg==
X-Gm-Message-State: AOAM5331mcG44omhevWab8dxqoaf0dNoQlq8ncgYQFL8Kn3s1WKRklun
        wLM1bqaiig1eT5+Ar/NQQX00OTey9Jw=
X-Google-Smtp-Source: ABdhPJw6d931tEogM2YEs1+h7DufRtIlzgvaymngmarg86l4fn4xI7n7oPNvaOkW5SJxM3CIJzoHEw==
X-Received: by 2002:a1c:20c7:: with SMTP id g190mr1170692wmg.16.1627501014715;
        Wed, 28 Jul 2021 12:36:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm735089wrs.56.2021.07.28.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:54 -0700 (PDT)
Message-Id: <18a26ca49e7a9b0046559ac8d5c62c99ea7262ae.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:46 +0000
Subject: [PATCH v6 6/9] ssh signing: add test prereqs
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
 t/lib-gpg.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 9fc5241228e..600c8d1a026 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -87,6 +87,35 @@ test_lazy_prereq RFC1991 '
 	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
 '
 
+test_lazy_prereq GPGSSH '
+	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
+	test $? != 127 || exit 1
+	echo $ssh_version | grep -q "find-principals:missing signature file"
+	test $? = 0 || exit 1;
+	mkdir -p "${GNUPGHOME}" &&
+	chmod 0700 "${GNUPGHOME}" &&
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
+	echo "\"principal with number 1\" $(cat "${GNUPGHOME}/ed25519_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
+	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
+	echo "\"principal with number 2\" $(cat "${GNUPGHOME}/rsa_2048_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
+	ssh-keygen -t ed25519 -N "super_secret" -C "git ed25519 encrypted key" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
+	echo "\"principal with number 3\" $(cat "${GNUPGHOME}/protected_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
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

