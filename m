From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 12:01:20 +0100
Message-ID: <20081101110120.GA3819@artemis.corp>
References: <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101001300.GE14786@spearce.org> <alpine.LFD.2.00.0810312106310.13034@xanadu.home> <20081101011910.GH14786@spearce.org> <alpine.LFD.2.00.0810312135190.13034@xanadu.home> <20081101015217.GJ14786@spearce.org> <alpine.DEB.1.00.0811010320370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oyUTqETQ0mS9luUI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:02:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEFf-0005cS-P0
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbYKALB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYKALB1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:01:27 -0400
Received: from pan.madism.org ([88.191.52.104]:44209 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYKALBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:01:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 12F903AA15;
	Sat,  1 Nov 2008 12:01:22 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B12425EE243; Sat,  1 Nov 2008 12:01:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811010320370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99729>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 02:26:45AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>=20
> > Nicolas Pitre <nico@cam.org> wrote:
> > > On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
> > >=20
> > > > > Both the negative code and errno style are lightweight in the=20
> > > > > common "no error" case.  The errno style is probably more handy=
=20
> > > > > for those functions returning a pointer which should be NULL in=
=20
> > > > > the error case.
>=20
> Unfortunately, errno would not be thread-safe, unless you can guarantee=
=20
> that errno is a thread-local variable.

Well, TLS afaict is implemented on arches that have GNU ld, or on win32
with a recent enough mingw. Though this is quite a requirement.

> > Oh, good point.  We could also stagger the errors so they are
> > always odd, and never return an odd-alignment pointer from a
> > successful function.  Thus IS_ERR can be written as:
> >=20
> >   #define IS_ERR(ptr) (((intptr_t)(ptr)) & 1)
> >=20
> > which is quite cheap, and given the (probably required anyway)
> > aligned allocation policy means we still have 2^31 possible
> > error codes available.
>=20
> Oh boy, both solutions are ugly as hell.  Although the &1 method does not=
=20
> limit the memory space as much (except if you plan to work in=20
> space-contrained environments, where you do not want to be forced to=20
> word-align structs).
>=20
> The only pointer game I would remotely consider clean is if you had
>=20
> 	const char *errors[] =3D {
> 		...
> 	};
>=20
> 	inline int is_error(void *ptr) {
> 		return ptr >=3D errors && ptr < errors + ARRAY_SIZE(errors);
> 	}

Well, you can't return _sanely_ an error through a pointer. The &1
method is broken as soon as you return a char* (there is an alignment
requirement for malloc, not for any pointer out there), hence shall not
be used, as it would not be the sole way to test for error.

Another option, that is _theorically_ not portable, but is ttbomk on all
the platforms we intend to support (IOW POSIX-ish and windows), is to
use "small" values of the pointers for errors. [NULL .. (void *)(PAGE_SIZE =
- 1)[
cannot exist, which gives us probably always 512 different errors, and
the test is ((uintptr_t)ptr < (PAGE_SIZE)) which is cheap. It's butt
ugly, but encoding errors into pointers is butt ugly in the first place.


Another option that is what I would prefer, would be for the use of
errno where it makes sense. E.g. if you want a function that fetches an
object, this is somehow what read(3) would look like on our store, more
or less, and errno's are enough.  For the other functions where errno
cannot be used, I'm pretty sure we will always pass a handle to some
kind of libgit2 stuff, like the "repository" we're working on. The
_easiest_ way is to put the "last error" into that structure and use
that. I mean, if we want libgit2 to be useful for _everyone_ we *WILL*
have to pass a repository context around. I see almost no way around it.
And there, NULL means error, and if you want to know about the specific
error, git_repo_errno(&ctx) / git_repo_strerr(&ctx) is just easy.

Note: What is important is to be able to check for errors _fast_, I
don't think printing out the error and knowing which error it was would
be in the fast path, so it's less useful to have this information
immediately.


_My_ taste (but again, like the _t I would use what is there, and won't
make a fuss about it at all) is to see function return -1 or NULL for
errors, and "abuse" errno for system-like functions, or put the last
error into the context on which you're working (your "this" more or
less). We don't need a specific error context at all, because we already
have a repository context available.

I'm not really a fan of pointer semantics abuse (it's sometimes useful,
but as the public interface of a library, this is butt-ugly.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMNv8ACgkQvGr7W6HudhzOiQCgpVQJ2WdNZ1+RUoZEZ2r1eOOM
JF4AoIJybFXMAXcbces8iKDhlYEWsCPe
=qZHi
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
