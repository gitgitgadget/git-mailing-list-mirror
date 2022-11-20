Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9402FC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKTXgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 18:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKTXgd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 18:36:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1032B625
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668987386; bh=q0W9UDGO3VONrN9CqjD1xvCft5fVR/lSLgN4NP3EsDA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YKlCvm4DMIPPHBIYUSz1SZx4yvXy24wukWMcyc33HiPd7vr5jnBKfEOeQOTBDC0ul
         tUY42vTR3PW+FfPtTYfABcerpiUM6jBo3sJf1LHySSaxeGKvbdRje3h0BH4k/6aX9g
         s3EafsUCNHd+iOILwBcriDm3uGB+2uIt1lsD5ms74eTjWmMqRztO/x8squqn0gnfwb
         BKCRmq4yii6TZa09KSHfSrCUTgr2Wr56/Yf9fSUe7Et+Len6fX3+OqhHJCF7lOK5VN
         QhLJLSz+Oj8UDnAQ03RETLu5ZovVZCITgrMuw6RAiIYhUQgpSpjrzT9FDN5Z4vXrL+
         kxAlUssNapDbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzjt-1oQBTX2yu9-00XNA7; Mon, 21
 Nov 2022 00:36:26 +0100
Date:   Mon, 21 Nov 2022 00:36:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
In-Reply-To: <Y3fLdJ7CIIU8fj0g@nand.local>
Message-ID: <q39q9rr7-or29-5510-5177-2s92n8qs2540@tzk.qr>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com> <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com> <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com> <Y3LD1CtKBoDhPdSZ@nand.local> <qp0556o2-6q18-8556-0n8s-p28831qr6qs6@tzk.qr>
 <Y3fLdJ7CIIU8fj0g@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+/OpHZmyLnU5BHfcki1j4BcsriAy5tfLka9LTQX3ltQt0wg5Hq9
 PQJrRpz2N2zHWkJg4DywQdTTMLFUE6jmfrw15aq6qK35E/DHMYg7AhMZXjDkZrmKwVBjCA+
 V75pZJAtnRZHbfeSuFE4vi6ir0lMVLvW8zFgH5Sb42+ROhsRDBKTlHMsHsyLT+klQrGJjFa
 a69b5ZIAXqCxpce/D9cVg==
UI-OutboundReport: notjunk:1;M01:P0:+BIub/1Noxw=;tpS7s4mLBodOnHgCWzr6JPYrlcz
 IHVKfu86cSxx60Y4NubniJbpzGH+xChRUzPTgz3hTdi9SWas+47Imy2OJeuREG5utEczp97o5
 OTujF8TaaJkXA42kvxz28KMJTIQq9n8jR7cgbl2cYtLdNMygy/uC1oygekoq7HY39LpZ8+oEl
 KMANdch1IUenySpK00rCzJX1Ozt7ZLpzo7GB6jejf1Ptwxp3gDEnaYx3BERGnL4CViar5QuAM
 rlcdGmi3x1wXeFA+mVCTYmIoW1Q5ejfy0cwmROYrDybpGdeXkYUldNa9/1tEWaCQ0I6IHLrVF
 kyCvURjiGUb/VY7pNYdUSBI3yxAmn22OlUcW56oZEAR2WT3c1h4/TG4OPLIU+PkHIVwe9VPSD
 2RBZPfoCmKBKhXfve1W4+m/TdbUPR0YIy5u10Bo6RI5op3QBq71Uq5elNDseVbMYl1Gl1yzT8
 YK0YGBIGcaFsVjc6Zrv3xcJ95k1pHIyvwW8ZgQgsFhGcL2+zOHMn/CeK2Nq0xCoi/+qwuEKdc
 rjHSCxfNyEhv+Ph9fwQW/Wrz/X3AzZJWmzfjZoM+J4ayfIbi5TLVocCCYWwLtVu1VzHxK7F2h
 U0YNaqidLg5+s9L002dLi72VxoQCq6qqVcA8+hxqIEwJYX9eF6lrnxEoykztw5L8hg8TqnzYS
 SzAsD8XTSXQTvqyOTcriJ00wrhy+Tpc5hjd9PJfJQdJxt5FxVV2ECX0PNmRkAKXvZnrKR4asv
 2PCePOrkfriE7QzYG+k5StXhad13pqVDcfw3DVwXy9mjO4RpIpZL+ZMzDaZjL/6vZNrScuECC
 kcA8KZOpq03PndfWZunNj/STc/Wdgl6cilRamYnBnNjywZB4FqOopBd2TAvS24JRnurPIy7W/
 wMC7aR8jMJczt5ebi9jTCe2SRLVds3B7MgHev+5xRTg4A3lLNFDWiqJao3KSGqjsxPIvdLC3s
 y818mw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Fri, 18 Nov 2022, Taylor Blau wrote:

> On Fri, Nov 18, 2022 at 02:32:28PM +0100, Johannes Schindelin wrote:
> > > But I'm not sure the rewritten version does what you claim, at least=
 in
> > > my own personal opinion.
> > >
> > > It is not helpful to say the original approach "saw a lot of backlas=
h".
> >
> > It is the nicest thing I can say about it.
>
> I don't think you have to or should refer to the earlier round of review
> at all.

You misunderstand.

I am referring to the fact that Git for Windows has run with a very
different solution for this problem, for years, yet it was rejected upon
upstreaming, and had to be replaced by a completely different workaround.

It's not just a simple "earlier round of review" at all that is the issue
I am describing.

It is a very real concern of future readers who know what patches are
currently in Git for Windows and who all of a sudden do not find the `git
test-tool cmp` code anymore in Git for Windows and then see that `git diff
=2D-no-index` is used and naturally want to know what the heck happened.

This is context relevant to understand why the particular approach
implemented in the patch was chosen and another one was discarded (when
that other approach has served Git for Windows very well for several
years), for which the commit message is precisely the appropriate place. I
am quite lost trying to understand why I am asked to remove said context,
leaving future readers puzzled e.g. in the case that it should turn out to
have been a terrible idea to use the quite complex diff machinery for as
simple a task as `test_cmp`. It sounds to me like I am asked to make my
contribution worse ("worsimprove" is the term I recently learned to
describe this) instead of helping me to improve it.

The advice you provided directly contradicts what is written in
https://git-scm.com/docs/SubmittingPatches#describe-changes, after all
(ignore the funny grammar for now unless you want to add a tangent to this
already long thread):

	The body should provide a meaningful commit message, which:

	    [...]

	    3. alternate solutions considered but discarded, if any.

Thanks,
Johannes
