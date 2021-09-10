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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7BCC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2989B61206
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhIJUJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhIJUJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:09:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353AC06175F
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q11so4238995wrr.9
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6nhrYBjdBnmuUAKGwl9qAyo4L3t9eEkCOV8jHxcOSSU=;
        b=gSo+ddSelsnIHcy5+F3V9psUTnVRmVuLtjcqNoqbaUH8RJpXWzf1MGiUuodhMj54XJ
         KS5BV+JJSIGr0SKgSSAqcVV7v+z8c0rJsPyj6IfC8LNX2IczZIgSXpJLb38Q9V7cJZp0
         6JPfcL47giMWjM/kiboEGK5UDnsbY55KlXvKKnbnXUiTL8AmcJSTUwxFEkhjrxpSKR+X
         vv2bAsGKVOcSv1sbI2MrCHjMJtPEKjm+E/o0HCljTa+ItZqWGhCOUBPJ2+HJ7O8VQhid
         k0TlT2cX753dNxSgLWid+7ahlLXQQRvG+A5Qwu8OoarVqKup9SZLvFL4n5wwJ6c1I+B9
         TdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6nhrYBjdBnmuUAKGwl9qAyo4L3t9eEkCOV8jHxcOSSU=;
        b=e+7rf3q2/6SWSxfg/RwldEOyjiYf/GFTWwHaOYHkTQhIYolCkYROIxPhkt+nO6vkQm
         3VnVLoVG8S/TbUcg2AHnNZUVKVYNpkrkhb3upCHStR3/B9vNIBmiaP4ctSnwnMMZEkfY
         P+cm8qB05lXLLUGiwI/C5OzU4sAkJcVry8lMwkbHvB0DSoRhvyB+8QlPGkuXy1r28pgs
         WmJY58+Kcc9zm0nV6927FrLI45whpRvETEELM7923QO88fGHBSeEC4nAPtOr7UFWCvZp
         OnVZXWbckWLmqoU5kFQTZ/Q0Wp6iwFU94FGKZykNbN78yC39JlzDkZ0aOVNPnzk+ON4o
         zo6w==
X-Gm-Message-State: AOAM533Uqqc3cq/BasNzBY57SRVDg9R3egbeiwq0VGgaDfmxuMlI29Ix
        J0aV+9+da6I8F6eU86xBcs93FoQwBKo=
X-Google-Smtp-Source: ABdhPJwz6TeNFGrErJWpDB5yZv0Dy908qum6WKx7YmiNeEgP6H5s2K43vF5UIyPkKNXFLBUP5ExWlA==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr11586786wrw.433.1631304467129;
        Fri, 10 Sep 2021 13:07:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm6719016wrm.54.2021.09.10.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:46 -0700 (PDT)
Message-Id: <cfd66180249e6d2c817dd187efd71f3f48b6dbd1.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:39 +0000
Subject: [PATCH v8 6/9] ssh signing: verify signatures using ssh-keygen
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

To verify a ssh signature we first call ssh-keygen -Y find-principal to
look up the signing principal by their public key from the
allowedSignersFile. If the key is found then we do a verify. Otherwise
we only validate the signature but can not verify the signers identity.

Verification uses the gpg.ssh.allowedSignersFile (see ssh-keygen(1) "ALLOWED
SIGNERS") which contains valid public keys and a principal (usually
user@domain). Depending on the environment this file can be managed by
the individual developer or for example generated by the central
repository server from known ssh keys with push access. This file is usually
stored outside the repository, but if the repository only allows signed
commits/pushes, the user might choose to store it in the repository.

To revoke a key put the public key without the principal prefix into
gpg.ssh.revocationKeyring or generate a KRL (see ssh-keygen(1)
"KEY REVOCATION LISTS"). The same considerations about who to trust for
verification as with the allowedSignersFile apply.

Using SSH CA Keys with these files is also possible. Add
"cert-authority" as key option between the principal and the key to mark
it as a CA and all keys signed by it as valid for this CA.
See "CERTIFICATES" in ssh-keygen(1).

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt |  35 ++++++
 builtin/receive-pack.c       |   4 +
 gpg-interface.c              | 215 ++++++++++++++++++++++++++++++++++-
 3 files changed, 252 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 9b95dd280c3..51a756b2f15 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -39,3 +39,38 @@ gpg.ssh.defaultKeyCommand:
 	signature is requested. On successful exit a valid ssh public key is
 	expected in the	first line of its output. To automatically use the first
 	available key from your ssh-agent set this to "ssh-add -L".
