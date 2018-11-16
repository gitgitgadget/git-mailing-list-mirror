Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500DD1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 04:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKPOZm (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 09:25:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56798 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeKPOZl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 09:25:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAAFF129BDA;
        Thu, 15 Nov 2018 23:14:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vdBjLtrNZsyr
        m4Fs8SV0DDztAzo=; b=GHnLHMraBaXe4N/VynCSI2SDN3HVHZWkweV4Kcd/JI06
        ZzE0r862WQLhYhSdYJRAu75o6U19fwkyPLlAikZQoljNRDEtkRUJEsKjqwUXhuDN
        zOv5Dq8H2U1IdSRnhMyYbXlD5CyX3MKf533D9ovHAs0noq11eQ+I+ZKTRjvUCpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uMys+J
        /U9DJN8CsAZ7gVr/aUkZZBt++oiwNVpy8XM5uzV+KLpLgPx5Upii46ir6t4zRDjU
        S5QjHytavTXCEtdnxfqzQ9FlE0AdDvuySYFlra7t8/+VoVikrL0ME0GuDXLPtQWB
        R2u1AJ8Kz6eGBtT8brjzuKlzw8VCjAxVNc4xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2D1B129BD9;
        Thu, 15 Nov 2018 23:14:55 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11A78129BD8;
        Thu, 15 Nov 2018 23:14:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] clone: respect configured fetch respecs during initial fetch
References: <20181114104620.32478-1-szeder.dev@gmail.com>
        <20181115110802.GD19032@sigill.intra.peff.net>
Date:   Fri, 16 Nov 2018 13:14:54 +0900
In-Reply-To: <20181115110802.GD19032@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Nov 2018 06:08:02 -0500")
Message-ID: <xmqq7ehdlku9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C1506C0-E956-11E8-815E-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 14, 2018 at 11:46:17AM +0100, SZEDER G=C3=A1bor wrote:
>
>> This patch series should have been marked as v6, but I chose to reset
>> the counter, because:
>>=20
>>   - v5 was sent out way over a year ago [1], and surely everybody has
>>     forgotten about it since then anyway.  But more importantly:
>>=20
>>   - A lot has happened since then, most notably we now have a refspec
>>     API, which makes this patch series much simpler (now it only
>>     touches 'builtin/clone.c', the previous version had to add stuff
>>     to 'remote.{c,h}' as well).
>
> Thanks for sticking with this!
>
> I skimmed over the old discussion, mostly just to make sure there wasn'=
t
> anything subtle that might have been forgotten. But nope, all of the
> subtlety went away because of the refspec API you mentioned.
>
> The whole series looks good to me.

Thanks, both.
