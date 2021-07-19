Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6ACC07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8616113C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbhGSWSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:18:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63779 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGSTS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 15:18:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFF0914931F;
        Mon, 19 Jul 2021 15:58:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/JdYL+iNASn/
        zxVX0cl1+feU2gEJwrOtEQmwemgRKug=; b=NZVKDNmnUMm5t/QGqhNTsLlaMF2F
        nii3Nga9m/GverUzrEYvUliTiROAd6vhaSSS30U4C96REUWC5BvN2bLskiyDb08Y
        LsCY4BVPZIvjRyhh04L+nDPgZVhUql9Qzv8ypCbxRy5JIFTQaIWQ58zfowRNo8Id
        HkYavP420Hn2Pwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7B4B14931E;
        Mon, 19 Jul 2021 15:58:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA1E514931D;
        Mon, 19 Jul 2021 15:58:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
        <87v95tbqgh.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
        <87y2a6w61l.fsf@evledraar.gmail.com> <xmqqa6mlplo7.fsf@gitster.g>
        <87k0lowr6u.fsf@evledraar.gmail.com>
Date:   Mon, 19 Jul 2021 12:58:51 -0700
In-Reply-To: <87k0lowr6u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 17 Jul 2021 23:43:00 +0200")
Message-ID: <xmqqczrekrd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BE82392A-E8CB-11EB-AE67-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>>> Why put this in an ifdef?
>>>> ...
>>> Why does the FSMONITOR_DAEMON_BACKEND option require a nonexistent li=
ne
>>> as opposed to an empty one?
>>
>> I do not quite get the question.
>>
>> #!/bin/sh
>> cat >make.file <<\EOF
>> all::
>> ifeq ($(FSMONITOR_DAEMON_BACKEND),)
>> 	echo it is empty
>> endif
>> ifndef FSMONITOR_DAEMON_BACKEND
>> 	echo it is undefined
>> endif
>> EOF
>>
>> echo "unset???"
>> make -f make.file
>>
>> echo "set to empty???"
>> make -f make.file FSMONITOR_DAEMON_BACKEND=3D
>>
>> These two make invocations will give us the same result, showing
>> that "is it set to empty" and "is it unset" are the same.
>
> Indeed, which is why I'm pointing out that wrapping it in an ifdef is
> pointless, which is why we don't do it for the other ones.
>
> We do have a bunch of ifdef'd things there for perf etc., I'm not sure
> if it matters or not for those.

Sorry, but I still do not get the question.  There are bunch of
ifndef in Makefile in addition to ifeq/ifneq and your question

    FSMONITOR_DAEMON_BACKEND option require a nonexistent line as
    opposed to an empty one?

is asking "why is it X" when X is not quite true.  I presume that
your "wrapping it in an ifdef" refers to a construct like this:

>>> > +ifdef FSMONITOR_DAEMON_BACKEND
>>> > +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>>> > +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR=
_DAEMON_BACKEND).o
>>> > +endif

but is your suggestion that it should be written like this instead?

>>> > +ifneq ($(FSMONITOR_DAEMON_BACKEND),)
>>> > +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>>> > +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR=
_DAEMON_BACKEND).o
>>> > +endif

I do not think the latter is any easier to follow (and we have many
ifdef and ifndef in our Makefile already).  Perhaps I will see what
you mean when I see your "better alternative", but so far, I am not
successfully guessing what it is.

