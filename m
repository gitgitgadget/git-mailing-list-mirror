From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix memory leak in apply_filter.
Date: Fri, 05 Oct 2007 10:27:11 +0200
Message-ID: <20071005082711.GF19879@artemis.corp>
References: <87wsu2sad0.fsf@gollum.intra.norang.ca> <20071005082026.GE19879@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a1QUDc0q7S3U7/Jg";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdiWo-00015i-Af
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbXJEI1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbXJEI1O
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:27:14 -0400
Received: from pan.madism.org ([88.191.52.104]:40399 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbXJEI1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:27:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4DE2315E;
	Fri,  5 Oct 2007 10:27:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E3E3F3D84; Fri,  5 Oct 2007 10:27:11 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071005082026.GE19879@artemis.corp>
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60048>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

While we're at it... Here is a stupid memory leak in apply_filter.
On top of the previous commit.

 convert.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 4664197..d5c197f 100644
--- a/convert.c
+++ b/convert.c
@@ -293,10 +293,9 @@ static int apply_filter(const char *path, const char *=
src, size_t len,
 	}
=20
 	if (ret) {
-		*dst =3D nbuf;
-	} else {
-		strbuf_release(&nbuf);
+		strbuf_swap(dst, &nbuf);
 	}
+	strbuf_release(&nbuf);
 	return ret;
 }
=20
--=20
1.5.3.4.208.gdcc67-dirty

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBfVfvGr7W6HudhwRAryJAKCiUWlGYFv1jP3hYrg5GUpJZ7XMngCfZ9IU
dSUivW/FwNmF5DWtSVlfeH4=
=5uzj
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
