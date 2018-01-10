Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBAA21F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeAJUWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:22:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63508 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeAJUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:22:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AF20B6EE4;
        Wed, 10 Jan 2018 15:22:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YQPiLs54EkmDOiTvax6TQYQusUc=; b=dmIRMM
        ve/HDcJG0WMkjhlfsEXm5/GGYyM+YLAxNAH1hzc97QomXrOI5F+6yNwUvbrtzk2g
        Qvcu8wFoSRO+yJbA1Xhh/eOtYOYQU9euqmsRkXHrdBTETvokefSBfkI1vWG9La2g
        01LEHkbchUdUQZUxOnPc7AFINsdo1RxYs8DVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZiquJaZqyxavGuGILos6B/BI9ziezGfI
        wgxZAPydb7NCxf8DR1l6W7vHyfLgFsxma/2ZjPd8PLGeqcm9zx9vNeTkrXpLWNUY
        bQ+va9ZtdMLnPO1adc3PebmeeH7kntPmvA+KD9w31dW6Xlnmuu1u210jc3vkIxWS
        xRnZAjFmlxo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 416E8B6EE2;
        Wed, 10 Jan 2018 15:22:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A339DB6EDE;
        Wed, 10 Jan 2018 15:22:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
References: <20180108154822.54829-1-git@jeffhostetler.com>
        <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
        <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
        <20180109072044.GD32257@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
        <20180110074701.GB16315@sigill.intra.peff.net>
Date:   Wed, 10 Jan 2018 12:22:10 -0800
In-Reply-To: <20180110074701.GB16315@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 10 Jan 2018 02:47:01 -0500")
Message-ID: <xmqqfu7d1n2l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0936228-F643-11E7-8F73-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To be clear, which approach are we talking about? I think there are
> three options:
>
>   1. The user tells us not to bother computing real ahead/behind values.
>      We always say "same" or "not the same".
>
>   2. The user tells us not to bother computing ahead/behind values
>      with more effort than N. After traversing N commits without getting
>      an answer, we say "same" or "not the same". But we may sometimes
>      give a real answer if we found it within N.
>
>   3. The user tells us not to spend more effort than N. After traversing
>      N commits we try to make some partial statement based on
>      generations (or commit timestamps as a proxy for them).
>
> I agree that (3) is probably not going to be useful enough in the
> general case to merit the implementation effort and confusion. But is
> there anything wrong with (2)?

I agree (3) would not be all that interesting.  Offhand I do not see
a problem with (2).  I think with "real" in your "sometimes give a
real answer" you meant to say that we limit our answers to just one
three ("same", "not the same", "ahead/behind by exactly N/M") and I
think it is a good choice that is easy to explain.

We might be able to say things other than these three, namely,
"ahead by no more than N, behind by no more than M", but I do not
know if that is useful or merely more confusing than it's worth.
