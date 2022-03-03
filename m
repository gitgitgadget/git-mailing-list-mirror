Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E298C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 20:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiCCU7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiCCU66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 15:58:58 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C520344DD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 12:58:10 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7D02185868;
        Thu,  3 Mar 2022 15:58:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G8hvT/lbctvV
        xn2X9rDOAl2TWv61dLkBT/KEPzIU8Dw=; b=MgRb0utw9UU8AekD31GWtWXl8KwV
        rzNat6EgFHXLhvtlnlU040ZYPTK9o6SM8gO5MnZK18iOx+JFzlJSjc6RTjLxJ7rc
        56SqdbXWXbMHolbG03T2mXcsm8OVyBlYewtI9KQ+wOt8Uivq3iofoW4VZP1tAxQ+
        OrVhvyhyTDr9ic0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFF56185866;
        Thu,  3 Mar 2022 15:58:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 272A2185865;
        Thu,  3 Mar 2022 15:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 12/15] gettext tests: don't ignore "test-tool regex"
 exit code
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        <patch-12.15-f3cc5bc7eb9-20220302T171755Z-avarab@gmail.com>
        <xmqq5yowgcvg.fsf@gitster.g>
        <220303.86zgm72g3j.gmgdl@evledraar.gmail.com>
Date:   Thu, 03 Mar 2022 12:58:05 -0800
In-Reply-To: <220303.86zgm72g3j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 03 Mar 2022 16:46:22 +0100")
Message-ID: <xmqqsfryah42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A04EE590-9B34-11EC-B40F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 02 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> -test_have_prereq GETTEXT_LOCALE &&
>>> -test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE &&
>>> -test_set_prereq REGEX_LOCALE
>>> +test_expect_success GETTEXT_LOCALE 'setup REGEX_LOCALE prerequisite'=
 '
>>> +	if test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE
>>> +	then
>>> +		test_set_prereq REGEX_LOCALE
>>
>> This looks sensible but
>>
>>> +	else
>>> +		test_must_fail test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE
>>
>> this side looks puzzling.  I think this way to avoid counting abort
>> etc as passing "must fail" test would be the least bad that we can
>> do.
>>
>> Nicely done.
>
> Thanks. For the purposes of a re-roll I'll note this as a "nothing to
> change", since the commit message explains why we're doing this, unless
> you have comments on that explanation (the last paragraph of the commit
> message).

The comment was mostly if it is more appropriate to explain the
puzzling code with an in-code comment, rather than the log message.

In-code comment is for those who may find the current code strange.
The log message is for those who wonder why the current code came to
be in today's shape.
