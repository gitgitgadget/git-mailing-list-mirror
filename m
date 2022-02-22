Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D298BC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiBVQ0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiBVQ0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:26:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C83C166A7D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645547125;
        bh=GCbu7zTu/WqKsyRGh9GlyxfpfWlXS9KS7PUV8/c9p7Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JbsSHt8DO5Cc9NCtPM+eCTLUrxnZFzqenvAvbZzU/EmtWXawIbgUwihsNrGwhfAF+
         ToGH1257ZtNzv3GZVWL+H0HfF90YyqcceQq6E5GuxYR0RwwBGw9pHlcXKXYJEShXZu
         WWCNYrgTvdKifRVNBsUgKsR22/UEiy0l1QLs/w8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1nH3nE45o4-005VR6; Tue, 22
 Feb 2022 17:25:25 +0100
Date:   Tue, 22 Feb 2022 17:25:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v5 04/12] merge-tree: implement real merges
In-Reply-To: <CABPp-BESAh6wLComJoYsf7Q7NF2EMPptKRhfAoy=1-ZRZovnaQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221720360.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com> <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com> <7994775a9341b256d1ea7dfc417bb577d9a3195f.1645340082.git.gitgitgadget@gmail.com> <9b65e743-729f-6449-b7ef-c8c9fb130221@web.de>
 <CABPp-BESAh6wLComJoYsf7Q7NF2EMPptKRhfAoy=1-ZRZovnaQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-735522399-1645546962=:11118"
Content-ID: <nycvar.QRO.7.76.6.2202221725000.11118@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:/sBvhdoL2XpMQLJxCFLvFgFJMszTEYAIRLQY/xhmngWSlwVWf2w
 jdfRocSsybC5RoEcE3TqOXmUT1hasw887yH+Ye0DUJb+F1jA8KvZpUR5nMUFS2vkdldG6jh
 2gDYBch1Uf74Enw7P0mSu2v2lWomZWlZIRcD1wTIZCmffBFv9cUhxhfJ1fhnmfah/AewN5w
 OCAS+BgidwOpBzYuayErg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ewu1OZF+MQ=:gu0SG1ecHvIzc6H4Qr6jE7
 Owq0P4Rf80fNYihAAfN1tifrmPkYexzNVIUWfyRpNA5/roP/fnHfuzog3XPFr8S8eyVed66kT
 ijY4z6zwuGC22DEpTCncHYz8CjFki4+K4BMRVKWFlLKz5l7KZUojK+IoAH5ZSdV98wHzhUWHp
 Jujl8IzMPfsfDM4njx+tdetQvxRd10gvpm6m+zbgDk4Xa/H/eyZ2idOjui0mwziC/QOlO7Ida
 ReXboe8uIOVZYH4bsny7rAmIauykVu9eAt1FvcDntrr9422dBSQ8OQcxI0kAyGVwu9j/dvgOc
 ent2rif5T4VZu60ZlTcBlEk+eVd1w9SB8o6AkQTt7f+FJGXDIbfBoICRvirSpAJrtyHcBS+KB
 wsMcoFYJXWnzsfiiX0b0GMRIXwahY68y+dbLrD388t5ka/T33pfU+Qs/pVa4kssFClHejrHNF
 YyZnaT5ZY5kn66zfEn+2U8C56RbJOmgjv5hyoBczc3y/vhY91ObVR4XgkoKupPOV1VhrVO0uj
 cSljUUmBYp4IB0dgrdXDHjv64EXxcUIrWPfLlviJH/ROqjUMgBCo8N0bMyzq8dcAinyiucwkd
 W5AEZhzUzQJkPtPNqvrMLFNqqkL87UhG7vENAUrxaeJYSt2cUqENRla0OxIz9Rd2vCcG9kRGv
 ng7UkuBhy9/AgJ5BlIUa7U9t1aOaloXrzb8yebd9VFNyg573GhwkQQjjG0dnrcRr0kPjVG4Jo
 t5Q/hF6NE0XoS6XPwBx+s1gJEXSPVQ0b6U83pru0kP0bt2vj6kFEkialwutz7jI/p7EmZja3+
 1FzsiiGjLTnKDOICtq29QjLWg4iIFl4m0VfPVF3NaXRxDf8zoWqglY5m6t2llWPDnBYY5tbrb
 qrnp4g+FyNM//err0Q7tNVQ4RlkASPfcvH9F7UShqkvoECCcVHiYrPeONsWMeT6rNvkH5FmJX
 +8lfLOH7gcF9PTcpnVc1YfcthDZg8Z6gv6QkgCMc2U4GPAO5KRxkTW95B3TPPsNxRCUOfr5JY
 n9cjgeBRlCowFer8i9cK2XoCY18kN8X6JA4qdG/mS2hYxy+QAWt0ApCix4Li+i1fjsOnsqF3M
 HvbyB0U7FEQlIo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-735522399-1645546962=:11118
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2202221725001.11118@tvgsbejvaqbjf.bet>

Hi Elijah,

On Mon, 21 Feb 2022, Elijah Newren wrote:

> On Sun, Feb 20, 2022 at 1:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> >
> > Am 20.02.22 um 07:54 schrieb Elijah Newren via GitGitGadget:
> [...]
> > > +     /*
> > > +      * Get the merge bases, in reverse order; see comment above
> > > +      * merge_incore_recursive in merge-ort.h
> > > +      */
> > > +     common =3D get_merge_bases(parent1, parent2);
> > > +     if (!common)
> > > +             die(_("refusing to merge unrelated histories"));
> > > +     for (j =3D common; j; j =3D j->next)
> > > +             commit_list_insert(j->item, &merge_bases);
> >
> > This loop creates a reversed copy of "common".  You could use
> > reverse_commit_list() instead to do it in-place and avoid the
> > allocations.  Only the copy, "merge_bases", is used below.
>
> Oh, good catch.  I probably should have been aware of this since
> someone requested I move the reverse_commit_list() function from
> merge-recursive.c to commit.c as part of my merge-ort work, but looks
> like I forgot about it and copied this command snippet from
> builtin/merge.c instead.  I have no excuse.

Ooops! I missed that the `reverse_commit_list()` function was moved to
`commit.c` by _you_, and had not been there all along (my fault, of
course, see 8918b0c9c26 (merge-recur: try to merge older merge bases
first, 2006-08-09)).

> However, I wonder if that means we could also apply this
> simplification to the code snippets in builtin/merge.c and sequencer.c
> that you can find with
>     git grep commit_list_insert.*reversed
> ?  Maybe #leftoverbits for that part?

Yes, that's a good idea. I summarized this left-over-bit in
https://github.com/gitgitgadget/git/issues/1156

Ciao,
Dscho

--8323328-735522399-1645546962=:11118--
