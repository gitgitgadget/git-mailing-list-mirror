Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC1C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7FE61992
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 08:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGFIWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhGFIWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 04:22:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C9C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 01:19:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u8so24963644wrq.8
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yyLIF+adh1UvyS/FZAgpYkUCPf8Cs12RF70VMcZd3sM=;
        b=JnMQlmqyEuNmPL48Ai2LtO0kr0Y0HPD/dvbwcNhzX29yhOztsPpvv1ynXPiQdnJpZ6
         8l3f+iv3qo01dChAdI1aS87zAjAn04UKaWWSpg8upRzR/Gg1Vz2euwWSNKD1HQkQSnhW
         e33FeyLwV6zhGUxTgY4TgR++iMffYAF+76tWk60/5QcfdBL3LDY7ta3GJKpT1KUal5ia
         3LcKSC401IDLcv+q0A+5ah2S2BnIWGFu+AXdBoFnNtAxmYEzOiJxR5KTsfuveSSdtXKo
         a8aqbvZYgF8WLivmcTW+BNMSpYFANxXs0wCamKJGLmBpAcvQtmzvDdWDdzxHdlBw0P/w
         9cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyLIF+adh1UvyS/FZAgpYkUCPf8Cs12RF70VMcZd3sM=;
        b=JPtJeUw1Y7+WrBh3MiguuHw22tKIb7BWaLlw2XDGTlA1VqyvtIPGV7SGgkZ7nvstlu
         QEfs7ROc6c7ScdWSYgUWGabsk64xCZMhEd8/6U0E1qsSO2fujOYJ/nV22b/9K1ul4+k4
         EDKYAF0JsfsG+pSlsIh/Mw8/gSyLSXSYpILh2dLqGFkg9DuKv7dhQ9GqizW6TpxjNDsH
         x5bWz+cENHb3aznT8RwpgDjI/cRwoIpozRpu1xrvbl2BB0WDXA0O6I5/cSO+HpGX0/ES
         mrvA3Ggtuh9DBoN0SoEFV/8VKLs7b+NWGG9Y97Rbwg8nfQwzOS940SyCbEUDYBediUWP
         B9DQ==
X-Gm-Message-State: AOAM533JR702BMtPyyvWqazB33aJBjZvvLT+cOG2daO846uSx5w6KQQY
        eVygWmqMbJw4ePbdwExLEVN9ANRbAIU=
X-Google-Smtp-Source: ABdhPJyfJtQ1mVrvMZEzlEt+yHBAnCg0gh7RRU+VpLUsym0ETBZzE/yPO/lLWoQcyfamo/rOLLYTZA==
X-Received: by 2002:adf:e610:: with SMTP id p16mr20400718wrm.13.1625559594986;
        Tue, 06 Jul 2021 01:19:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm19395805wrn.62.2021.07.06.01.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:19:54 -0700 (PDT)
Message-Id: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 08:19:53 +0000
Subject: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

set gpg.format = ssh and user.signingkey to a ssh public key string (like from an
authorized_keys file) and commits/tags can be signed using the private
key from your ssh-agent.

Verification uses a allowed_signers_file (see ssh-keygen(1)) which
defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
verification.

needs openssh>8.2p1

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
    RFC: Add commit & tag signing/verification via SSH keys using ssh-keygen
    
    Support for using private keyfiles directly is still missing and i'm
    unsure on how to configure it or if the pubkey in the signingkey field
    is such a good idea. A SSH Fingerprint as signingkey would be nicer, but
    key lookup would be quite cumbersome. Maybe storing the fingerprint in
    signingkey and then have a gpg.ssh.$FINGERPRINT.publickey/privatekeyfile
    setting? As a default we could get the first ssh key from ssh-add and
    store it in the config to avoid unintentional changes of the used
    signing key. I've started with some tests for SSH Signing but having
    static private keyfiles would make this a lot easier. So still on my
    TODO.
    
    This feature makes git signing much more accessible to the average user.
    Usually they have a SSH Key for pushing code already. Using it for
    signing commits allows us to verify not only the transport but the
    pushed code as well. The allowed_signers file could be kept in the
    repository if all receives are verified (allowing only useris with valid
    signatures to add/change them) or outside if generated/managed
    differently. Tools like gitolite could optionally generate and enforce
    them from the already existing user ssh keys for example.
    
    In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
    signing/encryption and ssh keys which i think is quite common (at least
    for the email part). This way we can establish the correct trust for the
    SSH Keys without setting up a separate GPG Infrastructure (which is
    still quite painful for users) or implementing x509 signing support for
    git (which lacks good forwarding mechanisms). Using ssh agent forwarding
    makes this feature easily usable in todays development environments
    where code is often checked out in remote VMs / containers.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v1
