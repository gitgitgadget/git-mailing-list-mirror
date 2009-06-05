From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] daemon: Skip unknown "extra arg" information
Date: Fri, 5 Jun 2009 17:16:27 +0400
Message-ID: <20090605171627.d92f6060.vsu@altlinux.ru>
References: <20090604220824.GT3355@spearce.org>
	<7vbpp3tsg0.fsf@alter.siamese.dyndns.org>
	<20090605013332.GV3355@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__5_Jun_2009_17_16_27_+0400_BiV5RDQn+GDHbMAq"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 15:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCZa8-0006XK-R2
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 15:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbZFENf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbZFENf0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 09:35:26 -0400
Received: from mivlgu.ru ([195.20.195.134]:50142 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbZFENfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 09:35:25 -0400
X-Greylist: delayed 1131 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2009 09:35:25 EDT
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id D7C13804C; Fri,  5 Jun 2009 17:16:30 +0400 (MSD)
In-Reply-To: <20090605013332.GV3355@spearce.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.1; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120773>

--Signature=_Fri__5_Jun_2009_17_16_27_+0400_BiV5RDQn+GDHbMAq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2009 18:33:32 -0700 Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >=20
> > > If we don't recognize an extra arg supplied hidden behind the
> > > command, we should skip it and look at the next extra arg, in
> > > case we recognize the next one.
> > >
> > > For example, we currently don't recognize the "user=3D" extra arg,
> > > but we should still be able to start this connection anyway:
> >=20
> > I do not necessarily agree 100% with that argument.
>=20
> Actually, we're already f'kd.  We can't change the protocol like
> we had hoped.

There is always a place for another ugly workaround :)

Add an extra \0 before additional parameters:

  "\0host=3Dexample.com\0\0param1=3Dvalue1\0param2=3Dvalue2\0"

(the buggy loop will still terminate on double \0, and maybe the code
we will add to parse the rest of data will work correctly).

This will be enough for optional parameters (when the old server may
silently ignore them without breaking the protocol).  For mandatory
parameters a change in the preceding "git-upload-pack" part will be
necessary (like the "git://v2" suggestion).

--Signature=_Fri__5_Jun_2009_17_16_27_+0400_BiV5RDQn+GDHbMAq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkopGq4ACgkQW82GfkQfsqL2DwCdH0O64KXxmRZHVqwg7C8uS5DO
IgEAnjmfGDIwbW40YrqJHrA9cq5Z+m47
=wljd
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Jun_2009_17_16_27_+0400_BiV5RDQn+GDHbMAq--
