Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157FB64E70
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhBLQF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 11:05:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:36281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhBLQFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 11:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613145848;
        bh=azkgYQDxYq9/3B/K/DXoXQrW/AZjTGvCp2NqowErV/c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JYsloWhHb5/RahoPzEF/I3vtgLPhryB1laKXLEYpE2W/1wn27ehtPqiyxwcLfqp21
         CHDjzBUV1v28qo14DYBbgGKGP4iymkBkhaORxnqGxlRqrindNXbXFmf0pY3zaFzj9H
         s8q/w1kmf3n7Y7sIZI52pBBwdeqs2zcSiYHo6PMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1m0Uer2YcP-00sLWV; Fri, 12
 Feb 2021 17:04:08 +0100
Date:   Fri, 12 Feb 2021 17:04:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] reflog expire --stale-fix: be generous about missing
 objects
In-Reply-To: <YCUQkqXNXFzBs7aA@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2102121702120.29765@tvgsbejvaqbjf.bet>
References: <pull.873.git.1612973499110.gitgitgadget@gmail.com> <xmqqy2fv1x98.fsf@gitster.c.googlers.com> <YCUQkqXNXFzBs7aA@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TOgevgi/Ym2TR628lNkk/FBXm3WGOdCWdTTBoMZO/U201pHyMaw
 b4JrsSrDH/UmHCwo/kq8+pnpDyn0LNUZ/rUjnd8clE0Zf5hW79KeraEN+ajrEgurDjcy5fh
 3tUb7mLDYYXAf6ha4f/qn3Z3dEbe2fgxdJP5OocwetD4+/HkTIF9lSQ4ZiME8ZxUNx9Mjs5
 vMI1bTHwnBb2JrvDqVulg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dzB81TU1rwg=:oZuALRJBVEjcRhE1T0f7lg
 XNqeZkj7fBU2TMVcC8/KJnFuHTGjUCStK7SXvMu7zAz6wxdsCUQTh6w7Z2N7/3DHbbFUIJk01
 +4OoQB0cVYl4mlqBWHHCvIgA7K4SZycHFpTIN29gQ7pDbIHUKZljRMPbJnqD1JFdkDQg7DcuQ
 k8dT36NPT0CfBS9HAPENAFJfIRsKexFYKRoc1zt7Sr1k+TuNbG0V1e229Tlq+NoaWrM8NDZj2
 Cjqo5do31EsganbbA5MQ43r5BmABiCVFFE8lUB8Kkh4PmL3PmCmltA1nZOXdH/rCdSMMt+LME
 GQqhyBwSAq/MyTYFI6LT9c+ePFnrSEOrNZSShTp4hN8brdn+5sGpeuKQDFWsERYI1TyDZGup5
 +kFes2cUt1LqP8lUkUCAHjRjQW6xMbjV3xpf0ByaqMfrfJpGKMgobcDf5KmSTP3NxY6Ky2oLJ
 ruTWFVUfCsds5Nxk1CQSSUsOwlZz3/upOXfoaRiirbkXLC4CVDHQ2rsShOjPlG0ETWNkkUhqY
 WLtO2BuLMAWYqrjkxo0Lp2EbrU23v92E64fw7WGCrMtf+/0rXXFadMaETOCXk0m3kiC48jrCY
 TqsjCpw6d0O6r4BpyfFO5cEOR3QVsPlsYKiD2vLZKt75BvBSH8DZrM0VwwOIqXwvRUzx6ApLJ
 OlKH0oE4SMWbzyTGbNkl779J3cTMy1jba8V56KUDMvKt3sKlV/aLqDzbsSnxXST4K7UzGrG4W
 uINEkGwidcCPrQA+xrk20bac9yHepDLJeH+Wb82cbHGO9AXaeKvXWVbhM1NoUdTPjjB8dnCRT
 0xiZ0yKFZ5gqnSPp2ohxjdzLY3AuPJpdKEOQDdDS9tUQftneDof1rZdNoX0E+GjFfumca7sS/
 v7P9YrMQFgJERNnEJjWumqUemVNieZ2SefaZhB2Tg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 11 Feb 2021, Jeff King wrote:

> On Wed, Feb 10, 2021 at 12:30:27PM -0800, Junio C Hamano wrote:
>
> > I appreciate an effort of making it looser and less likely to get in
> > trouble when running in a corrupt repository, but --stale-fix is a
> > bit special and should probably be removed.
> >
> > The only reason the option was added was because we needed to have
> > an easy way to recover from a specific kind of reflog corruption
> > that would have resulted by a (then known) bug in "git reflog" in
> > the released version of Git that came immediately before the version
> > of Git that added the "fix" option, while the root cause of the
> > corruption got fixed.
> >
> > Back when 1389d9dd (reflog expire --fix-stale, 2007-01-06) was
> > written, it was very useful to have a way to recover from the
> > corruption likely to have happened with the version of Git that came
> > before it.  But it no longer is relevant after this many years.
> > There may be other ways to break the reflog entries, but --stale-fix
> > was never designed to deal with anything but a specific way the
> > reflog gets corrupted (namely, by the old version of Git that
> > corrupted reflog in a specific way), so keeping it would not be very
> > useful.

Thank you for the original historical context.

> FWIW, I have used --stale-fix for cases where a repo's reflog was
> "corrupted" by its alternate pruning objects.
>
> E.g., if you do something like this:
>
>   git clone -s orig.git new.git
>
> you're now at risk of "git gc" in orig.git corrupting new.git, because
> its reachability check doesn't know anything about those refs. You can
> mitigate that by keeping a copy of new.git's refs in orig.git. Something
> like:
>
>   git -C orig.git fetch ../new.git refs/*:refs/preserve/*
>   git -C orig.git gc
>
> But that doesn't know about reflogs at all! It will still corrupt them
> (but only sometimes; depending how often you do that fetch, you might
> catch the same values in orig.git's reflog).
>
> Possibly the correct answer here is "turn off reflogs in new.git", but
> they are sometimes useful, and things _mostly_ work (for history that
> doesn't rewind, or where the rewound bits are specific to new.git). So
> it's useful to be able to run something like "reflog expire --stale-fix"
> to clear out the occasional problem.
>
> (A careful reader will note that objects mentioned only in the index
> have a similar problem; but again, those tend to be local to new.git,
> and don't exist at all in a server context).

I want to add the experience with that half year during which `git gc`
with worktrees was broken, as it would happily ignore the reflogs of the
worktree-specific `HEAD`s, all except the one from the worktree from which
`git gc` was run. That was some fun time, and `--stale-fix` was a life
saver.

With this _additional_ historical context, I would deem it wise to keep
`--stale-fix` around.

Ciao,
Dscho
