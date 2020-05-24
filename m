Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD2C433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B60920878
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SFdNSap5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgEXQAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:00:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62554 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgEXQAm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:00:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E30AD1210;
        Sun, 24 May 2020 12:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JEJW577dmGXb
        /LwDOazuBG76Zts=; b=SFdNSap5WmUcEgWSK8aF0J8gguDrJtvgfxDQkjrN7un3
        0yBnIAamsw5gEVNSlk2KuKavUqs/StDXyPW6rE2CKV7pptUXAfbBCjV6cvjuRZ4J
        ZoZu9fruC+ElMQzZiUiiXWTAjqq6YhnmAirEmCwyXvitJj96Tg0WmOb/J7Z9GTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RVD+S4
        OA6cgo6zgVh/PiPntpvodJIMYuQv9q6cTT9VYvk6cymOEMKCf4Fo+6u63Vbk8s4d
        e+9Aykf1hT3cy20ppqqWKk17Y25WhnSgMq1kD74eNaj8epXjZ1q2dC2k+OLIH8k7
        BD5TDoR10sEuIVJM3KahAf86oVGQrwLiYqSJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95A4BD120F;
        Sun, 24 May 2020 12:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DDE78D120D;
        Sun, 24 May 2020 12:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] bisect--helper: avoid segfault with bad syntax in `start --term-*`
References: <20200520195214.62655-1-carenas@gmail.com>
        <20200520232627.30901-1-carenas@gmail.com>
        <CAP8UFD1Oa6g4kj8GDhDC-3ry1eFyg-aD+JVDtfK1TkJKuL8v-Q@mail.gmail.com>
Date:   Sun, 24 May 2020 09:00:35 -0700
In-Reply-To: <CAP8UFD1Oa6g4kj8GDhDC-3ry1eFyg-aD+JVDtfK1TkJKuL8v-Q@mail.gmail.com>
        (Christian Couder's message of "Fri, 22 May 2020 17:49:08 +0200")
Message-ID: <xmqqr1v9qq58.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B5A4E324-9DD7-11EA-BDE5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, May 21, 2020 at 1:31 AM Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
>>
>> 06f5608c14 (bisect--helper: `bisect_start` shell function partially in=
 C,
>> 2019-01-02) adds a lax parser for `git bisect start` which could resul=
t
>> in a segfault under a bad syntax call for start with custom terms.
>>
>> Detect if there are enough arguments left in the command line to use f=
or
>> --term-{old,good,new,bad} and abort with the same syntax error the ori=
ginal
>> implementation will show if not.
>>
>> While at it, remove an unnecessary (and incomplete) check for unknown
>> arguments and make sure to add a test to avoid regressions.
>
> This looks good to me!

Thanks, both.
