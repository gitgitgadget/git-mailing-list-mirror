From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 09:33:16 +0100
Message-ID: <20080130083315.GB8698@artemis.madism.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VrqPEDrXMn8OVzN4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 09:33:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK8OE-00075i-Iw
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 09:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbYA3IdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 03:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYA3IdT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 03:33:19 -0500
Received: from pan.madism.org ([88.191.52.104]:48963 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbYA3IdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 03:33:18 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 29AEB31317;
	Wed, 30 Jan 2008 09:33:16 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 296F743D673; Wed, 30 Jan 2008 09:33:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080130042201.GO24004@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72052>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2008 at 04:22:01AM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > On Tue, Jan 29, 2008 at 04:10:00AM +0000, Shawn O. Pearce wrote:
> > > * PGP public key storage:
> > >=20
> > >   Use a "hidden" ref called "refs/access-keys" to store a commit.
> > >   The access control change log is a normal Git commit chain.
> >=20
> >   This won't work well, because I don't think GnuPG is able to check
> > some signature against an armored GPG public Key (at least I didn't
> > found a way to do that). You have to create one pubring per submitter,
> > wich is kind of a waste in fact, and the format is horribly binary.
>=20
> Gaaah.
>=20
> I hate tools that build their own little internal databases of
> objects, and don't let you store their data in other random places,
> like in any random file format you choose[*1*].  ;-)

  [for the record I got the joke].

> I just read the GnuPG manual and you are obviously correct.  The only
> way to get GnuPG to process a key is to load it onto a keyring.
> We could extract the armored (or binary) public key and load it
> onto a temporary keyring created just for the purpose of verifying
> this connection, but that's rather messy.

  That was my point.

> >   I don't even know if you really need the versionning of this
> > pseudo-keyring, and if a .git/keyring.gpg isn't enough.
>=20
> Well, I don't know about that.
>=20
> People come and go on a project.  It would be nice if there was
> a reasonably trusted store available as part of the project, that
> one can verify using a current trusted project member's public key,
> and obtain prior project member's public keys out of.  But maybe the
> Debian folks just doesn't worry about this as it isn't a real issue.

  It is, we have since recently the princple of "Debian Maintainers",
people that are only allowed to upload their own package, and the
keyring used for that purpose is versionned using a custom development
of ours called jetring (by Joey Hess and al.), I suppose the sources are
somewhere around, and it has an internal ascii-armored database IIRC
_and_ a gpg-usable keyring, I think. Or is able to generate the keyring
at least.

  But for the case I discussed, indeed, I'd use
/usr/share/keyrings/debian-keyring.gpg anyways, and won't be the one
updating it. That's why your developpement should be able to allow
checking against another keyring. IOW I'm less and less sure that you
want to manage the keyring _necessarily_ inside the git tree, and that
allowing any external way to manage a keyring (inside a git tree beeing
one of the options) is the most flexible way.

> >   As a side note, you don't really need to use GIT_PUSH_*. It doesn't
> > make anything safer (as the UIDs of a given public key are public
> > information anyways), you just want to know which key signed that data,
> > and the signature holds that information. Hence if you still want to
> > have a flat-file based keyring (which I repeat I don't think gpg
> > supports directly -- and that's really a shame) you'd better index them
> > per key fingerprint than by author name.
>=20
> Yea, I know, you haven't told me anything I didn't already know.
>=20
> Having GIT_PUSHER_{NAME,EMAIL} makes it easier for a hook to
> obtain information about this person and use it in an automated
> email message.  Think a post-receive hook that automatically sends
> out announcement emails.

  okay, that makes sense. Sorry about the obvious parts, it sensed like
you didn't used gpg on a regular basis, hence wasn't sure of what you
already knew or not. I agree that for the sake of logging GIT_PUSHER_*
are nice, since as you can see on the CLI examples I gave, gpg says that
the email associated to my key is pierre.habouzit@polytechnique.edu
whereas I ususally contribute to open source projects using
madcoder@debian.org ;)

> Yes, I know the key ids are unique enough for our needs.  But dammit,
> they just aren't friendly to work with when you are storing log
> records for later inspection, or maintaing an access list.

  Well, I know my gpg key ID, but I'm biased for sure ;)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHoDZLvGr7W6HudhwRArPlAJ97LIB4SpNlSBfo+G9vB3cVOHlErgCcCUue
XBXsedVpbFnW7jZfH9IJ8PA=
=AJeQ
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
