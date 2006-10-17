From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 23:36:30 +0400
Message-ID: <20061017233630.72a0aae5.vsu@altlinux.ru>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
	<7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171437250.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__17_Oct_2006_23_36_30_+0400_OCP0V3DJL6w7lCHB"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 21:37:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZul5-0002Ok-LW
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 21:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWJQThs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWJQThs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 15:37:48 -0400
Received: from [213.177.124.23] ([213.177.124.23]:10921 "EHLO procyon.home")
	by vger.kernel.org with ESMTP id S1751194AbWJQThr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 15:37:47 -0400
Received: by procyon.home (Postfix, from userid 500)
	id 7A9794B7A3; Tue, 17 Oct 2006 23:36:33 +0400 (MSD)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29107>

--Signature=_Tue__17_Oct_2006_23_36_30_+0400_OCP0V3DJL6w7lCHB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Oct 2006 14:47:16 -0400 (EDT) Nicolas Pitre wrote:

> On Tue, 17 Oct 2006, Junio C Hamano wrote:
>=20
> > Nicolas Pitre <nico@cam.org> writes:
> >=20
> > > Could you instrument the code at the end of=20
> > > index-pack.c:parse_pack_objects() to display how many deltas were=20
> > > actually resolved and how many were not?  IOW is it a case of all or=
=20
> > > nothing, or is there an isolated case of corruption lurking somewhere?
> >=20
> > fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has
> > 18915 unresolved ref-deltas and 0 ofs-deltas among 21205
>=20
> Hmmm....  Interesting.
>=20
> Is it possible that sizeof(union delta_base) might not be equal to 20=20
> for you?

Yes, on x86_64 this is 24 because of 8-byte alignment for longs:


$ echo 'unsigned x =3D sizeof(union{unsigned char sha1[20]; long offset;});=
' | gcc -S -x c -m64 -o - - | grep long
        .long   24

$ echo 'unsigned x =3D sizeof(union{unsigned char sha1[20]; long offset;});=
' | gcc -S -x c -m32 -o - - | grep long
        .long   20


--Signature=_Tue__17_Oct_2006_23_36_30_+0400_OCP0V3DJL6w7lCHB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFNTDBW82GfkQfsqIRAi3+AKCNe0of9blBJ/bv4vt8faxbXHnDgwCghpKN
QJMqq6VjTBTkJNPAnn8jV/Q=
=eS14
-----END PGP SIGNATURE-----

--Signature=_Tue__17_Oct_2006_23_36_30_+0400_OCP0V3DJL6w7lCHB--
