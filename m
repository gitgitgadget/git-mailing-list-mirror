From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 20:43:00 +0200
Message-ID: <20080713184300.GF10347@genesis.frugalware.org>
References: <loom.20080713T073129-112@post.gmane.org> <20080713124100.GB10347@genesis.frugalware.org> <20080713174659.GE10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCGU/3tJP9FZjbY4"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Hvammen Johansen <hvammen+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI6YD-0002RK-UB
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbYGMSnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 14:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbYGMSnE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:43:04 -0400
Received: from virgo.iok.hu ([193.202.89.103]:56679 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbYGMSnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:43:03 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E34541B251E;
	Sun, 13 Jul 2008 20:43:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3CAAA4465E;
	Sun, 13 Jul 2008 20:07:15 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9531E11901B3; Sun, 13 Jul 2008 20:43:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080713174659.GE10347@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88323>


--KCGU/3tJP9FZjbY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2008 at 07:46:59PM +0200, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> So far what I see is that the input for the reduce_heads() function is
> (c1, c0, c2, c0, c1). The expected output would be (c1, c2), but the
> actual output is c2. So I suspect the bug is not in builtin-merge.c
> itself but in reduce_heads().

This fixes the problem for me. Junio, does the fix looks correct to you
as well?

Thanks.

diff --git a/commit.c b/commit.c
index d20b14e..03e73f3 100644
--- a/commit.c
+++ b/commit.c
@@ -747,7 +747,7 @@ struct commit_list *reduce_heads(struct commit_list *he=
ads)
=20
 		num_other =3D 0;
 		for (q =3D heads; q; q =3D q->next) {
-			if (p =3D=3D q)
+			if (p->item =3D=3D q->item)
 				continue;
 			other[num_other++] =3D q->item;
 		}

--KCGU/3tJP9FZjbY4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh6TLQACgkQe81tAgORUJaeJQCfYkv2dTxItGWDbMqjizJK0Mai
vZEAnRnCQw/pQy7p/CmtKfVXu1eO9pK+
=64FU
-----END PGP SIGNATURE-----

--KCGU/3tJP9FZjbY4--
