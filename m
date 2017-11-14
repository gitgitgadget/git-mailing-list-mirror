Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B07201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbdKNCMG (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 21:12:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51204 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752774AbdKNCMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 21:12:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2003AB2E0;
        Mon, 13 Nov 2017 21:12:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AS9xSoxWxgTh
        mPO1bilfI4WgDQU=; b=oYcc4JYOHJmogOXA9AqxrpkggPVeEjZSsZzG1nktcR+u
        8M4m80zHYI750GjW/sAjnQzSCR/eOhuXiRKQKZbqcXhm/wku3szQ2iFLrsQ8ynpm
        vtgWavMgK16TPw62/z/pHEMJhmC99HNOKJgpZ31rHcQ7nN7MOQSznsVIyZUvRdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ewupjn
        s6CdbZw7QMLPBoFGLUF/rFp72uAVfQFFmlEMB9Fm+nTzrD/HGRNQpI2rzrXPHz+I
        yyulQd4nNfcEATz+6LgHwdK1toqctu6qDFMjY5NnTXQh16Yt2a2YnP8otQJMlnbB
        Vs3m8/J84HL6/hajlAlNppD/TqAnAxDDgQBVA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB2ABAB2DF;
        Mon, 13 Nov 2017 21:12:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A29AAB2DE;
        Mon, 13 Nov 2017 21:12:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charles Bailey <charles@hashpling.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix NO_LIBPCRE1_JIT to fully disable JIT
References: <20171112165938.8787-1-charles@hashpling.org>
        <87tvxzxm0j.fsf@evledraar.booking.com>
        <xmqqmv3qal78.fsf@gitster.mtv.corp.google.com>
        <20171113065410.rb43utcbncy7ndrv@hashpling.org>
Date:   Tue, 14 Nov 2017 11:12:03 +0900
In-Reply-To: <20171113065410.rb43utcbncy7ndrv@hashpling.org> (Charles Bailey's
        message of "Mon, 13 Nov 2017 06:54:10 +0000")
Message-ID: <xmqqefp17gng.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 351523B8-C8E1-11E7-B506-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

>> > But that we should take it anyway regardless of that since it'll *al=
so*
>> > work on Linux with your patch, and this logic makes some sense where=
as
>> > the other one clearly didn't and just worked by pure accident of som=
e
>> > toolchain semantics that I haven't figured out yet.
>>=20
>> That is curious and would be nice to know the answer to.
>
> The error that I was getting ...
> My guess is that we are just exposing a pre-existing bug in our Solaris
> build of libpcre.

Sorry, my question was not clear.  I think you already mentioned the
above in the thread.  What I was curious about was why =C3=86var was
seeing that JIT disabled with NO_LIBPCRE1_JIT alone on his Linux
setup, i.e. namely this part from his message:

    *But* for some reason you still get away with that on Linux. I
    don't know why, but I assume the compiler toolchain is more lax
    for some reason than on Solaris.n

In any case, thanks for a fix; queued.
