Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007162021B
	for <e@80x24.org>; Mon, 13 Nov 2017 03:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdKMDxS (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:53:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751585AbdKMDxR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:53:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CA6EB5BEB;
        Sun, 12 Nov 2017 22:53:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Rs6+zwX6Xkze
        274oOsafzPF7Djs=; b=waqWF9yhGffimK22hkCDWw6j+pOak9eLVbTCBmh1/q9o
        urhJO7F33QzMJ2rdxagJpdOy+qaECKJ0F5GLschH5GM6sbF1NYNrKe3sCIRv8vJt
        iVDqgad9/wk7XgV68D+wzqfx9Ci9HLF/iR/Hb6pYkTcqUz/Q3wKC7faZw43k5bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LVDc3G
        P+OI7Dg0TrIJ+beWzr5Xz8nPVIZG2EMw3ep/o5AwbKqDi1fMa5U0t39i5TfAbdkC
        EILmn7EZleEC2lq9FxeuavuozNZTV4utABZmbBD7CDtzZodElWSz7jJMstEbLcv2
        No+IIxdEVPdSDlqaZNEpzC6G+PfGMVFm8pjyM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 449FCB5BEA;
        Sun, 12 Nov 2017 22:53:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B53C8B5BE9;
        Sun, 12 Nov 2017 22:53:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
Subject: Re: [PATCH] Fix NO_LIBPCRE1_JIT to fully disable JIT
References: <20171112165938.8787-1-charles@hashpling.org>
        <87tvxzxm0j.fsf@evledraar.booking.com>
Date:   Mon, 13 Nov 2017 12:53:15 +0900
In-Reply-To: <87tvxzxm0j.fsf@evledraar.booking.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 12 Nov 2017 21:47:08 +0100")
Message-ID: <xmqqmv3qal78.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E347EC4-C826-11E7-9185-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Nov 12 2017, Charles Bailey jotted:
>
>> From: Charles Bailey <cbailey32@bloomberg.net>
>>
>> If you have a pcre1 library which is compiled with JIT enabled then
>> PCRE_STUDY_JIT_COMPILE will be defined whether or not the
>> NO_LIBPCRE1_JIT configuration is set.
>>
>> This means that we enable JIT functionality when calling pcre_study
>> even if NO_LIBPCRE1_JIT has been explicitly set and we just use plain
>> pcre_exec later.
>>
>> Fix this by using own macro (GIT_PCRE_STUDY_JIT_COMPILE) which we set =
to
>> PCRE_STUDY_JIT_COMPILE only if NO_LIBPCRE1_JIT is not set and define t=
o
>> 0 otherwise, as before.
>> ---
>>
>> I was bisecting an issue with the PCRE support that was causing a test
>> ...
>
> [CC-ing Junio]
>
> Thanks a lot. This patch looks good to me.

Thanks.  This patch needs a sign-off, by the way.

> But that we should take it anyway regardless of that since it'll *also*
> work on Linux with your patch, and this logic makes some sense whereas
> the other one clearly didn't and just worked by pure accident of some
> toolchain semantics that I haven't figured out yet.

That is curious and would be nice to know the answer to.

