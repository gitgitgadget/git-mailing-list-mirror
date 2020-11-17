Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF26C64E7B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A65F2463F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gefkO0YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgKQTfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:35:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53234 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbgKQTfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 14:35:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C7AEFE312;
        Tue, 17 Nov 2020 14:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=89QQPLInXPkKKDaWkTwHAoJ2wfU=; b=gefkO0
        YD6AFRTiMmpPFIyMwK58sGplwjxlrFoyL9ggpMAE9hh6UXzq22etD2As5KcWGajv
        wCHbNtZkHpOK2+yLA3ebyqETS0qIa47m/VZCzHs+DGkxN55dk1WjcKmCIyvHFe2s
        eP5I+ARR+sA38BpaJbZpm9pZ2/sXXtqJXk4i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J0c3eeMoNItZK4k5Rp1G0JLYlBFP/rUt
        m8p8MiMkJE6ymI2Mf7hFtj/3nwyPAFSE5+zvScYJkz8IhkD+Zddg8DMANEkNfv9z
        xGDgpqQLQla3J6TzFXCUeFdlXDcBFj4cO21JYebuxSagxElW2zCB57Uhi4Jn4zWy
        3y1rhzeIuE4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05822FE311;
        Tue, 17 Nov 2020 14:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F141FE30E;
        Tue, 17 Nov 2020 14:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
        <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
        <20201116235642.GA15562@google.com>
        <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
        <20201117010709.GB15562@google.com>
        <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
Date:   Tue, 17 Nov 2020 11:34:56 -0800
In-Reply-To: <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com> (Derrick
        Stolee's message of "Tue, 17 Nov 2020 08:56:16 -0500")
Message-ID: <xmqqlfez6alb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA1680D4-290B-11EB-AE61-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> Good find.  And it is even worse that value_regex uses ERE, not BRE,
>>> which means even an otherwise innocuous letter like '+' cannot be
>>> used without quoting.
>> 
>> I should have mentioned in the first letter than Jonathan Nieder was the
>> one who made the jump from "this is breaking in the buildbot but not
>> locally" to regular expression metachars. Credit where it's due.
>
> Thank you for finding and reporting this bug.
>
> Can I at least have a short moment of griping about anyone putting
> regex characters into their directory names? ;)

Sure, but the blame mostly lies in the one who thought using ERE was
a good idea ('+' is very often used).

>>> 0. Quote the value_regex properly, instead of blindly using a value
>>>    that comes from the environment.
>
> Pulling the subcommand from my test enfironment using GIT_TRACE2_PERF=1
> I see the following quotes being used:
>
> git config --global --unset maintenance.repo "/repos/new+repo*test"
>
> I'm guessing that what we really want is to _escape_ the regex glob
> characters? This command works:
>
> git config --global --unset maintenance.repo "/repos/new\+repo\*test"
>
> The only place I see where we do that currently is in
> builtin/sparse-checkout.c:escaped_pattern(). Please let me know if
> you know of a more suitable way to escape regex characters.

If we wanted to go that route, yes, we need to prevent random input
taken from the end user or the environment to be regexes, when they
are literal strings.  But I think we should just bite the bullet and
say "git config --unset --literal-value-pattern vari.able va+l+ue", etc.

This is not a suggestion for the option name, but a suggestion to do
this with a new option and not with a special value-pattern syntax.

	Side note.  It is tempting to declare that something like

	    git config --unset vari.able "!!$end_user_value"

	is the syntax to use literal/fixed pattern, and that way we
	do not have to touch the callchain from builtin/config.c
	leading down to git_config_set_multivar_in_file_gently().
	It is backward incompatible change that is unlikely hurt
	real people.  If a script is feeding "$end_user_value"
	without cleansing as the value_regex already, it is already
	broken (e.g. if $end_user_value happens to being with '!',
	this will unset everything that does not match the regexp)
	anyway.  And users already know to say '[!]some-pattern'
	when they mean the pattern begins with a literal '!' and not
	"does not match some-pattern", so reserving '!!' prefix does
	not sound too bad.

>>>> 1. Teach 'git config' to learn either which regex parser to use
>>>> (including fixed), or at least to learn "value isn't a regex", or
>>>>
>>>> 2. Don't spin a child process in 'git maintenance [un]register' and
>>>> instead just call the config API.
>>> ...
>>> My short-to-mid-term preference is to do #1 to allow a value to be
>>> spelled literally (i.e. remove entry with _this_ value, and add this
>>> one instead), and optionally do #2 as an optimization that is not
>>> essential.  I do not offhand know how you can make #2 alone fly
>>> without doing some form of #1, as I think the same value_regex that
>>> ought to be ERE to specify entries to be replaced needs to be used
>>> under the cover even if you use "config API" anyway.
>> 
>> Ah, right you are - I had figured the regex parsing was done earlier,
>> but it indeed looks to happen in
>> config.c:git_config_set_multivar_in_file_gently. Thanks.
>
> So the "real fix" is to allow a command-line option to 'git config'
> that makes the "value_regex" parameter a literal string? Of course,
> this would either require wiring an option down into
> git_config_set_multivar_in_file_gently() to treat the string as a
> literal _or_ to escape the input string in builtin/config.c.
>
> Am I understanding the intended plan here?

Yup, if people cannot poke holes with the wishful thinking that the
breaking of backward compatibility by using the "!!" prefix would
not cause practical issues, then I am also fine with that, but
inventing a flags word with a VALUE_PATTERN_FIXED bit in it and
updating the callchain to pass it down from the command line option
parser would be much less risky, I would think.
