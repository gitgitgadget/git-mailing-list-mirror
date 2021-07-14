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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EFC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2DE613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhGNMNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbhGNMNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBFC061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3739636wmh.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sAkcBJrO6eyyKbR8+MobPPd7V1FDwhpazxTwgoxY5m4=;
        b=PWaZ9dVR5x+RWO8u3BvByhb0KRdLMfnKOvFeUo2KE6o5oeStB+Nkz7MpTPjECtxNPQ
         IDQojwlsBxRk5xlsXxyD9swkKhtmFG8M+Uao/c/bJMu6ZgJsqXM8fpFP5f1Fn+4fCKlS
         xUYr0C7j4N51oyws/r8Dvr0zf0ywBO9tcOQvtzP3ZsfBcQlxkpENFOnJqZuBsTVPMTw9
         zYF+eehDMhlhYV3jzIOEiGfm4Yz+egK9EXDXdVf0YbAwtJ93M9TPQ7e4VGNyH4PHDDp8
         caDuVyiMGuX2A+9vbsYZrKD++3qu5ZQa+LWUh7SCF63w3dSWOI2IUtVt5fc/z+nsTpEY
         egAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sAkcBJrO6eyyKbR8+MobPPd7V1FDwhpazxTwgoxY5m4=;
        b=Kjn17Po3KXu0cs3EJRgvjY3Him3rXuJrIKfxBTHlsMbHbKq5Ci4eClwkYhw2+Nh10r
         PGlfiNhmYUQr6wjDAGTKEp0Nm6Q+YxJQR2UipJR/v3+4xfD9zl8o1YI6zOf+B5tsOX/g
         Ame59n/3ZiqHVe4cqNxPxGmD15vZRL3wIsD2AFz1tOecPE5LfD4gh3Mj7NTquwVW3Dkq
         N5CAdlDK4etZt+WN3w65CHxLY+yJv18efT6SHjdDC3R7GCpnaiCjHrQnqxX29v2y9AR3
         /jeSUtdSzDnhNQPN9ReyHYOV5u1coVBrC/iiiJ7H12MIZfp6+rQDi162n54/Vo+K5OPq
         +ngw==
X-Gm-Message-State: AOAM533aaCrN4z86d/Z3R3MAV/cD0rKF3E/Klmrwz5FrTRyImld93pPV
        TR0foR/E2sOaBnmZ+EsYCkObm0+dJGw=
X-Google-Smtp-Source: ABdhPJyPXc8f44ZDp1FPfI0V8LinG2czZzN4kxiINJ4N9xfuyXO3mrMObOSCzr+nMIFx+7i4HtF67w==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr3662764wmo.91.1626264618310;
        Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm2366270wrq.92.2021.07.14.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
Message-Id: <381a950a6e1708b3895bb9c9cb46e974e142ae64.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:10 +0000
Subject: [PATCH v3 6/9] ssh signing: parse ssh-keygen output and verify
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
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Verification uses the gpg.ssh.keyring file (see ssh-keygen(1) "ALLOWED
SIGNERS") which contains valid public keys and a principal (usually
user@domain). Depending on the environment this file can be managed by
the individual developer or for example generated by the central
repository server from known ssh keys with push access. If the
repository only allows signed commits / pushes then the file can even be
stored inside it.

To revoke a key put the public key without the principal prefix into
gpg.ssh.revocationKeyring or generate a KRL (see ssh-keygen(1)
"KEY REVOCATION LISTS"). The same considerations about who to trust for
verification as with the keyring file apply.

Using SSH CA Keys with these files is also possible. Add
"cert-authority" as key option between the principal and the key to mark
it as a CA and all keys signed by it as valid for this CA.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 builtin/receive-pack.c |   2 +
 gpg-interface.c        | 139 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

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
index 328af86c272..1be88b87d96 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "dir.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "tempfile.h"
@@ -156,6 +157,42 @@ static int parse_gpg_trust_level(const char *level,
 	return 1;
 }
 
