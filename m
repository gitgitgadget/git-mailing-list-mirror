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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F484C4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AF16101E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhG1ThA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhG1Tg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA0C0613C1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g15so3918512wrd.3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Z2ObP/5m6Bqgpvniwr4cMuIjfLoyWcTtATrlnn97P4=;
        b=rfG07djbQXU4VrCuRgjdwl2LOq6nZJSYS+Cm8K4gWo/pvv5FJSlpo+KJjutNe4GGe6
         4J2PVUGMPwjgLJGgpbZgN3H/H4HWSbkXX+uWyWH028Y5CYEvS7XjP5KXJpqe8gK/bVEL
         2gWMAnGJ3BCStSU3nswg17hgnBou4zKdFnIJC3Ocl4vQzK9czCmQ95t+95DeZM0qeRG2
         ucZAiQ0P8Z4ui/NWDnd9NaV60TfiguzcCsnZIglAyRhfgsgtVksR132wTGkSZ/0gdzxk
         mWmXXHGBky8zFRUASQ6/1O1IPImBb8wBNgg8jmtzfrb2GnrFaYcwdVh9eU2jbbv+4RDT
         RD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Z2ObP/5m6Bqgpvniwr4cMuIjfLoyWcTtATrlnn97P4=;
        b=Jwds1P9F5DVwXxMsvS4Rv6bJ0+LMp5vwq3UXcJHVzbF0FG89EopLrLr0YTFOPgiPvn
         Rud8df/30fxnPABkM5ZvFxJvpiRce//Z/2LHz0LOV8R6RHCxdUfzXxTXbr2WXsYiZ/RS
         BgD7KsSeut5JnXWH51faW60/EWYtxtWg/eFY2K+t2jsaa/DDlf51d+NLX2HxKf48NqMt
         joEMaHa4pVt5pKm1LkbBCDdM1YX0yb3nU+PwGPOASGWLjyycklqs71NcPquEKRiQ8HnC
         zOSU3UJvPS90XkSAp4I2Nbj4iVwAgmUIzIVIiBxjtkX8UckTArq7UE7D5hP8BZrPRu9j
         e9DA==
X-Gm-Message-State: AOAM533IPWa1kyhOccXSBE+3l1np5919YYB3vB+RCKAAXqQvFUkVY7RU
        TdW8r7q/BcTD87n3qwH/DNWc6/jErKs=
X-Google-Smtp-Source: ABdhPJzCksg/A2HxJlg775ASyohPW3fKqviM7tWbPtQWvlj5VhSbIXH6EVA3srLR3QrAxQI4QGaQfg==
X-Received: by 2002:adf:de8a:: with SMTP id w10mr952351wrl.61.1627501014103;
        Wed, 28 Jul 2021 12:36:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm804118wrn.79.2021.07.28.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:53 -0700 (PDT)
Message-Id: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:45 +0000
Subject: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
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

to verify a ssh signature we first call ssh-keygen -Y find-principal to
look up the signing principal by their public key from the
allowedSignersFile. If the key is found then we do a verify. Otherwise
we only validate the signature but can not verify the signers identity.

Verification uses the gpg.ssh.allowedSignersFile (see ssh-keygen(1) "ALLOWED
SIGNERS") which contains valid public keys and a principal (usually
user@domain). Depending on the environment this file can be managed by
the individual developer or for example generated by the central
repository server from known ssh keys with push access. If the
repository only allows signed commits / pushes then the file can even be
stored inside it.

To revoke a key put the public key without the principal prefix into
gpg.ssh.revocationKeyring or generate a KRL (see ssh-keygen(1)
"KEY REVOCATION LISTS"). The same considerations about who to trust for
verification as with the allowedSignersFile apply.

Using SSH CA Keys with these files is also possible. Add
"cert-authority" as key option between the principal and the key to mark
it as a CA and all keys signed by it as valid for this CA.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 builtin/receive-pack.c |   2 +
 gpg-interface.c        | 179 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a34742513ac..62b11c5f3a4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -131,6 +131,8 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 {
 	int status = parse_hide_refs_config(var, value, "receive");
 
+	git_gpg_config(var, value, NULL);
+
 	if (status)
 		return status;
 
diff --git a/gpg-interface.c b/gpg-interface.c
index ec48a37b6cc..703225c3cd3 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -3,11 +3,13 @@
 #include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "dir.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "tempfile.h"
 
 static char *configured_signing_key;
+static const char *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
@@ -51,6 +53,10 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
 				    size_t payload_size, const char *signature,
 				    size_t signature_size);
+static int verify_ssh_signed_buffer(struct signature_check *sigc,
+				    struct gpg_format *fmt, const char *payload,
+				    size_t payload_size, const char *signature,
+				    size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
 static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
@@ -78,7 +84,7 @@ static struct gpg_format gpg_format[] = {
 		.program = "ssh-keygen",
 		.verify_args = ssh_verify_args,
 		.sigs = ssh_sigs,
-		.verify_signed_buffer = NULL, /* TODO */
+		.verify_signed_buffer = verify_ssh_signed_buffer,
 		.sign_buffer = sign_buffer_ssh
 	},
 };
