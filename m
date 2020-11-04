Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C36C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29BF20684
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="myPEzGKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgKDUQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:16:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63197 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgKDUQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:16:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AFA6A31C8;
        Wed,  4 Nov 2020 15:16:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CBkEsnSlenbdrKHh1xogYelVBpA=; b=myPEzG
        KjLDXx9iwt7MvYXOJ5kmV+r2PgALnpfvpxQAeyebbnOhI89FWD3+sOy+VSC46R80
        wIMq42Lops/XuqoGMT/KE/082SyPJ3/QkbeF3bH3Gh+c6kSkLwpBuvafTDkvPSUJ
        S8Tg3a2XK+GYboKWo5CprVHmp1O5DH13zMCF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MWajIuGzVcc7e/WgtJpUvUPM1E/3yykb
        usJyLiUby645myokPEjI/4Xs3c/YtLCgMDfUYLz0EzAWtHXKt3qecVFieBYjP0j2
        PTieYXXHsP+ujEJTP25IvFpe394l8MftXzm3ZdzRcHrHyVY/PU9l5SLEfjFNU8yg
        kixR5wq4prA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2170BA31C6;
        Wed,  4 Nov 2020 15:16:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3C73A31C5;
        Wed,  4 Nov 2020 15:16:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Re*: Segfault in git when using git logs
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
        <20201103101553.GH24813@szeder.dev>
        <20201103182102.GA459792@coredump.intra.peff.net>
        <xmqq361qs31a.fsf@gitster.c.googlers.com>
        <20201103185711.GA461461@coredump.intra.peff.net>
        <xmqqimamqjhl.fsf@gitster.c.googlers.com>
        <xmqq7dr1nh3a.fsf_-_@gitster.c.googlers.com>
        <20201104194155.GA3060815@coredump.intra.peff.net>
Date:   Wed, 04 Nov 2020 12:16:36 -0800
In-Reply-To: <20201104194155.GA3060815@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 4 Nov 2020 14:41:55 -0500")
Message-ID: <xmqq361onahn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A485A978-1EDA-11EB-B4D8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +# Basic command line option parsing
>> +test_expect_success '-L is incompatible with pathspec' '
>> +	# This may fail due to "no such path a.c in commit",
>> +	# or "-L is incompatible with pathspec". Either is acceptable.
>> +	test_must_fail git log -L1,1:a.c -- a.c &&
>
> This test confuses me. What are we looking for here? Presumably we'd
> fail with:
>
>   git log -L1,1:a.c
>
> too. If the test were "basic command line parsing", I could see checking
> that. But that's only what the comment says.

Yeah, I was undecided to have a single test that covers all (which I
ended up with) or a sequence of individual tests (which I wrote on
the title).

>> +	# This must fail due to "-L is incompatible with pathspec".
>> +	test_must_fail git log -L1,1:b.c -- b.c &&
>
> Right, this is what we fixed. Would using test_i18ngrep on the stderr be
> better than the comment?

I do not care either way myself ;-)

>> +	# These must fail due to "follow requires one pathspec".
>> +	test_must_fail git log -L1,1:b.c --follow &&
>> +	test_must_fail git log --follow -L1,1:b.c &&
>
> These are really tests of --follow, but I don't mind seeing them here as
> reinforcement for the concepts that the commit message claims.
>
>> +	# This may fail due to "-L is incompatible with pathspec",
>> +	# or "-L is incompatible with pathspec". Either is acceptable.
>> +	test_must_fail git log --follow -L1,1:b.c -- b.c
>
> Should one of those be "-L is incompatible with --follow"? Though of
> course we did not add such a check, so we know that it will be "-L is
> incompatible with pathspec", even without the --follow.

The comment seems utterly wrong here.  I may reroll after taking a
nap or something ;-)
