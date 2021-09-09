Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780DC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969E3610C9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhIIXXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:23:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54348 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbhIIXXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:23:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08383141DC9;
        Thu,  9 Sep 2021 19:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tBatsdxio0LL
        oOUY4mSscMt9Rt8An3Uogq/CMD/5Gnw=; b=ORFt1XBNHtBha5OipebA1/iT6ig/
        rZFaPB9NlcYfcyVvRTiaKTBQO2Esw5pAZNJYugdHpjWo07Dlwv5Oq5G3Oe97WGgY
        We+hBKX3+OIpOMr5x4aFwuMI/A5mtUcILnnCK6FdoiYAQdlyFxnXkZdQLRS4rNFY
        xHhdjPgV9qh73K4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 003F8141DC8;
        Thu,  9 Sep 2021 19:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43DDC141DC7;
        Thu,  9 Sep 2021 19:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 5/5] http: don't hardcode the value of CURL_SOCKOPT_OK
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <patch-5.5-4f42c0e48b0-20210908T152807Z-avarab@gmail.com>
        <xmqqr1dxwdbu.fsf@gitster.g>
Date:   Thu, 09 Sep 2021 16:22:28 -0700
In-Reply-To: <xmqqr1dxwdbu.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        09 Sep 2021 16:15:17 -0700")
Message-ID: <xmqqmtolwczv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDA3B07E-11C4-11EC-9040-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +/**
>> + * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
>> + */
>> +#ifndef CURL_SOCKOPT_OK
>> +#define CURL_SOCKOPT_OK 0
>> +#endif
>> +
>>  /**
>>   * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
>>   */
>> diff --git a/http.c b/http.c
>> index e38fcc34d64..c40439d39ce 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -533,7 +533,7 @@ static int sockopt_callback(void *client, curl_soc=
ket_t fd, curlsocktype type)
>>  	if (rc < 0)
>>  		warning_errno("unable to set SO_KEEPALIVE on socket");
>> =20
>> -	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
>> +	return CURL_SOCKOPT_OK;
>>  }
>
> This is much better than the one in the previous round where an
> extra CPP macro with GIT_CURL_SOCKOPT_OK_AVAILABLE or some other
> name was used to conditionally return 0 or CURL_SOCKOPT_OK.

I hit <send> a bit too early.

Because the git-curl-compat.h header file is primarily to hold the
GIT_CURL_HAVE_CURL_BLAH CPP macros, the fallback definition of
CURL_SOCKOPT_OK added by this patch looks somewhat out of place.
Doing so in http.c would be perfectly OK, though.