+static void parse_ssh_output(struct signature_check *sigc)
+{
+	struct string_list parts = STRING_LIST_INIT_DUP;
+	char *line = NULL;
+
+	/*
+	 * ssh-keysign output should be:
+	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
+	 * or for valid but unknown keys:
+	 * Good "git" signature with RSA key SHA256:FINGERPRINT
+	 */
+	sigc->result = 'B';
+	sigc->trust_level = TRUST_NEVER;
+
+	line = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
+	string_list_split(&parts, line, ' ', 8);
+	if (parts.nr >= 9 && starts_with(line, "Good \"git\" signature for ")) {
+		/* Valid signature for a trusted signer */
+		sigc->result = 'G';
+		sigc->trust_level = TRUST_FULLY;
+		sigc->signer = xstrdup(parts.items[4].string);
+		sigc->fingerprint = xstrdup(parts.items[8].string);
+		sigc->key = xstrdup(sigc->fingerprint);
+	} else if (parts.nr >= 7 && starts_with(line, "Good \"git\" signature with ")) {
+		/* Valid signature, but key unknown */
+		sigc->result = 'G';
+		sigc->trust_level = TRUST_UNDEFINED;
+		sigc->fingerprint = xstrdup(parts.items[6].string);
+		sigc->key = xstrdup(sigc->fingerprint);
+	}
+	trace_printf("trace: sigc result %c/%d - %s %s %s", sigc->result, sigc->trust_level, sigc->signer, sigc->fingerprint, sigc->key);
+
+	string_list_clear(&parts, 0);
+	FREE_AND_NULL(line);
+}
+
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
@@ -269,6 +306,108 @@ error:
 	FREE_AND_NULL(sigc->key);
 }
 
+static int verify_ssh_signature(struct signature_check *sigc,
+	struct gpg_format *fmt,
+	const char *payload, size_t payload_size,
+	const char *signature, size_t signature_size)
+{
+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
+	struct tempfile *temp;
+	int ret;
+	const char *line;
+	size_t trust_size;
+	char *principal;
+	struct strbuf ssh_keygen_out = STRBUF_INIT;
+	struct strbuf ssh_keygen_err = STRBUF_INIT;
+
+	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
+	if (!temp)
+		return error_errno(_("could not create temporary file"));
+	if (write_in_full(temp->fd, signature, signature_size) < 0 ||
+	    close_tempfile_gently(temp) < 0) {
+		error_errno(_("failed writing detached signature to '%s'"),
+			    temp->filename.buf);
+		delete_tempfile(&temp);
+		return -1;
+	}
+
+	/* Find the principal from the signers */
+	strvec_pushl(&ssh_keygen.args,  fmt->program,
+					"-Y", "find-principals",
+					"-f", get_ssh_allowed_signers(),
+					"-s", temp->filename.buf,
+					NULL);
+	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
+	if (strstr(ssh_keygen_err.buf, "usage:")) {
+		error(_("openssh version > 8.2p1 is needed for ssh signature verification (ssh-keygen needs -Y find-principals/verify option)"));
+	}
+	if (ret || !ssh_keygen_out.len) {
+		/* We did not find a matching principal in the keyring - Check without validation */
+		child_process_init(&ssh_keygen);
+		strvec_pushl(&ssh_keygen.args,  fmt->program,
+						"-Y", "check-novalidate",
+						"-n", "git",
+						"-s", temp->filename.buf,
+						NULL);
+		ret = pipe_command(&ssh_keygen, payload, payload_size, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
+	} else {
+		/* Check every principal we found (one per line) */
+		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {
+			while (*line == '\n')
+				line++;
+			if (!*line)
+				break;
+
+			trust_size = strcspn(line, " \n");
+			principal = xmemdupz(line, trust_size);
+
+			child_process_init(&ssh_keygen);
+			strbuf_release(&ssh_keygen_out);
+			strbuf_release(&ssh_keygen_err);
+			strvec_push(&ssh_keygen.args,fmt->program);
+			/* We found principals - Try with each until we find a match */
+			strvec_pushl(&ssh_keygen.args,  "-Y", "verify",
+							"-n", "git",
+							"-f", get_ssh_allowed_signers(),
+							"-I", principal,
+							"-s", temp->filename.buf,
+							NULL);
+
+			if (ssh_revocation_file) {
+				if (file_exists(ssh_revocation_file)) {
+					strvec_pushl(&ssh_keygen.args, "-r", ssh_revocation_file, NULL);
+				} else {
+					warning(_("ssh signing revocation file configured but not found: %s"), ssh_revocation_file);
+				}
+			}
+
+			sigchain_push(SIGPIPE, SIG_IGN);
+			ret = pipe_command(&ssh_keygen, payload, payload_size,
+					&ssh_keygen_out, 0, &ssh_keygen_err, 0);
+			sigchain_pop(SIGPIPE);
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
+	delete_tempfile(&temp);
+	strbuf_release(&ssh_keygen_out);
+	strbuf_release(&ssh_keygen_err);
+
+	return ret;
+}
+
 static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt,
 	const char *payload, size_t payload_size,
 	const char *signature, size_t signature_size)
-- 
gitgitgadget

