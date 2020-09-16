Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFEC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 10:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D521741
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 10:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A3WuR5k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIPKYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 06:24:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:50259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgIPKVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600251647;
        bh=Rwdq+n/x0uyXtHH+107cDygZobO0QKMtf2P1K3tckoA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A3WuR5k/LLerfnP6MtWcoap3ZKN2LEY5K6Pv7ZBmCXIQrGB72R3xRjAnEiprbdlON
         J2PtLOtsIIW/lt/+PEW8YPelO2+MTiWTDQ46DNCM5S23GTtrFviYfSG1lGcDviTcFP
         XcSKVKG5Rl06H5VghJYXUGo7B72+Cne7tSbHGx3U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1khbXe3NVM-00yhON; Wed, 16
 Sep 2020 12:20:46 +0200
Date:   Wed, 16 Sep 2020 12:20:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <20200916053141.GA29901@mail.clickyotomy.dev>
Message-ID: <nycvar.QRO.7.76.6.2009161214030.56@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <xmqqr1rcxdsu.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
 <20200910144456.GA25125@mail.clickyotomy.dev> <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet> <xmqqk0wwjf4p.fsf@gitster.c.googlers.com> <20200916053141.GA29901@mail.clickyotomy.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v57JV3TPGc7Glfpmn8pdiG32tFKM99ZrxkNu8uDNcC04Bj4Pe1y
 /ZcZzlLp7vv36FdkuQ3gs6WBnHGN0u/AWI5LnMTENIgLGv09UuL16EDn7YQOS1k0xXKP8NE
 quyXRrarPtWX60dXk2ISnSYBq08k2YEja2fqxuYVevOgw4O7IGxO50hLN5xp5VKZtDKXnnJ
 qVR5mC4IGm3q5uGvgNlSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XFvdF784St4=:pXUb7zjQAL7Vy4ILzktfCX
 jj94OJzxtXhLy+dvQHYjmr22vMt4c+Nq0V6zDi9Kgyp8oVsOkkJ+4/WWopD35hCNW3vHZvqXR
 7fsZp8RXhJK9Mf1GYGXU2wX4cvYEvsB2WZIBl3jwpfNsznRL+E4YGW/gazlSHByP8PZaDg5wr
 mkdnIPz7f4TqyRm09ZOZQ1C7bdhnK8D5d0FBqpZ5qLaKRUtDCiSCAL2kzpsNL3PR6bBEVP96Z
 YZXEHlQmoIBbJmXh2c3x897MohfCOtUKhTOBKH1b87jZhJWDgCcWa/9j6ZaHB7jVUX+ujO+Bp
 ww8GsJUGBaMeC2Z8dNvsxoHhzt0eD8A/+usA9SQ29GPDNLtoTicEj2vV6StdN2SXrZbGVtvtK
 xqS4HX3oFND6U5oamN8mLp3ahEUCawmvo+ii5bsCUZ8zNYpCzy2m8q2xFjkR8Df9Si4dyth3/
 p9y+DGH87ZE759c7hs/EwULLGZFYjdemJTCP1uYMKnO5wJ9SV6fNyh5XO7hJA5U6AJGO+YyV2
 GCgCwUxWvgJFnKQBynoD/ym4yJiy7vPtjvaWywwB9a1s8n4TuMeUsynNi54aKpqG1IynqscGi
 H0jgI8IfG/IIbh70dbMNs/LAZ1Iqb+Uw3ZpdE3lOCu3BzbUt5L10ia6RJSgoTtvxms0XrDmyM
 C3Ntg6Zosb7Up7+uiX6erFZ6k5W3YbIM8z31lticVy4ls0xi+wWJzm0g/Z1qatUvs2wyzvdcS
 XLyz6BfZ5umOv+Hnnl7CVGgT40IWVbsIPrUheOcKFWE14XvCWIrb7wnr0HFjqH6Ojx9p16eIn
 vOGHkg8kyorbVoeXQ95+aR83wtc/qbuzMNdW1YsPb/9EVffvyMcKMNQaXmjW9jUCaWvF8QqMG
 3Ab5fiRiLDxq4TMw5HFQKKMgzInTWixCmW7Zneni+ZMo39CE+zcKDB9S84g7c52KLJWDj4r3z
 inuqyAvFP1XdHppDrur6UWnBYjOXq5FZEZljcCPhemMPOsvg49Ky7kMqj8jqwscGPCX8QoOQ0
 7OdFsmtnj6onoXH7AJbFX9oRLXlZIaZyyrDxL+NvIfZTzVNHQaZkXc9W6+/DoiFzayMlBdQuR
 1oOmLPnyX+lHU2EcNpabjcYvYiSoCE1SVgbbt0j8eFBWnjJJ2kGoGWtp7beQ/bLn9ayzmPTTf
 Lyduida1oOvvE+FfSEKws+sSO0c0Zl+Mwn5r2+3U3iwIu53+tY2dil0F+2ACf0PHWGE5lYF8t
 DR94nODCbaBIU691UmrdZhWqQCsxmAXGszsIfJA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 16 Sep 2020, Srinidhi Kaushik wrote:

> On 09/14/2020 13:08, Junio C Hamano wrote:
> >>> [...]
> >>>
> >>> Good catch. Would adding in_merge_bases() along with checking if OID=
s
> >>> are equal for each reflog entry in oid_in_reflog_ent() address the
> >>> problem? That way, we would check if remote ref is reachable from
> >>> one of the entries?
> >
> > That sounds very expensive.
>
> Yes, you're right about that.
>
> > If we switched to check the reflog of HEAD (and not any particular
> > local branch's reflog), then "has this ever been checked out", tests
> > would suffice, no?  We detach at the tip of the remote-tracking
> > branch and then reapply our work one by one in such a case, so we
> > should have the record of having their tip in the working tree at
> > some point (i.e. at the beginning of the "rebase" phase of the "pull
> > --rebase" operation).
>
> Interesting, I think that might work! Since HEAD moves around and
> records all the movements, if the remote was ever checked out there
> should be an entry in the reflog.

No, I don't think that would suffice. For several reasons:

- the user could have checked out the remote-tracking branch directly
  (`git switch --detach origin/my-branch`), as opposed to actually
  integrating the revision into the branch at some stage. I know that I do
  that sometimes.

- even if the remote-tracking branch has not been checked out directly, it
  might have been `git pull --rebase`d into a _different_ branch, in which
  case the reflog of `HEAD` would say "yep, I saw this commit!" but that
  would not mean that it was integrated into the branch we want to
  (force-)push.

- the reflog of the `HEAD` is worktree-specific, and if the user pushes
  from a different worktree (e.g. to push multiple branches at the same
  time, or because the push is scripted and run from a different working
  directory), it would be missed.

- and if we take a little step back, we do see that the reflog of `HEAD`
  _does_ answer a different question from what we actually asked.

Sure, it would be faster, but is that worth the consequences?

I really think we need to stick to looking at the reflog of the asked-for
branch. And to make that faster, we should have a first loop using
`oideq()` and failing that check, run a second loop using
`is_in_merge_bases()`.

Ciao,
Dscho
