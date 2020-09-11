Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55375C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F4C221E7
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MCWoGR6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKU1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 16:27:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54175 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKU1F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 16:27:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DD0DECCEA;
        Fri, 11 Sep 2020 16:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eoqXgV+/Vb/PtOHsB7r8G1M5HQk=; b=MCWoGR
        6vBkNERCwCP5+J0m6gSeQvRqh4U8zAE+C0ZXGwqvQVdOZMrd42hoe3ccAIxBCCso
        TuAeK8JnCvgbNtUSzADsep7b3q2CC1d6VfcYQQUsUTw6+yvbpaZ4ciUQ6NNLhWXD
        CgQf659+1jt+95/wKvhFrDGegNwCKL61WYgrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q+I0YDUjUbPoYldqVr68oG+FUv/mXsPm
        WZM0vgVi+ay11pyBYSx0Q6skvt5VSVk1ZDMINtX4Vno1Haq9XrCv1aiMMRjFGX9J
        067flAl0O4d8i9e7SFDDjwQOrtqVKmfoLmspqSff5SSwVxFBhMt02lkBa6usgz6b
        k5q/VKmXhLQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4785FECCE9;
        Fri, 11 Sep 2020 16:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8757DECCE7;
        Fri, 11 Sep 2020 16:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 2/4] clone: call git_config before parse_options
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <51ef776f8523d29dfe03d15f0d1958f5c456c057.1599848727.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 13:26:57 -0700
In-Reply-To: <51ef776f8523d29dfe03d15f0d1958f5c456c057.1599848727.git.gitgitgadget@gmail.com>
        (Sean Barag via GitGitGadget's message of "Fri, 11 Sep 2020 18:25:25
        +0000")
Message-ID: <xmqq5z8knjou.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24E2FB2C-F46D-11EA-81A0-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Barag <sean@barag.org>
>
> While Junio's request [1] was to avoids the unusual  "write config then
> immediately read it" pattern that exists in `cmd_clone`, Johannes
> mentioned that --template can write new config values that aren't
> automatically included in the environment [2]. This requires a config
> re-read after `init_db` is called.
>
> Moving the initial config up does allow settings from config to be
> overwritten by ones provided via CLI options in a more natural way
> though, so that part of Junio's suggestion remains.

The title says what the code does after this change.  The code calls
git_config() before calling parse_options(), but not much in the
proposed log message explains what the patch tries to achieve by
doing so.

The above refers to suggestions but does not describe what problem
the patch is trying to address and what approach is taken to address
it.

> Signed-off-by: Sean Barag <sean@barag.org>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>

Usually these two are spelled Helped-by: in this project, and are
given in chronological order.  People gave input to you and then
finally you send out a signed copy, so your sign-off is placed at
the end of the sequence.

> +static int git_clone_config(const char *k, const char *v, void *cb)
> +{
> +	return git_default_config(k, v, cb);
> +}
> +
>  static int write_one_config(const char *key, const char *value, void *data)
>  {
> +	/*
> +	 * give git_config_default a chance to write config values back to the environment, since
> +	 * git_config_set_multivar_gently only deals with config-file writes
> +	 */

Overlong lines...

> +	int apply_failed = git_default_config(key, value, data);

Not git_clone_config()?  Presumably you'll make git_clone_config()
recognise more variables than git_default_config() does, and the
caller of this helper wants us to recognise "clone.*" that are
ignored by git_default_config() callback, no?

> +	if (apply_failed)
> +		return apply_failed;
> +
>  	return git_config_set_multivar_gently(key,
>  					      value ? value : "true",
>  					      CONFIG_REGEX_NONE, 0);
> @@ -964,6 +977,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	struct strvec ref_prefixes = STRVEC_INIT;
>  
>  	packet_trace_identity("clone");
> +
> +	git_config(git_clone_config, NULL);
> +
>  	argc = parse_options(argc, argv, prefix, builtin_clone_options,
>  			     builtin_clone_usage, 0);
>  
> @@ -1125,9 +1141,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (real_git_dir)
>  		git_dir = real_git_dir;
>  
> +	/*
> +	 * additional config can be injected with -c, make sure it's included
> +	 * after init_db, which clears the entire config environment.
> +	 */
>  	write_config(&option_config);

The comment that explains the location is very much appropriate.

> -	git_config(git_default_config, NULL);
> +	/*
> +	 * re-read config after init_db and write_config to pick up any config
> +	 * injected by --template and --config, respectively
> +	 */
> +	git_config(git_clone_config, NULL);

Does this call read from the freshly written file?

I thought git_config() iterates over the in-core configset that was
read by the first call to git_config(), which in turn calls
git_config_check_init() and calls repo_read_config() only once to
populate the in-core configset, and I suspect we are not clearing
it in between.
