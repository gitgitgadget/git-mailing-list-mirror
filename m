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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC90C11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C553F613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhGNMNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhGNMNL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7379AC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g12so1437588wme.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddwA/8mx8OmqYsuNyiAaITyfRxE+uAf3Yy62UmrJeKo=;
        b=ERez8PI+aBVNAD4ELoOz4O4p/BsaMTUstjoXd0JkFVEuHgQ89/MKZPQOmdNEQlVSCD
         4xFuzGFfX19Efqj1J7ad8H2l23hnfByz670IOJogCgdP1cz/veuingqoBVcswD6jHUvz
         OduJzITypR/icuvRyl+Df1NefvlJqnikAAUsap51TYyWK8T4mGt6Us3HcmUO5BZNmKqZ
         OZVloBWZSdzFEahvdjRFJ27hrJA6zUpo7tUZ+nt83xSjCU2RNdhu4c4J5hiD059J3nMt
         BXIBwD/uChZuzqFzke/2wNG329m/6ubuZF7Kz9ZBsMxOCCrrDHDPhfCNtJbC10JsWmll
         SZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddwA/8mx8OmqYsuNyiAaITyfRxE+uAf3Yy62UmrJeKo=;
        b=cE0gVmp0F2qXk++YJJSnmEGjMjS855//5xJSlTpFK4xpLz7Vek5GrZFpIwrwi3rw+C
         QxcY6f9Ylid/RztfifJpezunKnTqrj+aGRmM5trvsFkrNYE9H0b2sm3wpoL9Gbo5B0FA
         nhPanu6IkolbvXEMsbkdtmTYRXBKyFUoJ5qirl98Z80fYgmburyKIFDAc46LBeKRV4Cn
         g2/BqRCYY9JwfpSSvK+7UAIFVdgyJtj4PoI1wTCi9TUifkz8hqWqOeoUD1YxDsPWFuYd
         vU68b3G377OJVqarn+UFDh+r6z4qpfEmAXU/fO0O4UG9C/5ShBqrH+KXN5dOwbseMiGZ
         V5Ug==
X-Gm-Message-State: AOAM532aO3rMXfG31V3wvI0plmf6OzD4sVLLWM4zthuYE+qHIn07oLZG
        IkaCq/CFvYmimzTyFh5P5R+0XD2lmw4=
X-Google-Smtp-Source: ABdhPJwQrtFu3QW4tlIo3hvBuUEnRFJJe4IRMD6DWPMlYLqW98RkCelv9IjD/1fmLd6qbMM96xyS8Q==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr10807973wmj.120.1626264617113;
        Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm2520340wri.39.2021.07.14.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
Message-Id: <df55b9e1d5989766b08596f5b9057ba0be38c10e.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:08 +0000
Subject: [PATCH v3 4/9] ssh signing: sign using either gpg or ssh keys
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

implements the actual ssh-keygen -Y sign operation

Set gpg.format = ssh and user.signingkey to either a ssh public key
string (like from an authorized_keys file), or a ssh key file.
If the key file or the config value itself contains only a public key
then the private key needs to be available via ssh-agent.
If no signingkey is set then git will call 'ssh-add -L' to check for
available agent keys and use the first one for signing.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 86 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c956ed87475..fa32a57d372 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -505,30 +505,96 @@ const char *get_ssh_allowed_signers(void)
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
-	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct child_process signer = CHILD_PROCESS_INIT;
 	int ret;
 	size_t i, j, bottom;
-	struct strbuf gpg_status = STRBUF_INIT;
+	struct strbuf signer_stderr = STRBUF_INIT;
+	struct tempfile *temp = NULL, *buffer_file = NULL;
+	char *ssh_signing_key_file = NULL;
+	struct strbuf ssh_signature_filename = STRBUF_INIT;
 
-	strvec_pushl(&gpg.args,
-		     use_format->program,
+	if (!strcmp(use_format->name, "ssh")) {
+		if (!signing_key || signing_key[0] == '\0')
+			return error(_("user.signingkey needs to be set for ssh signing"));
+
+
+		if (istarts_with(signing_key, "ssh-")) {
+			/* A literal ssh key */
+			temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
+			if (!temp)
+				return error_errno(_("could not create temporary file"));
+			if (write_in_full(temp->fd, signing_key, strlen(signing_key)) < 0 ||
+				close_tempfile_gently(temp) < 0) {
+				error_errno(_("failed writing ssh signing key to '%s'"),
+					temp->filename.buf);
+				delete_tempfile(&temp);
+				return -1;
+			}
+			ssh_signing_key_file= temp->filename.buf;
+		} else {
+			/* We assume a file */
+			ssh_signing_key_file = expand_user_path(signing_key, 1);
+		}
+
+		buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
+		if (!buffer_file)
+			return error_errno(_("could not create temporary file"));
+		if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
+			close_tempfile_gently(buffer_file) < 0) {
+			error_errno(_("failed writing ssh signing key buffer to '%s'"),
+				buffer_file->filename.buf);
+			delete_tempfile(&buffer_file);
+			return -1;
+		}
+
+		strvec_pushl(&signer.args, use_format->program ,
+					"-Y", "sign",
+					"-n", "git",
+					"-f", ssh_signing_key_file,
+					buffer_file->filename.buf,
+					NULL);
+
+		sigchain_push(SIGPIPE, SIG_IGN);
+		ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
+		sigchain_pop(SIGPIPE);
+
+		strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
+		strbuf_addstr(&ssh_signature_filename, ".sig");
+		if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
+			error_errno(_("failed reading ssh signing data buffer from '%s'"),
+				ssh_signature_filename.buf);
+		}
+		unlink_or_warn(ssh_signature_filename.buf);
+		strbuf_release(&ssh_signature_filename);
+		delete_tempfile(&buffer_file);
+	} else {
+		strvec_pushl(&signer.args, use_format->program ,
 		     "--status-fd=2",
 		     "-bsau", signing_key,
 		     NULL);
 
-	bottom = signature->len;
-
 	/*
 	 * When the username signingkey is bad, program could be terminated
 	 * because gpg exits without reading and then write gets SIGPIPE.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, buffer->buf, buffer->len,
-			   signature, 1024, &gpg_status, 0);
+		ret = pipe_command(&signer, buffer->buf, buffer->len, signature, 1024, &signer_stderr, 0);
 	sigchain_pop(SIGPIPE);
+	}
+
+	bottom = signature->len;
+
+	if (temp)
+		delete_tempfile(&temp);
 
-	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
-	strbuf_release(&gpg_status);
+	if (!strcmp(use_format->name, "ssh")) {
+		if (strstr(signer_stderr.buf, "usage:")) {
+			error(_("openssh version > 8.2p1 is needed for ssh signing (ssh-keygen needs -Y sign option)"));
+		}
+	} else {
+		ret |= !strstr(signer_stderr.buf, "\n[GNUPG:] SIG_CREATED ");
+	}
+	strbuf_release(&signer_stderr);
 	if (ret)
 		return error(_("gpg failed to sign the data"));
 
-- 
gitgitgadget

