Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE7C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FFE208B8
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbhAMUG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:06:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61739 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbhAMUG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:06:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEF60109C5F;
        Wed, 13 Jan 2021 15:06:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FWpIV8D8HcpJtDdetVMo7K72jew=; b=V/2fkm
        ovUJk3J5V3uwQH2ouLS2FUyuY6WGtxF4Cr65GlapqvvTrF5Chjtac7UD5QPPJ9Sh
        F8a/agyeHq+VC3rz5v8QYLpuhyd+OO3gdi+dPSh+MNYcKLCq8DY6aQEph5wEuTfU
        xZgB3a+jFLbrm2o8dwQ4XKIGse8LkRs+vIp4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QRpwsHas85Hy5pDJOXIJExGyDzx+6YGI
        uSjaUk1RV9jDjRXoREW77lcuF7EkRupAMJHh8NCfp8m7Wl73swAgyC0b/pEvNUQb
        6jFHiBnxUCNi1QKltNFCELMEg55yln7+oofTtcOs6E1jCV7D4Lx+yy61CgjmcC3A
        hYALcrMc4AQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A79F8109C5E;
        Wed, 13 Jan 2021 15:06:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE82A109C5C;
        Wed, 13 Jan 2021 15:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
References: <cover.1610129796.git.me@ttaylorr.com>
        <xmqqk0shznvf.fsf@gitster.c.googlers.com>
        <X/5ER+ml/MhDjROA@nand.local>
        <xmqqft35ziog.fsf@gitster.c.googlers.com>
        <X/5nsw6uqKDCHGql@nand.local>
        <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
        <X/7yFdqUmSmRE8A0@coredump.intra.peff.net>
        <X/8THO3ck3bjJH+K@nand.local>
Date:   Wed, 13 Jan 2021 12:06:08 -0800
In-Reply-To: <X/8THO3ck3bjJH+K@nand.local> (Taylor Blau's message of "Wed, 13
        Jan 2021 10:34:52 -0500")
Message-ID: <xmqqft34y53j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C74DA474-55DA-11EB-AEC4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > That way, the bottom part can be merged sooner to 'next' than the
>> > rest.  It always is cumbersome to have some part of the series in
>> > 'next' and remainder in 'seen', so at that point, the lower half
>> > would naturally gain a different name before it gets merged to
>> > 'next', I would think.
>>
>> That seems to me like it ends up being _more_ work than just making them
>> into two branches in the first place.

More work to contributors?  How?

As long as each of 20-patch and 8-patch series is marked clearly to
manage the risk of mistakes and confusion down to the same level as
a single long series, I am perfectly OK.

Examples of help contributors could have made, which would have
avoided past confusion (these are not "potential" ones, but I had to
redo day's intergration in the past because of one long topic
building on top of another) are:

 - When sending either topic, not limited to the initial round but
   in all the subsequent rounds, remind that the top topic is to be
   applied on top of the bottom topic.

 - When updating the bottom topic (e.g. 20-patch one in this case),
   send out the top one (e.g. 8-patch one), too (or instruct me to
   discard the top one tentatively).

The worst case that happened in the past was that a quite minor
tweak was made to a bottom topic that was depended on another topic,
so I just queued the new iteration of the bottom topic again,
without realizing that the other one needed to be rebased.  We ended
up two copies of the bottom topic commits in 'pu' (these days we
call it 'seen') as the tweak was so minor that the two topics
cleanly merged into 'pu' without causing conflict.  The next bad
case was a similar situation with larger rewrite of the bottom
topic, which caused me to look at quite a big conflict and waste my
time until I realized that I was missing an updated top half.

If the inter-dependent topics that caused me trouble were managed as
a single long patch series, either with "this is a full replacement
of the new iteration" or "these are to update only the last 8
patches; apply them after rewinding the topic to commit f0e1d2c3
(gostak: distim doshes, 2021-01-08)", would have had a lot less risk
to introduce human error on this end.

> I agree, but I also wasn't aware that you would consider queuing part of
> a series. If that's the route you want to take, I'm OK with that.

Discarding broken part of a series and only queuing a good part can
happen with or without multiple topics.  Merging one topic to 'next'
but not the other also happens.  Merging early part of a topic to
'next' while leaving the rest to 'seen' is possible but I'd prefer
to avoid it.  Because of the last one, a single long topic, when a
bottom part stabilizes enough, would likely to gain a separate name
and its tip would be merged to 'next'.

> But I
> tend to agree with Peff that (in this case since a clear deliniation
> already exists) it may save us time to just send two separate series
> from the get-go.

As long as the two serieses are marked as such clearly, not just in
the initial round but in all subsequent rounds, it is OK.  But in an
unproven initial round, you may regret having to move a patch across
topics, from the bottom one to the top one or vice versa, instead of
just reordering inside a single topic.

>> So I guess I remain skeptical that ad-hoc splitting of longer series is
>> easier than doing so up front.

Nobody suggested ad-hoc splitting.  I was saying that splitting
would naturally grow out of reviews toward stabilization.
