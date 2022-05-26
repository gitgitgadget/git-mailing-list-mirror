Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEB8C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiEZT4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiEZT4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:56:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8444927CD9
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:56:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A458512655B;
        Thu, 26 May 2022 15:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xRou29uKK/WK
        UTNTyHyvWoIVPsRnHZ/z+NMICBj0n7M=; b=ZJ0VMgg5h/BP7tvdkoi9je7vvCmz
        mZvBAA7yJ0RdNROp3jhAr8LFraj++BK0GtrQLJJe+xAwWkVcKiYulQJatY3oEwEE
        5YdQYz3NEKWumDS/9CIi3PX8fmBX4YhuZBSypEk+onPY0uybNPF8Tj8PuSeY/K98
        SZfiLnLZ1vhSd+A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C04012655A;
        Thu, 26 May 2022 15:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D8FE126558;
        Thu, 26 May 2022 15:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
        <xmqqbkvl8s88.fsf@gitster.g> <xmqqczg13xpy.fsf@gitster.g>
        <220526.86pmk060xa.gmgdl@evledraar.gmail.com>
        <xmqqpmk01caj.fsf@gitster.g>
        <220526.86ee0g3y1k.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 12:56:46 -0700
In-Reply-To: <220526.86ee0g3y1k.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 21:13:50 +0200")
Message-ID: <xmqqsfowxe2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F97F18B6-DD2D-11EC-975D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I wonder if rebuilding from scratch is easier to review, then?  The
>> first three patches of such a series would be
>>
>>  - Revert cb3b3974 (Merge branch 'ab/racy-hooks', 2022-03-30)
>>  - Revert 7431379a (Merge branch 'ab/racy-hooks', 2022-03-16)
>>  - Revert c70bc338 (Merge branch 'ab/config-based-hooks-2', 2022-02-09=
)
>>
>> and then the rest would rebuild what used to be in the original
>> series on top.  There will be a lot of duplicate patches between
>> that "the rest" and the patches in the original series (e.g. I would
>> imagine that the resulting hook.h would look more or less
>> identical), but "git range-diff" may be able to trim it down by
>> comparing between "the rest" and "c70bc338^..c70bc338^2" (aka
>> ab/config-based-hooks-2).  I dunno.
>
> I'm still happy to and planning to send a re-roll of this to try to
> address outstanding comments/concerns, but am holding off for now
> because it's not clear to me if you're already planning to discard any
> such re-roll in favor of a revert.
>
> Or do you mean to create a point release with such revert(s) and have
> master free to move forward with a fix for the outstanding issue, but
> not to use that for a point release?

If a maintenance release will have reverts with adjustment, then the
solution that will be only merged to master should still be built on
top.  So if we were to go the route above, the early part (the first
three that are reverts above, and possibly a couple more directly on
top just to address "did we really run hook?") would be merged to the
maintenance track, while the whole thing that rebuilds on top of the
reverted one would be merged to 'master', I would imagine.

It all depends on how involved it is to get to where we want to be,
between

 (1) starting from 'master' and working backwards, removing the use of
     the run_parallel stuff and replacing it with the run_command API, or

 (2) bringing us back to pre-c70bc338 state first and then building
     up what we would have built if we didn't use run_parallel stuff
     in the original series.

As you were saying that what you would produce with the former
approach would be, compared to the initial "regress fix" that still
used the run_parallel stuff, a large and unreviewable mess, I was
throwing out a different approach as a potential alternative, with
the hope that the resulting series may make it reviewable, as long
as the early "straight revert" part is straight-forward.

If we take the "start from 'master' and fix minimally" approach, the
whole thing would be both in the maintenance track and in the track
for the next release, I would imagine.

So, in short, either way, we would not run hooks in parallel, and we
would not run hooks with run_parallel API castrated to a single
process usage only, in the version we will merge to the maintenance
track and also to the master track.  The latter may get an update to
re-attempt reusing run_parallel API in a way that is less hostile to
existing users, but I do not think we should make users wait by
spending more time on it than necessary right now, before we get the
regression fix ready.

Thanks.
