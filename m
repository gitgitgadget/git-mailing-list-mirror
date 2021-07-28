Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F073361019
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhG1Wpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhG1Wp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 18:45:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D171C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:45:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a17-20020a170902ecd1b029012c22956f93so3115042plh.7
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wPPImtrIFk1G4bGwE7cRsS2VK42RGNwGdhvsyXfxsio=;
        b=Lo9FDDr2yTyccUrDSvmoFU5qpdH57/xncypE33s7yhj74E563ocWwRytJFP7FOwUFh
         NK7T9Wj22hQmbJMRj7FiD8B0tFPVdJP3zrF2PdTU0M8BfvzHBk/UFGIHyHU0NQvv8uuQ
         UAxiHR25VYZAgA3Y/bSpA+8EyioMbSHryBZy1YxRd/net03xWbF/yH8dCncw7LeV2Xnx
         Z3FExQ/WTqj5BOJWuYW6oy6wQ2Wg/EYNgLgjWzfUXLc3O2abOzZViqO9+IG+ff4zrpOe
         MtWEpMAdHEHAWzzcB4TDRcbHJLJ8jlF0/OCcrBSRYuaIjornXMzk2V9+199K6GwU/ayj
         RTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wPPImtrIFk1G4bGwE7cRsS2VK42RGNwGdhvsyXfxsio=;
        b=Gy15PNT6AfVJfUdqdKl90V9pibnG6l8YqWZoG8q2Y9hRAPlxYOgvnLZp+CVAhVcJum
         DMKJDS73m8u2V+x9IS266E5if9MSPNhJet5FsWdxz8sZKmxKYHAoebQpw+OD8MY+PuCN
         c/YGtSTsSJCb5lIR4xmFx7/wVO8jnVpezcKPVnw7Sytoic7T0SJhGRhqBOakEu/9I55l
         fMvGKvLsed7yxYyBR9coyOK6VBt91UEV83cqbQdvn1feFtJLUULFvVzlMGwAbI3W7Qn0
         iG25lwVuzfFrrMU/2AF4BplYMAeGdP3VJmbbyfQr3a6RbMsjJVE1ss2MJgmaPY27RqVe
         R5cQ==
X-Gm-Message-State: AOAM530lXeb/2SjaOzJk/MI3tIWqy2gFMQYMTQhmnskBbsIjiZSbp3D8
        FLUwE1Xqf97pT9uWxnnzkUpFLlnfqYwAgTS6jLzM
X-Google-Smtp-Source: ABdhPJxX0oN28iEQXpn0jLCkfCV89vtRRkv9Ro4VNjvD8Js2M9bnxUR1ba93nJdkDl9u0gAyPC8+HL9LdtZ9F/Kz/L/A
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:189:: with SMTP id
 t9mr625792pjs.1.1627512325756; Wed, 28 Jul 2021 15:45:25 -0700 (PDT)
Date:   Wed, 28 Jul 2021 15:45:23 -0700
In-Reply-To: <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
Message-Id: <20210728224523.2716969-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v6 2/9] ssh signing: add ssh signature format and signing
 using ssh keys
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, fs@gigacodes.de,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the commit titles to 50 characters or fewer. E.g.:

  gpg-interface: teach "ssh" gpg.format

> implements the actual sign_buffer_ssh operation and move some shared
> cleanup code into a strbuf function

Capitalization and punctuation.

> Set gpg.format = ssh and user.signingkey to either a ssh public key
> string (like from an authorized_keys file), or a ssh key file.
> If the key file or the config value itself contains only a public key
> then the private key needs to be available via ssh-agent.
> 
> gpg.ssh.program can be set to an alternative location of ssh-keygen.
> A somewhat recent openssh version (8.2p1+) of ssh-keygen is needed for
> this feature. Since only ssh-keygen is needed it can this way be
> installed seperately without upgrading your system openssh packages.

I notice that end-user documentation (e.g. about gpg.ssh.program) is in
its own patch, but could that be added as functionality is being
implemented? That makes it easier for reviewers to understand what's
being implemented in each patch.

> @@ -463,12 +482,30 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  	return use_format->sign_buffer(buffer, signature, signing_key);
>  }
>  
> +/*
> + * Strip CR from the line endings, in case we are on Windows.
> + * NEEDSWORK: make it trim only CRs before LFs and rename
> + */
> +static void remove_cr_after(struct strbuf *buffer, size_t offset)
> +{
> +	size_t i, j;
> +
> +	for (i = j = offset; i < buffer->len; i++) {
> +		if (buffer->buf[i] != '\r') {
> +			if (i != j)
> +				buffer->buf[j] = buffer->buf[i];
> +			j++;
> +		}
> +	}
> +	strbuf_setlen(buffer, j);
> +}

In the future, I would prefer refactoring like this to be in its own
patch. For the moment, this should probably be called "remove_cr" (no
"after" as CRs are removed wherever they are in the string).

> +static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
> +			   const char *signing_key)
> +{
> +	struct child_process signer = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	size_t bottom, keylen;
> +	struct strbuf signer_stderr = STRBUF_INIT;
> +	struct tempfile *key_file = NULL, *buffer_file = NULL;
> +	char *ssh_signing_key_file = NULL;
> +	struct strbuf ssh_signature_filename = STRBUF_INIT;
> +
> +	if (!signing_key || signing_key[0] == '\0')
> +		return error(
> +			_("user.signingkey needs to be set for ssh signing"));
> +
> +	if (starts_with(signing_key, "ssh-")) {
> +		/* A literal ssh key */
> +		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
> +		if (!key_file)
> +			return error_errno(
> +				_("could not create temporary file"));
> +		keylen = strlen(signing_key);
> +		if (write_in_full(key_file->fd, signing_key, keylen) < 0 ||
> +		    close_tempfile_gently(key_file) < 0) {
> +			error_errno(_("failed writing ssh signing key to '%s'"),
> +				    key_file->filename.buf);
> +			goto out;
> +		}
> +		ssh_signing_key_file = key_file->filename.buf;
> +	} else {
> +		/* We assume a file */
> +		ssh_signing_key_file = expand_user_path(signing_key, 1);
> +	}

A config that has 2 modes of operation is quite error-prone, I think.
For example, a user could put a path starting with "ssh-" (admittedly
unlikely since it would usually be an absolute path, but not
impossible). And also from an implementation point of view, here the
"ssh-" is case-sensitive, but in a future patch, there is a "ssh-" that
is case-insensitive.

Can this just always take a path?

> +	if (ret) {
> +		if (strstr(signer_stderr.buf, "usage:"))
> +			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
> +
> +		error("%s", signer_stderr.buf);
> +		goto out;
> +	}

Checking for "usage:" seems fragile -  a binary running in a different
locale might emit a different string, and legitimate output may somehow
contain the string "usage:". Is there a different way to detect a
version mismatch?
