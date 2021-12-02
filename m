Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35140C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbhLBArP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:47:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62592 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354737AbhLBArH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 899A01038CC;
        Wed,  1 Dec 2021 19:43:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kiAtPo8RIaym
        qqs1ofCtJQTSvz+mjh/e/irXOpFiuGU=; b=U/8ZderqkcRP654jK9jboo8HIgIl
        tkrKXqXkf+X/z01JK1BvPCRiNvxMVdPyv3aIAaWbDrg15UgUoCkJA14WHsT7IyFv
        YMpX7qgdozLyQaAaCq/eugw4+wgC4XoPGXNxkvVKJ4o+rJ9nOaaj3gauEBD6YAYb
        PUQOtWPc2XYIDEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80EE81038CB;
        Wed,  1 Dec 2021 19:43:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC2251038C9;
        Wed,  1 Dec 2021 19:43:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
References: <20211130043946.19987-1-sunshine@sunshineco.com>
        <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
        <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
        <YaaN0pibKWgjcVk3@coredump.intra.peff.net>
        <211201.86mtlk9fx4.gmgdl@evledraar.gmail.com>
Date:   Wed, 01 Dec 2021 16:43:43 -0800
In-Reply-To: <211201.86mtlk9fx4.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 01 Dec 2021 22:20:11 +0100")
Message-ID: <xmqq35nbygxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E76D4CC4-5308-11EC-BF49-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Here's a past discussion (that actually goes the other way: somebody
>> complaining that stderr should be on stdout!) where I laid out my ment=
al
>> model:
>>
>>   https://lore.kernel.org/git/20110907215716.GJ13364@sigill.intra.peff=
.net/
>
> ...and a third way (which git doesn't conform to at all), which is that
> std*err* is really what we should be using for errors only.
>
> You shouldn't write anything that isn't an error there, or at least
> that's what I've seen some software in the wild assume.

That is already covered in the old thread Peff cited (not in the
message from Peff, but you can find what others said on the topic
back then from that page).  We saw programs that declare any output
to standard error by programs they spawn indicates an error, instead
of checking the exit status of the programs they spawn, which would
of course break when they try to drive git.
