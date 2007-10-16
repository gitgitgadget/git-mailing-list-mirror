From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-import crashes
Date: Tue, 16 Oct 2007 09:46:45 +0200
Message-ID: <20071016074645.GA6919@artemis.corp>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com> <20071013032916.GL27899@spearce.org> <20071013033407.GM27899@spearce.org> <20071013073640.GC7110@artemis.corp> <20071013075027.GD7110@artemis.corp> <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com> <20071015073307.GA1508@artemis.corp> <e66701d40710150119y7c9e0ff6n83c5fbd25d351fc6@mail.gmail.com> <e66701d40710160013h270f685sef57f80382089f3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wac7ysb48OaltWcw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihh8l-0006yL-V7
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765181AbXJPHqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765032AbXJPHqt
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:46:49 -0400
Received: from pan.madism.org ([88.191.52.104]:35545 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763386AbXJPHqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:46:48 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D2E8325371;
	Tue, 16 Oct 2007 09:46:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A65936E8B; Tue, 16 Oct 2007 09:46:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <e66701d40710160013h270f685sef57f80382089f3c@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61106>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 07:13:31AM +0000, Shun Kei Leung wrote:
> Hi Pierre,
>=20
> I have tested with your patch applied, and it still crashed badly.

  okay

> I compiled the b449f4c version and I got a different backtrace from
> GDB. I am still not sure about how the error occurs. I attached the
> memory usage from various command line tools.

  I believe you should rather test master as any of the strbuf stages is
broken for you, and that there has been some issues with strbuf fixed
lately (not only the patch I asked you to try, but also an issue with
empty strubufs, and you _need_ that patch).

> GDB output
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Program received signal EXC_BAD_ACCESS, Could not access memory.
> Reason: KERN_INVALID_ADDRESS at address: 0x756c7463
> 0x90018d0c in szone_realloc ()
> (gdb) bt
> #0  0x90018d0c in szone_realloc ()
> #1  0x90018898 in realloc ()
> #2  0x0001f8c8 in strbuf_grow (sb=3D0x75ef8, extra=3D0) at git-compat-uti=
l.h:223
> #3  0x0001fc14 in read_line (sb=3D0x75ef8, fp=3D0xa0001b9c, term=3D10) at=
 strbuf.c:107
> #4  0x00002da8 in read_next_command () at fast-import.c:1599
> #5  0x0000742c in cmd_new_commit () at fast-import.c:2118
> #6  0x00007e80 in main (argc=3D1, argv=3D0xbffff828) at fast-import.c:2390
> (gdb) frame 3
> #3  0x0001fc14 in read_line (sb=3D0x75ef8, fp=3D0xa0001b9c, term=3D10) at=
 strbuf.c:107
> 107                     strbuf_grow(sb, 1);
> (gdb) print *sb
> $1 =3D {
>   alloc =3D 60,
>   len =3D 23,
>   eof =3D 0,
>   buf =3D 0x5020b0 "D windows/packages/cdc/ces/adm"
> }
> (gdb) frame 2
> #2  0x0001f8c8 in strbuf_grow (sb=3D0x75ef8, extra=3D0) at git-compat-uti=
l.h:223
> 223             void *ret =3D realloc(ptr, size);
> (gdb) print (char *) ptr
> $2 =3D 0x5020b0 "D windows/packages/cdc/ces/adm"
> (gdb) print (char *)ret
> $3 =3D 0xd <Address 0xd out of bounds>

  This does not make sense, ptr should be either valid or NULL.
> The output of `leaks'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Process 27075: 88 nodes malloced for 2335 KB
> Process 27075: 6 leaks for 624 total leaked bytes.
> Leak: 0x005012b0  size=3D208      string 'EOT'
> Leak: 0x00501e60  size=3D128      string 'EOT'
> Leak: 0x00501c80  size=3D128      string 'EOT'
> Leak: 0x00500f10  size=3D64       string 'EOT'
> Leak: 0x00501fa0  size=3D64       string 'EOT'
> Leak: 0x00501f60  size=3D32
>         0x00000000 0x02008000 0x00000000 0x01000000     ................
>         0x02000000 0x0000001a 0x00000000 0x00000000     ................

  What I _really_ need is that you run your test into valgrind (the easy
way is to rename git-fast-import into git-fast-import.bin, and make
git-fast-import be a shell-script doing:

  exec valgrind --log-file /tmp/git-fast-import git-fast-import "$@"

  and please send to me the /tmp/git-fast-import.<pid> from the one that
crashes.

  And please do that on the most recent tip of master so that you have a
(at least believe to be) full and sane strbuf series. Thanks.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFGxlvGr7W6HudhwRAkiBAKCnnY9VvxsuTFfM2t9anGcWLGJ+6gCgoILU
lev2jMKorvwCtTGrmWtKhDw=
=Xova
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
