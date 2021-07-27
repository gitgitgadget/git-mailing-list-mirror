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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03581C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC5B619FA
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhG0NPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhG0NPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:15:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE66C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so2315056wmd.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1K7dD+rLYIpu5AIZOSp9EwbaAi6bjkt4iJ8+VaO9I00=;
        b=QIS62UIQU4iSKIuh0SGa95PlRPrKaWfTGkR6yVq5nCwiFWV9qGQLvMheF04N6lfFkU
         0xYS50WwoSrddD3uf9WQMvSwE+1j9/oRXNi6sv95CiJ9J37o8ijEaSoqUaDaF0z+AApQ
         lB9YK0O5vQrfp544pdkEXWYYC8SKqJsUrJ2NiC/NSMuVrwVkThO4dLn8IMVz6CyxH2GH
         5CVCmHhSmqN8D5xxfwwiHOWqz9axXxoV+uXD4j/9udWzMHiFsaWIhLft5q+Dw1G/bHTt
         dIM1rl55bX5i0q1MinI0mSBM5BFeu2z4NlRexBN1AGzsL6ZZh2+UHFfyAeQaQOa9BFet
         v+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1K7dD+rLYIpu5AIZOSp9EwbaAi6bjkt4iJ8+VaO9I00=;
        b=eXtwjifRSB4HipZ0h9srDiN38QZDAiKpsMMtvnfJMtL12d2yFIBWuSYEi0xhM0krZ0
         //4dDkS3lNX8SJgMjq+raC9dloUdYrhuJTmVjcqqt7c7WIefyy6eDSlTR0SeN5steu6W
         iaMKobZpI0W56LZYl5q+DEfdtjd127W3zxW+7e10NWGgFy7JiMnV51rAgI39WVrCGJIF
         yzvQWfvupKaokHybhLB5hb45Ebg+7S+RqDOVzv4nih7N/ZfxqyDf6ztkcvV/B5sXmZKz
         5v/sKJwasWSnRpfqWeQu2gG9ZvvwihNOrlveQhj2e5R18s8GYhxhbqt5T2ZUtJ5x1XCB
         ybJw==
X-Gm-Message-State: AOAM531BT2KevPdDljmuI5so76S2iJd73YlVZGtPTGov6nVOB/KMZtzS
        EgnMyCoOcFbyvj+JJL/nt3vO+SVS5SE=
X-Google-Smtp-Source: ABdhPJxJ0feo2AheyKeLomdh3rs4c7avq+lvjwCt3dAMEvKY9hAThtru7FZ9ktuPQZr7Oekn5ZhZFQ==
X-Received: by 2002:a05:600c:1d25:: with SMTP id l37mr4049070wms.126.1627391745909;
        Tue, 27 Jul 2021 06:15:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm2909894wme.2.2021.07.27.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:15:45 -0700 (PDT)
Message-Id: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 13:15:35 +0000
Subject: [PATCH v5 0/9] ssh signing: Add commit & tag signing/verification via SSH keys using
 ssh-keygen
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
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have added support for using keyfiles directly, lots of tests and
generally cleaned up the signing & verification code a lot.

I can still rename things from being gpg specific to a more general
"signing" but thats rather cosmetic. Also i'm not sure if i named the new
test files correctly.

openssh 8.7 will add valid-after, valid-before options to the allowed keys
keyring. This allows us to pass the commit timestamp to the verification
call and make key rollover possible and still be able to verify older
commits. Set valid-after=NOW when adding your key to the keyring and set
valid-before to make it fail if used after a certain date. Software like
gitolite/github or corporate automation can do this automatically when ssh
push keys are addded / removed I will add this feature in a follow up patch
afterwards.

v3 addresses some issues & refactoring and splits the large commit into
several smaller ones.

v4:

 * restructures and cleans up the whole patch set - patches build on its own
   now and commit messages try to explain whats going on
 * got rid of the if branches and used callback functions in the format
   struct
 * fixed a bug with whitespace in principal identifiers that required a
   rewrite of the parse_ssh_output function
 * rewrote documentation to be more clear - also renamed keyring back to
   allowedSignersFile

