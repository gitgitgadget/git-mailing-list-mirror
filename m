Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F03EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbiBYQcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbiBYQcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:32:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F673211880
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645806681;
        bh=f9EMQ5l8mf41ZsbtO4MhVYF9qAcsBPv6ZXOKUl0WaZo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T+ntnsnvH5dr/nJOR6vA+cHpOFJZmfVqIKiSGeK7jLN2RPqunBjEz8BbMYG6WC/1p
         +jeSNihs90ysXHkzAhgS/8ngdyVm5+uKGoLF7GmS0djjIW4F+JW5Q33Qn6v8A6HCuY
         iDtiaaqnQtS1+fnjPAaKjIAYyPL/pZDJUV+df3WE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1ncq240ci9-00KBXo; Fri, 25
 Feb 2022 17:31:21 +0100
Date:   Fri, 25 Feb 2022 17:31:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R9ZC6yJ2LpwBngI0x3EM3EtbVk1noHixnp3Nwq/22/kDTOn+lvj
 4EUxOJhsMnJKHJEBVy1F6qcn2d21yWDK/j1Q8MBQFtlVN2kScuqWj+8heDnGHv7t8mtJAYW
 PXa8BGvftvlHmXXy24wVf7vMr/Yi6tadwv/lAAm7zMhJ+yIyTzfwHjO3cb+QXe0Bcxne4EC
 GljojD1wbNs2HkvryITXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iL8f4dPo1Rw=:S3WW4RyLUnfft+6QgGp5ZX
 kEots8+s1rd0/E1cCgxhUm0jyLwMur8dlJ+h7Jg6S0Jlu56W9hzdHViNemekT6shmGSfqk6Pg
 sQqtfuROD0+ks15uujc96m+WmXwKQVCnIq335B1XypwOwA8ikVlOPw86AhljVnEUBhF3sMs6i
 eDxOSV/8r7ZD9rgY0VcWbTdNJZXVyYIIVdIGo/vmPICsziMJFSttgZnjlNv1LU2/fkDao2soC
 YyHaL6qzrCYtUP8/s7KysUFC9fbBazSEAeAtWaZXNTQrkwPu1zK4qB1JJk2Kwsp+WTXJJ+1Wo
 QBSUIyoP1o/DSwSGalKymumwJn++CNZpE5OI2icWncWcojRUIXP9MuRnTlKZN7e9XoiKaDjKw
 IWVUZuEOVYRnW1N/dpEIUkV9kYsrsCNdwhvdAVYG/uGGnB1n8/5orn2voVrsr4Lts8mdWU1mt
 DEaDn7QWRl6OjtfHK7E8K6VipHPPMkdSW7DcrxbbOq8S3jaat6Gft+m6yZhHkECYGiheMIY9w
 5lyxgVcJYGiR4JkP3FVv0EnH2DpGDnpvxKjeLXvhYp6lH9ZAPCRuPwWrND/JRXIPNfebZPMCJ
 AfdsrZY4BcoJZBpd2H+CWqEI6hCHMiZ5zUjuPbP+FnrMKGlejCAhiv0ip0q/0VK1/lbVZasVD
 alJUShktACbEpKerj2hs0BZnPl/ON62/3uXazdJUw/7X4aoJGqVb7B6m0uJ31A9QwQWguiBcV
 zdx6br35w3YrNCWLKibLS+X9OJeMf+d1m/cPhKZYdXhDspW9gsAhqMH2dnNwVuN4fiR3ood7T
 vM2TTnftg4CNunuYHKRkj9+foW4coOYW0KSIN8TM6qvzBLq2p/1UmiYhFNJjj3i+KsXIE5Mgb
 Ic3coEy4m3hOIAntLvPc+Gzzi9w6EaiT87veLsOOJF4esoqLDvU71DZCZfHAUlrP227xhMJWQ
 4aO1jlegDmjMN+//x1kHC7BSFb6v2VKTkAE58ynQ1Vhu3jrbyeL7QZs4fEVh9LR+/lsDM+joJ
 G1MpKxvEuQ6criE5qzALBKouI3wvE+ILtIcqU6zaYT0q1+71dLGZod7HhU+Q5jem0M/SXzmDd
 TlAS3gFl9iZ26I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 22 Feb 2022, Elijah Newren wrote:

