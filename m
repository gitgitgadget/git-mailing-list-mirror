Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B66C71153
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbjICPrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 11:47:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A2DE
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693756051; x=1694360851; i=johannes.schindelin@gmx.de;
 bh=20UFzxYQOSIP/oCH5aTUUbREE8QbS7twS7V9GiXVZh8=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=jP0ptb2INcfbxG0n/SyXBKjifHlXIRDmz4RCHEguFyco/0J5GTdHGcwKjueXYlQ3h8CPCqS
 6RTQRtpIRynlBxA4o9afB2HZtjLJqBzwCqhiYpJkCcxQLVYvQbXGx4VaIQynQ0lFgZvtzs+IF
 uI7yCHoxmETxFVOUBvwSaAMKEcqM4S3ds73t38YsTdxPf9ez3hwWParnMVDDJLZx+M6MYkJ0x
 Ag66ztYgNS0441sds3dp8ACW4whBX1opnyhm858kOSu5xyz0NPpR2TM988T3u0K1gFpxoaXS3
 fd+Gmp6oS5mhtt08jYvD6T71QZMtfNV/KFyYootzX5DdDnZyqrZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1q42T31w2c-00a0MV; Sun, 03
 Sep 2023 17:47:31 +0200
Date:   Sun, 3 Sep 2023 17:47:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee <derrickstolee@github.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
In-Reply-To: <CABPp-BGRtcBQ_6fkMrTskV9dk71ffycXZ8hEE_RaOrAdza_wLA@mail.gmail.com>
Message-ID: <f74fb509-0e1a-9542-d80c-0bec2a1e6740@gmx.de>
References: <20230407072415.1360068-1-christian.couder@gmail.com> <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com> <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com> <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com> <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com> <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
 <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com> <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com> <58f7918f-6ca3-2158-7d9e-bfcd8eb24b0d@github.com> <CABPp-BGRtcBQ_6fkMrTskV9dk71ffycXZ8hEE_RaOrAdza_wLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1693193536-1693756051=:134"
X-Provags-ID: V03:K1:FGzdsox1OMFEa9pqMOTrccWKcheQtvB2B/LhcrmTwMVA6Ndl0DM
 rl5l/4/8aPBlpaxQ92lIrDVY67c2W1yfgQijrt8ppBPOMPP7nQIpgZ+QYB4zGM0obB6oJ8I
 2+ZylRZgMmAI5lVrjR0enotp0WKShGgja2ZlvcWdCg62PqjysODPaia9eXMB7C7h38z04kK
 DK877JXwM7K4kxhjUECgw==
UI-OutboundReport: notjunk:1;M01:P0:+z7jqlWAekE=;ceRctew+y3xr3XdR7ZRnZgkxzOa
 QQ1Ari2oOqfAQg2adJNL6nad2NERq9QOukuo+nMduK9zFdDoFC6vF8fj8a1BpRUmBkzbi5MdM
 xJarxqJGgAi27n5jCBZXS+rJ/utvxKEuHMEsArO/ikA9fSY4ILl6UMBA9xaup9Nc7NzsTAjEz
 de2p2oO7jDYaRQ45eiOveunGuCJzVv5btYd3YpXx3Fwkw81o3Sv2VmTfNAX4r7kOU+jKs+6NX
 hPou5+Xh/6MyI9VJGiZxv+7ybN+l+JUW4XpyrbPYl/Xd3Evu3UjP63dHNIkXN/sUVTboiTU3K
 7NgbLI3lS4GaJZFM+yNuDcRrx+k3dZi7ZjeJke3elh0hNkfj1mr0A/AiEWdtx9nuFqwEHSSz6
 pHLZMf3KQjYDrw1yIpAIlb0FJS7gy/HmMFhEDNj5pB3YwHtBzG0a6vA2uKbtD4pCk8TJYdYhV
 i3yyQlpishaXXBYgWOzzeQpfYaL60nXi1tU4g/1+csJM8X+EpfSYIcMstc/lLYQ2akk95ZRFa
 4XBFuMKQDt3FSa3SuMV8gsS+6p9yBNdDGmVsij19Vox/3VqNMTS9D/J+mDF52+dGN1qpa0O97
 wTh0n8lWEeYok0lP1k8svJ0P32oHOPWCBIVqY9iYaxbc4D8aCtJGBH0ACfS4zPrS5HZWNleST
 ig8ugOUmtFXqVnToZ4O/1JPkfgnO7tZwkfcyOtleJOBn5kIPNKvJrU2IJgxHTRL6hpO03EqF2
 9T2XQLoSAmpPSvwymrVG+OQ/U4CnXHai9aDloeranh5r4q5LqCbJmYbQ2NSICxslcCEk2m1l1
 M68q7+9bHsguMBQIhiuHqPloasSXGTNALIKvVo9ZqQzCUtNCDHSyLnazhhSuRwVH4iwqemwV7
 TiDYPXG0+MSa2Bz7Z44brjmWQvJL1NHjcgx5wrEfEmW6IsRK7yC07RshVg8u2Mv9AuwVnua6O
 jc5AeQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1693193536-1693756051=:134
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah & Stolee,

