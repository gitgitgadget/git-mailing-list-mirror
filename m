Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610BC4332B
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E038823359
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAMIV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:21:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52515 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbhAMIV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 03:21:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5D58100A6E;
        Wed, 13 Jan 2021 03:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=85QCvRCKbSrS0l9LGv2Csspn6jo=; b=tAhqAt
        jRuezVu652NEZgVewKy8nbz9fLgDkk+DYRXWWIjMafHYryM4Tec2FfJKpDN4Wl/d
        nfWEbM+CwyFd9DO5ahT6GwCLQcI3RxCyUYbDMwSpZezh4Wh0hhqn/YgqswF+HSDV
        I0jlmOekQ/InJreCZPBNPlZ+YGdy3qSS4c4zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tZ9jhuv9MNaY4e9QcPgALTeqyZ8WV/bh
        oaKMTxWUZQ5kS4JmcNZqdkMvwsFvTIuqfVz10dzztzywidS+6sLaZ5PQxppL+iLu
        SLGpDvDpvZzneTsvWTSTWsf8bXOjmaGlGqOq9c5PwOjuzLxCeJH0bcYQpwlFA61A
        rKJ73JcgkHQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFE5C100A6D;
        Wed, 13 Jan 2021 03:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06134100A6B;
        Wed, 13 Jan 2021 03:21:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
References: <cover.1610129796.git.me@ttaylorr.com>
        <xmqqk0shznvf.fsf@gitster.c.googlers.com>
        <X/5ER+ml/MhDjROA@nand.local>
        <xmqqft35ziog.fsf@gitster.c.googlers.com>
        <X/5nsw6uqKDCHGql@nand.local>
Date:   Wed, 13 Jan 2021 00:21:12 -0800
In-Reply-To: <X/5nsw6uqKDCHGql@nand.local> (Taylor Blau's message of "Tue, 12
        Jan 2021 22:23:31 -0500")
Message-ID: <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CF3FC1C-5578-11EB-9C11-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> If you agree that the bottom topic is stable, I'd prefer to send the top
> one separately. Otherwise, I can send both together. Let me know.

I do not expect the first 20 of the 20+8 patches to be stable from
the beginning---in fact, after reading 01/20 myself, and seeing a
few of Peff's reviews, I expect that you'll be redoing at least some
of them.

When we deal with this kind of situation (not limited to these
topics), let's make it a tradition to first pretend that we have a
long single topic, and expect that the early rounds of review focus
on two things:

 (1) to identify the best ordering of the commits (topics from
     experienced contributors like you are likely to be already
     structured in a good order, so reviewers may only have to say
     "the ordering looks good", but sometimes they may want to say
     thinks like "it would be better to leave patches 5, 8 and 11 to
     much later in the series".

 (2) to find good points to divide the series into two (or more)
     pieces, and spend more effort on helping the bottom part to
     solidify faster.

That way, the bottom part can be merged sooner to 'next' than the
rest.  It always is cumbersome to have some part of the series in
'next' and remainder in 'seen', so at that point, the lower half
would naturally gain a different name before it gets merged to
'next', I would think.

Thanks.

