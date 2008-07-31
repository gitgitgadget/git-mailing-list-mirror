From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
	Monotone)
Date: Thu, 31 Jul 2008 22:54:00 +0200
Message-ID: <20080731205400.GA7911@atjola.homenet>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:55:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfAz-0007wZ-1J
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbYGaUyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 16:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYGaUyH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:54:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:40626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751712AbYGaUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:54:06 -0400
Received: (qmail invoked by alias); 31 Jul 2008 20:54:02 -0000
Received: from i577BBE0C.versanet.de (EHLO atjola.local) [87.123.190.12]
  by mail.gmx.net (mp025) with SMTP; 31 Jul 2008 22:54:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19R9Kde0ShRDDQO8wQUQ0ogJFY/3BN7ycOhKB6Dy/
	o0Q8act6b2psjo
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90987>

On 2008.07.31 13:09:09 -0700, Linus Torvalds wrote:
>=20
>=20
> On Thu, 31 Jul 2008, Craig L. Ching wrote:
> >=20
> > We find ourselves constantly having to shift gears and work on othe=
r
> > things in the middle of whatever it is we're currently working on. =
 For
> > instance, in the scenario above, A might be branch that contains a
> > feature going into our next release.  B might be a bugfix and takes
> > priority over A, so you have to leave A as-is and start work on B. =
 When
> > I come back to work on A, I have to rebuild A to continue working, =
and
> > that's just too expensive for us.  So we use the monotone-like
> > new-workdir which allows us to save those build artifacts.
> >=20
> > So, that said, I ask again, am I missing something?  Is there a bet=
ter
> > way to do this?  How do the kernel developers do this, surely they'=
re
> > switching branches back and forth having to build in-between?
>=20
> Sure, if you want to keep the build tree around, you would probably n=
ot=20
> use branches.=20
>=20
> But yes, then you'd likely do "git clone -s" with some single "common=
=20
> point" or use "git worktree". And even if you don't use "-s", you sho=
uld=20
> _still_ effectively share at least all the old history (which tends t=
o be=20
> the bulk) thanks to even a default "git clone" will just hardlink the=
=20
> pack-files.
>=20
> So literally, if you do
>=20
> 	git clone <cntral-repo-over-network> <local>

Hum, I guess I'm just missing something and prepare to get flamed, but
wouldn't you want that one to be bare? Otherwise, the other clones won'=
t
see all of the original repo's branches, right?

Maybe even better:

mkdir local-mirror
cd local-mirror
git --bare init
git remote add -f --mirror origin <central-repo-over-network>

A cronjob (or whatever) could keep the local mirror up-to-date and the
other repos can fetch from there. Pushing would need to go to a
different remote then though.. Humm... Maybe not worth the trouble for =
a
bit of additional object sharing.

Bj=F6rn
