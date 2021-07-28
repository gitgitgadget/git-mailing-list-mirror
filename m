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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C584C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7D760BD3
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhG1ThF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhG1ThB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:37:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16415C0613C1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso5190954wmq.0
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QAS9hnOSCruAnMJO67LhuiuXgP/Xzg2aTOWl4lMTCg=;
        b=ChXs7AvLhuw9VTTs8dqEOOBANOCcsFRpboZ9nqrrnDPdg+lylJ5z3OFRFyxbuilnkL
         /ZO4phXaVOrjtVW2Hv5mzqV56/AwGCl5cWMc/KyfQ0/6S0FUeN8kqN26Q2FBuoiVlB2N
         vPTX0xYgShGSpjooQlrIhAChBKaGa8yHDSX97VDzbipQ/gcBWssXcYiVwBXKthaQ4EIF
         fYHc+nIS108JhIpMB6HJXjm3w6I1tRTBtsrYA1LXrYrr6t+l6Gcl7ZlOgFR7ruZL0mRQ
         09eJn7wbarm5UbyUw2UBXt4Y79mBG28WfvqZAls0TwJzXIsEQLECMHZSASPs5Y027WIB
         PffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QAS9hnOSCruAnMJO67LhuiuXgP/Xzg2aTOWl4lMTCg=;
        b=GdluIUVOoKTGIdrgYX2t5gi6K1hMi8/s/naBFBoWM7KIGFqG/VGvTQsYDrvpvitRrz
         8xnLphbqCSUjoLy5UfzKvUjPfV74njBs4yxoj69Q0GtraVjPWl64QxNIjy7zXHfeqw92
         ITX7fte3UteTgiL3+7fUKZTN13ZH6RqKs3/zJVSEZ2FHkAOdZzC1wRBaliMeUqo50UgZ
         DE0fzVFUYeM67ygNcAxohbZx2HMZomnjxLqN9a2G5/uzZQk3zl55Ww1lxhd/5LrzfMMZ
         475iP4LedKi63UrY1U8so5E4GI4tPRFN6xMFTO7byBk4+e5w1UXAD1bhqIqWv/51NzqE
         /PsQ==
X-Gm-Message-State: AOAM531hgS7MiCwsf3uiluCgpBZ63MdfshjXGd86rRaMJppMANG5YyHt
        TnoBpkjaw4EhAaGr+0n1XVfpyuiFL20=
X-Google-Smtp-Source: ABdhPJxWE4+FTQi899BoEozcVCLApVKoXaXmntEofzi/zowlXqYMZgwIVvr/236M7FIq+gSGnXrFEA==
X-Received: by 2002:a1c:9d14:: with SMTP id g20mr1145532wme.25.1627501016625;
        Wed, 28 Jul 2021 12:36:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm934265wmj.8.2021.07.28.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:56 -0700 (PDT)
Message-Id: <275af516ebadebf0af6555f27508bdff98a35b94.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:49 +0000
Subject: [PATCH v6 9/9] ssh signing: add documentation
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
