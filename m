Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB4C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A7B23F37
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 10:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394098AbgLKKDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 05:03:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55087 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405732AbgLKKDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 05:03:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C639610ED99;
        Fri, 11 Dec 2020 05:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=KKFdMO+Dnt+rpfJhexZ3MTops/0=; b=n/Q+flBq2EBin0OurxMC
        hR+SHiAKOXH7IQYdCFTkKU+lqXA97Sqtj2+o0v1CQpZ4JJ3WjyKtdXL9lzXcBvrs
        qDMO8ZdHtVBvHiXIQZ7GYGLjYtwgUbkgxh524eM01QGsvE5KUlHVPrCtze58c/1D
        H0Yb7A+xobQT+QYEdweWKVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=tmFigsimiZH5XOKA4fxHJ6ZRF0wupRSkyhb05gbmVdbDlX
        RrLtzvBidPNIwLVk3jSnCP5XNYB2ymnRP4p1RvVmNGRdEZtzK2Lo3AY0TyKyOtj9
        ZVpG/MyrRSOsgkI16vpYmJTbsG3rhWHmvmhYcmeoQ2X9ugvVMBmJ3+aQTNQJI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE00410ED98;
        Fri, 11 Dec 2020 05:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 113EA10ED97;
        Fri, 11 Dec 2020 05:02:51 -0500 (EST)
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
Date:   Thu, 10 Dec 2020 23:17:01 -0800
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
        <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
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
Message-ID: <xmqqtussirsl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 080A43E4-3B98-11EB-A834-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> And when we stop in such a manner, it is sensible to give an error
>> message telling them
>>
>>  - why we are stopping,
>>
>>  - what they can do to move the immediate situation forward
>>    (i.e. command line option that lets them choose), and
>>
>>  - what they can do to make their choice permanent so that they
>>    would never see the command stop when facing a non-ff history
>>    (i.e. the configuration variables).
>>
>> Up to this point, I think both of us agree with the above.
>
> I don't agree with the above.
>
> The error I propose is just:
>
>   The pull was not fast-forward, please either merge or rebase.
>
> That's it. Nothing more.

It says "why we are stopping." quite well.  It would be a good
message to use as the first part of the three-part message I
mentioned above.

> I explained that was the final end goal in my list of steps [1]. I do
> not think any suggestion for commands or configurations belongs in a
> *permanent* error message.

In the design I have in mind in the message you are responding to,
the users who haven't told their choice to Git would be the only
folks who get all three.

You want to let the user express: "I do not want to choose either
rebase or merge.  I want 'pull' to fail when it needs to deal with
non-ff history.  But I do not need to be told about command line
option and configuration every time."

I said I don't (I view that disabling half the "git pull" just a
safe fallback behaviour until the user chooses between merge and
rebase), but if we wanted to offer it as a valid choice to users, we
can do so.  We just make it possible to squelch the latter two parts
of the three-part message---you leave pull.rebase unconfigured and
squelch the latter two parts of the message, and you got the "stop
me, I do not merge or rebase, but don't even tell me how to further
configure" already.

I agree the latter two should not be part of *permanent* error
message.  And my suggestion did not intend to make them so---it
should have been quite obvious to who read the message you are
responding to through to the end and understood what it said.

Now, how would we make it possible to squelch the latter two parts?
It is not a good idea to introduce pull.mode=ff-only for that
purpose (pull.mode=rebase and pull.rebase=yes would unnecessarily
become two redundant ways to do the same thing if we added a new
pull.mode variable).

But there is an established way used in this project when we allow
squelching overly-helpful help messages, and we can apply it here as
well.  That way:

 - unconfigured folks would get all the three parts of the messages,
   just like the current system.

 - if you tell rebase or merge, you do not see any.

 - if you do not choose between rebase or merge, you can still
   squelch the latter two by setting advice.pullNonFF to false.

The last one is "keep the more dangerous half of 'git pull' disabled,
without getting told how to enable it over and over", which is what
you want to be able to specify.

> The reason "pull.mode=ff-only" needs to be introduced is that
> --ff-only doesn't work. Otherwise there's no way the user cannot
> select the "safe default" mode. It has absolutely nothing to do with
> what we present the user with.

I too initially thought that pull.mode may be needed, but probably I
was wrong.  I do think this can be done without pull.mode at all, at
least in two ways, without adding different ways to do the same
thing.

 - When pull.rebase is set to 'no' and pull.ff is set to 'only',
   "git pull" that sees a non-ff history should error out safely.
   The user is telling that their preference is to merge, but the
   difference between merge and rebase does not really matter
   because pull.ff=only would mean we forbid merges of non-ff
   history anyway.  The message you'd get would be "fatal: Not
   possible to fast-forward, aborting." though.

 - Or with the advice that hides the latter two points, a user can
   unset pull.rebase and set the advice.pullNonFF to false to get
   the same behaviour (i.e. disable the more dangerous half of
   "pull") with just the "we stopped" error message.

I think either of these are close enough to what you want, and I
think the latter gives us more flexibility in how we tone down the
message with advice.pullNonFF.
