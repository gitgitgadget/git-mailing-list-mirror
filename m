Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A3C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E41764E04
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBPRwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:52:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhBPRvt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 12:51:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80A471169A3;
        Tue, 16 Feb 2021 12:51:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z9f4isrRlnLj
        lLlk3Fuso5Y/qlY=; b=KcXLZKmdL+aOmZwn7I7fGx01U6uDeV10XSeR4DrXE8VU
        r7SuNYVl7au++xSsWFYMP733ECSHk1qOebwMmG2sxgUjyPT81xvZE0VIXVpiohmu
        s0FjfOZa+OQCwbMxj+GCci3OY8t4QbeaLxLe0XbB87GUFlLz4NU6WyK40OYI9PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jjeu7s
        NsxA8Riwfa2bQLJ8QMbpzYBj9Aa4pa/mHvdMfaXqVDAtvQJdDNGy32dbRMbHFwM9
        PUxk+/tCEia4rSu06OacQZz+IJKp7EHmDke1S0helsiENWufRvmSrrXNQH5CnfHX
        McJVuVvLB8UrYNNcuK0eBpkJLHlDNQc8HfZsU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78FFF1169A2;
        Tue, 16 Feb 2021 12:51:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C5C6A1169A1;
        Tue, 16 Feb 2021 12:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210215155020.2804-2-avarab@gmail.com>
        <xmqq7dn8u7dz.fsf@gitster.c.googlers.com>
        <10e6cd64-8c1c-20ea-154e-89fad6664a5e@kdbg.org>
Date:   Tue, 16 Feb 2021 09:51:00 -0800
In-Reply-To: <10e6cd64-8c1c-20ea-154e-89fad6664a5e@kdbg.org> (Johannes Sixt's
        message of "Tue, 16 Feb 2021 08:20:29 +0100")
Message-ID: <xmqq4kibsxyz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 891A2B86-707F-11EB-823A-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.02.21 um 02:30 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>> This new behavior does give us the edge case that if we e.g. view the
>>> diff here with "-U150 -W" we'd previously extend the context to the
>>> middle of the "is_func_rec()" function, and show that function in the
>>> hunk context. Now we'll show nothing.
>> To me, that sounds like a grave regression.  Why lose the
>> information?
>> This may be coming from the difference between us, i.e. I read a lot
>> more patches written by other people than my own changes written for
>> my next commit, so every bit of hint helps, and the name of the
>> function I am seeing its latter half in the precontext is sometimes
>> a useful thing to see.
>
> I totally agree with your assessment. I wouldn't even have removed the
> hunk header in the case of "-W wins", either, but that is a case that
> I can live with when others think it makes sense.

Ditto.

The information on @@ ... @@ line may look misleading especially to
those who are not used to reading patches in the "-W wins" case.  It
is otherwise not hurting anybody and it loses information to remove
it, but it is not as grave as in the "-U<n> wins" case, so I do not
mind losing it, if it helps them.


