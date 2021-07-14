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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C362C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9161370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhGNMNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbhGNMNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37EDC061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so1261799wms.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g6pK5aTs/gN1KFcuPRs2dk+MjEWqMc4v4MOlqu0b/xk=;
        b=DO8T8kVe0VB5MlN+oACurSUQ4gYx0u6OAIDskAf4QxPi6DlSv7j6advbkd18Hr9fkV
         jAnKtlNpThxy49u2KmbRpczq4DOHKjDRQ0NvTxzLtOwwlBePxheEgouHKN4AXjdi7Tfy
         nL3iy6ulgFFAf1kI0dqDMcX1RGtO3evf9OHK4lYkaT7i/VwtGoHeTjxP3OkWe6xSotAw
         LPMNFEVQ7JvrJqDliMXhxnMandZby07emPk/NkGR7NP36jwYPJVdEHKoTsdT3U1GrKXO
         Gd/6/YE2KYzm/YYc80Fph6bqDFGjJR9ik9jA/NSCPShY1ud2jIkIVnUjT0twfJi+T8Mt
         FX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g6pK5aTs/gN1KFcuPRs2dk+MjEWqMc4v4MOlqu0b/xk=;
        b=C+tGbNmoC+yyxD54McYdsFz2YZrixwlBOb0piBvQBsBKT6OzpUITOJRdtTDI38KwGP
         yGow9wfk/jYgRhM+mJVnU9jpZjEUp1PobD4UImKOPnm7QWjV+0No5W2sYRUteGv0xHBa
         Ut0qXwkr6gCPJbO2EnHa+l++KxHpicLXxkj3ywu0VHpBVceimNFSShRIbt263fWGHb84
         U5D9cJSF7zrrxoXAylH+0EXODce9bsPW8Caj8/yDaLaEKoU2tAwMSGE3O4BtxuFxC0Hp
         77A8mMXbSnr8pYF//kGihoHV6Xsk8RsvpDLh+hXr1wSaEnW098IA7UYbG9CivAvGU5MA
         Tt5Q==
X-Gm-Message-State: AOAM5336cwv9kQ7JTIGTVkZWmSdcHRgXr4Vs1/0k2Fje/t00csofF4P2
        VOZ8IGmdBYE/IxPDx08IVO7JYp/07Lk=
X-Google-Smtp-Source: ABdhPJy1qylEvKtoqTQcF6VoUs2wLn7dh4gOr2uJ0zKlfTEbdE2Mh9eyp6dI8uOoe4BF1WbH6J2PPg==
X-Received: by 2002:a05:600c:4ba1:: with SMTP id e33mr3610767wmp.81.1626264615259;
        Wed, 14 Jul 2021 05:10:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm2275026wro.48.2021.07.14.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:14 -0700 (PDT)
Message-Id: <390a8f816cda0574cabe49e9f88ae1803142fb51.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:05 +0000
Subject: [PATCH v3 1/9] Add commit, tag & push signing via SSH keys
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

Openssh v8.2p1 added some new options to ssh-keygen for signature
creation and verification. These allow us to use ssh keys for git
signatures easily.

Start with adding the new signature format, new config options and
rename some fields for consistency.

This feature makes git signing much more accessible to the average user.
Usually they have a SSH Key for pushing code already. Using it
for signing commits allows us to verify not only the transport but the
pushed code as well.

In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
signing/encryption and ssh keys which i think is quite common
(at least for the email part). This way we can establish the correct
trust for the SSH Keys without setting up a separate GPG Infrastructure
(which is still quite painful for users) or implementing x509 signing
support for git (which lacks good forwarding mechanisms).
Using ssh agent forwarding makes this feature easily usable in todays
development environments where code is often checked out in remote VMs / containers.
In such a setup the keyring & revocationKeyring can be centrally
generated from the x509 CA information and distributed to the users.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c |   4 +-
 gpg-interface.c | 122 +++++++++++++++++++++++++++++++++---------------
 gpg-interface.h |   5 +-
 log-tree.c      |   8 ++--
 pretty.c        |   4 +-
 5 files changed, 95 insertions(+), 48 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 0f66818e0f8..1d7b64fa021 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -527,10 +527,10 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			len = payload.len;
 			if (check_signature(payload.buf, payload.len, sig.buf,
 					 sig.len, &sigc) &&
-				!sigc.gpg_output)
+				!sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
-				strbuf_addstr(&sig, sigc.gpg_output);
+				strbuf_addstr(&sig, sigc.output);
 		}
 		signature_check_clear(&sigc);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 127aecfc2b0..3c9a48c8e7e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -8,6 +8,7 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
