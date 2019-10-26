Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8951F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 20:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJZU52 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 16:57:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:44915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfJZU52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 16:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572123432;
        bh=ztYNTXodbPlxMQhdoCP0NLj0i5l7GA1/vLpLW8Rap18=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LuhZUCsRQde49F8usCDMEG9tSnWiHAdpPPYdHetAllQyD9ahALv5dAF6eSxyBDj7Q
         krY8uduXKWYkkwgEBnCecwaYmTUXw4Sq5taS9Q7oeQteP1XlCCDaNf/IXmTpzeWzx3
         KsRbTrVwndxW+Uz+pp99RyoRJDf6vr+Rm66ZiZTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1iDhTo1h6X-00Fkja; Sat, 26
 Oct 2019 22:57:11 +0200
Date:   Sat, 26 Oct 2019 22:56:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <20191025221118.GA29213@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com> <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com> <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet> <20191025221118.GA29213@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QFW/kfQYC0/Jm3dY4szwMzozqo/W7RceLJt/hanG9wQtOnGdF5s
 VRAoJjmIo80rM44+MmQC5wR4bRQAkANdTYDYUNDz7LjQZe76JnQw+HnwmkFG26i/q9NkQpA
 FCHYRhh2ZQfLhHTfc4xSH9JR4rRmMwPWzcvi27N5jEt8iHLX2miMEPof68uH58SMa5tGm4J
 s1OqIwvs0q2lFK0+q2X8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:07n7rwTHX4U=:4vnWTvsQ0/aglI8rsF8B5Z
 u12gFlNV1nDKwql/IvCTPmPqLagNVt1OwqErbaavHuvB0oSrhm0TNLD9moBUh6oybsb4fyaov
 s6Ktkg5DSI9ijuE8MkjMTqXMdLtE1oWx8lgiPxdypnys+f0H0Ut6i/eLnepUpW6NtcpcHP7OU
 lOZge3xZHamvYIDNzv0q3TviAjDttz+LbkI8oRN0yFJwoPDf/qrTc9nKVn89+DrwYvDPWE7yT
 5AfF0VbG+6YA/1HeSbYR7kEt3SVmXyeIeY37SNmHulKdCjqV6CsDYKgZ3HNnIySiHwCHV8902
 dqJR1jOqiM0l86cKPD7eFbmkXQHC/HSUaPvf7ZEyfuZbNrf3JA2bk4VdI2hm7mJ+t55wsYRQw
 Jb9FbW28esKGZgAAYVspXxhDD4QHC9s/oPK/C4yRUYa6P3hGchQN80Pw7pu5ZdxN3ZoqWzuZf
 7H2FTzq1v4ijZ7q4RH51OUnXyRUC6ALyh27fVBQiiyYC1RwhezBYLn4JJCGFDPV6GVQFHtcX5
 H6tmw+w8lCWad947wXJfq6HuccYczTjiLYub/pyblYz5y/qtpXHp+duQ1O39Zf3Ox2hWpPO/j
 icT3zlHvgUgj8rDsBLJPczKGd7mjBvB7odxLZBuNqAqiWR+wqQZmy7U3N2+MyeJOATzmAmWtP
 LCWf9L3IMNcpXWze7BYayC7SPW25cYBuDrw4qh1CK+54a1mPI4iJEqm4MP4SVDerscVaBD7bb
 73IuZXTjrFG9Xm6AIppJF277KQu67YCqBYFbCEW11G2/yUiEDuVqY0pdKsi25kWovduB5gErw
 6GtMzL6DuMlmg5e7YwFUDuXYJIJYdtq3Czg//tjPiyt8vksY/1h93gw+yzAFx013WzxMP8+zN
 ai26uloktLejTjmHwWsx3zIr9nlv/So+8IVnAol9YFuSJoydi+JA6OsciQ/xd1/x8X/aLhiGw
 U4WoSD7XMPc7nZsOhFsSfjLvTealscM2MS5H9f8dfaYGfv55OZIDHopX/ings91mCgCcDUxQ5
 RB7o6kRag+GXBFDKVoHgeo12PFjC33vrF/9rvN36QtbzZ0lxxzYnF+jKTYkdWHNhypXXahKYZ
 6R4hh5oHpzkriQ/wFkmzzDei1gKsOtW12JLxols9M2MKTHrzkcPja2HxHxDXqjEn6SCo8IZxl
 YTXO3om2ANSV78ff1VAWl80u6P2vTteadeIuNKQx3mt0SzuRh/HqWgiUYnsZ1oZwZqypx+sFy
 IHWZ3IZGb4QvOmWJe7nUiyD1bPJjJBCWC2WgHE1B1F8q3sYZlO5TAYcBTSHQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 25 Oct 2019, Jeff King wrote:

