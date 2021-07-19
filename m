Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB1C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93C260FF4
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhGSMwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhGSMwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 08:52:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA2C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 05:55:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f190so8793560wmf.4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ed0VClq/ljfaQdxfkvIBwsJHC5wO9q0ccq4VKc7C2wk=;
        b=liw3KC2iO2DgTJXHkN9PFEf1VqWp7UXvCbQDIjIsMgAJ+P1f6xWgtLZtWLOXq6PccA
         r+BESbrfIneegGOuWS2re7jZ0bTD3M8jknyqoSJ8BOAvBK3xg4GQUt8K/PlK1lOZ8Kp5
         FAS5iIyYjB99AkINcLIRaKnrd8orB8R5EyzUdIeltzFjhfiR/YyQZ1QQum+Bpyne8D5v
         duK65sI4BTuuezqvxgmL1WvWUZy4wErGu1p2Rb7nNM2ZPxZBtJ7TpahglnQ4cuLwUI0n
         UEHxneLQPOlsfeiN/JVhd73/r01sd/yAZ1TZQMMkMLVRK+Wdj+9ZU0tbiF5VE4E6Ba4X
         gBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ed0VClq/ljfaQdxfkvIBwsJHC5wO9q0ccq4VKc7C2wk=;
        b=pjD22/ikzZbTAlvZxWsY93E+SwZ86i7s6l/+nz+Au32iyowr2uL46jOn/QczmJUS7o
         w94E7YRIRlftNVNbLLgv1Q0yYeCEF5eW3ELj4+th7oJvfYHsQ6ENAk2J2zi8QA0zEfg4
         4vArrlaTqpfi4N9fv9wdohmdGTuoMxHYjOw6UIk+WF3bO1tyrSQDalq/8fdRtTp9mSWT
         gKxfnY7ixDa1pE+2d8htOvK9qYTUaDrlx8BTGeKNC8YhQLzIGbbPelnWS+u8CNxeBBVS
         YXBOJRp/yOdIh4dgvtYdJxwKycEL0TSEfqjlmAKmjIkmTRYWYOx8XOgOWy4y2zv4Z3NN
         eG7w==
X-Gm-Message-State: AOAM532xKvpzzJ4kkbL06/pVTPTFC3hXS+cmvGy9K7jnl67W77ssWCmn
        eCJh1oShcnJK6ZhV/ZBO59G+RUW9VcQ=
X-Google-Smtp-Source: ABdhPJzUcGU/NNF02R3eNEX5nZDQeOe/ibxVSYIw16iBWkCVq9QOlbQVlZOyrrirWMZ2Y02eRfY27g==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr29642646wms.165.1626701598727;
        Mon, 19 Jul 2021 06:33:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm19110957wmh.41.2021.07.19.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:33:17 -0700 (PDT)
Message-Id: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 13:33:07 +0000
Subject: [PATCH v4 0/9] ssh signing: Add commit & tag signing/verification via SSH keys using
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

There is a patch in the pipeline for openssh by Damien Miller that will add
valid-after, valid-before options to the allowed keys keyring. This allows
us to pass the commit timestamp to the verification call and make key
rollover possible and still be able to verify older commits. Set
valid-after=NOW when adding your key to the keyring and set valid-before to
make it fail if used after a certain date. Software like gitolite/github or
corporate automation can do this automatically when ssh push keys are addded
/ removed

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

another thing we could add later (via a config switch) is to use the
committer email as principal, instead of looking it up with the key that was
used to sign, to allow only specific trusted keys per committer.

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
 gpg-interface.c                  | 485 +++++++++++++++++++++++++++----
 gpg-interface.h                  |   8 +-
 log-tree.c                       |   8 +-
 pretty.c                         |   4 +-
 send-pack.c                      |   8 +-
 t/lib-gpg.sh                     |  27 ++
 t/t4202-log.sh                   |  23 ++
 t/t5534-push-signed.sh           | 101 +++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 ++++++++++
 t/t7527-signed-commit-ssh.sh     | 398 +++++++++++++++++++++++++
 14 files changed, 1211 insertions(+), 65 deletions(-)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh
 create mode 100755 t/t7527-signed-commit-ssh.sh


base-commit: 75ae10bc75336db031ee58d13c5037b929235912
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v4
Pull-Request: https://github.com/git/git/pull/1041

