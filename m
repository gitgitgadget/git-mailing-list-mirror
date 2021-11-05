Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5162AC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F896120D
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhKESvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:51:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59511 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhKESvs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 14:51:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33810F6D64;
        Fri,  5 Nov 2021 14:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MTH4qaxFnhB9wLNeRLx8UNj08kq5BEsYVvs3ti
        FC++M=; b=j+6CbCOBYHWTngPeVf3oqxxhDlaA4Z/IYX+zlLfBsoWaVvC1DunfCb
        6CfABuq5x+y6EpHnzEJIFmsChPCwNO3oePm2ubSIGBLOdnPPg6aNqmamyrVt+Ufv
        f9Oplh9PbT2AGRfh9Yv3aGXJE55n28QKo5lHIdiq/7TwdEZM2qvLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09284F6D63;
        Fri,  5 Nov 2021 14:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3303F6D62;
        Fri,  5 Nov 2021 14:49:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Vipul Kumar <kumar+git@onenetbeyond.org>, git@vger.kernel.org
Subject: Re: List all commits of a specified file in oldest to newest order
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
        <YYTorS1DiuTXv0/V@coredump.intra.peff.net>
Date:   Fri, 05 Nov 2021 11:49:03 -0700
In-Reply-To: <YYTorS1DiuTXv0/V@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 5 Nov 2021 04:17:49 -0400")
Message-ID: <xmqq7ddmxwtc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D7D0CF6-3E69-11EC-826D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As a workaround, you can get what you want by two separate traversals:
> one to collect the commits via --follow, and then another to actually
> show them (but without doing any further walking). Like:
>
>   git log --follow --format=%H -- $your_file |
>   git log --stdin --no-walk --reverse [--oneline, -p, etc]

We learn new things every day.

Knowing the implementation, it is sort of obvious (we push the
objects into the pending list, populate the revs.commits in
prepare_revision_walk() from the pending list in order,
get_revision() first reverses the revs.commits and then gives out
the elements), but I didn't know the combination of "--no-walk" and
"--reverse" did something sensible ;-)

Thanks.