+
+gpg.ssh.allowedSignersFile::
+	A file containing ssh public keys which you are willing to trust.
+	The file consists of one or more lines of principals followed by an ssh
+	public key.
+	e.g.: user1@example.com,user2@example.com ssh-rsa AAAAX1...
+	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
+	The principal is only used to identify the key and is available when
+	verifying a signature.
++
+SSH has no concept of trust levels like gpg does. To be able to differentiate
+between valid signatures and trusted signatures the trust level of a signature
+verification is set to `fully` when the public key is present in the allowedSignersFile.
+Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
+Otherwise valid but untrusted signatures will still verify but show no principal
+name of the signer.
++
+This file can be set to a location outside of the repository and every developer
+maintains their own trust store. A central repository server could generate this
+file automatically from ssh keys with push access to verify the code against.
+In a corporate setting this file is probably generated at a global location
+from automation that already handles developer ssh keys.
++
+A repository that only allows signed commits can store the file
+in the repository itself using a path relative to the top-level of the working tree.
+This way only committers with an already valid key can add or change keys in the keyring.
++
+Using a SSH CA key with the cert-authority option
+(see ssh-keygen(1) "CERTIFICATES") is also valid.
+
+gpg.ssh.revocationFile::
+	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
+	See ssh-keygen(1) for details.
+	If a public key is found in this file then it will always be treated
+	as having trust level "never" and signatures will show as invalid.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d1f97e1ca7..05dc8e160f8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -131,6 +131,10 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 {
 	int status = parse_hide_refs_config(var, value, "receive");
 
+	if (status)
+		return status;
+
+	status = git_gpg_config(var, value, NULL);
 	if (status)
 		return status;
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 0f1c6a02e53..433482307c0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -3,13 +3,14 @@
 #include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "dir.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
 
 static char *configured_signing_key;
-static const char *ssh_default_key_command;
+static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
@@ -55,6 +56,10 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
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
@@ -90,7 +95,7 @@ static struct gpg_format gpg_format[] = {
 		.program = "ssh-keygen",
 		.verify_args = ssh_verify_args,
 		.sigs = ssh_sigs,
-		.verify_signed_buffer = NULL, /* TODO */
+		.verify_signed_buffer = verify_ssh_signed_buffer,
 		.sign_buffer = sign_buffer_ssh,
 		.get_default_key = get_default_ssh_signing_key,
 		.get_key_id = get_ssh_key_id,
@@ -357,6 +362,200 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
+static void parse_ssh_output(struct signature_check *sigc)
+{
+	const char *line, *principal, *search;
+	char *key = NULL;
+
+	/*
+	 * ssh-keygen output should be:
+	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
+	 *
+	 * or for valid but unknown keys:
+	 * Good "git" signature with RSA key SHA256:FINGERPRINT
+	 *
+	 * Note that "PRINCIPAL" can contain whitespace, "RSA" and
+	 * "SHA256" part could be a different token that names of
+	 * the algorithms used, and "FINGERPRINT" is a hexadecimal
+	 * string.  By finding the last occurence of " with ", we can
+	 * reliably parse out the PRINCIPAL.
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
+	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) {
+		/* Valid signature, but key unknown */
+		sigc->result = 'G';
+		sigc->trust_level = TRUST_UNDEFINED;
+	} else {
+		return;
+	}
+
+	key = strstr(line, "key");
+	if (key) {
+		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
+		sigc->key = xstrdup(sigc->fingerprint);
+	} else {
+		/*
+		 * Output did not match what we expected
+		 * Treat the signature as bad
+		 */
+		sigc->result = 'B';
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
+	struct strbuf ssh_principals_out = STRBUF_INIT;
+	struct strbuf ssh_principals_err = STRBUF_INIT;
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
+	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
+			   &ssh_principals_err, 0);
+	if (ret && strstr(ssh_principals_err.buf, "usage:")) {
+		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
+		goto out;
+	}
+	if (ret || !ssh_principals_out.len) {
+		/*
+		 * We did not find a matching principal in the allowedSigners
+		 * Check without validation
+		 */
+		child_process_init(&ssh_keygen);
+		strvec_pushl(&ssh_keygen.args, fmt->program,
+			     "-Y", "check-novalidate",
+			     "-n", "git",
+			     "-s", buffer_file->filename.buf,
+			     NULL);
+		pipe_command(&ssh_keygen, payload, payload_size,
+				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
+
+		/*
+		 * Fail on unknown keys
+		 * we still call check-novalidate to display the signature info
+		 */
+		ret = -1;
+	} else {
+		/* Check every principal we found (one per line) */
+		for (line = ssh_principals_out.buf; *line;
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
+			/*
+			 * We found principals
+			 * Try with each until we find a match
+			 */
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
+			if (!ret)
+				ret = !starts_with(ssh_keygen_out.buf, "Good");
+
+			if (!ret)
+				break;
+		}
+	}
+
+	sigc->payload = xmemdupz(payload, payload_size);
+	strbuf_stripspace(&ssh_keygen_out, 0);
+	strbuf_stripspace(&ssh_keygen_err, 0);
+	/* Add stderr outputs to show the user actual ssh-keygen errors */
+	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
+	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
+	sigc->output = strbuf_detach(&ssh_keygen_out, NULL);
+	sigc->gpg_status = xstrdup(sigc->output);
+
+	parse_ssh_output(sigc);
+
+out:
+	if (buffer_file)
+		delete_tempfile(&buffer_file);
+	strbuf_release(&ssh_principals_out);
+	strbuf_release(&ssh_principals_err);
+	strbuf_release(&ssh_keygen_out);
+	strbuf_release(&ssh_keygen_err);
+
+	return ret;
+}
+
 int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
@@ -473,6 +672,18 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return git_config_string(&ssh_default_key_command, var, value);
 	}
 
+	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_pathname(&ssh_allowed_signers, var, value);
+	}
+
+	if (!strcmp(var, "gpg.ssh.revocationfile")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_pathname(&ssh_revocation_file, var, value);
+	}
+
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
 
-- 
gitgitgadget