Range-diff vs v3:

  1:  390a8f816cd !  1:  b4b0e2bac1c Add commit, tag & push signing via SSH keys
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    Add commit, tag & push signing via SSH keys
     +    ssh signing: preliminary refactoring and clean-up
      
          Openssh v8.2p1 added some new options to ssh-keygen for signature
          creation and verification. These allow us to use ssh keys for git
          signatures easily.
      
     -    Start with adding the new signature format, new config options and
     -    rename some fields for consistency.
     -
     -    This feature makes git signing much more accessible to the average user.
     -    Usually they have a SSH Key for pushing code already. Using it
     -    for signing commits allows us to verify not only the transport but the
     -    pushed code as well.
     -
     -    In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
     -    signing/encryption and ssh keys which i think is quite common
     +    In our corporate environment we use PIV x509 Certs on Yubikeys for email
     +    signing/encryption and ssh keys which I think is quite common
          (at least for the email part). This way we can establish the correct
          trust for the SSH Keys without setting up a separate GPG Infrastructure
          (which is still quite painful for users) or implementing x509 signing
     @@ Commit message
          In such a setup the keyring & revocationKeyring can be centrally
          generated from the x509 CA information and distributed to the users.
      
     +    To be able to implement new signing formats this commit:
     +     - makes the sigc structure more generic by renaming "gpg_output" to
     +       "output"
     +     - introduces function pointers in the gpg_format structure to call
     +       format specific signing and verification functions
     +     - moves format detection from verify_signed_buffer into the check_signature
     +       api function and calls the format specific verify
     +     - renames and wraps sign_buffer to handle format specific signing logic
     +       as well
     +
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
       ## fmt-merge-msg.c ##
      @@ fmt-merge-msg.c: static void fmt_merge_msg_sigs(struct strbuf *out)
     + 			buf = payload.buf;
       			len = payload.len;
       			if (check_signature(payload.buf, payload.len, sig.buf,
     - 					 sig.len, &sigc) &&
     +-					 sig.len, &sigc) &&
      -				!sigc.gpg_output)
     -+				!sigc.output)
     ++					    sig.len, &sigc) &&
     ++			    !sigc.output)
       				strbuf_addstr(&sig, "gpg verification failed.\n");
       			else
      -				strbuf_addstr(&sig, sigc.gpg_output);
     @@ fmt-merge-msg.c: static void fmt_merge_msg_sigs(struct strbuf *out)
       
      
       ## gpg-interface.c ##
     -@@
     - #include "tempfile.h"
     - 
     - static char *configured_signing_key;
     -+const char *ssh_allowed_signers, *ssh_revocation_file;
     - static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
     +@@ gpg-interface.c: struct gpg_format {
     + 	const char *program;
     + 	const char **verify_args;
     + 	const char **sigs;
     ++	int (*verify_signed_buffer)(struct signature_check *sigc,
     ++				    struct gpg_format *fmt, const char *payload,
     ++				    size_t payload_size, const char *signature,
     ++				    size_t signature_size);
     ++	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
     ++			   const char *signing_key);
     + };
       
     - struct gpg_format {
     + static const char *openpgp_verify_args[] = {
      @@ gpg-interface.c: static const char *x509_sigs[] = {
       	NULL
       };
       
     -+static const char *ssh_verify_args[] = {
     -+	NULL
     -+};
     -+static const char *ssh_sigs[] = {
     -+	"-----BEGIN SSH SIGNATURE-----",
     -+	NULL
     -+};
     ++static int verify_gpg_signed_buffer(struct signature_check *sigc,
     ++				    struct gpg_format *fmt, const char *payload,
     ++				    size_t payload_size, const char *signature,
     ++				    size_t signature_size);
     ++static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     ++			   const char *signing_key);
      +
       static struct gpg_format gpg_format[] = {
     - 	{ .name = "openpgp", .program = "gpg",
     - 	  .verify_args = openpgp_verify_args,
     -@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     - 	  .verify_args = x509_verify_args,
     - 	  .sigs = x509_sigs
     +-	{ .name = "openpgp", .program = "gpg",
     +-	  .verify_args = openpgp_verify_args,
     +-	  .sigs = openpgp_sigs
     ++	{
     ++		.name = "openpgp",
     ++		.program = "gpg",
     ++		.verify_args = openpgp_verify_args,
     ++		.sigs = openpgp_sigs,
     ++		.verify_signed_buffer = verify_gpg_signed_buffer,
     ++		.sign_buffer = sign_buffer_gpg,
     + 	},
     +-	{ .name = "x509", .program = "gpgsm",
     +-	  .verify_args = x509_verify_args,
     +-	  .sigs = x509_sigs
     ++	{
     ++		.name = "x509",
     ++		.program = "gpgsm",
     ++		.verify_args = x509_verify_args,
     ++		.sigs = x509_sigs,
     ++		.verify_signed_buffer = verify_gpg_signed_buffer,
     ++		.sign_buffer = sign_buffer_gpg,
       	},
     -+	{ .name = "ssh", .program = "ssh-keygen",
     -+	  .verify_args = ssh_verify_args,
     -+	  .sigs = ssh_sigs },
       };
       
     - static struct gpg_format *use_format = &gpg_format[0];
      @@ gpg-interface.c: static struct gpg_format *get_format_by_sig(const char *sig)
       void signature_check_clear(struct signature_check *sigc)
       {
     @@ gpg-interface.c: error:
      -				const char *signature, size_t signature_size,
      -				struct strbuf *gpg_output,
      -				struct strbuf *gpg_status)
     -+static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt,
     -+	const char *payload, size_t payload_size,
     -+	const char *signature, size_t signature_size)
     ++static int verify_gpg_signed_buffer(struct signature_check *sigc,
     ++				    struct gpg_format *fmt, const char *payload,
     ++				    size_t payload_size, const char *signature,
     ++				    size_t signature_size)
       {
       	struct child_process gpg = CHILD_PROCESS_INIT;
      -	struct gpg_format *fmt;
       	struct tempfile *temp;
       	int ret;
      -	struct strbuf buf = STRBUF_INIT;
     -+	struct strbuf gpg_out = STRBUF_INIT;
     -+	struct strbuf gpg_err = STRBUF_INIT;
     ++	struct strbuf gpg_stdout = STRBUF_INIT;
     ++	struct strbuf gpg_stderr = STRBUF_INIT;
       
       	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
       	if (!temp)
     @@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t pay
       	strvec_push(&gpg.args, fmt->program);
       	strvec_pushv(&gpg.args, fmt->verify_args);
       	strvec_pushl(&gpg.args,
     --		     "--status-fd=1",
     --		     "--verify", temp->filename.buf, "-",
     --		     NULL);
     --
     +@@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t payload_size,
     + 		     "--verify", temp->filename.buf, "-",
     + 		     NULL);
     + 
      -	if (!gpg_status)
      -		gpg_status = &buf;
     -+			"--status-fd=1",
     -+			"--verify", temp->filename.buf, "-",
     -+			NULL);
     - 
     +-
       	sigchain_push(SIGPIPE, SIG_IGN);
      -	ret = pipe_command(&gpg, payload, payload_size,
      -			   gpg_status, 0, gpg_output, 0);
     -+	ret = pipe_command(&gpg, payload, payload_size, &gpg_out, 0,
     -+				&gpg_err, 0);
     ++	ret = pipe_command(&gpg, payload, payload_size, &gpg_stdout, 0,
     ++			   &gpg_stderr, 0);
       	sigchain_pop(SIGPIPE);
     -+	ret |= !strstr(gpg_out.buf, "\n[GNUPG:] GOODSIG ");
       
     --	delete_tempfile(&temp);
     -+	sigc->payload = xmemdupz(payload, payload_size);
     -+	sigc->output = strbuf_detach(&gpg_err, NULL);
     -+	sigc->gpg_status = strbuf_detach(&gpg_out, NULL);
     + 	delete_tempfile(&temp);
       
      -	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
      -	strbuf_release(&buf); /* no matter it was used or not */
     ++	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
     ++	sigc->payload = xmemdupz(payload, payload_size);
     ++	sigc->output = strbuf_detach(&gpg_stderr, NULL);
     ++	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
     ++
      +	parse_gpg_output(sigc);
      +
     -+	delete_tempfile(&temp);
     -+	strbuf_release(&gpg_out);
     -+	strbuf_release(&gpg_err);
     ++	strbuf_release(&gpg_stdout);
     ++	strbuf_release(&gpg_stderr);
       
       	return ret;
       }
     @@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t pay
      -	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
      -	parse_gpg_output(sigc);
      +	fmt = get_format_by_sig(signature);
     -+	if (!fmt) {
     -+		error(_("bad/incompatible signature '%s'"), signature);
     -+		return -1;
     -+	}
     ++	if (!fmt)
     ++		return error(_("bad/incompatible signature '%s'"), signature);
     ++
     ++	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
     ++					   slen);
      +
     -+	if (!strcmp(fmt->name, "ssh")) {
     -+		status = verify_ssh_signature(sigc, fmt, payload, plen, signature, slen);
     -+	} else {
     -+		status = verify_gpg_signature(sigc, fmt, payload, plen, signature, slen);
     -+	}
      +	if (status && !sigc->output)
      +		return !!status;
      +
     @@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t pay
       
       void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
       {
     - 	const char *output = flags & GPG_VERIFY_RAW ?
     +-	const char *output = flags & GPG_VERIFY_RAW ?
      -		sigc->gpg_status : sigc->gpg_output;
     -+		sigc->gpg_status : sigc->output;
     ++	const char *output = flags & GPG_VERIFY_RAW ? sigc->gpg_status :
     ++							    sigc->output;
       
       	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
       		fputs(sigc->payload, stdout);
     -@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     - 	int ret;
     - 
     - 	if (!strcmp(var, "user.signingkey")) {
     -+		/*
     -+		 * user.signingkey can contain one of the following
     -+		 * when format = openpgp/x509
     -+		 *   - GPG KeyID
     -+		 * when format = ssh
     -+		 *   - literal ssh public key (e.g. ssh-rsa XXXKEYXXX comment)
     -+		 *   - path to a file containing a public or a private ssh key
     -+		 */
     - 		if (!value)
     - 			return config_error_nonbool(var);
     - 		set_signing_key(value);
     - 		return 0;
     - 	}
     - 
     -+	if (!strcmp(var, "gpg.ssh.keyring")) {
     -+		if (!value)
     -+			return config_error_nonbool(var);
     -+		return git_config_string(&ssh_allowed_signers, var, value);
     -+	}
     -+
     -+	if (!strcmp(var, "gpg.ssh.revocationkeyring")) {
     -+		if (!value)
     -+			return config_error_nonbool(var);
     -+		return git_config_string(&ssh_revocation_file, var, value);
     -+	}
     -+
     - 	if (!strcmp(var, "gpg.format")) {
     - 		if (!value)
     - 			return config_error_nonbool(var);
     -@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     - 	if (!strcmp(var, "gpg.x509.program"))
     - 		fmtname = "x509";
     - 
     -+	if (!strcmp(var, "gpg.ssh.program"))
     -+		fmtname = "ssh";
     -+
     - 	if (fmtname) {
     - 		fmt = get_format_by_name(fmtname);
     - 		return git_config_string(&fmt->program, var, value);
      @@ gpg-interface.c: const char *get_signing_key(void)
     - {
     - 	if (configured_signing_key)
     - 		return configured_signing_key;
     --	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		return get_default_ssh_signing_key();
     -+	} else {
     -+		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
     -+	}
     -+}
     -+
     -+const char *get_ssh_allowed_signers(void)
     -+{
     -+	if (ssh_allowed_signers)
     -+		return ssh_allowed_signers;
     -+
     -+	die("A Path to an allowed signers ssh keyring is needed for validation");
       }
       
       int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
     ++{
     ++	return use_format->sign_buffer(buffer, signature, signing_key);
     ++}
     ++
     ++static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     ++		    const char *signing_key)
     + {
     + 	struct child_process gpg = CHILD_PROCESS_INIT;
     + 	int ret;
      
       ## gpg-interface.h ##
      @@ gpg-interface.h: enum signature_trust_level {
     @@ gpg-interface.h: enum signature_trust_level {
       struct signature_check {
       	char *payload;
      -	char *gpg_output;
     --	char *gpg_status;
      +	char *output;
     -+	char *gpg_status; /* Only used internally -> remove from this public api */
     + 	char *gpg_status;
       
       	/*
     - 	 * possible "result":
     -@@ gpg-interface.h: int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
     - int git_gpg_config(const char *, const char *, void *);
     - void set_signing_key(const char *);
     - const char *get_signing_key(void);
     -+const char *get_ssh_allowed_signers(void);
     - int check_signature(const char *payload, size_t plen,
     - 		    const char *signature, size_t slen,
     - 		    struct signature_check *sigc);
      
       ## log-tree.c ##
      @@ log-tree.c: static void show_signature(struct rev_info *opt, struct commit *commit)
  4:  df55b9e1d59 !  2:  2c75adee8e1 ssh signing: sign using either gpg or ssh keys
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    ssh signing: sign using either gpg or ssh keys
     +    ssh signing: add ssh signature format and signing using ssh keys
      
     -    implements the actual ssh-keygen -Y sign operation
     +    implements the actual sign_buffer_ssh operation and move some shared
     +    cleanup code into a strbuf function
      
          Set gpg.format = ssh and user.signingkey to either a ssh public key
          string (like from an authorized_keys file), or a ssh key file.
          If the key file or the config value itself contains only a public key
          then the private key needs to be available via ssh-agent.
     -    If no signingkey is set then git will call 'ssh-add -L' to check for
     -    available agent keys and use the first one for signing.
     +
     +    gpg.ssh.program can be set to an alternative location of ssh-keygen.
     +    A somewhat recent openssh version (8.2p1+) of ssh-keygen is needed for
     +    this feature. Since only ssh-keygen is needed it can this way be
     +    installed seperately without upgrading your system openssh packages.
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
       ## gpg-interface.c ##
     -@@ gpg-interface.c: const char *get_ssh_allowed_signers(void)
     +@@ gpg-interface.c: static const char *x509_sigs[] = {
     + 	NULL
     + };
     + 
     ++static const char *ssh_verify_args[] = { NULL };
     ++static const char *ssh_sigs[] = {
     ++	"-----BEGIN SSH SIGNATURE-----",
     ++	NULL
     ++};
     ++
     + static int verify_gpg_signed_buffer(struct signature_check *sigc,
     + 				    struct gpg_format *fmt, const char *payload,
     + 				    size_t payload_size, const char *signature,
     + 				    size_t signature_size);
     + static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     + 			   const char *signing_key);
     ++static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
     ++			   const char *signing_key);
     + 
     + static struct gpg_format gpg_format[] = {
     + 	{
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.verify_signed_buffer = verify_gpg_signed_buffer,
     + 		.sign_buffer = sign_buffer_gpg,
     + 	},
     ++	{
     ++		.name = "ssh",
     ++		.program = "ssh-keygen",
     ++		.verify_args = ssh_verify_args,
     ++		.sigs = ssh_sigs,
     ++		.verify_signed_buffer = NULL, /* TODO */
     ++		.sign_buffer = sign_buffer_ssh
     ++	},
     + };
     + 
     + static struct gpg_format *use_format = &gpg_format[0];
     +@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     + 	if (!strcmp(var, "gpg.x509.program"))
     + 		fmtname = "x509";
     + 
     ++	if (!strcmp(var, "gpg.ssh.program"))
     ++		fmtname = "ssh";
     ++
     + 	if (fmtname) {
     + 		fmt = get_format_by_name(fmtname);
     + 		return git_config_string(&fmt->program, var, value);
     +@@ gpg-interface.c: int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
     + 	return use_format->sign_buffer(buffer, signature, signing_key);
     + }
       
     - int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
     ++static void strbuf_trim_trailing_cr(struct strbuf *buffer, int offset)
     ++{
     ++	size_t i, j;
     ++
     ++	for (i = j = offset; i < buffer->len; i++) {
     ++		if (buffer->buf[i] != '\r') {
     ++			if (i != j)
     ++				buffer->buf[j] = buffer->buf[i];
     ++			j++;
     ++		}
     ++	}
     ++	strbuf_setlen(buffer, j);
     ++}
     ++
     + static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     + 		    const char *signing_key)
       {
     --	struct child_process gpg = CHILD_PROCESS_INIT;
     -+	struct child_process signer = CHILD_PROCESS_INIT;
     + 	struct child_process gpg = CHILD_PROCESS_INIT;
       	int ret;
     - 	size_t i, j, bottom;
     --	struct strbuf gpg_status = STRBUF_INIT;
     +-	size_t i, j, bottom;
     ++	size_t bottom;
     + 	struct strbuf gpg_status = STRBUF_INIT;
     + 
     + 	strvec_pushl(&gpg.args,
     +@@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     + 		return error(_("gpg failed to sign the data"));
     + 
     + 	/* Strip CR from the line endings, in case we are on Windows. */
     +-	for (i = j = bottom; i < signature->len; i++)
     +-		if (signature->buf[i] != '\r') {
     +-			if (i != j)
     +-				signature->buf[j] = signature->buf[i];
     +-			j++;
     +-		}
     +-	strbuf_setlen(signature, j);
     ++	strbuf_trim_trailing_cr(signature, bottom);
     + 
     + 	return 0;
     + }
     ++
     ++static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
     ++			   const char *signing_key)
     ++{
     ++	struct child_process signer = CHILD_PROCESS_INIT;
     ++	int ret = -1;
     ++	size_t bottom;
      +	struct strbuf signer_stderr = STRBUF_INIT;
      +	struct tempfile *temp = NULL, *buffer_file = NULL;
      +	char *ssh_signing_key_file = NULL;
      +	struct strbuf ssh_signature_filename = STRBUF_INIT;
     - 
     --	strvec_pushl(&gpg.args,
     --		     use_format->program,
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		if (!signing_key || signing_key[0] == '\0')
     -+			return error(_("user.signingkey needs to be set for ssh signing"));
     -+
     -+
     -+		if (istarts_with(signing_key, "ssh-")) {
     -+			/* A literal ssh key */
     -+			temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
     -+			if (!temp)
     -+				return error_errno(_("could not create temporary file"));
     -+			if (write_in_full(temp->fd, signing_key, strlen(signing_key)) < 0 ||
     -+				close_tempfile_gently(temp) < 0) {
     -+				error_errno(_("failed writing ssh signing key to '%s'"),
     -+					temp->filename.buf);
     -+				delete_tempfile(&temp);
     -+				return -1;
     -+			}
     -+			ssh_signing_key_file= temp->filename.buf;
     -+		} else {
     -+			/* We assume a file */
     -+			ssh_signing_key_file = expand_user_path(signing_key, 1);
     -+		}
      +
     -+		buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
     -+		if (!buffer_file)
     -+			return error_errno(_("could not create temporary file"));
     -+		if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
     -+			close_tempfile_gently(buffer_file) < 0) {
     -+			error_errno(_("failed writing ssh signing key buffer to '%s'"),
     -+				buffer_file->filename.buf);
     -+			delete_tempfile(&buffer_file);
     -+			return -1;
     -+		}
     ++	if (!signing_key || signing_key[0] == '\0')
     ++		return error(
     ++			_("user.signingkey needs to be set for ssh signing"));
      +
     -+		strvec_pushl(&signer.args, use_format->program ,
     -+					"-Y", "sign",
     -+					"-n", "git",
     -+					"-f", ssh_signing_key_file,
     -+					buffer_file->filename.buf,
     -+					NULL);
     -+
     -+		sigchain_push(SIGPIPE, SIG_IGN);
     -+		ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
     -+		sigchain_pop(SIGPIPE);
     -+
     -+		strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
     -+		strbuf_addstr(&ssh_signature_filename, ".sig");
     -+		if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
     -+			error_errno(_("failed reading ssh signing data buffer from '%s'"),
     -+				ssh_signature_filename.buf);
     ++	if (istarts_with(signing_key, "ssh-")) {
     ++		/* A literal ssh key */
     ++		temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
     ++		if (!temp)
     ++			return error_errno(
     ++				_("could not create temporary file"));
     ++		if (write_in_full(temp->fd, signing_key, strlen(signing_key)) <
     ++			    0 ||
     ++		    close_tempfile_gently(temp) < 0) {
     ++			error_errno(_("failed writing ssh signing key to '%s'"),
     ++				    temp->filename.buf);
     ++			goto out;
      +		}
     -+		unlink_or_warn(ssh_signature_filename.buf);
     -+		strbuf_release(&ssh_signature_filename);
     -+		delete_tempfile(&buffer_file);
     ++		ssh_signing_key_file = temp->filename.buf;
      +	} else {
     -+		strvec_pushl(&signer.args, use_format->program ,
     - 		     "--status-fd=2",
     - 		     "-bsau", signing_key,
     - 		     NULL);
     - 
     --	bottom = signature->len;
     --
     - 	/*
     - 	 * When the username signingkey is bad, program could be terminated
     - 	 * because gpg exits without reading and then write gets SIGPIPE.
     - 	 */
     - 	sigchain_push(SIGPIPE, SIG_IGN);
     --	ret = pipe_command(&gpg, buffer->buf, buffer->len,
     --			   signature, 1024, &gpg_status, 0);
     -+		ret = pipe_command(&signer, buffer->buf, buffer->len, signature, 1024, &signer_stderr, 0);
     - 	sigchain_pop(SIGPIPE);
     ++		/* We assume a file */
     ++		ssh_signing_key_file = expand_user_path(signing_key, 1);
     ++	}
     ++
     ++	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
     ++	if (!buffer_file) {
     ++		error_errno(_("could not create temporary file"));
     ++		goto out;
     ++	}
     ++
     ++	if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
     ++	    close_tempfile_gently(buffer_file) < 0) {
     ++		error_errno(_("failed writing ssh signing key buffer to '%s'"),
     ++			    buffer_file->filename.buf);
     ++		goto out;
     ++	}
     ++
     ++	strvec_pushl(&signer.args, use_format->program, "-Y", "sign", "-n",
     ++		     "git", "-f", ssh_signing_key_file,
     ++		     buffer_file->filename.buf, NULL);
     ++
     ++	sigchain_push(SIGPIPE, SIG_IGN);
     ++	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
     ++	sigchain_pop(SIGPIPE);
     ++
     ++	if (ret && strstr(signer_stderr.buf, "usage:")) {
     ++		error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
     ++		goto out;
     ++	}
     ++
     ++	if (ret) {
     ++		error("%s", signer_stderr.buf);
     ++		goto out;
      +	}
      +
      +	bottom = signature->len;
      +
     ++	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
     ++	strbuf_addstr(&ssh_signature_filename, ".sig");
     ++	if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
     ++		error_errno(
     ++			_("failed reading ssh signing data buffer from '%s'"),
     ++			ssh_signature_filename.buf);
     ++	}
     ++	unlink_or_warn(ssh_signature_filename.buf);
     ++
     ++	if (ret) {
     ++		error(_("ssh failed to sign the data"));
     ++		goto out;
     ++	}
     ++
     ++	/* Strip CR from the line endings, in case we are on Windows. */
     ++	strbuf_trim_trailing_cr(signature, bottom);
     ++
     ++out:
      +	if (temp)
      +		delete_tempfile(&temp);
     - 
     --	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
     --	strbuf_release(&gpg_status);
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		if (strstr(signer_stderr.buf, "usage:")) {
     -+			error(_("openssh version > 8.2p1 is needed for ssh signing (ssh-keygen needs -Y sign option)"));
     -+		}
     -+	} else {
     -+		ret |= !strstr(signer_stderr.buf, "\n[GNUPG:] SIG_CREATED ");
     -+	}
     ++	if (buffer_file)
     ++		delete_tempfile(&buffer_file);
      +	strbuf_release(&signer_stderr);
     - 	if (ret)
     - 		return error(_("gpg failed to sign the data"));
     - 
     ++	strbuf_release(&ssh_signature_filename);
     ++	return ret;
     ++}
  3:  b84b2812470 !  3:  1ec5c06cbe9 ssh signing: retrieve a default key from ssh-agent
     @@ Metadata
       ## Commit message ##
          ssh signing: retrieve a default key from ssh-agent
      
     -    calls ssh-add -L and uses the first key
     +    if user.signingkey is not set and a ssh signature is requested we call
     +    ssh-add -L and use the first key we get
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
       }
       
      +/* Returns the first public key from an ssh-agent to use for signing */
     -+static char *get_default_ssh_signing_key(void) {
     ++static char *get_default_ssh_signing_key(void)
     ++{
      +	struct child_process ssh_add = CHILD_PROCESS_INIT;
      +	int ret = -1;
      +	struct strbuf key_stdout = STRBUF_INIT;
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
      +			return strbuf_detach(keys[0], NULL);
      +	}
      +
     ++	strbuf_release(&key_stdout);
      +	return "";
      +}
     ++
       const char *get_signing_key(void)
       {
       	if (configured_signing_key)
     + 		return configured_signing_key;
     +-	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
     ++	if (!strcmp(use_format->name, "ssh")) {
     ++		return get_default_ssh_signing_key();
     ++	} else {
     ++		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
     ++	}
     + }
     + 
     + int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
  5:  0581c72634c !  4:  ec6931082ee ssh signing: provide a textual representation of the signing key
     @@ Metadata
       ## Commit message ##
          ssh signing: provide a textual representation of the signing key
      
     -    for ssh the key can be a filename/path or even a literal ssh pubkey
     -    in push certs and textual output we prefer the ssh fingerprint instead
     +    for ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
     +    in push certs and textual output we prefer the ssh fingerprint instead.
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
       	return 0;
       }
       
     -+static char *get_ssh_key_fingerprint(const char *signing_key) {
     ++static char *get_ssh_key_fingerprint(const char *signing_key)
     ++{
      +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
      +	int ret = -1;
      +	struct strbuf fingerprint_stdout = STRBUF_INIT;
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
      +	 * For textual representation we usually want a fingerprint
      +	 */
      +	if (istarts_with(signing_key, "ssh-")) {
     -+		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
     -+					"-lf", "-",
     -+					NULL);
     -+		ret = pipe_command(&ssh_keygen, signing_key, strlen(signing_key),
     -+			&fingerprint_stdout, 0,  NULL, 0);
     ++		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
     ++		ret = pipe_command(&ssh_keygen, signing_key,
     ++				   strlen(signing_key), &fingerprint_stdout, 0,
     ++				   NULL, 0);
      +	} else {
     -+		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
     -+					"-lf", configured_signing_key,
     -+					NULL);
     ++		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf",
     ++			     configured_signing_key, NULL);
      +		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0,
     -+			NULL, 0);
     ++				   NULL, 0);
      +	}
      +
      +	if (!!ret)
      +		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
     -+			signing_key);
     ++			  signing_key);
      +
      +	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
      +	if (!fingerprint[1])
      +		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
     -+			signing_key);
     ++			  signing_key);
      +
      +	return strbuf_detach(fingerprint[1], NULL);
      +}
      +
       /* Returns the first public key from an ssh-agent to use for signing */
     - static char *get_default_ssh_signing_key(void) {
     - 	struct child_process ssh_add = CHILD_PROCESS_INIT;
     -@@ gpg-interface.c: static char *get_default_ssh_signing_key(void) {
     - 
     + static char *get_default_ssh_signing_key(void)
     + {
     +@@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
       	return "";
       }
     -+
     + 
      +/* Returns a textual but unique representation ot the signing key */
     -+const char *get_signing_key_id(void) {
     ++const char *get_signing_key_id(void)
     ++{
      +	if (!strcmp(use_format->name, "ssh")) {
      +		return get_ssh_key_fingerprint(get_signing_key());
      +	} else {
     @@ gpg-interface.h: int sign_buffer(struct strbuf *buffer, struct strbuf *signature
      + * Either a GPG KeyID or a SSH Key Fingerprint
      + */
      +const char *get_signing_key_id(void);
     -+
     - const char *get_ssh_allowed_signers(void);
       int check_signature(const char *payload, size_t plen,
       		    const char *signature, size_t slen,
     + 		    struct signature_check *sigc);
      
       ## send-pack.c ##
      @@ send-pack.c: static int generate_push_cert(struct strbuf *req_buf,
  6:  381a950a6e1 !  5:  4436cb3a122 ssh signing: parse ssh-keygen output and verify signatures
     @@ Metadata
       ## Commit message ##
          ssh signing: parse ssh-keygen output and verify signatures
      
     -    Verification uses the gpg.ssh.keyring file (see ssh-keygen(1) "ALLOWED
     +    to verify a ssh signature we first call ssh-keygen -Y find-principal to
     +    look up the signing principal by their public key from the
     +    allowedSignersFile. If the key is found then we do a verify. Otherwise
     +    we only validate the signature but can not verify the signers identity.
     +
     +    Verification uses the gpg.ssh.allowedSignersFile (see ssh-keygen(1) "ALLOWED
          SIGNERS") which contains valid public keys and a principal (usually
          user@domain). Depending on the environment this file can be managed by
          the individual developer or for example generated by the central
     @@ Commit message
          To revoke a key put the public key without the principal prefix into
          gpg.ssh.revocationKeyring or generate a KRL (see ssh-keygen(1)
          "KEY REVOCATION LISTS"). The same considerations about who to trust for
     -    verification as with the keyring file apply.
     +    verification as with the allowedSignersFile apply.
      
          Using SSH CA Keys with these files is also possible. Add
          "cert-authority" as key option between the principal and the key to mark
     @@ gpg-interface.c
       #include "gpg-interface.h"
       #include "sigchain.h"
       #include "tempfile.h"
     -@@ gpg-interface.c: static int parse_gpg_trust_level(const char *level,
     - 	return 1;
     + 
     + static char *configured_signing_key;
     ++static const char *ssh_allowed_signers, *ssh_revocation_file;
     + static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
     + 
     + struct gpg_format {
     +@@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sigc,
     + 				    struct gpg_format *fmt, const char *payload,
     + 				    size_t payload_size, const char *signature,
     + 				    size_t signature_size);
     ++static int verify_ssh_signed_buffer(struct signature_check *sigc,
     ++				    struct gpg_format *fmt, const char *payload,
     ++				    size_t payload_size, const char *signature,
     ++				    size_t signature_size);
     + static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     + 			   const char *signing_key);
     + static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.program = "ssh-keygen",
     + 		.verify_args = ssh_verify_args,
     + 		.sigs = ssh_sigs,
     +-		.verify_signed_buffer = NULL, /* TODO */
     ++		.verify_signed_buffer = verify_ssh_signed_buffer,
     + 		.sign_buffer = sign_buffer_ssh
     + 	},
     + };
     +@@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sigc,
     + 	return ret;
       }
       
      +static void parse_ssh_output(struct signature_check *sigc)
      +{
     -+	struct string_list parts = STRING_LIST_INIT_DUP;
     -+	char *line = NULL;
     ++	const char *line, *principal, *search;
      +
      +	/*
      +	 * ssh-keysign output should be:
      +	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
     ++	 * Good "git" signature for PRINCIPAL WITH WHITESPACE with RSA key SHA256:FINGERPRINT
      +	 * or for valid but unknown keys:
      +	 * Good "git" signature with RSA key SHA256:FINGERPRINT
      +	 */
     @@ gpg-interface.c: static int parse_gpg_trust_level(const char *level,
      +	sigc->trust_level = TRUST_NEVER;
      +
      +	line = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
     -+	string_list_split(&parts, line, ' ', 8);
     -+	if (parts.nr >= 9 && starts_with(line, "Good \"git\" signature for ")) {
     -+		/* Valid signature for a trusted signer */
     ++
     ++	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
     ++		/* Valid signature and known principal */
      +		sigc->result = 'G';
      +		sigc->trust_level = TRUST_FULLY;
     -+		sigc->signer = xstrdup(parts.items[4].string);
     -+		sigc->fingerprint = xstrdup(parts.items[8].string);
     ++
     ++		/* Search for the last "with" to get the full principal */
     ++		principal = line;
     ++		do {
     ++			search = strstr(line, " with ");
     ++			if (search)
     ++				line = search + 1;
     ++		} while (search != NULL);
     ++		sigc->signer = xmemdupz(principal, line - principal - 1);
     ++		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
      +		sigc->key = xstrdup(sigc->fingerprint);
     -+	} else if (parts.nr >= 7 && starts_with(line, "Good \"git\" signature with ")) {
     ++	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) {
      +		/* Valid signature, but key unknown */
      +		sigc->result = 'G';
      +		sigc->trust_level = TRUST_UNDEFINED;
     -+		sigc->fingerprint = xstrdup(parts.items[6].string);
     ++		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
      +		sigc->key = xstrdup(sigc->fingerprint);
      +	}
     -+	trace_printf("trace: sigc result %c/%d - %s %s %s", sigc->result, sigc->trust_level, sigc->signer, sigc->fingerprint, sigc->key);
     ++}
     ++
     ++static const char *get_ssh_allowed_signers(void)
     ++{
     ++	if (ssh_allowed_signers)
     ++		return ssh_allowed_signers;
      +
     -+	string_list_clear(&parts, 0);
     -+	FREE_AND_NULL(line);
     ++	die("gpg.ssh.allowedSignersFile needs to be configured and exist for validation");
      +}
      +
     - static void parse_gpg_output(struct signature_check *sigc)
     - {
     - 	const char *buf = sigc->gpg_status;
     -@@ gpg-interface.c: error:
     - 	FREE_AND_NULL(sigc->key);
     - }
     - 
     -+static int verify_ssh_signature(struct signature_check *sigc,
     -+	struct gpg_format *fmt,
     -+	const char *payload, size_t payload_size,
     -+	const char *signature, size_t signature_size)
     ++static int verify_ssh_signed_buffer(struct signature_check *sigc,
     ++				    struct gpg_format *fmt, const char *payload,
     ++				    size_t payload_size, const char *signature,
     ++				    size_t signature_size)
      +{
      +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
      +	struct tempfile *temp;
     @@ gpg-interface.c: error:
      +	}
      +
      +	/* Find the principal from the signers */
     -+	strvec_pushl(&ssh_keygen.args,  fmt->program,
     -+					"-Y", "find-principals",
     -+					"-f", get_ssh_allowed_signers(),
     -+					"-s", temp->filename.buf,
     -+					NULL);
     -+	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
     -+	if (strstr(ssh_keygen_err.buf, "usage:")) {
     -+		error(_("openssh version > 8.2p1 is needed for ssh signature verification (ssh-keygen needs -Y find-principals/verify option)"));
     ++	strvec_pushl(&ssh_keygen.args, fmt->program, "-Y", "find-principals",
     ++		     "-f", get_ssh_allowed_signers(), "-s", temp->filename.buf,
     ++		     NULL);
     ++	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0,
     ++			   &ssh_keygen_err, 0);
     ++	if (ret && strstr(ssh_keygen_err.buf, "usage:")) {
     ++		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
     ++		return ret;
      +	}
      +	if (ret || !ssh_keygen_out.len) {
     -+		/* We did not find a matching principal in the keyring - Check without validation */
     ++		/* We did not find a matching principal in the allowedSigners - Check
     ++		 * without validation */
      +		child_process_init(&ssh_keygen);
     -+		strvec_pushl(&ssh_keygen.args,  fmt->program,
     -+						"-Y", "check-novalidate",
     -+						"-n", "git",
     -+						"-s", temp->filename.buf,
     -+						NULL);
     -+		ret = pipe_command(&ssh_keygen, payload, payload_size, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
     ++		strvec_pushl(&ssh_keygen.args, fmt->program, "-Y",
     ++			     "check-novalidate", "-n", "git", "-s",
     ++			     temp->filename.buf, NULL);
     ++		ret = pipe_command(&ssh_keygen, payload, payload_size,
     ++				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
      +	} else {
      +		/* Check every principal we found (one per line) */
     -+		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {
     ++		for (line = ssh_keygen_out.buf; *line;
     ++		     line = strchrnul(line + 1, '\n')) {
      +			while (*line == '\n')
      +				line++;
      +			if (!*line)
      +				break;
      +
     -+			trust_size = strcspn(line, " \n");
     ++			trust_size = strcspn(line, "\n");
      +			principal = xmemdupz(line, trust_size);
      +
      +			child_process_init(&ssh_keygen);
      +			strbuf_release(&ssh_keygen_out);
      +			strbuf_release(&ssh_keygen_err);
     -+			strvec_push(&ssh_keygen.args,fmt->program);
     -+			/* We found principals - Try with each until we find a match */
     -+			strvec_pushl(&ssh_keygen.args,  "-Y", "verify",
     -+							"-n", "git",
     -+							"-f", get_ssh_allowed_signers(),
     -+							"-I", principal,
     -+							"-s", temp->filename.buf,
     -+							NULL);
     ++			strvec_push(&ssh_keygen.args, fmt->program);
     ++			/* We found principals - Try with each until we find a
     ++			 * match */
     ++			strvec_pushl(&ssh_keygen.args, "-Y", "verify", "-n",
     ++				     "git", "-f", get_ssh_allowed_signers(),
     ++				     "-I", principal, "-s", temp->filename.buf,
     ++				     NULL);
      +
      +			if (ssh_revocation_file) {
      +				if (file_exists(ssh_revocation_file)) {
     -+					strvec_pushl(&ssh_keygen.args, "-r", ssh_revocation_file, NULL);
     ++					strvec_pushl(&ssh_keygen.args, "-r",
     ++						     ssh_revocation_file, NULL);
      +				} else {
     -+					warning(_("ssh signing revocation file configured but not found: %s"), ssh_revocation_file);
     ++					warning(_("ssh signing revocation file configured but not found: %s"),
     ++						ssh_revocation_file);
      +				}
      +			}
      +
      +			sigchain_push(SIGPIPE, SIG_IGN);
      +			ret = pipe_command(&ssh_keygen, payload, payload_size,
     -+					&ssh_keygen_out, 0, &ssh_keygen_err, 0);
     ++					   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
      +			sigchain_pop(SIGPIPE);
      +
     ++			FREE_AND_NULL(principal);
     ++
      +			ret &= starts_with(ssh_keygen_out.buf, "Good");
      +			if (ret == 0)
      +				break;
     @@ gpg-interface.c: error:
      +	return ret;
      +}
      +
     - static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt,
     - 	const char *payload, size_t payload_size,
     - 	const char *signature, size_t signature_size)
     + int check_signature(const char *payload, size_t plen, const char *signature,
     + 	size_t slen, struct signature_check *sigc)
     + {
     +@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     + 		return 0;
     + 	}
     + 
     ++	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
     ++		if (!value)
     ++			return config_error_nonbool(var);
     ++		return git_config_string(&ssh_allowed_signers, var, value);
     ++	}
     ++
     ++	if (!strcmp(var, "gpg.ssh.revocationFile")) {
     ++		if (!value)
     ++			return config_error_nonbool(var);
     ++		return git_config_string(&ssh_revocation_file, var, value);
     ++	}
     ++
     + 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
     + 		fmtname = "openpgp";
     + 
  7:  1d292a8d7a2 !  6:  06a76e64b35 ssh signing: add test prereqs
     @@ Metadata
       ## Commit message ##
          ssh signing: add test prereqs
      
     -    generate some ssh keys and a allowed keys keyring for testing
     +    generate some ssh keys and a allowedSignersFile for testing
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     @@ t/lib-gpg.sh: test_lazy_prereq RFC1991 '
      +	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
      +	ssh-keygen -t rsa -b 2048 -N "" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
      +	ssh-keygen -t ed25519 -N "super_secret" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
     -+	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"principal_\" NR \" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.keyring" &&
     -+	cat "${GNUPGHOME}/ssh.all_valid.keyring" &&
     ++	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"\\\"principal with number \" NR \"\\\" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     ++	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
      +	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
      +'
      +
     @@ t/lib-gpg.sh: test_lazy_prereq RFC1991 '
      +SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
      +SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
      +SIGNING_KEY_PASSPHRASE="super_secret"
     -+SIGNING_KEYRING="${GNUPGHOME}/ssh.all_valid.keyring"
     ++SIGNING_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
      +
      +GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
      +GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
  8:  338d1b976e9 !  7:  4dc5572083b ssh signing: duplicate t7510 tests for commits
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify and show signatures' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	test_config gpg.mintrustlevel UNDEFINED &&
      +	(
      +		for commit in initial second merge fourth-signed \
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify-commit exits success on untrusted signature' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git verify-commit eighth-signed-alt 2>actual &&
      +	grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
      +	! grep "${BAD_SIGNATURE}" actual &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	test_config gpg.minTrustLevel fully &&
      +	git verify-commit sixth-signed
      +'
      +
      +test_expect_success GPGSSH 'verify-commit exits success with low minTrustLevel' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	test_config gpg.minTrustLevel marginal &&
      +	git verify-commit sixth-signed
      +'
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify signatures with --raw' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	(
      +		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
      +		do
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show signed commit with signature' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git show -s initial >commit &&
      +	git show -s --show-signature initial >show &&
      +	git verify-commit -v initial >verify.1 2>verify.2 &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'detect fudged signature' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git cat-file commit seventh-signed >raw &&
      +	sed -e "s/^seventh/7th forged/" raw >forged1 &&
      +	git hash-object -w -t commit forged1 >forged1.commit &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'detect fudged signature with NUL' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git cat-file commit seventh-signed >raw &&
      +	cat raw >forged2 &&
      +	echo Qwik | tr "Q" "\000" >>forged2 &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +test_expect_success GPGSSH 'amending already signed commit' '
      +	test_config gpg.format ssh &&
      +	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git checkout fourth-signed^0 &&
      +	git commit --amend -S --no-edit &&
      +	git verify-commit HEAD &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show good signature with custom format' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
      +	cat >expect.tmpl <<-\EOF &&
      +	G
      +	FINGERPRINT
     -+	principal_1
     ++	principal with number 1
      +	FINGERPRINT
      +
      +	EOF
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show bad signature with custom format' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	cat >expect <<-\EOF &&
      +	B
      +
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show untrusted signature with custom format' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	cat >expect.tmpl <<-\EOF &&
      +	U
      +	FINGERPRINT
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show untrusted signature with undefined trust level' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	cat >expect.tmpl <<-\EOF &&
      +	undefined
      +	FINGERPRINT
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show untrusted signature with ultimate trust level' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	cat >expect.tmpl <<-\EOF &&
      +	fully
      +	FINGERPRINT
     -+	principal_1
     ++	principal with number 1
      +	FINGERPRINT
      +
      +	EOF
     @@ t/t7527-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'log.showsignature behaves like --show-signature' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	test_config log.showsignature true &&
      +	git show initial >actual &&
      +	grep "${GOOD_SIGNATURE_TRUSTED}" actual
  9:  33330fda441 !  8:  275dd8a1013 ssh signing: add more tests for logs, tags & push certs
     @@ t/t4202-log.sh: test_expect_success GPGSM 'log OpenPGP fingerprint' '
       '
       
      +test_expect_success GPGSSH 'log ssh key fingerprint' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	ssh-keygen -lf  "${SIGNING_KEY_PRIMARY}" | awk "{print \$2\" | \"}" >expect &&
      +	git log -n1 --format="%GF | %GP" signed-ssh >actual &&
      +	test_cmp expect actual
     @@ t/t4202-log.sh: test_expect_success GPGSM 'log --graph --show-signature x509' '
       '
       
      +test_expect_success GPGSSH 'log --graph --show-signature ssh' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git log --graph --show-signature -n1 signed-ssh >actual &&
      +	grep "${GOOD_SIGNATURE_TRUSTED}" actual
      +'
     @@ t/t5534-push-signed.sh: test_expect_success GPG 'signed push sends push certific
      +test_expect_success GPGSSH 'ssh signed push sends push certificate' '
      +	prepare_dst &&
      +	mkdir -p dst/.git/hooks &&
     -+	git -C dst config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git -C dst config receive.certnonceseed sekrit &&
      +	write_script dst/.git/hooks/post-receive <<-\EOF &&
      +	# discard the update list
     @@ t/t5534-push-signed.sh: test_expect_success GPG 'signed push sends push certific
      +
      +	(
      +		cat <<-\EOF &&
     -+		SIGNER=principal_1
     ++		SIGNER=principal with number 1
      +		KEY=FINGERPRINT
      +		STATUS=G
      +		NONCE_STATUS=OK
     @@ t/t5534-push-signed.sh: test_expect_success GPGSM 'fail without key and heed use
      +	test_config gpg.format ssh &&
      +	prepare_dst &&
      +	mkdir -p dst/.git/hooks &&
     -+	git -C dst config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git -C dst config receive.certnonceseed sekrit &&
      +	write_script dst/.git/hooks/post-receive <<-\EOF &&
      +	# discard the update list
     @@ t/t5534-push-signed.sh: test_expect_success GPGSM 'fail without key and heed use
      +
      +	(
      +		cat <<-\EOF &&
     -+		SIGNER=principal_1
     ++		SIGNER=principal with number 1
      +		KEY=FINGERPRINT
      +		STATUS=G
      +		NONCE_STATUS=OK
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify and show ssh signatures' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	(
      +		for tag in initial second merge fourth-signed sixth-signed seventh-signed
      +		do
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'detect fudged ssh signature' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git cat-file tag seventh-signed >raw &&
      +	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
      +	git hash-object -w -t tag forged1 >forged1.tag &&
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify ssh signatures with --raw' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	(
      +		for tag in initial second merge fourth-signed sixth-signed seventh-signed
      +		do
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify signatures with --raw ssh' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	git verify-tag --raw sixth-signed 2>actual &&
      +	grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
      +	! grep "${BAD_SIGNATURE}" actual &&
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify multiple tags ssh' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	tags="seventh-signed sixth-signed" &&
      +	for i in $tags
      +	do
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verifying tag with --format - ssh' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
      +	cat >expect <<-\EOF &&
      +	tagname : fourth-signed
      +	EOF
  2:  2f8452f6570 !  9:  13f6c229bd1 ssh signing: add documentation
     @@ Documentation/config/gpg.txt: gpg.minTrustLevel::
       * `fully`
       * `ultimate`
      +
     -+gpg.ssh.keyring::
     -+	A file containing all valid SSH public signing keys.
     -+	Similar to an .ssh/authorized_keys file.
     ++gpg.ssh.allowedSignersFile::
     ++	A file containing ssh public keys which you are willing to trust.
     ++	The file consists of one or more lines of principals followed by an ssh
     ++	public key.
     ++	e.g.: user1@example.com,user2@example.com ssh-rsa AAAAX1...
      +	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
     -+	If a signing key is found in this file then the trust level will
     -+	be set to "fully". Otherwise if the key is not present
     -+	but the signature is still valid then the trust level will be "undefined".
     ++	The principal is only used to identify the key and is available when
     ++	verifying a signature.
     +++
     ++SSH has no concept of trust levels like gpg does. To be able to differentiate
     ++between valid signatures and trusted signatures the trust level of a signature
     ++verification is set to `fully` when the public key is present in the allowedSignersFile.
     ++Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
     ++Otherwise valid but untrusted signatures will still verify but show no principal
     ++name of the signer.
     +++
     ++This file can be set to a location outside of the repository and every developer
     ++maintains their own trust store. A central repository server could generate this
     ++file automatically from ssh keys with push access to verify the code against.
     ++In a corporate setting this file is probably generated at a global location
     ++from automation that already handles developer ssh keys.
     +++
     ++A repository that only allows signed commits can store the file
     ++in the repository itself using a path relative to the top-level of the working tree.
     ++This way only committers with an already valid key can add or change keys in the keyring.
     +++
     ++Using a SSH CA key with the cert-authority option
     ++(see ssh-keygen(1) "CERTIFICATES") is also valid.
      +
     -+	This file can be set to a location outside of the repository
     -+	and every developer maintains their own trust store.
     -+	A central repository server could generate this file automatically
     -+	from ssh keys with push	access to verify the code against.
     -+	In a corporate setting this file is probably generated at a global location
     -+	from some automation that already handles developer ssh keys.
     -+
     -+	A repository that is only allowing signed commits can store the file
     -+	in the repository itself using a relative path. This way only committers
     -+	with an already valid key can add or change keys in the keyring.
     -+
     -+	Using a SSH CA key with the cert-authority option
     -+	(see ssh-keygen(1) "CERTIFICATES") is also valid.
     -+
     -+	To revoke a key place the public key without the principal into the
     -+	revocationKeyring.
     -+
     -+gpg.ssh.revocationKeyring::
     ++gpg.ssh.revocationFile::
      +	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
      +	See ssh-keygen(1) for details.
      +	If a public key is found in this file then it will always be treated

-- 
gitgitgadget