On Sat, 29 Apr 2023, Elijah Newren wrote:

> On Mon, Apr 24, 2023 at 8:23=E2=80=AFAM Derrick Stolee <derrickstolee@gi=
thub.com> wrote:
> >
> > On 4/22/2023 9:18 PM, Elijah Newren wrote:
> > > On Thu, Apr 20, 2023 at 6:44=E2=80=AFAM Derrick Stolee <derrickstole=
e@github.com> wrote:
> > >>
> > >> On 4/20/2023 12:53 AM, Elijah Newren wrote:
> > >>> On Tue, Apr 18, 2023 at 6:10=E2=80=AFAM Derrick Stolee <derricksto=
lee@github.com> wrote:
> >
> > >>  3. (Ordering options) Modifications to how those commits are order=
ed,
> > >>     such as --topo-order, --date-order, and --reverse. These seem t=
o
> > >>     be overridden by git-replay (although, --reverse probably cause=
s
> > >>     some confusion right now).
> > >
> > > Yep, intentionally overridden.
> > >
> > > Could you elaborate on what you mean by --reverse causing confusion?
> >
> > It's very unlikely that a list of patches will successfully apply
> > when applied in the reverse order. If we allow the argument, then
> > someone will try it thinking they can flip their commits. Then they
> > might be surprised when there are a bunch of conflicts on every
> > commit.
> >
> > Basically, I'm not super thrilled about exposing options that are
> > unlikely to be valuable to users and instead are more likely to cause
> > confusion due to changes that won't successfully apply.
>
> Oh, I got thrown by the "right now" portion of your comment; I
> couldn't see how time or future changes would affect anything to make
> it less (or more) confusing for users.
>
> Quick clarification, though: while you correctly point out the type of
> confusion the user would experience without my overriding, my
> overriding of rev.reverse (after setup_revisions() returns, not before
> it is called) precludes that experience.  The override means none of
> the above happens, and they would instead just wonder why their option
> is being ignored.

FWIW here is my view on the matter: `git replay`, at least in its current
incarnation, is a really low-level tool. As such, I actually do not want
to worry much about protecting users from nonsensical invocations.

In that light, I would like to see that code rejecting all revision
options except `--diff-algorithm` be dropped. Should we ever decide to add
a non-low-level mode to `git replay`, we can easily add some user-friendly
sanity check of the options then, and only for that non-low-level code.
For now, I feel that it's just complicating things, and `git replay` is in
the experimental phase anyway.

And further, I would even like to see that `--reverse` override go, and
turn it into `revs.reverse =3D !revs.reverse` instead. (And yes, I can
easily think of instances where I would have wanted to reverse a series of
patches...).

Ciao,
Johannes

--8323328-1693193536-1693756051=:134--
