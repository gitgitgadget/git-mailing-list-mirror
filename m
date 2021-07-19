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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCDC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FA961004
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhGSMwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbhGSMwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 08:52:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B98C061768
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 05:55:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so12879090wms.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VsX8aje9d9W0eTw8WLMAfBlbOVOcMc/JGcM1KgRET+c=;
        b=iKhURA5WjuEpFOVHZpJWmNEWjjZXPMnqZDV2vQ6VocsZDoLOH5E2GYIJRdmQqXRJJB
         4XwmGwggQvHGvutKLuHw+sHtM01E+O8nqNuwM5wif7RLO+FTu1g8agKaET4JkSBlOnzP
         lFeVxxIq18XjJmc8wu1eoKG/svI+AFbG9gT8eeXxB9lIRzkwrRDxXjYy2vWB3uDkbyPM
         YdsarcbgiHs/vnBwv7bmlgB6mPZ7pysE/o+dbM+6e6SI83OfNPpG0sgLlxxaPuZ1fght
         uPc7rXz3dT73Xb4qCOzlDebH344ToHrEzJdLEJT40ZL4evvhvElHeA0LIVuI5qFJ8brv
         EJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VsX8aje9d9W0eTw8WLMAfBlbOVOcMc/JGcM1KgRET+c=;
        b=d8jViSJlspCffyjTNnuYxp/7FIzVonpKBzSPsrQLGuQPMFu0tVei8eJO4ULoC3qUoF
         u+JI1cq/6ksXWn8eTlHvHxz1CLmEUy40UVX+7SrrHD6j417PhIcC0+fBW3HUa6rvJjET
         jzcPAijL9azpI0ZCMScRZ6aDI1PmG61VydfJ934r/TVBbvuJJBH2SxDzo0Pjg2ENq/9N
         7FnE+KOpHtFScfP8vDXkOkqp4EUcccspdCgh+n/fnlwQ1zf2xioLSXeTIUlfIYp3NDis
         dI6NggfjJnwQuRAkXvElG1HwSoLBcv9JvttXmMPy+rRB09tTl6ECSEXvu0czgVjE0EX+
         hI+A==
X-Gm-Message-State: AOAM531XMl11NAsSysFKyjzb+j5FG6NpPOPQU4yDBFrkI++yJqkk1S9v
        ACpN2PIgQR2Vxk0hzptIdgt91lv++6Y=
X-Google-Smtp-Source: ABdhPJwR8/T9O3aEVLo9WG5I6mGVKLHZbHi33EDCgLyfdJNG8mxN7W/uGj8SgQn/osOfx0/0MBeK1A==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr26419046wmh.186.1626701603422;
        Mon, 19 Jul 2021 06:33:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9sm25153516wrh.81.2021.07.19.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:33:23 -0700 (PDT)
Message-Id: <06a76e64b353a190ac9f387e2593dde829166ebb.1626701596.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 13:33:13 +0000
Subject: [PATCH v4 6/9] ssh signing: add test prereqs
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

