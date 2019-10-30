Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EADAE1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 08:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfJ3IzZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 04:55:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:47975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfJ3IzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 04:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572425708;
        bh=Bb1cOwwPMpBUcoiRQ0lAh05X3QU2BvtkhupdgjpJZ+M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V0JtLAjhiko6cugsvXTbmJJqeyCYjI6wFLrOHrDOg6gRPl7EO9N0NIscQQereTWcD
         CiWDQdHINa1t9Epi0kxkY9+ISvL4TKXS6YtojNiffs9kAf/DUfU05/nw03VAlMFnvr
         QeJHI6maMvXJne5tn6KClf+2OP86Ga2LyZ2kOu1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1hfAj417J8-00oGoZ; Wed, 30
 Oct 2019 09:55:08 +0100
Date:   Wed, 30 Oct 2019 09:54:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
In-Reply-To: <20191029203259.GB12337@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910300947410.46@tvgsbejvaqbjf.bet>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com> <pull.428.v3.git.1572379280.gitgitgadget@gmail.com> <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com> <20191029203259.GB12337@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GArS4UE2RwwjaHKhnG1rO9UTAJrmJr/Pf21P010rJeXnDiKslze
 IwOjaHURWefEgPJBG1BgelVt9rfqxkjqWrHgvXMjha2ZYKgUckHdA927CCVeQZjqqEQCcgV
 ASkoML7n/9VVcIFJVjjOCvvTNwNEQRZwHNcfOTBcxdSic5es+1efbmVvF6AHSm0Unrd4Ato
 OXnvRXmKufKx6eiJdQ02w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:glXhLRrJGks=:fcVe7fxcyly/Mkfyvy/f8V
 ETrt2rRcGVm7kho7PKcU9zkh/gMInp2jDARr4jEeeiVKFHfoLLcxYhRx24Izqxs3gwF1KrXpT
 EICairFMoDcjrOf9ZHk6LHjkzv4u8eCYXUQbDde3GEBB9nuo511MWIHfu7XxqaGB/Ch50Yee2
 3E4+RIjDzGzXA3p3k9EbtuDVWoTUNffMdV7aT5JJvauetXzzexzna3SWZgB3S/oEt8QP4u1mT
 93JlT3EXrRJjyoZPDhrHI/mipO/B0fyEg2aLiabypG7iQ61Ie0IZERgMy068C+LM91UizJWYN
 J3yqShTYlDyJzu0LQE7/s6PRAzGZ4aKkUpxjXHwpfJPqMOwyZB4LLGxfMxYgah43Jsuma4hWi
 NR9SpU487PfO/zsptY+bdxTv9tU2pEz/WwuuXS4XL3bNp9qLDyhHTTs3buhYIt0678AVNRxWk
 7zXIeZbPvkGma0A/YsFei8qtug8xWx7w60L5vm59Goq4O2rPHq3IJauPcOBFmVLxqzm6RyK+1
 xL/T9eQMcxgX901prZ0izIUT5U6JDKtiKPXeLYqVyYgYK29Hiz1u2yUr8eeAolhLHd71tTocy
 /s+Ng3ollST4C3yNDYd45GSBjrnJsyfRDn49YVkw1WMCkPZ7UYp9Ky0ecUvPFvGPCY4oAqMZH
 7X+FkpXh4e9wBs2D95KD9SlyRb0ux3ev0SpnYGx/5klK3riShZ7avBDO9tfSv/Dyytzn4CZLJ
 dTJ981vk8oz1jHRod99OHA1mPIYWnaUrs5jHC8omLZhjcpbVZSvE/j04YTg2RGsVv31kOmvdM
 rk159oyScu8lpU9iy6ht9cRJ03YXKxSnA0jaPdeECt2tFwBRdt4iBivglQ21uXORCtU3WXExN
 ozMvciOcOxJ8jXYsOYT6/NYocYQ6Kt1EtOAFb3i7oA+ch4vVzlRlVXHvJM9VT2fslYvROKe/e
 huNRj2NQFL3PTHVpO/XxxFfwaLUKrkPvGFTv/NSgqvCY8YDQ9U9Wusbx07gYGZQ1KS4Xwo3rn
 tkFN4XxbkQadBJzPdvHakaAkX/ho04RfbJCzIw9X5BuDeJH6kYYVdPGhJoyhzUY4KHnbatDEi
 AlPDH6Jgy24tdeqtg4nAkpzyPtij5b4lOYCjhyrXrtlzCkgzlPB4EMJkOo043wU8Dxeqon73x
 Jg/eNraFixrZjYvGi+V/hwCR9puAqMroowxhbSXMgFV9ZKlgOIF+y9NN0x6vKPWopsx/58G5S
 9roWSQ8KgA0JyZ1DNxlhpT5mMvReFDec1QFe7BE6rBeim2fazcOvM4THs2VA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 29 Oct 2019, Jeff King wrote:

