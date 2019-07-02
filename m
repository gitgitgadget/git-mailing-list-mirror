Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4421F461
	for <e@80x24.org>; Tue,  2 Jul 2019 17:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfGBRUS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 13:20:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50043 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 13:20:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CA32153109;
        Tue,  2 Jul 2019 13:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jd3BfaDhIFlXzSpzRrACQxV6OaY=; b=eTtWfA
        3LwnYuJW/8/WoHHndjuXtkJtkykeksAAxXZPjxMuss/+3Enjpw1N1uukCuYf/Iol
        K5b6AlmEakaT13sGxjDwaYRgQgIrgg8YQyC9cij+klPBVVgBkaR34XK9GWvFEvzY
        7g2jl+t4PUTR3DD7x3tED4zVeyAozvYE5nb0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y/I0Rb4HgGzWteFA/uFtbu7sLeBG6qs+
        pb0fwVaBqPtmaIbdahV0h6cpA8lK85KMpkYSPjRiiIZFoLSRVosAl7Q+Fp6ypF+K
        WfusJTrJj6JhcuW11pHnnKLgeqvQxguhu77VeYM5UkSTIPKn5Y5UHnxpSIpVNT8h
        OSTK90GOsDA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24E94153108;
        Tue,  2 Jul 2019 13:20:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84157153107;
        Tue,  2 Jul 2019 13:20:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
References: <20190630051816.8814-1-eantoranz@gmail.com>
        <20190630065358.GB31264@sigill.intra.peff.net>
        <xmqq36jp7gd8.fsf@gitster-ct.c.googlers.com>
        <2cece7ff-49af-0cae-7cb8-7cc1821be1ca@gmail.com>
Date:   Tue, 02 Jul 2019 10:20:14 -0700
In-Reply-To: <2cece7ff-49af-0cae-7cb8-7cc1821be1ca@gmail.com> (Derrick
        Stolee's message of "Tue, 2 Jul 2019 07:37:39 -0400")
Message-ID: <xmqqr2784alt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8419DE4-9CED-11E9-B49B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/1/2019 2:35 PM, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>>> First, we create a (temporary) merge commit of both branches (M3)
>>>>
>>>> ------------
>>>> 	R1---R2---R3---R4---R5---R6---R7---M3
>>>> 	 \         \              \       /
>>>> 	  F1---F2---M1---F3---F4---M2---F5
>>>> ------------
>>>>
> ...
>> If M3 merge is always easier to manage than incremental stepwise
>> rebase of the topic, then doing the "git merge --reverse-squash"
>> would be a saner interface and also conceptually simpler.
>
> I agree that this would be a better way to expose this behavior,
> and likely the implementation could be very clean.

What I was sort-of hoping to get comments on was actually something
else.

Would there be cases where the merge M3 gets unmanageably complex
even if rebasing the feature commits one by one is relatively simple
(and how often would that happen)?  "merge --squash" would not work
well (and extending the command to merge in a different direction
would not help) in such a situation, but "rebase -i" would work
much better (and "imerge" would, too).
