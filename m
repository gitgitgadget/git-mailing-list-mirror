From: Joey Hess <joey@kitenet.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:24:00 -0500
Message-ID: <20081120192400.GB25604@kodama.kitenet.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <alpine.LNX.1.00.0811201223300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 20:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3F9X-00018K-NC
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 20:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbYKTTYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYKTTYF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 14:24:05 -0500
Received: from wren.kitenet.net ([80.68.85.49]:35393 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbYKTTYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 14:24:04 -0500
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id A864731436A
	for <git@vger.kernel.org>; Thu, 20 Nov 2008 14:24:01 -0500 (EST)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 71B879C073; Thu, 20 Nov 2008 14:24:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0811201223300.19665@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 04:04:07 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101469>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2008, Roger Leigh wrote:
> Except in this case I'm storing the content of *tarballs* (along with
> pristine-tar).  I'm committing exactly what's in the tarball with
> no changes (this is a requirement).  I can't change the source prior
> to commit.

Note that pristine-tar will work no matter what the mtimes or other file
metadata are, none of that affects generation of deltas or regeneration
of tarballs from them.

Also, the source you commit does not really have to be identical to
what's in the tarball. (Despite what it may say in the man page. ;-)
A larger delta will be generated if something is different.

So, three possible approaches:

1. Run make or whatever you need to do before running pristine-tar,
   and put up with a larger delta.

2. Before building, you could use pristine-tar to extract the original
   tarball, and then have a program examine that tarball, and reset the
   mtimes in your build tree to match the mtimes of files in it.
   (Or you could duplicate the info with metastore -m, which could be
   restored quicker.)

3. Store uncompressed tarballs in git, so that they will pack
   efficiently, and use pristine-gz to regenerate the pristine .tar.gz.
   Only mentioned because this could be more space efficient than option
   #1, if the pristine-tar deltas get too large.

--=20
see shy jo

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJJblHd8HHehbQuO8RAnqgAKCmCyB4Tgw9uwbDxSwWa1KsoESeKgCffIIY
1dhmgLDGUFxwwSHEhzVs2kE=
=MjqB
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
