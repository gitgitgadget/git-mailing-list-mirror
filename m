Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D06C4332D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683B820665
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbhAZWA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55119 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393536AbhAZRwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 12:52:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADD8A113E79;
        Tue, 26 Jan 2021 12:51:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BNI2iGptMfDc
        y1IF6pLTmdAs3MQ=; b=ZvVj+I0mKwBMhQURmow1Kxe3nSFl41FzziW0PRr4kiPZ
        U+vA6ZDAysE1qd4zka+KL8MHXtXQHnMuAswY4HWrimbmJUlXQnSpLPCY8cO49wed
        KgbhQrVzOdBoKJA8ZX5h/0X4+b1l0FOFTo3H8vzpWyj9X1guO5MneJTVbHwgCRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WqK2Wy
        +7sOakNUnVpFsZMWWVd2xIZ8ScK6ahOO5dHNP0KPrXKxnG9FTdfnV+rSFQWCd1V8
        lYGMoFtb69zjK5skkFpWqNrcgmeYPSRfMcQdfakz5p/EJuz8gR1bjScPirFEmpEm
        XuPlsk7ulsrBtHAFKbvGECSG0R1brWmkFkOB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A59B6113E77;
        Tue, 26 Jan 2021 12:51:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D198113E73;
        Tue, 26 Jan 2021 12:51:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, peff@peff.net,
        git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
        <20210125230952.15468-1-jacob@gitlab.com>
        <20210125230952.15468-2-jacob@gitlab.com>
        <874kj46mwf.fsf@evledraar.gmail.com>
Date:   Tue, 26 Jan 2021 09:51:35 -0800
In-Reply-To: <874kj46mwf.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 26 Jan 2021 10:57:36 +0100")
Message-ID: <xmqqlfcf37tk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23302A04-5FFF-11EB-9C1B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jan 26 2021, Jacob Vosmaer wrote:
>
>> This fixes a bug that occurs when you combine partial clone and
>> uploadpack.packobjectshook. You can reproduce it as follows:
>
> Let's:=20
>
>  * Refer to the commit we're fixing a bug in, i.e. Junio's mention of
>    10ac85c7 (upload-pack: add object filtering for partial clone,
>    2017-12-08) upthread.
>
>  * See also "imperative-mood" in SubmittingPatches. I.e. say "Fix a bug
>    in ..." not "This fixes ... can be reproduced as"
>
>  * uploadpack.packObjectsHook not uploadpack.packobjectshook except in =
C
>    code.
>
> ... [jc: all the helpful hints snipped] ...
>
> Thanks for hacking this up! Hopefully the above is helpful and not too
> nitpicky. Mainly wanted to help you get future patches through more
> easily...

Yeah, thanks, both, for aiming higher ;-) =20

I have to admit that I did find the log message a bit lacking, and
that was why I had to dig bit to find out how the historical issue
happened myself in the first place, and I tend to agree that it
feels a bit of waste for that work to end up buried in the list
archive without getting reflected in the proposed log message.

