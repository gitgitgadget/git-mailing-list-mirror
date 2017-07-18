Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13D720356
	for <e@80x24.org>; Tue, 18 Jul 2017 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdGRRlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 13:41:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58247 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751379AbdGRRk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 13:40:59 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jul 2017 13:40:59 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A512748B2;
        Tue, 18 Jul 2017 13:35:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8HLZzlng9ZNptauSViYeSPqvbak=; b=Cdj51i
        XMCCDhbmjo1Tl2wftBbH7r/6uuMx3iV4Wn29JQap62QYc31GM37VWQTS9PFCJkV4
        Q+FmhNqMzfQCT2gBoWZzDNYMTR1tpA1e98ghvr1CpA7v0EZ7tLGh6+j2Nu0v/LVX
        obdElODMAhWoP+tb/cHLFLSmMwwRLFxdUxr7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q9u/IbXFrw11S5ztbCTMydeDoYhcQSiW
        usQsAPBdiLEYbdC0LNH5k7rwN/8eFpb8n3oniSd5ilmJX+ZS8m0imKy34utNBzh5
        T5hVVsByQvCzi1keAeoCtP8GsVSoQHf7x3LMSUGLrs1cqQ2krq4k0BHqtwTuJFw3
        YlePdCjJFGE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43309748B1;
        Tue, 18 Jul 2017 13:35:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8F97748B0;
        Tue, 18 Jul 2017 13:35:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
Date:   Tue, 18 Jul 2017 10:35:12 -0700
In-Reply-To: <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        (Jiang Xin's message of "Tue, 18 Jul 2017 09:33:43 +0800")
Message-ID: <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74A65BC8-6BDF-11E7-9E7A-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>> Two potential issues are:
>>
>>  - After this patch, there still are quite a many
>>
>>         printf("time is %"PRItime" ...\n", timestamp)
>>
>>    so the burden on the programmers having to remember when it is
>>    required to use format_raw_time() becomes unclear, and makes the
>>    change/churn larger when an existing message needs to be marked
>>    for translation.
>>
>>  - The static struct strbuf here is a cheap way to avoid leaks, but
>>    at the same time it is unfriendly to threaded code.  We could
>>    instead do:
>>
>>         void append_PRItime(struct strbuf *buf, timestamp_t time);
>>
>>    to fix that trivially, but the damage to the caller obviously is
>>    much larger going this way.
>>
>
> I wonder if we can replace the original %lu for timestamp with PRIuMAX
> instead.  PRIuMAX works fine with gettext utils.

I think the question can better be answered if we know how gettext
tools special case PRIuMAX.  One thing that may be problematic is
that timestamp can later become a signed type and use of one level
of redirection in the current code via PRItime and via timestamp_t
is a good way to keep such a transition much easier.  Reverting it
to use PRIuMAX would make such a transition much harder.
