Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BBC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3BE6127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFHHGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:06:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59454 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHHGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:06:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CC65C6266;
        Tue,  8 Jun 2021 03:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TUDANQQci/rDRI8zQZQKa9ou81IGuB+Kh1HWv8
        ehoqI=; b=coFUAgn/c8Dxh/uePsEB0BShu71FITrlM1/nhk6+n4dBQ4GFw/0qbH
        wdFytnmoFxTxMhEp+7TB2AdnVwlio9vxsgQmEmvoFeVTAQ6v24/tIu3zJQPIjish
        zcWbYh6xH6jskfGC9tvr3/bhfdme36AdIg91hoCIPu68pss7GfKgg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13CECC6265;
        Tue,  8 Jun 2021 03:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AA74C6264;
        Tue,  8 Jun 2021 03:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [suggestion] support non-negative float number in git-repack
 --max-pack-size
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
        <YL8RfGijMY95miHI@coredump.intra.peff.net>
Date:   Tue, 08 Jun 2021 16:04:23 +0900
In-Reply-To: <YL8RfGijMY95miHI@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 8 Jun 2021 02:43:08 -0400")
Message-ID: <xmqqfsxsq1l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1D076B0-C827-11EB-9B9D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 07, 2021 at 01:42:47PM +0700, Bagas Sanjaya wrote:
>
>> I would like to create packfiles with charm-numbered size (that is for
>> example use 49.99M instead of 50M) with git-repack:
>> 
>> $ git repack --max-pack-size=49.99M -a -d
>
> The parser for numbers with units is shared by many options and config
> variables. In general, I'm not really opposed to allowing floating point
> values which get rounded to the nearest byte for any of them. So no
> objection for the general feature if somebody wants to implement it.
>
> But I would note that --max-pack-size is almost never a good idea in
> general. I don't know what you think it's accomplishing, but it is
> probably making your repository larger than it needs to be, as well as
> less performant.

Perhaps a doc update is in order?  It might have been cute and
superficially useful to be able to cut packfiles in 650M chunks to
fit on a CD-ROM, but I suspect that it would be more useful to feed
a single large file to a generic multi-volume archive tool and let
it split it to fit the physical volume the tool deals with.
