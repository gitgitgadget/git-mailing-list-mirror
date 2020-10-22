Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5BBC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93C021534
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 18:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mO8Wmn6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896398AbgJVSHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 14:07:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53019 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895913AbgJVSHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 14:07:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBE3080FF3;
        Thu, 22 Oct 2020 14:07:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/d7qnCf0O71rnF5MEGxjdSIp5v0=; b=mO8Wmn
        6YF7oGuyK2DAUSSu5FjHm6KMxrZKPgfULIiG+6BiqMWPZDOZvB6gMWqRlDpFHrFW
        19Ucsx1YmljKkAwOUn6iVUrxczxqNwC2HXHp2fvtzJ2+ZOk1KPKJHJlHMsDwXXjc
        2A6q7pMSQ5KJIpJcElgQksHss8u6MJN0XX8hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q0s7OzJsGkkU43f+z9L4XdsAYG6pp//0
        nTa0xd43qZB2AsQiK2fFsvC3GoByl9Y4/7llmDOagn6s6xnhNSOWzf3fO6I6UW54
        IzarbjloaWjF4PAyWiqHfyOO+649QDOwEAf856bKhhNCqTWKgsl+aX1mBAcJMXZ0
        CExddYvJTGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B310580FF1;
        Thu, 22 Oct 2020 14:07:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 387DD80FF0;
        Thu, 22 Oct 2020 14:07:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta Jain <sangunb09@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        kaartic.sivaraam@gmail.com, sunshine@sunshineco.com
Subject: Re: [Outreachy] [PATCH v3] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201022112201.51459-1-sangunb09@gmail.com>
Date:   Thu, 22 Oct 2020 11:07:37 -0700
In-Reply-To: <20201022112201.51459-1-sangunb09@gmail.com> (Sangeeta Jain's
        message of "Thu, 22 Oct 2020 16:52:01 +0530")
Message-ID: <xmqqft66m8wm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 781681F8-1491-11EB-B42B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta Jain <sangunb09@gmail.com> writes:

> From: sangu09 <sangunb09@gmail.com>

Oops?

> Git diff reports a submodule directory as -dirty even when there are
> only untracked files in the submodule directory.
> This is inconsistent with what `git describe --dirty` says when run in
> the submodule directory in that state.

Nicely written.

> This patch makes `git diff HEAD` consistent with `git describe --dirty`
> when a submodule contains untracked files by making
> `--ignore-submodules=untracked` the default.

Instead of explaining "This patch makes...", it is more common to
give an order to the codebase, i.e. "Make...".

> Also, to avoid `ignoreSubmodules` in user config being overwritten,
> I have made added a flag in diff_flags to keep a track whether
> `handle_ignore_submodules_arg` is called before or not.

Well, that is not "Also"; it is an integral part of making
"--ignore-submodules=untracked" the _default_.  We need to make sure
that end-user configuration would be honored, and we need to make
sure that the command line option would be honored, too.

I'd suggest to follow the excellent first paragraph above with
something like the following.

	Make `--ignore-submodules=untracked` the default for `git
	diff` when there is no configuration variable or command
	line option, so that the command would not give '-dirty'
	suffix to a submodule whose working tree has untracked
	files, to make it consistent with `git describe --dirty`
	that is run in the submodule working tree.


> @@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>  		DIFF_XDL_SET(options, INDENT_HEURISTIC);
>  
>  	options->orderfile = diff_order_file_cfg;
> +	
> +	if (!options->flags.ignore_submodule_set)

This new boolean is meant to be set only when non-default
ignore-submodules option is given either from the command line or
from the configuration---when the bit is unset, we are told to do
whatever it is that is the default for us.

> +		options->flags.ignore_untracked_in_submodules = 1;

And the default is to flip only this bit on.  Do we need to turn off
other bits that submodule.c::handle_ignore_submodules_arg() function
touches?  [*1*]

> diff --git a/diff.h b/diff.h
> index 11de52e9e9..1e18e6b1c3 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -178,6 +178,7 @@ struct diff_flags {
>  	unsigned diff_from_contents;
>  	unsigned dirty_submodules;
>  	unsigned ignore_untracked_in_submodules;
> +	unsigned ignore_submodule_set;
>  	unsigned ignore_dirty_submodules;
>  	unsigned override_submodule_config;
>  	unsigned dirstat_by_line;
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..a7956e1539 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -420,6 +420,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
>  void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  				  const char *arg)
>  {
> +	diffopt->flags.ignore_submodule_set = 1;

I like the general idea of having one bit that is set if and only if
the command line or configuration told us specifically what to do,
so that we can dictate the default after they were taken care of.

But I am not sure if this is a good implementation of that idea.  

Case in point.  I was wondering if the most future-proof way to
answer the question I asked (marked with [*1*] above) was to avoid
flipping the bits in options->flags ourselves, but to make a call

	handle_ignore_submodules_arg(&options, "untracked");

in repo_diff_setup().  When such an improvement is made after this
patch lands, the assumption that only the end-user preference will
call this function no longer holds.

Even without anticipating such a change in the future, there already
is a callsite of this function in wt-status.c that hands a hardcoded
string "dirty" to it.  That is *not* caused by an end-user request
(be it a configuration variable or a command line option), so in a
sense, the assumption is already broken.

I wonder, if we can do things in a more natural way (at least the
natural way in this codebase).  Usually we do things in this order:

 - initialize the status and option variables to their default state.

 - read the configuration files to allow the state of these
   variables to be modified from their default state.

 - parse the command line arguments to further allow the state of
   these variables to be modified.

and then use the final state of these variables.  That way, we do
not even need the extra bit that is only required if we did things
in an unnatural way, which is

 - read the config; remember if any bits were toggled
 - parse the command line; remember if any bits were toggled
 - only if bits weren't toggled in the above, set the default

I dunno.

> @@ -1677,7 +1678,9 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  
>  	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>  	if (ignore_untracked)
> -		strvec_push(&cp.args, "-uno");
> +		strvec_push (&cp.args, "-uno");

Noise.

> +	else
> +    	strvec_push (&cp.args, "--ignore-submodules=none");

Misindented.
