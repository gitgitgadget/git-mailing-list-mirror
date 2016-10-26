Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5112F2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 17:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbcJZRxw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 13:53:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51836 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752618AbcJZRxv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 13:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC26848DB0;
        Wed, 26 Oct 2016 13:53:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nZm4Z35p4kuf
        W46wSrl204wyMD4=; b=mhtHVpfALg3tZEndnqer0xx0jP3HsY2jfX7rS0u65Tng
        QiPcIoRC0ghYEcHYvYlxCkBuBzF0uOsNitkzI9zoRFDgIALGjAMAyHjoTEsk0Dk/
        G8JUF/L/b3xPXtvO+AIYlfi2O2WGq4NKS29wlRMu65DtbNvNv4C2wnzqADp7Or4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tb0LTZ
        G4fBtFC8V2qofHal6l6AP3DNBVcXLRDYhsU3A8U1ZkwixpnvkovPDCHB8+G6KSan
        JYqlIpml6+rr3ukHKf6zhe+Q0wYjmazDRnRoAEBIIM81S75obJYDf+wUPfUcKKid
        TiJ3Fc1DVSNBesMvLyTdvk5Exni6NpM3po6Vk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B45FE48DAF;
        Wed, 26 Oct 2016 13:53:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3543148DAE;
        Wed, 26 Oct 2016 13:53:49 -0400 (EDT)
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
        <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
        <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net>
        <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
        <3c95a89a-2a9b-2856-42a1-6b994f2e31cd@web.de>
Date:   Wed, 26 Oct 2016 10:53:47 -0700
In-Reply-To: <3c95a89a-2a9b-2856-42a1-6b994f2e31cd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 26 Oct 2016 19:08:41 +0200")
Message-ID: <xmqqlgxbatec.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2617008A-9BA5-11E6-BC4B-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Actually I didn't sign-off on purpose originally.  But OK, let's keep
> the version below.  I just feel strangely sad seeing that concise magic
> go.  Nevermind.

I actually share the sadness, too, but let's be stupid and obvious
here.

Thanks.

>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>
>> -- >8 --
>> From: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> Date: Sun, 23 Oct 2016 19:57:30 +0200
>> Subject: [PATCH] hex: make wraparound of the index into ring-buffer ex=
plicit
>>
>> Overflow is defined for unsigned integers, but not for signed ones.
>>
>> We could make the ring-buffer index in sha1_to_hex() and
>> get_pathname() unsigned to be on the safe side to resolve this, but
>> let's make it explicit that we are wrapping around at whatever the
>> number of elements the ring-buffer has.  The compiler is smart enough
>> to turn modulus into bitmask for these codepaths that use
>> ring-buffers of a size that is a power of 2.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  hex.c  | 3 ++-
>>  path.c | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hex.c b/hex.c
>> index ab2610e498..845b01a874 100644
>> --- a/hex.c
>> +++ b/hex.c
>> @@ -78,7 +78,8 @@ char *sha1_to_hex(const unsigned char *sha1)
>>  {
>>  	static int bufno;
>>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>> -	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
>> +	bufno =3D (bufno + 1) % ARRAY_SIZE(hexbuffer);
>> +	return sha1_to_hex_r(hexbuffer[bufno], sha1);
>>  }
>>
>>  char *oid_to_hex(const struct object_id *oid)
>> diff --git a/path.c b/path.c
>> index fe3c4d96c6..9bfaeda207 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -24,7 +24,8 @@ static struct strbuf *get_pathname(void)
>>  		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
>>  	};
>>  	static int index;
>> -	struct strbuf *sb =3D &pathname_array[3 & ++index];
>> +	struct strbuf *sb =3D &pathname_array[index];
>> +	index =3D (index + 1) % ARRAY_SIZE(pathname_array);
>>  	strbuf_reset(sb);
>>  	return sb;
>>  }
>>