v5:

 * moved t7527 to t7528 to not collide with another patch in "seen"
 * clean up return logic for failed signing & verification
 * some minor renames / reformatting to make things clearer

Fabian Stelzer (9):
  ssh signing: preliminary refactoring and clean-up
  ssh signing: add ssh signature format and signing using ssh keys
  ssh signing: retrieve a default key from ssh-agent
  ssh signing: provide a textual representation of the signing key
  ssh signing: parse ssh-keygen output and verify signatures
  ssh signing: add test prereqs
  ssh signing: duplicate t7510 tests for commits
  ssh signing: add more tests for logs, tags & push certs
  ssh signing: add documentation

 Documentation/config/gpg.txt     |  39 ++-
 Documentation/config/user.txt    |   6 +
 builtin/receive-pack.c           |   2 +
 fmt-merge-msg.c                  |   6 +-
 gpg-interface.c                  | 490 +++++++++++++++++++++++++++----
 gpg-interface.h                  |   8 +-
 log-tree.c                       |   8 +-
 pretty.c                         |   4 +-
 send-pack.c                      |   8 +-
 t/lib-gpg.sh                     |  27 ++
 t/t4202-log.sh                   |  23 ++
 t/t5534-push-signed.sh           | 101 +++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 ++++++++++
 t/t7528-signed-commit-ssh.sh     | 398 +++++++++++++++++++++++++
 14 files changed, 1216 insertions(+), 65 deletions(-)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh
 create mode 100755 t/t7528-signed-commit-ssh.sh


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v5
Pull-Request: https://github.com/git/git/pull/1041

