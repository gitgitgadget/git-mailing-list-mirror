Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A1C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0126140B
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhD1EN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:13:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53379 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1EN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:13:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 789FFC88E9;
        Wed, 28 Apr 2021 00:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P7A5n/j+RgUL
        QSTzqlOYvTvM3O+JVQtknglir9u1J8Q=; b=R5+Ys0xd1WQFb+9uEh8vMl6J5IuP
        m4e56JBWkQk4DUSY14SD3E9m0EZ8p4m6adyMpuDqrBnrcymEhThqi5PI0XOu+jGO
        KD3F8dgdn5mMquZyhdYcpQ1CrwKl32/NY00FVUDcZOAvkhtacUFw1eQt6C/0+xkX
        cynMcjrKfmI5+vo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F372C88E8;
        Wed, 28 Apr 2021 00:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDF92C88E7;
        Wed, 28 Apr 2021 00:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/8] object.c: add and use oid_is_type_or_die_msg()
 function
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
        <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
        <patch-3.8-22e7d9a3db-20210420T133218Z-avarab@gmail.com>
        <YIC1IcpKCXh3qoun@google.com>
Date:   Wed, 28 Apr 2021 13:12:41 +0900
In-Reply-To: <YIC1IcpKCXh3qoun@google.com> (Josh Steadmon's message of "Wed,
        21 Apr 2021 16:28:33 -0700")
Message-ID: <xmqq7dkncaiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FA0DBCBA-A7D7-11EB-B13B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2021.04.20 15:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> diff --git a/object.c b/object.c
>> index 9e06c0ee92..0f07f976fb 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -176,6 +176,18 @@ int oid_is_type_or_error(const struct object_id *=
oid,
>>  		     type_name(want));
>>  }
>> =20
>> +char* oid_is_type_or_die_msg(const struct object_id *oid,
>
> It's kind of a nitpick, but I found the function name to be confusing.
> It sounds like you're going to die with a custom message. Maybe
> something like "get_oid_type_mismatch_msg()" would be more
> straightforward.

Yeah, in an older round I found this function's name was confusing,
too.

Also, there is a style (in our codebase, asterisk to signal the
pointer-ness sticks to the identifier, not to the type name).

Thanks.
