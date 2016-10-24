Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC0A20193
	for <e@80x24.org>; Mon, 24 Oct 2016 23:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbcJXXxz (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 19:53:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55937 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754133AbcJXXxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 19:53:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09B91498F8;
        Mon, 24 Oct 2016 19:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3a4EQtVq1T+J
        PPFiWs4d99BOWxI=; b=wS1mzAl1rvjTMxeRr/vI4+IjQ5bCwOkHxKgyE+t7849Y
        o5LCW5aAGULuWKKazl+Ht727KYCMvsRdOyhY2Ai1R+1qK/HTLuVxYriKNTZRsZ/1
        R7rmkYBaM2tcjh8V+8Dg9plm9zz9hQfQYVNy+C9eWDO043KbotOeafquJPeisWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OS8HcF
        LD6o5vKSVpxu4WPFyVPxwcGhwISOy4+cZkT8RrJ4N4vCl7HJxYz7KumSgWZWnm8N
        c5OpD/gWDslovJy2MEi+o7jZE62bLMaqrD/hZHM1J0TvzOttF+H/Ds4xwf99MWMw
        GA9nsmE38pc09Q7gpBAoJOU18/eTgvR+rG7tI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01048498F7;
        Mon, 24 Oct 2016 19:53:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77566498F6;
        Mon, 24 Oct 2016 19:53:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
        <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
        <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
        <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
        <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
        <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
        <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
Date:   Mon, 24 Oct 2016 16:53:50 -0700
In-Reply-To: <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 25 Oct 2016 00:33:03 +0200")
Message-ID: <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E6A0834-9A45-11E6-94A8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 24.10.2016 um 19:27 schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>>> I think it would be preferable to just fix it inline in each place.
>>>
>>> Yeah, probably.
>>>
>>> My initial reaction to this was
>>>
>>>  char *sha1_to_hex(const unsigned char *sha1)
>>>  {
>>> -	static int bufno;
>>> +	static unsigned int bufno;
>>>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>>>  	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
>>>
>>> "ah, we do not even need bufno as uint; it could be ushort or even
>>> uchar".  If this were a 256 element ring buffer and the index were
>>> uchar, we wouldn't even be having this discussion, and "3 &" is a
>>> way to get a fake type that is a 2-bit unsigned integer that wraps
>>> around when incremented.
>>>
>>> But being explicit, especially when we know that we can rely on the
>>> fact that the compilers are usually intelligent enough, is a good
>>> idea, I would think.
>>>
>>> Isn't size_t often wider than uint, by the way?  It somehow makes me
>>> feel dirty to use it when we know we only care about the bottom two
>>> bit, especially with the explicit "bufno %=3D ARRAY_SIZE(hexbuffer)",
>>> but I may be simply superstitious in this case.  I dunno.
>>=20
>> If we are doing the wrap-around ourselves, I suspect that the index
>> should stay "int" (not even unsigned), as that is supposed to be the
>> most natural and performant type on the architecture.  Would it
>> still result in better code to use size_t instead?
>
> Right.
>
> Gcc emits an extra cltq instruction for x86-64 (Convert Long To Quad,
> i.e. 32-bit to 64-bit) if we wrap explicitly and still use an int in
> sha1_to_hex().  It doesn't if we use an unsigned int or size_t.  It
> also doesn't for get_pathname().  I guess updating the index variable
> only after use makes the difference there.
>
> But I think we can ignore that; it's just an extra cycle.  I only
> even noticed it when verifying that "% 4" is turned into "& 3"..
> Clang and icc don't add the cltq, by the way.
>
> So how about this?  It gets rid of magic number 3 and works for array
> size that's not a power of two.  And as a nice side effect it can't
> trigger a signed overflow anymore.

Looks good to me.  Peff?

> Just adding "unsigned" looks more attractive to me for some reason.
> Perhaps I stared enough at the code to get used to the magic values
> there..

I somehow share that feeling, too.
