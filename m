Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E0C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D1F61164
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDGWNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:13:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56654 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDGWNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:13:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE2A8135997;
        Wed,  7 Apr 2021 18:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AKqtDm1Jf0g3WZa6XKTcsFlRa0c=; b=WtC0F0
        VvMJ+NnSHnzV2KTFNVBPg42G02cBYOwHDvyLLUIZ9u6iGdLqHBJcSfbOnnqPtt0F
        4OKwNd1et6R5qMD5z19PXut98fY6rdcBhk7SIuMyWBqYNii/dCePQZOTp78TgYtl
        qEJeKEOLfRMux1S+UTtOoN8CY33dcU63VYq2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HvSfKYETVZRe+MXn6oSF6qeMhJCNmyh5
        2M/p8dUTms4YLC/NGdpubUdDXoPMi/KcCXFYNCNqX8Qw/COEUY8RwYenqZLkTUwN
        mpWujrAx0QVvEkpmMiNWahM5YvOyu9nI/eYmHQd2rBR5K/K7da4mYNDP1CoS03Hc
        3lZDWf3vDyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D64EF135996;
        Wed,  7 Apr 2021 18:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 194C0135995;
        Wed,  7 Apr 2021 18:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: There should have be git gc --repack-arguments
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
        <YG4J7vtTRVpGGLoo@coredump.intra.peff.net>
        <xmqq8s5tzv4f.fsf@gitster.g>
        <YG4mImcQyTC1/S8X@coredump.intra.peff.net>
Date:   Wed, 07 Apr 2021 15:13:39 -0700
In-Reply-To: <YG4mImcQyTC1/S8X@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 7 Apr 2021 17:37:38 -0400")
Message-ID: <xmqqa6q9yc8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 826D8710-97EE-11EB-984E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 07, 2021 at 01:40:16PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> ... git repack ...  --max-pack-size=<desired pack size> to create split and
>> >> smaller packs instead.
>> > ...
>> > You can also set pack.packSizeLimit for the latter, though I do not
>> > recommend it. It will not help with memory usage (neither while
>> > repacking nor for later commands).
>> 
>> In other words, passing --max-pack-size, whether it is done with a
>> new --repack-arguments option or it is done with the existing
>> pack.packSizeLimit configuration, would make things worse.
>
> Right. I wish we didn't have --max-pack-size at all. I do not think it
> is ever a good idea, and it complicates the packing code quite a bit.

I suspect that the original motivation was sneaker-netting on
multiple floppy disks ;-)

>>  - on a small box, it may make sense to avoid repacking everything
>>    into one in the first place, but we do not want the number of
>>    packs to grow unbounded.
>> 
>> Would the new geometric repack feature help here, especially for the
>> latter?
>
> Yes, I think it would. You'd perhaps want to generate a multi-pack-index
> file, too, to avoid having to look for objects in multiple packs
> sequentially (we have a "git repack --write-midx" option on the way, as
> well).

Thanks.
