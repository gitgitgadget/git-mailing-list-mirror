Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE9C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6460622ADF
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAMUWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:22:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64661 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbhAMUWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:22:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0064893FC1;
        Wed, 13 Jan 2021 15:21:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1SQV296f8Een+Xq4yNFGDaaR2s=; b=accfbi
        2XZHR7v2gBDtuKE2JuoI2tAO9kIirp5p8TOd6T3CN3Wy4BzscJnjVPT4VGTEJgWZ
        U1a6Kmvdj+P1JYtYpcYR7HfgjLKxGVAC9SH9nawA6tnhkmsQtH1a0JvW9y/1J3R6
        7SAqxw7TJS6CwIjERUPgXRbEobZD9HUhBv+0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rZG2KRx+GP5MJii1NqhNFWbeh0niECzS
        /84TOybyD6vIeAsrjQp/KO8Jy9xgpYZ01ZwGNfOgZQ+IpTV79A2TtKg/yG1PC+k/
        xjPlBHgcB4nzPcGBlJqvlzy/5Aw4qR0WxlBUgUynx+VqeL+3yToEWWTJtnv1x1Dq
        w4u+Qwvf2YQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECB9893FC0;
        Wed, 13 Jan 2021 15:21:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74F5593FBF;
        Wed, 13 Jan 2021 15:21:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Arnaud Morin <arnaud.morin@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] patch-ids: handle duplicate hashmap entries
References: <20210109162440.GM31701@sync>
        <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
        <X/28IXBpse2dNZQH@coredump.intra.peff.net>
        <20210112153438.GC32482@sync>
        <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
        <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
        <20210113092448.GE32482@sync>
        <X/7ur/IcCg1AqTdZ@coredump.intra.peff.net>
Date:   Wed, 13 Jan 2021 12:21:30 -0800
In-Reply-To: <X/7ur/IcCg1AqTdZ@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 13 Jan 2021 07:59:27 -0500")
Message-ID: <xmqq7dogy4dx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC9043CA-55DC-11EB-AABF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right. There's definitely a question of whether --cherry-pick is the
> most useful thing in such a situation, but the current behavior was
> simply broken. It did not behave as advertised, and it treated one side
> of the history different from the other. So whether we want to do
> anything else to help that case, I think this at least makes
> --cherry-pick sane. :)

Yes; I think "sane" does not always equal to "useful", though ;-)

> Here are two related histories to think about.
> ...
> I suspect for most operations we care less about "remove all
> cherry-picks from both sides", but rather "give me one side, omitting
> commits that are already on the other side" (because you want to rebase
> or cherry-pick some subset).

Yes again.  It means "--cherry-pick" inherently is not symmetric.
One side is the reference side (i.e. mainline), and the goal is to
remove from the other side what is in the reference side.

What we are seeing in this discussion is that "--cherry-pick" and
symmetric difference do not conceptually play well together.

But the behaviour with the patch makes the most sense when
cherry-pick is applied to a symmetric difference (provided that
doing so makes sense in the first place, that is).
