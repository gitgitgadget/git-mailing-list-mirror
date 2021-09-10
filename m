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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C029C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF35611F0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhIJUJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhIJUI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:08:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27CAC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so4297034wrb.0
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b0eJkTewMzFu6XDC4tXfSIWvMZG72Wsu+DB2qkv61VI=;
        b=hKvI/YHxihTNx7PV2b5Zu9mxlzVgDGezomecVTCleAGBqepSqKA2blwrSe00Kq+AMC
         kspvMdV6vOqrLeISQiC7fUhSkp/rXFnnhELMlXrhfKtMrcmNPWnOxbeyJlyfaut5Zk2E
         5jooM3JdMtqhBTMGIg5QLVmERlzqYqVwaQGkBovTrUa48IQ86ewg3AzL3Q1yKtxsuyy6
         7M3rMveIYZQEWZfBCYs0f2Ng+9Mi8s54nv0qy+QBj9Qvf79cgRQ0DJHml2SH1bm8NNr2
         rJ71tDbUEIn2yJOyFkkXrRrFZHkrbU/H9u9pKMNJaCZtRJUJeSNUEDNKGD/HqqKOSIR5
         yWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b0eJkTewMzFu6XDC4tXfSIWvMZG72Wsu+DB2qkv61VI=;
        b=asdxl1rWdvoClK/ve7x5IKGn3E0+Km3TXBRz1raQ424P9risHT8S8035nXjQ7HfY0/
         PK5DFWoCFSuksMZ5XBfRglhXpVRFhHochW9UxncMJ5DJdwAxzXgPALXhtNYkRtb9b6Wh
         LTYQbw+EJWkCUL/bds1OAUYNIlAP/rW5J7k7bfwUTwQg5ToBU7XOQNsage9+hTOb5xTY
         Zw6HMOy8dwCBdqVh5juZpNyO/bAmgyWmieXwW3psHxmOwzpmdO5EajRLDqpiEhpYtEmY
         PV/ENPFKwqfxXaFwc6Xo6Pz7RqyBZlKLlZwC8gOE4f68Id2b75R8Cmmuvliof71slRs8
         jreg==
X-Gm-Message-State: AOAM531j3WINqO9fJujivuRNcVxHP2yjHu30RDS1W5VRqh+CG0qOT7XI
        ceNY8WtStsIv9aFTOdJLU9GWtt9myFA=
X-Google-Smtp-Source: ABdhPJyJcjG+yTIKdVlQMuqW5LFtWHue02WSMLaQYqdsRkFy7hjsXiqOWHUL8v+tYxAXiMy+AzsCUw==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr11674889wrq.3.1631304465317;
        Fri, 10 Sep 2021 13:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm4953381wml.46.2021.09.10.13.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:44 -0700 (PDT)
Message-Id: <c1e9bba8da09d464739e3a1e192d1d9c4cd29e24.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:36 +0000
Subject: [PATCH v8 3/9] ssh signing: add ssh key format and signing code
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

Implements the actual sign_buffer_ssh operation and move some shared
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
 Documentation/config/gpg.txt  |   4 +-
 Documentation/config/user.txt |   5 ++
 gpg-interface.c               | 138 ++++++++++++++++++++++++++++++++--
 3 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index d94025cb368..88531b15f0f 100644
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
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 59aec7c3aed..2155128957c 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -36,3 +36,8 @@ user.signingKey::
 	commit, you can override the default selection with this variable.
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
+	If gpg.format is set to "ssh" this can contain the literal ssh public
+	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
+	corresponds to the private key used for signing. The private key
+	needs to be available via ssh-agent. Alternatively it can be set to
+	a file containing a private key directly.
diff --git a/gpg-interface.c b/gpg-interface.c
index db54b054162..7ca682ac6d6 100644
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
@@ -494,13 +531,98 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
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
+		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
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
+	FREE_AND_NULL(ssh_signing_key_file);
+	return ret;
+}
-- 
gitgitgadget

