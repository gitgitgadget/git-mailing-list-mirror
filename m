Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEEAD1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 05:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfJCFCJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 01:02:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55789 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfJCFCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 01:02:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63B981EDA7;
        Thu,  3 Oct 2019 01:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D0JS86sFJqscvFNHKX9vKqvipAw=; b=YIXmDR
        04dgEhyg7/7Z5f/gpd6AX93Ux3IalZ2rfFYO2o6E2C0dAa8MIS9SJ0YCgXKvw/ev
        Mq0M2nH5Gq66eNB3tg/uDUG0gRwrWvd3bQUElFxyU4t+eFHAjcqBzCRmgJ8ubwMr
        ho8Baplfb6vGKjVq9Vdtkmm5eHyNQnbd45o8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a4PnLst6h+TjCBgnOFmoauvuBFkP3p59
        WAzPiicI4Ax0K3Z2raJm7jMt/uIijO7ECRCcxC4MXim9FALuWIuX88zYn+ohNJYN
        6S65NbCrmAL++lth4ZQ7jkvNVLpaKclOfkcqW8O9BrHuFzOPqBiYCnSxzMXD48q+
        JqgM6+t7vFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1E9E1EDA6;
        Thu,  3 Oct 2019 01:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A08F01EDA5;
        Thu,  3 Oct 2019 01:02:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de,
        michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
References: <20190807213945.10464-1-carenas@gmail.com>
        <20190809030210.18353-1-carenas@gmail.com>
        <20190809030210.18353-3-carenas@gmail.com>
        <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet>
        <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
Date:   Thu, 03 Oct 2019 14:02:02 +0900
In-Reply-To: <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 27 Aug 2019 04:51:14 -0700")
Message-ID: <xmqqwodmbewl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0A8BA72-E59A-11E9-98F2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Tue, Aug 27, 2019 at 2:07 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Unfortunately, this is _still_ incorrect.
> ...
> Just to clarify, I think my patch accounts for that (haven't tested
> that assumption, but will do now that I have a windows box, probably
> even with mi-alloc) but yes, the only reason why there were references
> to NEDMALLOC was to isolate the code and make sure the fix was
> tackling the problem, it was not my intention to do so at the end,
> specially once we agreed that xmalloc should be used anyway.
> ...
> apologize for the delays, and will be fine using your squash, mine,
> the V6 RC (my preference) or dropping this series from pu if that
> would help clear the ugliness of pu for windows

So,... have we seen any conclusion on this?  Can any of you guys
give us a pointer to or copies of the candidate to be the final
solution of this topic, please?

Thanks.
