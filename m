Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84571C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAAA60EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhHCNqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhHCNqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D4C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 06:46:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso1812148wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Wy2nJQ+3MnfpiwsyjkT2QBw96A0lOES2fRbW70E2iU=;
        b=mGbGEp2QKsp6EsNXi0VUjIoUxU84v5S+XNYQpYLkENxBquYTvHD3tGB9MYzE/EcSwd
         aF3HkuH1Y1rNfRylsrOs0eBRBL0RsFBR1ZseEqSe6KybEigKnYQGDAj5yCyoPE3Cdfkh
         mzl7Dus5XAvZHSEAMecB3cHJ1k6gYs+EOKUSmU0zWygw7hsuM/U7jeou1Ll3UVek3Ky8
         RuS5uEugtFZRcuB9w6c5MwJavwGrh9ZLn0TVaDol0L9t6kLD4K8BBGEMyu2yNSDC8mpd
         pyHFCtXmOR2ty2D3NRKikgjv510xoUnzaLbCL84wc14HoDyAOxVjAtLXoDsCe571qouR
         WhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3Wy2nJQ+3MnfpiwsyjkT2QBw96A0lOES2fRbW70E2iU=;
        b=Q6MP5IHKdi9G7vvxrDGUCin7+BIp6Kz4HPcyr0nlJ3tHUagd1WCEjxWzxHlg0Yd8Sk
         0Lxb0OPb45lOjoqsL3TrPkS8X2F+qskGTdGsnUvkWhM3QtTrx6egdsy36/lpzUJUaDja
         P8mc2kgcBggVfHNHe3Ld8I6RrNRIRjgCGAb2pndEzA7hlQyh9Q387Zvk1LtABlZx3j/u
         REcCJhGELWGYZ4SOwL12i2p6vUx50CMkdPUO8ZwcJViWDVDdHDgRfexxoVOkNj7svSK4
         OprGXkXSZ0k4i8s9tzE+iVUVEbdirw1vLQ6Swa673rHZNkSiIKkUV2PNl8jsLBRMDRUX
         vx4Q==
X-Gm-Message-State: AOAM531b/dJm5+E92Zn5zrGPS8WEriGbAv87IjSZxxRTeEnQizqSR3GW
        WDwQ0i296J+0ZxF+zKCuilBLBRDfnAc=
X-Google-Smtp-Source: ABdhPJxJFMZwGmbyEnJQgKaG+gGsyXnvpCHiLPC0ZFWcNlz8iaLfcXYt2hPJCuYYhO4jhX52VKk7dg==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr22238076wma.186.1627998361800;
        Tue, 03 Aug 2021 06:46:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm15053991wrs.85.2021.08.03.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:46:00 -0700 (PDT)
Message-Id: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 13:45:49 +0000
Subject: [PATCH v7 0/9] ssh signing: Add commit & tag signing/verification via SSH keys using
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
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

openssh 8.7 will add valid-after, valid-before options to the allowed keys
keyring. This allows us to pass the commit timestamp to the verification
call and make key rollover possible and still be able to verify older
commits. Set valid-after to the current date when adding your key to the
keyring and set valid-before to make it fail if used after a certain date.
Software like gitolite/github or corporate automation can do this
automatically when ssh push keys are addded / removed I will add this
feature in a follow up patch afterwards.

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

v6: fixed tests when using shm output dir

v7:

 * change unknown signing key behavior to fail verify-commit/tag just like
   gpg does
 * add test for unknown signing keys for ssh & gpg
 * made default signing key retrieval configurable
   (gpg.ssh.defaultKeyCommand). We could default this to "ssh-add -L" but
   would risk some users signing with a wrong key
 * die() instead of error in case of incompatible signatures to match
   current BUG() behaviour more
 * various review fixes (early return for config parse, missing free,
   comments)
 * got rid of strcmp("ssh") branches and used format configurable callbacks
   everywhere
 * moved documentation changes into the commits adding the specific
   functionality

The test 'verify-commit verifies multiply signed commits' relies on the
commit/author date that was incremented via test_tick in the inital function
doing all the commits even though it creates its own. This should be reset
or otherwise set to a known state. But I'm not sure how.

Fabian Stelzer (9):
  ssh signing: preliminary refactoring and clean-up
  ssh signing: add test prereqs
  ssh signing: add ssh key format and signing code
  ssh signing: retrieve a default key from ssh-agent
  ssh signing: provide a textual signing_key_id
  ssh signing: verify signatures using ssh-keygen
  ssh signing: duplicate t7510 tests for commits
  ssh signing: tests for logs, tags & push certs
  ssh signing: test that gpg fails for unkown keys

 Documentation/config/gpg.txt     |  45 ++-
 Documentation/config/user.txt    |   7 +
 builtin/receive-pack.c           |   4 +
 fmt-merge-msg.c                  |   6 +-
 gpg-interface.c                  | 571 ++++++++++++++++++++++++++++---
 gpg-interface.h                  |   8 +-
 log-tree.c                       |   8 +-
 pretty.c                         |   4 +-
 send-pack.c                      |   8 +-
 t/lib-gpg.sh                     |  28 ++
 t/t4202-log.sh                   |  23 ++
 t/t5534-push-signed.sh           | 101 ++++++
 t/t7031-verify-tag-signed-ssh.sh | 161 +++++++++
 t/t7510-signed-commit.sh         |  29 +-
 t/t7528-signed-commit-ssh.sh     | 398 +++++++++++++++++++++
 15 files changed, 1335 insertions(+), 66 deletions(-)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh
 create mode 100755 t/t7528-signed-commit-ssh.sh


