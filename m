Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E6C4332B
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 17:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDAE64F6D
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 17:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhBDR53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 12:57:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57989 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbhBDR5J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 12:57:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E056CB38FB;
        Thu,  4 Feb 2021 12:56:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LLIZj6iUa+8l
        EYfqnnsLUAcmEiU=; b=wNciyX3c5kMSGeZhIEf15eTJNTRLUoLQ7A6XS1pVZX49
        ru64BQ19LfUDdYcPZVv2GpPHlqXbOU1pgYK5iE+OSVuMgzYhUut9dV19ZwTKE8DW
        lqiYr0HEjYYA8O5R4NYnT0pItbKUaz82ctr8hZwO+GeAkY97Qg+IAXQ+rUMLzk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yc00/D
        9LIvnR3Ev4fUow/I1ZyPz8+gX8qqVy6uTUKRvfqTZL+cOMixbGdBQSx1yDfcyki2
        jwkCVybbUKmX1Lu/9f2mUhlxzAlb6ZS+Ce4v2pNldC0corQqOAzf93qylkZnPAJe
        MvdSoBaDysxJ4oxnuO4YbTGjF7zQzYqaoqFrw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7C05B38FA;
        Thu,  4 Feb 2021 12:56:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DF5FB38F9;
        Thu,  4 Feb 2021 12:56:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 14/25] pickaxe -S: remove redundant "sz" check in
 while-loop
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210203032811.14979-15-avarab@gmail.com>
        <4ef09db7-34f2-2fb5-b9e9-be69c7102787@web.de>
Date:   Thu, 04 Feb 2021 09:56:17 -0800
In-Reply-To: <4ef09db7-34f2-2fb5-b9e9-be69c7102787@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 4 Feb 2021 17:16:29 +0100")
Message-ID: <xmqqh7mr90ou.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 483E2700-6712-11EB-9DFA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> -		while (sz &&
>> -		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
>> +		while (!regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
>
> This will loop forever for regexes that match an empty string.  An
> example would be /$/.  Silly, perhaps, but still I understand this chec=
k
> less as an optimization and more as a correctness/robustness thing.
>
>>  			flags |=3D REG_NOTBOL;
>>  			data +=3D regmatch.rm_eo;
>>  			sz -=3D regmatch.rm_eo;
>> -			if (sz && regmatch.rm_so =3D=3D regmatch.rm_eo) {
>> +			if (regmatch.rm_so =3D=3D regmatch.rm_eo) {
>>  				data++;
>>  				sz--;
>>  			}
>
> Before, if the match was an empty string and there was more data after
> it, then the code would consume a character anyway, in order to avoid
> matching the same empty string again.  With the patch, that character
> is consumed even if there is no more data.  This leaves 'data'
> pointing beyond the buffer and 'sz' rolls over to ULONG_MAX.  Oops. :(

While I do not care too much about NUL in the haystack, I do not
mind [13/25] either.  But this is bad.

This whole thing reminds me of f53c5de2 (pickaxe: fix segfault with
'-S<...> --pickaxe-regex', 2017-03-18), by the way.

Thanks.