> Sidenote: Do you lump in binary merge conflicts with "non-semantic
> merge conflicts"?  You would by your definition, but I'm not sure it
> matches.
>
> I tend to call things either content-based conflicts or path-based
> conflicts, where content-based usually means textual-based but also
> includes merges of binaries.

I like "content-based conflicts".

And no, I had not even thought about binary merge conflicts yet...

> On Mon, Feb 21, 2022 at 2:46 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Concretely: while I am not currently aware of any web UI that allows
> > to resolve simple rename/rename conflicts, it is easily conceivable
> > how to implement such a thing. When that happens, we will need to be
> > able to teach the server-side code to discern between the cases that
> > can be handled in the web UI (trivial merge conflicts, trivial
> > rename/rename conflicts) as compared to scenarios where the conflicts
> > are just too complex.
>
> Um, I'm really worried about attempting to make the conflict notices
> machine parseable.  I don't like that idea at all, and I even tried to
> rule that out already with my wording:
> """
> In all cases, the
> <Informational messages> section has the necessary info, though it is
> not designed to be machine parseable.
> """
> though maybe I should have been even more explicit.  The restrictions
> that those messages be stable is too rigid, I think.  I also think
> they're a poor way to communicate information to a higher level tool.
> I would much rather us add some kind of additional return data
> structures from merge ort and use them if we want extra info.

Okay.

I thought that we could keep the `CONFLICT (<type>)` constant enough to
serve as such a machine-parseable thing. And then presenting
`<path>NUL<message>NUL` could have served my use case well...

> > Here's an excerpt from t4301:
> >
> > -- snip --
> > Auto-merging greeting
> > CONFLICT (content): Merge conflict in greeting
> > Auto-merging numbers
> > CONFLICT (file/directory): directory in the way of whatever from side1=
; moving it to whatever~side1 instead.
> > CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified=
 in side1.  Version side1 of whatever~side1 left in tree.
> > -- snap --
> >
> > This is the complete set of messages provided in the `test conflict
> > notices and such` test case.
> >
> > I immediately notice that every line contains at least one file name.
> > Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, =
it
> > does not seem as if the file names are quoted:
> >
> >                 path_msg(opt, path, 1, _("Auto-merging %s"), path);
> >
> > (where `path` is used verbatim in a call to `merge_3way()` before that=
,
> > i.e. it must not have been quoted)
> >
> > I would like to register a wish to ensure that file names with special
> > characters (such as most notably line-feed characters) are quoted in t=
hese
> > messages, so that a simple server-side parser can handle messages star=
ting
> > with `Auto-merging` and with `CONFLICT (content): Merge conflict in `,=
 and
> > "throw the hands up in the air" if any other message prefix is seen.
> >
> > Do you think we can switch to `sq_quote_buf_pretty()` for these messag=
es?
> > For the `Auto-merging` one, it would be trivial, but I fear that we wi=
ll
> > have to work a bit on the `path_msg()` function
> > (https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) becaus=
e it
> > accepts a variable list of arguments without any clue whether the
> > arguments refer to paths or not. (And I would be loathe to switch _all=
_
> > callers to do the quoting themselves.)
> >
> > I see 28 calls to that function, and at least a couple that pass not o=
nly
> > a path but also an OID (e.g.
> > https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).
> >
> > We could of course be sloppy and pass even OIDs through
> > `sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be a=
ny
> > special characters in them, but it gets more complicated e.g. in
> > https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where=
 we
> > pass an `strbuf` that contains a somewhat free-form commit message.
> >
> > I guess we could still pass those through `sq_quote_buf_pretty()`, eve=
n if
> > they are not paths, to ensure that there are no special characters in =
the
> > machine-parseable lines.
> >
> > What do you think?
>
> Switching to single quoting paths as a matter of style might make
> sense, but only if we go through and change every caller to do so so
> that we can make sure it applies to all paths.  And only paths and not
> OIDs.

Yes, that sounds unappealing.

> But I'm going to reserve the right in merge-ort to modify, add, or
> delete any of those messages passed to path_msg(), which might wreak
> havoc on your attempts to parse those strings.  I think they're a bad
> form for communicating information to a script or program, and trying
> to transform them into such risks making them suboptimal at
> communicating info to humans.  These messages should optimize the
> latter, and if we want something for the former, it should probably be
> a new independent bit of info.

Makes sense.

So we need something in addition to those messages.

Ciao,
Dscho
