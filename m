Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24521F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbeKMLsY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:48:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61475 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMLsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:48:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58929112816;
        Mon, 12 Nov 2018 20:52:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E9d1Ou6Sc/mLqNSOFRxPwSUHE+o=; b=mZv9YR
        PKBAvTd+mVn8YIW4fgEfOaoJ2WKxIu/3vrlMiiPxolXQ1HfG0yel8bfmypCbKU3c
        N+/fhsmoqOBVSQhhyFbbqr2501k3kQO3guRqr3SZADBYIfAThwjDQgmk7waIp5+j
        E+Kjkl6HInLvSlU6YEc4u1O6G7ir9zQahHlJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nxEA3EhAd6bRG0yFKu7CuewwE967wzZa
        aYgIi77/ksd9PhpNLh1iMwTumQCvH6jdn33pVj8VR43YQ1WcvT/RQAdSl7CRh2Ty
        Ra9ftzKDsM6o7FFSx0My8eLjxm5HcPQge7vb+3L02C9orPkUzQ5HnlyZgVMtzzhW
        j9rYP6iGlJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F779112815;
        Mon, 12 Nov 2018 20:52:33 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEDD9112812;
        Mon, 12 Nov 2018 20:52:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
        <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
        <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
        <20181112131247.GL3956@sigill.intra.peff.net>
Date:   Tue, 13 Nov 2018 10:52:31 +0900
In-Reply-To: <20181112131247.GL3956@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 12 Nov 2018 08:12:47 -0500")
Message-ID: <xmqqwophyc9s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9347246-E6E6-11E8-A94C-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> You mean something like
>> 
>> 			v->s = xstrfmt("%"PRIdMAX, (intmax_t)oi->disk_size);
>
> I think elsewhere we simply use PRIuMAX for printing large sizes via
> off_t; we know this value isn't going to be negative.
>
> I'm not opposed to PRIdMAX, which _is_ more accurate, but...
>
>> P.S.: I wondered whether we have precedent for PRIdMAX, as we used to use
>> only PRIuMAX, but yes: JeffH's json-writer uses PRIdMAX.
>
> That's pretty recent. I won't be surprised if we have to do some
> preprocessor trickery to handle that at some point. We have a PRIuMAX
> fallback already. That comes from c4001d92be (Use off_t when we really
> mean a file offset., 2007-03-06), but it's not clear to me if that was
> motivated by a real platform or an over-abundance of caution.
>
> I'm OK with just using PRIdMAX as appropriate for now. It will serve as
> a weather-balloon, and we can #define our way out of it later if need
> be.

I am OK if we avoid PRIdMAX and use PRIuMAX instead with a cast to
the corresponding size in this codepath, as long as we properly
handle negative oi.disk_size field, which may be telling some
"unusual" condition to us.


