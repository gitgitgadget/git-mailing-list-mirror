Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02C61F731
	for <e@80x24.org>; Wed,  7 Aug 2019 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfHGTZN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 15:25:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51602 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfHGTZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 15:25:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B77468D7BB;
        Wed,  7 Aug 2019 15:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QxB6e/6F1GxJ
        lmK/BfSEpBzggR4=; b=GEaB+iXi5c314aJdorHan9h7K8tIA7bmeuAW0JRS9D1k
        K8F8fUCOhSWB63C8eZ59LGEYNfJUyoxxRz8uoptoX4pyvdwgJA8Hvy80jeOfv73E
        oj5PW+cZAcVjQi2wnDz7lSATq0kYNHtk56bOk7Xn28pG0OnxxMarBvj4IcaKM84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JQXOfg
        +ep684khMEr8Hbbk9ACRfqyTu2LkHI7KRBomWR49CqLq5YgjCnw6ot6XPnOrQ5Zb
        7i2OnXRfqLI2QMNYWsPVlxWk4q+9oT5YZfKrvAoQuZ9Y2mARnSljif8/6LfaBcWV
        O+sknQUb+yuC9tUGTnJRReI99YhcTEKxIwXiA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFE998D7B9;
        Wed,  7 Aug 2019 15:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B562A8D7B8;
        Wed,  7 Aug 2019 15:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: release strbufs after use
References: <c3be25bf-6487-52ce-217d-d6ee93b3a16f@web.de>
        <a2f30b81-ba93-579c-98ec-07f5df1043d7@gmail.com>
Date:   Wed, 07 Aug 2019 12:25:04 -0700
In-Reply-To: <a2f30b81-ba93-579c-98ec-07f5df1043d7@gmail.com> (Derrick
        Stolee's message of "Wed, 7 Aug 2019 09:16:24 -0400")
Message-ID: <xmqqsgqchj73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 103AB08A-B949-11E9-B2C5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/7/2019 7:15 AM, Ren=C3=A9 Scharfe wrote:
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Patch generated with --function-context for easier review.  That makes
>> it look a lot bigger than it actually is, though.
>
> Thanks for the --function-context. It really does clarify what's going =
on,
> especially in the case with the "out:" label.

Yes in general, but it can cut both ways ;-)

>> The plugged leaks were added after v2.22.0 (2019-06-07) by the followi=
ng
>> commits:
>>=20
>> 5c84b3396c 2019-06-18 commit-graph: load commit-graph chains
>> ef5b83f2cf 2019-06-12 commit-graph: extract fill_oids_from_packs()
>> 8d84097f96 2019-06-18 commit-graph: expire commit-graph files
>
> Your changes look good to me.

Thanks.

>
>> -	strbuf_reset(&progress_title);
>> +	strbuf_release(&progress_title);
>
> This line confused me as I'm sure I adapted it from another place in co=
de,
> and sure enough in the old code, progress_title was re-used between mul=
tiple
> stages. That's why it was a 'reset' when it should have been a 'release=
'.
>
> Thanks!
> -Stolee
