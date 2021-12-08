Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59373C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhLHTGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:06:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59460 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhLHTGP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:06:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF89017235A;
        Wed,  8 Dec 2021 14:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=xDRUEHA4TrmoSyWzOjxqChZ07
        MFb42fOYBDdddnYEVc=; b=jvBVELtpLhBDZPDk/gPDlNAqKlP9EBZMwMlhto1o4
        0WWOEeiRaQcSZcmz83eqhAvs0Us/teK07Q8nRNe3ZSput73PMKya7QQR8HUVOiyJ
        ObvJ/zMQqW11ziAAibOrJXEnKxs2SLaHne81b7Sh92SKQsPuyBEu2nobYMVifCJx
        OE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A897C172359;
        Wed,  8 Dec 2021 14:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4D20172358;
        Wed,  8 Dec 2021 14:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Subject: Re: errno oversight
References: <CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com>
        <211208.86sfv3l0op.gmgdl@evledraar.gmail.com>
        <211208.86o85rl07m.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Dec 2021 11:02:37 -0800
Message-ID: <xmqqo85q2a42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 697F1120-5859-11EC-8805-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>                    if (refs_read_raw_ref(refs, refname, oid, &sb_refn=
ame,
>>>                                       &read_flags, failure_errno)) {
>>>                         *flags |=3D read_flags;
>>>                         if (errno)
>>>                                 *failure_errno =3D errno;
> ...
> Urg, sorry. Yes obviously that should use the failure_errno from
> refs_read_raw_ref().

Yeah, I was wondering about the same thing, "refs_read_raw_ref()
takes the failure_errno pointer for stuffing errno there, doesn't
it?  does the caller need to do anything?".

> I'll submit a fix for this soon. There's some good post-cleanup to be
> done here, it seems only one upstream caller of
> refs_resolve_ref_unsafe() cares about the failure_errno currently (but =
I
> didn't look into your reftable code).

Thanks.
