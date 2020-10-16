Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938EC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687D7207BC
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hGidb4yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409842AbgJPQRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:17:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58158 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409271AbgJPQRF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 12:17:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E42D8FF5CC;
        Fri, 16 Oct 2020 12:17:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=25NlFPmAmZG/uiyqsot5ypVl+zg=; b=hGidb4
        yW15AOnIpXecaEiq8O+XgDvKz+YP0nJj35lxIHQ6nMWAlkVyppHhHOzXXUJy9iTT
        LWnG8eHH0Yw9IfnIFvbGhlO/EmvgC/qT18lqxE9bNWbSySTgZhTXtWtifh4SqFqE
        l9ZWhe4C2aL3wzaNjxNQI25WMQB9Hlr0VMlk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oQjC5F42xuNtZGRi0PP+0+q94TLcVBrc
        uAfBFj3h+Np7UvC2EPBbvMUh8zuWdc6tgCmbaFhz2DhOvlZHEqH+vdCR/YY93JtD
        fmQKUSPw3sltBYVxhpIrEr/Ashsqqo/r2L++KzZtePlx6AZOnj5opji7Ymc/MMQW
        h1/tMLEmTU0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC4E6FF5CB;
        Fri, 16 Oct 2020 12:17:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1EF7DFF5C7;
        Fri, 16 Oct 2020 12:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
        <20201014170413.GB21687@coredump.intra.peff.net>
        <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
        <20201015194648.GB1490964@coredump.intra.peff.net>
        <xmqq7drrfe15.fsf@gitster.c.googlers.com>
        <20201016003847.GB2932796@coredump.intra.peff.net>
Date:   Fri, 16 Oct 2020 09:16:57 -0700
In-Reply-To: <20201016003847.GB2932796@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 20:38:47 -0400")
Message-ID: <xmqq7drqdu2u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04648BBC-0FCB-11EB-A9CC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Ah, I see.  I actually do use "git ls-files t/ | grep ..." to look
>> for tests that are relevant to the issue I have at hand quite often,
>> so unlike what Jonathan said in the thread, having a good name does
>> matter to me.
>
> I'm not sure where he suggests worse names. I'd think if anything we'd
> have better names, because they'd be even more meaningful (if people
> start using them for test selectors). FWIW, I also grep like that when
> looking for scripts.

I didn't mean Jonathan suggested worse names.  Unlike "I don't tend
to discover test scripts based on their filename", which was what
Jonathan said, I do look for tests based on their filename, so
having a good name matters (on the other hand, if you are the kind
of person who does not look for them by name, the naming may not
matter to you).


> My plan is that you'd be able to say:
>
>   Meta/make --test=filesystem,update-ref
>
> for t0050 and t1400 respectively. Or more interesting things like
> "git-svn-*" to skip all of the t91xx tests (or "git-svn/*" if we split
> them by directories).

Most of the time, I am focused on running only the selected few, not
excluding a few known-broken ones.

For example, with an round of integration, I know only two tests
fail, and after I tried to fix the bug in the series, I want to
retry these two tests and nothing else to see if the attempted fix
patches the breakage up (of course I need to run the remainder of
the tests to ensure there is no regression, but that is just the
matter of running "make test" to run the whole thing again).

As long as it is known that "filesystem" and "update-ref" can serve
as tokens to uniquely identify these two tests, it would be fine for
my purpose.  But 0050 (under the rule that numbering must be unique)
would give me such an assurance much better without having to look
at any other test file.

The word "filesystem"?  Unless we have a rule that we can use each
unique word in test names only once (which of course is impractical)
I am not sure I can use it in place of 0050 without checking names
of other tests first.

> I definitely don't want to make anybody's life harder. But if the
> numbers aren't unique and the text connected to them is, then it seems
> like we should just use the text primarily.

True in principle, but it is harder to come up with unique substring
of text, knowing only that the whole string is unique.

Thanks.
