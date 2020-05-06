Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E65C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887422070B
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="R0BL6SPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgEFVgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:36:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:58921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgEFVgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 17:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588800950;
        bh=UG5oh1cwACkFEkTzgGBc641GwFDPtWY+CvyKAM1i4a4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R0BL6SPehBE1b9dgwGXtflIHPMgu63aU914TUl/6W68htGeXxJYb3sytzS3QrhDQg
         nw4XD3DvIkTq5XTStpozzD/DvuGNXk9Q3wva17oRDHCbfoVzvbnt4TWwfTGSvmsXdf
         m1kTIQ2uDfCrGBFTGZ5ifo1mnC13Xzt8SHM59zc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([89.1.213.224]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1ix6ou402b-00Zbqa; Wed, 06
 May 2020 23:35:50 +0200
Date:   Wed, 6 May 2020 23:35:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
In-Reply-To: <xmqqv9la9lbn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005062334170.56@tvgsbejvaqbjf.bet>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com> <20200504213326.GA31037@coredump.intra.peff.net> <20200504220916.GF45250@syl.local> <xmqqv9la9lbn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QaE5IFF1WJ0mKqLHPQFsDKsNYQHsyfoKZjYkurtQRhDTdb7n591
 Iyt5eAEwlof1ZqgahbxoBtj30SE7KsM6Zm/q4MEFwq/Qhx/C0MPr+YNb53yTFUKhn81z3co
 HyvjTS/7PWpsZoohTJhq9QAwNL27TJoat3ZXJP7wdka7fCgLzvScjPm/kW5U0WvG1TaKFJq
 bTYHI0TyuRBLOc6dVoikQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6HVkIrYh5Eg=:jWy3563MmGA5BdU/1Mb/OP
 rzTexQmkDxTbAK1+9YH95p/5naF4oQN5AXPNxnoMecQMDie08Ylja3bQR3V9G7hIXya/rdgfg
 dIsZ0ILtR/7jGmeagDnrjeczLCGTT0LmlLvDm/BC6cogec3mhLMIzRq8f0zxRKJGcteeh1TR5
 Kn05JbPWylpNgULTJ//zaz/pGf/GQxRj3BCPM/okzquQ+edU0P2t8XFo7CCcPSjHCJLmsj1X+
 EU4etZM90lGfm/ZAcUBSAXhivWRJibj5qTrwrDm/omuIDHurS2CN7/LKy36C4v4N7MC7UOJVj
 kVAN31uyVbSfdzozHUjarqyYlL5dTTb6mljj+53JLTjy+pYm4wIZ3wPqBgdxwtByvMZLa7AGx
 bH/XD8IOnRFy74uzOr8zKZ37GU6YISI+FiaZb0tDM04xZzq1Ug2/2goTnolo7TTLkBuxdM/ys
 4Eb4UGfyE/PXPG56MhEqD9eaDT47sIq8cQBv82DMERgwKiSHA8ELf+DOgJ9+fV9ZEPjVULZy9
 UyQHy5ffXrtvPQlAiWw1mdqbFGw8DUmuf7GNTiYQB/pTYM5WKIHWWIYu/l3FzW9tQTa1Lzpij
 ZypnzUJ0EV0ivWFGuIdNcTHumgdpzg7ycTR8NVP4vk7PzQAJzEFbCEl+QIqYqa2ztzFf6+WMb
 /NdGmagsJa9eXwigYrg+IFRWDY/Yc46dX4tRi2TiqXrOm2j7rSVf1bnTlO9lPhFLBLZ8lteaA
 qRY/nltRC/MVQKzjIJ+1m4mJgCe5BtA8nAO0Y/x9JyxthL8nmpfsZRF9VNx6smsiWXDLQ/xTU
 SkGUl0bqp18bqcJv+Z1jKFYG1+D/qGLp7mJVo4aqQuOtAuO08hnkMsB5YtdKJMnmY0OmPfgu7
 Jbu8EO3wyHwAfXfZ9MRIgd1bZVIt5i+yCEn+kKN76EqTXK+Y3l8Quskiqt9IF8ZWq5GtVOR55
 1mveZk/eiJhuQRimmtgxsVuQDaXR9bip2ewicHJAV5+gCVk/x3eqFNFozwjUDqhKYQb+ZNDoO
 NOYc995+SwyqYl289/9z8lDESsp6qSiLw2U6w8JC7Hc48pQotIA6p8uGWAmlFs/okReEKwtza
 poXsPdZU7t0u8Q42IyWgDhV44aVZKAcs9pL8arMpUtN3sf7DVMkdi0tGnLfPZOg3CLjjULz2k
 GwYiiPvK9I0BgX4vB9AE0P2F1lnLj3TAh4gxsT7cIN2GYj1uCQlxbWAKDQEiTsHhqWX4bJUOq
 fxv/TsvVmlbXAHnxb
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 5 May 2020, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > +				/*
> >> > +				 * i2 refers to a fixup commit in the middle of
> >> > +				 * a fixup chain
> >> > +				 */
> >> > +				next[i] =3D next[i2];
> >> > +				next[i2] =3D i;
> >> > +				continue;
> >> > +			}
> >>
> >> I do have one question, though. What happens if we add a second
> >> fixup-of-a-fixup?
> >
> > Thanks for asking this question, I was a little curious about it, too.
>
> Interesting that three people looked at the same patch and asked the
> same question in different ways ;-)

Indeed!

I am very grateful, as I had missed that, and it helped me figure out a
better way to do it, and v2 looks a lot nicer, too.

Ciao,
Dscho
