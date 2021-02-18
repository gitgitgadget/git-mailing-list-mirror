Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4746C4332D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E4764EB2
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhBRTcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56147 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhBRTTt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:19:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E013899041;
        Thu, 18 Feb 2021 14:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b05i4ymVsVd/9MvAWX/4pdBmBWc=; b=SLbLB+
        7iA4cWYmID8zedbn29PiPjVRXMVvmFOXnj6u5jFmRW1gAmdRxT4tMC1XGkVXuqI8
        tkOOLND+p8LD7irhQN1VKR035i+DFXOfDgZ3gEQGmNMVBW/Yv/zYYsmc44hT3GYY
        O/vO75Cp1Q6fbuaBFNGoTeo5wCRX3Do40js+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aUQKPBwxosa1uIhIj9bR2l+lUghCdjMc
        imj5MXC7SwlfSUytXnhLh4n9G9aC7eQALlhW/aehyQ7HZl5VYYNwCYhXkUjlWfP5
        Y8LtsHRdQepRwGdZ6upIDFrDj5zAKvgKBgVd8AYRaKdgRnW4UlptTfW+a9ymDgHu
        TJozZ68eoRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D04A69903F;
        Thu, 18 Feb 2021 14:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37F779903E;
        Thu, 18 Feb 2021 14:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-2-charvi077@gmail.com>
        <xmqq35xulbj0.fsf@gitster.g>
        <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
Date:   Thu, 18 Feb 2021 11:18:59 -0800
In-Reply-To: <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
        (Charvi Mendiratta's message of "Thu, 18 Feb 2021 15:43:56 +0530")
Message-ID: <xmqqpn0xfal8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27840220-721E-11EB-8B3C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Hi Junio,
>
> On Thu, 18 Feb 2021 at 01:20, Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> The second one, even with s|HEAD|HEAD~3| is even less clear.
>> Without the "-m", the resulting commit will have the subject that
>> begins with !amend but the log message body is taken from the given
>> commit, but with "-m", what happens?  Does a single-liner 'clever
>> commit message' _replace_ the log message of the named commit,
>> resulting in an !amend commit that has no message from the original?
>> Or does 'clever commit message' get _appended_ the log message?
>>
>
> Yes, here it gets _appended_ the log message.  I agree this seems a bit
> confusing.

In what situation would a user use "-m 'appended pieces of text'"
option, together with "--fixup=amend:<commit>"?  I am wondering if
we want such a "append to" feature, or is it easier to understand
for end-users if "-m", "-F", "-C" and "-c" (the common trait of
these options is that they contribute to the log message text)
are made incompatible with --fixup=amend:<commit>.

> ...Thanks, for pointing this out. Also, in the above method for
> alnum I think we can initialize an array of alnum[] instead of
> alphas[]. Or otherwise I was thinking to instead check:
>            if (!isalnum(*c) && *c == ':')

Sure a loop is fine, or alnum[] is fine, or just alpha[] is OK, I
would think.  Do you foresee you'd need --fixup=chomp124:<commit>?
I somehow doubt it.
