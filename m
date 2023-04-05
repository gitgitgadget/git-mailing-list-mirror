Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E9C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 12:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjDEMHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbjDEMHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 08:07:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B865586
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680696450; i=johannes.schindelin@gmx.de;
        bh=wpYRVyD3tHtAhgo2QyNzdchnXkB+JgS4Q5Lp3ZeyR00=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K3S76TTS+cgzICcy8ddrurilaEfoz4gHTRfB20w96lKXYQS5/EF4Hk36u1JLnRIDK
         QMgPfHAmI7EXfDi6et5Whu8fW7IOsrr6pWkkOSR64wV9MHm7TQwlNqF3rjhyEDQTAe
         9tsvsAJAUfJzGdjsJgCD86zlU6CFbJqhJGHGPmEO75dMbkMOLEbIsXbSzLCf75RMMc
         eZFkxpzPW5zrYB/JQ1ZAKw6pkCBOaIumYh2lSoWGAFTZXr6zvSE7Z7rywsHXPXj+0E
         OqsYuFTRyhK3KisKlljkSmRBa7w8SiVaHVnqzYfBJ/ZmAskm+PUkSmKITgOGh0cQZe
         Vhzcge72/CObA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1ptHLk2F50-00R0Kk; Wed, 05
 Apr 2023 14:07:30 +0200
Date:   Wed, 5 Apr 2023 14:07:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
In-Reply-To: <ZCMRpnS9gzN1Rlbh@ugly>
Message-ID: <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de> <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de> <ZCMRpnS9gzN1Rlbh@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VSDPgEGa2s4Fv+61PMH3NEZw+Cc80i5jFJSSeYM8iajdTgq0x3E
 84eRH+8+5qUXEKMJicyebOMG8/n5v24Ba654fVQX0R3YE6LJZpW5R9MkhNOzCTRKib6x0xw
 0p2liPAup8JKuBjKO7q7J/34jLbcSDjLI/pEFORulYzRZDcWpjjoPHBhNB98BzrA58nuirm
 ypRPHLMtbtz0JtuOdv9fw==
UI-OutboundReport: notjunk:1;M01:P0:j/TgAZWzVHQ=;UKKoe6lF+Oa0L4dVZtnTwsgCSsL
 bGwyWTxcNxEIe5VxiCbQA9KYAl3NkVxTSfkIxtWkxzCItDHjHL7kzvAJ4u6AvPhtuonv6wQla
 /bxh4IL1IvJ9r0PgZteMK+a86XEYDUsUQPvtv3pRiyzEl6cXGZAH2n/29f0PTtIVJVkkIv0wr
 RZmmSSiN7beK4DfilgWx2jcMej98mqpmgAAm3HLtJ4uc+ZFTreCqdWRVpRxfrxN3LrIfVqm/x
 o/ymAi+CH6m2J55PFNHi12lqp6fhbfTgKMn+FUHVYjfBYlVs8eIde3MSCB2dprK5WghiKI5AV
 rG1KqTqWUP8BWxKjnKX7hbN+TQ76sbL2ZUr/XkoV++klyC/maPAPPOMnFC/qqgtCvKh6Rb4bV
 794G1yNhKLe3CN+xbEGy29rfl5B7DZcrF41Zf1pjJWJFerUUWU/AbBO5C9IjrBRZrhcUctqH3
 J5SgfbwFt3zcWnDj+vuo+qOViEH0Jc//CygG+4h5Y2noWs98OD9p0yQpD1FJg2Iaf171eHaAu
 85IQeqvsMRG7TRWVM+jVGo8Mu/CAxssVqo7f0iONUtOQRYmHgaEkk/QLbjefCOQWlvYYyqekE
 0oiLiQkFpHnvGpevyP4+ZobOsGvtJsPIKpVsBZlAPTmMROJ3sGRNNOqzl4CKRf1QzMP5Vp1pb
 2k0CKgCJuDwb9JY+qCcyBRYh3V4hogrkDPCieDKi88Vuvho1ZNyi1VjKw/Dc4LrzD5r1b6R1u
 7Kyijd4F5iNF0xxb9P0lyz4DvS7pE6OINPgD8b0MF148Al9xvSBcp/e5uLxM1GhGpdgAQn3wu
 RS6mUFd1OEnUJMD7PZ5MxPsz2ws0/qQUo7Iys7uGa7NpP2iLdw4DTpO6/hRBpcvBsAQ3qGsPo
 f3v+oMbFeGK65TuSAE/q4Tr4rKBhiugHT6ROKpavyaDEbgdLY2yNwXu0Ra8tvE5tlY2rrqx/z
 OKxc7Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald,

