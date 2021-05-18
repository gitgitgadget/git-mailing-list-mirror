Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD331C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB784611CC
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhERO24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:28:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60872 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhERO24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:28:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 262B81254CF;
        Tue, 18 May 2021 10:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xt8xxUCsF3/srgTbI8KXDDbd7X0+fU1qbXoHXb
        015Ys=; b=b9Dh8BnvQYX8NiXK8KaWryjCzgRPvNX0WVwHCOVzNXzqSw4Xrox8+v
        2E9TvJToyze5rZH8NEUojJJ5Qt0uuAWmxJyUaoxEyF0QbYpMmNid3OS4r3Ec0IMG
        OzWV55Ez08QX2gq3aIZXThSvrZiEZ+QDK4AYrgCbe2KDLqGqwv+eE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 207CE1254CE;
        Tue, 18 May 2021 10:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 597DD1254CB;
        Tue, 18 May 2021 10:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: Man pages have colors? A deep dive into groff
References: <60a046bd83001_f4b0f20861@natae.notmuch>
        <87tun1qp91.fsf@evledraar.gmail.com> <xmqqlf8d6ty5.fsf@gitster.g>
        <60a2f1c4cab0d_13c3702083a@natae.notmuch> <xmqqim3g4ys5.fsf@gitster.g>
        <60a3422b9556c_14d1bc2082f@natae.notmuch>
        <YKNptH9DL6pe18Dk@coredump.intra.peff.net>
Date:   Tue, 18 May 2021 23:27:33 +0900
In-Reply-To: <YKNptH9DL6pe18Dk@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 18 May 2021 03:16:04 -0400")
Message-ID: <xmqqlf8c2k2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 307D32FE-B7E5-11EB-A804-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 17, 2021 at 11:27:23PM -0500, Felipe Contreras wrote:
>
>> > So in short, the color.pager is about "is the pager capable of
>> > colors?"
>> 
>> That's not the case.
>> 
>> Even the documentation says so:
>> 
>>   color.pager::
>>     A boolean to enable/disable colored output when the pager is in
>>     use (default is true).
>
> I think that documentation misses the reason you'd want to use it.

Thanks for digging and I agree that this one is quite bad---no
wonder it misled to the "why not color.pager?" question.

The configuration is solely used to disable (because it defaults to
true) colors when pager is in use and the configurations on the
application side (i.e. color.ui and friends) specify "auto".  We
should update the description.

> And so likewise, we would want to avoid turning on colors if the user
> has set color.pager=false. Usually this is done automatically because
> want_color() checks, which knows if we are using the pager or not.
