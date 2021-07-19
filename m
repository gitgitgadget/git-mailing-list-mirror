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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EFAC07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9316661006
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbhGSMwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbhGSMwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 08:52:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C2C061766
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 05:55:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c17so3322620wmb.5
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZwnVW15v5d4A6PvMc5VC31PbZDkfYnzJT+ReYy986bg=;
        b=Naz1CgpDMDD2nFxwfJIFQ4DSE+BrX32H7rkDlfhN7+47C1YiTk9nL1Rmqr6fGWYw6A
         nWeSTP49AC6wV0fBdwyVZr+A4oFpdHuaWgXkM+vc6gllohhaBSTmKRBNEx8PVcxif8/M
         IdxRe3VkjByFPD6JohrNkWDiw0yNEqx495bOx7vlxAw4LE/KVGPLtkOkSzSJTSUm3698
         qypLYyicyqKR3uHQrH2iq7WitpUgrl5yIgxpqSOOlCp2kKa5SZj4SVq9aMtMzejV0Gx9
         lfo8RY+7j0ogaBneNkOPHszQoLTqXV1lwjOrSbrjB/EQxX7qi01NCs6jAv/DinIsifH4
         GjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZwnVW15v5d4A6PvMc5VC31PbZDkfYnzJT+ReYy986bg=;
        b=CtAoCwa7MC8WjsNNKW0/eDuZeEif27QkPR3j/9CEmOMvUAEv/ciARHPi+Np6IhNfnM
         /Tmqx8jpp7EDwPWm119Dbe7n8dAcStIIE+U2ChmYg8Q1BxDugpZngmAQJ38IXZBuZtoG
         jNWUC9tTv8W8NfN6NzTX+AbkFrhfAli5Q3ur+P9E9Wwq6hIakju5FR1hgHwaHpEg+DSf
         Bn+AYUDqf4Z1eHdIyn/sTL/5s9TLXx8sMU6RqFbE6hmGdDvgTk8yf81yTfjZ6/CV1SDL
         i+lYXHT+BnAMTADxeWwzbTZAPxfscFRKXBkW4n+I73c+fkrqzCkscgMOyuwj7s+daPMU
         yLyA==
X-Gm-Message-State: AOAM533GmJHnV7W9+omq05Oq3fPws8SP0r8J9+oMbsPV6uqVx1enamQH
        fFZ6RD9WvKdz0qHyFOKR93RGo0+OD+c=
X-Google-Smtp-Source: ABdhPJzbK1xb7jFNHnNiBGMPEEVJMxfpStCzKblNf2KWWeyGkWQq0MuF+Yzlva7De/xVQT3MmTCcFQ==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr31868615wmi.164.1626701600403;
        Mon, 19 Jul 2021 06:33:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm20547015wro.1.2021.07.19.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:33:20 -0700 (PDT)
Message-Id: <2c75adee8e1d6147c5be1b3b0832cc90d44ba6df.1626701596.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 13:33:09 +0000
Subject: [PATCH v4 2/9] ssh signing: add ssh signature format and signing
 using ssh keys
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

implements the actual sign_buffer_ssh operation and move some shared
cleanup code into a strbuf function

Set gpg.format = ssh and user.signingkey to either a ssh public key
string (like from an authorized_keys file), or a ssh key file.
If the key file or the config value itself contains only a public key
then the private key needs to be available via ssh-agent.

gpg.ssh.program can be set to an alternative location of ssh-keygen.
A somewhat recent openssh version (8.2p1+) of ssh-keygen is needed for
this feature. Since only ssh-keygen is needed it can this way be
installed seperately without upgrading your system openssh packages.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 137 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 8 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 31cf4ba3938..a086123754d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -41,12 +41,20 @@ static const char *x509_sigs[] = {
 	NULL
 };
 
+static const char *ssh_verify_args[] = { NULL };
+static const char *ssh_sigs[] = {
+	"-----BEGIN SSH SIGNATURE-----",
+	NULL
+};
+
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
 				    size_t payload_size, const char *signature,
 				    size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
