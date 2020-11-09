Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E0C388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179C1206ED
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 13:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zy6qEYE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgKIN53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:57:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:50435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbgKIN53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 08:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604930237;
        bh=kwfAFVk2uLOj5pqAFxYLk1f6P+uzYqmh+IZQUqJvnmM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zy6qEYE34IEd9IC+abSql5w9w65oFC9/2iojV0rQcc/imsNp3eGNWnYHcGTxfH3M2
         wA/GsW+YAy3XiRKEGZR04Ei3aDb6AF7Ez9FrVz0Whlr2slyLNmaLubwZAdHPpelVZ+
         2RUln/qK92M7BQlePqfyxmc9ItqIaCCsRkwmLqn0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1kAzrO1yGd-013wBN; Mon, 09
 Nov 2020 14:57:17 +0100
Date:   Mon, 9 Nov 2020 14:57:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] abspath: add a function to resolve paths with
 missing components
In-Reply-To: <20201010011048.GQ1392312@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2011091456010.18437@tvgsbejvaqbjf.bet>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net> <20201009191511.267461-2-sandals@crustytoothpaste.net> <xmqqk0vzrtqr.fsf@gitster.c.googlers.com> <20201010011048.GQ1392312@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1854099020-1604930245=:18437"
X-Provags-ID: V03:K1:QG32KofKHnZsuwPCfQLW+Y4fnIvHGOppB+8vXAA07N6ckRI5krD
 RUJzWt8AwPJQLsxIvgveM27wMenjQtOvjU+ipCa8swAx56pjfBPE7Yt7vEa/rtKYVbjjoYh
 1tMnA/lxmOa4Cs9HRB+Wu+Hz2oE/kuUKAx/hT4JzdF5J1w0Eg4jszk7BRiU3bOZgI1Ss83z
 D+GlwKSUgzsw+xAsdA0Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g24ccXAN3tw=:UZgeP/6sghUlVij+EuUhXa
 l/3s0Q9aEsLfvEUgMVE2yrGfFji7w7/FzFLcsTBFJURZ4MaWtXhzESUHteClw1XwcQF/+wAtV
 liahrM48uhrv3eHhN0c31hhMzt29NAgRvA2qTDe2nQZ9M4Wu6ibRuMuhoo8sE8g3UDPtc9lcx
 jlMwBIoG72qIeESXdAQBgQuEOe3GlQ3Dzeq3dE2QKM4lQZUU7p9dUL6lQ6/9bhZK64sWrpQ08
 MPL4q7+LkhSE9oAOp1JJbtByi161MsSVLhHQJ6tqvqE1me6KW0j6f/BoH1KCU0T/oGtPtOBSY
 7ypXUOCX07WM3scZiII32LoGlyUMMn4xfZSA/WCuFTAEtVq7QxRKerWAMN1UAmqv8rgFVuynC
 NTLWs/azfAMx/N4luUQbyfD07NyX6DTQ0Btk4/o1dnrbv+NFAFl1X5sUCmibdoFuMSJQdr5Ly
 1nZHII77JO7tBTCC9oE//Ld9Yg5xaAdgi0yBpoVDI+5zg3ks98ziBnANqk7ykVrJxFEqylilS
 52hIMtZCZ+V3uyig7TcFN71qd8B/YoX1M0+zqqHgy9P8jjEQ8eBuJzAUpMxQATP8Xa1OKt/fT
 eUhCAXxGo7550Vk/SqVtLoGmys0mBbHm2DeSgReMS+edp8UQv2vrkmFzCN5UbkWcpCjVH1ZIr
 lRjSPmZbxZ6QUKJX41Tihdb+fJyTRF+jQOPb42axcT6CTpftSJAJRuSjciwpfY3DPFImKjYSl
 Yjg9vgNa9L4pqt70shxWcn+l+K8Yyhs7o+p6E2w13EKRt/wXhI/NrGujefoBWYzNfzsDuI2aR
 F/J0cUoDgRdhIvkfCL/5FpfCvhWRyMoM1gYDJk4tUoMq/+eK4DzWWDTET1NpJ8NQced8gBfVx
 hvEHKOyaw9tO4zEI721k365707k6cfVvRcc7k66kM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1854099020-1604930245=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi brian,