+const char *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
@@ -35,6 +36,14 @@ static const char *x509_sigs[] = {
 	NULL
 };
 
+static const char *ssh_verify_args[] = {
+	NULL
+};
+static const char *ssh_sigs[] = {
+	"-----BEGIN SSH SIGNATURE-----",
+	NULL
+};
+
 static struct gpg_format gpg_format[] = {
 	{ .name = "openpgp", .program = "gpg",
 	  .verify_args = openpgp_verify_args,
@@ -44,6 +53,9 @@ static struct gpg_format gpg_format[] = {
 	  .verify_args = x509_verify_args,
 	  .sigs = x509_sigs
 	},
+	{ .name = "ssh", .program = "ssh-keygen",
+	  .verify_args = ssh_verify_args,
+	  .sigs = ssh_sigs },
 };
 
 static struct gpg_format *use_format = &gpg_format[0];
@@ -72,7 +84,7 @@ static struct gpg_format *get_format_by_sig(const char *sig)
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
-	FREE_AND_NULL(sigc->gpg_output);
+	FREE_AND_NULL(sigc->output);
 	FREE_AND_NULL(sigc->gpg_status);
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
@@ -257,16 +269,15 @@ error:
 	FREE_AND_NULL(sigc->key);
 }
 
-static int verify_signed_buffer(const char *payload, size_t payload_size,
-				const char *signature, size_t signature_size,
-				struct strbuf *gpg_output,
-				struct strbuf *gpg_status)
+static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt,
+	const char *payload, size_t payload_size,
+	const char *signature, size_t signature_size)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	struct gpg_format *fmt;
 	struct tempfile *temp;
 	int ret;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf gpg_out = STRBUF_INIT;
+	struct strbuf gpg_err = STRBUF_INIT;
 
 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
 	if (!temp)
@@ -279,29 +290,28 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 		return -1;
 	}
 
-	fmt = get_format_by_sig(signature);
-	if (!fmt)
-		BUG("bad signature '%s'", signature);
-
 	strvec_push(&gpg.args, fmt->program);
 	strvec_pushv(&gpg.args, fmt->verify_args);
 	strvec_pushl(&gpg.args,
-		     "--status-fd=1",
-		     "--verify", temp->filename.buf, "-",
-		     NULL);
-
-	if (!gpg_status)
-		gpg_status = &buf;
+			"--status-fd=1",
+			"--verify", temp->filename.buf, "-",
+			NULL);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size,
-			   gpg_status, 0, gpg_output, 0);
+	ret = pipe_command(&gpg, payload, payload_size, &gpg_out, 0,
+				&gpg_err, 0);
 	sigchain_pop(SIGPIPE);
+	ret |= !strstr(gpg_out.buf, "\n[GNUPG:] GOODSIG ");
 
-	delete_tempfile(&temp);
+	sigc->payload = xmemdupz(payload, payload_size);
+	sigc->output = strbuf_detach(&gpg_err, NULL);
+	sigc->gpg_status = strbuf_detach(&gpg_out, NULL);
 
-	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
-	strbuf_release(&buf); /* no matter it was used or not */
+	parse_gpg_output(sigc);
+
+	delete_tempfile(&temp);
+	strbuf_release(&gpg_out);
+	strbuf_release(&gpg_err);
 
 	return ret;
 }
@@ -309,35 +319,36 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
-	struct strbuf gpg_output = STRBUF_INIT;
-	struct strbuf gpg_status = STRBUF_INIT;
+	struct gpg_format *fmt;
 	int status;
 
 	sigc->result = 'N';
 	sigc->trust_level = -1;
 
-	status = verify_signed_buffer(payload, plen, signature, slen,
-				      &gpg_output, &gpg_status);
-	if (status && !gpg_output.len)
-		goto out;
-	sigc->payload = xmemdupz(payload, plen);
-	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
-	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
-	parse_gpg_output(sigc);
+	fmt = get_format_by_sig(signature);
+	if (!fmt) {
+		error(_("bad/incompatible signature '%s'"), signature);
+		return -1;
+	}
+
+	if (!strcmp(fmt->name, "ssh")) {
+		status = verify_ssh_signature(sigc, fmt, payload, plen, signature, slen);
+	} else {
+		status = verify_gpg_signature(sigc, fmt, payload, plen, signature, slen);
+	}
+	if (status && !sigc->output)
+		return !!status;
+
 	status |= sigc->result != 'G';
 	status |= sigc->trust_level < configured_min_trust_level;
 