Pull-Request: https://github.com/git/git/pull/1041

 Documentation/config/gpg.txt  |  13 ++-
 Documentation/config/user.txt |   4 +
 gpg-interface.c               | 212 ++++++++++++++++++++++++++++++----
 gpg-interface.h               |   3 +
 4 files changed, 205 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index d94025cb368..fd71bd782ec 100644
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
@@ -27,6 +27,15 @@ gpg.minTrustLevel::
 	with at least `undefined` trust.  Setting this option overrides
 	the required trust-level for all operations.  Supported values,
 	in increasing order of significance:
+
+gpg.ssh.allowedSigners::
+	A file containing all valid SSH signing principals. 
+	Similar to an .ssh/authorized_keys file. See ssh-keygen(1) for details.
+	Defaults to .gitsigners
+
+gpg.ssh.revocationFile::
+	Either a SSH KRL or a list of revoked public keys.
+	See ssh-keygen(1) for details.
 +
 * `undefined`
 * `never`
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 59aec7c3aed..1632e7b320f 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -36,3 +36,7 @@ user.signingKey::
 	commit, you can override the default selection with this variable.
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
+	If gpg.format is set to "ssh" this needs to contain the valid
+	ssh public key (e.g.: "ssh-rsa XXXXXX identifier") which corresponds
+	to the private key used for signing. The private key needs to be available
+	via ssh-agent. Direct private key files are not supported yet.
diff --git a/gpg-interface.c b/gpg-interface.c
index 127aecfc2b0..53504f64410 100644
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
@@ -144,6 +156,38 @@ static int parse_gpg_trust_level(const char *level,
 	return 1;
 }
 
