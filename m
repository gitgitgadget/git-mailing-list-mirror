Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC7C6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7187A21D7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgLBWV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:21:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61338 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgLBWV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:21:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE9EA8ACCD;
        Wed,  2 Dec 2020 17:20:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wBYl6cZAtzSM
        N82EEOW2vTDmFXs=; b=GyvYmGk5wJZ9q8L/va+tHzQ2EBxkdwwnjUwmlOJbk7pb
        ZvxKj6whXiokQGNK7k4YClnAWj3YuKYdVCQ3dUpWijUQjzRtJstdManFKwlNxLQs
        yKrLjaoHrCdODAsuBfboIqesIz5MIyhl5CeRYzTOKFChqngqj8QiJ2pxdf7dDp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Nq3Tvm
        Uv6lTkgs6plw1S14KeWbG5kWfchS6J4GGXCifQltqAbpzfH4wc8bLA4u3Hf3bFfS
        7PHU5R89rCgAw4d2ePDgXDukkcqaunSu6YYyhSe4bmgulr8/itox1d8Vfar95jlX
        BrEfOoH0nKcGwJqhF7ygOHwD88y6zEEy/T4Ys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4C4E8ACCB;
        Wed,  2 Dec 2020 17:20:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 595D78ACC8;
        Wed,  2 Dec 2020 17:20:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] make "mktag" use fsck_tag()
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-1-avarab@gmail.com>
        <87zh2xvny6.fsf@evledraar.gmail.com>
        <xmqqlfehpa7p.fsf@gitster.c.googlers.com>
Date:   Wed, 02 Dec 2020 14:20:44 -0800
In-Reply-To: <xmqqlfehpa7p.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 01 Dec 2020 12:01:14 -0800")
Message-ID: <xmqqwnxzluir.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F42F89E-34EC-11EB-8DC4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Nov 26 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> Now a non-RFC. I went for the approach I suggested in
>>> <87r1ognv4b.fsf@evledraar.gmail.com> of just having fsck_tag() able t=
o
>>> optionally tell us about its parsed tag/type, thus avoiding any need
>>> for a custom parser in mktag.c. Hopefully I've addressed the rest of
>>> the feedback, range-diff below.
>>
>> Ping @ Jeff & brian: you said you wanted this in one shape or another,
>> so mind seeing if the v2 looks good to you?:)
>>
>> Junio didn't pick it up for the "What's Cooking" sent out recently,
>> hopefully some reviewer ACK/NACK will help move it forward. Thanks!
>
> True.  I don't want to queue too many topics on 'seen', only to end
> up with a pile of patches that haven't been reviewed adequately and
> cannot move forward.

So, now I've seen all of them.

There were some minor things in the earlier part I commented on, and
if I am not mistaken, a new check, "body must not begin with a blank
line", should not be added at all, which would affect 08/10.

I am not sure how much longer we want to retain the .extra level of
checks that are more strict than those of fsck.  If we decide that
it is not worth it to forbid new object headers, we may be able to
lose 08/10 altogether.

Other than the above, the series mostly looked well done.

Thanks.
