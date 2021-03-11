Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E33C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE7964ECD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCKUdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 15:33:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56694 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhCKUcd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 15:32:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7FF812BACA;
        Thu, 11 Mar 2021 15:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=olfaKXZR8hVC8loEXqlqcUVtXho=; b=F1ZrL2
        ymPXVMh0wG7WJKlECjq7j1kJA9Aq53TfICfzAP7TWIdtpdL/PST/8rNQOuDyp2rE
        XYGlhhztSGT50i4wLWEOy/ePQcm3inxB6TYmNuw+BYUQOERyqc6XInHK9xybxNmT
        o61RCiEyUrTOQTUNvAYO6N1WkDUVDlclpXuQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N8SQBqjbqKg9zUTweY1rSC5M4yyTS2zn
        UHi5McKVDM7jyP/VbzlhAsTtypwm4BZZRIJ0XvH3mCk2VXDbo2Qj9qvMBgVne13k
        IT5Q//1SBVk5TfYw9cWkjIJM+G9ZgRXWCaKDuUttcSbOw31eZeHq68F+S30GlN9G
        zfzVohXsVLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A05E612BAC9;
        Thu, 11 Mar 2021 15:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB04012BAC8;
        Thu, 11 Mar 2021 15:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <311ea4a5cd71c5dd2407348ad4608d2f7dd77ce5.1615302157.git.gitgitgadget@gmail.com>
        <xmqqblbrzy5j.fsf@gitster.c.googlers.com>
        <YEpvfztZWhAvSDTL@coredump.intra.peff.net>
Date:   Thu, 11 Mar 2021 12:32:29 -0800
In-Reply-To: <YEpvfztZWhAvSDTL@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 11 Mar 2021 14:29:03 -0500")
Message-ID: <xmqq4khhctya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E730CBA4-82A8-11EB-88B3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 09, 2021 at 03:48:40PM -0800, Junio C Hamano wrote:
>
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> > +	/*
>> > +	 * Write the header and the buffer in 2 parts so that we do not need
>> > +	 * to allocate a buffer or rely on a static buffer.  This avoids perf
>> > +	 * and multi-threading issues.
>> > +	 */
>> 
>> I understand "multi-threading issues" (i.e. let's not have too much
>> stuff on the stack), but what issue around "perf" are we worried
>> about?
>>  ...
> Yeah, this came from my suggestion. My gut feeling is that it isn't
> likely to matter, but I'd much rather solve any performance problem we
> find using writev(), which would be pretty easy to emulate with a
> wrapper for systems that lack it.

I too had writev() in mind when I said "can fix it locally", so we
are on the same page, which is good.

So "this avoid multi-threading issues" without mentioning "perf and"
would be more appropriate?

Thanks.
