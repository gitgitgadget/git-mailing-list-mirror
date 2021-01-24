Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F3FC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1322BF3
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbhAXFPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 00:15:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64364 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAXFP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 00:15:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17E11A14EE;
        Sun, 24 Jan 2021 00:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RZG4JWgYTd/0
        r2KSXJjg+zJk3tU=; b=BmO4kCUoQPiYnw45b2MVMU8bUgTMvyI/Ysq/smJOBccV
        Q1von2bSRemyTsbPj0oLkHp/hX4DNHVkOboy6V6+MOoYFSQwSv35H73ClBdW6vyb
        jCxuEIPKp/kgIkvCO71+wrCQLhNBUu/sk6cDZTiBP46Q9HyF2bVmlXdVAno0tgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qoRmkj
        X3aFYqddqNDRfymnwonLrNCKmeyJ4+kqkOr1znnVOHLQK09ho8H/ytVaxRtRnqyW
        KwxfRz1s1FSobS496H6LdT6ftOMy4F3WB0gcjUikqF2cj53Lmm+lN4zNplkw9C9b
        ZyDad44I41zipkfbY8tv+zOhzcUvJtAQKFeSg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F388DA14EC;
        Sun, 24 Jan 2021 00:14:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70485A14EB;
        Sun, 24 Jan 2021 00:14:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 2/2] Remove support for v1 of the PCRE library
References: <20210124015833.2753-1-avarab@gmail.com>
        <20210124015833.2753-2-avarab@gmail.com>
        <YAzn0Z+568rtF6rs@camp.crustytoothpaste.net>
Date:   Sat, 23 Jan 2021 21:14:43 -0800
In-Reply-To: <YAzn0Z+568rtF6rs@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sun, 24 Jan 2021 03:21:53 +0000")
Message-ID: <xmqqmtwy29x8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11FEBB2C-5E03-11EB-81B7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-01-24 at 01:58:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
>> Remove support for using version 1 of the PCRE library. Its use has
>> been discouraged by upstream for a long time, and it's in a
>> bugfix-only state.
>>=20
>> Anyone who was relying on v1 in particular got a nudge to move to v2
>> in e6c531b808 (Makefile: make USE_LIBPCRE=3DYesPlease mean v2, not v1,
>> 2018-03-11), which was first released as part of v2.18.0.
>>=20
>> With this the LIBPCRE2 test prerequisites is redundant to PCRE. But
>> I'm keeping it for self-documentation purposes, and to avoid conflict
>> with other in-flight PCRE patches.
>
> I think it's fine to drop support for the original PCRE.  All supported
> versions of CentOS, Debian, Ubuntu, FreeBSD, and NetBSD have PCRE2 by
> now, and I'm quite fine with giving folks using systems without securit=
y
> updates a bit of a wake-up call.  I have no reason to believe that any
> other major operating system won't have version 2, either.
>
> So, essentially, I think this is a good idea.

Yeah, I too like seeing the world making progress ;-).
