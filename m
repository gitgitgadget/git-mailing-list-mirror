Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB03C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5F4223C8
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgLOC4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:56:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61049 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgLOC4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:56:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2A3710F9BA;
        Mon, 14 Dec 2020 21:55:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ixqBW5VS4iLm
        IrPaFjvyCuGk+Vc=; b=xoYwNNg5m6yNDh4HiuwjW/4+FwBa5rKhR6GQ8REONdnw
        BDv8GGbJFax0fSx+T1yPehzb05Nyu4bPrFsDgQY5eQvdeIS3caP0Df0+s5BtMxw0
        4TTILg9o3EWtwFNiBdFm7QBbT1pz/D7M6Ugk3OMgSSlSDFx/jMenQO4cYdzn68A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S6U3Lq
        IrEM9OxJDN9scWG9B7Lmgoxidc9PNedWa0XYzEY4vWoPdy57pfQUjG1wScq7u47Z
        GFYa9iIscIJhWDhkqO1x/xafRafVEzx0E5nCWnVle6CuuqjMVm/O8TmVdIivS3SF
        wafgzXvwSczpqFOlzYxICzDFWKNT54SpgWTOM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C10510F9B9;
        Mon, 14 Dec 2020 21:55:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E51D710F9B7;
        Mon, 14 Dec 2020 21:55:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <20201211210508.2337494-1-jonathantanmy@google.com>
        <87blewwoil.fsf@evledraar.gmail.com>
        <xmqqim94e4et.fsf@gitster.c.googlers.com>
        <878s9zx2ul.fsf@evledraar.gmail.com>
        <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
Date:   Mon, 14 Dec 2020 18:55:33 -0800
In-Reply-To: <X9ghqMo5WS8FrBEz@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 14 Dec 2020 21:38:32 -0500")
Message-ID: <xmqq8s9zaica.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00C522DE-3E81-11EB-83CD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the situation is better than that. We are surfacing the remote
> HEAD here, and there is already a command for copying that to our local
> tracking symref: "git remote set-head origin -a", which will set up
> refs/remotes/origin/HEAD.
>
> I think there are two ways we could improve that further:
>
>   - making it more natural to pick up or update the remote HEAD via
>     fetch; Felipe's patches to git-fetch look good to me

I do not mind that as an option (not the default) to the "git fetch"
command.  But I think =C3=86var was driving at the lack of a scriptable
building block.

>   - it might be nice to be able to have some equivalent to the dwim "gi=
t
>     checkout foo" that creates a new "foo" based off of origin/foo.
>     Doing "git checkout origin/HEAD" will detach the HEAD. I think righ=
t
>     now you'd have to do something like:
>
>       tracking=3D$(git symbolic-ref refs/remotes/origin/HEAD)
>       branch=3D${tracking#refs/remotes/origin/}
>       git checkout -b $branch $tracking

Meaning "git checkout origin" would look at origin/HEAD and find the
remote-tracking branch it points at, and uses that name?  I think
that does make quite a lot of sense.  You are correct to point out
that not just "git checkout origin/HEAD", but "git checkout origin",
currently detaches the HEAD at that commit, if you have origin/HEAD
pointing at one of the remote-tracking branches.

But if we were to make such a change, "git fetch" shouldn't
automatically update remotes/origin/HEAD, I would think.  It does
not matter too much if we are talking about a publishing repository
where the HEAD rarely changes (and when it does, it is a significant
event that everybody in the downstream should take notice), but if
you clone from a live repository with active development, you do not
want to lose a stable reference to what you consider as the primary
branch at your origin repository.

>     Or maybe not. It's not something people probably need to do a lot.
>     And if the point is to have plumbing commands that can do the same,
>     then maybe those commands are sufficient.

