From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Mon, 17 Sep 2007 15:31:05 +0200
Message-ID: <20070917133105.GA17536@lapse.madduck.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site> <20070916061411.GC24124@piper.oerlikon.madduck.net> <20070916155147.GA30476@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 18:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJmg-0002zV-5N
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXIQQtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXIQQtN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:49:13 -0400
Received: from clegg.madduck.net ([82.197.162.59]:48373 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXIQQtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:49:12 -0400
Received: from lapse.madduck.net (unknown [78.16.99.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 0FFBBBA45B;
	Mon, 17 Sep 2007 18:48:45 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id BB6A14FD43; Mon, 17 Sep 2007 15:31:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070916155147.GA30476@efreet.light.src>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4310/Mon Sep 17 14:47:06 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58462>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jan Hudec <bulb@ucw.cz> [2007.09.16.1751 +0200]:
> > If the filesystem does not support owners, chown() would not
> > exist. I actually tend to think of things the other way around:
> > instead of a fallback when chown() does not work (what would
> > such a fallback be other than not chown()ing?), it would only
> > try chown() if such functionality existed.
>=B7
> There's a problem. You need to know that the functionality is
> missing and not try to read attributes back, but instead consider
> them unchanged. Nothing that can't be taken care of, but it needs
> to be handled carefuly.

This is a good consideration. One way of implementing this seems to
be to iterate over all file attributes recorded in the object cache
(or metastore) and try to apply each. For every attribute that was
properly applied to the worktree, a note is attached to the object's
data in the index. Tools identifying differences between index and
worktree would then only pay attention to these attributes.

> But if you tar that up again, the owners will be different. But
> you don't want the change.

As per my above suggestion, this would solve itself. Untarring as
non-root simply means that the chmod/chown/whatever calls would fail
or not be tried at all. Thus, they would not be recorded in the
index and later commits would never consider changes to these
attributes.

One could probably simplify the implementation such that failure to
chmod/chown/whatever a single file would make the attribute be=20
ignored when worktree and index are compared. Then, it would all=20
boil down to a combination of configuration and functionality: the
attributes the user wants to have tracked (configuration) and those
which can be applied to the worktree when logically and'ed result in
the final mask of attributes to consider when identifying changes.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
a gourmet concerned about calories
is like a punter eyeing the clock.
=20
spamtraps: madduck.bogus@madduck.net

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7oGZIgvIgzMMSnURAi/fAJ43RdxCdhyyH3H4TjbPa1dYfm+DaQCeMHGa
cZU8f6gpS8ZeNSACmVNz9YE=
=1gU7
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
