Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA6C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E6020736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ByzoVVnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDXUdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:33:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58568 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDXUdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:33:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27E04D5768;
        Fri, 24 Apr 2020 16:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O3I5/w1/3kl6VjSolbUILPg4MNQ=; b=ByzoVV
        npBJqdpV4EvVHTH1spjDOJ5LEtsz97c5e9TaC0jkFB9y7sXUG4mr8DYNInBG/fXr
        N/nLOdkuZG8oOc+9JmS3B6bk6XktY+b07Hjs7IFSCv94NLs1mw7avNs1eFeyzBId
        jNBSn4S+W7P8K4yERPrYIXEf0C1yyDuZiEHo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BR9WgsgMsBYcIHNQwjRzDOtgxO7CDZpT
        Odnv6tNfM59z7og/13KyUVsgEzXTuGHkF6tIIojWOjGU7Md+gL2loTbCvMrgSqiG
        rsG+WvdZ80llDu69rsr51Y497BZ6vCVcQHTBhRy2Yl/SVRZYq1TZXZVWTrJZwkQo
        NeTUMo4FEII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2199AD5767;
        Fri, 24 Apr 2020 16:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BB71D5764;
        Fri, 24 Apr 2020 16:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/4] date.c: validate and set time in a helper function
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587644889.git.congdanhqx@gmail.com>
        <0d0e4d8edce37dfef13e573588f0c043ddf07f6a.1587644889.git.congdanhqx@gmail.com>
        <xmqqzhb2ez1q.fsf@gitster.c.googlers.com>
        <20200424114302.GG1949@danh.dev>
Date:   Fri, 24 Apr 2020 13:29:09 -0700
In-Reply-To: <20200424114302.GG1949@danh.dev> (Danh Doan's message of "Fri, 24
        Apr 2020 18:43:02 +0700")
Message-ID: <xmqq368sd3vu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41AA4D30-866A-11EA-ACF2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> I think single line like:
>
> 	/* We accept 61st second for the single? leap second */
>
> Or something along the time, is good enough. Not sure if we want the
> word "single" there, though.

I do not particularly want to see the single but without it, the
single-one comment looks perfect.

>> > -		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
>> > -			tm->tm_hour = num;
>> > -			tm->tm_min = num2;
>> > -			tm->tm_sec = num3;
>> > +		if (set_time(num, num2, num3, tm) == 0)
>> >  			break;
>> > -		}
>> >  		return 0;
>> 
>> This caller does become easier to follow, I would say.  Nicely done.
>
> Yes, when I looked around date.c
>
> I saw that the only usecase for validate time is for setting it.
> And the incoming patch also has that usage.
>
> I chose to unify those code path to not buy me too much trouble.
>
> I'll take that "Nicely done" means this unification is OK for this
> series.

The OK was meant for this single place that was converted, not any
other place you'd use in the remainder of the series.

And I think it was not such a good idea to use it twice, but I think
with the suggested rewrite you took in v5, the other call site is
also OK.

Thanks.
