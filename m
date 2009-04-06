From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Mon, 6 Apr 2009 12:03:05 +0200
Message-ID: <20090406100305.GD20356@atjola.homenet>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com> <7v3acmoalw.fsf@gitster.siamese.dyndns.org> <3f4fd2640904060042m438a3a8en2d2746a6216b2b95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 12:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqlhF-0002m4-6m
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 12:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZDFKDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 06:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbZDFKDL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 06:03:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:45870 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754630AbZDFKDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 06:03:10 -0400
Received: (qmail invoked by alias); 06 Apr 2009 10:03:07 -0000
Received: from i59F56377.versanet.de (EHLO atjola.local) [89.245.99.119]
  by mail.gmx.net (mp006) with SMTP; 06 Apr 2009 12:03:07 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+suGM4NmusiPHN4/4uMAkAPUH3bDxQ9ENCxsN9iQ
	yrFXJqndj15vn2
Content-Disposition: inline
In-Reply-To: <3f4fd2640904060042m438a3a8en2d2746a6216b2b95@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115804>

On 2009.04.06 08:42:16 +0100, Reece Dunn wrote:
> 2009/4/6 Junio C Hamano <gitster@pobox.com>:
> > Reece Dunn <msclrhd@googlemail.com> writes:
> >
> >> diff --git a/git-pull.sh b/git-pull.sh
> >> index 8a26763..00a72dd 100755
> >> --- a/git-pull.sh
> >> +++ b/git-pull.sh
> >> @@ -97,6 +97,10 @@ error_on_no_merge_candidates () {
> >> =A0 =A0 =A0 echo "try again (e.g. 'git pull <repository> <refspec>=
')."
> >> =A0 =A0 =A0 echo "See git-pull(1) for details on the refspec."
> >> =A0 =A0 =A0 echo
> >> + =A0 =A0 echo "You may not be on a branch. In this case, you need=
 to move"
> >> + =A0 =A0 echo "onto the branch you want to pull to (usually maste=
r):"
> >> + =A0 =A0 echo " =A0 =A0git checkout <branch>"
> >> + =A0 =A0 echo
> >
> > I do not think that is necessarily what the user wanted to hear. =A0=
Often I
> > create trial merges on a detached HEAD when I hear a pull-request f=
rom
> > others (I have a few work trees that share the repository with my p=
rimary
> > working area, made with contrib/workdir/git-new-workdir script, and=
 their
> > HEAD are typically detached at the tip of the master), and in such =
a use
> > case, the first line of the instruction in the context in your patc=
h is
> > the right thing to give. =A0I do not want to have the resulting tri=
al merge
> > anywhere on my real branches, and do not want to be told to switch =
to any
> > of them.
> >
> > We really should teach people, especially the new ones early on, th=
at "git
> > push" and "git pull" are meant to be told where-to/from and what, a=
nd how
> > to drive these commands with explicit arguments, before letting the=
m rely
> > on the default configuration blindly without understanding the unde=
rlying
> > concepts.
>=20
> Ok, so how about something like:
>=20
> "You may not be on a branch. Because of this, you need to specify

This should not say "may", either you are or you are not on a detached
HEAD, and git can tell that, so it should not let the user have to
guess.

> where you are pulling from and to. See git-pull(1) for how to do this=
=2E
> Alternatively, you can move to a named branch using:
>     git checkout <branch>"

Checking out a named branch won't solve the "problem" on its own.
Consider this:

git checkout origin/foo
   *do stuff*

git pull
   *Oh! I need a named branch*

git checkout -b foo
git pull
   *Still fails*

Maybe:
You asked me to pull without telling me which branch you want to merge
with and as you have no branch checked out, I cannot look for any
defaults to use. Please name which branch you want to merge on the
command line and try again (e.g. 'git pull <repository> <refspec>'). Se=
e
git-pull(1) for details on the refspec.


That just adjusts the "you can set some defaults" part, replacing it
with a message telling that a detached HEAD cannot have any defaults.
Without implying anything about how the user might want to work, but
giving a hint that a branch can have defaults for "git pull".

Bj=F6rn
