From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: RE: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 5 Sep 2013 23:04:02 +0200
Message-ID: <20130905210402.GA2939@sandbox-ub>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
 <522827CE.5040303@viscovery.net>
 <F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
 <5228476A.2070505@viscovery.net>
 <F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@gmail.com>
To: =?iso-8859-1?Q?J=F8rgen?= Edelbo <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 23:04:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHgiy-00041G-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 23:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab3IEVEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 17:04:15 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:46529 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab3IEVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 17:04:10 -0400
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VHgil-0005xe-3H; Thu, 05 Sep 2013 23:04:07 +0200
Content-Disposition: inline
In-Reply-To: <F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233992>

On Thu, Sep 05, 2013 at 09:18:25AM +0000, J=F8rgen Edelbo wrote:
> > -----Original Message-----
> > From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> > Sent: 5. september 2013 10:57
> >=20
> > Please do not top-post.
> >=20
> > Am 9/5/2013 10:29, schrieb J=F8rgen Edelbo:
> > > -----Original Message----- From: Johannes Sixt
> > >> Am 9/2/2013 10:54, schrieb Joergen Edelbo:
> > >>> Changes done:
> > >>>
> > >>> Remove selection of branches to push - push always HEAD. This c=
an be
> > >>> justified by the fact that this far the most common thing to do=
=2E
> > >>
> > >> What are your plans to support a topic-based workflow? "Far the =
most
> > >> common thing to happen" is that someone forgets to push complete=
d
> > >> topics. With this change, aren't those people forced to relingui=
sh
> > >> their current work because they have to checkout the completed t=
opics
> > >> to push them?
> > >
> > > I am not quite sure what your concern is.
> >=20
> > When I have completed topics A and B, but forgot to push them, and =
now I
> > am working on topic C, how do I push topics A and B?
> >=20
> > You say I can only push HEAD. I understand this that I have to stop=
 work on C
> > (perhaps commit or stash any unfinished work), then checkout A, pus=
h it,
> > checkout B, push it, checkout C and unstash the unfinished work. If=
 my
> > understanding is correct, the new restriction is a no-go.
>=20
> Ok, this way of working is not supported. It just never occurred to m=
e that
> you would work this way. Forgetting to push something that you have j=
ust=20
> completed is very far from what I am used to. I think it comes most n=
atural
> to push what you have done before changing topic. The reason I make a=
 commit
> is to get it out of the door.

=46WIW, I also think that we should keep the box which allows you to
select the branch to push. I did not realize that you were removing it
when I first glanced at your patch.

Even if your reasoning that pushing the currently checked out branch is
correct: This box has been around for too long, so it will annoy people
that got used to the fact that they can select the branch to push.

Another problem: It is not very intuitive to only select the branch to
push to. You can do that on the command line but IMO using

	git push origin HEAD:refs/heads/<branchname>

is way less common than

	git push origin <branchname>

and I think that should also be reflected in the gui. It might be more
common for a gerrit user but for the typical git user without gerrit it
is not.

So to make it easy for the user to transition from gui to commandline
and back with your patch I would expect: The user selects a branch
to push. The new "Destination Branches" section automatically selects/s=
hows
the same name for the default case as destination (like the cli). So
if I only select the branch to push it behaves the same as before.

If you detect (I assume that is possible somehow) that the remote is a
gerrit remote: "Push for Gerrit review" would automatically be ticked a=
nd
the branch a git pull would merge (e.g. the one from branch.<name>.merg=
e)
is selected as the destination branch under refs/for/... . If there is
no config for that, fallback to "master".

This is what I would expect with no further extension of the current gi=
t
command line behavior and config options. So that way your patch will b=
e
an *extension* and not a change of behavior.

Another unrelated thing that is currently left out: You can transport
the local branchname when pushing to the magical gerrit refs/for/... . =
I
would like to see that appended as well. But opposed to the branch
selection that is not a show stopper for the patch more a side note.

Cheers Heiko
