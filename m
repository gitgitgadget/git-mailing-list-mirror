Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292E51F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1PhY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:37:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60606 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1PhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:37:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C96487BCB;
        Wed, 28 Aug 2019 11:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/UB36me7of6U+JScJl+XpG1vIcY=; b=D/9Sit
        mNJk5DTmUElzcqQS3cAepdC9k2tvwAh0u9rdjSY2XLInCGhDMIDe0tOxRW16cfhu
        ZDooKyJtq2xbghgvuJdyWwiR4qxPYczmuinRxDPIKbkOzhIR2HrvICG1d4w28H0q
        NLuspDdpYzjaNIwHdD54sReBTX9L0S8ankFLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b5QNqMnW0erF/GAipdJ4Xu+WGfxM024Z
        MBUn7h289J301ro9meb8B0dZODaAK6Wt2PFA3mfFe3iYIty83kdPzpu/5/lIe9LD
        ZnQnQCwXjhtrGsgSZg+ChpTBVmlc781oIrXsYNmIhqNmT2BdApQDhHvX2hxyc++K
        hQPYsMQe5HY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 851F587BC9;
        Wed, 28 Aug 2019 11:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9281387BC7;
        Wed, 28 Aug 2019 11:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/11] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com>
        <xmqq1ry6qeg2.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908262317250.46@tvgsbejvaqbjf.bet>
        <xmqq5zmi2qkp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908281705230.46@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Aug 2019 08:37:16 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908281705230.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 28 Aug 2019 17:06:36 +0200 (CEST)")
Message-ID: <xmqqd0gp1etv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B80ED816-C9A9-11E9-ABBB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Ah, so "add.usebuiltin = interactive patch" can (eventually) choose
>> to use the C code for both while "add.usebuiltin = interactive"
>> would not use it for the patch mode, or something?  Or even
>>
>> 	add.interactive.usebuiltin = yes
>
> This is what I had in mind.
>
>> 	add.patch.usebuiltin = no
>
> And this is what I should have done ;-)
>
> But maybe I should do
>
> 	add.useBuiltin = wheneverPossible

Ah, either is fine, I think, but because this is meant to be
temporary and not advertised to end-users for purposes other than
purely an escape hatch, I would not spend too much engineering
effort (iow, do the easiest to add and then easiest to later yank
out).

Thanks.