Range-diff vs v4:

  1:  b4b0e2bac1c =  1:  7c8502c65b8 ssh signing: preliminary refactoring and clean-up
  2:  2c75adee8e1 !  2:  f05bab16096 ssh signing: add ssh signature format and signing using ssh keys
     @@ gpg-interface.c: int sign_buffer(struct strbuf *buffer, struct strbuf *signature
       	return use_format->sign_buffer(buffer, signature, signing_key);
       }
       
     -+static void strbuf_trim_trailing_cr(struct strbuf *buffer, int offset)
     ++/*
     ++ * Strip CR from the line endings, in case we are on Windows.
     ++ * NEEDSWORK: make it trim only CRs before LFs and rename
     ++ */
     ++static void remove_cr_after(struct strbuf *buffer, size_t offset)
      +{
      +	size_t i, j;
      +
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      -			j++;
      -		}
      -	strbuf_setlen(signature, j);
     -+	strbuf_trim_trailing_cr(signature, bottom);
     ++	remove_cr_after(signature, bottom);
       
       	return 0;
       }
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      +{
      +	struct child_process signer = CHILD_PROCESS_INIT;
      +	int ret = -1;
     -+	size_t bottom;
     ++	size_t bottom, keylen;
      +	struct strbuf signer_stderr = STRBUF_INIT;
     -+	struct tempfile *temp = NULL, *buffer_file = NULL;
     ++	struct tempfile *key_file = NULL, *buffer_file = NULL;
      +	char *ssh_signing_key_file = NULL;
      +	struct strbuf ssh_signature_filename = STRBUF_INIT;
      +
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      +		return error(
      +			_("user.signingkey needs to be set for ssh signing"));
      +
     -+	if (istarts_with(signing_key, "ssh-")) {
     ++	if (starts_with(signing_key, "ssh-")) {
      +		/* A literal ssh key */
     -+		temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
     -+		if (!temp)
     ++		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
     ++		if (!key_file)
      +			return error_errno(
      +				_("could not create temporary file"));
     -+		if (write_in_full(temp->fd, signing_key, strlen(signing_key)) <
     -+			    0 ||
     -+		    close_tempfile_gently(temp) < 0) {
     ++		keylen = strlen(signing_key);
     ++		if (write_in_full(key_file->fd, signing_key, keylen) < 0 ||
     ++		    close_tempfile_gently(key_file) < 0) {
      +			error_errno(_("failed writing ssh signing key to '%s'"),
     -+				    temp->filename.buf);
     ++				    key_file->filename.buf);
      +			goto out;
      +		}
     -+		ssh_signing_key_file = temp->filename.buf;
     ++		ssh_signing_key_file = key_file->filename.buf;
      +	} else {
      +		/* We assume a file */
      +		ssh_signing_key_file = expand_user_path(signing_key, 1);
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      +		goto out;
      +	}
      +
     -+	strvec_pushl(&signer.args, use_format->program, "-Y", "sign", "-n",
     -+		     "git", "-f", ssh_signing_key_file,
     -+		     buffer_file->filename.buf, NULL);
     ++	strvec_pushl(&signer.args, use_format->program,
     ++		     "-Y", "sign",
     ++		     "-n", "git",
     ++		     "-f", ssh_signing_key_file,
     ++		     buffer_file->filename.buf,
     ++		     NULL);
      +
      +	sigchain_push(SIGPIPE, SIG_IGN);
      +	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
      +	sigchain_pop(SIGPIPE);
      +
     -+	if (ret && strstr(signer_stderr.buf, "usage:")) {
     -+		error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
     -+		goto out;
     -+	}
     -+
      +	if (ret) {
     ++		if (strstr(signer_stderr.buf, "usage:"))
     ++			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
     ++
      +		error("%s", signer_stderr.buf);
      +		goto out;
      +	}
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      +
      +	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
      +	strbuf_addstr(&ssh_signature_filename, ".sig");
     -+	if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
     ++	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
      +		error_errno(
      +			_("failed reading ssh signing data buffer from '%s'"),
      +			ssh_signature_filename.buf);
      +	}
      +	unlink_or_warn(ssh_signature_filename.buf);
      +
     -+	if (ret) {
     -+		error(_("ssh failed to sign the data"));
     -+		goto out;
     -+	}
     -+
      +	/* Strip CR from the line endings, in case we are on Windows. */
     -+	strbuf_trim_trailing_cr(signature, bottom);
     ++	remove_cr_after(signature, bottom);
      +
      +out:
     -+	if (temp)
     -+		delete_tempfile(&temp);
     ++	if (key_file)
     ++		delete_tempfile(&key_file);
      +	if (buffer_file)
      +		delete_tempfile(&buffer_file);
      +	strbuf_release(&signer_stderr);
  3:  1ec5c06cbe9 =  3:  071e6173d8e ssh signing: retrieve a default key from ssh-agent
  4:  ec6931082ee =  4:  7d1d131ff5b ssh signing: provide a textual representation of the signing key
  5:  4436cb3a122 !  5:  725764018ce ssh signing: parse ssh-keygen output and verify signatures
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +	}
      +}
      +
     -+static const char *get_ssh_allowed_signers(void)
     -+{
     -+	if (ssh_allowed_signers)
     -+		return ssh_allowed_signers;
     -+
     -+	die("gpg.ssh.allowedSignersFile needs to be configured and exist for validation");
     -+}
     -+
      +static int verify_ssh_signed_buffer(struct signature_check *sigc,
      +				    struct gpg_format *fmt, const char *payload,
      +				    size_t payload_size, const char *signature,
      +				    size_t signature_size)
      +{
      +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
     -+	struct tempfile *temp;
     -+	int ret;
     ++	struct tempfile *buffer_file;
     ++	int ret = -1;
      +	const char *line;
      +	size_t trust_size;
      +	char *principal;
      +	struct strbuf ssh_keygen_out = STRBUF_INIT;
      +	struct strbuf ssh_keygen_err = STRBUF_INIT;
      +
     -+	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
     -+	if (!temp)
     ++	if (!ssh_allowed_signers) {
     ++		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification"));
     ++		return -1;
     ++	}
     ++
     ++	buffer_file = mks_tempfile_t(".git_vtag_tmpXXXXXX");
     ++	if (!buffer_file)
      +		return error_errno(_("could not create temporary file"));
     -+	if (write_in_full(temp->fd, signature, signature_size) < 0 ||
     -+	    close_tempfile_gently(temp) < 0) {
     ++	if (write_in_full(buffer_file->fd, signature, signature_size) < 0 ||
     ++	    close_tempfile_gently(buffer_file) < 0) {
      +		error_errno(_("failed writing detached signature to '%s'"),
     -+			    temp->filename.buf);
     -+		delete_tempfile(&temp);
     ++			    buffer_file->filename.buf);
     ++		delete_tempfile(&buffer_file);
      +		return -1;
      +	}
      +
      +	/* Find the principal from the signers */
     -+	strvec_pushl(&ssh_keygen.args, fmt->program, "-Y", "find-principals",
     -+		     "-f", get_ssh_allowed_signers(), "-s", temp->filename.buf,
     ++	strvec_pushl(&ssh_keygen.args, fmt->program,
     ++		     "-Y", "find-principals",
     ++		     "-f", ssh_allowed_signers,
     ++		     "-s", buffer_file->filename.buf,
      +		     NULL);
      +	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0,
      +			   &ssh_keygen_err, 0);
      +	if (ret && strstr(ssh_keygen_err.buf, "usage:")) {
      +		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
     -+		return ret;
     ++		goto out;
      +	}
      +	if (ret || !ssh_keygen_out.len) {
      +		/* We did not find a matching principal in the allowedSigners - Check
      +		 * without validation */
      +		child_process_init(&ssh_keygen);
     -+		strvec_pushl(&ssh_keygen.args, fmt->program, "-Y",
     -+			     "check-novalidate", "-n", "git", "-s",
     -+			     temp->filename.buf, NULL);
     ++		strvec_pushl(&ssh_keygen.args, fmt->program,
     ++			     "-Y", "check-novalidate",
     ++			     "-n", "git",
     ++			     "-s", buffer_file->filename.buf,
     ++			     NULL);
      +		ret = pipe_command(&ssh_keygen, payload, payload_size,
      +				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
      +	} else {
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +			strvec_push(&ssh_keygen.args, fmt->program);
      +			/* We found principals - Try with each until we find a
      +			 * match */
     -+			strvec_pushl(&ssh_keygen.args, "-Y", "verify", "-n",
     -+				     "git", "-f", get_ssh_allowed_signers(),
     -+				     "-I", principal, "-s", temp->filename.buf,
     ++			strvec_pushl(&ssh_keygen.args, "-Y", "verify",
     ++				     "-n", "git",
     ++				     "-f", ssh_allowed_signers,
     ++				     "-I", principal,
     ++				     "-s", buffer_file->filename.buf,
      +				     NULL);
      +
      +			if (ssh_revocation_file) {
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +
      +	parse_ssh_output(sigc);
      +
     -+	delete_tempfile(&temp);
     ++out:
     ++	if (buffer_file)
     ++		delete_tempfile(&buffer_file);
      +	strbuf_release(&ssh_keygen_out);
      +	strbuf_release(&ssh_keygen_err);
      +
  6:  06a76e64b35 =  6:  eb677b1b6a8 ssh signing: add test prereqs
  7:  4dc5572083b !  7:  c877951df23 ssh signing: duplicate t7510 tests for commits
     @@ Commit message
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     - ## t/t7527-signed-commit-ssh.sh (new) ##
     + ## t/t7528-signed-commit-ssh.sh (new) ##
      @@
      +#!/bin/sh
      +
  8:  275dd8a1013 =  8:  60265e8c399 ssh signing: add more tests for logs, tags & push certs
  9:  13f6c229bd1 =  9:  f758ce0ade4 ssh signing: add documentation

-- 
gitgitgadget