+static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
+			   const char *signing_key);
 
 static struct gpg_format gpg_format[] = {
 	{
@@ -65,6 +73,14 @@ static struct gpg_format gpg_format[] = {
 		.verify_signed_buffer = verify_gpg_signed_buffer,
 		.sign_buffer = sign_buffer_gpg,
 	},
+	{
+		.name = "ssh",
+		.program = "ssh-keygen",
+		.verify_args = ssh_verify_args,
+		.sigs = ssh_sigs,
+		.verify_signed_buffer = NULL, /* TODO */
+		.sign_buffer = sign_buffer_ssh
+	},
 };
 
 static struct gpg_format *use_format = &gpg_format[0];
@@ -443,6 +459,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.x509.program"))
 		fmtname = "x509";
 
+	if (!strcmp(var, "gpg.ssh.program"))
+		fmtname = "ssh";
+
 	if (fmtname) {
 		fmt = get_format_by_name(fmtname);
 		return git_config_string(&fmt->program, var, value);
@@ -463,12 +482,26 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	return use_format->sign_buffer(buffer, signature, signing_key);
 }
 
+static void strbuf_trim_trailing_cr(struct strbuf *buffer, int offset)
+{
+	size_t i, j;
+
+	for (i = j = offset; i < buffer->len; i++) {
+		if (buffer->buf[i] != '\r') {
+			if (i != j)
+				buffer->buf[j] = buffer->buf[i];
+			j++;
+		}
+	}
+	strbuf_setlen(buffer, j);
+}
+
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 		    const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
-	size_t i, j, bottom;
+	size_t bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	strvec_pushl(&gpg.args,
@@ -494,13 +527,101 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
-	for (i = j = bottom; i < signature->len; i++)
-		if (signature->buf[i] != '\r') {
-			if (i != j)
-				signature->buf[j] = signature->buf[i];
-			j++;
-		}
-	strbuf_setlen(signature, j);
+	strbuf_trim_trailing_cr(signature, bottom);
 
 	return 0;
 }
+
+static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
+			   const char *signing_key)
+{
+	struct child_process signer = CHILD_PROCESS_INIT;
+	int ret = -1;
+	size_t bottom;
+	struct strbuf signer_stderr = STRBUF_INIT;
+	struct tempfile *temp = NULL, *buffer_file = NULL;
+	char *ssh_signing_key_file = NULL;
+	struct strbuf ssh_signature_filename = STRBUF_INIT;
+
+	if (!signing_key || signing_key[0] == '\0')
+		return error(
+			_("user.signingkey needs to be set for ssh signing"));
+
+	if (istarts_with(signing_key, "ssh-")) {
+		/* A literal ssh key */
+		temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
+		if (!temp)
+			return error_errno(
+				_("could not create temporary file"));
+		if (write_in_full(temp->fd, signing_key, strlen(signing_key)) <
+			    0 ||
+		    close_tempfile_gently(temp) < 0) {
+			error_errno(_("failed writing ssh signing key to '%s'"),
+				    temp->filename.buf);
+			goto out;
+		}
+		ssh_signing_key_file = temp->filename.buf;
+	} else {
+		/* We assume a file */
+		ssh_signing_key_file = expand_user_path(signing_key, 1);
+	}
+
+	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
+	if (!buffer_file) {
+		error_errno(_("could not create temporary file"));
+		goto out;
+	}
+
+	if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
+	    close_tempfile_gently(buffer_file) < 0) {
+		error_errno(_("failed writing ssh signing key buffer to '%s'"),
+			    buffer_file->filename.buf);
+		goto out;
+	}
+
+	strvec_pushl(&signer.args, use_format->program, "-Y", "sign", "-n",
+		     "git", "-f", ssh_signing_key_file,
+		     buffer_file->filename.buf, NULL);
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
+	sigchain_pop(SIGPIPE);
+
+	if (ret && strstr(signer_stderr.buf, "usage:")) {
+		error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
+		goto out;
+	}
+
+	if (ret) {
+		error("%s", signer_stderr.buf);
+		goto out;
+	}
+
+	bottom = signature->len;
+
+	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
+	strbuf_addstr(&ssh_signature_filename, ".sig");
+	if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
+		error_errno(
+			_("failed reading ssh signing data buffer from '%s'"),
+			ssh_signature_filename.buf);
+	}
+	unlink_or_warn(ssh_signature_filename.buf);
+
+	if (ret) {
+		error(_("ssh failed to sign the data"));
+		goto out;
+	}
+
+	/* Strip CR from the line endings, in case we are on Windows. */
+	strbuf_trim_trailing_cr(signature, bottom);
+
+out:
+	if (temp)
+		delete_tempfile(&temp);
+	if (buffer_file)
+		delete_tempfile(&buffer_file);
+	strbuf_release(&signer_stderr);
+	strbuf_release(&ssh_signature_filename);
+	return ret;
+}
-- 
gitgitgadget

