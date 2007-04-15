From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
	trees
Date: Sun, 15 Apr 2007 02:44:38 -0700
Message-ID: <20070415094438.GD2689@curie-int.orbis-terrarum.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <Pine.LNX.4.64.0704141019290.18655@racer.site> <20070415000330.GG3778@curie-int.orbis-terrarum.net> <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz> <20070415020139.GB2689@curie-int.orbis-terrarum.net> <20070415043146.GB2229@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 11:44:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd1HX-0005o5-6J
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 11:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXDOJoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 05:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXDOJoX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 05:44:23 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:49979 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751549AbXDOJoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 05:44:22 -0400
Received: (qmail 20669 invoked from network); 15 Apr 2007 09:44:21 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 15 Apr 2007 09:44:21 +0000
Received: (qmail 30628 invoked by uid 10000); 15 Apr 2007 02:44:38 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070415043146.GB2229@spearce.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44492>


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 15, 2007 at 12:31:46AM -0400, Shawn O. Pearce wrote:
> Mail them a DVD of the Git import, have them load it locally,
> and use --reference for all future clones.  With Git its possible
> to build fast throwaway trees from any random URL, so long as you
> keep at least one repository available locally to act as a reference.
Ok, that makes it even more worthwhile for them to keep one tree
locally, I didn't think of that :-).

> > the commit is accepted. The 'update' hook documentation suggests that
> > ACLs should be possible and implemented via that.
> Yes.  I run probably the most paranoid update hook in existance.
> If you want a copy let me know, I'll send it to you.  Its a Perl
> script that verifies the 'committer ' line matches the UNIX uid (by
> doing a table lookup) for every new commit or tag being introduced
> to the repository.  It also verifies that the user can update that
> branch, create it, delete it, or rewind it.
>=20
> It sounds like you would need to add some additional rules about
> specific paths being modified only by certain people in certain
> branches (for the SELinux stuff), and running other validations in
> the documentation (whatever that is).
Yes please, it would be greatly appreciated. I'll hack path ACLs into
it, and feed it back to contrib/? (CVS and SVN ship ACL stuff in their
contrib/, so we could probably follow suite safely).

> What you could do is create a program that mangles the files before
> delivery.  You would probably want to do something like:
>=20
>   $Id: 7fbf239:path/to/file$
There's one core problem with mangled after the fact there:
It's going to break checksum/gpg verification later.
Here's the existing CVS process as a comparison.
1. Developer creates/changes foo-1.2.ebuild. (cvs add, but not cvs ci).
2. Runs the local verify+commit tool (repoman).
(these steps are done by repoman now)
3. Generates the initial Manifest (contains SHA256/MD5/RIPEMD160 etc.).
4. Commits the initial Manifest AND the files from the developer.
5. Gegenerated Manifest because of any keywords in the files.
6. Manifest is clear-signed with gpg.
7. Signed Manifest is committed.

We can't require the re-processing of the files before they can be
verified, as that removes the ability for users to easily verify them
with standard tools (md5sum,sha256sum).

The direct conversion of such a process to insert the $Id$ and then
re-commit that $Id$ runs into chicken-and-egg problems as well, so
either git needs to insert the keyword, or the file can't be changed.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGIfQGPpIsIjIzwiwRAqaJAJ9k/N89O9d3TUnuHOwk/s58LsmxtQCgyRvn
7pAukZNU+TXumwmypPVV9FU=
=naRw
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
