Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F9C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E6E61972
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhC1SZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:25:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62800 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1SZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 14:25:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 062071278EE;
        Sun, 28 Mar 2021 14:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1n/jCBjlv1uQ
        4grjq0pS29Nn2dg=; b=F5hyF/5ElwrEt05zKXvy43RBzwq0dM5hwJbDTpk5ZkTo
        zNppG+uFm1MrB0h5zM6y1NuiMxvexl2OUGFIoD5xpWwVyLYTj1nwjdVOlQXPfyJ0
        g2E+Gw2k1RkFsfhXYNicyBq9KUKKsVw4uK5RZJAIFk2lrhmYbX9Y3MBuIc6AZfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uS0fwF
        A+t7Wuc7Pmh45WJknMZgc2x+Hfq3hGVdNmdk4F8KrzOyfadSJCchnrPr6VgOMcVO
        gnwsND+JiGCFbGQQChZBowxo4hGniwGe2q0obZM8sodgiTmxuH4wRF8gPVSCf2S9
        E06ldVb6x7K7NfZuTcT0iUK8v+sORbXcU8wpc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F01651278ED;
        Sun, 28 Mar 2021 14:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 392571278EC;
        Sun, 28 Mar 2021 14:25:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] object.c: stop supporting len == -1 in
 type_from_string_gently()
References: <20210308200426.21824-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <patch-01.11-e51c860a65d-20210328T021238Z-avarab@gmail.com>
        <xmqqy2e7on7d.fsf@gitster.g> <87zgynmgbk.fsf@evledraar.gmail.com>
Date:   Sun, 28 Mar 2021 11:25:05 -0700
In-Reply-To: <87zgynmgbk.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 28 Mar 2021 17:46:39 +0200")
Message-ID: <xmqq8s67m8zi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC321430-8FF2-11EB-B2C8-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> At least, replacing an already queued topic with v2 would not
>> increase the number of topics that are supposedly in-flight but not
>> quite moving due to lack of reviews and responses, unlike bunch of
>> totally new patches ;-)
>
> I'm not sure what to do to improve things in that area.
>
> I'm obviously for increasing the net velocity of my patches making it t=
o
> master, but if it's held up my number of reviews a submission of Y won'=
t
> necessarily make X worse, since people who've got an interest in Y will
> be different than those with an interest in X.
>
> But some of it's definitely on my end, e.g. re-rolls sometimes taking m=
e
> longer than I'd prefer. It's a different activity to dissect outstandin=
g
> reviews & re-roll than writing code, and sometimes I'm interested in on=
e
> over the other...

What I'd like to encourage contributors to think is the velocity in
the whole project, not only their own patches.  The changes proposed
on the list would consume the review bandwidth, which is
unfortunately not an infinite resource.

To balance the supply and the consumption, one way might be to
throttle incoming patches to restrict consumption and distribute the
supply more evenly among authors.  But a more desirable way that
would benefit the community more would be to increase the supply.

If all of those who consume the review bandwidth tip in by reviewing
others' patches, not limited to the area they are interested in but
more in the "I am not so familiar with the area, but I've been here
long enough and know general principles, so let's polish your patch
together" spirit, that would help the community greatly, I would
think, by:

 - replenishing review bandwidth they consumed from the pool;

 - throttling their patch flow that consume review bandwidth (while
   they are reviewing others patches, they won't be throwing new
   patches at the list to consume even more review bandwidth);

 - helping the reviewers themselves become more familiar with the
   parts of the code they are not working in right now.

I am reasonably sure I and a few others on the list are net
suppliers of the reviewer bandwidth.  I do not expect all the
prolific contributors to become net suppliers; after all, designing
and writing their own stuff is always fun.  But I wish that the most
prominent contributors in the community to be reviewing others'
topics and ushering these topics to completion from time to time,
and I am hoping to see that happen more.

Thanks.
