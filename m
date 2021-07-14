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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53DEC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786B61370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhGNMNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGNMNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DF5C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l7so2920881wrv.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DUjDF58HnIJaAVchh3yiKn6J0Fd3C08zQl2t44GL3q0=;
        b=kZMV4m0hbAECB8AF4bE54JBx7VSfcXLu43Lpk71c+4zLd6eK9whkN+U/BDxRK7Bdy5
         BEq7bc9UscWImjMQ4R48FFwZ+i/lLwb0PHWm79aM1fBwNeSb3dKLaTYkD1EUQ9o0SrtT
         oMMUZ+yWCK6o7YwgvGfudft8vdlGYAP+MwOEmmU6v/fsxHjUGn6OM+Co6inXuE00cXvG
         bh5WoD6Eu82kxVF6D2rNrHgmI7TKo2PKM0HeSgw7BW6N99XQ7BT7y+fwCx5RecpUNz3v
         Q5Qf8GD2dafWN8KML4UA9RgeWeVr7hFIgGmVTEDYxilSBqRGqCGYCx0qk10OogR6qAZu
         8ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DUjDF58HnIJaAVchh3yiKn6J0Fd3C08zQl2t44GL3q0=;
        b=bGSBCkrC243DTHISpzTz9HfKhL6vy5mMgSp7m/C72DmnPFJtIQHBaNv31K5qlm3y2p
         B2aehhPRmQQ2ZUJAb+3p8BsX+Ak5ifoe/N8yYgqFdTrPELbkpfsyW7jiyVDrPst8EQK3
         1JYdxPfPI5dMIEE6R94q7cmasxTc8NsGMwBK20rWzQZcUQHbOPvgDHeDQ5INWjqkuNYp
         MlJl0q1Dm8SzZ1CHv9rGF5qHIxPF/nciyq5V9DjNz9WCIUFKB/rtILlirEKs6viiL96P
         R5uJ4Xg8WjdGpaHx1hmF4jzJZMtEWW+V5YT4iqLty0Po10NDDh8RMS2gOj9Vvsdju/uB
         OzAg==
X-Gm-Message-State: AOAM532D6jXNC5pRevHxkRGxMIKd03CJsfUOMlsIzLA89XB6gvaw51ry
        YdG/0iAd9iLEbZv88gxeNgMUGrFDm4E=
X-Google-Smtp-Source: ABdhPJz1NWGTn60uLSWjvi5/rcpsEIArSe4zP1CoQrSrZmvWqpfjPLCxdPThASaAHb0/KKJuQRswYg==
X-Received: by 2002:a5d:6daf:: with SMTP id u15mr13011941wrs.41.1626264615858;
        Wed, 14 Jul 2021 05:10:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm4996523wmc.12.2021.07.14.05.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:15 -0700 (PDT)
Message-Id: <2f8452f6570b1811682863441020a6e43fc556c7.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:06 +0000
Subject: [PATCH v3 2/9] ssh signing: add documentation
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
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt  | 35 +++++++++++++++++++++++++++++++++--
 Documentation/config/user.txt |  6 ++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index d94025cb368..16af0b0ada8 100644
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
@@ -33,3 +33,34 @@ gpg.minTrustLevel::
 * `marginal`
 * `fully`
 * `ultimate`
+
+gpg.ssh.keyring::
+	A file containing all valid SSH public signing keys.
+	Similar to an .ssh/authorized_keys file.
+	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
+	If a signing key is found in this file then the trust level will
+	be set to "fully". Otherwise if the key is not present
+	but the signature is still valid then the trust level will be "undefined".
+
+	This file can be set to a location outside of the repository
+	and every developer maintains their own trust store.
+	A central repository server could generate this file automatically
+	from ssh keys with push	access to verify the code against.
+	In a corporate setting this file is probably generated at a global location
+	from some automation that already handles developer ssh keys.
+
+	A repository that is only allowing signed commits can store the file
+	in the repository itself using a relative path. This way only committers
+	with an already valid key can add or change keys in the keyring.
+
+	Using a SSH CA key with the cert-authority option
+	(see ssh-keygen(1) "CERTIFICATES") is also valid.
+
+	To revoke a key place the public key without the principal into the
+	revocationKeyring.
+
+gpg.ssh.revocationKeyring::
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