+static void parse_ssh_output(struct signature_check *sigc)
+{
+	const char *output = NULL;
+	char *next = NULL;
+
+	// ssh-keysign output should be:
+	// Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
+
+	output = xmemdupz(sigc->gpg_status, strcspn(sigc->gpg_status, " \n"));
+	if (skip_prefix(sigc->gpg_status, "Good \"git\" signature for ", &output)) {
+		sigc->result = 'G';
+
+		next = strchrnul(output, ' ');
+		replace_cstring(&sigc->signer, output, next);
+		output = next + 1;
+		next = strchrnul(output, ' '); // 'with'
+		output = next + 1;
+		next = strchrnul(output, ' '); // KEY Type
+		output = next + 1;
+		next = strchrnul(output, ' '); // 'key'
+		output = next + 1;
+		next = strchrnul(output, ' '); // key
+		replace_cstring(&sigc->fingerprint, output, next);
+	} else {
+		sigc->result = 'B';
+	}
+
+	// SSH-Keygen prints onto stdout instead of stderr like the output code expects - so we just copy it over
+	free(sigc->gpg_output);
+	sigc->gpg_output = xmemdupz(sigc->gpg_status, strlen(sigc->gpg_status));
+}
+
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
@@ -262,11 +306,17 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 				struct strbuf *gpg_output,
 				struct strbuf *gpg_status)
 {
-	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct child_process gpg = CHILD_PROCESS_INIT,
+			     ssh_keygen = CHILD_PROCESS_INIT;
 	struct gpg_format *fmt;
 	struct tempfile *temp;
 	int ret;
-	struct strbuf buf = STRBUF_INIT;
+	const char *line;
+	size_t trust_size;
+	char *principal;
+	struct strbuf buf = STRBUF_INIT,
+		      principal_out = STRBUF_INIT,
+		      principal_err = STRBUF_INIT;
 
 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
 	if (!temp)
@@ -283,24 +333,77 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 	if (!fmt)
 		BUG("bad signature '%s'", signature);
 
-	strvec_push(&gpg.args, fmt->program);
-	strvec_pushv(&gpg.args, fmt->verify_args);
-	strvec_pushl(&gpg.args,
-		     "--status-fd=1",
-		     "--verify", temp->filename.buf, "-",
-		     NULL);
+	if (!strcmp(use_format->name, "ssh")) {
+		// Find the principal from the  signers
+		strvec_push(&ssh_keygen.args, fmt->program);
+		strvec_pushl(&ssh_keygen.args,  "-Y", "find-principals",
+						"-f", get_ssh_allowed_signers(),
+						"-s", temp->filename.buf,
+						NULL);
+		ret = pipe_command(&ssh_keygen, NULL, 0, &principal_out, 0, &principal_err, 0);
+		if (strstr(principal_err.buf, "unknown option")) {
+			error(_("openssh version > 8.2p1 is needed for ssh signature verification (ssh-keygen needs -Y find-principals/verify option)"));
+		}
+		if (ret || !principal_out.len)
+			goto out;
+
+		/* Iterate over all lines */
+		for (line = principal_out.buf; *line; line = strchrnul(line + 1, '\n')) {
+			while (*line == '\n')
+				line++;
+			if (!*line)
+				break;
 
-	if (!gpg_status)
-		gpg_status = &buf;
+			trust_size = strcspn(line, " \n");
+			principal = xmemdupz(line, trust_size);
 
-	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size,
-			   gpg_status, 0, gpg_output, 0);
-	sigchain_pop(SIGPIPE);
+			strvec_push(&gpg.args,fmt->program);
+			// We found principals - Try with each until we find a match
+			strvec_pushl(&gpg.args, "-Y", "verify",
+						"-n", "git",
+						"-f", get_ssh_allowed_signers(),
+						"-I", principal,
+						"-s", temp->filename.buf,
+						 NULL);
 
-	delete_tempfile(&temp);
+			if (ssh_revocation_file) {
+				strvec_pushl(&gpg.args, "-r", ssh_revocation_file, NULL);
+			}
+
+			if (!gpg_status)
+				gpg_status = &buf;
+
+			sigchain_push(SIGPIPE, SIG_IGN);
+			ret = pipe_command(&gpg, payload, payload_size,
+					   gpg_status, 0, gpg_output, 0);
+			sigchain_pop(SIGPIPE);
 
-	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
+			ret |= !strstr(gpg_status->buf, "Good");
+			if (ret == 0)
+				break;
+		}
+	} else {
+		strvec_push(&gpg.args, fmt->program);
+		strvec_pushv(&gpg.args, fmt->verify_args);
+		strvec_pushl(&gpg.args,
+				"--status-fd=1",
+				"--verify", temp->filename.buf, "-",
+				NULL);
+
+		if (!gpg_status)
+			gpg_status = &buf;
+
+		sigchain_push(SIGPIPE, SIG_IGN);
+		ret = pipe_command(&gpg, payload, payload_size, gpg_status, 0,
+				   gpg_output, 0);
+		sigchain_pop(SIGPIPE);
+		ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
+	}
+
+out:
+	delete_tempfile(&temp);
+	strbuf_release(&principal_out);
+	strbuf_release(&principal_err);
 	strbuf_release(&buf); /* no matter it was used or not */
 
 	return ret;
@@ -323,7 +426,11 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	sigc->payload = xmemdupz(payload, plen);
 	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
-	parse_gpg_output(sigc);
+	if (!strcmp(use_format->name, "ssh")) {
+		parse_ssh_output(sigc);
+	} else {
+		parse_gpg_output(sigc);
+	}
 	status |= sigc->result != 'G';
 	status |= sigc->trust_level < configured_min_trust_level;
 
