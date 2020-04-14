Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CAEC2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2BA20678
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LSI0W20q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407582AbgDNRTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:19:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61240 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407532AbgDNRTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 13:19:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80B2359CA9;
        Tue, 14 Apr 2020 13:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6oZ6l9nhzduGLKhh4h/mGOJw8xU=; b=LSI0W2
        0qhAutXshYQg12PKAAhr1ZaEZWcgnVP0FnIDNocFGG4Cg18jcflriTF4l1+xY1eE
        lMVVXrMVUqoiBrpiTyu+S90F84qKo/n69DAFjqMvIEUwd3iPFiSiBYiUY+lDsbdv
        1Y6q5gGBIjwuthZPoDEj1qROCn7gN8BNVftTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wl5kjbQRqf7+chFA6Ee9jRPWc4RIcbC3
        HaAlrV+T6h2RLHH8LHxhPn6JbNZGXjjwKdfr7DWEzLxG6e1Tkzco5IhIoXM+SGS0
        OEPbaBYpIYkfF6I8OZ/7nQSS8qf6hZrMCeRP4nKnTOijzlepfhu7Bez4x61zeGsa
        OM1ChAOrVbI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78D2259CA8;
        Tue, 14 Apr 2020 13:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0E5E59CA7;
        Tue, 14 Apr 2020 13:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] log: add log.excludeDecoration config option
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
Date:   Tue, 14 Apr 2020 10:19:34 -0700
In-Reply-To: <pull.610.git.1586791720114.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 13 Apr 2020 15:28:39
        +0000")
Message-ID: <xmqqeesq9e8p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CA4EA5C-7E74-11EA-AE39-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (decoration_style) {
> +		const struct string_list *config_exclude =
> +			repo_config_get_value_multi(the_repository,
> +						    "log.excludeDecoration");
> +
> +		if (config_exclude) {
> +			struct string_list_item *item;
> +			for (item = config_exclude->items;
> +			     item && item < config_exclude->items + config_exclude->nr;
> +			     item++)
> +				string_list_append(&decorate_refs_exclude,
> +						item->string);
> +		}
> +
>  		rev->show_decorations = 1;
> +
>  		load_ref_decorations(&decoration_filter, decoration_style);
>  	}

A few random thoughts.  Unlike my other usual reviews, please do not
take "should we do X" as a suggestion (these are purely me wondering
and nothing more at this point):

 * Given that we have command line options to specify what patterns
   to include as well as to exclude, it feels somewhat asymmetric to
   have only the configuration to exclude.  Should we also have a
   configuration for including?

 * The new code only adds to decorate_refs_exclude, which has the
   patterns that were given with the "--decorate-refs-exclude"
   command line option.  As refs.c:ref_filter_match() rejects
   anything that match an exclude pattern first before looking at
   the include patterns, there is no way to countermand what is
   configured to be excluded with the configuration from the command
   line, even with --decorate-refs" option.  Should we have a new
   command line option to "clear" the exclude list read from the
   configuration?  And if we add configuration for including for
   symmetry, should that be cleared as well?

 * As this is a multi-valued configuration, there probably are cases
   where you have configured three patterns, and for this single
   invocation you would want to override only one of them.  It might
   not be usable if the only way to override were to "clear" with a
   new option and then add two that you want from the command line.

What if we had (configured) exclusion for X, Y and Z, and then
allowed the command line to say "include Y", that would result in
the combination to specify exclusion of X and Z only?  Can we get
away by not having "include these" configuration at all, perhaps,
because "if there is no inclusion pattern, anything that does not
match exclusion patterns is included" is how the matcher works?

I guess the last one, despite what I said upfront, is the beginning
of my suggestion.  If we take the quoted change as-is, and then
before load_ref_decorations() uses the decoration_filter, perhaps we
can see for each pattern in the "exclude" list, if there is the same
entry in the "include" list, and remove it from both lists.  That
way, when the users wonder why their "git log" does not use certain
refs to decorate (let's say, you configured "refs/heads/*" in the
exclusion list), they can countermand by giving "--decorate-refs"
from the command line, perhaps?  It is still unclear to me how well
such a scheme works, e.g. how should patterns "refs/tags/*" and
"refs/tags/*-rc*" interact when they are given as configs and
options to include/exclude in various permutations, though.

Thanks.



