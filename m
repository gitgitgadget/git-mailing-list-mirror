Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7606CC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD7123AA3
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbhAVQWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:22:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:44785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbhAVQV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 11:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611332406;
        bh=HZI/t/rF7EPq6mRMMZxwgNxTL38OC2BqEJD4unFRQE4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KOQ5Bm2XZGiA734PcZiYsf0BWpasgUFsuB2rjYhX6jaCmNndgckcwhRIRDjJtQvWc
         MakaNATAzPbp5lw6GkTR1DlqMFKanIT8fZigQGMTkfbKRLcZQYOuyv6YqSxxTRNxF+
         uV4u86FyP+Y7a+tAQEtv1uhl1b6rYeYYtHtGyof0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1lKEnl0sIF-00ISk0; Fri, 22
 Jan 2021 17:20:06 +0100
Date:   Fri, 22 Jan 2021 17:20:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] range-diff: handle commit ranges other than A..B
In-Reply-To: <xmqq1redc0x9.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101221713230.52@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com> <xmqq1redc0x9.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:K1Ar6YQWt1WxkZKEWpR92iBNROVUbkXrThYbtuk9goGDNHV95z0
 +YYWEctwjcBL1K7/8kT65Idi7ZbOO7rqkH5mFEVWDRU543uJFN6qE19iOT7HQNa6AouIrHd
 D/YEJJv4RS9JItXbOcpbAKBmJNWdOs6YrhWxtjfifDmu3OwLwIETj5nO4FCb6eflAPUMxWw
 KKBVnbA+y8qYCXdqflOFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+YrcQjhELeE=:xbvc38bk5DxSUUyGIL7Z+x
 7i/UuGuUGwfTrZF5aDV+72a0IdFQyKMNAG81FXcjkusx+NWCCPuLqCP0sh1gyBmJh1EWIFjxw
 ySpt7z9Vr78BcBduRiG9U1MIPAAqCs0uGHpPLRXHCClgXnIZkaqGHJcZBt7HL85g0QRXtYvRG
 +CLqyzRzrEh8WwNvkTEEvLo7m7xdeVKZj6YryJQglYJKzMTnVCeahV5VBeOM3O8Zm/Lkn3JG9
 lEYZEZE/8KW+Ggd2IxOVV3LR5JLgYbTUlwFJ9So6CLReqpz0kseg+sjdOvljODiaP+nwWGymp
 GAR7uw1ozT1XGj48znPqFWzyqKLMMigdyjxadQHQOSrkl3NAPcRG2B4i3dwtbPtjTLsamx+9H
 FzSsinYi+iakKjcRRcy1A32SFVN0px1/T6PaPllUFcxghmInPHxamf6gRXct+vJJ1BdapHojK
 1R1SzCCL7VPKh6eB8MoEV6O3sADLK2JwysCvSp5C94YGvIrxFBZ3VmpxshZjO7lZJsyHXpIbl
 G0h06PjkKjQHlqBL4g3GwrURMfgxXlePwXBCk0AxNPNl0DNgd0ZSKNO6SuVYXygrrPPX2zk/9
 I1meBi8xZTANRRYkE6RqTInlxPoSrBRw+09Lc7deOQlJ27SuFBHWHj9hbVJQWulkArA2XIc8Z
 LIbZzng0HGTZ1oT5RaHZrRd1ovWOIevLlOjvJJvioLU53l//2cbIivsvfjt07G91fjjzxMF8P
 l8G5CMOSh9OuImIQyEH906i0IuW4D/sZ3eBzFEY3foEYDP/r1+PB4Am5t1zDcQZbOLJVbNKe+
 0GNAD09p3kB2UFzGDhTWnylkhG0CDBMc1KaxsldME98h842ARLsRJwmXiiqiUcfyHMJsMsjaz
 iOzpQuwmBF3SIjJqCVbp/m9DcXamzyrFqR3Sc7UIw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Jan 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
> > described to specify commit ranges that `range-diff` does not yet
> > accept: "<commit>^!" and "<commit>^-<n>".
> >
> > Let's accept them.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/range-diff.c  | 21 ++++++++++++++++++++-
> >  t/t3206-range-diff.sh |  8 ++++++++
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> > index 551d3e689cb..6097635c432 100644
> > --- a/builtin/range-diff.c
> > +++ b/builtin/range-diff.c
> > @@ -13,7 +13,26 @@ NULL
> >
> >  static int is_range(const char *range)
> >  {
> > -	return !!strstr(range, "..");
> > +	size_t i;
> > +	char c;
> > +
> > +	if (strstr(range, ".."))
> > +		return 1;
> > +
> > +	i =3D strlen(range);
> > +	c =3D i ? range[--i] : 0;
> > +	if (c =3D=3D '!')
> > +		i--; /* might be ...^! or ...^@ */
>
> I am confused.  If it ends with '!', I do not see how it can end
> with "^@".

Bah. This is a left-over from an earlier version. I tried to hide the fact
that I had misunderstood `<rev>^@` to specify a commit range. Oh well.

> If the input were "!", i gets strlen("!") which is 1, c gets '!'
> while predecrementing i down to 0, and we notice c is '!' and
> decrement i again to make it (size_t)(-1) which is a fairly large
> number.

Right, guarding that `range[--i]` only by `i` is not enough. My idea was
to exit early if the string is too short, anyway, i.e. if `i < 3`.

> Then we skip all the else/if cascade, ensure that i is positive, and
> happily access range[i], which likely is way out of bounds (but it
> probably is almost one turn around the earth out of bounds, it may
> access just a single byte before the array).
>
> Am I reading the code right?
>
> IOW, "git range-diff \! A..B" would do something strange, I would
> guess.

Right. Will be fixed in the next iteration.

Thanks,
Dscho

