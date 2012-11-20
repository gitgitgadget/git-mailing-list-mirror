From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Mon, 19 Nov 2012 20:16:28 -0500
Message-ID: <20121120011628.GD321@odin.tremily.us>
References: <20121117153007.GB7695@book.hvoigt.net>
 <20121117192026.GI22234@odin.tremily.us>
 <7vd2z9t7y2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=5p8PegU4iirBW1oA
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 02:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TacSV-0008QV-KW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 02:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab2KTBQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 20:16:49 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:14743 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab2KTBQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 20:16:48 -0500
Received: from odin.tremily.us ([unknown] [72.68.107.127])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDR00432I7GF130@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 19 Nov 2012 19:16:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 4CDD5697AEF; Mon,
 19 Nov 2012 20:16:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353374188; bh=TOwvz2GQtEt4oIInONgiTzTwiCubzvc2b7G4NjgMzUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1oOvM2yg+T+7dvHq25HbdB2qSA6mGJCFxfhJnV1os7Nu01txrS9Ge3sbWwP764zL
 XVgOCZK7eupkv/03M9YxXbJMavhaAurQhtuhTyZ1zpkQtY8tZt6YuKi5EPyaJxZ9FF
 bUc22Inu0kTHdH7zKxfQH85SXCKZ9z0aXta777zE=
Content-disposition: inline
In-reply-to: <7vd2z9t7y2.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210074>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 04:49:09PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> >> From what I have heard of projects using this: They usually still have
> >> something that records the SHA1s on a regular basis. Thinking further,
> >> why not record them in git? We could add an option to update which
> >> creates such a commit.
> >
> > I think it's best to have users craft their own commit messages
> > explaining why the branch was updated.  That said, an auto-generated
> > hint (a la "git merge") would probably be a useful extra feature.
>=20
> I am not quite sure I agree.  When the project says "Use the tip of
> 'bar' branch for the submodule 'foo'" at the top-level, does an
> individual user who is not working on the submodule 'foo' but merely
> is using it have any clue as to why the submodule's 'foo' branch
> 'foo' moved, or does he necessarily even care?

If he doesn't care, why is he updating the submodule gitlink?

> Now, since somebody created the top-level commit you have just
> pulled and checked out, other people may have worked on submodule
> 'foo' [*1*].  What should happen on "git submodule update foo"?

If the 'foo' checkout is not the one listed in the superproject's
=2Egitmodules, the update should bail with an appropriate error message,
and let the user sort things out.

  $ git submodule update --pull foo
  error: Your local changes to the following submodule would be
  overwritten by update:=E2=80=A6

This is similar to how Git currently bails on dirty-tree branch
switches:

  $ git checkout my-branch
  error: Your local changes to the following files would be
  overwritten by checkout:=E2=80=A6

Without "--pull", the update command is intended to checkout the hash
specified in .gitmodules.  If you've committed some local work in foo
and then explicitly ask for an update, I suppose you get clobbered.

> What should appear in "git diff"?  The working tree taken as a whole
> is different from what the superproject's commit describes (which is
> the state the person who created the superproject wanted to record)
> even though this user does not have anything to do with the change
> at 'foo' from the recorded commit to the current tip of 'bar'.  What
> would his description for the reason why the branch was updated?

The submodule content is not part of the superproject.  All the
superproject has is a gitlink.  If the gitlink hasn't changed, "git
diff" in the superproject shouldn't say anything.

I'll probably have time to write up v4 over the weekend.  Maybe having
a more explicit example will clear things up.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQqtnqAAoJEEUbTsx0l5OMHwwP/3eyNAAfLlhyI/Qjyc3yW3xK
V0RJOw9vDBbN8NflgZ1VYJEFECzh/Bze0+EUhm66bZR8HBgO6tzb58qnZ2jjBc3L
ZQCfxCHAmmF0le6LQSf4VQFss69b1GQaV/0jddlcp+yaE7Wiyy1r2JmcIJz3ahdf
bnnfwfzuIUno3PQL6xAs1jZJm6Y2i0A5fy9lF8Wb+igjBtl7n9ahm3xiySuB4gQq
MWPq7jlmYWVi0vAL2YPjQ7fEyW6yzLMxtbDLAvhAHWYsnVPNw3K3zdYcmT2JfOkD
egzNFhJw+nebgHWME5ILEmGap3ivsgY0ooZQ8Q9PMa6FggC/Vh4gVJ43hJXDQm3I
P+23OE/Ynd1N10+tukxME+U/9M9M8dWCmEf7s1dk76Z3Yz2GsXEatGIp1s4GoldK
4MxUrWs8881DHb4e+gkjO1ft2GN7aeDAtDYjEbBJBaJfxgxRg6RkAgc+tEiRoapJ
WltBRhBR0xXDWi8MbIAyl0cWMRK1sLkQIejaTnSRK2Calr0ev+mw8PoGckZs9nAm
0UroPjkitJdIyCt9f6Phgmx6sNi3rMY+u8hfQ8RAcn1O71eFeFc5oVhJdZ5hZULX
E2WRx9PqyXUvcQF4xSlVLZH3qSlhDJZN22tNB77JnuFuMn1b9UN71FIlVQDijw56
SaMpCOpLi6qOioaQQDnS
=HQc6
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