> On Fri, Oct 25, 2019 at 04:02:36PM +0200, Johannes Schindelin wrote:
>
> > ... and indeed, I verified that this patch fixes the problem:
> >
> > -- snip --
> > diff --git a/usage.c b/usage.c
> > index 2fdb20086bd..7f5bdfb0f40 100644
> > --- a/usage.c
> > +++ b/usage.c
> > @@ -10,13 +10,16 @@ void vreportf(const char *prefix, const char *err,=
 va_list params)
> >  {
> >  	char msg[4096];
> >  	char *p;
> > -
> > -	vsnprintf(msg, sizeof(msg), err, params);
> > +	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
> > +	int ret =3D vsnprintf(msg + off, sizeof(msg) - off, err, params);
> >  	for (p =3D msg; *p; p++) {
> >  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
> >  			*p =3D '?';
> >  	}
> > -	fprintf(stderr, "%s%s\n", prefix, msg);
> > +	if (ret > 0) {
> > +		msg[off + ret] =3D '\n'; /* we no longer need a NUL */
> > +		write_in_full(2, msg, off + ret + 1);
> > +	}
> >  }
>
> Heh. This is quite similar to what I posted in:
>
>   https://public-inbox.org/git/20190828145412.GB14432@sigill.intra.peff.=
net/
>
> though I missed the cleverness with "we no longer need a NUL" to get an
> extra byte. ;)

:-)

I also use `xwrite()` instead of `write()`...

> > > except truncation to 4096. Then I would expect a patch to increase
> > > buffer size to 8192 in the next couple years. And if you also try to
> > > solve truncation, it will get you very close to my code.
> >
> > My point is: I don't want to "fix" truncation. I actually think of it =
as
> > a feature. An error message that is longer than the average news artic=
le
> > I read is too long, period.
>
> Yeah. As the person responsible for many of the "avoid truncation" works
> referenced in the original patch, I have come to the conclusion that it
> is not worth the complexity. Even when we do manage to produce a
> gigantic error message correctly, it's generally not very readable.
>
> That's basically what I came here to say, and I was pleased to find that
> you had already argued for it quite well. So I'll just add my support
> for the direction you've taken the conversation.

Thank you for affirming. I have to admit that I would have loved for my
argument to work on its own, and not require the additional force of a
second opinion. In my mind, there is little opinion required here.

> I _do_ wish we could do the truncation more intelligently. I'd much
> rather see:
>
>   error: unable to open 'absurdly-long-file-name...': permission denied
>
> than:
>
>   error: unable to open 'absurdly-long-file-name-that-goes-on-forever-an=
d-ev
>
> But I don't think it's possible without reimplementing snprintf
> ourselves.

Indeed. I _did_ start to implement `strbuf_vaddf()` from scratch, over
ten years ago:

https://public-inbox.org/git/alpine.LSU.1.00.0803061727120.3941@racer.site=
/

I am not sure whether we want to resurrect it, it would need to grow
support _at least_ for `%PRIuMAX` and `%PRIdMAX`, but that should not be
hard.

Back to the issue at hand: I did open a GitGitGadget PR with my proposed
change, in the hopes that I could somehow fast-track this fix into the
CI/PR builds over at https://github.com/gitgitgadget/git, but there are
problems: it seems that now there is an at least occasional broken pipe
in the same test when run on macOS.

There _also_ seems to be something spooky going on in t3510.12 and .13,
where the expected output differs from the actual output only by a
re-ordering of the lines:

=2D- snip --
[...]
+++ diff -u expect advice
=2D-- expect	2019-10-25 22:17:44.982884700 +0000
+++ advice	2019-10-25 22:17:45.278884500 +0000
@@ -1,3 +1,3 @@
 error: cherry-pick is already in progress
-hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
 fatal: cherry-pick failed
+hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
=2D- snap --

For details, see:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D19336&view=
=3Dms.vss-test-web.build-test-results-tab
and
https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D44549&v=
iew=3Dms.vss-test-web.build-test-results-tab
(You need to click on a test case title to open the logs, then inspect
the Attachments to get to the full trace)

So much as I would love to see the flakiness of t5516 be fixed as soon
as possible, I fear we will have to look at the underlying issue a bit
closer: there are two processes writing to `stderr` concurrently. I
don't know whether there would be a good way for the `stderr` of the
`upload-pack` process to be consumed by the `fetch` process, and to be
printed by the latter.

Ciao,
Dscho