> On Tue, Oct 29, 2019 at 08:01:20PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > diff --git a/usage.c b/usage.c
> > index 2fdb20086b..471efb2de9 100644
> > --- a/usage.c
> > +++ b/usage.c
> > @@ -9,14 +9,21 @@
> >  void vreportf(const char *prefix, const char *err, va_list params)
> >  {
> >  	char msg[4096];
> > -	char *p;
> > +	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
> > +	char *p, *pend =3D msg + sizeof(msg);
> >
> > -	vsnprintf(msg, sizeof(msg), err, params);
> > -	for (p =3D msg; *p; p++) {
> > +	p =3D off < pend - msg ? msg + off : pend - 1;
> > +	if (vsnprintf(p, pend - p, err, params) < 0)
> > +		*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
> > +
> > +	for (; p !=3D pend - 1 && *p; p++) {
> >  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
> >  			*p =3D '?';
> >  	}
>
> This version looks OK to me. Some bikeshedding:
>
>   - I suspect it may be more readable to just stick to offsets instead
>     of pointers, since that's what strlcpy() and vsnprintf() give us.

An earlier (unsent) iteration did exactly that, but it was quite a bit
more unreadable because of the required arithmetics with `sizeof(msg)`.

>   - I don't think "p =3D=3D pend - 1" can ever trigger, since either
>     vsnprintf() or we will have just written a NUL.

You are right, but I wanted to make extra sure that this code is robust
even (or: especially) in the presence of buggy libc functions.

It's not even expensive, I don't think.

>   - Do we need to contend with vsnprintf() return a negative value in
>     general in our codebase? We already BUG() on it elsewhere. Yes, that
>     BUG() would try to write via this code path, but it implies to me
>     that we've already dealt with any such broken vsnprintf()
>     implementations (via compat/snprintf.c).

It is true that the test suite bails out with a `BUG()` when
`vsnprintf()` is broken. But I figured that we want to be safe rather
than sorry. Besides, I have no full picture about what potential reasons
could make `vsnprintf()` return a negative value: for what I know, an
invalid format string could trigger that. And I _really_ want this code
path to be as robust as I can make it.

> If you're sick of bikeshedding, though, I can live without any of those
> being addressed.

Oh, that's okay, and I would not even call it bikeshedding, I think you
raised valid concerns.

> > +	*(p++) =3D '\n'; /* we no longer need a NUL */
> > +	fflush(stderr);
> > +	write_in_full(2, msg, p - msg);
>
> One non-bikeshed question: would fprintf() on some platforms have sent
> "\r\n", which is no longer happening with our write()? Do we need to
> care about that?

I am not aware of any platform where `fprintf()` would automatically
transform `\n` to `\r\n`. Not unless the `FILE *` in question has been
opened with the `t` flag. And I am rather certain that `stderr` is not
opened with that flag. And if it was, I would force it off in Git for
Windows.

Thanks,
Dscho
