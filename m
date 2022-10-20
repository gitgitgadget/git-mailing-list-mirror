Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A2C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 15:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJTPqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJTPqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 11:46:17 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032E476F2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666280769; bh=seDmKzIuxhUQOrBQafeMbeDZYUlXT7z2N1lw4v6W3hs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KudzfZGYpmf7sXMsF9nlJoY46BUcsV1/NbUWNsRL0IYJu5M/M2l+tLrZUiwzKhNqH
         7hXE8uyHgTkwAL9m2TPRe/r+Z3c9NGKOXcfthZjc9dTKDeIRvNW7hywCCqk/7+TIiF
         JhXEVlB1+HAqWFCxAmtWnkLZ/H955vcoT8RT2kFSCGRaYPubsYlOuFjBd346OquXyu
         0WrsDpv32sQ78icuslXSnQWq/jWqc1N9eZTjlUiwL0I7dZ37AHgZAk/twar1UjV/43
         C61ZgajeyrG0+I/zuN2/7302HICI7DA+gk6k+QU22zu+Y2eO7a9Qm/1qTCiCS/mFao
         DgZs+M99Z0BgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ac-1pQuSF337G-00o8kp; Thu, 20
 Oct 2022 17:46:09 +0200
Date:   Thu, 20 Oct 2022 17:46:09 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20221020154608.jndql5sio3jyii3z@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220914151333.3309-1-tboegi@web.de>
 <xmqqpmfx52qj.fsf@gitster.g>
 <20220926184308.5oaaoopod36igq6i@tb-raspi4>
 <xmqq35bv1gu5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqq35bv1gu5.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:aYGOVhtSanYabWdCs+CAHMAlfoqiYOSz31vNnl96OXbsg/kz4jD
 lmpPfvjG8AcNzym+ovsui1ZonIHTMnOWh0x1505cw1bR6jgl87FklQG+qcYfkYymqemLzz+
 NC7fGIbVDG6edZAZh+2kgvimJtmrFTN6ov5tvsgdtzgdqqXhvIDDJtcoL4PR1rcVKKFtMyA
 FxvE7GtUtgRJ6y4QF5Rzw==
UI-OutboundReport: notjunk:1;M01:P0:GRG17q++XRQ=;gryeNBV8Jvo9iKS/gvGnvW0ru8w
 7YnSIJ32u9kv8RRBuyRNhzJHrpfVCSI5QQgOrBX/ona6WcIIOMPSwsa0r7BRVqYIhabilEyXV
 tEpNvnB7Vs6/ViD7R4KvCxTuYFqc0LacSvMdJSbnWVNmduPzovGXzHXkcLOTxZvPG6ve1cdew
 nbHGYZJq9glJYzkIhBKt2097SMwG3iIX5vNCw6LpGw7232p41tJuCtCiiCdEmAJ03tyX6HW8u
 0B4OlX9K5u3mjMNW4WGiU0ma/DW2V76GpVCda1sR26WQGwog2wWoowtEsvjkiACeOCiwBcSkl
 Smu65Sf1IbADXmLAS50p/eZd0d04776qsKqSmEKWsF38sQlN0XP/uChMT6WPmG9pM4ozGueZQ
 IKAbC8e5wBMUVCbovDaOr4Bv5ckyUEyIppp0RBSU3LUR+qXSHLaxwKVRXACEjdQpuHuyUL65Z
 3tl4EcUiEaWiFFDK7m6e3pSfvPZEKnvYCwmdTh7vTIkvfvPnCJ6NWVLdeH/jM7imCb2ZLldi/
 xCtkN8guq4bkuiRnxP4UByVGLoAwRaXNOe/ZcqDDwHit8PN6LUMdvVNBUc7jS34dM4c/VDAjq
 m0+do7hUb7QdDUvKisi+WveraQj8x/ATdfr5T1liX3/mEdXOVKcjIaXWgCzqCY5tfwEdFjtZb
 sPiYRuSkC1KaNsiuUIDem1D8bR8GwNV31Vv4K84oBQ+eWqZ+o2QTEva1l0HUVjLtJ0g5+b9Wh
 oKTSQEkUX7vq4WRrR7rW+9hAiyVw1HM6LjOld9QbJt0BvXvCF9s8+WhniCPyFdp7lrqQAgr7k
 YJrdkCF9mgwhc/EpatdNYCWCdgbl/iboNlO9AZ4Ny5+56XxvGhf39Ed1uC8RjEwBqaSsloSeK
 ZMA0nsFBRH65zs6bJqP+mJEzybC0hzPRPOgno40TmuqGo0LhdA6hupc+XVKUSf3vfhC/jiDTc
 2f5oVg+DN0TVq3q6hcRq03igLwM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 02:58:26PM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > On Wed, Sep 14, 2022 at 09:40:04AM -0700, Junio C Hamano wrote:
> >
> > []
> >
> >> I think I spotted two remaining "bugs" that are left unfixed with
> >> this patch..
> >> ...
> > How should we proceed here ?
> > This patch fixes one, and only one, reported bug,
>
> But then two more were reported in the message you are responding
> to, and they stem from the same underlying logic bug where byte
> count and display columns are mixed interchangeably.
>
> > "git log --graph" was mentioned.
> > Do we have test cases, that test this ?
> > How easy are they converted into unicode instead of ASCII ?
>
> The graph stuff pushes your "start of line" to the right, making the
> available screen real estate narrower.  I do not think in the
> current code we need to worry about unicode vs ascii (IIRC, we stick
> to ASCII graphics while drawing lines), but we do need to take into
> account the fact that ANSI COLOR escape sequences have non-zero byte
> count while occupying zero display columns.
>
> The other bug about the code that finds which / to use to abbreviate
> a long pathname on diffstat lines does involve byte vs column that
> comes from unicode.  From the bug description in the message you are
> responding to, if we have a directory name whose display columns and
> byte count are significantly different, the end result by chopping
> with the current code would end up wider than it should be, which
> sounds like a recipe to cook up a test case to me.
>


I couldn't find how to trigger this code path.
The `git log --graph` help says:
=2D-graph
    Draw a text-based graphical representation of the commit history
    on the left hand side of the output.
    This may cause extra lines to be printed in between commits,
    in order for the graph history to be drawn properly.
    Cannot be combined with --no-walk.

There is no indication about filenames or diffs in the
resultet output.
If someone has time and knowledge to cook up a test case,
that would help.

For the moment, I don't have enough spare time to spend on digging
how to write this test case, that's the sad part of the story.
And that is probably a good start, or, to be more strict,
an absolute precondition, if I need to change another single line
in diff.c

I still haven't understood why the current patch can not move forward
on its own ?
There is a bug report, patch, a test case that verifies the fix.

What more is needed ?
To fix all other bugs/issues/limitations in diff.c ?
If yes, they need to go in separate commits anyway, or do I miss
something ?

Can we dampen the expectations a little bit ?