base-commit: 940fe202adcbf9fa1825c648d97cbe1b90d26aec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v7
Pull-Request: https://github.com/git/git/pull/1041

Range-diff vs v6:

  1:  7c8502c65b8 !  1:  91fd0159e1f ssh signing: preliminary refactoring and clean-up
     @@ gpg-interface.c: static int verify_signed_buffer(const char *payload, size_t pay
      -	parse_gpg_output(sigc);
      +	fmt = get_format_by_sig(signature);
      +	if (!fmt)
     -+		return error(_("bad/incompatible signature '%s'"), signature);
     ++		die(_("bad/incompatible signature '%s'"), signature);
      +
      +	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
      +					   slen);
     @@ gpg-interface.c: const char *get_signing_key(void)
      +}
      +
      +static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     -+		    const char *signing_key)
     ++			  const char *signing_key)
       {
       	struct child_process gpg = CHILD_PROCESS_INIT;
       	int ret;
  6:  18a26ca49e7 !  2:  fe98052a3ea ssh signing: add test prereqs
     @@ Metadata
       ## Commit message ##
          ssh signing: add test prereqs
      
     -    generate some ssh keys and a allowedSignersFile for testing
     +    Generate some ssh keys and a allowedSignersFile for testing
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     @@ t/lib-gpg.sh: test_lazy_prereq RFC1991 '
       	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
       '
       
     ++GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
     ++GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
     ++GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
     ++GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
     ++GPGSSH_KEY_PASSPHRASE="super_secret"
     ++GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
     ++
     ++GPGSSH_GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
     ++GPGSSH_GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
     ++GPGSSH_KEY_NOT_TRUSTED="No principal matched"
     ++GPGSSH_BAD_SIGNATURE="Signature verification failed"
     ++
      +test_lazy_prereq GPGSSH '
      +	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
      +	test $? != 127 || exit 1
     @@ t/lib-gpg.sh: test_lazy_prereq RFC1991 '
      +	test $? = 0 || exit 1;
      +	mkdir -p "${GNUPGHOME}" &&
      +	chmod 0700 "${GNUPGHOME}" &&
     -+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
     -+	echo "\"principal with number 1\" $(cat "${GNUPGHOME}/ed25519_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     -+	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
     -+	echo "\"principal with number 2\" $(cat "${GNUPGHOME}/rsa_2048_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     -+	ssh-keygen -t ed25519 -N "super_secret" -C "git ed25519 encrypted key" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
     -+	echo "\"principal with number 3\" $(cat "${GNUPGHOME}/protected_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     -+	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
     -+	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
     ++	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
     ++	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
     ++	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
     ++	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
     ++	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
     ++	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
     ++	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
      +'
     -+
     -+SIGNING_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
     -+SIGNING_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
     -+SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
     -+SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
     -+SIGNING_KEY_PASSPHRASE="super_secret"
     -+SIGNING_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
     -+
     -+GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
     -+GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
     -+KEY_NOT_TRUSTED="No principal matched"
     -+BAD_SIGNATURE="Signature verification failed"
      +
       sanitize_pgp() {
       	perl -ne '
  2:  f05bab16096 !  3:  80d2d55d22e ssh signing: add ssh signature format and signing using ssh keys
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    ssh signing: add ssh signature format and signing using ssh keys
     +    ssh signing: add ssh key format and signing code
      
     -    implements the actual sign_buffer_ssh operation and move some shared
     +    Implements the actual sign_buffer_ssh operation and move some shared
          cleanup code into a strbuf function
      
          Set gpg.format = ssh and user.signingkey to either a ssh public key
     @@ Commit message
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     + ## Documentation/config/gpg.txt ##
     +@@ Documentation/config/gpg.txt: gpg.program::
     + 
     + gpg.format::
     + 	Specifies which key format to use when signing with `--gpg-sign`.
     +-	Default is "openpgp" and another possible value is "x509".
     ++	Default is "openpgp". Other possible values are "x509", "ssh".
     + 
     + gpg.<format>.program::
     + 	Use this to customize the program used for the signing format you
     + 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
     + 	be used as a legacy synonym for `gpg.openpgp.program`. The default
     +-	value for `gpg.x509.program` is "gpgsm".
     ++	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
     + 
     + gpg.minTrustLevel::
     + 	Specifies a minimum trust level for signature verification.  If
     +
     + ## Documentation/config/user.txt ##
     +@@ Documentation/config/user.txt: user.signingKey::
     + 	commit, you can override the default selection with this variable.
     + 	This option is passed unchanged to gpg's --local-user parameter,
     + 	so you may specify a key using any method that gpg supports.
     ++	If gpg.format is set to "ssh" this can contain the literal ssh public
     ++	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
     ++	corresponds to the private key used for signing. The private key
     ++	needs to be available via ssh-agent. Alternatively it can be set to
     ++	a file containing a private key directly.
     +
       ## gpg-interface.c ##
      @@ gpg-interface.c: static const char *x509_sigs[] = {
       	NULL
     @@ gpg-interface.c: int sign_buffer(struct strbuf *buffer, struct strbuf *signature
      +}
      +
       static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     - 		    const char *signing_key)
     + 			  const char *signing_key)
       {
       	struct child_process gpg = CHILD_PROCESS_INIT;
       	int ret;
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      +				    key_file->filename.buf);
      +			goto out;
      +		}
     -+		ssh_signing_key_file = key_file->filename.buf;
     ++		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
      +	} else {
      +		/* We assume a file */
      +		ssh_signing_key_file = expand_user_path(signing_key, 1);
     @@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf
      +		delete_tempfile(&buffer_file);
      +	strbuf_release(&signer_stderr);
      +	strbuf_release(&ssh_signature_filename);
     ++	FREE_AND_NULL(ssh_signing_key_file);
      +	return ret;
      +}
  3:  071e6173d8e !  4:  83ece42e1de ssh signing: retrieve a default key from ssh-agent
     @@ Metadata
       ## Commit message ##
          ssh signing: retrieve a default key from ssh-agent
      
     -    if user.signingkey is not set and a ssh signature is requested we call
     -    ssh-add -L and use the first key we get
     +    If user.signingkey is not set and a ssh signature is requested we call
     +    gpg.ssh.defaultKeyCommand (typically "ssh-add -L") and use the first key we get
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     + ## Documentation/config/gpg.txt ##
     +@@ Documentation/config/gpg.txt: gpg.minTrustLevel::
     + * `marginal`
     + * `fully`
     + * `ultimate`
     ++
     ++gpg.ssh.defaultKeyCommand:
     ++	This command that will be run when user.signingkey is not set and a ssh
     ++	signature is requested. On successful exit a valid ssh public key is
     ++	expected in the	first line of its output. To automatically use the first
     ++	available key from your ssh-agent set this to "ssh-add -L".
     +
     + ## Documentation/config/user.txt ##
     +@@ Documentation/config/user.txt: user.signingKey::
     + 	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
     + 	corresponds to the private key used for signing. The private key
     + 	needs to be available via ssh-agent. Alternatively it can be set to
     +-	a file containing a private key directly.
     ++	a file containing a private key directly. If not set git will call
     ++	gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the first
     ++	key available.
     +
       ## gpg-interface.c ##
     +@@
     + #include "gpg-interface.h"
     + #include "sigchain.h"
     + #include "tempfile.h"
     ++#include "alias.h"
     + 
     + static char *configured_signing_key;
     ++static const char *ssh_default_key_command;
     + static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
     + 
     + struct gpg_format {
     +@@ gpg-interface.c: struct gpg_format {
     + 				    size_t signature_size);
     + 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
     + 			   const char *signing_key);
     ++	const char *(*get_default_key)(void);
     + };
     + 
     + static const char *openpgp_verify_args[] = {
     +@@ gpg-interface.c: static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
     + static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
     + 			   const char *signing_key);
     + 
     ++static const char *get_default_ssh_signing_key(void);
     ++
     + static struct gpg_format gpg_format[] = {
     + 	{
     + 		.name = "openpgp",
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.sigs = openpgp_sigs,
     + 		.verify_signed_buffer = verify_gpg_signed_buffer,
     + 		.sign_buffer = sign_buffer_gpg,
     ++		.get_default_key = NULL,
     + 	},
     + 	{
     + 		.name = "x509",
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.sigs = x509_sigs,
     + 		.verify_signed_buffer = verify_gpg_signed_buffer,
     + 		.sign_buffer = sign_buffer_gpg,
     ++		.get_default_key = NULL,
     + 	},
     + 	{
     + 		.name = "ssh",
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.verify_args = ssh_verify_args,
     + 		.sigs = ssh_sigs,
     + 		.verify_signed_buffer = NULL, /* TODO */
     +-		.sign_buffer = sign_buffer_ssh
     ++		.sign_buffer = sign_buffer_ssh,
     ++		.get_default_key = get_default_ssh_signing_key,
     + 	},
     + };
     + 
     +@@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     + 		return 0;
     + 	}
     + 
     ++	if (!strcmp(var, "gpg.ssh.defaultkeycommand")) {
     ++		if (!value)
     ++			return config_error_nonbool(var);
     ++		return git_config_string(&ssh_default_key_command, var, value);
     ++	}
     ++
     + 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
     + 		fmtname = "openpgp";
     + 
      @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
       	return 0;
       }
       
      +/* Returns the first public key from an ssh-agent to use for signing */
     -+static char *get_default_ssh_signing_key(void)
     ++static const char *get_default_ssh_signing_key(void)
      +{
     -+	struct child_process ssh_add = CHILD_PROCESS_INIT;
     ++	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
      +	int ret = -1;
     -+	struct strbuf key_stdout = STRBUF_INIT;
     ++	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
      +	struct strbuf **keys;
     ++	char *key_command = NULL;
     ++	const char **argv;
     ++	int n;
     ++	char *default_key = NULL;
     ++
     ++	if (!ssh_default_key_command)
     ++		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
     ++
     ++	key_command = xstrdup(ssh_default_key_command);
     ++	n = split_cmdline(key_command, &argv);
     ++
     ++	if (n < 0)
     ++		die("malformed build-time gpg.ssh.defaultKeyCommand: %s",
     ++		    split_cmdline_strerror(n));
     ++
     ++	strvec_pushv(&ssh_default_key.args, argv);
     ++	ret = pipe_command(&ssh_default_key, NULL, 0, &key_stdout, 0,
     ++			   &key_stderr, 0);
      +
     -+	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
     -+	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
      +	if (!ret) {
      +		keys = strbuf_split_max(&key_stdout, '\n', 2);
     -+		if (keys[0])
     -+			return strbuf_detach(keys[0], NULL);
     ++		if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
     ++			default_key = strbuf_detach(keys[0], NULL);
     ++		} else {
     ++			warning(_("gpg.ssh.defaultKeycommand succeeded but returned no keys: %s %s"),
     ++				key_stderr.buf, key_stdout.buf);
     ++		}
     ++
     ++		strbuf_list_free(keys);
     ++	} else {
     ++		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
     ++			key_stderr.buf, key_stdout.buf);
      +	}
      +
     ++	free(key_command);
     ++	free(argv);
      +	strbuf_release(&key_stdout);
     -+	return "";
     ++
     ++	return default_key;
      +}
      +
       const char *get_signing_key(void)
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
       	if (configured_signing_key)
       		return configured_signing_key;
      -	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		return get_default_ssh_signing_key();
     -+	} else {
     -+		return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
     ++	if (use_format->get_default_key) {
     ++		return use_format->get_default_key();
      +	}
     ++
     ++	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
       }
       
       int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
  4:  7d1d131ff5b !  5:  76bc9eb4079 ssh signing: provide a textual representation of the signing key
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    ssh signing: provide a textual representation of the signing key
     +    ssh signing: provide a textual signing_key_id
      
     -    for ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
     -    in push certs and textual output we prefer the ssh fingerprint instead.
     +    For ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
     +    In push certs and textual output we prefer the ssh fingerprint instead.
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
       ## gpg-interface.c ##
     +@@ gpg-interface.c: struct gpg_format {
     + 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
     + 			   const char *signing_key);
     + 	const char *(*get_default_key)(void);
     ++	const char *(*get_key_id)(void);
     + };
     + 
     + static const char *openpgp_verify_args[] = {
     +@@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
     + 
     + static const char *get_default_ssh_signing_key(void);
     + 
     ++static const char *get_ssh_key_id(void);
     ++
     + static struct gpg_format gpg_format[] = {
     + 	{
     + 		.name = "openpgp",
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.verify_signed_buffer = verify_gpg_signed_buffer,
     + 		.sign_buffer = sign_buffer_gpg,
     + 		.get_default_key = NULL,
     ++		.get_key_id = NULL,
     + 	},
     + 	{
     + 		.name = "x509",
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.verify_signed_buffer = verify_gpg_signed_buffer,
     + 		.sign_buffer = sign_buffer_gpg,
     + 		.get_default_key = NULL,
     ++		.get_key_id = NULL,
     + 	},
     + 	{
     + 		.name = "ssh",
     +@@ gpg-interface.c: static struct gpg_format gpg_format[] = {
     + 		.verify_signed_buffer = NULL, /* TODO */
     + 		.sign_buffer = sign_buffer_ssh,
     + 		.get_default_key = get_default_ssh_signing_key,
     ++		.get_key_id = get_ssh_key_id,
     + 	},
     + };
     + 
      @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
       	return 0;
       }
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
      +	 * With SSH Signing this can contain a filename or a public key
      +	 * For textual representation we usually want a fingerprint
      +	 */
     -+	if (istarts_with(signing_key, "ssh-")) {
     ++	if (starts_with(signing_key, "ssh-")) {
      +		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
      +		ret = pipe_command(&ssh_keygen, signing_key,
      +				   strlen(signing_key), &fingerprint_stdout, 0,
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
      +}
      +
       /* Returns the first public key from an ssh-agent to use for signing */
     - static char *get_default_ssh_signing_key(void)
     + static const char *get_default_ssh_signing_key(void)
       {
     -@@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
     - 	return "";
     +@@ gpg-interface.c: static const char *get_default_ssh_signing_key(void)
     + 	return default_key;
       }
       
     -+/* Returns a textual but unique representation ot the signing key */
     ++static const char *get_ssh_key_id(void) {
     ++	return get_ssh_key_fingerprint(get_signing_key());
     ++}
     ++
     ++/* Returns a textual but unique representation of the signing key */
      +const char *get_signing_key_id(void)
      +{
     -+	if (!strcmp(use_format->name, "ssh")) {
     -+		return get_ssh_key_fingerprint(get_signing_key());
     -+	} else {
     -+		/* GPG/GPGSM only store a key id on this variable */
     -+		return get_signing_key();
     ++	if (use_format->get_key_id) {
     ++		return use_format->get_key_id();
      +	}
     ++
     ++	/* GPG/GPGSM only store a key id on this variable */
     ++	return get_signing_key();
      +}
      +
       const char *get_signing_key(void)
  5:  725764018ce !  6:  dc092c79796 ssh signing: parse ssh-keygen output and verify signatures
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    ssh signing: parse ssh-keygen output and verify signatures
     +    ssh signing: verify signatures using ssh-keygen
      
     -    to verify a ssh signature we first call ssh-keygen -Y find-principal to
     +    To verify a ssh signature we first call ssh-keygen -Y find-principal to
          look up the signing principal by their public key from the
          allowedSignersFile. If the key is found then we do a verify. Otherwise
          we only validate the signature but can not verify the signers identity.
     @@ Commit message
          SIGNERS") which contains valid public keys and a principal (usually
          user@domain). Depending on the environment this file can be managed by
          the individual developer or for example generated by the central
     -    repository server from known ssh keys with push access. If the
     -    repository only allows signed commits / pushes then the file can even be
     -    stored inside it.
     +    repository server from known ssh keys with push access. This file is usually
     +    stored outside the repository, but if the repository only allows signed
     +    commits/pushes, the user might choose to store it in the repository.
      
          To revoke a key put the public key without the principal prefix into
          gpg.ssh.revocationKeyring or generate a KRL (see ssh-keygen(1)
     @@ Commit message
          Using SSH CA Keys with these files is also possible. Add
          "cert-authority" as key option between the principal and the key to mark
          it as a CA and all keys signed by it as valid for this CA.
     +    See "CERTIFICATES" in ssh-keygen(1).
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     + ## Documentation/config/gpg.txt ##
     +@@ Documentation/config/gpg.txt: gpg.ssh.defaultKeyCommand:
     + 	signature is requested. On successful exit a valid ssh public key is
     + 	expected in the	first line of its output. To automatically use the first
     + 	available key from your ssh-agent set this to "ssh-add -L".
     ++
     ++gpg.ssh.allowedSignersFile::
     ++	A file containing ssh public keys which you are willing to trust.
     ++	The file consists of one or more lines of principals followed by an ssh
     ++	public key.
     ++	e.g.: user1@example.com,user2@example.com ssh-rsa AAAAX1...
     ++	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
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
     ++
     ++gpg.ssh.revocationFile::
     ++	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
     ++	See ssh-keygen(1) for details.
     ++	If a public key is found in this file then it will always be treated
     ++	as having trust level "never" and signatures will show as invalid.
     +
       ## builtin/receive-pack.c ##
      @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const char *value, void *cb)
       {
       	int status = parse_hide_refs_config(var, value, "receive");
       
     -+	git_gpg_config(var, value, NULL);
     ++	if (status)
     ++		return status;
      +
     ++	status = git_gpg_config(var, value, NULL);
       	if (status)
       		return status;
       
     @@ gpg-interface.c
       #include "gpg-interface.h"
       #include "sigchain.h"
       #include "tempfile.h"
     + #include "alias.h"
       
       static char *configured_signing_key;
     -+static const char *ssh_allowed_signers, *ssh_revocation_file;
     +-static const char *ssh_default_key_command;
     ++static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_revocation_file;
       static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
       
       struct gpg_format {
     @@ gpg-interface.c: static struct gpg_format gpg_format[] = {
       		.sigs = ssh_sigs,
      -		.verify_signed_buffer = NULL, /* TODO */
      +		.verify_signed_buffer = verify_ssh_signed_buffer,
     - 		.sign_buffer = sign_buffer_ssh
     - 	},
     - };
     + 		.sign_buffer = sign_buffer_ssh,
     + 		.get_default_key = get_default_ssh_signing_key,
     + 		.get_key_id = get_ssh_key_id,
      @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sigc,
       	return ret;
       }
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +static void parse_ssh_output(struct signature_check *sigc)
      +{
      +	const char *line, *principal, *search;
     ++	char *key = NULL;
      +
      +	/*
     -+	 * ssh-keysign output should be:
     ++	 * ssh-keygen output should be:
      +	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
     -+	 * Good "git" signature for PRINCIPAL WITH WHITESPACE with RSA key SHA256:FINGERPRINT
     ++	 *
      +	 * or for valid but unknown keys:
      +	 * Good "git" signature with RSA key SHA256:FINGERPRINT
     ++	 *
     ++	 * Note that "PRINCIPAL" can contain whitespace, "RSA" and
     ++	 * "SHA256" part could be a different token that names of
     ++	 * the algorithms used, and "FINGERPRINT" is a hexadecimal
     ++	 * string.  By finding the last occurence of " with ", we can
     ++	 * reliably parse out the PRINCIPAL.
      +	 */
      +	sigc->result = 'B';
      +	sigc->trust_level = TRUST_NEVER;
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +				line = search + 1;
      +		} while (search != NULL);
      +		sigc->signer = xmemdupz(principal, line - principal - 1);
     -+		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
     -+		sigc->key = xstrdup(sigc->fingerprint);
      +	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) {
      +		/* Valid signature, but key unknown */
      +		sigc->result = 'G';
      +		sigc->trust_level = TRUST_UNDEFINED;
     ++	} else {
     ++		return;
     ++	}
     ++
     ++	key = strstr(line, "key");
     ++	if (key) {
      +		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
      +		sigc->key = xstrdup(sigc->fingerprint);
     ++	} else {
     ++		/*
     ++		 * Output did not match what we expected
     ++		 * Treat the signature as bad
     ++		 */
     ++		sigc->result = 'B';
      +	}
      +}
      +
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +		goto out;
      +	}
      +	if (ret || !ssh_keygen_out.len) {
     -+		/* We did not find a matching principal in the allowedSigners - Check
     -+		 * without validation */
     ++		/*
     ++		 * We did not find a matching principal in the allowedSigners
     ++		 * Check without validation
     ++		 */
      +		child_process_init(&ssh_keygen);
      +		strvec_pushl(&ssh_keygen.args, fmt->program,
      +			     "-Y", "check-novalidate",
      +			     "-n", "git",
      +			     "-s", buffer_file->filename.buf,
      +			     NULL);
     -+		ret = pipe_command(&ssh_keygen, payload, payload_size,
     ++		pipe_command(&ssh_keygen, payload, payload_size,
      +				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
     ++
     ++		/*
     ++		 * Fail on unknown keys
     ++		 * we still call check-novalidate to display the signature info
     ++		 */
     ++		ret = -1;
      +	} else {
      +		/* Check every principal we found (one per line) */
      +		for (line = ssh_keygen_out.buf; *line;
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +			strbuf_release(&ssh_keygen_out);
      +			strbuf_release(&ssh_keygen_err);
      +			strvec_push(&ssh_keygen.args, fmt->program);
     -+			/* We found principals - Try with each until we find a
     -+			 * match */
     ++			/*
     ++			 * We found principals
     ++			 * Try with each until we find a match
     ++			 */
      +			strvec_pushl(&ssh_keygen.args, "-Y", "verify",
      +				     "-n", "git",
      +				     "-f", ssh_allowed_signers,
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +
      +			FREE_AND_NULL(principal);
      +
     -+			ret &= starts_with(ssh_keygen_out.buf, "Good");
     -+			if (ret == 0)
     ++			if (!ret)
     ++				ret = !starts_with(ssh_keygen_out.buf, "Good");
     ++
     ++			if (!ret)
      +				break;
      +		}
      +	}
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
       	size_t slen, struct signature_check *sigc)
       {
      @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
     - 		return 0;
     + 		return git_config_string(&ssh_default_key_command, var, value);
       	}
       
      +	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
      +		return git_config_string(&ssh_allowed_signers, var, value);
      +	}
      +
     -+	if (!strcmp(var, "gpg.ssh.revocationFile")) {
     ++	if (!strcmp(var, "gpg.ssh.revocationfile")) {
      +		if (!value)
      +			return config_error_nonbool(var);
      +		return git_config_string(&ssh_revocation_file, var, value);
  7:  01da9a07934 !  7:  c17441566d9 ssh signing: duplicate t7510 tests for commits
     @@ t/t7528-signed-commit-ssh.sh (new)
      +
      +	test_when_finished "test_unconfig commit.gpgsign" &&
      +	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
      +
      +	echo 1 >file && git add file &&
      +	test_tick && git commit -S -m initial &&
     @@ t/t7528-signed-commit-ssh.sh (new)
      +	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
      +	git tag seventh-signed &&
      +
     -+	echo 8 >file && test_tick && git commit -a -m eighth -S"${SIGNING_KEY_UNTRUSTED}" &&
     ++	echo 8 >file && test_tick && git commit -a -m eighth -S"${GPGSSH_KEY_UNTRUSTED}" &&
      +	git tag eighth-signed-alt &&
      +
      +	# commit.gpgsign is still on but this must not be signed
     @@ t/t7528-signed-commit-ssh.sh (new)
      +	echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
      +	test_line_count = 1 oid &&
      +	git tag eleventh-signed $(cat oid) &&
     -+	echo 12 | git commit-tree --gpg-sign="${SIGNING_KEY_UNTRUSTED}" HEAD^{tree} >oid &&
     ++	echo 12 | git commit-tree --gpg-sign="${GPGSSH_KEY_UNTRUSTED}" HEAD^{tree} >oid &&
      +	test_line_count = 1 oid &&
      +	git tag twelfth-signed-alt $(cat oid)
      +'
      +
      +test_expect_success GPGSSH 'verify and show signatures' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	test_config gpg.mintrustlevel UNDEFINED &&
      +	(
      +		for commit in initial second merge fourth-signed \
     @@ t/t7528-signed-commit-ssh.sh (new)
      +		do
      +			git verify-commit $commit &&
      +			git show --pretty=short --show-signature $commit >actual &&
     -+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	) &&
     @@ t/t7528-signed-commit-ssh.sh (new)
      +		do
      +			test_must_fail git verify-commit $commit &&
      +			git show --pretty=short --show-signature $commit >actual &&
     -+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	) &&
     @@ t/t7528-signed-commit-ssh.sh (new)
      +		for commit in eighth-signed-alt twelfth-signed-alt
      +		do
      +			git show --pretty=short --show-signature $commit >actual &&
     -+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			grep "${KEY_NOT_TRUSTED}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	)
      +'
      +
     -+test_expect_success GPGSSH 'verify-commit exits success on untrusted signature' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     -+	git verify-commit eighth-signed-alt 2>actual &&
     -+	grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     -+	! grep "${BAD_SIGNATURE}" actual &&
     ++test_expect_success GPGSSH 'verify-commit exits failure on untrusted signature' '
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     ++	test_must_fail git verify-commit eighth-signed-alt 2>actual &&
     ++	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
     ++	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +	grep "${KEY_NOT_TRUSTED}" actual
      +'
      +
      +test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	test_config gpg.minTrustLevel fully &&
      +	git verify-commit sixth-signed
      +'
      +
      +test_expect_success GPGSSH 'verify-commit exits success with low minTrustLevel' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	test_config gpg.minTrustLevel marginal &&
      +	git verify-commit sixth-signed
      +'
     @@ t/t7528-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'verify signatures with --raw' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	(
      +		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
      +		do
      +			git verify-commit --raw $commit 2>actual &&
     -+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	) &&
     @@ t/t7528-signed-commit-ssh.sh (new)
      +		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
      +		do
      +			test_must_fail git verify-commit --raw $commit 2>actual &&
     -+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	) &&
      +	(
      +		for commit in eighth-signed-alt
      +		do
     -+			git verify-commit --raw $commit 2>actual &&
     -+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			test_must_fail git verify-commit --raw $commit 2>actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	)
     @@ t/t7528-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show signed commit with signature' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git show -s initial >commit &&
      +	git show -s --show-signature initial >show &&
      +	git verify-commit -v initial >verify.1 2>verify.2 &&
      +	git cat-file commit initial >cat &&
     -+	grep -v -e "${GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.commit &&
     -+	grep -e "${GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.gpg &&
     ++	grep -v -e "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.commit &&
     ++	grep -e "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" -e "Warning: " show >show.gpg &&
      +	grep -v "^ " cat | grep -v "^gpgsig.* " >cat.commit &&
      +	test_cmp show.commit commit &&
      +	test_cmp show.gpg verify.2 &&
     @@ t/t7528-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'detect fudged signature' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git cat-file commit seventh-signed >raw &&
      +	sed -e "s/^seventh/7th forged/" raw >forged1 &&
      +	git hash-object -w -t commit forged1 >forged1.commit &&
      +	test_must_fail git verify-commit $(cat forged1.commit) &&
      +	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
     -+	grep "${BAD_SIGNATURE}" actual1 &&
     -+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual1 &&
     -+	! grep "${GOOD_SIGNATURE_UNTRUSTED}" actual1
     ++	grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
     ++	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
     ++	! grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
      +'
      +
      +test_expect_success GPGSSH 'detect fudged signature with NUL' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git cat-file commit seventh-signed >raw &&
      +	cat raw >forged2 &&
      +	echo Qwik | tr "Q" "\000" >>forged2 &&
      +	git hash-object -w -t commit forged2 >forged2.commit &&
      +	test_must_fail git verify-commit $(cat forged2.commit) &&
      +	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
     -+	grep "${BAD_SIGNATURE}" actual2 &&
     -+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual2
     ++	grep "${GPGSSH_BAD_SIGNATURE}" actual2 &&
     ++	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual2
      +'
      +
      +test_expect_success GPGSSH 'amending already signed commit' '
      +	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git checkout fourth-signed^0 &&
      +	git commit --amend -S --no-edit &&
      +	git verify-commit HEAD &&
      +	git show -s --show-signature HEAD >actual &&
     -+	grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+	! grep "${BAD_SIGNATURE}" actual
     ++	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++	! grep "${GPGSSH_BAD_SIGNATURE}" actual
      +'
      +
      +test_expect_success GPGSSH 'show good signature with custom format' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     ++	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
      +	cat >expect.tmpl <<-\EOF &&
      +	G
      +	FINGERPRINT
     @@ t/t7528-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show bad signature with custom format' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	cat >expect <<-\EOF &&
      +	B
      +
     @@ t/t7528-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'show untrusted signature with custom format' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	cat >expect.tmpl <<-\EOF &&
      +	U
      +	FINGERPRINT
     @@ t/t7528-signed-commit-ssh.sh (new)
      +
      +	EOF
      +	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
     ++	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
      +	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success GPGSSH 'show untrusted signature with undefined trust level' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	cat >expect.tmpl <<-\EOF &&
      +	undefined
      +	FINGERPRINT
     @@ t/t7528-signed-commit-ssh.sh (new)
      +
      +	EOF
      +	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
     ++	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_UNTRUSTED}" | awk "{print \$2;}") &&
      +	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success GPGSSH 'show untrusted signature with ultimate trust level' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	cat >expect.tmpl <<-\EOF &&
      +	fully
      +	FINGERPRINT
     @@ t/t7528-signed-commit-ssh.sh (new)
      +
      +	EOF
      +	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
     ++	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
      +	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
      +	test_cmp expect actual
      +'
     @@ t/t7528-signed-commit-ssh.sh (new)
      +'
      +
      +test_expect_success GPGSSH 'log.showsignature behaves like --show-signature' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	test_config log.showsignature true &&
      +	git show initial >actual &&
     -+	grep "${GOOD_SIGNATURE_TRUSTED}" actual
     ++	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
      +'
      +
      +test_expect_success GPGSSH 'check config gpg.format values' '
      +	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
      +	test_config gpg.format ssh &&
      +	git commit -S --amend -m "success" &&
      +	test_config gpg.format OpEnPgP &&
  8:  d9707443f5c !  8:  0763517d62d ssh signing: add more tests for logs, tags & push certs
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    ssh signing: add more tests for logs, tags & push certs
     +    ssh signing: tests for logs, tags & push certs
      
          Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
      
     @@ t/t4202-log.sh: test_expect_success GPGSM 'setup signed branch x509' '
       
      +test_expect_success GPGSSH 'setup sshkey signed branch' '
      +	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
      +	test_when_finished "git reset --hard && git checkout main" &&
      +	git checkout -b signed-ssh main &&
      +	echo foo >foo &&
     @@ t/t4202-log.sh: test_expect_success GPGSM 'log OpenPGP fingerprint' '
       '
       
      +test_expect_success GPGSSH 'log ssh key fingerprint' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     -+	ssh-keygen -lf  "${SIGNING_KEY_PRIMARY}" | awk "{print \$2\" | \"}" >expect &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     ++	ssh-keygen -lf  "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2\" | \"}" >expect &&
      +	git log -n1 --format="%GF | %GP" signed-ssh >actual &&
      +	test_cmp expect actual
      +'
     @@ t/t4202-log.sh: test_expect_success GPGSM 'log --graph --show-signature x509' '
       '
       
      +test_expect_success GPGSSH 'log --graph --show-signature ssh' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git log --graph --show-signature -n1 signed-ssh >actual &&
      +	grep "${GOOD_SIGNATURE_TRUSTED}" actual
      +'
     @@ t/t5534-push-signed.sh: test_expect_success GPG 'signed push sends push certific
      +test_expect_success GPGSSH 'ssh signed push sends push certificate' '
      +	prepare_dst &&
      +	mkdir -p dst/.git/hooks &&
     -+	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	git -C dst config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git -C dst config receive.certnonceseed sekrit &&
      +	write_script dst/.git/hooks/post-receive <<-\EOF &&
      +	# discard the update list
     @@ t/t5534-push-signed.sh: test_expect_success GPG 'signed push sends push certific
      +	EOF
      +
      +	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
     ++	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
      +	git push --signed dst noop ff +noff &&
      +
      +	(
     @@ t/t5534-push-signed.sh: test_expect_success GPGSM 'fail without key and heed use
      +	test_config gpg.format ssh &&
      +	prepare_dst &&
      +	mkdir -p dst/.git/hooks &&
     -+	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	git -C dst config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git -C dst config receive.certnonceseed sekrit &&
      +	write_script dst/.git/hooks/post-receive <<-\EOF &&
      +	# discard the update list
     @@ t/t5534-push-signed.sh: test_expect_success GPGSM 'fail without key and heed use
      +		sane_unset GIT_COMMITTER_EMAIL &&
      +		test_must_fail git push --signed dst noop ff +noff
      +	) &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     -+	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
     ++	FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk "{print \$2;}") &&
      +	git push --signed dst noop ff +noff &&
      +
      +	(
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +test_expect_success GPGSSH 'create signed tags ssh' '
      +	test_when_finished "test_unconfig commit.gpgsign" &&
      +	test_config gpg.format ssh &&
     -+	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
     ++	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
      +
      +	echo 1 >file && git add file &&
      +	test_tick && git commit -m initial &&
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +	git tag -m seventh -s seventh-signed &&
      +
      +	echo 8 >file && test_tick && git commit -a -m eighth &&
     -+	git tag -u"${SIGNING_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
     ++	git tag -u"${GPGSSH_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
      +'
      +
      +test_expect_success GPGSSH 'verify and show ssh signatures' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	(
      +		for tag in initial second merge fourth-signed sixth-signed seventh-signed
      +		do
      +			git verify-tag $tag 2>actual &&
     -+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $tag OK || exit 1
      +		done
      +	) &&
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
      +		do
      +			test_must_fail git verify-tag $tag 2>actual &&
     -+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $tag OK || exit 1
      +		done
      +	) &&
      +	(
      +		for tag in eighth-signed-alt
      +		do
     -+			git verify-tag $tag 2>actual &&
     -+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     -+			grep "${KEY_NOT_TRUSTED}" actual &&
     ++			test_must_fail git verify-tag $tag 2>actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
     ++			grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
      +			echo $tag OK || exit 1
      +		done
      +	)
      +'
      +
      +test_expect_success GPGSSH 'detect fudged ssh signature' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git cat-file tag seventh-signed >raw &&
      +	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
      +	git hash-object -w -t tag forged1 >forged1.tag &&
      +	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
     -+	grep "${BAD_SIGNATURE}" actual1 &&
     -+	! grep "${GOOD_SIGNATURE_TRUSTED}" actual1 &&
     -+	! grep "${GOOD_SIGNATURE_UNTRUSTED}" actual1
     ++	grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
     ++	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
     ++	! grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
      +'
      +
      +test_expect_success GPGSSH 'verify ssh signatures with --raw' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	(
      +		for tag in initial second merge fourth-signed sixth-signed seventh-signed
      +		do
      +			git verify-tag --raw $tag 2>actual &&
     -+			grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $tag OK || exit 1
      +		done
      +	) &&
     @@ t/t7031-verify-tag-signed-ssh.sh (new)
      +		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
      +		do
      +			test_must_fail git verify-tag --raw $tag 2>actual &&
     -+			! grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $tag OK || exit 1
      +		done
      +	) &&
      +	(
      +		for tag in eighth-signed-alt
      +		do
     -+			git verify-tag --raw $tag 2>actual &&
     -+			grep "${GOOD_SIGNATURE_UNTRUSTED}" actual &&
     -+			! grep "${BAD_SIGNATURE}" actual &&
     ++			test_must_fail git verify-tag --raw $tag 2>actual &&
     ++			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
     ++			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +			echo $tag OK || exit 1
      +		done
      +	)
      +'
      +
      +test_expect_success GPGSSH 'verify signatures with --raw ssh' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	git verify-tag --raw sixth-signed 2>actual &&
     -+	grep "${GOOD_SIGNATURE_TRUSTED}" actual &&
     -+	! grep "${BAD_SIGNATURE}" actual &&
     ++	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     ++	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
      +	echo sixth-signed OK
      +'
      +
      +test_expect_success GPGSSH 'verify multiple tags ssh' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	tags="seventh-signed sixth-signed" &&
      +	for i in $tags
      +	do
      +		git verify-tag -v --raw $i || return 1
      +	done >expect.stdout 2>expect.stderr.1 &&
     -+	grep "^${GOOD_SIGNATURE_TRUSTED}" <expect.stderr.1 >expect.stderr &&
     ++	grep "^${GPGSSH_GOOD_SIGNATURE_TRUSTED}" <expect.stderr.1 >expect.stderr &&
      +	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
     -+	grep "^${GOOD_SIGNATURE_TRUSTED}" <actual.stderr.1 >actual.stderr &&
     ++	grep "^${GPGSSH_GOOD_SIGNATURE_TRUSTED}" <actual.stderr.1 >actual.stderr &&
      +	test_cmp expect.stdout actual.stdout &&
      +	test_cmp expect.stderr actual.stderr
      +'
      +
      +test_expect_success GPGSSH 'verifying tag with --format - ssh' '
     -+	test_config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
     ++	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
      +	cat >expect <<-\EOF &&
      +	tagname : fourth-signed
      +	EOF
  9:  275af516eba <  -:  ----------- ssh signing: add documentation
  -:  ----------- >  9:  a5add98197a ssh signing: test that gpg fails for unkown keys

-- 
gitgitgadget
