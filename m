From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 16:54:37 +0200
Message-ID: <20070915145437.GA12875@piper.oerlikon.madduck.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 16:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWZ2z-0004LI-JV
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264AbXIOOzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbXIOOzA
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:55:00 -0400
Received: from clegg.madduck.net ([82.197.162.59]:34852 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbXIOOy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:54:59 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 6D97BBA3A4;
	Sat, 15 Sep 2007 16:54:38 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 5A0A79F161;
	Sat, 15 Sep 2007 16:54:38 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 04152B3106; Sat, 15 Sep 2007 16:54:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709151507310.28586@racer.site>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4279/Sat Sep 15 14:53:34 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58252>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.15.16=
10 +0200]:
> No.  Git is a source code management system.  Everything else that
> you can do with it is a bonus, a second class citizen.  Should we
> really try to support your use case, we will invariably affect the
> primary use case.

I thought git was primarily a content tracker... so it all comes
down to how to define content, doesn't it? But either way, we need
not discuss that because that definition depends a lot on context
and purpose and thus cannot be answered once and for all.

I understand that for the primary use case, tracking nothing more
than +x makes sense and should not be interfered with. This is why
I was proposing a policy-based approach. The primary use case is
unaffected, it's the default policy. Someone may choose to track
other mode bits or file/inode attributes, according to one of
several policies available with git, or even a custom policy. In
that case, the repository needs to be appropriately configured.

The reason why I say this should be done inside git rather than with
hooks and an external tool, such as metastore is quite simple: git
knows about every content entity in any tree of a repo and already
has a data node for each object. Rather than introducing a parallel
object database (shadow hierarchy or single file), it would make
a lot more sense and be way more robust to attach additional
information to these object nodes, wouldn't it?

So with "appropriately configured" above, I meant that one should be
able to say

  git-config core.track all

or

  git-config core.track mode+attr

or the default:

  git-config core.track 7666
  (read that as a umask, which masks out everything but the three
  x bits. I made it 7666 instead of 7677 because core.umask and
  core.sharedrepository then override the group and world bits if
  needed)

and have git do the right thing, rather than expecting those who
want to track more than the executable bit to assemble a brittle set
of hooks and metadata collectors+applicators and hope it all works.

I understand also that this is not top priority for git, which is
why I said earlier in the thread that the real difficulty might be
to get Junio to accept a patch. But I think that the patch would be
rather contained and small, having it all configurable would make it
unintrusive, and if we all test it real well, it should pass as
a bonus. After all, git can e.g upload patches to IMAP boxes, which
in my world clearly is bonus material as well.

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"the well-bred contradict other people.
 the wise contradict themselves."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6/ItIgvIgzMMSnURAjO1AKC+NQFmeNGrrPyq7bSZzBmxAWpl6gCgy/U+
P1QBAjyUxuhDcMkItTfkLHY=
=KYRb
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
