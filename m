Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786CDC636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 05:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C1613AF
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 05:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhGQFQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 01:16:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51302 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGQFQm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 01:16:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D428AD6BEA;
        Sat, 17 Jul 2021 01:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U2XnBGBgjDUm
        qd+Ng/phfbvEiL0szHewpsGJsTHewSs=; b=YJJpLYAF1xCZwjvAqpxi6Ds/mLLN
        bkbehojy0XQVC7oAOHvBaouy2PRi9JcVy3UHFn3oPXjV3HruVPyyIisxDn2QiTaJ
        jAMSfTFKkE+UTZ73eqtcSknoukEFsSK653RseBtbLwHVz1/WbyZkv4VSnrOKh1NU
        GrhzYqVr/Bt5TeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB8F8D6BE8;
        Sat, 17 Jul 2021 01:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33A82D6BE6;
        Sat, 17 Jul 2021 01:13:45 -0400 (EDT)
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
        <87y2a6w61l.fsf@evledraar.gmail.com>
Date:   Fri, 16 Jul 2021 22:13:44 -0700
In-Reply-To: <87y2a6w61l.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 16 Jul 2021 18:55:12 +0200")
Message-ID: <xmqqa6mlplo7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C28F0A76-E6BD-11EB-93DE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> > +ifdef FSMONITOR_DAEMON_BACKEND
>>> > +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>>> > +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR=
_DAEMON_BACKEND).o
>>> > +endif
>>> > +
>>> >  ifeq ($(TCLTK_PATH),)
>>> >  NO_TCLTK =3D NoThanks
>>> >  endif
>>> ...
>>>
>>> Why put this in an ifdef?
>>
>> Why not? What benefit does this question bring to improving this patch
>> series?
>
> I think that when adding code to the Makefile it makes sense to follow
> the prevailing pattern, unless there's a good reason to do otherwise,
> e.g. on my build:
> =09
> 	$ grep "''" GIT-BUILD-OPTIONS=20
> 	NO_CURL=3D''
> 	NO_EXPAT=3D''
> 	NO_PERL=3D''
> 	NO_PTHREADS=3D''
> 	NO_PYTHON=3D''
> 	NO_UNIX_SOCKETS=3D''
> 	X=3D''
>
> Why does the FSMONITOR_DAEMON_BACKEND option require a nonexistent line
> as opposed to an empty one?

I do not quite get the question.

#!/bin/sh
cat >make.file <<\EOF
all::
ifeq ($(FSMONITOR_DAEMON_BACKEND),)
	echo it is empty
endif
ifdef FSMONITOR_DAEMON_BACKEND
	echo it is undefined
endif
EOF

echo "unset???"
make -f make.file

echo "set to empty???"
make -f make.file FSMONITOR_DAEMON_BACKEND=3D

These two make invocations will give us the same result, showing
that "is it set to empty" and "is it unset" are the same.

