Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B3C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E86461205
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhIJWGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:06:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52694 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhIJWGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 18:06:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7826C14A423;
        Fri, 10 Sep 2021 18:05:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BhJ8PJpRdHMz
        /WwpIX4SxyKlhwqSzJUG9Pe2HC2O9uI=; b=ycnsndYjQW7QZZrNLOlYzrPsTZf4
        29hEhEo4+9uCTHBgmfNLq0HIBXhnRbVvUNT8HKawdCI4q0y2bhLColMeE+SSp/pX
        LLQPQ6nfVCfglxlPXZI+MQpIHk9JFkTWTicAM7dmYYU/D+87ZkUafCL4Y7m7a/s1
        zlT+MakbsGoXnCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D06B14A422;
        Fri, 10 Sep 2021 18:05:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7A2714A420;
        Fri, 10 Sep 2021 18:05:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] test-tool run-command: fix confusing init pattern
References: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
        <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2109101319110.59@tvgsbejvaqbjf.bet>
        <87pmtgb4m1.fsf@evledraar.gmail.com>
Date:   Fri, 10 Sep 2021 15:05:22 -0700
In-Reply-To: <87pmtgb4m1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 10 Sep 2021 21:32:03 +0200")
Message-ID: <xmqq1r5wrsrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 326D53F2-1283-11EC-B33A-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> The diff does too many things, some of which are your purely personal
>> preferences and do not actually need to be changed. This is a much mor=
e
>> to-the-point diff:
>
> We've been slowly converting everything to designated initializers. It
> seems to make sense to just do that if the line is being touched anyway=
.

Perhaps a preliminary clean-up patch is called for in such a case?

I do not think anybody can immediately see what the difference
between the old -1 and the new 0 in TESTSUITE_INIT macro means in
Dscho's alternative, but if we had a preliminary clean-up whose sole
change is to use designated initializers, the real "to-the-point"
step would become much easier to see which member that used to be
initialized to -1 is now getting zero-initialized.

And yes, changing the initializer style *and* the values the members
are initialized to in a same patch is much worse than sticking to
the style of the unreadable original.  It buries the real change in
the noise.

>>  #define TESTSUITE_INIT \
>> -	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
>> +	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0 }
