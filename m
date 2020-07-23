Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE0C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 21:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79825207C4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 21:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FwLYQIpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgGWVjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:39:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63230 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWVjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 17:39:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FE53D4D37;
        Thu, 23 Jul 2020 17:39:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yMAZX+cDyntTafnWxUxEukw+gl0=; b=FwLYQI
        pUB2axy4yfmf1H7W9dij0Anyo/fA2Fxnoo2zbtfPXKTDnXpoDb0ihEYqv+RTVOVa
        JuAHyxEJumALnE8Zde+pIsnsF7EcKCGZot7iU1DM0TX3uF4vJT9LLJ20v6mK8t7u
        on5jDF+fyTVL7rTeIsD2KbNXuq9OUKbcYq0hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YBAFkMNIqbVaHUZNGntwtf5hZlhqfGsU
        ktsKjkRjtCWWXsYOneq6gghpM2Pf1oHw4zSF/CWObGc6JlVs87qaDoEsG5p6haFD
        I9tmxXnNrRRtEfKRJrGCK/MiHtKTjOhvPB/2DE0hbZF1oRmirbzpvCLf+gWklFpb
        +0UtLnp14IQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78B32D4D36;
        Thu, 23 Jul 2020 17:39:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2745D4D30;
        Thu, 23 Jul 2020 17:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
        <87blk6yrlc.fsf@osv.gnss.ru>
Date:   Thu, 23 Jul 2020 14:39:03 -0700
In-Reply-To: <87blk6yrlc.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        23 Jul 2020 22:11:11 +0300")
Message-ID: <xmqqimedq5c8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEDFB248-CD2C-11EA-B783-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> You can also do it after "git merge" aborts with conflicts by running:
>>
>>   git checkout --conflict=diff3 my-file
>>
>> but do note that it will check out from the index, overwriting any
>> resolution you've already done in that file.
>
> Though now it gets really odd "git merge" itself doesn't have this
> option.

A command line option is cumbersome that you have to type it every
time, so configuration variable makes 100% more sense than an option
to "git merge".  

If your merge used the merge (as opposed to diff3) style, and seeing
that the resulting conflict is not easy to review and you wish you
used diff3 style instead, it is way too late for any option to "git
merge" to help you.

But having an option to "git checkout" lets you move forward from
that state, so it also makes 100% more sense than an option to "git
merge".

So, it is not odd at all.  Just compare between merge and diff3,
think which one would often help you, configure to use it by default,
*and* at a rare occasion where the chosen default does not work for
you, let "checkout" help you.  The thing is, unless you first attempt
to "git merge", you won't know what shape of conflict you would get,
so you cannot choose the right conflict style command line option,
even if one were available.
