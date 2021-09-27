Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C15C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADDD60EB4
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhI0UZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:25:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56239 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhI0UZX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:25:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F404D141107;
        Mon, 27 Sep 2021 16:23:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F+2HYWg7++W1
        FhLnlUSUWLYceREZt6G6RUQl6Txebsc=; b=glKisbjvuRfUtU2ZmJ5Lpxa2BOy4
        /fybbon27Sc07mIZIP6I07tcCmwBHnzrrV8M+/638HBh9NSv5xlRkGRz20xykDVT
        D6ahYDXlT2MWDsiUnQSsnWsmuzAgMkc0QlSoyZLWXP1/JM9fuW8VNGZ8WXqk3qrj
        YJXIdv+LLWGmtfA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC84F141106;
        Mon, 27 Sep 2021 16:23:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 58461141105;
        Mon, 27 Sep 2021 16:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
        <patch-v2-8.8-7420267ce09-20210926T185800Z-avarab@gmail.com>
        <xmqqfstqq80j.fsf@gitster.g>
        <0e07cee4-079a-af12-880f-d4a99300df28@web.de>
Date:   Mon, 27 Sep 2021 13:23:41 -0700
In-Reply-To: <0e07cee4-079a-af12-880f-d4a99300df28@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 27 Sep 2021 20:00:49 +0200")
Message-ID: <xmqqk0j1py2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEBD13BE-1FD0-11EC-B1C9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 27.09.21 um 18:48 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> +sed -n \
>>> +	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
>>> +	-e 'x' \
>>> +	<Documentation/githooks.txt |
>>> +	LC_ALL=3DC sort
>>
>> Thanks.  It is not wrong per-se, but if you are willing to do a
>> multi-line script for readability, wouldn't a much more readable
>> "single long and multi-line string" approach, i.e.
>>
>>     sed -ne '
>> 	/^~~~~*$/ {
>> 		x
>> 		s/^.*$/ "&",/
>> 		p
>> 	}
>> 	x
>>     ' Documentation/githooks.txt |
>>     LC_ALL=3DC sort
>>
>> work better?
>>
>
> It is more readable, but according to OpenBSD's sed(1) manpage it would
> also be non-portable (https://man.openbsd.org/sed#STANDARDS).  That not=
e
> was added in 2006 (https://github.com/openbsd/src/commit/24ce9718),
> though, so perhaps it needs an update.
>
> FWIW, generate-cmdlist.sh uses such a multi-line sed script in its
> function get_synopsis.

I wonder who wrote the invocation in generate-cmdlist.sh ;-)

FWIW, the informative part of POSIX.1 sed manpage

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html#tag_2=
0_116_17

has such a single long and multi-line string script given on the
command line, but "non-portable" can refer to "some implementations
may not implement all of what POSIX expects", so ... ;-)

