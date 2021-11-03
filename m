Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DDC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 22:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D583D610EA
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCWPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 18:15:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59590 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCWP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 18:15:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E3AA16781B;
        Wed,  3 Nov 2021 18:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MK8Fz+zmWju/
        OhlfW+AaP/5vC4K4TxbiOKN4xwGRvGA=; b=e33EJVaNxkyBqECNDvQrw5TY2wZw
        EOfkxfICZ3n2T1S41DiILkzC0ElSUuHRKQ11xTQifuL07aWiSTDVQubzIB3QT4k6
        4451dbfA8mioCtjmQmi2KY3DeEDQltejJTY9y2u73/F8QXNZBtR+BkodVN0kvX88
        Woc9xaKt7gcZwy8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5635F16781A;
        Wed,  3 Nov 2021 18:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10682167818;
        Wed,  3 Nov 2021 18:12:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: test suite speedups via some not-so-crazy ideas
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
        <20211026201448.GA29480@dcvr>
        <211030.86ee8246hy.gmgdl@evledraar.gmail.com>
        <211103.864k8t1sma.gmgdl@evledraar.gmail.com>
Date:   Wed, 03 Nov 2021 15:12:47 -0700
In-Reply-To: <211103.864k8t1sma.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 03 Nov 2021 10:24:57 +0100")
Message-ID: <xmqqbl306g80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E29A36E-3CF3-11EC-A30D-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>  8. To a first approximation, does anyone really care about getting an
>     exhaustive list of all failures in a run, or just that we have *a*
>     failure? You can always do an exhaustive run later.

I do, not necessarily because I want to catch all failures, but
mostly because I want to use the the number of failing tests as a
rough sanity check.  I expect that the number is low, but not
necessarily zero, in the normal state, but if I see many in a run,
that rings different bells.  If we stop at the first failure, it
becomes harder to do this, and having to go there and restart with
"this time run the full set" manually is not really feasible.


