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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C7CC4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4CE601FD
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhG0NP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbhG0NPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:15:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91618C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so11628192wrr.2
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V3GzVV4SshoF5I6PPjJe3yHYH1Nj6z8r5KXlmDLzRZo=;
        b=VR+iC6cZKeNN9uAxHDZuaipt3exmnOd8nDw5ZR04fbwEoaQ/YpvmoeH4X/Vyq6uHTq
         +lZZKCKSn//CgnsQUQuPwKyb3qoR/GUEu0m/zf/WhDoABSpi9vz8lEPhOfuWwhVk78Fe
         dmmFC0S7OhKPwoFifFuJPj1/j634I/9ERuzocv3xLwN6eWpER73VVuL1wRAK/4T0x07G
         lilvvhse3nRoO91hK6MczBVg1avmfeFUSF3ollxPC75HTPuHhxcVeSd2sefLrxe317gG
         nVyfEOFdbJ3dh3QBDAbJ1Ij1thj02o0EmBBnvQa36eWw6yf5dRsOVKeC26XVta6mjQHt
         rkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V3GzVV4SshoF5I6PPjJe3yHYH1Nj6z8r5KXlmDLzRZo=;
        b=AeMjDyOzyZTlWfTGrlSf/CEPIVzqUnvI9QcoCVi1lOQLGJ30PmX/Xna6fEKizVOBw2
         d/wfB1s0l3c03EeQYTTrEdw1Y9QKTnKewoRDr6iiwa+YE1hyZ1+3cP1OPFjk3+gyDeeq
         L1wevVTFYpOeKtvm/fAwhzZssguWUjFqcd/i/9ekOsARKEtVRkA60QmRioeCAmF3TCED
         aSNrtiWz49dgbTEWlNVLb79MgQap4FqyanqqmsjC5M+Whth3uuE4GHoxT91frKSgnTHL
         e4jN5wqgrXs/dL6Ir3DxNHtv3Y3Y9/jP59A6z2QBbhLfy5ZpGGVmR83A9f4B454X7K/J
         DrGw==
X-Gm-Message-State: AOAM533NsWrJ9vj4gl6zVwaXjmkBPdxIisxf2srT0sRqTqwhNCIridSE
        PDQRRlJg0VAfrv6LrhHEJhhQWWaAROE=
X-Google-Smtp-Source: ABdhPJxe4CEbQ5uZ3Zk2QqjNoqJJOamQeoAqfdGdVHswZswtSGKOSIOouiKhzzC8C3w5D9FMWnO02w==
X-Received: by 2002:a05:6000:1625:: with SMTP id v5mr21712205wrb.80.1627391748194;
        Tue, 27 Jul 2021 06:15:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm2944748wmi.1.2021.07.27.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:15:47 -0700 (PDT)
Message-Id: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627391744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
        <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 13:15:38 +0000
Subject: [PATCH v5 3/9] ssh signing: retrieve a default key from ssh-agent
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

if user.signingkey is not set and a ssh signature is requested we call
ssh-add -L and use the first key we get

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c131977b347..3afacb48900 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -470,11 +470,35 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Returns the first public key from an ssh-agent to use for signing */
+static char *get_default_ssh_signing_key(void)
+{
+	struct child_process ssh_add = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf key_stdout = STRBUF_INIT;
+	struct strbuf **keys;
+
+	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
+	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
+	if (!ret) {
+		keys = strbuf_split_max(&key_stdout, '\n', 2);
+		if (keys[0])
+			return strbuf_detach(keys[0], NULL);
+	}
+
+	strbuf_release(&key_stdout);
+	return "";
+}
+
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
 		return configured_signing_key;
-	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+	if (!strcmp(use_format->name, "ssh")) {
+		return get_default_ssh_signing_key();
+	} else {
+		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
+	}
 }
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
-- 
gitgitgadget