- out:
-	strbuf_release(&gpg_status);
-	strbuf_release(&gpg_output);
-
 	return !!status;
 }
 
 void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 {
 	const char *output = flags & GPG_VERIFY_RAW ?
-		sigc->gpg_status : sigc->gpg_output;
+		sigc->gpg_status : sigc->output;
 
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
 		fputs(sigc->payload, stdout);
@@ -388,12 +399,32 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	int ret;
 
 	if (!strcmp(var, "user.signingkey")) {
+		/*
+		 * user.signingkey can contain one of the following
+		 * when format = openpgp/x509
+		 *   - GPG KeyID
+		 * when format = ssh
+		 *   - literal ssh public key (e.g. ssh-rsa XXXKEYXXX comment)
+		 *   - path to a file containing a public or a private ssh key
+		 */
 		if (!value)
 			return config_error_nonbool(var);
 		set_signing_key(value);
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.ssh.keyring")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&ssh_allowed_signers, var, value);
+	}
+
+	if (!strcmp(var, "gpg.ssh.revocationkeyring")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&ssh_revocation_file, var, value);
+	}
+
 	if (!strcmp(var, "gpg.format")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -425,6 +456,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.x509.program"))
 		fmtname = "x509";
 
+	if (!strcmp(var, "gpg.ssh.program"))
+		fmtname = "ssh";
+
 	if (fmtname) {
 		fmt = get_format_by_name(fmtname);
 		return git_config_string(&fmt->program, var, value);
@@ -437,7 +471,19 @@ const char *get_signing_key(void)
 {
 	if (configured_signing_key)
 		return configured_signing_key;
-	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+	if (!strcmp(use_format->name, "ssh")) {
+		return get_default_ssh_signing_key();
+	} else {
+		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
+	}
+}
+
+const char *get_ssh_allowed_signers(void)
+{
+	if (ssh_allowed_signers)
+		return ssh_allowed_signers;
+
+	die("A Path to an allowed signers ssh keyring is needed for validation");
 }
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
diff --git a/gpg-interface.h b/gpg-interface.h
index 80567e48948..5dfd92b81f6 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -17,8 +17,8 @@ enum signature_trust_level {
 
 struct signature_check {
 	char *payload;
-	char *gpg_output;
-	char *gpg_status;
+	char *output;
+	char *gpg_status; /* Only used internally -> remove from this public api */
 
 	/*
 	 * possible "result":
@@ -64,6 +64,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
+const char *get_ssh_allowed_signers(void);
 int check_signature(const char *payload, size_t plen,
 		    const char *signature, size_t slen,
 		    struct signature_check *sigc);
diff --git a/log-tree.c b/log-tree.c
index 7b823786c2c..20af9bd1c82 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,10 +513,10 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 
 	status = check_signature(payload.buf, payload.len, signature.buf,
 				 signature.len, &sigc);
-	if (status && !sigc.gpg_output)
+	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
-		show_sig_lines(opt, status, sigc.gpg_output);
+		show_sig_lines(opt, status, sigc.output);
 	signature_check_clear(&sigc);
 
  out:
@@ -583,8 +583,8 @@ static int show_one_mergetag(struct commit *commit,
 		/* could have a good signature */
 		status = check_signature(payload.buf, payload.len,
 					 signature.buf, signature.len, &sigc);
-		if (sigc.gpg_output)
-			strbuf_addstr(&verify_message, sigc.gpg_output);
+		if (sigc.output)
+			strbuf_addstr(&verify_message, sigc.output);
 		else
 			strbuf_addstr(&verify_message, "No signature\n");
 		signature_check_clear(&sigc);
diff --git a/pretty.c b/pretty.c
index b1ecd039cef..daa71394efd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1432,8 +1432,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			check_commit_signature(c->commit, &(c->signature_check));
 		switch (placeholder[1]) {
 		case 'G':
-			if (c->signature_check.gpg_output)
-				strbuf_addstr(sb, c->signature_check.gpg_output);
+			if (c->signature_check.output)
+				strbuf_addstr(sb, c->signature_check.output);
 			break;
 		case '?':
 			switch (c->signature_check.result) {
-- 
gitgitgadget

