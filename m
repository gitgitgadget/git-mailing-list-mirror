From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 21:40:34 +0100
Message-ID: <20101110204034.GO22105@genesis.frugalware.org>
References: <20101110010016.GC22105@genesis.frugalware.org>
 <7vaalhhstp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/esV2TVMZzkOBRzt"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 21:40:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGHTF-0008Jk-SQ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0KJUkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:40:37 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47855 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab0KJUkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:40:36 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2E85B580D4;
	Wed, 10 Nov 2010 21:40:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2027144659;
	Wed, 10 Nov 2010 21:40:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D88DF132C041; Wed, 10 Nov 2010 21:40:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vaalhhstp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161184>


--/esV2TVMZzkOBRzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2010 at 11:38:58AM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Just a guess.  Does this have to do with 80dbae0 (Chose better tag names
> in git-describe after merges., 2007-01-10)?

Hmm, not sure. I tried reverting that commit, but that resulted in
conflicts - git checkout 80dbae0^ produces a git binary that can't read
the index version we have today. :)

But I think the approach to follow the first parent only would solve the
problem outlined in the commit message of 80dbae0 as well: I think it's
pretty rare to tag a commit in a feature branch, then merge it.

I mean the trivial proof of concenpt below finds the right tag here:

$ ~/git/git/git describe
1.4pre1-572-g42b497b

Even if it does not count all the commits since that tag:

$ git rev-list 1.4pre1..|wc -l
883

Thanks.

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..f32eaf4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -303,6 +303,7 @@ static void describe(const char *arg, int last_one)
 				insert_by_date(p, &list);
 			p->object.flags |=3D c->object.flags;
 			parents =3D parents->next;
+			break;
 		}
 	}
=20

--/esV2TVMZzkOBRzt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzbA0IACgkQe81tAgORUJZoUwCcCMyHs4LhyvMfo3P9plyOu076
c3gAn1mWbPX0wkBECqBL9y9InmqFLDb7
=Dhyi
-----END PGP SIGNATURE-----

--/esV2TVMZzkOBRzt--
