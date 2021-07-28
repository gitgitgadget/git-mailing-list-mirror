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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA0C432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B7661040
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhG1Tg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhG1Tg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B354C0613C1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so5139957wmg.4
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JiArLkPcBhOFVOY2guTH1cDXj5SJxtbilBb4hOluZCg=;
        b=tPfKz1RYj/T8TmwI2C5RyFtI+EJP4KoVfRFIX6IQ//4QYFTVw19gE/NPcJPtlFsicn
         In0yMyyYC8vdTIT/NzSuRtrC3s+5zB4mx9zKuDOd31rd4lRwmpzJVeWABQ9vRiHc8zYv
         FyAELAkWz8w99V1RO8BMnlKePl4Qd6awfWymhfX+rbzhwni0D6786Wj/9FzwUcU58g+v
         jN1qeRQwcFnpAhj6nlLY3yN7ashpfK7dZGbW1FUBN3Kk9nzFZvhHFpCdI5PYOgMZ2rY1
         rHlBD0NRGhsg81MZisyRaFmdLXCtDBYXq5+o9zCS76/qggqTXFX6EW1oFG6cCknkw4co
         q9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JiArLkPcBhOFVOY2guTH1cDXj5SJxtbilBb4hOluZCg=;
        b=bbw0iRSqRy3P/TQ39ApOC3kYchI57QTeMgT+loSniJMTbhxFlVIzYSarwbUuM9B3dR
         9rjgDWDJPi4aJSmFKg6IjKJ19gJZotRma4N7ITgOWN/rLfZ59Wd+IrRZsTa1N61d4fiM
         LDfkuRFgBVD0pJ3YCtVb2vp7ULGHzamewbZeUSnjiFmiDNWqTkHEmBRBEUkSTABBlbFz
         CaWYIydk6+6/sV/GO2vBuMAzQb2SIUnXxCb32Oqq0lOY9NaissCf/FXHIitHTBxYSIkm
         a7m3GrGsZq3GpSSk2OPOt8aQldPCy8bwD1Eeb6Boep4Td/tRE4A/Vyn2oHC9duOdSsZT
         wv9g==
X-Gm-Message-State: AOAM530jTbOcAwABgzUtkHe4bqfRt20E7Nb2ho1MDjUIXb+dm4nu+b3V
        nOqrU/I01mX4rkimrxnXPSKjF0F3CqY=
X-Google-Smtp-Source: ABdhPJyhVH6wrrYnPc0hZiIWReJINE6PZwVkPBEEf1L11Q5MZO7p0sZ2b71WHFmFMKE0GSw52PWY9A==
X-Received: by 2002:a1c:9d14:: with SMTP id g20mr1145294wme.25.1627501011884;
        Wed, 28 Jul 2021 12:36:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm794834wrt.23.2021.07.28.12.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:51 -0700 (PDT)
Message-Id: <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:42 +0000
Subject: [PATCH v6 2/9] ssh signing: add ssh signature format and signing
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
index 31cf4ba3938..c131977b347 100644
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
@@ -463,12 +482,30 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	return use_format->sign_buffer(buffer, signature, signing_key);
 }
 
+/*
+ * Strip CR from the line endings, in case we are on Windows.
+ * NEEDSWORK: make it trim only CRs before LFs and rename
+ */
+static void remove_cr_after(struct strbuf *buffer, size_t offset)
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
@@ -494,13 +531,97 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
-	for (i = j = bottom; i < signature->len; i++)
-		if (signature->buf[i] != '\r') {
-			if (i != j)
-				signature->buf[j] = signature->buf[i];
-			j++;
-		}
-	strbuf_setlen(signature, j);
+	remove_cr_after(signature, bottom);
 
 	return 0;
 }
+
+static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
+			   const char *signing_key)
+{
+	struct child_process signer = CHILD_PROCESS_INIT;
+	int ret = -1;
+	size_t bottom, keylen;
+	struct strbuf signer_stderr = STRBUF_INIT;
+	struct tempfile *key_file = NULL, *buffer_file = NULL;
+	char *ssh_signing_key_file = NULL;
+	struct strbuf ssh_signature_filename = STRBUF_INIT;
+
+	if (!signing_key || signing_key[0] == '\0')
+		return error(
+			_("user.signingkey needs to be set for ssh signing"));
+
+	if (starts_with(signing_key, "ssh-")) {
+		/* A literal ssh key */
+		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
+		if (!key_file)
+			return error_errno(
+				_("could not create temporary file"));
+		keylen = strlen(signing_key);
+		if (write_in_full(key_file->fd, signing_key, keylen) < 0 ||
+		    close_tempfile_gently(key_file) < 0) {
+			error_errno(_("failed writing ssh signing key to '%s'"),
+				    key_file->filename.buf);
+			goto out;
+		}
+		ssh_signing_key_file = key_file->filename.buf;
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
+	strvec_pushl(&signer.args, use_format->program,
+		     "-Y", "sign",
+		     "-n", "git",
+		     "-f", ssh_signing_key_file,
+		     buffer_file->filename.buf,
+		     NULL);
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
+	sigchain_pop(SIGPIPE);
+
+	if (ret) {
+		if (strstr(signer_stderr.buf, "usage:"))
+			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
+
+		error("%s", signer_stderr.buf);
+		goto out;
+	}
+
+	bottom = signature->len;
+
+	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
+	strbuf_addstr(&ssh_signature_filename, ".sig");
+	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
+		error_errno(
+			_("failed reading ssh signing data buffer from '%s'"),
+			ssh_signature_filename.buf);
+	}
+	unlink_or_warn(ssh_signature_filename.buf);
+
+	/* Strip CR from the line endings, in case we are on Windows. */
+	remove_cr_after(signature, bottom);
+
+out:
+	if (key_file)
+		delete_tempfile(&key_file);
+	if (buffer_file)
+		delete_tempfile(&buffer_file);
+	strbuf_release(&signer_stderr);
+	strbuf_release(&ssh_signature_filename);
+	return ret;
+}
-- 
gitgitgadget

