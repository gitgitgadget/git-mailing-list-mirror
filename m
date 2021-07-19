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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0ADC07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309E960200
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhGSMw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhGSMwu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 08:52:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CCC0613DD
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 05:55:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c12so4047395wrt.3
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QAS9hnOSCruAnMJO67LhuiuXgP/Xzg2aTOWl4lMTCg=;
        b=cP8FxMeu2LiQAf64UTDDtZY1YXx8fFyhsMjJZJS6FFiXe8poGbInMCXPngf5s3cP45
         I6iYmPQnv2N4ydY74XnXYg7AGmwnnfQvyfsb/32Mlst1UZ/Ffq8DWUy4MSPfmuu/VDRz
         2hXS/eyzsLEGm2MfXy/IJlCMQ+KPHy5orl6v0mVyZFP/6cOb+G9u9OpBj8Sa4jTZkwQw
         N+BjOHMp4xszVGXY42wm8wxZyRB7NbRFbRA9u5FICKTeyfcVaM4loUVZ102P6SArPM4F
         klqXpzMdE97JgEpGY5miNkmWa1HV7Br0g2n5wyeE7LMXUq7Fah0YoBPynZZ847WUaRHR
         8wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QAS9hnOSCruAnMJO67LhuiuXgP/Xzg2aTOWl4lMTCg=;
        b=n+tjISJK44zzMEwRus9k81fD92iS5hwE437IVWRImKYRgHJxaWdvyuadwNqpUDkuxL
         0txFdZJFGY3FWb6rE7WcCcB5lbHyMCIMI8vb/Z0Tza4A+8IXtdmMTtoC8xM2kJOGGfC7
         xKF8wW7x3BW7pRVSok9xz0vAr8MTjwJ6qF8p6IWeOf1d7zbbB0RYvGHFbbnp6HxjmEPe
         QOAtblT3NKP7Yf+SX+5dqyg6kcowslaC2cEzsMiuHlEqNpRUtA54wSFpXFvDy9YlsHFO
         7hij6sVkx63Rg0/b1B9AteR7H+NmNQ1/IrS7wJ+/UH33bc3YlsqNh72m/tFEzktv/lku
         UPrg==
X-Gm-Message-State: AOAM533RzsbveWr3zo0m5OxUG69xmnbNbLEYJoFb6m2cA1ICZYpP8UJJ
        muiOX4mlMa0eEHXvmtS+V70D0ZvlRYE=
X-Google-Smtp-Source: ABdhPJyTNXhwQod9uiDReLYiV4etS3PbS8pRIqqZ/NlhOVgCgUkBW1jnMVeZJx9l1wJiWduIdFsTHQ==
X-Received: by 2002:adf:f592:: with SMTP id f18mr29254959wro.179.1626701605720;
        Mon, 19 Jul 2021 06:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm25122653wrt.0.2021.07.19.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:33:25 -0700 (PDT)
Message-Id: <13f6c229bd1459dcb0c8ab59c1ef22fb3430be72.1626701596.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 13:33:16 +0000
Subject: [PATCH v4 9/9] ssh signing: add documentation
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
 Documentation/config/gpg.txt  | 39 +++++++++++++++++++++++++++++++++--
 Documentation/config/user.txt |  6 ++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index d94025cb368..dc790512e86 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -11,13 +11,13 @@ gpg.program::
 
 gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp" and another possible value is "x509".
+	Default is "openpgp". Other possible values are "x509", "ssh".
 
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
 	be used as a legacy synonym for `gpg.openpgp.program`. The default
-	value for `gpg.x509.program` is "gpgsm".
+	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
 
 gpg.minTrustLevel::
 	Specifies a minimum trust level for signature verification.  If
@@ -33,3 +33,38 @@ gpg.minTrustLevel::
 * `marginal`
 * `fully`
 * `ultimate`
+
+gpg.ssh.allowedSignersFile::
+	A file containing ssh public keys which you are willing to trust.
+	The file consists of one or more lines of principals followed by an ssh
+	public key.
+	e.g.: user1@example.com,user2@example.com ssh-rsa AAAAX1...
+	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
+	The principal is only used to identify the key and is available when
+	verifying a signature.
++
+SSH has no concept of trust levels like gpg does. To be able to differentiate
+between valid signatures and trusted signatures the trust level of a signature
+verification is set to `fully` when the public key is present in the allowedSignersFile.
+Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
+Otherwise valid but untrusted signatures will still verify but show no principal
+name of the signer.
++
+This file can be set to a location outside of the repository and every developer
+maintains their own trust store. A central repository server could generate this
+file automatically from ssh keys with push access to verify the code against.
+In a corporate setting this file is probably generated at a global location
+from automation that already handles developer ssh keys.
++
+A repository that only allows signed commits can store the file
+in the repository itself using a path relative to the top-level of the working tree.
+This way only committers with an already valid key can add or change keys in the keyring.
++
+Using a SSH CA key with the cert-authority option
+(see ssh-keygen(1) "CERTIFICATES") is also valid.
+
+gpg.ssh.revocationFile::
+	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
+	See ssh-keygen(1) for details.
+	If a public key is found in this file then it will always be treated
+	as having trust level "never" and signatures will show as invalid.
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 59aec7c3aed..b3c2f2c541e 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -36,3 +36,9 @@ user.signingKey::
 	commit, you can override the default selection with this variable.
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
+	If gpg.format is set to "ssh" this can contain the literal ssh public
+	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
+	corresponds to the private key used for signing. The private key
+	needs to be available via ssh-agent. Alternatively it can be set to
+	a file containing a private key directly. If not set git will call
+	"ssh-add -L" and try to use the first key available.
-- 
gitgitgadget
