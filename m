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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9DC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C7E60F46
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhHCNrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhHCNqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA66C06179A
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 06:46:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b128so12519729wmb.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FYc7gP4ouZ+tmGy3TTaguZ1NmPWmn5xw+ch3KO8SFuM=;
        b=JBRIhjRpddTDpaPoltMBSd+WlickRneIX8cQdSw9GnahOcVGmtQ4FK2NpeKxD1TFQ6
         QhNj6tb3H9EKX8WJ2v2plQgcZNFd5Rxq3kEdCuzoT8DYnv09MMF+nWU1NF9LaPPWIr+/
         1IxrUVyYlMeTD0AeP5dcMGrFwKm+H/xw4bmTYVnUaeFAcum2dOZzx/wkI1wiAvzHLuqK
         N9GXk+D2Nh16FKr5ubMzl3EqUMDIKOiDBguYMwfSTP9DWbo4sBPwEXBpLqPSGVgO7H9q
         e7zY4Hd8NqeidKie74Ycgrs2kkZXsxiDb1vFIKHQVHf5ST7dtY6ZyPT2sdlNSscCPd3D
         3caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FYc7gP4ouZ+tmGy3TTaguZ1NmPWmn5xw+ch3KO8SFuM=;
        b=UfOWocBX42dPy/RUM5swmphwt+bXy7cJeI12cPq4RvQe2sfHoIwbqLt+Zix5+x30nS
         Im1oS9DP7SWQLM1+6cs/HCFIIRmf82ep35cSF3Fs/Hb2ufRnGvpX4iY8oQpXOcVDaBEi
         qdzcP3fV1Fxf3vHtMSYuJH/EWDlQnNBENl+IURXln23QbOeEDROlRkjqRfalV61R1P3d
         QSpTi+KQxpLLMBGSTl7H5Jx1SnBSlJ68TZE5BPHeoT3nZoVs/kH9Lf+zNPVrNa3p+Q0G
         0hjRC/QbEo391ie/rqCOSuBERkiJgQxYXcASoH32A4L71omURegt1dbHSLvG6hsgUmri
         sHlA==
X-Gm-Message-State: AOAM533QNverbuZAPwoMig/5vKXRi+cl5mV/7NX/AoZ0G/olOILkxEsU
        BKhG6klPKfoffHQcNIxmJUZqsLTgrb8=
X-Google-Smtp-Source: ABdhPJwWOZaajc/aceMe/1TJ7z8vgCkZ5/MPJIZZYU35x1AjHi+mxtddhNEgQOcwNolbBEode/v6dw==
X-Received: by 2002:a1c:7506:: with SMTP id o6mr22680659wmc.155.1627998376718;
        Tue, 03 Aug 2021 06:46:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm14771606wro.30.2021.08.03.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:46:15 -0700 (PDT)
Message-Id: <a5add98197a9a92a84d5ba386a9e801878e6461a.1627998358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 13:45:58 +0000
Subject: [PATCH v7 9/9] ssh signing: test that gpg fails for unkown keys
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

Test that verify-commit/tag will fail when a gpg key is completely
unknown. To do this we have to generate a key, use it for a signature
and delete it from our keyring aferwards completely.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7510-signed-commit.sh | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 8df5a74f1db..d65a0171f29 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -71,7 +71,25 @@ test_expect_success GPG 'create signed commits' '
 	git tag eleventh-signed $(cat oid) &&
 	echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
 	test_line_count = 1 oid &&
-	git tag twelfth-signed-alt $(cat oid)
+	git tag twelfth-signed-alt $(cat oid) &&
+
+	cat >keydetails <<-\EOF &&
+	Key-Type: RSA
+	Key-Length: 2048
+	Subkey-Type: RSA
+	Subkey-Length: 2048
+	Name-Real: Unknown User
+	Name-Email: unknown@git.com
+	Expire-Date: 0
+	%no-ask-passphrase
+	%no-protection
+	EOF
+	gpg --batch --gen-key keydetails &&
+	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
+	git tag thirteenth-signed &&
+	DELETE_FINGERPRINT=$(gpg -K --with-colons --fingerprint --batch unknown@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
+	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
+	gpg --batch --yes --delete-keys unknown@git.com
 '
 
 test_expect_success GPG 'verify and show signatures' '
@@ -110,6 +128,13 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_success GPG 'verify-commit exits failure on unknown signature' '
+	test_must_fail git verify-commit thirteenth-signed 2>actual &&
+	! grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	grep -q -F -e "No public key" -e "public key not found" actual
+'
+
 test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 	git verify-commit eighth-signed-alt 2>actual &&
 	grep "Good signature from" actual &&
@@ -338,6 +363,8 @@ test_expect_success GPG 'show double signature with custom format' '
 '
 
 
+# NEEDSWORK: This test relies on the test_tick commit/author dates from the first
+# 'create signed commits' test even though it creates its own
 test_expect_success GPG 'verify-commit verifies multiply signed commits' '
 	git init multiply-signed &&
 	cd multiply-signed &&
-- 
gitgitgadget
