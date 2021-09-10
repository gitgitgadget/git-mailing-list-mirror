Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7DAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A16611EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhIJUI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhIJUI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:08:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56EC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t18so4296932wrb.0
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pQqugpku2xxjiYxuYMBKanWWBvkHhgXYN+FjSPHWdDU=;
        b=KQy5v6S37m+r2r8pz80jFrTOqfCTqFXCEF44lG6vDyfqCrZ5RQTISTscIHLbwFKLL0
         uEcT7nhzGQpjmEkpHD4W7/6V23sOcdx8tBB5y9uQZ7x/TqRwYVozujeLJyjOCag2nWbo
         yAgvNn9S1bEYbSMzWoLU/Fx479lRCGzvn5AwNQGfoW97F2F8pl6RGsTl+Rkx/pfvWvbJ
         rL9GeO2zI0T2jDwTyRn4MoW0Fg0kbdapRIQj5bshMiDiarIuGtXJuqqEFYG107rjQIWz
         Gryj1a2i1lwbx15VMVRJAoc1uJQJYdHCdjZFlelDcamIc4G+9pUy8C7NgGQLeyIQ6234
         tR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pQqugpku2xxjiYxuYMBKanWWBvkHhgXYN+FjSPHWdDU=;
        b=3oSotTJmeGhTuRPpAoTG5n9V5/pwKhYGOspZBnY0B3ynOv5BHg4eqCSmNw4B3f4VuU
         jvIjPKAPpH/hKcAlS8PSs1TeQpwvTX4Nh707nxvPiwSkcI5M0QRDIRlvTYYoSFp+VVB2
         Ix6GjkcgMCSJoUYhRnHrR66o2sa5UzFrsh+23aDLkJrOoVYJ8VPB+WaGq7501MlD1meS
         jQuEmHwVPAz3qangKWg2TwxfPOaBIevakxCBRvCeyF9nmIWVvwM+yku6/W2UkuVTUjcB
         U2nM8QfJpsERx26KJdiLMgIulzv1dTfSuANEIaJWUhKmmFUgfP29cZJXggTHsPRH6Zmk
         Di6w==
X-Gm-Message-State: AOAM533rBUWhVlKOBfg5WhysxoOYyLQ/cj7+0MDJ3jEKcpe5VaIFJJIj
        +DrMaLn6eUorQ1xb2jWhbnzj/F7pn3U=
X-Google-Smtp-Source: ABdhPJz4n7wFc4uFrdU6WxA5DK6ppc5fnR+hGspugU1ssbMgdoiUlqidgsnIQlJFQmgphs5+m/WHBA==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr11606232wrq.212.1631304463398;
        Fri, 10 Sep 2021 13:07:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm5539523wmi.23.2021.09.10.13.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:43 -0700 (PDT)
Message-Id: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:33 +0000
Subject: [PATCH v8 0/9] ssh signing: Add commit & tag signing/verification via SSH keys using
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
        Fabian Stelzer <fabian@stelzer.cloud>
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
feature in a follow up patch afterwards since the released 8.7 version has a
broken ssh-keygen implementation which will break ssh signing completely.

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

v8:

 * fixes a bug around find-principals buffer i was releasing while still
   iterating over it. Uses separate strbufs now.
 * rename a wrong variable in the tests
 * use git_config_pathname instead of string where applicable

Fabian Stelzer (9):
  ssh signing: preliminary refactoring and clean-up
  ssh signing: add test prereqs
  ssh signing: add ssh key format and signing code
  ssh signing: retrieve a default key from ssh-agent
  ssh signing: provide a textual signing_key_id
  ssh signing: verify signatures using ssh-keygen
  ssh signing: duplicate t7510 tests for commits
  ssh signing: tests for logs, tags & push certs
  ssh signing: test that gpg fails for unknown keys

 Documentation/config/gpg.txt     |  45 ++-
 Documentation/config/user.txt    |   7 +
 builtin/receive-pack.c           |   4 +
 fmt-merge-msg.c                  |   6 +-
 gpg-interface.c                  | 577 ++++++++++++++++++++++++++++---
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
 15 files changed, 1341 insertions(+), 66 deletions(-)
 create mode 100755 t/t7031-verify-tag-signed-ssh.sh
 create mode 100755 t/t7528-signed-commit-ssh.sh


base-commit: 8463beaeb69fe0b7f651065813def4aa6827cd5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1041%2FFStelzer%2Fsshsign-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1041/FStelzer/sshsign-v8
Pull-Request: https://github.com/git/git/pull/1041

