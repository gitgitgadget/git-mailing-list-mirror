Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE04C56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BE62075A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fh0zMMfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgKZBEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:04:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64020 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgKZBEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:04:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 644E3FDC9A;
        Wed, 25 Nov 2020 20:04:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=moe/0sOuoQrZ6zhE2TdBKtpohno=; b=fh0zMM
        fgWAgLaZl8HksJSM5LLj+84IMQKeCVjSNsf8bXodYEeCuvMkH1Jh+ad0FkRKiXJs
        339udgzTwnCAT2+CF4CpyE3tfIdXvA+NQ+Nsxp/CqtNOJpRE5QyEXHDm+B4HiCGP
        K2GY7oW6Zu9C3dV9qBHFXWFayZQkIllQdJJts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cgdarVJgJRsMIIN3nJnyrH7VgZXLCJyX
        7m/++pdb+uyQP6bacZwXtZSPcMcqbBRTYjHE82XkC81Ns2Hjk7lzeVFeirFHwhHe
        auFtEui37ppP5t7mosLRWk/EHVjC/m5VLV8h4GapjrRTrAdagRmEOmvCL40K3lzn
        ttGdfjnJPjw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D02DFDC99;
        Wed, 25 Nov 2020 20:04:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A66E5FDC98;
        Wed, 25 Nov 2020 20:04:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
        <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
        <20201121002921.GC353076@coredump.intra.peff.net>
        <xmqqd006s7ee.fsf@gitster.c.googlers.com>
        <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
        <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
        <X778eIAr3uzdh0H0@coredump.intra.peff.net>
Date:   Wed, 25 Nov 2020 17:04:47 -0800
In-Reply-To: <X778eIAr3uzdh0H0@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 25 Nov 2020 19:53:12 -0500")
Message-ID: <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61715F9C-2F83-11EB-9074-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 25, 2020 at 01:42:24PM -0800, Junio C Hamano wrote:
>
>> In the meantime, I may queue this on 'seen' but it cannot move
>> forward without a signoff.
>>  ...
>   We spawn an external pack-objects process to actually send objects to
>   the remote side. If we are killed by a signal during this process,
>   then pack-objects may continue to run. As soon as it starts producing
>   output for the pack, it will see a failure writing to upload-pack and
>   exit itself. But before then, it may do significant work traversing
>   the object graph, compressing deltas, etc, which will all be
>   pointless. So let's make sure to kill as soon as we know that the
>   caller will not read the result.

Thanks, that reads well.
