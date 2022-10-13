Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51AC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 18:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiJMSl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJMSlI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 14:41:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DC352809
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:38:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 319FE15D1F9;
        Thu, 13 Oct 2022 14:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/SkXkc392PGW
        Hh8t2PlTfLEiJUXO+TQymfOHHSPHgwQ=; b=U7SIUUvCvrZzKTHfsHHWGgO0hkCu
        Xs4VkGscr3AEj6Y7Nwns/nkjq1wyStAhJ7okayX7ksqvwzNq13bqT3fuLGSfoCng
        f32ET65g9ljnchTAUa5M2V7GAEbBnUVlYsu2c+TtZSEQP6NIB/WrTKMLz5OqJqmg
        tvRNxnYGtyTUtN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28F6615D1F8;
        Thu, 13 Oct 2022 14:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 673AE15D1F7;
        Thu, 13 Oct 2022 14:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] archive: deduplicate verbose printing
References: <af5611aa-8662-7508-4f00-7fcf4e9cbcc6@web.de>
        <221011.86pmeyo7ch.gmgdl@evledraar.gmail.com>
        <27ec1253-4d34-1de2-caee-12bcf1dac03e@web.de>
        <CAPig+cRuqq=n=CLkCSH=axLO92=F2JGwNnK51aBEeCoMSdJjqg@mail.gmail.com>
Date:   Thu, 13 Oct 2022 11:33:52 -0700
In-Reply-To: <CAPig+cRuqq=n=CLkCSH=axLO92=F2JGwNnK51aBEeCoMSdJjqg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 13 Oct 2022 13:02:36 -0400")
Message-ID: <xmqqy1tjfu9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96CFAC2E-4B25-11ED-BB95-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 13, 2022 at 6:40 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> +test_expect_success 'git archive --verbose' '
>> +       git archive --verbose HEAD >verbose.tar 2>err &&
>> +       test_cmp_bin b.tar verbose.tar &&
>> +       find a -type d | sed s-\$-/- >verbose.lst &&
>> +       find a \! -type d >>verbose.lst &&
>
> Aside: I was curious whether or not we care about older `find`
> implementations which don't print anything at all if `-print` isn't
> specified, but I see that the test suite already has a mixture of
> `find` invocations -- some with and some without `-print` -- so that
> answers my question.

It indicates that everybody is POSIX enough these days ;-)

I do think it is better to be more explicit to write "-print" when
we mean it, and I wouldn't mind a clean-up patch every once in a
while when the area of the tree being affected are quiescent.

Thanks.
