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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55894C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD1760BD3
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhG1ThA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1Tg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83EC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m19so2178516wms.0
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V3GzVV4SshoF5I6PPjJe3yHYH1Nj6z8r5KXlmDLzRZo=;
        b=AGfZmyJbtAusVlPWNErHjnDA3oM+gpnHwL8wtaQJw8GhjchSXUBFOdwvUNuru3Dcxx
         0TcajdVgk80huR0IBUSuFSudmRooVef9HOnPHzgXMb3Hrh4s+eIO4tn+Gc9GjWewKBcL
         wBJjBxDF95j8WnMfDPraF1QXE4QTC3wCAeRJBCQRWNsGOV7THCPHf+eY2ZOcDop0lbcm
         mC0uAoVj1+rLWJ6Z/5JoIuulj3oqt5Ur5AKQz+y916xB8Yi/mqkGoJKAptFVUStvghHP
         y6G/10x04Y4Uhu+PF4RCz8B1FLY9nSrMyjrUOaWB/7KsKlMNSjXC7/fYuylk4Wm/iSz3
         Jo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V3GzVV4SshoF5I6PPjJe3yHYH1Nj6z8r5KXlmDLzRZo=;
        b=F65xMIl95bc5IgfMstxEEMEHdBsg6l21TxiAKIiKVFa56rkmRo9eiSkI15/GMu8Gne
         i7TpyqLhhfh1ntqoaNcVGR8QVASkm6RfXfv+G+dPjnIVj85VRWbEB0wQFhVsqDMb03Ta
         M+R5LfLs87WKtx3KiI7ghAsXxe5JIlWDkpcf2mFU4sb2onvQZHdddCFZnFemvws4W0Dt
         2Fca3ChWE8/s6q26mp7BN1TuWyVB/1NezOHXSnMWsv2ks66D0CmOOsYG6BcyJU02PhvP
         3xFq2akzXVeHkHaJKV2WUcPDipwXPYnZbf5bmIMRciJaOsNmkiJ97OMoSc72NfYI7Q3R
         BRhg==
X-Gm-Message-State: AOAM5337pJ+NRJVr7RzzYEP5MrfahM4CzQ9pE2MOH2BG1OM/Z3iE/Z8R
        iDSQOVxUxobqCE0hm6fnkgGsMz2q37w=
X-Google-Smtp-Source: ABdhPJzez2lWEEsUhZF2bwA2fdY26uJht0uRHGD3gCaFLO/eRS3ezG7jdmHmA35kubpZ2/unCkGjbA==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr1114984wmc.163.1627501012678;
        Wed, 28 Jul 2021 12:36:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm829965wmq.7.2021.07.28.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:52 -0700 (PDT)
Message-Id: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:43 +0000
Subject: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
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

