Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC4F1F45F
	for <e@80x24.org>; Tue,  7 May 2019 02:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfEGCme (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 22:42:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57670 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGCme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 22:42:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 073B6144855;
        Mon,  6 May 2019 22:42:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XJbdg4HhlE40zq8GVgbxq3Or4EI=; b=EQS6vF
        1q5v0kTwiccGjecvmVla+WjbRGdTiBzfOG5YC54ajGLjZ+hQtfMab+8CjF/EM2Wl
        cxpUMbo/8rKdIEOi3pPmLlKoebXZVd4Al3IflYAK3Brg8CS0mvNxmj04G5r34gB3
        scm3+9cQI0zjk/DHAp+qKtN3KqV8yBljFowzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qmPEvqcOgtYZbQRKdEwPU5EYXl9JRYOp
        +ygsjMKNEr7Z58S5rIyo5X86z778dvJg51yU/w7EJB0O0erdxhoO7GEdYDloTshD
        lwhwfFWDsdayzORLFjp3Y4OFqmSLG9dYBMfTv/2niOj+a2YkXf69clPH0ntlB9r2
        S1w8Gp/WSro=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F296B144854;
        Mon,  6 May 2019 22:42:29 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6924F144853;
        Mon,  6 May 2019 22:42:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
References: <20190425120758.GD8695@szeder.dev>
        <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
        <20190501100108.GA8954@archbookpro.localdomain>
        <20190502000422.GF14763@szeder.dev>
        <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
        <20190503144211.GH14763@szeder.dev>
        <20190503174503.GA8242@sigill.intra.peff.net>
        <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
        <20190506051148.GB30003@sigill.intra.peff.net>
        <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
        <20190506234334.GA13296@sigill.intra.peff.net>
Date:   Tue, 07 May 2019 11:42:28 +0900
In-Reply-To: <20190506234334.GA13296@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 6 May 2019 19:43:34 -0400")
Message-ID: <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1AD1194-7071-11E9-917C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The implementation is done with xargs, which should be widely available;
> it's in POSIX, we rely on it already in the test suite. And "coccicheck"
> is really a developer-only tool anyway, so it's not a big deal if
> obscure systems can't run it.

OK.

> I left the default at 1 for safety. Probably 4 or 16 would be an OK
> default, but I don't have any interest in figuring out exactly what
> Travis or some hypothetical average machine can handle. I'll be setting
> mine to 999. ;)
>
> Making "0" work as "unlimited" might be nice, but xargs doesn't support
> that and I didn't want to make the recipe any more unreadable than it
> already is.

Sounds good.  After reading the log message, I was curious if there
is a mechanism that makes 999 special (like 0 in your hypothetical
"0 means unlimited"), but I guess it is just "any number that is
greater than the number of source files we have will do".

Thanks.
