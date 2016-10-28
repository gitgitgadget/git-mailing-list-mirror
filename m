Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029992022A
	for <e@80x24.org>; Fri, 28 Oct 2016 11:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756138AbcJ1LLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 07:11:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:49178 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbcJ1LL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 07:11:29 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MC4R6-1c8qVK31c0-008sqD; Fri, 28 Oct 2016 13:11:02
 +0200
Date:   Fri, 28 Oct 2016 13:11:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
In-Reply-To: <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610281306320.3264@virtualbox>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox> <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com> <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com> <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com> <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
 <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com> <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com> <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com> <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com> <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com> <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5bK+dbSxP0CGc0xeRv+MHJrcIWTYceI1DIOeal1XLtlFm5yhA3x
 +wXWHNAEM9kYty2/4TwK1lli4AIu9oNpD5uuJvLT2bbX4nwx7YdBAtHtNRe6eOAhzqsW9ib
 wo65DD+o5/M6DRGpXZ9Tm60027gXOcaLn3R8QDzz9N6QqbeNp2+X8rsDLPEYFkUcmunIkUG
 ZMZnmmVX3DPCCGaCmEoRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JYJas6Oum28=:ZBEnxaCAkt3WJne75Cd4zZ
 GQx0pTHbbhsrkSnPC49V3oTq9PZ6jHQhOlDzDLyIFifC42g2SvAl/WGlOf7Vp29p6M7rP4wHy
 5qWKXzL4nK+FLmKpOoNL9kK4YpiE3/6Dog4FcaI0WCN7PAasAuf89cS9Rf+K37mnDWShGpEAN
 gjUGXdoNCQjY6Dozrvml1qPkyRX1zGQfonzyJvSw7EeMNYOF/nVN7lYK6FMbIkO6zNPcnsa4x
 /wugO95dC/0yxjXI5EFBPBQYieP+f4DCpJYdKv6iTK8EIBMoMIGmKF14IkBosdtnTCRyYZvZu
 JI42Big7nhdiEe1M9g+CYdbW8Yo262NimPnC4235RURfFNq7/dEvoYrUFezmXCb1nwGhVk2/1
 nzHd9w89YnzgKr7l511QJHvcaxY7ME9uh0z5UN0yeqgePsxxiCNq9wFFm6HOfem96Rl2qFFcS
 AZBNw47aO+i1ZCzd49X1GZtafhONMOJDoJdERC28LcwX3vsq43evsfvak0phJ4xJzEJyOoBU+
 fBVcW+Hvo6yJE8wrz9/Dzqov2lPhICPJ7l+UD3UUVZ9L8UA9hu+XH+Io9r+vSaLNOHAdBrv/j
 fgBPfOptzuNJe6wNAsA3tWcpUYyv6NENJR5H5X8skoph/bSiov8XdBvTqvy2ERme+JwN3pXCn
 lkI7EZN4BURo6m8Dc9jR79tex09GjV64aKXS4yr9e9/n4JaAPV2cdz5BlRDiYR6RrM1UmzQ3X
 77DWOpm6oAqiITCNHEvls95+pmYlmzTes5AcXrdoEvQUfkPphPtVa76xlsSs4hjtrE6SY4aYw
 f7Q956R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 27 Oct 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> >> On Thu, Oct 27, 2016 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>>
> >>> Would the best endgame shape for this function be to open with
> >>> O_NOATIME (and retry without), and then add CLOEXEC with fcntl(2)
> >>> but ignoring an error from it, I guess?  That would be the closest
> >>> to what we historically had, I would think.
> >>
> >> I think that's the best model.
> >
> > OK, so perhaps like this.
> 
> Hmph.  This may not fly well in practice, though.  
> 
> To Unix folks, CLOEXEC is not a huge correctness issue.  A child
> process may hold onto an open file descriptor a bit longer than the
> lifetime of the parent but as long as the child eventually exits,
> nothing is affected.  Over there, things are different.  The parent
> cannot even rename(2) or unlink(2) a file it created and closed
> while the child is still holding the file descriptor open and the
> lack of CLOEXEC will make the parent fail.  I do not know how well
> fcntl(2) emulation works on Windows, but I would not be surprised
> if J6t or Dscho comes back and says that FD_CLOEXEC given to F_SETFD
> would not work while O_CLOEXEC given to open(2) does.

You guys. I mean: You guys! You sure make my life hard. A brief look at
mingw.h could have answered your implicit question:

	static inline int fcntl(int fd, int cmd, ...)
	{
		if (cmd == F_GETFD || cmd == F_SETFD)
			return 0;
		errno = EINVAL;
		return -1;
	}

So while you discuss in your Linux Ivory Tower how to optimize Git for
Linux, and Linux only, I'll have to drop everything else and spend the
rest of my Friday trying to find a way to adjust a file handle
*immediately after opening it with undesired flags* (when it could have
been opened with the desired flags, as suggested, to begin with).

Ciao,
Johannes
