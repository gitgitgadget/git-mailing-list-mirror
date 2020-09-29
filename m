Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E171C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2F3207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m8Uo2vjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgI2T70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:59:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61974 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2T70 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 15:59:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2240C7E210;
        Tue, 29 Sep 2020 15:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2BnhkodHH0xQZgOEQcxK/sdZn70=; b=m8Uo2v
        jOcIbDsb2GvhPsHXz2k/EjnrGEKHh7T/Mb7B9TmzBle3i5bEEzcez4dHRqap6ZNY
        QwxP9I+GrSJHYvafUQQNp4VvIy9mYsAzpiIHhDI60t9xBxWWza1b04hynSklYFIx
        HcK89aap05NU5pcAeT+HiLn3CXyWct7ws2QR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V+SLM0WCGKPJdyIm3NB9GpNPHZ/G+veG
        08HdZYEHVEoOeDOtAE11vvajrbp7algze5sK3XeCuRESZATFIhpZ1NXzagNiKM25
        z/+yxCHnWhiU1lHtYCZY/+ftJIWb4BBf4MgEBi7q2jhONZSs9zyIdcyQ8hEXNS+9
        n7ZmSktaiW4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 180397E20F;
        Tue, 29 Sep 2020 15:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BACD7E20D;
        Tue, 29 Sep 2020 15:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 7/7] clone: allow configurable default for
 `-o`/`--origin`
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <737f91c6244220eec196c327fcea9a6548c45310.1601350615.git.gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 12:59:22 -0700
In-Reply-To: <737f91c6244220eec196c327fcea9a6548c45310.1601350615.git.gitgitgadget@gmail.com>
        (Sean Barag via GitGitGadget's message of "Tue, 29 Sep 2020 03:36:55
        +0000")
Message-ID: <xmqqa6x8icbp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 453F3ADC-028E-11EB-B9D2-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  static int git_clone_config(const char *k, const char *v, void *cb)
>  {
> +	if (!strcmp(k, "clone.defaultremotename")) {
> +		if (remote_name != default_remote_name)
> +			free(remote_name);
> +		remote_name = xstrdup(v);

This feels strange.  The usual arrangement is

    - initialize the variable to NULL (or any value that the code
      can tell that nobody touched it);

    - let git_config() callback to update the variable, taking care
      of freeing and strduping as needed.  Note that free(NULL) is
      kosher.

    - let parse_options() to further update the variable, taking
      care of freeing and strduping as needed.

    - finally, if the variable is still NULL, give it its default
      value.

so there is no room for the "if the variable has the value of the
fallback default, do things differently" logic to be in the
git_config() callback function.

> @@ -976,6 +982,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	int submodule_progress;
>  
>  	struct strvec ref_prefixes = STRVEC_INIT;

Missing blank line here.

> +	remote_name = default_remote_name;

Isn't the reason why the git_config() callback we saw above has an
unusual special case for default_remote_name because we have this
assignment way too early?  Would it make the control flow in a more
natural way if we removed this, and then after parse_options() did
the "-o" handling, add something like

	if (!remote_name)
		remote_name = xstrdup("origin");

instead?

> @@ -1153,10 +1154,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	/*
>  	 * re-read config after init_db and write_config to pick up any config
> -	 * injected by --template and --config, respectively
> +	 * injected by --template and --config, respectively.
>  	 */

Squash this "oops, I forgot to finish the sentence" to the step the
mistake was introduced, i.e. "use more conventional..."

>  	git_config(git_clone_config, NULL);
>  
> +	/*
> +	 * apply the remote name provided by --origin only after this second
> +	 * call to git_config, to ensure it overrides all config-based values.
> +	 */
> +	if (option_origin)
> +		remote_name = option_origin;

And here would be where you'd fall back

	if (!remote_name)
		remote_name = xstrdup("origin");

Note that you'd need to dup the option_origin for consistency if you
want to free() it at the end.

> +	if (!valid_remote_name(remote_name))
> +		die(_("'%s' is not a valid remote name"), remote_name);
> +
