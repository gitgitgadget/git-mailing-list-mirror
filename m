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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FEC07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39ACE613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhGNMNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbhGNMNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09997C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t5so2897872wrw.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t38ob4PimtGnOR2G33fUD1FwP9dWaKhRAuVM93OHUxs=;
        b=J6hqUUqsX4DHb0oG0u8vhbc4xNaFgRZboY6a43P2sGg0veRqwVcySIFVtm18TEFQQE
         +phdGdGouGtvL8bhkTXw/hkPEkrNPdLuhKGLw0QsrUZrSSPSit0fU0Q/hqLVzyFoweM3
         R+YrmmLRsvoSIkVX6QkF0jF8eHvRKH2pawqkS+z0fKehrooL5xkxzFx5NY2zI3X8We0q
         yPfXHwvjb0fVyl6mpHbW2ztz8Nst1180qxjV0vVBMneuWVsykzQrm6V35YODU/nYKWOe
         TPWvbCb5nM1V61arQtRo8q5cijUPWwK784sGdOYsB5220/poOwbMwXXN6qWpA8Kbiewu
         DEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t38ob4PimtGnOR2G33fUD1FwP9dWaKhRAuVM93OHUxs=;
        b=EIxX+GVO8mN+z0SsOlWB9JxOBpqAwqCSnZ/GIxa89tn08MBxHGryHmEGu3syOMxILr
         CNWMm5vZTypk+hWziazyVgzFlDdbKzgj43o13zoX47WJFttAiyvIDzhC3ett9RV+NQBl
         5MdQ/myKkqS42N4NzZQxso5qxD+15+/QdPcWJKI8iTSMGnITQeuCdNaUnBTwGEikDIr1
         s6JqcB98Ax2vBb5HuoQ9i5m7WLCJ/q+3j6NXBLyKbsuMOhm3WW7F6x9DlkRJqm5lLax+
         MnifyyZGb37tP2K7hMu6WJ4SyKM7OEt5n3/019sylEr1rBPH0WS7p5ApB6bYCpfpT1ve
         eRaw==
X-Gm-Message-State: AOAM53367szEvTgdPjW+iVbKcZ3o4HiLumKdLhFJ28v2pJkFZmIcmaG0
        L0toZ4I060gfr4SqoXdH4pIlMzmW4Fc=
X-Google-Smtp-Source: ABdhPJymOMoVqT+JFqA9tWo+L55wIWN/MdsGuFcN8ftfAasV2pDFId2z8Nx6J+XKL3H8LlN+AFoPCg==
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr12575303wrp.351.1626264617657;
        Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm2333436wrs.4.2021.07.14.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
Message-Id: <0581c72634cc4c289d7a063ac2c330d2f87e82b3.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:09 +0000
Subject: [PATCH v3 5/9] ssh signing: provide a textual representation of the
 signing key
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

for ssh the key can be a filename/path or even a literal ssh pubkey
in push certs and textual output we prefer the ssh fingerprint instead

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h |  7 +++++++
 send-pack.c     |  8 ++++----
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index fa32a57d372..328af86c272 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -467,6 +467,42 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static char *get_ssh_key_fingerprint(const char *signing_key) {
+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf fingerprint_stdout = STRBUF_INIT;
+	struct strbuf **fingerprint;
+
+	/*
+	 * With SSH Signing this can contain a filename or a public key
+	 * For textual representation we usually want a fingerprint
+	 */
+	if (istarts_with(signing_key, "ssh-")) {
+		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
+					"-lf", "-",
+					NULL);
+		ret = pipe_command(&ssh_keygen, signing_key, strlen(signing_key),
+			&fingerprint_stdout, 0,  NULL, 0);
+	} else {
+		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
+					"-lf", configured_signing_key,
+					NULL);
+		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0,
+			NULL, 0);
+	}
+
+	if (!!ret)
+		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+			signing_key);
+
+	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
+	if (!fingerprint[1])
+		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+			signing_key);
+
+	return strbuf_detach(fingerprint[1], NULL);
+}
+
 /* Returns the first public key from an ssh-agent to use for signing */
 static char *get_default_ssh_signing_key(void) {
 	struct child_process ssh_add = CHILD_PROCESS_INIT;
@@ -484,6 +520,17 @@ static char *get_default_ssh_signing_key(void) {
 
 	return "";
 }
+
+/* Returns a textual but unique representation ot the signing key */
+const char *get_signing_key_id(void) {
+	if (!strcmp(use_format->name, "ssh")) {
+		return get_ssh_key_fingerprint(get_signing_key());
+	} else {
+		/* GPG/GPGSM only store a key id on this variable */
+		return get_signing_key();
+	}
+}
+
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
diff --git a/gpg-interface.h b/gpg-interface.h
index 5dfd92b81f6..1e842188c26 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -64,6 +64,13 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
+
+/*
+ * Returns a textual unique representation of the signing key in use
+ * Either a GPG KeyID or a SSH Key Fingerprint
+ */
+const char *get_signing_key_id(void);
+
 const char *get_ssh_allowed_signers(void);
 int check_signature(const char *payload, size_t plen,
 		    const char *signature, size_t slen,
diff --git a/send-pack.c b/send-pack.c
index 9cb9f716509..191fc6da544 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -341,13 +341,13 @@ static int generate_push_cert(struct strbuf *req_buf,
 {
 	const struct ref *ref;
 	struct string_list_item *item;
-	char *signing_key = xstrdup(get_signing_key());
+	char *signing_key_id = xstrdup(get_signing_key_id());
 	const char *cp, *np;
 	struct strbuf cert = STRBUF_INIT;
 	int update_seen = 0;
 
 	strbuf_addstr(&cert, "certificate version 0.1\n");
-	strbuf_addf(&cert, "pusher %s ", signing_key);
+	strbuf_addf(&cert, "pusher %s ", signing_key_id);
 	datestamp(&cert);
 	strbuf_addch(&cert, '\n');
 	if (args->url && *args->url) {
@@ -374,7 +374,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (!update_seen)
 		goto free_return;
 
-	if (sign_buffer(&cert, &cert, signing_key))
+	if (sign_buffer(&cert, &cert, get_signing_key()))
 		die(_("failed to sign the push certificate"));
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
@@ -386,7 +386,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	packet_buf_write(req_buf, "push-cert-end\n");
 
 free_return:
-	free(signing_key);
+	free(signing_key_id);
 	strbuf_release(&cert);
 	return update_seen;
 }
-- 
gitgitgadget

