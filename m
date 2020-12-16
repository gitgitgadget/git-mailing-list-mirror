Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FBC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 03:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D5322D75
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 03:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgLPDKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:10:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63654 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgLPDKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 22:10:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 112F4117CCC;
        Tue, 15 Dec 2020 22:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XnlU49PHHFudpqMiyNOyfGWAmkw=; b=oJIT0O
        YUsxgf3M646WD6184D5WdyNE/s4Hg1SGoMblL2+II9qDwoNNUnwhFpIKXiOz08IC
        c5fhP0LoGeI5a8LUI6IdIe5sq3gTsJ4Zi+c1iWiPKkYUjj1JLmjAiAaQ5U90Wt2u
        dK3EGsgQKakzRk+5Gfo8/wb3oyncvWb8Wqv88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kC+UzCJ0bcr4DyjdXf/FVq2AQCU7sNww
        swTNzlONVwndAhnwJaaufLd3NNJ6L7h1Rg92mJLSFWlUhlkEXvPT80B+WKCWT/A3
        vLLWGM6svA+FaJ3cEWaM4dHIeUHlhgU6h8Ye9LyeuGUQSUlVIS1d4sTbEodiASRY
        +dquS4I84oc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09202117CCB;
        Tue, 15 Dec 2020 22:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48107117CCA;
        Tue, 15 Dec 2020 22:09:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <20201211210508.2337494-1-jonathantanmy@google.com>
        <87blewwoil.fsf@evledraar.gmail.com>
        <xmqqim94e4et.fsf@gitster.c.googlers.com>
        <878s9zx2ul.fsf@evledraar.gmail.com>
        <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
        <xmqq8s9zaica.fsf@gitster.c.googlers.com>
        <X9g9Y9LWc0NtHlQn@coredump.intra.peff.net>
Date:   Tue, 15 Dec 2020 19:09:50 -0800
In-Reply-To: <X9g9Y9LWc0NtHlQn@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 14 Dec 2020 23:36:51 -0500")
Message-ID: <xmqq7dpi5tvl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A346528-3F4C-11EB-B8B2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Meaning "git checkout origin" would look at origin/HEAD and find the
>> remote-tracking branch it points at, and uses that name?  I think
>> that does make quite a lot of sense.  You are correct to point out
>> that not just "git checkout origin/HEAD", but "git checkout origin",
>> currently detaches the HEAD at that commit, if you have origin/HEAD
>> pointing at one of the remote-tracking branches.
>
> I'm not sure if it's a good idea to change "git checkout origin" here or
> not. It already does something useful. I was mostly suggesting that the
> other thing might _also_ be useful, but I'm not sure if it is wise to
> change the current behavior.

Well, "git checkout origin/HEAD" would also do something useful,
which happens to be identical to "git checkout origin", to detach
HEAD at the commit.

> I was thinking more like an explicit way to trigger the dwim-behavior,
> like:
>
>   # same as "git checkout foo" magic that creates "foo", but we
>   # have said explicitly both that we expect to make the new branch, and
>   # also that we expect it to come from origin.
>   git checkout --make-local origin/foo

By default I think --guess (formerly known as --dwim) is enabled, so
"git checkout foo" is "git checkout --guess foo", which is making
local 'foo' out of the uniquely found remote-tracking branch.  This
new one is to reduce the "uniquely found" part from the magic and
let you be a bit more explicit, but not explicit enough to say "-t"
or "-b foo"?  I am not sure if this is all that useful.

If this were a slightly different proposal, I would see the
convenience value in it, though.  Currently what "--guess" does is:

      If the name 'foo' given does not exist as a local branch,
      and the name appears exactly once as a remote-tracking branch
      from some remote (i.e. 'refs/remotes/origin/foo' exists, but
      there is no other 'refs/remotes/*/foo'), create a local 'foo'
      that builds on that remote-tracking branch and check it out.

What would happen if we tweaked the existing "--guess" behaviour
slightly?

      "git checkout --guess origin/foo", even when there is a second
      remote 'publish' that also has a remote-tracking branch for
      its 'foo' (i.e. both 'refs/remotes/{origin,publish}/foo'
      exists), can be used to disambiguate among these remotes with
      'foo'.  You'd get local 'foo' that builds on 'foo' from the
      remote 'origin' and check it out.

>   # similar, but because we are being explicit, we know it is reasonable
>   # to dereference HEAD to find the actual branch name
>   git checkout --make-local origin/HEAD

The user does not need "git symbolic-ref refs/remotes/origin/HEAD"
if such a feature were available.  "git checkout --some-option origin"
without having to say /HEAD may be a better UI, though.

And "checkout" being a Porcelain, and the DWIM feature that is
always on is subject to be improved for human use, I do not see why
that --some-option cannot be --guess.  If I want to get the current
behaviour, I can explicitly say "git checkout --detach origin"
anyway, no?

> That seems orthogonal. Whether there is checkout magic or not, changing
> what origin/HEAD points to would be disruptive to selecting it as a
> tracking source, or doing diffs, or whatever. But that is why the
> proposal in that series was to make the behavior configurable, and
> default to "fill it in if missing" as the default, not "always update on
> fetch".

Ah, I totally forgot that the favoured variant was "fill in if
missing, but don't move once it is set".  Yes, I think that is a
sensible default.

Thanks.
