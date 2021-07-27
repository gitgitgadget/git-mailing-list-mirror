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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD0C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0076128E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhG0NQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhG0NP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:15:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F98C06179B
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so7504612wrv.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QAS9hnOSCruAnMJO67LhuiuXgP/Xzg2aTOWl4lMTCg=;
        b=aBr/AID/O0+SPO1/sQcsHxNYUdd1vLaHEnhnkwsTgZ/REgtsR/s/uR9qHlaQpyrS5U
         aE80HG7ZlWB7cfVXie/fTTEvTdSmii3amKZWW9bB/Cx8TDIA2+ZbVvlBfvG0q3wQFv5+
         9fGec6L4cB7oh+9PNyEpw+7HIhtCz4tch1I3a02CjhgZST6dC5Jz2AJFfTHdgELB2qXV
         SFtLAHfcN65UX1TMhe3Sokg1BJBgiGeSDb5nfc7LYKyPjka9JONNz8RWCYzIMZK0bzhh
         5qGDErXPgX2KHbhUqM2CZ27FxTEpnul5KPsjWN9H4Bsr+rEpN7qPfMoZAP+5NYlOACmx
         H5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QAS9hnOSCruAnMJO67LhuiuXgP/Xzg2aTOWl4lMTCg=;
        b=PN7nEm0hOHzOF5RJ+qgXNmkM0Q5uIunZuoMCAWvaPMyCjsJvWwemzqyc2vAKFUxoKq
         2JELFpQlpIwSt165ym5HggFB2Fnrvs/PY55EOBO1EYRfqVvAeJJmST0Yfrt9x8g9dRK4
         JqKj6UtJwJdmis3Gz3sOXTu24VFvay/kfNk4pdhP23W/2ho67rVlZZLoXiPSzSxltF9n
         cWxDnvjyR9+mSPkQ8Czm2UDxo7fMxpdbZaLMJMliJpbPkhtXg8qBo1rQWmRCvCIyuzFq
         S3p6DwzSU6DRnN/wn0v1GU0L73b/70YdYAJagQZHzrNf2EhpK7JxM4QLbSX8rT2ZRiqF
         t2Xg==
X-Gm-Message-State: AOAM532id2cvZZELQRXAMoFMcL3spFqhS7xT7+bpgzNlFz4FN6hGHXQq
        O/tAgRe598j3RCCl/MRFHeW+u6vwd1o=
X-Google-Smtp-Source: ABdhPJwnmoWPnGwvGLXvD8PL/RC912wTdLJr+ono6NzmdS7ahfLVmHA3TsvV12H872tB/GqVnWWYSQ==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr17956838wrs.252.1627391752812;
        Tue, 27 Jul 2021 06:15:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm2969870wmb.35.2021.07.27.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:15:52 -0700 (PDT)
Message-Id: <f758ce0ade4575ab3a8de63aaced676eea35146a.1627391744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
        <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 13:15:44 +0000
Subject: [PATCH v5 9/9] ssh signing: add documentation
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
