From: tboegi@web.de
Subject: [PATCH v6 04/10] convert.c: ident + core.autocrlf didn't work
Date: Fri, 22 Apr 2016 16:53:49 +0200
Message-ID: <1461336829-5146-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:50:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcP9-0003Or-J0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbcDVOtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:49:46 -0400
Received: from mout.web.de ([212.227.17.11]:62645 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbcDVOtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:41 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LwHxK-1bnJXA3r9K-01869L; Fri, 22 Apr 2016 16:49:38
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:GMevf7z+66L3TVRAU51c8Xic2wtGfnhOBuHZ4BoaMAK1yyl0S3t
 0O/w3PL++4MfPEdUXx9BYhS/n0u1E/q/zSOlRczICI5mGju8fyT5+1mCZ42ptRu0cJWtUEr
 vTU6ZMYZR0dBizbu/FEawteIVJTbWFWU6ODXyDtgGNhJWryNPbWomuZeZMmoLGPZf2R+dDH
 d9EOwOPbsSy8Pxt+G2gHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W518LklNNcU=:r6CDpLTwvH09KUDrY1xRdc
 ETc/fQ9eAGZaegihS/DMdqYa1zFzAe8Lup5OiCwoT8O7FVLITP+xw4YGIpESWpNxbBCA4x/jt
 LwEK78KFPqZ+0Mw0I0ddYG2k8NmbJiWlKcWyA6kqfPLN2Fn48JcMchiriVIEknd57+s6T4Do1
 6Ct513bXZAm/Y7o2fIoDY+JrRNKetd18ufhcY6tOJbgRX475RwWSrjWYPx8+C9gFeh8sq0OuE
 pu5znVg4SD0t0JZ6lrT5pY54EvRym3w6ld7jOmsDVl8epZK7R2FqmwLTv3q7F4vKNAH2AUYVP
 Bv/eesTeu9SxUNb76cAoFNhz9xN88i2yOfSJqZdYSYSC1DsztsgnI/LhXRpSXJSIjfCAzXert
 c5dePhEkUH7sp4eHj8xR9yLkP+0u1a6NyFapdjQ5zq5hEiP6Ww6yJHpRPdjFJfF4XcBC7S1jt
 qD1oH9rgA6X1+ZnJ+Sjx2cIVkLcoZ+WJjawS2vKFx08iHax6d9zxaLycoQf7h/VCKP8jYnwVJ
 0dy+CAgp1Q2JgfoThAjBdNK5I1KwT18ogy/C8B7Q+92WjJUXW9wdTZzVehH8hAtXuRCmXqSA7
 AZgNwLahmPtwlctEnHNxXt1xA9mXPgfNMTsWgWJu24koi901arCRlhUV0oBLa8f+6/kkOFm+H
 7h7ZKi/MP13MZMJ3HmyhAqxseMJPsZkr1ez/VAt/V+DRiGtnSFh5wOr3zHpJUxoXZ6kkjzDUd
 aUrvM3Ao8heh6qZyJ16Lbf6XDaHEBijiCl7+QqDUYAaA67gg27vzCjLSkker5A47S10UBmYd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292213>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When the ident attributes is set, get_stream_filter() did not obey
core.autocrlf=3Dtrue, and the file was checked out with LF.

Change the rule when a streaming filter can be used:
- if an external filter is specified, don't use a stream filter.
- if the worktree eol is CRLF and "auto" is active, don't use a stream =
filter.
- Otherwise the stream filter can be used.

Add test cases in t0027.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c            | 19 +++++++------------
 t/t0027-auto-crlf.sh |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index f524b8d..b1614bf 100644
--- a/convert.c
+++ b/convert.c
@@ -1380,27 +1380,22 @@ static struct stream_filter *ident_filter(const=
 unsigned char *sha1)
 struct stream_filter *get_stream_filter(const char *path, const unsign=
ed char *sha1)
 {
 	struct conv_attrs ca;
-	enum crlf_action crlf_action;
 	struct stream_filter *filter =3D NULL;
=20
 	convert_attrs(&ca, path);
-
 	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
-		return filter;
+		return NULL;
+
+	if (ca.crlf_action =3D=3D CRLF_AUTO || ca.crlf_action =3D=3D CRLF_AUT=
O_CRLF)
+		return NULL;
=20
 	if (ca.ident)
 		filter =3D ident_filter(sha1);
=20
-	crlf_action =3D ca.crlf_action;
-
-	if ((crlf_action =3D=3D CRLF_BINARY) ||
-			crlf_action =3D=3D CRLF_AUTO_INPUT ||
-			(crlf_action =3D=3D CRLF_TEXT_INPUT))
-		filter =3D cascade_filter(filter, &null_filter_singleton);
-
-	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
-		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_CRLF=
))
+	if (output_eol(ca.crlf_action) =3D=3D EOL_CRLF)
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
+	else
+		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
 	return filter;
 }
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index fd5e326..9372589 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -493,7 +493,7 @@ fi
 export CRLF_MIX_LF_CR MIX NL
=20
 # Same handling with and without ident
-for id in ""
+for id in "" ident
 do
 	for ceol in lf crlf native
 	do
--=20
2.8.0.rc2.2.g1a4d45a.dirty
