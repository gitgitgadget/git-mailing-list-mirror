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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A6FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D9B603E9
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhHCNq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbhHCNqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE8C06179C
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 06:46:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m12so20603487wru.12
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mYYoLLs82wfDPkXZYjwM5QHY5QNqlpVjf9ujMmu4ZK8=;
        b=MZ23pWaN6gZoQAagqoyjSzb/v50FCBZwoWJzxIw9luMKJowTdu4PQpvP3QDJzZC3kR
         faTkvW9i4WzOfOmFLo9tV997NmEKrDSlpc/F+1sQZSaG2WHMdU5mc4evMfriGto996JM
         07JntfIPz6Lelmm+71NL7si2xFDSgej0CT4DJMq6X1f1KXpOzFmrWx+YuogkxbDnnlUj
         vHumLZO6RppQCxtKNut3PwHf4TNZtXMP0iCH3N52H2OFedbzHCk6+orUhJlnRAeBw29s
         XgYKt+hMk71Ndn/mfELyfPJRA4IcyIlR7QvW8NRbaRgvdyklDtfpPf3gdaGgTKzZDWhg
         OBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mYYoLLs82wfDPkXZYjwM5QHY5QNqlpVjf9ujMmu4ZK8=;
        b=gI1UzPcAcfmUjx0Tw5/VD2POaGLuHqH81xg0H8aEhWE7ClPBr6r9LZY4IdrUncZNq1
         SCyF7/MW6EMBks0OLbkib4eA5dmuY/Hru+mvjAZMCRp3V5vqJlStgfF2AbanHr2tVsTk
         5AimbEKJO0o9UiuxH+1BkZDYOuUx6C1RbfROZeauIuZ6+LHLKOqIFXYdaJxD4KGiBzaS
         lCnILTQl9tCKxzVIruCf5hNxh97aUQARBfvHIp6wf04zXxv+gHweHEzOmllAbsAYQ3Ox
         BvIwdVLpVvFEH37KgqGdxIl94UO/mwAMXaK6drtHnwyLJO13EcW0fIwNCUIZ8HaymjdT
         H12g==
X-Gm-Message-State: AOAM530VKfQPQxZzyuWQipcyd3E4mW+OlxoX8zEqXULOfwzZrl4rONGs
        e/LskGE4/WofRDR7YJ0PQNJUNGeLYMQ=
X-Google-Smtp-Source: ABdhPJyu9tLGth8SjT1n5RnOnvLL/BTgODiE052tS1y8kfQOOF9Fw1oiNfESOhL/w57NRpKKkEIapQ==
X-Received: by 2002:adf:e587:: with SMTP id l7mr22824773wrm.411.1627998370950;
        Tue, 03 Aug 2021 06:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm13330704wma.28.2021.08.03.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:46:10 -0700 (PDT)
Message-Id: <76bc9eb407969a6d99a86072ef33894ed5948272.1627998358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 13:45:54 +0000
Subject: [PATCH v7 5/9] ssh signing: provide a textual signing_key_id
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
index 5a79e0e7110..50cca7e439b 100644
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

