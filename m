From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
	trees
Date: Sun, 15 Apr 2007 19:17:29 -0700
Message-ID: <20070416021729.GH2689@curie-int.orbis-terrarum.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com> <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org> <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Cc: Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 04:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdGmp-0005w3-0T
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 04:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXDPCR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 22:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbXDPCR1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 22:17:27 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:51039 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750961AbXDPCR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 22:17:26 -0400
Received: (qmail 32004 invoked from network); 16 Apr 2007 02:17:25 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 16 Apr 2007 02:17:25 +0000
Received: (qmail 26905 invoked by uid 10000); 15 Apr 2007 19:17:29 -0700
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44562>


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 15, 2007 at 01:51:42PM -0700, Linus Torvalds wrote:
> There are valid uses to tag sources with some revision information WHEN I=
T=20
> LEAVES THE REVISION CONTROLLED ENVIRONMENT, but not one second before=20
> that.
Nobody has addressed the single problem that I have with adding it when
it's leaving the environment, and that's still of paramount concern to
me. Simply put, there is a conflict between being able to add revision
information of stuff leaving the environment, and those additions
breaking previous checksums (which may be digitally signed, and thus
breaking the signatures).

I'll reduce it further from my previous example.

1. Developer commits some change to file A.
2. The checksum file is updated because A changed (the checksum file
   explicitly does not contain keywords).
3. Developer signs the checksum file, and commits it.

If during the export process (which is undertaken elsewhere, by a
different person or script), file A now has an expansion applied to it,
you break the checksum file, which you CANNOT redo, because you lose the
developer's digital signature on the checksum file!

Using the existing git-verify-tag mechanisms are not suitable, because
it is the exported information that must be verifiable.

There's FOUR possible solutions here:
1. The commit to file A does the keywords - Which Linus is against.
2. An ADDITIONAL commit to file A, after the initial commit, as a
   scripted addition of the keywords, but before the checksum is
   updated. I think this is messy myself, as you'd have to insert the
   data from the N-1 commit always.
3. Lose the ability to tag the files leaving the environment.
4. Stop digitally signing the checksum file (which then leaves the
   possibility for other attacks).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGIty5PpIsIjIzwiwRArUEAKDL6YvaHvcjhdMjMdGSJaFRAARXNQCfe/EQ
CyAn5d472QScay8gBSJNuqk=
=CusJ
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
