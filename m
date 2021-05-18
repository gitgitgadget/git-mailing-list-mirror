Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7265C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81CD610A8
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhEROwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:52:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51147 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhEROwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:52:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A671139FC3;
        Tue, 18 May 2021 10:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8tJIFfxrwQNL7LWmOG0OccBPHLz8ygHV1ql5XH
        YGAoE=; b=PQHvISfIjZ8pmeipCgUBesC7b+PdOaG4SMi0c39yxX4QzqIHEV/1pT
        0NOZ4hDMPeHKZ3wSPouTMUzhzrcxQ8QNWo7b7/UqbLH/EkRsDPXpAiFkawP95q/y
        gUiC67CqyhSSjpFIApmztSfnOKVbMMWpUW2X5NgzyJ9MSPmtdarrg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92C6A139FC2;
        Tue, 18 May 2021 10:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD667139FBD;
        Tue, 18 May 2021 10:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2] help: colorize man pages
References: <20210518132056.2003135-1-felipe.contreras@gmail.com>
Date:   Tue, 18 May 2021 23:50:50 +0900
In-Reply-To: <20210518132056.2003135-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 18 May 2021 08:20:56 -0500")
Message-ID: <xmqqa6os2j05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70E3FA78-B7E8-11EB-87DC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +color.man::
> +	When set to `always`, always colorize the man pages. When `false`
> +	(or `never`), never.  When set to `true` or `auto`, use color only
> +	when the output is written to the terminal. If unset, then the
> +	value of `color.ui` is used (`auto` by default).

Makes sense and is more in line with the rest of the system to have
subcommand specific color.* variable.

There are two things that make me wonder in the above description,
though.

> +static void colorize_man(void)
> +{
> +	if (!want_color(man_color) || !pager_use_color)
> +		return;
> +
> +	/* Disable groff colors */
> +	setenv("GROFF_NO_SGR", "1", 0);
> +
> +	/* Bold */
> +	setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
> +	setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
> +
> +	/* Underline */
> +	setenv("LESS_TERMCAP_us", GIT_COLOR_BLUE GIT_COLOR_UNDERLINE, 0);
> +	setenv("LESS_TERMCAP_ue", GIT_COLOR_RESET, 0);
> +
> +	/* Standout */
> +	setenv("LESS_TERMCAP_so", GIT_COLOR_MAGENTA GIT_COLOR_REVERSE, 0);
> +	setenv("LESS_TERMCAP_se", GIT_COLOR_RESET, 0);
> +}

This seems very specific to use of "less" and hopefully does not do
anything (bad) when a different pager is used by "man".

 - Would it help readers to somehow tell that color.man does not
   apply at all to those whose "man" does not "less" in the
   documentation?

 - What does it mean to set this variable to "always"?  For commands
   that we control how the various pieces of output are colored (or
   not), e.g.

   $ git -c color.ui=always log -1 -p >git-log-output.txt

   it is obvious what "always" means, but given the implementation
   that tweaks how "less" should behave, a similar command (below)
   would not colorize its output like the "git log" example above
   does, would it?

   $ git -c color.man=always help -m git >git-help-text.txt

I am just wondering if we are better off not to mention "always" in
the documentation patch above.  It seems more like that the
configuration variable is to answer this question and nothing else:

    when 'git help' shows manual pages and internally uses 'less' as
    its pager, do we tell it to colorize the output?

for which sensible answers are 'true' or 'false'.  For that matter,
it is not clear what "auto" ought to mean, either.

Thanks.