On Sat, 10 Oct 2020, brian m. carlson wrote:

> On 2020-10-09 at 21:10:04, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > We'd like to canonicalize paths such that we can preserve any number=
 of
> > > trailing components that may be missing.
> >
> > Sorry, but at least to me, the above gives no clue what kind of
> > operation is desired to be done on paths.  How would one preserve
> > what does not exist (i.e. are missing)?
> >
> > Do you mean some leading components in a path point at existing
> > directories and after some point a component names a directory
> > that does not exist, so everything after that does not yet exist
> > until you "mkdir -p" them?
> >
> > I guess my confusion comes primarily from the fuzziness of the verb
> > "canonicalize" in the sentence.  We want to handle a/b/../c/d and
> > there are various combinations of missng and existing directories,
> > e.g. a/b may not exist or a/b may but a/c may not, etc.  Is that
> > what is going on?  Makes me wonder if it makes sense to canonicalize
> > a/b/../c/d into a/c/d when a/b does not exist in the first place,
> > though.
>
> The behavior that I'm proposing is the realpath -m behavior.  If the
> path we're canonicalizing doesn't exist, we find the closest parent that
> does exist, canonicalize it (=C3=A0 la realpath(3)), and then append the
> components that don't exist to the canonicalized portion.

FWIW I was immediately able to think of a handful scenarios where this
functionality would come in handy, but I am probably not a typical example
for the median reader. So maybe a concrete example or two why this could
be handy could be shown in the cover letter?

Thanks,
Dscho

>
> > > Let's add a function to do
> > > that that calls strbuf_realpath to find the canonical path for the
> > > portion we do have and then append the missing part.  We adjust
> > > strip_last_component to return us the component it has stripped and =
use
> > > that to help us accumulate the missing part.
> >
> > OK, so if we have a/b/c/d and know a/b/c/d does not exist on the
> > filesystem, we start by splitting it to a/b/c and d, see if a/b/c
> > exists, and if not, do the same recursively to a/b/c to split it
> > into a/b and c, and prefix the latter to 'd' that we split earlier
> > (i.e. now we have a/b and c/d), until we have an existing directory
> > on the first half?
>
> Correct.
>
> > > +/*
> > > + * Like strbuf_realpath, but trailing components which do not exist=
 are copied
> > > + * through.
> > > + */
> > > +char *strbuf_realpath_missing(struct strbuf *resolved, const char *=
path)
> > > +{
> > > +	struct strbuf remaining =3D STRBUF_INIT;
> > > +	struct strbuf trailing =3D STRBUF_INIT;
> > > +	struct strbuf component =3D STRBUF_INIT;
> > > +
> > > +	strbuf_addstr(&remaining, path);
> > > +
> > > +	while (remaining.len) {
> > > +		if (strbuf_realpath(resolved, remaining.buf, 0)) {
> > > +			strbuf_addbuf(resolved, &trailing);
> > > +
> > > +			strbuf_release(&component);
> > > +			strbuf_release(&remaining);
> > > +			strbuf_release(&trailing);
> > > +
> > > +			return resolved->buf;
> > > +		}
> > > +		strip_last_component(&remaining, &component);
> > > +		strbuf_insertstr(&trailing, 0, "/");
> > > +		strbuf_insertstr(&trailing, 1, component.buf);
> >
> > I may be utterly confused, but is this where
> >
> >     - we started with a/b/c/d, pushed 'd' into trailing and decided
> >       to redo with a/b/c
> >
> >     - now we split the a/b/c into a/b and c, and adjusting what is
> >       in trailing from 'd' to 'c/d'
> >
> > happens place?  It's a bit sad that we need to repeatedly use
> > insertstr to prepend in front, instead of appending.
>
> Yes, that's true.  It really isn't avoidable, though, with the functions
> the way that they are.  We can't use the original path and keep track of
> the offset because it may contain multiple path separators and we don't
> want to include those in the path.
> --
> brian m. carlson: Houston, Texas, US
>

--8323328-1854099020-1604930245=:18437--
