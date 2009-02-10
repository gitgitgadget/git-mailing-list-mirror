From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-svn: incomplete data after terminated "git svn clone"
Date: Tue, 10 Feb 2009 14:42:29 +0100
Message-ID: <200902101442.32772.trast@student.ethz.ch>
References: <40aa078e0902100350m2d885516o853b1ec56eb43ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4720532.PfGztQermW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsuF-0000ww-6p
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZBJNml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZBJNml
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:42:41 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:51982 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755549AbZBJNmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:42:40 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 14:42:38 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 14:42:38 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <40aa078e0902100350m2d885516o853b1ec56eb43ce1@mail.gmail.com>
X-OriginalArrivalTime: 10 Feb 2009 13:42:38.0181 (UTC) FILETIME=[6FF1F950:01C98B85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109239>

--nextPart4720532.PfGztQermW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Erik Faye-Lund wrote:
> I recently tried to clone an existing (very big) SVN repo by using
> "git svn clone <repo> -s", and by mistake I pressed Ctrl-C after the
> clone operation had been running for ~16 hours. When trying to
> re-issue the clone, I got the error message "Incomplete data: Delta
> source ended unexpectedly at /home/erifay01/libexec/git-core/git-svn
> line 4249" after git-svn fetching another 8 or so revisions. Now, I
> realize I shouldn't have done this, but I'd still prefer avoiding to
> have to re-do it all.
[...]
> Now, I'm wondering if there's any way of going back to the state
> before I pressed Ctrl-C, so I can rebuild from there. I know what
> revision I terminated at, and I have the corresponding SHA.

Some ideas:

=46irst you can try to reset the git-svn head to the SHA of the commit
before (in case the one it stopped at ended up being corrupted).  For
example, if $stopped is the commit you interrupted it at,

  git update-ref refs/remotes/git-svn $stopped^

Adjust the ref name if you used a trunk/branches layout.  Then remove
the .git/svn/ cache and try again.

=46ailing that, you could test if this also happens when only looking at
a few surrounding revisions, for example if the failure was around
revision 100:

  mkdir ../new-test
  cd ../new-test
  git svn init <args you gave to the other git svn init/clone>
  git svn fetch -r 95:105

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart4720532.PfGztQermW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmRhEgACgkQqUud07tmzP1ypACfY0SizloFPlp4pWd1BRCol4RF
g2cAn1bEvLxnKmBtkkJrPgpkL0xO5YhV
=k9DG
-----END PGP SIGNATURE-----

--nextPart4720532.PfGztQermW--
