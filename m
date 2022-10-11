Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB6C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJKA0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJKA0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:26:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F1240B1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:26:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1B9C1CE245;
        Mon, 10 Oct 2022 20:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EabyirD0Gb/95xzduXB7vzyQ2XZ8EH6PXQMK0c
        mxP7A=; b=s04TuiuJ6ZzLtq3uKrssCY90qb3cdF4v8jJW7Gn5v4P9iI4ryzDUNH
        cqOzZ79jaK+blg9gqB++6vLZ+ZnhCH8xaMxGdIRdxbWjYO7mJny8fX7QlB1mWQ5l
        2k3ILRWuxpC2bOgmQCVTiRFoiTwNk4Wi63HqOYsTcvzXCVzNVg/AM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A32C1CE244;
        Mon, 10 Oct 2022 20:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2C6C1CE243;
        Mon, 10 Oct 2022 20:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 5/5] CodingGuidelines: recommend against unportable
 C99 struct syntax
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
        <20221010203800.2154698-1-gitster@pobox.com>
        <20221010203800.2154698-6-gitster@pobox.com>
        <Y0S0Tpn/uCjG9J61@coredump.intra.peff.net>
Date:   Mon, 10 Oct 2022 17:26:36 -0700
In-Reply-To: <Y0S0Tpn/uCjG9J61@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 Oct 2022 20:09:50 -0400")
Message-ID: <xmqqlepnxl1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E8FA250-48FB-11ED-9FCC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 10, 2022 at 01:38:00PM -0700, Junio C Hamano wrote:
>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 9598b45f7e..cbe0377699 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -242,6 +242,10 @@ For C programs:
>>       printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version we
>>       rely on supports %z, but the C library used by MinGW does not.
>>  
>> +   . Shorthand like ".a.b = *c" in struct assignments is known to trip
>> +     up an older IBM XLC version, use ".a = { .b = *c }" instead. See
>> +     the 33665d98e6b portability fix from mid-2022.
>
> FWIW, the use of the word "assignment" here left me scratching my head.
> Reading 33665d98e6b, it is about struct initialization.

Thanks, I missed that confusion in the new description.  Perhaps
another round of reroll would make the series polished enough?
