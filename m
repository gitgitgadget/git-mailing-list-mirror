Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618821F731
	for <e@80x24.org>; Wed, 31 Jul 2019 16:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfGaQK4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 12:10:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55029 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaQKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 12:10:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96056158ED5;
        Wed, 31 Jul 2019 12:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rb6VPLskmqGtIKLaMdp62oNsSmU=; b=WCZfma
        k7P4rGjWPEoE9o1QaXdXWCS7dSyURvU9rt8P7k7kEjd7tyuVi0IZ44VAQbSsJmCL
        Ypot5rUJUqCUCjzcF9pRFCmmxD/+DH1o/qCO7+K+yLqk/lGkbVd7D4ViTQNyRsx9
        fRP/y3CQ9Xm96HmKNFFqLEbIPGyDWLb44fWWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J1aKA2msEZbnjbyqS7KbznbxfAsjW5Rf
        7E7Sf0f4+L+2LPdJhpQxL0Io9Fc0CdbBZ2uJ9K1XgmkKwYc9wSka7tEs4TO0jpyd
        hQk9xBRhOi9hIcrLJ965tNLgQcWhls0G5mEvZjoYJEaZxmibKc0pQ0ecm2SMzgRs
        +xv7oM6ciJg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EA17158ED4;
        Wed, 31 Jul 2019 12:10:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7DC8158ED3;
        Wed, 31 Jul 2019 12:10:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Cc:     Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
Subject: Re: `@` alias for `HEAD` not working in `git push -u origin @`
References: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com>
        <20190710233937.GG9224@genre.crustytoothpaste.net>
        <20190731055832.GA18039@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 09:10:47 -0700
In-Reply-To: <20190731055832.GA18039@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Jul 2019 01:58:33 -0400")
Message-ID: <xmqqsgqmqj5k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C299797E-B3AD-11E9-A2D1-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 10, 2019 at 11:39:37PM +0000, brian m. carlson wrote:
>
>> This is a bug. If the destination side of a refspec is omitted, and the
>> source side resolves to a ref starting with "refs/heads/" or
>> "refs/tags/" (which I expect it does here), then that ref is used as the
>> destination.
>> 
>> I submitted a patch at [0], but it was decided not to pick it up. If
>> Junio and the list decide that it's wanted, I'm happy to resend or
>> revise and resend.
>> 
>> [0] https://public-inbox.org/git/20180729192803.1047050-1-sandals@crustytoothpaste.net/
>
> I see I was cc'd on that original, but I don't remember ever reading it.
> It seems like a sane enough idea to me.

I see I was also on the cc list; I am not sure what I thought about
the patch (i.e. implementation, not the desire to use '@' in the
context in place for "HEAD") back then.

Now I read it with everything I thought forgotten, I see two
potential issues:

 - Any error message downstream will mention "HEAD" and there won't
   be a trace of it originally being an "@" sign.  It may not be a
   problem, especially for those who _KNOW_ that they should be
   typing HEAD but can type "@" instead, but I am not sure what to
   do those who do not know much about "HEAD" and start from "@" (by
   the way, it is one reason why I do not like encouraging "@",
   especially in introductory text).

 - The code should update llen to 4; right now the remainder of the
   function does not use the variable in a way that the discrepancy
   of replacing "@" with "HEAD" without updating llen matters, but
   relying on the shape of the code that happens to exist right now
   is a bad code hygiene.

Other than that, the patch looks sensible to me.


> Although I did notice that you mentioned there:
>
>> I probably type "git push upstream HEAD" from five to thirty times a
>> day
>
> I find I do that rarely, because I have:
>
>   [push]
>   default = current
>
> and in a triangular workflow, I have:
>
>   [remote]
>   pushDefault = upstream
>
> So "git push" without arguments typically does the same thing for me.
>
> Not an argument against your patch, but just something you might find
> useful.

That's a helpful tangent.  Thanks.
