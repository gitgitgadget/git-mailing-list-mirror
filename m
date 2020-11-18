Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBECCC63777
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6404B247BA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SNuDSYM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKRP46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 10:56:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56826 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgKRP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 10:56:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADC6E9EC88;
        Wed, 18 Nov 2020 10:56:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pq0s8KC5DMh5
        wCFpXQHyvVp2Rc8=; b=SNuDSYM2ODnUeoVlCPBfI5yU8OtCoDdrNFgvluhGZUcX
        TMfXX0e38sLCaf0PDRcrkzD6n/fPkJBPKI2b3jkjDpD5A4St2f3jzpS1J7ii9Qz6
        51v+WFydJKVMKRXySuVw9M9btmr2kFaOsMIGJfEXB4JWSlfyMB1zFoQEsFDOpzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IJKU1U
        ZsjOW9mS6KoVDR/Al/NmSHjSwpQNPj2ZKLRvUpRX1SzlvSlORnexluj2sGEqeFYM
        yFw8mZbcRXiGC5/a8KYhBZeeQATg9huuMfVbgfAogNiZ+PvkzAhr45dzQ1vBJuMV
        sq1vuf7EzjNMualzFMHUtMzHRzOHYvPas2weo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B94D9EC87;
        Wed, 18 Nov 2020 10:56:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E317D9EC86;
        Wed, 18 Nov 2020 10:56:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
        <20201113161320.16458-1-avarab@gmail.com>
        <20201113191418.GA764688@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
        <87h7psg6lz.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet>
        <87ima2rdsm.fsf@evledraar.gmail.com>
Date:   Wed, 18 Nov 2020 07:56:54 -0800
In-Reply-To: <87ima2rdsm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 18 Nov 2020 14:32:25 +0100")
Message-ID: <xmqqsg963bg9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE45F526-29B6-11EB-9A8F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... In my mind that doesn't even require a
> consideration of the political motivations at this point as far as
> git.git is concerned, just:
>
>  1. Major Git hosting providers already made the change
>
>  2. Realistically a lot/majority of git's user base interact with that
>     in a major way.
>
>  3. A discrepancy in any default between /usr/bin/git and those
>     providers is more confusing than not.
>
>  4. #3 doesn't mean they say "jump" we say "how high" whatever the
>     change is.
>
>     But in this case the default is an entirely arbitrary default. Not
>     e.g. that they decided to add some ill-thought out header to the
>     object format or whatever.

Yes.

> P.S.: Shouldn't the pull patch in d18c950a69f be using the advice
>      facility, not warning()?

I think warning() is the right thing here, as it is self squelching.
Setting pull.rebase (even to 'false') is sufficient---there is no
need to set advise.setpullrebase to 'false' on top.
