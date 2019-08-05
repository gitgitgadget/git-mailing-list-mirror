Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF6D1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfHEUQ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 16:16:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60898 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfHEUQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 16:16:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 388FF175641;
        Mon,  5 Aug 2019 16:16:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QYU20+Z9X/6chOFxoXoscfouYvw=; b=vm+81C
        8VriQCyeVsNTjZSxChr62Ingg6iQQAMuKCKVaK5+R9ICnAA0ju6r6Jf2adSgWjtw
        Kz9IUpGXgQ90s1uREryCXUfP3CYnGBTNFhbXRbUPFPM75PHNtR5b4Riuwpw5p/UG
        yNl5lPiAuy9tDreRRi9jDCYWQysH1/4cOsX0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vwSsFS/YqB4Jtn+Lo0ltp1Tv+VE3wvKr
        SRS5WmxhJPskzwkleQ/Z7mZFtQCzJXQnsWzMuOI3d9st1VadVxRbwt4vsVh/P4fm
        oxGNT8Akh51cU38edwetL+sStcfBkhqH0Zp+lzlj2INaHtPqawcDnZ2U0obDdqFo
        UW7c7M1wgyM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 307B9175640;
        Mon,  5 Aug 2019 16:16:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89F7717563F;
        Mon,  5 Aug 2019 16:16:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        l.s.r@web.de
Subject: Re: [RFC PATCH v3] grep: treat PCRE2 jit compilation memory error as non fatal
References: <20190729105955.44390-1-carenas@gmail.com>
        <20190804031409.32764-1-carenas@gmail.com>
        <CAPUEspjOtzFxDLrQzLLU7+Q6Z6V8P0=qNrH2NrOzL7Q884krrQ@mail.gmail.com>
Date:   Mon, 05 Aug 2019 13:16:54 -0700
In-Reply-To: <CAPUEspjOtzFxDLrQzLLU7+Q6Z6V8P0=qNrH2NrOzL7Q884krrQ@mail.gmail.com>
        (Carlo Arenas's message of "Sun, 4 Aug 2019 00:43:17 -0700")
Message-ID: <xmqqef1zmkp5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F868ABBA-B7BD-11E9-B648-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> * code is suspiciously similar to one[2] that was rejected, but
> hopefully commit message is better
> ...
> [2] https://public-inbox.org/git/20181209230024.43444-3-carenas@gmail.com/

I do not recall ever rejecting that one.

It did not come with a good proposed log message to be accepted
as-is, so I do not find it surprising that I did not pick it up, was
waiting for a new iteration and then everybody forgot about it.

But that is quite different from getting rejected (with the
connotation that "don't attempt this bad idea again, unless the
world changes drastically").

In any case, this round looks a lot more reasoned.  I personally do
not think the warning() is a good idea.  As I said in the old
discussion, we by default should treat JIT as a mere optimization,
and we should stay out of the way most of the time.

An additional "must have JIT or we will die" [*1*] can be added on
top of this change, if somebody really cares.

Thanks.


[Reference]

*1* https://public-inbox.org/git/87pnu9yekk.fsf@evledraar.gmail.com/
