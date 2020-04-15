Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D48C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5471E2076A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mJoHrxUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbgDOPDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:03:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55885 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgDOPDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:03:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 575A8D1A18;
        Wed, 15 Apr 2020 11:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LLb7phZShEmp
        wdWSisjuNSxnZ+w=; b=mJoHrxUox5f1tXmEV6rGNUIGti7gZ1ZZDIYQeS9nJ/tI
        /8lFVRFdI0PFJqCAS080BBamBJRYucaN8ddu3kI9sB1wmDtma6xEOUDMQPTcEn+b
        Oz4yO5jQJ0ps8R3lzWE9OvsHJPXrLB4D2eabWruqXuwlNo56zbt5Oo30n2hdapI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nWh8JR
        wNXtP2uy9eH8B+Fi51L3rW33wixpSamnwF9gS0zj+6RU2Qubng1fzchepcn4TXOt
        9x807znYGvXK7yxIlJG0Y6O3nKWtGyB5rfrGLc8BevTYmDfMs+sfV7xh7fWNArtR
        t/TJrMvO1wRy/g7yxzRqr92sMrVnsboM0Fs3s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F3D7D1A17;
        Wed, 15 Apr 2020 11:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FE97D1A16;
        Wed, 15 Apr 2020 11:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
        <cover.1586856398.git.congdanhqx@gmail.com>
        <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
        <20200414202401.GC1879688@coredump.intra.peff.net>
Date:   Wed, 15 Apr 2020 08:03:11 -0700
In-Reply-To: <20200414202401.GC1879688@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 14 Apr 2020 16:24:01 -0400")
Message-ID: <xmqq5ze094gg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A7C2390-7F2A-11EA-B295-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 14, 2020 at 04:31:55PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>
>> @@ -666,6 +666,24 @@ static int match_digit(const char *date, struct t=
m *tm, int *offset, int *tm_gmt
>>  		n++;
>>  	} while (isdigit(date[n]));
>> =20
>> +	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
>> +	if (n =3D=3D 8) {
>> +		tm->tm_year =3D num / 10000 - 1900;
>> +		tm->tm_mon =3D (num % 10000) / 100 - 1;
>> +		tm->tm_mday =3D num % 100;
>> +		return n;
>> +	}
>
> I worry a little this may conflict with other approxidate heuristics.
>
> The only one I can think of is an actual unix timestamp, though, and we
> already require that to have at least 9 digits (plus anybody wanting to
> use one robustly really should be using @12345678).

I am OK with 1/2, but I'd worry a LOT about this one, if we didn't
require 9 digits.  60/100 * 60/100 * 24/100 ~=3D 8.6% so limiting the
hour/min/sec to sensible values is not a useful protection against
ambiguity.  We'd essentially be declaring that a raw UNIX timestamp
without @ prefix is now hit-and-miss if we take this change, were
there not the "must be at least 9 digits" requirement.

Somebody was thinking when he wrote the very beginning part of the
match_digit() function ;-)

> We could probably tighten the heuristics a bit by insisting that the
> month and day be sensible. Or even year (see the 1900 to 2100 magic for
> the 4-digit year guess).

I do agree that we'd want 0 <=3D hr <=3D 24, 0 <=3D min <=3D 59, and 0 <=3D
sec <=3D 60 (or should this be 61?), but it is for correctness of the
new code.  It wouldn't have any value in disambiguation from other
formats, I would think.  So, from that point of view, I would buy
something like 1969 as a lower bound, but I am not sure if we
necessarily want an upper bound for the year.  What mistake are we
protecting us against?

Thanks.

>> +	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
>> +	if (n =3D=3D 6) {
>> +		tm->tm_hour =3D num / 10000;
>> +		tm->tm_min =3D (num % 10000) / 100;
>> +		tm->tm_sec =3D num % 100;
>> +		if (*end =3D=3D '.' && isdigit(end[1]))
>> +			strtoul(end + 1, &end, 10);
>> +		return end - date;
>> +	}
>
> And likewise here that the hour, minute, and second be reasonable.
>
> -Peff