@@ -394,6 +501,14 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.ssh.allowedsigners")) {
+		return git_config_string(&ssh_allowed_signers, var, value);
+	}
+
+	if (!strcmp(var, "gpg.ssh.revocationfile")) {
+		return git_config_string(&ssh_revocation_file, var, value);
+	}
+
 	if (!strcmp(var, "gpg.format")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -425,6 +540,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.x509.program"))
 		fmtname = "x509";
 
+	if (!strcmp(var, "gpg.ssh.program"))
+		fmtname = "ssh";
+
 	if (fmtname) {
 		fmt = get_format_by_name(fmtname);
 		return git_config_string(&fmt->program, var, value);
@@ -437,7 +555,19 @@ const char *get_signing_key(void)
 {
 	if (configured_signing_key)
 		return configured_signing_key;
-	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+	if (!strcmp(use_format->name, "ssh")) {
+		// We could simply use the first key listed by ssh-add -L and risk signing with the wrong key
+		return "";
+	} else {
+		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
+	}
+}
+
+const char *get_ssh_allowed_signers(void)
+{
+	if (ssh_allowed_signers)
+		return ssh_allowed_signers;
+	return GPG_SSH_ALLOWED_SIGNERS;
 }
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
@@ -446,12 +576,35 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	int ret;
 	size_t i, j, bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
-
-	strvec_pushl(&gpg.args,
-		     use_format->program,
-		     "--status-fd=2",
-		     "-bsau", signing_key,
-		     NULL);
+	struct tempfile *temp = NULL;
+
+	if (!strcmp(use_format->name, "ssh")) {
+		if (!signing_key)
+			return error(_("user.signingkey needs to be set to a ssh public key for ssh signing"));
+
+		// signing_key is a public ssh key
+		// FIXME: Allow specifying a key file so we can use private keyfiles instead of ssh-agent
+		temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
+		if (!temp)
+			return error_errno(_("could not create temporary file"));
+		if (write_in_full(temp->fd, signing_key,
+					strlen(signing_key)) < 0 ||
+			close_tempfile_gently(temp) < 0) {
+			error_errno(_("failed writing ssh signing key to '%s'"), temp->filename.buf);
+			delete_tempfile(&temp);
+			return -1;
+		}
+		strvec_pushl(&gpg.args, use_format->program ,
+					"-Y", "sign",
+					"-n", "git",
+					"-f", temp->filename.buf,
+					NULL);
+	} else {
+		strvec_pushl(&gpg.args, use_format->program ,
+					"--status-fd=2",
+					"-bsau", signing_key,
+					NULL);
+	}
 
 	bottom = signature->len;
 
@@ -464,7 +617,16 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 			   signature, 1024, &gpg_status, 0);
 	sigchain_pop(SIGPIPE);
 
-	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
+	if (temp)
+		delete_tempfile(&temp);
+
+	if (!strcmp(use_format->name, "ssh")) {
+		if (strstr(gpg_status.buf, "unknown option")) {
+			error(_("openssh version > 8.2p1 is needed for ssh signing (ssh-keygen needs -Y sign option)"));
+		}
+	} else {
+		ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
+	}
 	strbuf_release(&gpg_status);
 	if (ret)
 		return error(_("gpg failed to sign the data"));
diff --git a/gpg-interface.h b/gpg-interface.h
index 80567e48948..286c1b4167a 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -7,6 +7,8 @@ struct strbuf;
 #define GPG_VERIFY_RAW			2
 #define GPG_VERIFY_OMIT_STATUS	4
 
+#define GPG_SSH_ALLOWED_SIGNERS ".gitsigners"
+
 enum signature_trust_level {
 	TRUST_UNDEFINED,
 	TRUST_NEVER,
@@ -64,6 +66,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
+const char *get_ssh_allowed_signers(void);
 int check_signature(const char *payload, size_t plen,
 		    const char *signature, size_t slen,
 		    struct signature_check *sigc);

base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
-- 
gitgitgadget
