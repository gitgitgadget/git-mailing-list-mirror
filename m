Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377EBC432BE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DC060E09
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGXRA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 13:00:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55790 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXRA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 13:00:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6022C9B3E;
        Sat, 24 Jul 2021 13:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I9thOIpdewk526Vdx9pTrEwx4/gSfGG3+xFoyw
        4Bxf4=; b=Nno8jLRVdYglRN4abu+HM3uEPgFkHKm07yWEvoPiJIAoYtBbfKaA4/
        f1HfFRwSbfRjTeS5YNGLYGwKy//zVWggO6f53sn8Dk8W/DHNczXgnQzKKKK9iKg6
        K0xp8GzVU0cQxb9088PXl/OfbXlwAGiaIuESMBs29jY8+fWGvu5Yo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADFF8C9B3D;
        Sat, 24 Jul 2021 13:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E553C9B3C;
        Sat, 24 Jul 2021 13:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/5] [GSOC] ref-filter: add %(raw) atom
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
        <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
        <eafb79bad62f13fc8fd70ba1dce3e8fbab870e52.1627031043.git.gitgitgadget@gmail.com>
        <xmqqh7glouiw.fsf@gitster.g>
        <CAOLTT8SggCXkajPG3om+6zhM_K8fyAb2qTBDj40JJa1pszshzg@mail.gmail.com>
Date:   Sat, 24 Jul 2021 10:41:26 -0700
In-Reply-To: <CAOLTT8SggCXkajPG3om+6zhM_K8fyAb2qTBDj40JJa1pszshzg@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 24 Jul 2021 15:57:16 +0800")
Message-ID: <xmqqy29vk3sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F4FD802-ECA6-11EB-B823-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> It may make sense to
>>
>>  * Turn atom_value.s_size field into ssize_t instead of size_t
>>
>
> Will the conversion of size_t and ssize_t break -Wsign-conversion?
> Although there is a lot of code in Git that has broken it, but I am not
> sure if it is wise to use ssize_t here.
>
>>  * Rewrite (v->s_size != -1) comparison to (v->s_size < 0)
>>
>
> For size_t, this scheme is wrong.
>
>>
>> Optionally we could introduce #define ATOM_SIZE_UNSPECIFIED (-1) and
>> use it to initialize .s_size in ATOM_VALUE_INIT, but if we are just
>> going to test "is it negative, then it is not given", then it probably
>> is not needed.
>>
>
> It seems that this is the only method left. Although I think
> ATOM_SIZE_UNSPECIFIED
> is not very useful becasue we already have ATOM_VALUE_INIT.

Sorry, but I think you misread what I wrote.

These three were not offered as "you can do one of these three, pick
one you like" choices.  I meant to say "I think it makes sense to do
all these three things, but the last one is optional, doing only the
first two may be good enough".  As the second one requires that the
first is done, of course, doing only the second one would not make
sense.

Also, you seem to have missed the distinction between _INIT and
_UNSPECIFIED.  You can initialize something to (1) a reasonable
default value, or (2) unusable value that you can detect at runtime
and notice that it was not set.  If you called something to
FOO_INIT, your readers cannot tell which one it is, but if you call
it FOO_UNSPECIFIED, it is clear it is the latter case.

In many places, we do use ssize_t for "normally this is size, but we
can express exception cases (like errors) by storing negative value"
in our codebase (grep for it), and I think the member in question is
prime candidate for such use.

