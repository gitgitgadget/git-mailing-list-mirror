From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 14:06:53 +0100
Message-ID: <20091209130653.GA30218@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
 <m2pr6ocqrb.fsf@igel.home>
 <20091209120610.GA29430@atjola.homenet>
 <20091209120748.GI2977@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 14:07:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIMG0-0005XM-TZ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 14:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbZLINGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 08:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbZLINGw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 08:06:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:52576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755489AbZLINGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 08:06:51 -0500
Received: (qmail invoked by alias); 09 Dec 2009 13:06:57 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp001) with SMTP; 09 Dec 2009 14:06:57 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18+oHQuRO4+FI1B4BxPOUodLJQS/0IIr0pX9dPMpB
	iygpphiKFEFSqR
Content-Disposition: inline
In-Reply-To: <20091209120748.GI2977@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134964>

On 2009.12.09 14:07:48 +0200, Michael S. Tsirkin wrote:
> On Wed, Dec 09, 2009 at 01:06:10PM +0100, Bj=F6rn Steinbrink wrote:
> > On 2009.12.09 12:48:24 +0100, Andreas Schwab wrote:
> > > Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> > >=20
> > > > Err, no. "git merge --squash foo" merges all changes from the m=
erge base
> > > > of HEAD and foo up to foo. "git cherry-pick foo" takes just the=
 changes
> > > > from foo^ to foo. For example:
> > > >
> > > > A---B---C (master)
> > > >  \
> > > >   D---E---F (foo)
> > > >
> > > > git cherry-pick foo # Tries to create a new commit with the cha=
nges from
> > > >                     # "git diff D F"
> > >=20
> > > Did you mean "git diff E F"?
> >=20
> > Ugh, yes, of course. Thanks.
>=20
> So this will be best written as
> git cherry-pick ..foo

No, "git cherry-pick ..foo" should pick the individual commits, and not
create a single big commit like "git merge --squash". So such a command
should make you end up with:

A---B---C---D'--E'--F' (master)
         \
          D---E---F

Not:
A---B---C---M (master)
         \
          D---E---F (foo)

[M being the "sqash-merge"]

"merge --squash" is one of the things I really dislike, because it turn=
s
off the "history" part of the merge. You can say "Merging in git is abo=
ut
histories, merging in svn is about changes only" to describe the major
difference for the merge commands in the two systems... "But then
there's --squash which turns git into svn".

I think a "cherry-pick --squash <range>" command would be nicer from a
conceptual point of view, but it's way too late for merge --squash to b=
e
dropped. And I guess it wouldn't be trivial to add such a flag, and not
worth the effort, as you could as well use the interactive mode and
replace "pick" with "squash" manually. (An el cheapo implementation tha=
t
automatically replaces it would likely confuse the user, because he
asked for a single commit, but might get to fix conflicts for all the
individual commits).

Bj=F6rn
