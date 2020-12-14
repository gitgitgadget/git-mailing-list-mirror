Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D207C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B9C22525
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503635AbgLNVFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:05:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59267 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503618AbgLNVFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 16:05:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8877894221;
        Mon, 14 Dec 2020 16:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=g1Pn8F/slBJhHa3InvAmnMNwNRs=; b=ES34ium/iPR7yisymYJ9
        1in4EJPvNbG4z0TNeCA0OclWf9qIaYUYTOKXHhKKAYf2fj7UnR0zemoBBbYaWuxF
        cXqR6Y97oGKZE7HrRqNKa6JpmlHv1EdLFl7JAvzTicy71uVrsgalgURsHbva7o/o
        9vYT1vYBsoEk9Z6BFUg1P/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=OM8mfPZJJ6u8z72pKONWyfhzpXJpEvzTwvZA13+vNg1Nw7
        hW29/Wyvv8oxiPx6GEPB7Q92oCC8tsvG8ocBYfGfiA7HwvyRTxBWp7s+deCl5w4w
        WPHqnThYbpdxi0SzDmgW4EJ2IyEM3Me6lV7sRUak8MLx1BwLvlLwxSs5bNEAs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F7FC94220;
        Mon, 14 Dec 2020 16:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07A749421E;
        Mon, 14 Dec 2020 16:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
        <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
        <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
        <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
        <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
        <xmqqeek2cc14.fsf@gitster.c.googlers.com>
        <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
        <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
        <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
        <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
        <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
        <xmqq360h8286.fsf@gitster.c.googlers.com>
        <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
        <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
        <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
        <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
        <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
        <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
        <xmqqtussirsl.fsf@gitster.c.googlers.com>
        <CAMP44s3CcNAT4dFogyo61zV+D1pZ-0K+1rDBk_BUk-RYVUW0RQ@mail.gmail.com>
Date:   Mon, 14 Dec 2020 13:04:28 -0800
Message-ID: <xmqqh7ooje03.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F483F5BC-3E4F-11EB-A906-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is irrelevant.

Oh, now you are saying that you do not need a way to squelch these
message to help unconfigured users choose between rebase or merge?
I am confused.

> As long as it's an error I don't care if it's short or long. I'm
> against turning on an error from one version to the next.

Now you are changing your mind?  Current version and past ones do
not make it an error to pull non-ff history without choosing rebase
or merge---we go ahead and merge anyway.  I thought that in the far
future agreed between two of us, it would be turnend into an error
at some point.  There needs one version that turns it into an error
for that to happen.  Puzzled.

>> I too initially thought that pull.mode may be needed, but probably I
>> was wrong.  I do think this can be done without pull.mode at all, at
>> least in two ways, without adding different ways to do the same
>> thing.
>>
>>  - When pull.rebase is set to 'no' and pull.ff is set to 'only',
>>    "git pull" that sees a non-ff history should error out safely.
>>    The user is telling that their preference is to merge, but the
>>    difference between merge and rebase does not really matter
>>    because pull.ff=only would mean we forbid merges of non-ff
>>    history anyway.  The message you'd get would be "fatal: Not
>>    possible to fast-forward, aborting." though.
>>
>>  - Or with the advice that hides the latter two points, a user can
>>    unset pull.rebase and set the advice.pullNonFF to false to get
>>    the same behaviour (i.e. disable the more dangerous half of
>>    "pull") with just the "we stopped" error message.
>
> So, after your hypothetical patch, there would be no difference between:
>
>   git -c pull.rebase=no -c pull.ff=only pull
>
> and:
>
>   git -c advice.pullnonff=false pull
>
> ?

We do not have to or implement both, but either should give us the
"when pull sees a non-ff history, it should stop without merging or
rebasing, and the user won't be given the advice on how to choose
between merge and rebase" behaviour, I would think.

>> I think either of these are close enough to what you want, and I
>> think the latter gives us more flexibility in how we tone down the
>> message with advice.pullNonFF.
>
> You are missing at least two things.

I am guessing that the '?' above I just answered is one you wanted
to ask me, but what's the other one?
