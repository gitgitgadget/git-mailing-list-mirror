Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F37C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046B9619B8
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCWRjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:39:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56636 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCWRjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 13:39:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2227B120ECF;
        Tue, 23 Mar 2021 13:39:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8FIhDNJKZ9SmqfDdH5tx4vzJlI=; b=yXJCu5
        UChU5/vQTpBGM5fS5SiRmvjt/wilQT5UGD/YCm3opxXnbhrQS64TTvcFJQu2xvCb
        LSpp4KhP1SO99lb4ix8F3b3A/I/5Zcz6lfJAhKWcoZCrpqZqMA/aeTvmDCXSKmNP
        dnGXCMbe5f0gJzFtdhijWpIskFmmO5WmFEdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KvuAeSxta28WuowLoP4VbFg03BKQEZKx
        K2fDOETHCdpQBFSpGb6NelxpXe6l563dHFuRUaHdYeW/9uIBTp39sGuz8+OHrwx8
        nPoj7PNbUM9xvvDsYNlxVeP/4rlEEVKYpdn6o9gzavvGZOrY/KlhkKzRUkZXZPXl
        bDLUe6PouYE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A36D120ECE;
        Tue, 23 Mar 2021 13:39:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 691C2120ECC;
        Tue, 23 Mar 2021 13:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
        <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
        <YCwJ8tORQg2Air4r@nand.local>
        <xmqqmtw3pzu3.fsf@gitster.c.googlers.com>
        <YCwhPG6RaAhU9ljg@nand.local>
        <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
Date:   Tue, 23 Mar 2021 10:39:13 -0700
In-Reply-To: <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
        (Christian Couder's message of "Tue, 23 Mar 2021 16:17:46 +0100")
Message-ID: <xmqqsg4l3h32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFEDBE0E-8BFE-11EB-9D8D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> So I thought that blank lines should not appear in the trailers. And
> if any appears, it means that the trailers should start after the last
> blank line.

I think that is a good principle to stick to.

>> >  - if the second "multi:" trailer did not have the funny blank line
>> >    before "_two", the expected output would still be "multi:"
>> >    followed by "one two three", iow, the line after the second
>> >    "multi: one" is a total no-op?  If we added many more " \n" lines
>> >    there, they are all absorbed and ignored?  It somehow feels wrong
>>
>> That's definitely the outcome of this patch, but I agree it feels wrong.
>> I'm not sure that we define the behavior that strictly in
>> git-interpret-trailers(1), so we have some wiggle room, I guess.
>
> Any patch to relax how blank lines and other aspects of trailers
> parsing in my opinion should come with some documentation change to
> explain what we now accept and what we don't accept, and also tests to
> enforce that.

OK.  But do we document clearly what we accept and we don't before
any change?

