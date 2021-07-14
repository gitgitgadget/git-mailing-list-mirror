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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD8C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8B06120A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhGNMNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbhGNMNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B366C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3739507wmh.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EF/ah59gndsIPG7LW/tmi1a8Ly1aXkt2jmznqr94MNo=;
        b=EXSgkwFyFv88bvU3muSne0xUKn0TcIfChYOXItshbjsqVw9ZlbYlzoMeCDrfGMAxD5
         EHRkxSyssIlmmF+G90UHain0t/1e07uEZ8Uowi7QdB1H8XaeAPpKrYjyrLCse527WB5S
         cJfod/7Vz4BfFVwHm1fU7GKgWUQF+1mKAqbzLnx7+hlqGm97UnbPmjF6TQW75ZT7g08l
         SAICs/XTRSim9Njq8neVr5mtRsLIJuTb37/TStkdbsN8tqewEEN2Dlzz7f2JhedBr5wP
         mZ6ZZaCy5ene5w7df9rQ4QYZZg7SFp0DhYeXu80COIxX4o7nc09obsWtmc0CARRA7JOb
         cCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EF/ah59gndsIPG7LW/tmi1a8Ly1aXkt2jmznqr94MNo=;
        b=mo9A3BUKC5tHbUvxCT5Odo+z5ZdnB9LsRs0YOybqsf5zxvPrs+MLRHiwK+6pBdsAB+
         CtVhTcUxRn6g7jdTrZc1vd7NW2yso2i9eAwah0GV/ebQN7dKyFLStQqGqTmwSFpTtw3f
         2iyfJWdtVosUsHYA3lOnE/Ku02cKnMNhEG4B7+EKZ4mYlU271r6O6zin9Ulgscs+5Bog
         0xeMq9FsG2bpWu0MgSxHj2n6uImcWFqTE8VAtvbYMqMqK8ygUq4FZ4uSVBOBQdTNz5VJ
         8GBYRkZjWzNFbUaDMbvIPovKslwCwQgq/MRjqKane8fJuaXCgiqpGQSrlVPqr8vC6+4h
         kg5Q==
X-Gm-Message-State: AOAM530jKI7kPyqkhGM4kJYpzb0IRnvdoZNnc9oJUBwAKCGQPc1XtQn9
        Nq1UmDIAOrjBJGoEwaVhg+gr9FJQH+I=
X-Google-Smtp-Source: ABdhPJzzb9RXqKVxSF+6NpBNM1mKUVqi4hJw++Yc6WPsNf1umJ2uE2oAh5dKM/g6hY2Ltz8BPRrKzw==
X-Received: by 2002:a05:600c:8a9:: with SMTP id l41mr3778105wmp.152.1626264614638;
        Wed, 14 Jul 2021 05:10:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm2378033wrw.53.2021.07.14.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:14 -0700 (PDT)
Message-Id: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:04 +0000
Subject: [PATCH v3 0/9] RFC: Add commit & tag signing/verification via SSH keys using ssh-keygen
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

Fabian Stelzer (9):
  Add commit, tag & push signing via SSH keys
  ssh signing: add documentation
  ssh signing: retrieve a default key from ssh-agent
  ssh signing: sign using either gpg or ssh keys
  ssh signing: provide a textual representation of the signing key
  ssh signing: parse ssh-keygen output and verify signatures
  ssh signing: add test prereqs
  ssh signing: duplicate t7510 tests for commits
  ssh signing: add more tests for logs, tags & push certs

 Documentation/config/gpg.txt     |  35 ++-
 Documentation/config/user.txt    |   6 +
 builtin/receive-pack.c           |   2 +
 fmt-merge-msg.c                  |   4 +-
 gpg-interface.c                  | 411 +++++++++++++++++++++++++++----
 gpg-interface.h                  |  12 +-
 log-tree.c                       |   8 +-
 pretty.c                         |   4 +-
 send-pack.c                      |   8 +-
 t/lib-gpg.sh                     |  27 ++
 t/t4202-log.sh                   |  23 ++
 t/t5534-push-signed.sh           | 101 ++++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 ++++++++++++
 t/t7527-signed-commit-ssh.sh     | 398 ++++++++++++++++++++++++++++++
 14 files changed, 1136 insertions(+), 64 deletions(-)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh
 create mode 100755 t/t7527-signed-commit-ssh.sh


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v3
Pull-Request: https://github.com/git/git/pull/1041

