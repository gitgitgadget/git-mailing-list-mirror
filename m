Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84117C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674E56069E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 21:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhG1VfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:35:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhG1VfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 17:35:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4E3414AF00;
        Wed, 28 Jul 2021 17:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lg0FO47treap4uhzXUOIA/1n1nGAlweoVAlrbE
        0dVAg=; b=V/vBSs5J/jX35vbo20bJLllVK8Jb4AZEGg+KzrUVXLhxfqta9HhhmR
        UGKh+hF6ldgXwBF51YX5KF4vXo5RQelfjoX09hzWWDBMTOA0grPRIBxI6QiTLP9r
        yZUW3rt1OCmDNuJaSYkSAVteg8TjaA6/ESEe2hx9YBuec7BVy1wL0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBCBA14AEFE;
        Wed, 28 Jul 2021 17:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B98B914AEFB;
        Wed, 28 Jul 2021 17:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v6 4/9] ssh signing: provide a textual representation of
 the signing key
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <7d1d131ff5b43559c8a750ebdfd6faaba93c1ad1.1627501009.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 14:34:56 -0700
In-Reply-To: <7d1d131ff5b43559c8a750ebdfd6faaba93c1ad1.1627501009.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Wed, 28 Jul 2021
        19:36:44 +0000")
Message-ID: <xmqqeebi86m7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7E07AD4-EFEB-11EB-9D6C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fabian Stelzer <fs@gigacodes.de>
>
> for ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
> in push certs and textual output we prefer the ssh fingerprint instead.

These sentences that lack the initial capital letters would look
unusual and distracting in our "git log --no-merges" stream.

> +static char *get_ssh_key_fingerprint(const char *signing_key)
> +{
> +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	struct strbuf fingerprint_stdout = STRBUF_INIT;
> +	struct strbuf **fingerprint;
> +
> +	/*
> +	 * With SSH Signing this can contain a filename or a public key
> +	 * For textual representation we usually want a fingerprint
> +	 */
> +	if (istarts_with(signing_key, "ssh-")) {
> +		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
> +		ret = pipe_command(&ssh_keygen, signing_key,
> +				   strlen(signing_key), &fingerprint_stdout, 0,
> +				   NULL, 0);
> +	} else {
> +		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf",
> +			     configured_signing_key, NULL);
> +		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0,
> +				   NULL, 0);
> +	}
> +
> +	if (!!ret)
> +		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> +			  signing_key);
> +
> +	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
> +	if (!fingerprint[1])
> +		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> +			  signing_key);
> +
> +	return strbuf_detach(fingerprint[1], NULL);
> +}
> +
>  /* Returns the first public key from an ssh-agent to use for signing */
>  static char *get_default_ssh_signing_key(void)
>  {
> @@ -490,6 +525,17 @@ static char *get_default_ssh_signing_key(void)
>  	return "";
>  }
>  
> +/* Returns a textual but unique representation ot the signing key */

"ot" -> "of".

> +const char *get_signing_key_id(void)
> +{
> +	if (!strcmp(use_format->name, "ssh")) {
> +		return get_ssh_key_fingerprint(get_signing_key());
> +	} else {
> +		/* GPG/GPGSM only store a key id on this variable */
> +		return get_signing_key();

Hmph, we could ask gpg key fingerprint if we wanted to, and we
cannot tell why "ssh" side needs a separate "key" and "key_id"
while "gpg" side does not.  Hopefully it will become clear as we
read on?

Again, dispatching on use_format->name looked rather unexpected.

> +	}
> +}
> +
>  const char *get_signing_key(void)
>  {
>  	if (configured_signing_key)
> diff --git a/gpg-interface.h b/gpg-interface.h
> index feac4decf8b..beefacbb1e9 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -64,6 +64,12 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
>  int git_gpg_config(const char *, const char *, void *);
>  void set_signing_key(const char *);
>  const char *get_signing_key(void);
> +
> +/*
> + * Returns a textual unique representation of the signing key in use
> + * Either a GPG KeyID or a SSH Key Fingerprint
> + */
> +const char *get_signing_key_id(void);
>  int check_signature(const char *payload, size_t plen,
>  		    const char *signature, size_t slen,
>  		    struct signature_check *sigc);
> diff --git a/send-pack.c b/send-pack.c
> index 5a79e0e7110..50cca7e439b 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -341,13 +341,13 @@ static int generate_push_cert(struct strbuf *req_buf,
>  {
>  	const struct ref *ref;
>  	struct string_list_item *item;
> -	char *signing_key = xstrdup(get_signing_key());
> +	char *signing_key_id = xstrdup(get_signing_key_id());
>  	const char *cp, *np;
>  	struct strbuf cert = STRBUF_INIT;
>  	int update_seen = 0;
>  
>  	strbuf_addstr(&cert, "certificate version 0.1\n");
> -	strbuf_addf(&cert, "pusher %s ", signing_key);
> +	strbuf_addf(&cert, "pusher %s ", signing_key_id);

Ahh...  We do not send GPG fingerprint in push certificate but you
want to use the fingerprint when signing with SSH keys, and that is
where the need for signing_key_id comes from?

OK.
