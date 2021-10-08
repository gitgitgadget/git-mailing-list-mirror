Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E30C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6390E61040
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJHUg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:36:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61817 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhJHUg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:36:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1BF7144662;
        Fri,  8 Oct 2021 16:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QZgKmCSG+BIp
        6SlT9sUyWrkGFoxZM6bACCTwdD4P9Ew=; b=MZQkBHpwteCUAmk4hNQW7m8Fwuvk
        5NFI8IIsMorfbe4r3RsvRvKMp4Qo0wmLq5jMy0IplZeOaZZpXuHTnPkAe6TlhDxU
        K1FAyQ0KqrPMe4uHnZG29SUYcGincJsApmvqrzUdnGA+c9GXIYpCmfLmJwskoCOb
        WoCUETO5BzUC9K0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA20D144661;
        Fri,  8 Oct 2021 16:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCB98144660;
        Fri,  8 Oct 2021 16:34:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
        <YVy2DNd+XemykKE0@coredump.intra.peff.net>
        <877derjia9.fsf@evledraar.gmail.com>
        <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
        <87tuhuikhf.fsf@evledraar.gmail.com>
        <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
        <87k0ipgmbb.fsf@evledraar.gmail.com>
        <YV+tXVWVuy/rZn/l@coredump.intra.peff.net>
        <87lf34ey5a.fsf@evledraar.gmail.com>
Date:   Fri, 08 Oct 2021 13:34:26 -0700
In-Reply-To: <87lf34ey5a.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 08 Oct 2021 09:54:45 +0200")
Message-ID: <xmqqo87zjlwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 220DA2C8-2877-11EC-A80B-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> In fact, it _would_ be a bug to make it a CMDMODE if --batch were
>> correctly marked as one (but it is not sufficient to reason the other
>> way; --batch without --batch-all-objects is still mutually exclusive
>> with -t, etc).
>>
>  > What really makes things confusing, IMHO, is the --textconv and --fi=
lter
>> options. They are marked as CMDMODEs, and they are indeed mutually
>> exclusive with -t, etc. But they also work with --batch, which is itse=
lf
>> a different mode.
>>
>> So I don't think OPT_CMDMODE could ever present this complete set of
>> rules, because they are not all mutually exclusive with each other. Bu=
t
>> I think calling "--batch-all-objects" a mode is just muddying the wate=
rs
>> even further.
>
> I think we've got some different understanding of what a CMDMODE
> means. --batch-all-objects should be a cmdmode, but --batch, --buffer
> etc. can't be. Similarly it's not a bug that --filters and --textconv
> are cmdmodes, but you think that's bad.

Among options[] elements, "batch" and "batch-check" take &batch, and
they are obviously mutually exclusive.  "batch-all-objects" can flip
the batch.all_objects flag to affect operations that use &batch
(namely, these two), so it is more like a modifier and can never be
a cmdmode.

Is "git cat-file -t tag --batch" a valid way to invoke the command?
Are there options (like "-t" in the above example) that are marked
with OPT_CMDMODE that can be used with "--batch" or "--batch-check"?

If the answer is "no", then "--batch" and "--batch-check" could also
be command modes, but I suspect OPT_CMDMODE() does not have enough
flexibility to say "use the &opt to record which command mode is
requested, and by the way, there is this extra pointer &batch to
stuff necessary information in and use this callback to fill it", so
even if "--batch" and "--batch-check" are incompatible with existing
command modes, it needs a bit or preparatory work to make them.
