Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C734BC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FB1610CB
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbhHaQYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:24:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59870 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhHaQYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:24:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F0EFDBCF7;
        Tue, 31 Aug 2021 12:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CWcp/y0mrfj71U8VgZjsBAlmudbAX+KFn7ZU3n
        g//Hk=; b=AQVnJcuziGUre8mtqsz1ubn2aBrErT4IutsVOvi9DrtxwRVkxIYVpF
        wB3euB5ziLXuzN77JyAze9BbChmexiRf2NtHs3ajy3O+LcXHP7nyITiWAZuHN6l2
        WuqD5YkrEzVAIBKSMw8ZYoHmGIKzVjoDimu4RxJpresjnVPuhwA58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15E99DBCF6;
        Tue, 31 Aug 2021 12:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95F63DBCF5;
        Tue, 31 Aug 2021 12:23:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bruno Albuquerque <bga@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Stef Bon <stefbon@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
        <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
        <xmqq35qq4t1x.fsf@gitster.g>
        <YS1DnGTDo5ZG8Iw4@coredump.intra.peff.net>
        <xmqq4kb639xt.fsf@gitster.g> <87sfypwuwx.fsf@evledraar.gmail.com>
        <CAPeR6H7_V+ypzyN39e27+NCRqG-nA17sgq=qtefzFF3Dg50bnA@mail.gmail.com>
Date:   Tue, 31 Aug 2021 09:23:08 -0700
In-Reply-To: <CAPeR6H7_V+ypzyN39e27+NCRqG-nA17sgq=qtefzFF3Dg50bnA@mail.gmail.com>
        (Bruno Albuquerque's message of "Tue, 31 Aug 2021 08:35:22 -0700")
Message-ID: <xmqqv93lwplf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAFF5436-0A77-11EC-93ED-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Albuquerque <bga@google.com> writes:

> With all that being said, I don' t think making it optional would be
> an issue so I have no strong feelings about this. I am fine with
> whatever is agreed to be the best approach.
>
>> I found myself wondering this when reading serve.c the other day,
>> i.e. why we have "always_advertise" for object-info, but it seemed
>> innocuous enough given how it's described in a2ba162cda2 (object-info:
>> support for retrieving object info, 2021-04-20).
> For what it is worth, The same change is now being reviewed in JGit
> and there the feature is conditionally enabled. But that was a
> side-effect of needing to deploy it to multiple servers before making
> the feature available to clients.

FWIW, I do not mind, and probably prefer if I think about it a bit
longer, to make it an opt-in feature, like all other capabilities
defined in the serve.c file.

Thanks.

