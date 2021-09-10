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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18CAC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6061611F2
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhIJUJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhIJUI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:08:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC83C061757
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so4297112wrb.0
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nwRjjP2LKsMQOZ0wAg3Fh14vn6qx/QxViDjm1JHOJsg=;
        b=doJlo1LQghXQpj6efYxeK8308FRvjuGOMHq/D8z5fuAqGGdvwud1p5izLN4J24Na5H
         E4kx1BV3MEEerjXnEvbsnr/Q/zfxUHQpc23vfR13Vg6tCsEzkZNIawDrB+38pUbCXMAd
         q7DrqjzVIAgznNmxpO7KrlPEoQRuv1fj6OSQ+dnXFZGU5iGqQx8pKgfTtlalCjRqjwM9
         YBmCrM5O1VMRZoalZMRPHEkA75cKiSTdkzLSMoi3NrRUtRW5ozK/ZjcGnI8WqO/tvr6j
         wVDUO5LtEXFQDfqZn2kDn2CMTcHgFZaWVdFNAxTfQMn8OgFYon0PwztTk0SQ32dZSJvc
         rG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nwRjjP2LKsMQOZ0wAg3Fh14vn6qx/QxViDjm1JHOJsg=;
        b=QlAr6b9+VANWJkSKhVQN+rmlmDM3mwyLp7vnQu7wcaP0YLu+uHqd13SI7cVqgv88GH
         fU6MVOJPH2+6JwOLHWWu4jpRO5BP5GFaRPq32DdaWhpmQq5UOof11FmBSbvS0oOnzOjN
         WTifTWCRErSbkkkBlpgBoO543h0NGPxCNLuThbvyKaEVgRcsEOr1jKqfBKOWlqI3l1BJ
         nO1I8N6lFO1FUm0G05VhL0tG34CayH/7sI/Lgr75oTFMeAZGomL0hDyA1mx6euSXQMUM
         jB8wtMkda/gofX60Ys//mn01dUG8QvH14qya7Q39gRBTRsECixszxzIVblkPcvAwMpX4
         9L9w==
X-Gm-Message-State: AOAM530ZfV4vIODnLFW0M4bPapPNYCMTKettP5M81sntoWBq+WMequv9
        MO5KiMFaiKaxqrss0ANFgYH7Iyf/J8I=
X-Google-Smtp-Source: ABdhPJxvRw66Hny5Jw/eJZM+8KyZTHMYI6+ALH9Z38dEYz7YmIhxGGw0wPjN/pZkbCMDF1a6bbiATQ==
X-Received: by 2002:adf:f789:: with SMTP id q9mr11578193wrp.367.1631304466545;
        Fri, 10 Sep 2021 13:07:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d24sm4962950wmb.35.2021.09.10.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:46 -0700 (PDT)
Message-Id: <0864ed04670c271c3e686cc5301bebd45eae2242.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:38 +0000
Subject: [PATCH v8 5/9] ssh signing: provide a textual signing_key_id
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
        Fabian Stelzer <fabian@stelzer.cloud>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

For ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
In push certs and textual output we prefer the ssh fingerprint instead.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h |  6 ++++++
 send-pack.c     |  8 +++----
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3a0cca1b1d2..0f1c6a02e53 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -24,6 +24,7 @@ struct gpg_format {
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
 	const char *(*get_default_key)(void);
+	const char *(*get_key_id)(void);
 };
 
 static const char *openpgp_verify_args[] = {
@@ -61,6 +62,8 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 
 static const char *get_default_ssh_signing_key(void);
 
+static const char *get_ssh_key_id(void);
+
 static struct gpg_format gpg_format[] = {
 	{
 		.name = "openpgp",
@@ -70,6 +73,7 @@ static struct gpg_format gpg_format[] = {
 		.verify_signed_buffer = verify_gpg_signed_buffer,
 		.sign_buffer = sign_buffer_gpg,
 		.get_default_key = NULL,
+		.get_key_id = NULL,
 	},
 	{
 		.name = "x509",
@@ -79,6 +83,7 @@ static struct gpg_format gpg_format[] = {
 		.verify_signed_buffer = verify_gpg_signed_buffer,
 		.sign_buffer = sign_buffer_gpg,
 		.get_default_key = NULL,
+		.get_key_id = NULL,
 	},
 	{
 		.name = "ssh",
@@ -88,6 +93,7 @@ static struct gpg_format gpg_format[] = {
 		.verify_signed_buffer = NULL, /* TODO */
 		.sign_buffer = sign_buffer_ssh,
 		.get_default_key = get_default_ssh_signing_key,
+		.get_key_id = get_ssh_key_id,
 	},
 };
 
@@ -484,6 +490,41 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static char *get_ssh_key_fingerprint(const char *signing_key)
+{
+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf fingerprint_stdout = STRBUF_INIT;
+	struct strbuf **fingerprint;
+
+	/*
+	 * With SSH Signing this can contain a filename or a public key
+	 * For textual representation we usually want a fingerprint
+	 */
+	if (starts_with(signing_key, "ssh-")) {
+		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
+		ret = pipe_command(&ssh_keygen, signing_key,
+				   strlen(signing_key), &fingerprint_stdout, 0,
+				   NULL, 0);
+	} else {
+		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf",
+			     configured_signing_key, NULL);
+		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0,
+				   NULL, 0);
+	}
+
+	if (!!ret)
+		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+			  signing_key);
+
+	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
+	if (!fingerprint[1])
+		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+			  signing_key);
+
+	return strbuf_detach(fingerprint[1], NULL);
+}
+
 /* Returns the first public key from an ssh-agent to use for signing */
 static const char *get_default_ssh_signing_key(void)
 {
@@ -532,6 +573,21 @@ static const char *get_default_ssh_signing_key(void)
 	return default_key;
 }
 
+static const char *get_ssh_key_id(void) {
+	return get_ssh_key_fingerprint(get_signing_key());
+}
+
+/* Returns a textual but unique representation of the signing key */
+const char *get_signing_key_id(void)
+{
+	if (use_format->get_key_id) {
+		return use_format->get_key_id();
+	}
+
+	/* GPG/GPGSM only store a key id on this variable */
+	return get_signing_key();
+}
+
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
diff --git a/gpg-interface.h b/gpg-interface.h
index feac4decf8b..beefacbb1e9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -64,6 +64,12 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
+
+/*
+ * Returns a textual unique representation of the signing key in use
+ * Either a GPG KeyID or a SSH Key Fingerprint
+ */
+const char *get_signing_key_id(void);
 int check_signature(const char *payload, size_t plen,
 		    const char *signature, size_t slen,
 		    struct signature_check *sigc);
diff --git a/send-pack.c b/send-pack.c
index b3a495b7b19..bc0fcdbb000 100644
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

