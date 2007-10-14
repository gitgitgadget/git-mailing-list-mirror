From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 22:18:13 +0200
Message-ID: <20071014201813.GA26872@atjola.homenet>
References: <20071014143628.GA22568@atjola.homenet> <47122D02.9060204@op5.se> <20071014152327.GA24003@atjola.homenet> <Pine.LNX.4.64.0710141830050.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9uw-0003pe-Cc
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXJNUSV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 16:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXJNUSU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:18:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:49577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752801AbXJNUST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:18:19 -0400
Received: (qmail invoked by alias); 14 Oct 2007 20:18:17 -0000
Received: from i577BAEEF.versanet.de (EHLO localhost) [87.123.174.239]
  by mail.gmx.net (mp027) with SMTP; 14 Oct 2007 22:18:17 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX185+LhNvLE5UL7tHziiOVHYFFfK5PO9e0I91KZbNh
	x4acX7w9hGNLJ1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710141830050.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60899>

On 2007.10.14 18:32:44 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 14 Oct 2007, Bj?rn Steinbrink wrote:
>=20
> > On 2007.10.14 16:51:46 +0200, Andreas Ericsson wrote:
> > > Bj?rn Steinbrink wrote:
> > >> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the cu=
rrent
> > >> master and all of them crashed. A small shell script to reproduc=
e the
> > >> problem is attached.
> > >
> > > Manual bisect? Ugh. This *is* the century of the competent develo=
per
> > > tools, you know... ;-)
> >=20
> > Then, how do I search for a good version with git bisect if I only =
have
> > the one data-point "master is bad"?
>=20
> AFAIK Junio introduced the option to start with just a bad commit, an=
d no=20
> known "good" one.
>=20
> Yep, just found it.  Since v1.5.2-rc0~77^2(git-bisect: allow bisectin=
g=20
> with only one bad commit.) it is supported.
>=20
> >From the commit message:
>=20
>     This allows you to say:
>=20
>         git bisect start
>         git bisect bad $bad
>         git bisect next

OK, using that approach, I bisected it, and even found a "guilty"
commit, although it is pretty much useless:

1cfe77333f274c9ba9879c2eb61057a790eb050f is first bad commit
commit 1cfe77333f274c9ba9879c2eb61057a790eb050f
Author: Junio C Hamano <junkio@cox.net>
Date:   Tue Jan 30 01:11:08 2007 -0800

    git-blame: no rev means start from the working tree file.

    Warning: this changes the semantics.

    This makes "git blame" without any positive rev to start digging
    from the working tree copy, which is made into a fake commit
    whose sole parent is the HEAD.

    It also adds --contents <file> option to pretend as if the
    working tree copy has the contents of the named file.  You can
    use '-' to make the command read from the standard input.

    If you want the command to start annotating from the HEAD
    commit, you need to explicitly give HEAD parameter.

    Signed-off-by: Junio C Hamano <junkio@cox.net>

> I don't know if it is in the documentation (I rarely read it), so if =
it is=20
> missing, it would be nice if you could add the description there.

Nothing in there yet AFAICT. Will try to get a patch done tomorrow.

thanks,
Bj=F6rn
