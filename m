Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9973FC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559CF223E4
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgLWUBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:01:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59583 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLWUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:01:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 098E110B011;
        Wed, 23 Dec 2020 15:00:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cJ5EMAhE9GjD
        Zk4KNSiYZtsje8s=; b=unF+sYCdWpzyKZhWkcfk3x5Zigx+k0cvXP2NfQIzwvAp
        Atj5ilki6O1M/nfGCIg7Rk7s+q6BVJsaothXc1cD4LA4npmyOUAfwuCKw22kQU/8
        vb1/+9A7gTRfekCO2lvrEgNZjNbdFRziYW+HcAP/M5VBsyXeP7abJe+lQX9uOzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rg/LU8
        +gpDql297PZsZ93Np9u2DKAapaONz4Z42F/qpiVCCuZdx0/xHL6IHb5uWXk5W7s4
        qg3uxaKXlnwaza7xOhPnjAuOyjyNnI8A3TIyIhxSoDYDh0iDgoZRldvAoINTuyfx
        x92DMu/hUuMzkR0cQsI863Qk7Uo3zP7f/fjoo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 013F910B010;
        Wed, 23 Dec 2020 15:00:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03D0110B00B;
        Wed, 23 Dec 2020 15:00:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] gc: fix handling of crontab magic markers
References: <cover.1608585497.git.martin.agren@gmail.com>
        <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
        <xmqqsg7xfoj9.fsf@gitster.c.googlers.com>
        <CAPig+cRmatC0Q22XBBx-ouzNSn5uiarTes1tSehGZuBWucSt1g@mail.gmail.com>
        <CAN0heSrWjpdcPN7v9kS-A43TQ5RW_8kW9x_S7c70vUW5cX-fUA@mail.gmail.com>
Date:   Wed, 23 Dec 2020 12:00:45 -0800
In-Reply-To: <CAN0heSrWjpdcPN7v9kS-A43TQ5RW_8kW9x_S7c70vUW5cX-fUA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 23 Dec 2020 11:06:48
 +0100")
Message-ID: <xmqqk0t88f82.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C213B22-4559-11EB-9B3E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Wed, 23 Dec 2020 at 04:51, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>>
>> On Tue, Dec 22, 2020 at 5:47 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>> > Martin =C3=85gren <martin.agren@gmail.com> writes:
>> > > +test_expect_success 'stop preserves surrounding schedule' '
>> > > +     echo "Crucial information!" >>cron.txt &&
>> > > +     GIT_TEST_CRONTAB=3D"test-tool crontab cron.txt" git maintena=
nce stop &&
>> >
>> > 31345d55 (maintenance: extract platform-specific scheduling,
>> > 2020-11-24) in ds/maintenance-part-4 needs to adjust this
>> > exported variable for the tests to pass in 'seen'
>> >
>> > Is it just the matter of replacing it with
>> >         GIT_TEST_MAINT_SCHEDULER=3D"crontab:test-tool crontab ..."
>> > or is there more to it?
>
> Oh, I never realized this could be a problem. My merge with seen had a
> textual conflict, but nothing difficult, and the tests passed, so I
> didn't even stop to think if there was more to it. I clearly didn't
> notice the environment variable changed both name and value.
>
>> Yes, renaming GIT_TEST_CRONTAB to GIT_TEST_MAINT_SCHEDULER and
>> prepending "crontab:" to the value should be sufficient (per the
>> proposal by [1] and realization by [2]).
>>
>> [1]: https://lore.kernel.org/git/X6+iJNYEbpQjHCb0@flurp.local/
>> [2]: https://lore.kernel.org/git/4807342b0019be29bb369ed3403a485f0ce9c=
15d.1605647598.git.gitgitgadget@gmail.com/
>
> Thanks Junio and Eric for helping out.

Thanks for coming up with the fix.