Range-diff vs v2:

  -:  ----------- >  1:  390a8f816cd Add commit, tag & push signing via SSH keys
  -:  ----------- >  2:  2f8452f6570 ssh signing: add documentation
  -:  ----------- >  3:  b84b2812470 ssh signing: retrieve a default key from ssh-agent
  -:  ----------- >  4:  df55b9e1d59 ssh signing: sign using either gpg or ssh keys
  -:  ----------- >  5:  0581c72634c ssh signing: provide a textual representation of the signing key
  -:  ----------- >  6:  381a950a6e1 ssh signing: parse ssh-keygen output and verify signatures
  -:  ----------- >  7:  1d292a8d7a2 ssh signing: add test prereqs
  1:  b8b16f8e6ec !  8:  338d1b976e9 Add commit, tag & push signing/verification via SSH keys using ssh-keygen
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    Add commit, tag & push signing/verification via SSH keys using ssh-keygen
     -
     -    Openssh v8.2p1 added some new options to ssh-keygen for signature
     -    creation and verification. These allow us to use ssh keys for git
     -    signatures easily.
     -
     -    Set gpg.format = ssh and user.signingkey to either a ssh public key
     -    string (like from an authorized_keys file), or a ssh key file.
     -    If the key file or the config value itself contains only a public key
     -    then the private key needs to be available via ssh-agent.
     -    If no signingkey is set then git will call 'ssh-add -L' to check for
     -    available agent keys and use the first one for signing.
     -
     -    Verification uses the gpg.ssh.keyring file (see ssh-keygen(1) "ALLOWED
     -    SIGNERS") which contains valid public keys and an principal (usually
     -    user@domain). Depending on the environment this file can be managed by
     -    the individual developer or for example generated by the central
     -    repository server from known ssh keys with push access. If the
     -    repository only allows signed commits / pushes then the file can even be
     -    stored inside it.
     -
     -    To revoke a key put the public key without the principal prefix into
     -    gpg.ssh.revocationKeyring or generate a KRL (see ssh-keygen(1)
     -    "KEY REVOCATION LISTS"). The same considerations about who to trust for
     -    verification as with the keyring file apply.
     -
     -    This feature makes git signing much more accessible to the average user.
     -    Usually they have a SSH Key for pushing code already. Using it
     -    for signing commits allows us to verify not only the transport but the
     -    pushed code as well.
     -
     -    In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
     -    signing/encryption and ssh keys which i think is quite common
     -    (at least for the email part). This way we can establish the correct
     -    trust for the SSH Keys without setting up a separate GPG Infrastructure
     -    (which is still quite painful for users) or implementing x509 signing
     -    support for git (which lacks good forwarding mechanisms).
     -    Using ssh agent forwarding makes this feature easily usable in todays
     -    development environments where code is often checked out in remote VMs / containers.
     -    In such a setup the keyring & revocationKeyring can be centrally
     -    generated from the x509 CA information and distributed to the users.
     +    ssh signing: duplicate t7510 tests for commits
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     - ## Documentation/config/gpg.txt ##
     -@@ Documentation/config/gpg.txt: gpg.program::
     - 
     - gpg.format::
     - 	Specifies which key format to use when signing with `--gpg-sign`.
     --	Default is "openpgp" and another possible value is "x509".
     -+	Default is "openpgp". Other possible values are "x509", "ssh".
     - 
     - gpg.<format>.program::
     - 	Use this to customize the program used for the signing format you
     - 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
     - 	be used as a legacy synonym for `gpg.openpgp.program`. The default
     --	value for `gpg.x509.program` is "gpgsm".
     -+	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
     - 
     - gpg.minTrustLevel::
     - 	Specifies a minimum trust level for signature verification.  If
     -@@ Documentation/config/gpg.txt: gpg.minTrustLevel::
     - * `marginal`
     - * `fully`
     - * `ultimate`
     -+
     -+gpg.ssh.keyring::
     -+	A file containing all valid SSH public signing keys. 
     -+	Similar to an .ssh/authorized_keys file.
     -+	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
     -+	If a signing key is found in this file then the trust level will
     -+	be set to "fully". Otherwise if the key is not present
     -+	but the signature is still valid then the trust level will be "undefined".
     -+
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
     -+	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
     -+	See ssh-keygen(1) for details.
     -+	If a public key is found in this file then it will always be treated
     -+	as having trust level "never" and signatures will show as invalid.
     -
     - ## Documentation/config/user.txt ##
     -@@ Documentation/config/user.txt: user.signingKey::
     - 	commit, you can override the default selection with this variable.
     - 	This option is passed unchanged to gpg's --local-user parameter,
     - 	so you may specify a key using any method that gpg supports.
     -+	If gpg.format is set to "ssh" this can contain the literal ssh public
     -+	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and 
     -+	corresponds to the private key used for signing. The private key 
     -+	needs to be available via ssh-agent. Alternatively it can be set to
     -+	a file containing a private key directly. If not set git will call 
     -+	"ssh-add -L" and try to use the first key available.
     -
     - ## builtin/receive-pack.c ##
     -@@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const char *value, void *cb)
     - {
     - 	int status = parse_hide_refs_config(var, value, "receive");
     - 
     -+	git_gpg_config(var, value, NULL);
     -+
     - 	if (status)
     - 		return status;
     - 
     -@@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process *proc)
     - 		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
     - 		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
     - 				push_cert.len - bogs, &sigcheck);
     --
     -+		
     - 		nonce_status = check_nonce(push_cert.buf, bogs);
     - 	}
     - 	if (!is_null_oid(&push_cert_oid)) {
     -
     - ## fmt-merge-msg.c ##
     -@@ fmt-merge-msg.c: static void fmt_merge_msg_sigs(struct strbuf *out)
     - 			len = payload.len;
     - 			if (check_signature(payload.buf, payload.len, sig.buf,
     - 					 sig.len, &sigc) &&
     --				!sigc.gpg_output)
     -+				!sigc.output)
     - 				strbuf_addstr(&sig, "gpg verification failed.\n");
     - 			else
     --				strbuf_addstr(&sig, sigc.gpg_output);
     -+				strbuf_addstr(&sig, sigc.output);
     - 		}
     - 		signature_check_clear(&sigc);
     - 
     -
     - ## gpg-interface.c ##
     -@@
     - #include "config.h"
     - #include "run-command.h"
     - #include "strbuf.h"
     -+#include "dir.h"
     - #include "gpg-interface.h"
     - #include "sigchain.h"
     - #include "tempfile.h"
     - 
     - static char *configured_signing_key;
     -+const char *ssh_allowed_signers, *ssh_revocation_file;
     - static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
     - 
     - struct gpg_format {
     -@@ gpg-interface.c: static const char *x509_sigs[] = {
     - 	NULL
     - };
     - 
     -+static const char *ssh_verify_args[] = {
     -+	NULL
     -+};
     -+static const char *ssh_sigs[] = {
     -+	"-----BEGIN SSH SIGNATURE-----",
     -+	NULL
     -+};
     -+
     - static struct gpg_format gpg_format[] = {
     - 	{ .name = "openpgp", .program = "gpg",
     - 	  .verify_args = openpgp_verify_args,
     -@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     - 	  .verify_args = x509_verify_args,
     - 	  .sigs = x509_sigs
     - 	},
     -+	{ .name = "ssh", .program = "ssh-keygen",
     -+	  .verify_args = ssh_verify_args,
     -+	  .sigs = ssh_sigs },
     - };
     - 
     - static struct gpg_format *use_format = &gpg_format[0];
     -@@ gpg-interface.c: static struct gpg_format *get_format_by_sig(const char *sig)
     - void signature_check_clear(struct signature_check *sigc)
     - {
     - 	FREE_AND_NULL(sigc->payload);
     -+	FREE_AND_NULL(sigc->output);
     - 	FREE_AND_NULL(sigc->gpg_output);
     - 	FREE_AND_NULL(sigc->gpg_status);
     - 	FREE_AND_NULL(sigc->signer);
     -@@ gpg-interface.c: static int parse_gpg_trust_level(const char *level,
     - 	return 1;
     - }
     - 
     -+static void parse_ssh_output(struct signature_check *sigc)
     -+{
     -+	const char *output = NULL;
     -+	char *next = NULL;
     -+
     -+	/* ssh-keysign output should be:
     -+	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
     -+	 * or for valid but unknown keys:
     -+	 * Good "git" signature with RSA key SHA256:FINGERPRINT
     -+	 */
     -+
     -+	output = xmemdupz(sigc->output, strcspn(sigc->output, " \n"));
     -+	if (skip_prefix(sigc->output, "Good \"git\" signature for ", &output)) {
     -+		// Valid signature for a trusted signer
     -+		sigc->result = 'G';
     -+		sigc->trust_level = TRUST_FULLY;
     -+
     -+		next = strchrnul(output, ' '); // 'principal'
     -+		replace_cstring(&sigc->signer, output, next);
     -+		output = next + 1;
     -+		next = strchrnul(output, ' '); // 'with'
     -+		output = next + 1;
     -+		next = strchrnul(output, ' '); // KEY Type
     -+		output = next + 1;
     -+		next = strchrnul(output, ' '); // 'key'
     -+		output = next + 1;
     -+		next = strchrnul(output, '\n'); // key
     -+		replace_cstring(&sigc->fingerprint, output, next);
     -+		replace_cstring(&sigc->key, output, next);
     -+	} else if (skip_prefix(sigc->output, "Good \"git\" signature with ", &output)) {
     -+		// Valid signature, but key unknown
     -+		sigc->result = 'G';
     -+		sigc->trust_level = TRUST_UNDEFINED;
     -+
     -+		next = strchrnul(output, ' '); // KEY Type
     -+		output = next + 1;
     -+		next = strchrnul(output, ' '); // 'key'
     -+		output = next + 1;
     -+		next = strchrnul(output, '\n'); // key
     -+		replace_cstring(&sigc->fingerprint, output, next);
     -+		replace_cstring(&sigc->key, output, next);
     -+	} else {
     -+		sigc->result = 'B';
     -+		sigc->trust_level = TRUST_NEVER;
     -+	}
     -+}
     -+
     - static void parse_gpg_output(struct signature_check *sigc)
     - {
     - 	const char *buf = sigc->gpg_status;
     -@@ gpg-interface.c: error:
     - 	FREE_AND_NULL(sigc->key);
     - }
     - 
     --static int verify_signed_buffer(const char *payload, size_t payload_size,
     --				const char *signature, size_t signature_size,
     --				struct strbuf *gpg_output,
     --				struct strbuf *gpg_status)
     -+static int verify_ssh_signature(struct signature_check *sigc, struct gpg_format *fmt,
     -+	const char *payload, size_t payload_size,
     -+	const char *signature, size_t signature_size)
     - {
     --	struct child_process gpg = CHILD_PROCESS_INIT;
     --	struct gpg_format *fmt;
     -+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
     - 	struct tempfile *temp;
     - 	int ret;
     --	struct strbuf buf = STRBUF_INIT;
     -+	const char *line;
     -+	size_t trust_size;
     -+	char *principal;
     -+	struct strbuf ssh_keygen_out = STRBUF_INIT;
     -+	struct strbuf ssh_keygen_err = STRBUF_INIT;
     - 
     - 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
     - 	if (!temp)
     -@@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t payload_size,
     - 		return -1;
     - 	}
     - 
     --	fmt = get_format_by_sig(signature);
     --	if (!fmt)
     --		BUG("bad signature '%s'", signature);
     -+	// Find the principal from the  signers
     -+	strvec_pushl(&ssh_keygen.args,  fmt->program,
     -+					"-Y", "find-principals",
     -+					"-f", get_ssh_allowed_signers(),
     -+					"-s", temp->filename.buf,
     -+					NULL);
     -+	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
     -+	if (strstr(ssh_keygen_err.buf, "unknown option")) {
     -+		error(_("openssh version > 8.2p1 is needed for ssh signature verification (ssh-keygen needs -Y find-principals/verify option)"));
     -+	}
     -+	if (ret || !ssh_keygen_out.len) {
     -+		// We did not find a matching principal in the keyring - Check without validation
     -+		child_process_init(&ssh_keygen);
     -+		strvec_pushl(&ssh_keygen.args,  fmt->program,
     -+						"-Y", "check-novalidate",
     -+						"-n", "git",
     -+						"-s", temp->filename.buf,
     -+						NULL);
     -+		ret = pipe_command(&ssh_keygen, payload, payload_size, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
     -+	} else {
     -+		// Check every principal we found (one per line)
     -+		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {
     -+			while (*line == '\n')
     -+				line++;
     -+			if (!*line)
     -+				break;
     -+
     -+			trust_size = strcspn(line, " \n");
     -+			principal = xmemdupz(line, trust_size);
     -+
     -+			child_process_init(&ssh_keygen);
     -+			strbuf_release(&ssh_keygen_out);
     -+			strbuf_release(&ssh_keygen_err);
     -+			strvec_push(&ssh_keygen.args,fmt->program);
     -+			// We found principals - Try with each until we find a match
     -+			strvec_pushl(&ssh_keygen.args,  "-Y", "verify",
     -+							//TODO: sprintf("-Overify-time=%s", commit->date...),
     -+							"-n", "git",
     -+							"-f", get_ssh_allowed_signers(),
     -+							"-I", principal,
     -+							"-s", temp->filename.buf,
     -+							NULL);
     -+
     -+			if (ssh_revocation_file && file_exists(ssh_revocation_file)) {
     -+				strvec_pushl(&ssh_keygen.args, "-r", ssh_revocation_file, NULL);
     -+			}
     -+
     -+			sigchain_push(SIGPIPE, SIG_IGN);
     -+			ret = pipe_command(&ssh_keygen, payload, payload_size,
     -+					&ssh_keygen_out, 0, &ssh_keygen_err, 0);
     -+			sigchain_pop(SIGPIPE);
     -+
     -+			ret &= starts_with(ssh_keygen_out.buf, "Good");
     -+			if (ret == 0)
     -+				break;
     -+		}
     -+	}
     -+
     -+	sigc->payload = xmemdupz(payload, payload_size);
     -+	strbuf_stripspace(&ssh_keygen_out, 0);
     -+	strbuf_stripspace(&ssh_keygen_err, 0);
     -+	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
     -+	sigc->output = strbuf_detach(&ssh_keygen_out, NULL);
     -+
     -+	//sigc->gpg_output = strbuf_detach(&ssh_keygen_err, NULL); // This flip around is broken...
     -+	sigc->gpg_status = strbuf_detach(&ssh_keygen_out, NULL);
     -+
     -+	parse_ssh_output(sigc);
     -+
     -+	delete_tempfile(&temp);
     -+	strbuf_release(&ssh_keygen_out);
     -+	strbuf_release(&ssh_keygen_err);
     -+
     -+	return ret;
     -+}
     -+
     -+static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt, 
     -+	const char *payload, size_t payload_size,
     -+	const char *signature, size_t signature_size)
     -+{
     -+	struct child_process gpg = CHILD_PROCESS_INIT;
     -+	struct tempfile *temp;
     -+	int ret;
     -+	struct strbuf gpg_out = STRBUF_INIT;
     -+	struct strbuf gpg_err = STRBUF_INIT;
     -+
     -+	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
     -+	if (!temp)
     -+		return error_errno(_("could not create temporary file"));
     -+	if (write_in_full(temp->fd, signature, signature_size) < 0 ||
     -+	    close_tempfile_gently(temp) < 0) {
     -+		error_errno(_("failed writing detached signature to '%s'"),
     -+			    temp->filename.buf);
     -+		delete_tempfile(&temp);
     -+		return -1;
     -+	}
     - 
     - 	strvec_push(&gpg.args, fmt->program);
     - 	strvec_pushv(&gpg.args, fmt->verify_args);
     - 	strvec_pushl(&gpg.args,
     --		     "--status-fd=1",
     --		     "--verify", temp->filename.buf, "-",
     --		     NULL);
     --
     --	if (!gpg_status)
     --		gpg_status = &buf;
     -+			"--status-fd=1",
     -+			"--verify", temp->filename.buf, "-",
     -+			NULL);
     - 
     - 	sigchain_push(SIGPIPE, SIG_IGN);
     --	ret = pipe_command(&gpg, payload, payload_size,
     --			   gpg_status, 0, gpg_output, 0);
     -+	ret = pipe_command(&gpg, payload, payload_size, &gpg_out, 0,
     -+				&gpg_err, 0);
     - 	sigchain_pop(SIGPIPE);
     -+	ret |= !strstr(gpg_out.buf, "\n[GNUPG:] GOODSIG ");
     - 
     --	delete_tempfile(&temp);
     -+	sigc->payload = xmemdupz(payload, payload_size);
     -+	sigc->output = strbuf_detach(&gpg_err, NULL);
     -+	sigc->gpg_status = strbuf_detach(&gpg_out, NULL);
     - 
     --	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
     --	strbuf_release(&buf); /* no matter it was used or not */
     -+	parse_gpg_output(sigc);
     -+
     -+	delete_tempfile(&temp);
     -+	strbuf_release(&gpg_out);
     -+	strbuf_release(&gpg_err);
     - 
     - 	return ret;
     - }
     -@@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t payload_size,
     - int check_signature(const char *payload, size_t plen, const char *signature,
     - 	size_t slen, struct signature_check *sigc)
     - {
     --	struct strbuf gpg_output = STRBUF_INIT;
     --	struct strbuf gpg_status = STRBUF_INIT;
     -+	struct gpg_format *fmt;
     - 	int status;
     - 
     - 	sigc->result = 'N';
     - 	sigc->trust_level = -1;
     - 
     --	status = verify_signed_buffer(payload, plen, signature, slen,
     --				      &gpg_output, &gpg_status);
     --	if (status && !gpg_output.len)
     --		goto out;
     --	sigc->payload = xmemdupz(payload, plen);
     --	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
     --	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
     --	parse_gpg_output(sigc);
     -+	fmt = get_format_by_sig(signature);
     -+	if (!fmt)
     -+		BUG("bad signature '%s'", signature);
     -+
     -+	if (!strcmp(fmt->name, "ssh")) {
     -+		status = verify_ssh_signature(sigc, fmt, payload, plen, signature, slen);
     -+	} else {
     -+		status = verify_gpg_signature(sigc, fmt, payload, plen, signature, slen);
     -+	}
     -+	if (status && !sigc->gpg_output)
     -+		return !!status;
     -+
     - 	status |= sigc->result != 'G';
     - 	status |= sigc->trust_level < configured_min_trust_level;
     - 
     -- out:
     --	strbuf_release(&gpg_status);
     --	strbuf_release(&gpg_output);
     --
     - 	return !!status;
     - }
     - 
     - void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
     - {
     - 	const char *output = flags & GPG_VERIFY_RAW ?
     --		sigc->gpg_status : sigc->gpg_output;
     -+		sigc->gpg_status : sigc->output;
     - 
     - 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
     - 		fputs(sigc->payload, stdout);
     -@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     - 	int ret;
     - 
     - 	if (!strcmp(var, "user.signingkey")) {
     -+		/* user.signingkey can contain one of the following
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
     -@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     - 	return 0;
     - }
     - 
     -+static char *get_ssh_key_fingerprint(const char *signing_key) {
     -+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
     -+	int ret = -1;
     -+	struct strbuf fingerprint_stdout = STRBUF_INIT;
     -+	struct strbuf **fingerprint;
     -+
     -+	/* For SSH Signing this can contain a filename or a public key
     -+	* For textual representation we usually want a fingerprint
     -+	*/
     -+	if (istarts_with(signing_key, "ssh-")) {
     -+		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
     -+					"-lf", "-",
     -+					NULL);
     -+		ret = pipe_command(&ssh_keygen, signing_key, strlen(signing_key), &fingerprint_stdout, 0,  NULL, 0);
     -+	} else {
     -+		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
     -+					"-lf", configured_signing_key,
     -+					NULL);
     -+		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0, NULL, 0);
     -+		if (!!ret)
     -+			die_errno(_("failed to get the ssh fingerprint for key '%s'"), signing_key);
     -+		fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
     -+		if (fingerprint[1]) {
     -+			return strbuf_detach(fingerprint[1], NULL);
     -+		}
     -+	}
     -+	die_errno(_("failed to get the ssh fingerprint for key '%s'"), signing_key);
     -+}
     -+
     -+// Returns the first public key from an ssh-agent to use for signing
     -+static char *get_default_ssh_signing_key(void) {
     -+	struct child_process ssh_add = CHILD_PROCESS_INIT;
     -+	int ret = -1;
     -+	struct strbuf key_stdout = STRBUF_INIT;
     -+	struct strbuf **keys;
     -+
     -+	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
     -+	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
     -+	if (!ret) { 
     -+		keys = strbuf_split_max(&key_stdout, '\n', 2);
     -+		if (keys[0])
     -+			return strbuf_detach(keys[0], NULL);
     -+	}
     -+
     -+	return "";
     -+}
     -+
     -+// Returns a textual but unique representation ot the signing key
     -+const char *get_signing_key_id(void) {
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		return get_ssh_key_fingerprint(get_signing_key());
     -+	} else {
     -+		// GPG/GPGSM only store a key id on this variable
     -+		return get_signing_key();
     -+	}
     -+}
     -+
     - const char *get_signing_key(void)
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
     - }
     - 
     - int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
     -@@ gpg-interface.c: int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
     - 	int ret;
     - 	size_t i, j, bottom;
     - 	struct strbuf gpg_status = STRBUF_INIT;
     -+	struct tempfile *temp = NULL, *buffer_file = NULL;
     -+	char *ssh_signing_key_file = NULL;
     -+	struct strbuf ssh_signature_filename = STRBUF_INIT;
     -+
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		if (!signing_key || signing_key[0] == '\0')
     -+			return error(_("user.signingkey needs to be set for ssh signing"));
     -+
     -+
     -+		if (istarts_with(signing_key, "ssh-")) {
     -+			// A literal ssh key
     -+			temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
     -+			if (!temp)
     -+				return error_errno(_("could not create temporary file"));
     -+			if (write_in_full(temp->fd, signing_key, strlen(signing_key)) < 0 ||
     -+				close_tempfile_gently(temp) < 0) {
     -+				error_errno(_("failed writing ssh signing key to '%s'"), temp->filename.buf);
     -+				delete_tempfile(&temp);
     -+				return -1;
     -+			}
     -+			ssh_signing_key_file= temp->filename.buf;
     -+		} else {
     -+			// We assume a file
     -+			ssh_signing_key_file = expand_user_path(signing_key, 1);
     -+		}
     - 
     --	strvec_pushl(&gpg.args,
     --		     use_format->program,
     --		     "--status-fd=2",
     --		     "-bsau", signing_key,
     --		     NULL);
     -+		buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
     -+		if (!buffer_file)
     -+			return error_errno(_("could not create temporary file"));
     -+		if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
     -+			close_tempfile_gently(buffer_file) < 0) {
     -+			error_errno(_("failed writing ssh signing key buffer to '%s'"), buffer_file->filename.buf);
     -+			delete_tempfile(&buffer_file);
     -+			return -1;
     -+		}
     -+
     -+		strvec_pushl(&gpg.args, use_format->program ,
     -+					"-Y", "sign",
     -+					"-n", "git",
     -+					"-f", ssh_signing_key_file,
     -+					buffer_file->filename.buf,
     -+					NULL);
     -+
     -+		sigchain_push(SIGPIPE, SIG_IGN);
     -+		ret = pipe_command(&gpg, NULL, 0, NULL, 0, &gpg_status, 0);
     -+		sigchain_pop(SIGPIPE);
     -+
     -+		strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
     -+		strbuf_addstr(&ssh_signature_filename, ".sig");
     -+		if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
     -+			error_errno(_("failed reading ssh signing data buffer from '%s'"), ssh_signature_filename.buf);
     -+		}
     -+		unlink_or_warn(ssh_signature_filename.buf);
     -+		strbuf_release(&ssh_signature_filename);
     -+		delete_tempfile(&buffer_file);
     -+	} else {
     -+		strvec_pushl(&gpg.args, use_format->program ,
     -+					"--status-fd=2",
     -+					"-bsau", signing_key,
     -+					NULL);
     -+
     -+		/*
     -+		* When the username signingkey is bad, program could be terminated
     -+		* because gpg exits without reading and then write gets SIGPIPE.
     -+		*/
     -+		sigchain_push(SIGPIPE, SIG_IGN);
     -+		ret = pipe_command(&gpg, buffer->buf, buffer->len, signature, 1024, &gpg_status, 0);
     -+		sigchain_pop(SIGPIPE);
     -+	}
     - 
     - 	bottom = signature->len;
     - 
     --	/*
     --	 * When the username signingkey is bad, program could be terminated
     --	 * because gpg exits without reading and then write gets SIGPIPE.
     --	 */
     --	sigchain_push(SIGPIPE, SIG_IGN);
     --	ret = pipe_command(&gpg, buffer->buf, buffer->len,
     --			   signature, 1024, &gpg_status, 0);
     --	sigchain_pop(SIGPIPE);
     -+	if (temp)
     -+		delete_tempfile(&temp);
     - 
     --	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		if (strstr(gpg_status.buf, "unknown option")) {
     -+			error(_("openssh version > 8.2p1 is needed for ssh signing (ssh-keygen needs -Y sign option)"));
     -+		}
     -+	} else {
     -+		ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
     -+	}
     - 	strbuf_release(&gpg_status);
     - 	if (ret)
     - 		return error(_("gpg failed to sign the data"));
     -
     - ## gpg-interface.h ##
     -@@ gpg-interface.h: enum signature_trust_level {
     - 
     - struct signature_check {
     - 	char *payload;
     --	char *gpg_output;
     --	char *gpg_status;
     -+	char *output;
     -+	char *gpg_output; // This will be printed in commit logs
     -+	char *gpg_status; // Only used internally -> remove
     - 
     - 	/*
     - 	 * possible "result":
     -@@ gpg-interface.h: int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
     - int git_gpg_config(const char *, const char *, void *);
     - void set_signing_key(const char *);
     - const char *get_signing_key(void);
     -+
     -+/* Returns a textual unique representation of the signing key in use
     -+ * Either a GPG KeyID or a SSH Key Fingerprint
     -+ */
     -+const char *get_signing_key_id(void);
     -+
     -+const char *get_ssh_allowed_signers(void);
     - int check_signature(const char *payload, size_t plen,
     - 		    const char *signature, size_t slen,
     - 		    struct signature_check *sigc);
     -
     - ## log-tree.c ##
     -@@ log-tree.c: static void show_signature(struct rev_info *opt, struct commit *commit)
     - 
     - 	status = check_signature(payload.buf, payload.len, signature.buf,
     - 				 signature.len, &sigc);
     --	if (status && !sigc.gpg_output)
     -+	if (status && !sigc.output)
     - 		show_sig_lines(opt, status, "No signature\n");
     - 	else
     --		show_sig_lines(opt, status, sigc.gpg_output);
     -+		show_sig_lines(opt, status, sigc.output);
     - 	signature_check_clear(&sigc);
     - 
     -  out:
     -@@ log-tree.c: static int show_one_mergetag(struct commit *commit,
     - 		/* could have a good signature */
     - 		status = check_signature(payload.buf, payload.len,
     - 					 signature.buf, signature.len, &sigc);
     --		if (sigc.gpg_output)
     --			strbuf_addstr(&verify_message, sigc.gpg_output);
     -+		if (sigc.output)
     -+			strbuf_addstr(&verify_message, sigc.output);
     - 		else
     - 			strbuf_addstr(&verify_message, "No signature\n");
     - 		signature_check_clear(&sigc);
     -
     - ## pretty.c ##
     -@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 			check_commit_signature(c->commit, &(c->signature_check));
     - 		switch (placeholder[1]) {
     - 		case 'G':
     --			if (c->signature_check.gpg_output)
     --				strbuf_addstr(sb, c->signature_check.gpg_output);
     -+			if (c->signature_check.output)
     -+				strbuf_addstr(sb, c->signature_check.output);
     - 			break;
     - 		case '?':
     - 			switch (c->signature_check.result) {
     -
     - ## send-pack.c ##
     -@@ send-pack.c: static int generate_push_cert(struct strbuf *req_buf,
     - 	const struct ref *ref;
     - 	struct string_list_item *item;
     - 	char *signing_key = xstrdup(get_signing_key());
     -+	char *signing_key_id = xstrdup(get_signing_key_id());
     - 	const char *cp, *np;
     - 	struct strbuf cert = STRBUF_INIT;
     - 	int update_seen = 0;
     --
     -+	
     - 	strbuf_addstr(&cert, "certificate version 0.1\n");
     --	strbuf_addf(&cert, "pusher %s ", signing_key);
     -+	strbuf_addf(&cert, "pusher %s ", signing_key_id);
     - 	datestamp(&cert);
     - 	strbuf_addch(&cert, '\n');
     - 	if (args->url && *args->url) {
     -@@ send-pack.c: static int generate_push_cert(struct strbuf *req_buf,
     - 
     - free_return:
     - 	free(signing_key);
     -+	free(signing_key_id);
     - 	strbuf_release(&cert);
     - 	return update_seen;
     - }
     -
     - ## t/lib-gpg.sh ##
     -@@ t/lib-gpg.sh: test_lazy_prereq RFC1991 '
     - 	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
     - '
     - 
     -+test_lazy_prereq GPGSSH '
     -+	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
     -+	test $? != 127 || exit 1
     -+	echo $ssh_version | grep -q "find-principals:missing signature file"
     -+	test $? = 0 || exit 1; 
     -+	mkdir -p "${GNUPGHOME}" &&
     -+	chmod 0700 "${GNUPGHOME}" &&
     -+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
     -+	ssh-keygen -t rsa -b 2048 -N "" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
     -+	ssh-keygen -t ed25519 -N "super_secret" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
     -+	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"principal_\" NR \" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.keyring" &&
     -+	cat "${GNUPGHOME}/ssh.all_valid.keyring" &&
     -+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
     -+'
     -+
     -+SIGNING_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
     -+SIGNING_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
     -+SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
     -+SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
     -+SIGNING_KEY_PASSPHRASE="super_secret"
     -+SIGNING_KEYRING="${GNUPGHOME}/ssh.all_valid.keyring"
     -+
     -+GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
     -+GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
     -+KEY_NOT_TRUSTED="No principal matched"
     -+BAD_SIGNATURE="Signature verification failed"
     -+
     - sanitize_pgp() {
     - 	perl -ne '
     - 		/^-----END PGP/ and $in_pgp = 0;
     -
     - ## t/t4202-log.sh ##
     -@@ t/t4202-log.sh: test_expect_success GPGSM 'setup signed branch x509' '
     - 	git commit -S -m signed_commit
     - '
     - 
     -+test_expect_success GPGSSH 'setup sshkey signed branch' '
     -+	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	test_when_finished "git reset --hard && git checkout main" &&
     -+	git checkout -b signed-ssh main &&
     -+	echo foo >foo &&
     -+	git add foo &&
     -+	git commit -S -m signed_commit
     -+'
     -+
     - test_expect_success GPGSM 'log x509 fingerprint' '
     - 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
     - 	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
     -@@ t/t4202-log.sh: test_expect_success GPGSM 'log --graph --show-signature x509' '
     - 	grep "^| gpgsm: Good signature" actual
     - '
     - 
     -+test_expect_success GPGSSH 'log ssh key fingerprint' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+	ssh-keygen -lf  "${SIGNING_KEY_PRIMARY}" | awk "{print \$2\" | \"}" >expect &&
     -+	git log -n1 --format="%GF | %GP" signed-ssh >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     - test_expect_success GPG 'log --graph --show-signature for merged tag' '
     - 	test_when_finished "git reset --hard && git checkout main" &&
     - 	git checkout -b plain main &&
     -
     - ## t/t5534-push-signed.sh ##
     -@@ t/t5534-push-signed.sh: test_expect_success GPG 'signed push sends push certificate' '
     - 	test_cmp expect dst/push-cert-status
     - '
     - 
     -+test_expect_success GPGSSH 'ssh signed push sends push certificate' '
     -+	prepare_dst &&
     -+	mkdir -p dst/.git/hooks &&
     -+	git -C dst config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+	git -C dst config receive.certnonceseed sekrit &&
     -+	write_script dst/.git/hooks/post-receive <<-\EOF &&
     -+	# discard the update list
     -+	cat >/dev/null
     -+	# record the push certificate
     -+	if test -n "${GIT_PUSH_CERT-}"
     -+	then
     -+		git cat-file blob $GIT_PUSH_CERT >../push-cert
     -+	fi &&
     -+
     -+	cat >../push-cert-status <<E_O_F
     -+	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
     -+	KEY=${GIT_PUSH_CERT_KEY-nokey}
     -+	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
     -+	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
     -+	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
     -+	E_O_F
     -+
     -+	EOF
     -+
     -+	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
     -+	git push --signed dst noop ff +noff &&
     -+
     -+	(
     -+		cat <<-\EOF &&
     -+		SIGNER=principal_1
     -+		KEY=FINGERPRINT
     -+		STATUS=G
     -+		NONCE_STATUS=OK
     -+		EOF
     -+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
     -+	) | sed -e "s|FINGERPRINT|$FINGERPRINT|" >expect &&
     -+
     -+	noop=$(git rev-parse noop) &&
     -+	ff=$(git rev-parse ff) &&
     -+	noff=$(git rev-parse noff) &&
     -+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
     -+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
     -+	test_cmp expect dst/push-cert-status
     -+'
     -+
     - test_expect_success GPG 'inconsistent push options in signed push not allowed' '
     - 	# First, invoke receive-pack with dummy input to obtain its preamble.
     - 	prepare_dst &&
     -@@ t/t5534-push-signed.sh: test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
     - 	test_cmp expect dst/push-cert-status
     - '
     - 
     -+test_expect_success GPGSSH 'fail without key and heed user.signingkey ssh' '
     -+	test_config gpg.format ssh &&
     -+	prepare_dst &&
     -+	mkdir -p dst/.git/hooks &&
     -+	git -C dst config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+	git -C dst config receive.certnonceseed sekrit &&
     -+	write_script dst/.git/hooks/post-receive <<-\EOF &&
     -+	# discard the update list
     -+	cat >/dev/null
     -+	# record the push certificate
     -+	if test -n "${GIT_PUSH_CERT-}"
     -+	then
     -+		git cat-file blob $GIT_PUSH_CERT >../push-cert
     -+	fi &&
     -+
     -+	cat >../push-cert-status <<E_O_F
     -+	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
     -+	KEY=${GIT_PUSH_CERT_KEY-nokey}
     -+	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
     -+	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
     -+	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
     -+	E_O_F
     -+
     -+	EOF
     -+
     -+	test_config user.email hasnokey@nowhere.com &&
     -+	test_config gpg.format ssh &&
     -+	
     -+	test_config user.signingkey "" &&
     -+	(
     -+		sane_unset GIT_COMMITTER_EMAIL &&
     -+		test_must_fail git push --signed dst noop ff +noff
     -+	) &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
     -+	git push --signed dst noop ff +noff &&
     -+
     -+	(
     -+		cat <<-\EOF &&
     -+		SIGNER=principal_1
     -+		KEY=FINGERPRINT
     -+		STATUS=G
     -+		NONCE_STATUS=OK
     -+		EOF
     -+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
     -+	) | sed -e "s|FINGERPRINT|$FINGERPRINT|" >expect &&
     -+
     -+	noop=$(git rev-parse noop) &&
     -+	ff=$(git rev-parse ff) &&
     -+	noff=$(git rev-parse noff) &&
     -+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
     -+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
     -+	test_cmp expect dst/push-cert-status
     -+'
     -+
     - test_expect_success GPG 'failed atomic push does not execute GPG' '
     - 	prepare_dst &&
     - 	git -C dst config receive.certnonceseed sekrit &&
     -
     - ## t/t7031-verify-tag-signed-ssh.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='signed tag tests'
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+. ./test-lib.sh
     -+. "$TEST_DIRECTORY/lib-gpg.sh"
     -+
     -+test_expect_success GPGSSH 'create signed tags ssh' '
     -+	test_when_finished "test_unconfig commit.gpgsign" &&
     -+	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+
     -+	echo 1 >file && git add file &&
     -+	test_tick && git commit -m initial &&
     -+	git tag -s -m initial initial &&
     -+	git branch side &&
     -+
     -+	echo 2 >file && test_tick && git commit -a -m second &&
     -+	git tag -s -m second second &&
     -+
     -+	git checkout side &&
     -+	echo 3 >elif && git add elif &&
     -+	test_tick && git commit -m "third on side" &&
     -+
     -+	git checkout main &&
     -+	test_tick && git merge -S side &&
     -+	git tag -s -m merge merge &&
     -+
     -+	echo 4 >file && test_tick && git commit -a -S -m "fourth unsigned" &&
     -+	git tag -a -m fourth-unsigned fourth-unsigned &&
     -+
     -+	test_tick && git commit --amend -S -m "fourth signed" &&
     -+	git tag -s -m fourth fourth-signed &&
     -+
     -+	echo 5 >file && test_tick && git commit -a -m "fifth" &&
     -+	git tag fifth-unsigned &&
     -+
     -+	git config commit.gpgsign true &&
     -+	echo 6 >file && test_tick && git commit -a -m "sixth" &&
     -+	git tag -a -m sixth sixth-unsigned &&
     -+
     -+	test_tick && git rebase -f HEAD^^ && git tag -s -m 6th sixth-signed HEAD^ &&
     -+	git tag -m seventh -s seventh-signed &&
     -+
     -+	echo 8 >file && test_tick && git commit -a -m eighth &&
     -+	git tag -u"${SIGNING_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
     -+'
     -+
     -+test_expect_success GPGSSH 'verify and show ssh signatures' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+	test_config gpg.mintrustlevel UNDEFINED &&
     -+	(
     -+		for tag in initial second merge fourth-signed sixth-signed seventh-signed
     -+		do
     -+			git verify-tag $tag 2>actual &&
     -+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     -+			echo $tag OK || exit 1
     -+		done
     -+	) &&
     -+	(
     -+		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
     -+		do
     -+			test_must_fail git verify-tag $tag 2>actual &&
     -+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     -+			echo $tag OK || exit 1
     -+		done
     -+	) &&
     -+	(
     -+		for tag in eighth-signed-alt
     -+		do
     -+			git verify-tag $tag 2>actual &&
     -+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     -+			grep "${KEY_NOT_TRUSTED}" actual &&
     -+			echo $tag OK || exit 1
     -+		done
     -+	)
     -+'
     -+
     -+test_expect_success GPGSSH 'detect fudged ssh signature' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+	git cat-file tag seventh-signed >raw &&
     -+	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
     -+	git hash-object -w -t tag forged1 >forged1.tag &&
     -+	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
     -+	grep "${BAD_SIGNATURE}" actual1 &&
     -+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual1 &&
     -+	! grep "${GOOD_SIGNATURE_UNTRUSTED}" actual1
     -+'
     -+
     -+# test_expect_success GPGSSH 'verify ssh signatures with --raw' '
     -+# 	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+# 	(
     -+# 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
     -+# 		do
     -+# 			git verify-tag --raw $tag 2>actual &&
     -+# 			grep "GOODSIG" actual &&
     -+# 			! grep "BADSIG" actual &&
     -+# 			echo $tag OK || exit 1
     -+# 		done
     -+# 	) &&
     -+# 	(
     -+# 		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
     -+# 		do
     -+# 			test_must_fail git verify-tag --raw $tag 2>actual &&
     -+# 			! grep "GOODSIG" actual &&
     -+# 			! grep "BADSIG" actual &&
     -+# 			echo $tag OK || exit 1
     -+# 		done
     -+# 	) &&
     -+# 	(
     -+# 		for tag in eighth-signed-alt
     -+# 		do
     -+# 			git verify-tag --raw $tag 2>actual &&
     -+# 			grep "GOODSIG" actual &&
     -+# 			! grep "BADSIG" actual &&
     -+# 			grep "TRUST_UNDEFINED" actual &&
     -+# 			echo $tag OK || exit 1
     -+# 		done
     -+# 	)
     -+# '
     -+
     -+# test_expect_success GPGSM 'verify signatures with --raw x509' '
     -+# 	git verify-tag --raw ninth-signed-x509 2>actual &&
     -+# 	grep "GOODSIG" actual &&
     -+# 	! grep "BADSIG" actual &&
     -+# 	echo ninth-signed-x509 OK
     -+# '
     -+
     -+# test_expect_success GPGSSH 'verify multiple tags' '
     -+# 	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+# 	tags="fourth-signed sixth-signed seventh-signed" &&
     -+# 	for i in $tags
     -+# 	do
     -+# 		git verify-tag -v --raw $i || return 1
     -+# 	done >expect.stdout 2>expect.stderr.1 &&
     -+# 	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
     -+# 	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
     -+# 	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
     -+# 	test_cmp expect.stdout actual.stdout &&
     -+# 	test_cmp expect.stderr actual.stderr
     -+# '
     -+
     -+# test_expect_success GPGSM 'verify multiple tags x509' '
     -+#	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+# 	tags="seventh-signed ninth-signed-x509" &&
     -+# 	for i in $tags
     -+# 	do
     -+# 		git verify-tag -v --raw $i || return 1
     -+# 	done >expect.stdout 2>expect.stderr.1 &&
     -+# 	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
     -+# 	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
     -+# 	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
     -+# 	test_cmp expect.stdout actual.stdout &&
     -+# 	test_cmp expect.stderr actual.stderr
     -+# '
     -+
     -+test_expect_success GPGSSH 'verifying tag with --format' '
     -+	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     -+	cat >expect <<-\EOF &&
     -+	tagname : fourth-signed
     -+	EOF
     -+	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success GPGSSH 'verifying a forged tag with --format should fail silently' '
     -+	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
     -+	test_must_be_empty actual-forged
     -+'
     -+
     -+test_done
     -
       ## t/t7527-signed-commit-ssh.sh (new) ##
      @@
      +#!/bin/sh
     @@ t/t7527-signed-commit-ssh.sh (new)
      +	test_must_fail git verify-commit eighth-signed-alt
      +'
      +
     -+# test_expect_success GPGSSH 'verify signatures with --raw' '
     -+# 	(
     -+# 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
     -+# 		do
     -+# 			git verify-commit --raw $commit 2>actual &&
     -+# 			grep "GOODSIG" actual &&
     -+# 			! grep "BADSIG" actual &&
     -+# 			echo $commit OK || exit 1
     -+# 		done
     -+# 	) &&
     -+# 	(
     -+# 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
     -+# 		do
     -+# 			test_must_fail git verify-commit --raw $commit 2>actual &&
     -+# 			! grep "GOODSIG" actual &&
     -+# 			! grep "BADSIG" actual &&
     -+# 			echo $commit OK || exit 1
     -+# 		done
     -+# 	) &&
     -+# 	(
     -+# 		for commit in eighth-signed-alt
     -+# 		do
     -+# 			git verify-commit --raw $commit 2>actual &&
     -+# 			grep "GOODSIG" actual &&
     -+# 			! grep "BADSIG" actual &&
     -+# 			grep "TRUST_UNDEFINED" actual &&
     -+# 			echo $commit OK || exit 1
     -+# 		done
     -+# 	)
     -+# '
     ++test_expect_success GPGSSH 'verify signatures with --raw' '
     ++	test_config gpg.ssh.keyring "${SIGNING_KEYRING}" &&
     ++	(
     ++		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
     ++		do
     ++			git verify-commit --raw $commit 2>actual &&
     ++			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${BAD_SIGNATURE}" actual &&
     ++			echo $commit OK || exit 1
     ++		done
     ++	) &&
     ++	(
     ++		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
     ++		do
     ++			test_must_fail git verify-commit --raw $commit 2>actual &&
     ++			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${BAD_SIGNATURE}" actual &&
     ++			echo $commit OK || exit 1
     ++		done
     ++	) &&
     ++	(
     ++		for commit in eighth-signed-alt
     ++		do
     ++			git verify-commit --raw $commit 2>actual &&
     ++			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     ++			! grep "${BAD_SIGNATURE}" actual &&
     ++			echo $commit OK || exit 1
     ++		done
     ++	)
     ++'
      +
      +test_expect_success GPGSSH 'proper header is used for hash algorithm' '
      +	git cat-file commit fourth-signed >output &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +	FINGERPRINT
      +	principal_1
      +	FINGERPRINT
     -+	
     ++
      +	EOF
      +	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
      +	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +	FINGERPRINT
      +
      +	FINGERPRINT
     -+	
     ++
      +	EOF
      +	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
      +	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
     @@ t/t7527-signed-commit-ssh.sh (new)
      +	test_must_fail git commit -S --amend -m "fail"
      +'
      +
     -+# test_expect_success GPGSSH 'detect fudged commit with double signature' '
     -+# 	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
     -+# 	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
     -+# 		sed -e "s/^$(test_oid header)//;s/^ //" | gpg --dearmor >double-sig1.sig &&
     -+# 	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
     -+# 	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
     -+# 	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/$(test_oid header) /;2,\$s/^/ /" \
     -+# 		double-combined.asc > double-gpgsig &&
     -+# 	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
     -+# 	git hash-object -w -t commit double-commit >double-commit.commit &&
     -+# 	test_must_fail git verify-commit $(cat double-commit.commit) &&
     -+# 	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
     -+# 	grep "BAD signature from" double-actual &&
     -+# 	grep "Good signature from" double-actual
     -+# '
     ++test_expect_failure GPGSSH 'detect fudged commit with double signature (TODO)' '
     ++	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
     ++	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
     ++		sed -e "s/^$(test_oid header)//;s/^ //" | gpg --dearmor >double-sig1.sig &&
     ++	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
     ++	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
     ++	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/$(test_oid header) /;2,\$s/^/ /" \
     ++		double-combined.asc > double-gpgsig &&
     ++	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
     ++	git hash-object -w -t commit double-commit >double-commit.commit &&
     ++	test_must_fail git verify-commit $(cat double-commit.commit) &&
     ++	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
     ++	grep "BAD signature from" double-actual &&
     ++	grep "Good signature from" double-actual
     ++'
      +
     -+# test_expect_success GPGSSH 'show double signature with custom format' '
     -+# 	cat >expect <<-\EOF &&
     -+# 	E
     ++test_expect_failure GPGSSH 'show double signature with custom format (TODO)' '
     ++	cat >expect <<-\EOF &&
     ++	E
      +
      +
      +
      +
     -+# 	EOF
     -+# 	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.commit) >actual &&
     -+# 	test_cmp expect actual
     -+# '
     ++	EOF
     ++	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.commit) >actual &&
     ++	test_cmp expect actual
     ++'
      +
      +
     -+# test_expect_success GPGSSH 'verify-commit verifies multiply signed commits' '
     -+# 	git init multiply-signed &&
     -+# 	cd multiply-signed &&
     -+# 	test_commit first &&
     -+# 	echo 1 >second &&
     -+# 	git add second &&
     -+# 	tree=$(git write-tree) &&
     -+# 	parent=$(git rev-parse HEAD^{commit}) &&
     -+# 	git commit --gpg-sign -m second &&
     -+# 	git cat-file commit HEAD &&
     -+# 	# Avoid trailing whitespace.
     -+# 	sed -e "s/^Q//" -e "s/^Z/ /" >commit <<-EOF &&
     -+# 	Qtree $tree
     -+# 	Qparent $parent
     -+# 	Qauthor A U Thor <author@example.com> 1112912653 -0700
     -+# 	Qcommitter C O Mitter <committer@example.com> 1112912653 -0700
     -+# 	Qgpgsig -----BEGIN PGP SIGNATURE-----
     -+# 	QZ
     -+# 	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBDRYcY29tbWl0dGVy
     -+# 	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMNd+8AoK1I8mhLHviPH+q2I5fIVgPsEtYC
     -+# 	Q AKCTqBh+VabJceXcGIZuF0Ry+udbBQ==
     -+# 	Q =tQ0N
     -+# 	Q -----END PGP SIGNATURE-----
     -+# 	Qgpgsig-sha256 -----BEGIN PGP SIGNATURE-----
     -+# 	QZ
     -+# 	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBIBYcY29tbWl0dGVy
     -+# 	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN/NEAn0XO9RYSBj2dFyozi0JKSbssYMtO
     -+# 	Q AJwKCQ1BQOtuwz//IjU8TiS+6S4iUw==
     -+# 	Q =pIwP
     -+# 	Q -----END PGP SIGNATURE-----
     -+# 	Q
     -+# 	Qsecond
     -+# 	EOF
     -+# 	head=$(git hash-object -t commit -w commit) &&
     -+# 	git reset --hard $head &&
     -+# 	git verify-commit $head 2>actual &&
     -+# 	grep "Good signature from" actual &&
     -+# 	! grep "BAD signature from" actual
     -+# '
     ++test_expect_failure GPGSSH 'verify-commit verifies multiply signed commits (TODO)' '
     ++	git init multiply-signed &&
     ++	cd multiply-signed &&
     ++	test_commit first &&
     ++	echo 1 >second &&
     ++	git add second &&
     ++	tree=$(git write-tree) &&
     ++	parent=$(git rev-parse HEAD^{commit}) &&
     ++	git commit --gpg-sign -m second &&
     ++	git cat-file commit HEAD &&
     ++	# Avoid trailing whitespace.
     ++	sed -e "s/^Q//" -e "s/^Z/ /" >commit <<-EOF &&
     ++	Qtree $tree
     ++	Qparent $parent
     ++	Qauthor A U Thor <author@example.com> 1112912653 -0700
     ++	Qcommitter C O Mitter <committer@example.com> 1112912653 -0700
     ++	Qgpgsig -----BEGIN PGP SIGNATURE-----
     ++	QZ
     ++	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBDRYcY29tbWl0dGVy
     ++	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMNd+8AoK1I8mhLHviPH+q2I5fIVgPsEtYC
     ++	Q AKCTqBh+VabJceXcGIZuF0Ry+udbBQ==
     ++	Q =tQ0N
     ++	Q -----END PGP SIGNATURE-----
     ++	Qgpgsig-sha256 -----BEGIN PGP SIGNATURE-----
     ++	QZ
     ++	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBIBYcY29tbWl0dGVy
     ++	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN/NEAn0XO9RYSBj2dFyozi0JKSbssYMtO
     ++	Q AJwKCQ1BQOtuwz//IjU8TiS+6S4iUw==
     ++	Q =pIwP
     ++	Q -----END PGP SIGNATURE-----
     ++	Q
     ++	Qsecond
     ++	EOF
     ++	head=$(git hash-object -t commit -w commit) &&
     ++	git reset --hard $head &&
     ++	git verify-commit $head 2>actual &&
     ++	grep "Good signature from" actual &&
     ++	! grep "BAD signature from" actual
     ++'
      +
      +test_done
  -:  ----------- >  9:  33330fda441 ssh signing: add more tests for logs, tags & push certs

-- 
gitgitgadget
