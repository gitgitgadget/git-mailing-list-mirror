Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2EC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbhLMVwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:52:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62436 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbhLMVwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:52:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA7F91114A8;
        Mon, 13 Dec 2021 16:52:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dbPcbfmUO+ak
        rIsuM2yUeAYOjb45bnQu7rGCARtYt5c=; b=yDk382XMPGrEgs1gQmkWQUUYTTW3
        tklKsKOSDqRRJZJY+MdvNJbr9Xf/2a5heO/Hf75oErzJlGPj92tHwAYOXicYxsjp
        QaZaG1sjAP/6I0CePBmc2AjPIG/qU1JsbYjAK5q+6mMEgNjSCohfT5UjBb6v4FjX
        TIwEI1uYm0sTHJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1EE11114A7;
        Mon, 13 Dec 2021 16:52:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A1C71114A6;
        Mon, 13 Dec 2021 16:52:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
        <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
        <xmqq5yrwm7km.fsf@gitster.g>
        <CAOLTT8Rx9M9=a5M8UeDrJqMayTXo=dvdanVDLi7QLdPX8W_Tzw@mail.gmail.com>
        <xmqqy24pk6f4.fsf@gitster.g>
        <211213.86r1ag6ztx.gmgdl@evledraar.gmail.com>
        <xmqqr1agb313.fsf@gitster.g>
Date:   Mon, 13 Dec 2021 13:52:33 -0800
In-Reply-To: <xmqqr1agb313.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        13 Dec 2021 13:36:40 -0800")
Message-ID: <xmqqh7bcb2am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAA18A6C-5C5E-11EC-822B-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I don't see how it's fundimentally different than the DWIM logic of
>> taking "<name>" and seeing that there's only one "refs/heads/<name>",
>> and giving up in other cases where we get ambiguous reference names th=
at
>> we can't resolve.
>
> In that example, once you obtained a local branch whose name is
> <name>, it is obvious how you would work with that.  Your next "git
> checkout <name>" would work on the local one, and only the initial
> one does something magical.
>
> Which makes quite a lot of sense.
>
> There is no similarity in it with "--to-branch <tag>" that is being
> discussed here.

Another thing you seem to be ignoring is that it requires you to
prepare in advance and keep one (and only one) dormant branch for
the <tag> you will use the "--to-branch <tag>" with, because it
finds the branch whose tip exactly points at the tag.

You can use the command exactly once for the <tag> and check out
that branch, but then what?  Once you start working on that branch,
you would by definition no longer have a suitable branch that can be
used to with "--to-branch <tag>", because (1) it was the only one
that pointed at <tag> or you'd have gotten an error, and (2) you
have moved the tip of the branch so it no longer points at the tag.
And you'd expect the user to say "git branch <next-branch> <tag>" in
preparation for the next time you might want to use "--to-branch
<tag>" and keep that pristine?

I do not think of any similar counterpart in "teach checkout <name>
to dwim and fork from a remote-tracking branch from a remote, if
there is no other remote with a branch with that name" DWIMming to
these nonsense.

