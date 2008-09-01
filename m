From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/2] 'git svn info' fixes
Date: Mon, 1 Sep 2008 11:46:42 +0200
Message-ID: <200809011146.44909.trast@student.ethz.ch>
References: <20080829081654.GA6680@yp-box.dyndns.org> <1220017369-32637-1-git-send-email-trast@student.ethz.ch> <20080830010319.GA2940@untitled>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2199554.QmBFqD5oMk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 01 11:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka60k-0001Aa-Uf
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYIAJqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYIAJqp
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:46:45 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:58663 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbYIAJqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:46:45 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 11:46:44 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 11:46:43 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080830010319.GA2940@untitled>
X-OriginalArrivalTime: 01 Sep 2008 09:46:43.0641 (UTC) FILETIME=[A4431290:01C90C17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94553>

--nextPart2199554.QmBFqD5oMk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Eric Wong wrote:
> Yes.  Please maintain compatibility with svn 1.5.  The current version
> of git-svn should strive to maintain compatibility with the current
> version of svn whenever possible.

Ok, that certainly clarifies the goal.

> > Unfortunately this does raise the question whether the URL-encoding
> > issue treated in the other series is in fact a similar incompatibility
> > between 1.4 and 1.5, not a (minor but long-standing) bug in git-svn.
>=20
> It should match svn 1.5 for "git svn info".
[...]
> 	svn log -v `git svn info --url`
> [should] just work.
>=20
> I seem to recall the rules being slightly different for http(s):// and
> (file://|svn://) URLs with the command-line client; but my memory may
> just be fuzzy...

I've finally found a system with SVN 1.4 that I have access to, and
ran a few tests.  I don't have svn:// servers with weird directory
names at hand, but I could verify that even SVN 1.4 quotes output and
requires the input to be properly quoted:

  $ svn info
  Path: .
  URL: file:///home/thomas/test%20directory%3F
  Repository Root: file:///home/thomas/test%20directory%3F
  [...]

  $ svn info file:///home/thomas/test%20directory%3F
  Path: test directory?
  URL: file:///home/thomas/test%20directory%3F
  Repository Root: file:///home/thomas/test%20directory%3F
  [...]

  $ svn info file:///home/thomas/'test directory?'
  svn: URL 'file:///home/thomas/test directory?' is not properly URI-encoded

Variations with https:// and SVN 1.5 give the same results.  So unless
I'm missing something, the two patch series are needed to get the
correct output.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart2199554.QmBFqD5oMk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki7ugQACgkQqUud07tmzP2howCeMGJjcc95ERgBR1ZlGzq4cwcN
VkAAn2d8dZ16T9FpNXDrDkbRW6YLXtXp
=5/gw
-----END PGP SIGNATURE-----

--nextPart2199554.QmBFqD5oMk--
