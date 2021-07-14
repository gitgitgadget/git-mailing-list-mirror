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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789C4C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F2C61370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbhGNMNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbhGNMNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38619C061764
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so3762422wms.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nh7gesG8pFCqDvI9dPcirJo21EUrUEODaUMuP59OFM8=;
        b=OBAJjZY5sOhHH/o91QVS5ctf5zMnawHCHHCOKuIKTXr4J9RTMiKL7uaf9RP8rcWdrF
         6U9w1FaNW40T3rT9bl3RfMWUrnbUgZmP94mwqYp3vbvMz8CRv3oY5q843QPVmZBMIZuB
         WqY4IEQPouFvimNE3pij41D/b6gT1//dj0uZl74ghTkbaGVwLxzh/2lbyVnqkSwns9EY
         p0JZDOK9JZDIPCzvVYXgghqKJisAb7bqTIYGL7s7Y5Hd0OzNa+tAqVMrqBDCIGxJ/FiH
         0ALeSAZIk2L1TJWufT6wQzA9WLp8noTGQYmKp31TxGlW8XRYLx5kqemjvBfRnWGKQ0vj
         Kfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nh7gesG8pFCqDvI9dPcirJo21EUrUEODaUMuP59OFM8=;
        b=FfCLfGpiMHO6+KgkJWxKxk0du1vKOLbZ+dETYfWdEzIIC74+7l0usL7jX2ZQ7bRMfD
         7A1wU4KGfDereMhg0GfLA6Jxq/a5ANd/kjbgjxGsC1mSoFb1jPS77gFiC42TIZ5AjqNs
         IzvVCqz8u1XgWtwDx3LwSgHT5rMuw/hrFNVq/L1vb8BoW54j6HRKh75FAy+97adUqhGU
         LETsKI125jy65nH2EgqnQJVPWZqgE3tnHTGEI0G2gBwaQK/onxXmbKAK0eKkggrHs+bj
         ZVSIEHbMugeGsReCHtgUaOJZbZqVqRrLLCuAaSkXYTM2NxLtZtbTu94wbHk8z9Sl5f5j
         eTCg==
X-Gm-Message-State: AOAM532NXxHWHsVgnZZihhROu4jNds2V4QQoiRWrvN4D2BdWsiOQfB8D
        ri0FWIks69yY4bC7Y8zxzUCpAv54/JA=
X-Google-Smtp-Source: ABdhPJyjrOiQhDqJhkx8rRNpPYgBvDipBfH9U6qy9MqwCh1Qiei5jO8yWiag/g+8NkE7XRx9yrWuTg==
X-Received: by 2002:a05:600c:1d11:: with SMTP id l17mr10872183wms.169.1626264618903;
        Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm2559294wrt.86.2021.07.14.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
Message-Id: <1d292a8d7a286ff588a9c189ca961f2ab844d723.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:11 +0000
Subject: [PATCH v3 7/9] ssh signing: add test prereqs
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

generate some ssh keys and a allowed keys keyring for testing

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 9fc5241228e..c65cdde9e5f 100644
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
+	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"principal_\" NR \" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.keyring" &&
+	cat "${GNUPGHOME}/ssh.all_valid.keyring" &&
+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
+'
+
+SIGNING_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
+SIGNING_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
+SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
+SIGNING_KEY_PASSPHRASE="super_secret"
+SIGNING_KEYRING="${GNUPGHOME}/ssh.all_valid.keyring"
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

