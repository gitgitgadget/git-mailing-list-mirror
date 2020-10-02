Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F143C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA698207EA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BuyQkebE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgJBM1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:27:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:54965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBM1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 08:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601641645;
        bh=Feg5R/htpI0U+u1gYrbqeTZcI9aBJpdSQvfnrRjog4U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BuyQkebESP81KO2nRDNsD+kUTNMlxphbSdJ5HzCPm+vldrbiEGNLvvrr91HCm/tiS
         xZhyuI+1TyMjjZxPg9PJG+c7QMYafY6pKh7IEIRWhque2P0cb+wlRcwbOLHu1PS5h7
         CPSrZoq1GqVFyT52nJfGek7nYWXzuCJsJs3WhND0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.114]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1kS7p93SuB-014yS5; Fri, 02
 Oct 2020 14:27:24 +0200
Date:   Fri, 2 Oct 2020 14:27:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 1/3] credential.c: fix credential reading with regards
 to CR/LF
In-Reply-To: <20201002120126.GA2255314@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010021427080.50@tvgsbejvaqbjf.bet>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com> <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com> <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com> <20200929004220.GC898702@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet> <20201002120126.GA2255314@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ogMfkOZDUnlTeWi3vcsN7756Mb2vl13oTMELOfxmA1GsMwCJ49f
 8QAkU8O8cdWy38LNF/h64zC8bqoisl72Ybpsvgfb/meBsiE8PIlK6TNf5MFUQu6jFG1CVoC
 /QQyI8dWMSXYocaRAG/vyiEkeUObyna71D/q9ugmAoOI2GhZVr6JMtSPEyCQ6USMMQYxkKc
 dZzMsi5AOVusfl4ut18PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LeQBSywqtYQ=:R1kXcUghFycL+jDXR/7nkQ
 aIztHCZC2cI1AbbKF2KmyvYduIBEm+y64bYFv5MjXYJAXVZQV/vgc5bFPMum87qrcjuxY+jYr
 Rpda8kaTzy6Jhf6OBCgmjb2K5BBmozH13P29NFouS+3jVwCUvQwjrTpiIgjnyyBb0226lhIxr
 feF7/2Bh53lXvNvPrLOPeLeNF/A1cyYV6aVvrZo0vtlV/wANmDNGhyA5gpGSUf3xDa8rIoDZ3
 Y50pqh8jgdEikEr8cCsFstabf1uMb2RjdCqh7LmsgGeWAFzSa+V4z9zzPsiLqSPcg7cgUmfpQ
 OnYSkB3gGeeR4b+ZL6q0UBX2GTvupEFRIafFrVFeoRxzgdqUCCrCFsWkb08ERIuvEw5oO2vps
 /SdjSxjwVwtTaqdSyEFfKzwA3tU1K+lMUIvHGokF56Ef1Ml79m8HjB4THkHGfD9b/QD5eVGsj
 e6UTUS5zreodlz2ZVPjGgdUr7vtAYnK860tD7yQgp1DDgiMxQvKNFP4O4lE7JY/p1Idf/00ek
 j2poqwFRyzR2a9jjuSCr71IMkVHbBJxPZ5Hyh27f4mQlw67/QYQEi4VPIaKf/VlUU6om7F9MN
 CH9o3Im8/3PYZrlJvQ1I/WT+wxPUPkKkAvWdR/qHpqTLtlR9ZJ6qFg9RoT+ITj3LYbpvC13vk
 TgXTy8zCYYI0a/UN8Jao/BkzgCBPSAVcrgxwAcHzFxm8ATzEARzIyE+j9u6XvoA7bo9aSPzey
 LgyE11cGP6T7vP/D2BG4q4tJZCy7cmi1uDg8LQd6mrx3F7ncrYKNvQVikK8/MTefMfreGMhL1
 sDkxwIqN7H+9CkY6Bj1JPSCpXAL4Aj9SRmT8HpjZ1n5m4tR2EAL/aw/+rAhiEB44K+QeeohVE
 a6GL/6GQGf+dx49uF7DftnO0MmQ7yZgmp1wS9mv56SC1xh67+iWV/fnazGczvCt0IGj43PvC7
 GMpVEl3bOmr/ybrEreb8BdKbrhaZ5AnR5ZG0uRqzEQeQPdq2vMLt8vNDv9ZskcCICQCheTqlv
 Fd4h+vrZRDWu8uvrk0DyK07M3Hirf4Zpjd7KDRt70m/i99VLAR05SVZdkiY+C0CofGBZYyRc4
 oijxiV7ZdsTEhsXXt8Y5K7QCCcYgOGTj71pZ84V1j26c/3GiFr64YCqmLrpL8mdqtQtHd79k/
 lff24s/LQVxTv6MZIEEZShqeOai6eqDR/65389ppWD+hfqk6cMwIHFpWTOZC3L0fi+tOfTqGQ
 659iShPvpRchswuRvcaY+x6SJDfbnuyMNfupQVw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 2 Oct 2020, Jeff King wrote:

> On Fri, Oct 02, 2020 at 01:37:23PM +0200, Johannes Schindelin wrote:
>
> > But I would highly doubt that the empty lines were the biggest problem=
:
> > Sure, we would fail to recognize an empty line with CR/LF line endings
> > when reading with `strbuf_getline_lf()`, but we would totally
> > misunderstand the entire rest of the lines, too. For example, we would
> > mistake `quit\r` for an unknown command, and hence simply ignore it.
> >
> > I do agree, however, that your confusion validly points out a flaw in =
the
> > commit message: the "empty line" comment is a red herring.
> >
> > Therefore, I spent some time pouring over the commit message. This is =
my
> > current version:
> > [...]
> > What do you think?
>
> I think we are on the same page, and this revision does a good job of
> fixing my complaint about the commit message. Thanks. One minor typo:
>
> >     While we do this for the credential helper protocol, we do _not_ d=
o
> >     adjust `git credential-cache--daemon` (which won't work on Windows=
,
>
> s/do$//

Thanks, fixed!

Ciao,
Dscho
