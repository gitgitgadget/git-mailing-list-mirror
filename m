From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Warning: cvsexportcommit considered dangerous
Date: Thu, 15 Nov 2007 11:59:46 +0000
Organization: Insert joke here
Message-ID: <1195127986.32371.6.camel@murta.transitives.com>
References: <Pine.LNX.4.64.0711041638270.4362@racer.site>
	 <623F4AFA-FE43-4046-9D3F-435396BBE17D@zib.de>
	 <Pine.LNX.4.64.0711042133330.4362@racer.site>
	 <200711050005.28561.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 12:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsdNj-0000p1-1N
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 12:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbXKOL7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759168AbXKOL7G
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 06:59:06 -0500
Received: from mx.transitive.com ([217.207.128.220]:42476 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756405AbXKOL7E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 06:59:04 -0500
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1IsdGt-0008CF-LE; Thu, 15 Nov 2007 11:52:36 +0000
In-Reply-To: <200711050005.28561.robin.rosenberg.lists@dewire.com>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65111>

On Mon, 2007-11-05 at 00:05 +0100, Robin Rosenberg wrote:
> s=C3=B6ndag 04 november 2007 skrev Johannes Schindelin:
> > Hi,
> > On Sun, 4 Nov 2007, Steffen Prohaska wrote:
> > > On Nov 4, 2007, at 5:41 PM, Johannes Schindelin wrote:
> > > > ever since the up-to-date check was changed to use just one cal=
l to=20
> > > > "cvs status", a bug was present.  Now cvsexportcommit expects "=
cvs=20
> > > > status" to return the results in the same order as the file nam=
es were=20
> > > > passed.
> > > I do not know why it wasn't applied. I forgot re-checking after m=
y=20
> > > vacation.

I think at the time it was felt the speed hit was too great on large
trees. Although my view still is we should always go for correctness
over speed.

> > It slipped by me, because of holiday, too.  (I was on my well neede=
d=20
> > holiday then.)
> >=20
> > But that patch really seems like a step back to me.  The line "File=
: ...=20
> > Status: ..." should be parsable enough to fix the bug properly, ins=
tead of=20
> > undoing the optimisation.
> Unfortunately it's not that easy to parse. It *can* be done by lookin=
g at the
> repository path, and the CVS/Root etc, but it's not nice.=20

I also worry about corner cases in parsing code, especially if you have
to start poking around in CVS/Root files. Another (ugly) method could b=
e
a two pass attempt, falling back to an individual status call if the
"optimized" version isn't sure.

> > AFAICS Robin replied with a "let's see if a proper fix materialises=
", and=20
> > I kind of hope that it will materialise soon.

I've not had another go at fixing this mainly due to being too busy. Th=
e
current patch works for me.

> Still hoping :). BTW, wouldn't this err on the right side anyway, i.e=
=2E if an
> existing file was not up to date and was wrongly thought to not exist=
 or a new=20
> file was thought to be up-to-date, I would get an error and would not=
 be able
> to commit. I've never seen it though and I always have a clean CVS ch=
eckout
> so the potential bug seems unlikely to me.

It's not just new files that can break (btw another fix has gone in to
ensure directories are added to CVS trees in order).=20

--=20
Alex, homepage: http://www.bennee.com/~alex/
Nothing in life is to be feared. It is only to be understood.