@@ -343,6 +349,165 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
+static void parse_ssh_output(struct signature_check *sigc)
+{
+	const char *line, *principal, *search;
+
+	/*
+	 * ssh-keysign output should be:
+	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
+	 * Good "git" signature for PRINCIPAL WITH WHITESPACE with RSA key SHA256:FINGERPRINT
+	 * or for valid but unknown keys:
+	 * Good "git" signature with RSA key SHA256:FINGERPRINT
+	 */
+	sigc->result = 'B';
+	sigc->trust_level = TRUST_NEVER;
+
+	line = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
+
+	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
+		/* Valid signature and known principal */
+		sigc->result = 'G';
+		sigc->trust_level = TRUST_FULLY;
+
+		/* Search for the last "with" to get the full principal */
+		principal = line;
+		do {
+			search = strstr(line, " with ");
+			if (search)
+				line = search + 1;
+		} while (search != NULL);
+		sigc->signer = xmemdupz(principal, line - principal - 1);
+		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
+		sigc->key = xstrdup(sigc->fingerprint);
+	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) {
+		/* Valid signature, but key unknown */
+		sigc->result = 'G';
+		sigc->trust_level = TRUST_UNDEFINED;
+		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
+		sigc->key = xstrdup(sigc->fingerprint);
+	}
+}
+
+static int verify_ssh_signed_buffer(struct signature_check *sigc,
+				    struct gpg_format *fmt, const char *payload,
+				    size_t payload_size, const char *signature,
+				    size_t signature_size)
+{
+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
+	struct tempfile *buffer_file;
+	int ret = -1;
+	const char *line;
+	size_t trust_size;
+	char *principal;
+	struct strbuf ssh_keygen_out = STRBUF_INIT;
+	struct strbuf ssh_keygen_err = STRBUF_INIT;
+
+	if (!ssh_allowed_signers) {
+		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification"));
+		return -1;
+	}
+
+	buffer_file = mks_tempfile_t(".git_vtag_tmpXXXXXX");
+	if (!buffer_file)
+		return error_errno(_("could not create temporary file"));
+	if (write_in_full(buffer_file->fd, signature, signature_size) < 0 ||
+	    close_tempfile_gently(buffer_file) < 0) {
+		error_errno(_("failed writing detached signature to '%s'"),
+			    buffer_file->filename.buf);
+		delete_tempfile(&buffer_file);
+		return -1;
+	}
+
+	/* Find the principal from the signers */
+	strvec_pushl(&ssh_keygen.args, fmt->program,
+		     "-Y", "find-principals",
+		     "-f", ssh_allowed_signers,
+		     "-s", buffer_file->filename.buf,
+		     NULL);
+	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0,
+			   &ssh_keygen_err, 0);
+	if (ret && strstr(ssh_keygen_err.buf, "usage:")) {
+		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
+		goto out;
+	}
+	if (ret || !ssh_keygen_out.len) {
+		/* We did not find a matching principal in the allowedSigners - Check
+		 * without validation */
+		child_process_init(&ssh_keygen);
+		strvec_pushl(&ssh_keygen.args, fmt->program,
+			     "-Y", "check-novalidate",
+			     "-n", "git",
+			     "-s", buffer_file->filename.buf,
+			     NULL);
+		ret = pipe_command(&ssh_keygen, payload, payload_size,
+				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
+	} else {
+		/* Check every principal we found (one per line) */
+		for (line = ssh_keygen_out.buf; *line;
+		     line = strchrnul(line + 1, '\n')) {
+			while (*line == '\n')
+				line++;
+			if (!*line)
+				break;
+
+			trust_size = strcspn(line, "\n");
+			principal = xmemdupz(line, trust_size);
+
+			child_process_init(&ssh_keygen);
+			strbuf_release(&ssh_keygen_out);
+			strbuf_release(&ssh_keygen_err);
+			strvec_push(&ssh_keygen.args, fmt->program);
+			/* We found principals - Try with each until we find a
+			 * match */
+			strvec_pushl(&ssh_keygen.args, "-Y", "verify",
+				     "-n", "git",
+				     "-f", ssh_allowed_signers,
+				     "-I", principal,
+				     "-s", buffer_file->filename.buf,
+				     NULL);
+
+			if (ssh_revocation_file) {
+				if (file_exists(ssh_revocation_file)) {
+					strvec_pushl(&ssh_keygen.args, "-r",
+						     ssh_revocation_file, NULL);
+				} else {
+					warning(_("ssh signing revocation file configured but not found: %s"),
+						ssh_revocation_file);
+				}
+			}
+
+			sigchain_push(SIGPIPE, SIG_IGN);
+			ret = pipe_command(&ssh_keygen, payload, payload_size,
+					   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
+			sigchain_pop(SIGPIPE);
+
+			FREE_AND_NULL(principal);
+
+			ret &= starts_with(ssh_keygen_out.buf, "Good");
+			if (ret == 0)
+				break;
+		}
+	}
+
+	sigc->payload = xmemdupz(payload, payload_size);
+	strbuf_stripspace(&ssh_keygen_out, 0);
+	strbuf_stripspace(&ssh_keygen_err, 0);
+	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
+	sigc->output = strbuf_detach(&ssh_keygen_out, NULL);
+	sigc->gpg_status = xstrdup(sigc->output);
+
+	parse_ssh_output(sigc);
+
+out:
+	if (buffer_file)
+		delete_tempfile(&buffer_file);
+	strbuf_release(&ssh_keygen_out);
+	strbuf_release(&ssh_keygen_err);
+
+	return ret;
+}
+
 int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
@@ -453,6 +618,18 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&ssh_allowed_signers, var, value);
+	}
+
+	if (!strcmp(var, "gpg.ssh.revocationFile")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&ssh_revocation_file, var, value);
+	}
+
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
 
-- 
gitgitgadget

