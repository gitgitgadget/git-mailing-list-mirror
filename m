Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8C3C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiBVQql (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiBVQqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:46:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D716A59F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645548357;
        bh=3tZKyfIGdJ7v+3+At88e2qBRJjihkdx7j/HOxJZC7bw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AgwxyLaXteBhtkwv5vM4Y2X/C6V85BrCg/ee7iM5pbuICiLICY7evcG5hivsqdcyM
         bYd0VkWtHH6uxEtJAkaKq++dKtvUZnoVlUN/TuQuooNPSVEYWcLGaflGlMVU1glymp
         b90Ik+UNG6LXel8LX4i6H6GEHmj3upEhZWBveCoc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1nMYIX29Wi-0000zw; Tue, 22
 Feb 2022 17:45:57 +0100
Date:   Tue, 22 Feb 2022 17:45:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
In-Reply-To: <xmqqee3wt5g3.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202221730431.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com> <xmqqy22tx8t1.fsf@gitster.g>
 <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com> <xmqqh79hvsgn.fsf@gitster.g> <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com> <xmqqee3wt5g3.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bF5k1RgpoI9wz5M+bmw95QET7JuttGEH/f14nmZojMm+EyFmy5u
 jAoPddM6pZDuTjXrNsMk4pBBhvmeWXxzDGWpfGvH1m7hlkxeFCF6hTSTqgcfXyiUF1PD5pi
 zp/eyVk8LW8ohFOtVZARc9H1sc/Bqq9R1v+ArGUd3m7aoSVw9weQ+gVQMMCg2uW5KnVv+FG
 nLvW4JkgZOj0AFPBB7j0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+yQoCuJ/4H8=:wcB/SEtEUiFGKlIVyGFMKe
 w+zK9DS7rcW/5zlphpqCkixEYy8HHfEAjrxHmVE+3fpG0kOiF88bTDTw1rWBjqGg/XoWIqTGf
 YXqyyxldgBmi7DaQIQmdCtEJc7vi2OHT4gtawzKc/PJmfuS+Vyjv9AXeSwE0APbuL2e3OhhTE
 a4F2NqDR71IA5g77qm2ogXGlu0mt4MLxN9wYsnwtAZ1casx/TJqoccRSXOANLScKthenUj4YK
 ebnYVUWMhf4s2I16Son8eSJcZ+EmqAYXr4jrVWrGeTE75wnuzdLb8XERNGkoaJ7hEslcI8WBs
 ZZYxSsCsbbflEwxXfZe8KW4OY22U4J+Of3V8gWnG80Q6dyPR4daRVXxVKZo79QOi+GIJR42Sw
 1C8oFwKNVJY4Z8PcT+co6Ix1yM0SHbA1zpJAAM5QkVmPsO1Ot//qwkfZsS99HCX68cTI3eQxP
 hNvRUCsv32FRfGXQtIkP9zE/Cyj+fxezkSfw/rB7pWu46YNj83aKLNa25brnKXQ2D+G2NG28d
 D4MPs2+lWt9SovcvDN8gRnanLeTPF1m11aUFLp+OhP88GZQ4OC1hRKh5d7kTkjhxUpMLUX05Z
 OrAYF5tPF2jFMQP8Cf6t5WesHcjUKXV3LQGU50OKg0M6kgSJm8rVVUCoyZ7ooYDsk6lsrP7eP
 au/xSz+Hhst//wuJ7bKy+Xv9GCJgYtefvS5CVzjwRz62R5hkOKh6ep1/pVJLVPrETnyCgAvB+
 AShhujyMmcA1WFdVSn2x70ezXNee/htCdUYzpbJNn2RoV5J/fjq0SP6MiWJavOBRvqX2u0UU7
 V4LCyN12zMCk6fXgLKn8qII3V95sayaiFl4JbhUGM4sDjTRJjd318STrkuJRQdAHotZQyeeYz
 KymxwVZ9+ITEFnLJlNtf+ylrIHXwldT/MD271CYCHR2ks0EK35785RftkJlwik5eAY4mlfpxY
 WVEyOTKHK87NnHrWhWWxjXZ/X09nwnQPPv15JCwYfEV/UDVG4cmonNbFOtat7TRyH4A5Dmc2q
 m3aeuSjKTkfK1aVWEG9v1XziId/lZteNP/OYv4muksx3Q+LufLJ9NMp9TLLw8F0GBaqaLMtsH
 6QZoOA5AIxV9Oo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Feb 2022, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > Adding such an ability to merge-tree would be trivial -- it basically
> > involves just two things: (1) accepting one extra argument, and (2)
> > calling merge_incore_nonrecursive() instead of
> > merge_incore_recursive().
> >
> > However, I think forking a subprocess for every merge of a series of
> > commits is a completely unreasonable overhead, so even if we provide
> > such an option to merge-tree, I still want a separate plumbing-ish
> > tool that does non-worktree/non-index replaying of commits which is
> > not written as a driver of merge-tree.  That other tool should just
> > call merge_incore_nonrecursive() directly.  And such a tool, since it
> > should handle an arbitrary number of commits, should certainly be able
> > to handle just one commit.  From that angle, it feels like adding
> > another mode to merge-tree would just be a partial duplication of the
> > other tool.
>
> The above does not make much sense to me.
>
> I am hearing that "multi-step cherry-picks and reverts need to be
> fast and we need something like sequencer that is all written in C,
> and single-step cherry-pick is merely a special case that does not
> deserve a plumbing".

Correct. The single cherry-pick will be a trivial fall-out of such a
sequencer, and the opposite is not true: if we taught `merge-tree` the
options `--cherry-pick` or `--revert`, the result would be a dead end
because it does not make sense to extend `merge-tree` to do what the
`sequencer` would do.

> But that argument leads to "and the same something-like-sequencer
> that is all written in C would need '--rebase-merges' that can pick
> multi-step merge sequences, and single-step merge does not deserve a
> plumbing", which is an argument against this topic that is utterly
> absurd.

But that `--rebase-merges`-like behavior is far off in the future, and the
sequencer is not.

If you step back for a moment and think about the existing use cases where
we want to use `merge-tree` on the server side, there are GitHub's Pull
Requests (and I suspect that all other Git hosting services followed
suite), where you have three options:

- merge
- squash
- rebase

The first two options are actually pretty much done, as we already have
a way with the current iteration of `merge-tree` to get the tree, and
that's all we need from `merge-tree`, the rest can be done by calling
`commit-tree` with the appropriate parent(s) and commit messages.

In contrast, `rebase` will require not only `tree` objects to be
generated, but much more. It is a fundamentally more complex operation
because of that.

Now, if there were already server-side user interfaces to cherry-pick, I
could potentially see that the next logical step would be to support
something like the `--force-non-recursive-base=3D<tree-ish>` option I
have already implemented over here (for separate reasons).

But I am unaware of such a user interface. I _am_ aware of the `rebase`
option to apply Pull Requests. So I think that's the logical direction
we're going from here.

> So why isn't your objection not equally absurd against having a
> single step cherry-pick or revert primitive as a plumbing?

Well, if you care so deeply about it, I will offer up that patch to
support `--force-non-recursive-base=3D<tree-ish>` (where the `cherry-pick`
and `revert` primitive would not need to exist but be the special case of
passing `CHERRY_PICK_HEAD^` as the appropriate argument).

What gets me excited much more, though, is the `rebase` operation. And
therefore I would like to spend more focus on that, and focus is a limited
resource (especially here on the Git mailing list :-)).

Ciao,
Dscho
