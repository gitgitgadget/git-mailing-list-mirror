Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696C0C433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FB56198F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 05:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhC1Fhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 01:37:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhC1Fh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 01:37:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F673123758;
        Sun, 28 Mar 2021 01:37:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rvF9UnhObD5O
        KitR7fxtNDwRANg=; b=p4RLmtDPuwPhEWsFjgKilPIVikkuKXR6hi5RoMlgGOTB
        EnatlP+/hD5s8MsjfoNTAQ8beVrYdbfbMaqTEVFOkYDVUkGY8eEPSwOy/WyC+dnT
        P1dvjTrN/hP1zCrlP+sZbonpUf+dwxU6P1u9VDuFSvBMy4oGljIaD6L6CkeUlP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c+L39k
        9wbvHfXm/Lr9eOrKV0DEL9mLLpSSzuHQbvd6xRKKcxxbRPtWA8qepR/lrGtiAmbl
        x1Cqwkygrb5XEgH5/T3Vz3De00H7F3qMlnjMpCA2Y3wAi/+G+aBxxq36d+te0XqV
        sqlMDA0yyty1552bxI7yEXHIllE/e/vSofeCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 185FF123757;
        Sun, 28 Mar 2021 01:37:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60F9C123756;
        Sun, 28 Mar 2021 01:37:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
        <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
        <87blb4nf2n.fsf@evledraar.gmail.com>
Date:   Sat, 27 Mar 2021 22:37:24 -0700
In-Reply-To: <87blb4nf2n.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 28 Mar 2021 05:16:00 +0200")
Message-ID: <xmqqtuovon3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ADCC0630-8F87-11EB-94E2-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

[jc: redirecting the question to patch author---I am just a messenger]

>> diff --git a/userdiff.c b/userdiff.c
>> index 3f81a2261c..685fe712aa 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -191,6 +191,10 @@ PATTERNS("rust",
>>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>>  	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>>  	 "|[-+*\\/<>%&^|=3D!:]=3D|<<=3D?|>>=3D?|&&|\\|\\||->|=3D>|\\.{2}=3D|=
\\.{3}|::"),
>> +PATTERNS("scheme",
>> +	 "^[\t ]*(\\(define-?.*)$",
>
> The "define-?.*" can be simplified to just "define.*", but looking at
> the tests is that the intent? From the tests it looks like "define[- ]"
> is what the author wants, unless this is meant to also match
> "(definements".
>
> Has this been tested on some real-world scheme code? E.g. I have guile
> installed locally, and it has really large top-level eval-when
> blocks. These rules would jump over those to whatever the function abov=
e
> them is.
>
>> +	 /* whitespace separated tokens, but parentheses also can delimit wo=
rds */
>> +	 "([^][)(\\}\\{ \t])+"),
>>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{=
~%]*).*$",
>>  	 "[=3D{}\"]|[^=3D{}\" \t]+"),
>>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
