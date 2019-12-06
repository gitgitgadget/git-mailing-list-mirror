Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB710C2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B80C24659
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 14:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gU7Xb3KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLFOMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:12:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:42239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfLFOMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 09:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575641515;
        bh=jlh4vMnYlQKKQVwIw5NTP0VIhQQrzYWnzzvJaMD0NC8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gU7Xb3KIxuI2WUSDqep8rCd63fo2WApzvqkzud+bLtll1DVPGgS3hAXizLj+jNgXf
         1zLCW6gmtKjDHQ3jWuGJLvxfJ+5azEamBR2rVre+ab8Zd/xfpSLXm+x5LVF6/lMDHc
         w3mPewpnLMIBYa5bp2q8jhR1dvZPLpLR0uy89gL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfJX-1hl8oG2RUl-00v4i6; Fri, 06
 Dec 2019 15:11:55 +0100
Date:   Fri, 6 Dec 2019 15:11:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/7] apply --allow-overlap: fix a corner case
In-Reply-To: <xmqqr21hy3cf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912061502110.31080@tvgsbejvaqbjf.bet>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com> <15c4cce5a027d56c7ddbe5523cf0f3beabd06ed7.1575637705.git.gitgitgadget@gmail.com> <xmqqr21hy3cf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OXDs0luOOA24onRoSp9KFi8qmOPNPVOoCcUzGIcFbVOq6eodHAB
 SU69fBqwaCoVcBbaLzcd01W+cLP5KeuTKC/D3NU9YabnLswvad7jgaHUApd6wc93ImM3sTC
 NAgCfDPawJ7JcFS4Z54L5XA6mYBKu9IF3SKYiVLQ+rIBFE36eD5Ppwumn3wDxdjPBecHWC0
 5xlsaqnG+TmaDdMc7QOAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ncvc30u+NL8=:za0QfGKmxyqHU2HAMmcAdc
 d/cjtR/0MpxiyDAigrN5GnfygSkXPhPcsHA2QprcZqOaYqn0iSQ8h7adQyPyztyDFFR5p58HZ
 c0gljm/Ku2Shz93bg9OlTCauRHSTatjfHmZlyz3YOpHVeWeqDOweO69XZhYZx2wkkrILuGIQD
 NzsoOBhZPYBGPHKhYXHpomyi/vFbRN2tlkKm4kOFIQxJkUYq72lotc4TdI8Vu1Wx3YrFO7FNf
 S4lTTCw+YXmuH3BAjENTKTigGq82O96qFvD0xVMJhRUVJNu7DtmUEk8BM6zkZJD3QMZauCKXw
 wQOGmQx4vnzVwboWjyV+dyXPkobqsxBDmZmxdYt/OIcVu2CfxkVWarzMF4XJ4QX+glpSZ58B8
 dX/j1Eo8B1OSrS6RnzXCNOhhC+QfI92ZWBSPEWnkdhNun2U1buh8o23Vi4yK1OT48L39wevYB
 LRSShddRVR9LXThjFhoncgAn//nu5tgvTuDOySsjDFiy1nVVpZghpwPNhXzT4UZWjG+bc+O4I
 GZ81oFyvDHgDwHUZiql2d6JHKHOW2m8swf3nr9dXmK90m/AIAFkHI9SQ2G4ciXgivK4eNzb9I
 T3pirn6+Yflr3QTMxPkIaqSSvVUNA3sjqC1C3OHH0CwPLX0K62rbvf6tlpLNw+D6dktm9Kev2
 vT6Oe9cIz+RCN/KJpHDjUd68ZOQpQFXcUyaSNU8hF7JU5bihGd7FDKWPa2P7NxqzGlDYlvi4E
 EoVcL22K5Mu4zmr63FRlrksolVg6CpOM3YFaHeUOypkoRvszT7l9qJCHvo3qz1OrReCfgkyxF
 SOz7W90WzPw9poXIc2jmJzrw0mtRtm8LHYsbbzG2sjDfA77O3DEDzyaflXXTF009oK8qH9zv/
 jSAIFlT8KZYcsVzNPTu04tjOKm7JEZfLrtmnI3wlNX82GkfXXbFMR0uFKm44g/Yokg0MriG20
 t7+DQZYFOAIbEMj4rnzSHbAfIYOVANA1HM2xx1uHHgxEdZwf8v5s14PMPA7JXxKVFKYOJPj6g
 ZMM2SPP39kp3Qpt3EsoWwOwzvTaRxsgj8BJMLrQTy2uFvQUPC3lEheBWkRugDGLysxE5hbH8a
 5LEPqj7FJkMRDnLkPd3VEvJ2w9gUYsDOFdjDuCwZpGoI+hQEzTGugKE4VxeFAuh13esllh3Ip
 AKccyKwD6xp8XpUUlRpZdI03ftIXr2IePANjcgB9nuQNzhq7A8ia4WR7tC1LCWEXCZTZsTSr+
 eLle6bSyRnh1ACeYbZ38R5QrhcK5CTP2i7026+XZosHjApoJL++JoY1Z8cPs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Yes, yes, this is supposed to be only a band-aid option for `git add -=
p`
> > not Doing The Right Thing. But as long as we carry the `--allow-overla=
p`
> > option, we might just as well get it right.
>
> It probably depends on the definition of "right", where it may not
> even exist (otherwise it wouldn't be a band-aid but be a real
> feature) ;-)

Indeed. My hope is that we can get rid of it once the scripted
`git-add--interactive.perl` is removed in favor of the built-in add -i/-p.
This is a long way off, of course.

> > This fixes the case where one hunk inserts a line before the first lin=
e,
> > and is followed by a hunk whose context overlaps with the first one's
> > and which appends a line at the end.
>
> The in-code comment makes me wonder if we need to further loosen the
> check in the other direction, though.  What makes begin more special
> than end?  Can a hunk be seen that pretends to extend to the end but
> no longer does because there was an overlapping hunk that has been
> wiggled in?

The beginning is more special than the end because it is associated with
the line number 1. The end line number is flexible already.

There is another difference: after splitting hunks, the first hunk is
applied first, and may render the line numbers of succeeding hunks
incorrect. The same is not true for the last hunk: it cannot render the
preceding hunks' line numbers incorrect, as it has not been applied yet.

I think that's why `--allow-overlap` works with this patch when adding
lines both to the beginning and to the end after splitting a single hunk.

Ciao,
Dscho

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  apply.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/apply.c b/apply.c
> > index f8a046a6a5..720a631eaa 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -2661,6 +2661,16 @@ static int find_pos(struct apply_state *state,
> >  	unsigned long backwards, forwards, current;
> >  	int backwards_lno, forwards_lno, current_lno;
> >
> > +	/*
> > +	 * When running with --allow-overlap, it is possible that a hunk is
> > +	 * seen that pretends to start at the beginning (but no longer does)=
,
> > +	 * and that *still* needs to match the end. So trust `match_end` mor=
e
> > +	 * than `match_beginning`.
> > +	 */
> > +	if (state->allow_overlap && match_beginning && match_end &&
> > +	    img->nr - preimage->nr !=3D 0)
> > +		match_beginning =3D 0;
> > +
> >  	/*
> >  	 * If match_beginning or match_end is specified, there is no
> >  	 * point starting from a wrong line that will never match and
>
