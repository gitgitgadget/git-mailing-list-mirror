Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C6C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDF661159
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhDHXzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:55:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61726 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhDHXzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:55:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 715BDB5051;
        Thu,  8 Apr 2021 19:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JFBYmzsyjIlD
        D7Ja+wSidiz+KFc=; b=adRCH/qi6gRcxIA5rmYOOB5fQgzqadvqlLXGYfPGdbIN
        bEiF1d/w5vDk+9HQA3tVU4/WG4Vf4U9HkzLd6NAwJsGem8xHlzBSdivaCX8M3Yxw
        /sIVS7zevwV/oIzTa+xX8F2UdvE59hm56GOxCo68GNYwshRTvU6FRuflvmpc6Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JpJXY4
        Ejhmf1buBbYb8PmqGYnC60qUQL+x/BtAgABlmMr5bA5igdcPX4EydgOulioMX1dK
        cEn9Y1nKjHinEJbOVA0rBYFXJIFdRWHA+njaKj343aO4cpzfoomPDLwheST8gOmP
        awoSvAxs3+ATls1BoN2Ak2715hkgicNYUetKM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 438B8B5050;
        Thu,  8 Apr 2021 19:54:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AD31B504C;
        Thu,  8 Apr 2021 19:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
        <xmqqa6q8tymu.fsf@gitster.g> <875z0wicmp.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 16:54:46 -0700
In-Reply-To: <875z0wicmp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 01:23:58 +0200")
Message-ID: <xmqqsg40pc1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCC79F44-98C5-11EB-B2B7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +int git_parse_maybe_tristate(const char *value)
>>> +{
>>> +	int v =3D git_parse_maybe_bool(value);
>>> +	if (v < 0 && !strcasecmp(value, "auto"))
>>> +		return 2;
>>> +	return v;
>>> +}
>>
>> This is not parse_maybe_bool_text(), so "1" and "-1" written in the
>> configuration file are "true", "0" is "false", like the "bool" case.
>>
>> I wonder if written without an unnecessary extra variable, i.e.
>>
>> 	if (value && !strcasecmp(value, "auto"))
>> 		return 2;
>> 	return git_parse_maybe_bool(value);
>>
>> is easier to follow, though, as it is quite clear that it is mostly
>> the same as maybe_bool and the only difference is when "auto" is
>> given.
>
> I guess it could be either way around,...

Having seen another example in the current code recently,

 static int parse_tristate(int *b, const char *k, const char *v)
 {
-	if (v && !strcasecmp(v, "auto"))
-		*b =3D -1;
-	else
-		*b =3D git_config_bool(k, v);

I upgrade my earlier "I wonder" to "I do think that".  Let's swap
the order so that it is clear that we are special-casing "auto".

