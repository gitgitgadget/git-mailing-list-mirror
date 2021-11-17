Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93AC60E8E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhKQIcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:32:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64913 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhKQIcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:32:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92BE1F45BE;
        Wed, 17 Nov 2021 03:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=VgCfjLsDDq9u9/9cLABF8QemxWo8E/UZKSE4iCEf1X8=; b=GhOl
        yrBMc4f+1MyVIEGZPjMkGWKfZO5btq1zaqnbQk1w82i8EabhqaTw1rooMRmcoUl/
        aTx5HsRo26BVtO2gLPGO183RhuwnE4J7zkQHjUMxYfVRqj2yQaEg099XWh5n22P8
        uBW2Cww6q5ANk6NoKPA48OlejWscQfec93N84Cw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BDEDF45BD;
        Wed, 17 Nov 2021 03:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9CB9F45BB;
        Wed, 17 Nov 2021 03:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
        <20211114211622.1465981-2-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
Date:   Wed, 17 Nov 2021 00:29:08 -0800
Message-ID: <xmqqk0h7423v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FC8AF08-4780-11EC-AC65-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Even MSVC, long a holdout against modern C, now supports both C11 and
>> C17 with an appropriate update.  Moreover, even if people are using an
>> older version of MSVC on these systems, they will generally need some
>> implementation of the standard Unix utilities for the testsuite, and GNU
>> coreutils, the most common option, has required C99 since 2009.
>> Therefore, we can safely assume that a suitable version of GCC or clang
>> is available to users even if their version of MSVC is not sufficiently
>> capable.
>
> I am all in favor of this patch!

I like the direction, but ...

>> diff --git a/Makefile b/Makefile
>> index 12be39ac49..22d9e67542 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1204,7 +1204,7 @@ endif
>>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>>  # tweaked by config.* below as well as the command-line, both of
>>  # which'll override these defaults.
>> -CFLAGS = -g -O2 -Wall
>> +CFLAGS = -g -O2 -Wall -std=gnu99

... as has been already pointed out, this part probably should not
be there.  It is not our intention to require gcc/clang, or to
constrain newer systems to gnu99.

