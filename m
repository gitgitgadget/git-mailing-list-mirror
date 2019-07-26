Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3803E1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 11:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGZLXn (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 07:23:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:43105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZLXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 07:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564140215;
        bh=YdHBs1SGbYzdF4X9lIm3F8mD9EyeofoxD+elhOhpYqI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O+0wCi9FrKGm6MwFqxVbcYMVs+FAq/O7QiCflUvDhvyqHKqsAAiy8Xee6nmPBfQVD
         NNJhlSihdZDk/Dm4jab7aDoEz+9c1yPBP+A25soxUALTBCakw9qvZSUqRitefkMvKw
         zUzcLj0DoZ7q11Q370pcACwSgVsGMeEEgkrseAuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Likl3-1iPDkA1MHV-00d2ns; Fri, 26
 Jul 2019 13:23:35 +0200
Date:   Fri, 26 Jul 2019 13:23:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/19] Ensure index matches head before invoking merge
 machinery, round N
In-Reply-To: <CABPp-BHahUojy1+cBrOTCvg-w3n-xJp3yE3Br6v8jMwnMzQwCQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907261323000.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-4-newren@gmail.com> <nycvar.QRO.7.76.6.1907252120300.21907@tvgsbejvaqbjf.bet> <CABPp-BHahUojy1+cBrOTCvg-w3n-xJp3yE3Br6v8jMwnMzQwCQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HH86VnXU90k9xe4mWCtV3Hx5IyJZjBcLt09k2U+3zJv5dZYfQ2R
 aHYIi9hRyRNX8mto1/8MOUY1/Ft6tJ1gAydBjyvO4NchcJWJri8rBsRXInj22y0hV0HSzUT
 AT62NII8MGLgnMZCNjOCtq5LY3z2nfm2hZdNqV+xF5xLZ0e6wG9hgGmqCmX+yI7Q+F6bpeq
 7hSIQGA9n1f+6d9FCtG5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HltnWSqQjfs=:O4KQfy9M0TzjbRWLrxCqwy
 nLEpbNH3mVJ05cMygNV5rIHuJF6w2ACk6Mqnv40zuDKpV4EscZtNOqFfHXjLhaEVi3XpxXf1I
 DB4Goy86V+ianh/AGZUv90VGAGnvYxvOhmst3zJobKedSSNjt9Ezytaba9eDrZSD5y0ABRLf4
 r6O3XldgTU79UBDfxysezfvgfkh4fjMALDaNYDfuPsshgdjvyHGq7+cKgvxi4G18og37mLElM
 OMqFKUfD1MraxgLEKf0fV+vEKh+XxiQcfBSCs+8uDmtiSjQVVDlP8FlBwlz/ASRp0dxB0IwQq
 +rPuTNS1llKXGibKY4JcC4uGq6+TUMrjcu/rv/9oewvJ3jKj+5XB7nJ9yLtU7Y+puEUglIw73
 /j1Zj4400BOQ9MUfn3ZbADdpUDIUUwYHqdHBo9Cv0WETEW1gdjD96zSPNb2O6xuvP2TumUDQT
 WoOO/wd8YNx0ooOnLTjn63ePP9n0SDJvcoZhA/6DUb0DT/fZrxk2qFohotK3dqeWBZpCQ0nnf
 71JYWJB8I4BzTpMSqShCF6Fly9NlE7gArKYKbfSGaCx5hjiqYdYOR7fH3dK0URLslSiUppnl+
 Y3Fkf8+Q/Ay381ctjsJe/B139TIU72zlIapMnhiiRSoHQ2G5rQw+P9xPSaa4DlA8qrPUx7CGe
 lLKPkLkG2smQG0oYtpRhF2hpYn4uUDqUdIpygBA3zRYXjFwcu+ZRTT1/LcrIxmP05i/nCDW2I
 QtXOXerkeqHorHvKSrzAs92gzQ2SV8qRtc95Z7sJC8wpD8XryITX+2+2Z32HWh5OOnoDup8/g
 seevx31N+YrT/Hnyf2Y98TXxb129XSEFwXYncxSNzvalzanpzJ/2z9P9VrDkL26oeAwsjCSWp
 f2qigGfyXg6Pq29YxZhEneaMJco7UXtYvY7QwJRvIynqqLocWmuzHAwquZs1pAbBzbIsZRYD9
 /0fSrcnas3SmKOt/o5Yqdy+eAhOH6qAuKXXMxESlbUJH7kKl03WtfD+aXq9LQ5qcsJFPoRF7E
 P7LY64RM3INQnTErs4/T0aXZ8g+sV7Gme5FzEgFe3t3muCkOAJtAuk/pRbURf+JqFreHrihfL
 kOQYBYzSf1A661JBLM2HKQsn00OuQLO55we
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> On Thu, Jul 25, 2019 at 12:41 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 25 Jul 2019, Elijah Newren wrote:
> >
> > > diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> > > index 5b910e351e..a4bfd8fc51 100644
> > > --- a/builtin/merge-recursive.c
> > > +++ b/builtin/merge-recursive.c
> > > @@ -1,3 +1,4 @@
> > > +#include "cache.h"
> > >  #include "builtin.h"
> > >  #include "commit.h"
> > >  #include "tag.h"
> > > @@ -63,6 +64,9 @@ int cmd_merge_recursive(int argc, const char **arg=
v, const char *prefix)
> > >       if (argc - i !=3D 3) /* "--" "<head>" "<remote>" */
> > >               die(_("not handling anything other than two heads merg=
e."));
> > >
> > > +     if (repo_read_index_unmerged(the_repository))
> > > +             die_resolve_conflict("merge");
> >
> > For a moment I was unsure whether `_unmerged()` is the right thing to =
do
> > here, as it specifically allows to read the index even when there are
> > conflict stages. But I guess it does not matter too much here. I
> > probably would have opted for `repo_read_index()` instead, though.
>
> The names repo_read_index() and repo_read_index_unmerged() actually
> seem slightly misleading to me; they seem to do the opposite of what
> you'd think they do.
>
> repo_read_index() reads in an index and allows unmerged entries and
> returns istate->cache_nr.
>
> repo_read_index_unmerged() calls repo_read_index(), then checks to see
> if any of the entries are unmerged and returns whether or not any
> unmerged entries were found.
>
> So, the way to disallow conflict stages isn't to use
> repo_read_index(), but to use repo_read_index_unmerged(), as I did.
> Counter-intuitive, I know.

Whoa. No wonder I get it wrong all the time.

Thanks for educating me,
Dscho