please do reply-to-all on this list.

On Tue, 28 Mar 2023, Oswald Buddenhagen wrote:

> On Tue, Mar 28, 2023 at 04:53:52PM +0200, Johannes Schindelin wrote:
> >I do not think that the concept in its
> >current form mixes well with being in the middle of a `--rebase-merges`
> >run.
>
> fundamentally, it shouldn't pose a problem: the already done part leads up to
> a single commit, from which a complete todo with merges up to that point can
> be built again, while the remainder of the pre-existing todo should be unfazed
> by the fact that you're repeatedly messing with whatever branch you stopped
> in.

I guess the most important question is: What problem is the proposed
`--rewind` option supposed to solve?

If the idea is to let the user re-start the rebase (for whatever reason),
throwing away the current state, then the proposed code really does not
handle the `--rebase-merges` case at all. Instead, it would implicitly
restart the rebase with `--no-rebase-merges`, i.e. the opposite of what
the user asked for.

But a more important concern is: Is this `--rewind` idea even a good one?
This question brings me back to the initial question: What problem do we
try to solve here? (This is a question that try as I might, I cannot see
answered in the proposed commit message.)

Since I do not want to speculate about your motivation, let me explain the
challenges I would like to see addressed with those rewound-or-nested
rebases.

I frequently find myself in _large_ rebases (we're talking about several
thousand commits, with some 100-200 merge commits), where I notice in the
middle that I should have resolved a previous merge conflict in a
different way.

Do I want to start over and redo the whole rebase? Sometimes I do, and
`git rebase --abort` and the Bash history (Ctrl+R -i will get me back to
the start of the interactive rebase) are my friend. No `--rewind`
required. (Which makes me wonder why that same strategy is not good enough
for your scenarios, too.)

However, that's what I need only in a few, rare instances.

What I need much, much, much more often is a way to redo only _part_ of
the rebase. Like, the last 3 commits. And not from scratch, oh no! I do
not want the original commits to be cherry-picked, but the ones that were
already rebased.

In other words, I need a nested rebase.

Now, why do I keep bringing up this idea of a nested rebase, when such a
nested rebase would not be able to perform a rewind as you asked?

The reason is that I am still very much unconvinced that `--rewind` can do
anything that `git rebase --abort` and starting over cannot do. So: no
patches required, right?

However, the use case that _immediately_ comes to mind when you talk about
these rewinds is when a part of a rebase needs to be redone, in the middle
of said rebase. And that _does_ require a nested rebase, and the
`--rewind` would in most cases only throw away too much work.

Ciao,
Johannes

P.S.: Yes, yes, I know, a nested rebase can be simulated via

	git worktree add --detach /tmp/throw-away &&
	git -C /tmp/throw-away rebase -i HEAD~3 &&
	git reset --hard $(git -C /tmp/throw-away rev-parse HEAD) &&
	git worktree remove /tmp/throw-away

but that is of course not only inconvenient, but leaves too much
book-keeping and safe-guarding up to the human user, e.g. to make sure
that the `git reset --hard` does not overwrite uncommitted changes/files.

FWIW I simulate nested rebases in the illustrated way _a lot_.