Range-diff vs v7:

  1:  91fd0159e1f =  1:  b0bee197a05 ssh signing: preliminary refactoring and clean-up
  2:  fe98052a3ea =  2:  d08327ecb25 ssh signing: add test prereqs
  3:  80d2d55d22e =  3:  c1e9bba8da0 ssh signing: add ssh key format and signing code
  4:  83ece42e1de =  4:  8c430fc7a1b ssh signing: retrieve a default key from ssh-agent
  5:  76bc9eb4079 =  5:  0864ed04670 ssh signing: provide a textual signing_key_id
  6:  dc092c79796 !  6:  cfd66180249 ssh signing: verify signatures using ssh-keygen
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +	const char *line;
      +	size_t trust_size;
      +	char *principal;
     ++	struct strbuf ssh_principals_out = STRBUF_INIT;
     ++	struct strbuf ssh_principals_err = STRBUF_INIT;
      +	struct strbuf ssh_keygen_out = STRBUF_INIT;
      +	struct strbuf ssh_keygen_err = STRBUF_INIT;
      +
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +		     "-f", ssh_allowed_signers,
      +		     "-s", buffer_file->filename.buf,
      +		     NULL);
     -+	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0,
     -+			   &ssh_keygen_err, 0);
     -+	if (ret && strstr(ssh_keygen_err.buf, "usage:")) {
     ++	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
     ++			   &ssh_principals_err, 0);
     ++	if (ret && strstr(ssh_principals_err.buf, "usage:")) {
      +		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
      +		goto out;
      +	}
     -+	if (ret || !ssh_keygen_out.len) {
     ++	if (ret || !ssh_principals_out.len) {
      +		/*
      +		 * We did not find a matching principal in the allowedSigners
      +		 * Check without validation
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +		ret = -1;
      +	} else {
      +		/* Check every principal we found (one per line) */
     -+		for (line = ssh_keygen_out.buf; *line;
     ++		for (line = ssh_principals_out.buf; *line;
      +		     line = strchrnul(line + 1, '\n')) {
      +			while (*line == '\n')
      +				line++;
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +	sigc->payload = xmemdupz(payload, payload_size);
      +	strbuf_stripspace(&ssh_keygen_out, 0);
      +	strbuf_stripspace(&ssh_keygen_err, 0);
     ++	/* Add stderr outputs to show the user actual ssh-keygen errors */
     ++	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
      +	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
      +	sigc->output = strbuf_detach(&ssh_keygen_out, NULL);
      +	sigc->gpg_status = xstrdup(sigc->output);
     @@ gpg-interface.c: static int verify_gpg_signed_buffer(struct signature_check *sig
      +out:
      +	if (buffer_file)
      +		delete_tempfile(&buffer_file);
     ++	strbuf_release(&ssh_principals_out);
     ++	strbuf_release(&ssh_principals_err);
      +	strbuf_release(&ssh_keygen_out);
      +	strbuf_release(&ssh_keygen_err);
      +
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
      +	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
      +		if (!value)
      +			return config_error_nonbool(var);
     -+		return git_config_string(&ssh_allowed_signers, var, value);
     ++		return git_config_pathname(&ssh_allowed_signers, var, value);
      +	}
      +
      +	if (!strcmp(var, "gpg.ssh.revocationfile")) {
      +		if (!value)
      +			return config_error_nonbool(var);
     -+		return git_config_string(&ssh_revocation_file, var, value);
     ++		return git_config_pathname(&ssh_revocation_file, var, value);
      +	}
      +
       	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
  7:  c17441566d9 !  7:  c8e21dc97f1 ssh signing: duplicate t7510 tests for commits
     @@ t/t7528-signed-commit-ssh.sh (new)
      +			git show --pretty=short --show-signature $commit >actual &&
      +			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
      +			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
     -+			grep "${KEY_NOT_TRUSTED}" actual &&
     ++			grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
      +			echo $commit OK || exit 1
      +		done
      +	)
     @@ t/t7528-signed-commit-ssh.sh (new)
      +	test_must_fail git verify-commit eighth-signed-alt 2>actual &&
      +	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
      +	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
     -+	grep "${KEY_NOT_TRUSTED}" actual
     ++	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
      +'
      +
      +test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
  8:  0763517d62d =  8:  b66e3e0284c ssh signing: tests for logs, tags & push certs
  9:  a5add98197a !  9:  07afb94ed83 ssh signing: test that gpg fails for unkown keys
     @@ Metadata
      Author: Fabian Stelzer <fs@gigacodes.de>
      
       ## Commit message ##
     -    ssh signing: test that gpg fails for unkown keys
     +    ssh signing: test that gpg fails for unknown keys
      
          Test that verify-commit/tag will fail when a gpg key is completely
          unknown. To do this we have to generate a key, use it for a signature

-- 
gitgitgadget
