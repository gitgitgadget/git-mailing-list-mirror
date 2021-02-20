Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8524C433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BBF64E43
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTDaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:30:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63546 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBTDaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:30:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED62210737F;
        Fri, 19 Feb 2021 22:29:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OdaOi86G4z/L
        r4CRiyU9ny7wNko=; b=kBeQhbuC/5hNRAOBunvszjIMNgZQeit+GKshJLGfONqf
        2s/brCwINENpY9hyegqMl5DwYhB0tkIXqNmEdncsoL+IPmxKM5LR5H0eGhVdPkUN
        8ZzoPP01IOgqVoWHKx1UVsBBzNH7QPeEmSn87nsqoAXVWQczgTQ3MGC+bykTAbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qyPq3F
        ouTvaX1yd+VdCG1z4WwV8/I/74pH5FwvI8XFF0jaHJdzQkOsDhFqtTq5xfPbadYa
        LkWVdLIVvL3fr1esGq+QYp287zBQkCYNGLnGFLQ/RVId4Xd1hz9oM5kY+YUda3b9
        eUZhYuVuoNGOvfbm4u4uW3ywvurrFqbR2pZQ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E530A10737E;
        Fri, 19 Feb 2021 22:29:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 256CF10737D;
        Fri, 19 Feb 2021 22:29:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1611455251.git.jonathantanmy@google.com>
        <xmqqzh01ar2s.fsf@gitster.g> <87im6o984g.fsf@evledraar.gmail.com>
Date:   Fri, 19 Feb 2021 19:29:27 -0800
In-Reply-To: <87im6o984g.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 19 Feb 2021 02:08:47 +0100")
Message-ID: <xmqqr1lba02w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6EED632-732B-11EB-8BC7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Feb 19 2021, Junio C Hamano wrote:
>
>> This seems to have been stalled but I think it would be a better
>> approach to use a custom callback for error reporting, suggested by
>> =C3=86var, which would be where his fsck API clean-up topic would lead
>> to.
>>
>> If it is not ultra-urgent, perhaps you can retract the ones that are
>> queued right now, work with =C3=86var to finish the error-callback wor=
k
>> and rebuild this topic on top of it?  Thanks.
>
> If my vote counts for something I think it makes sense to have
> Jonathan's series go first and just ignore my fsck API improvement
> patches (well, the part of my v1[1] which conflicts with his work).
>
> I'm also happy to help him queue his on top of a v1 version of my
> series.

Either would work for us, I would think.

Thanks.
