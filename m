From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Workflow question: A case for git-rebase?
Date: Thu, 9 Aug 2007 22:30:56 +0200
Message-ID: <20070809203056.GB4567@efreet.light.src>
References: <18071eea0708081411p41eaa44ai105adaef0e4b10a5@mail.gmail.com> <Pine.LNX.4.64.0708082246370.21857@racer.site> <18071eea0708081456l2ff1b73dy90ef33c1b5058c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJEfW-0005UY-8M
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 22:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbXHIUbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 16:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755626AbXHIUbG
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 16:31:06 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:38202 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653AbXHIUbD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 16:31:03 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 116DE5738F;
	Thu,  9 Aug 2007 22:31:02 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id w3D71oN-sW32; Thu,  9 Aug 2007 22:30:59 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A25BE57380;
	Thu,  9 Aug 2007 22:30:58 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IJEem-00036U-1x; Thu, 09 Aug 2007 22:30:56 +0200
Content-Disposition: inline
In-Reply-To: <18071eea0708081456l2ff1b73dy90ef33c1b5058c77@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55470>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2007 at 22:56:33 +0100, Thomas Adam wrote:
> On 08/08/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 8 Aug 2007, Thomas Adam wrote:
> >
> > > As for myself, I maintain _locally_ a few branches (branchX, branchY)
> > > which dictate some bits and pieces I'm working on.  Periodically, I
> > > will tend to merge either merge to master and then push those changes
> > > out.  So far so good...
> > >
> > > But, I've now come up against a case whereby if one of my colleagues
> > > changes a file (call it fileA) in branch master, and, in the course of
> > > my working in branchX means i modify fileA also, when I come to merge
> > > branchX into master I find the original change in master (as submitted
> > > by my colleague) being reverted by my changes in branchX.
> >
> > I have a hard time seeing that.  If you touch the same code,
> > unidentically, merge-recursive will not be nice to you: it will show
> > conflicts, and you have to resolve them.
> >
> > Or do you use "-s ours"?
>=20
> No, nothing like that.  I have had a situation where by a merge from
> branchX to master has resulted in master's changes to fileA being
> reverted based on what was in the contents of fileA in branchX -- this
> is of course wrong though -- master hsa the most recent copy.  My
> solution therefore was to cherry pick the commit into branchX and
> remerge into master.  This is why I was forced to ask about whether or
> not git-rebase was the correct way to go.

Git rebase is a correct way to go, with advantage of resulting in simpler
history and disadvantage of slightly harder conflict resolution (since you
merge commit-at-a-time rather than in one big block). However merge is
equally correct way to go.

Either there is a bug in merge -- which I would consider rather unlikely,
though not impossible -- or you actually did, probably unintentionally, undo
the master's changes. This might happen if:

 - You try to merge, either in --no-commit mode, or have a conflict, so it's
   not commited.
 - Then decide you don't want to resolve now and undo the
   changes by checking out the files, but don't clean the information about
   merge in progress.
 - Commit some changes in such state. This records a merge, that revers all
   changes from master.

Similarly attempt to merge just part of files would result in a problem like
you describe -- merging is only supported on whole trees.

> Although I suppose this leads me to the ancillory question of:  At the
> point I merged master into branchX did this cause any problems for any
> future merges of branchX into master?   I cannot recall if this
> "revert scenario" I describe to master happened pre or past my merge
> of master into branchX, but I suspect it was after I had merged master
> into branchX.

Merge is completely symetrical operation in git. Merging branchX into master
and merging master into branchX is the same for all purposes whatsoever
(though you can tell how you did it by order of the parsent in the commit
objecT).

Repeated merges between two branches are allowed and always correct thing t=
o do.
However, you should be aware, that attempt to reject a change will be
recorded as a reversal and merged as such. You can try visualizing the
situation before the merge with:
  gitk master-before-merge...branchX-before-merge
  (or equivalently: gitk merge-result^...merge-result^2)
print the base revision with:
  git merge-base master-before-merge...branchX-before-merge
  (or equivalently: git merge-base merge-result^...merge-result^2)
look it up the graph and contemplate at what could have caused the reversal.
I expect you can't disclose the code to ask anybody help you with that.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGu3l/Rel1vVwhjGURAmQVAJ443DH/HGxc5stZikw2aYGSNkdLcACghgm0
wAufy4ntGNtYFWZ8+z7Aq7Q=
=M5EQ
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
