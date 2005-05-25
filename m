From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: [PATCH] update cogito cg-diff to use new git diff format
Date: Wed, 25 May 2005 15:38:26 -0400
Message-ID: <1117049907.11542.9.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/pgp-signature";
	boundary="=-Jg5AGqnWvBes9/c+wP1w";
	micalg=pgp-sha1
X-From: git-owner@vger.kernel.org Wed May 25 21:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1gT-0004wV-VO
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVEYTii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVEYTii
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:38:38 -0400
Received: from mail.timesys.com ([65.117.135.102]:11888 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261539AbVEYTib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:38:31 -0400
Received: from jmcmullan by owa.timesys.com; 25 May 2005 15:38:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
Date: Wed, 25 May 2005 15:32:01 -0400
Message-ID: <1117049907.11542.9.camel@jmcmullan.timesys>
X-Mailer: Evolution 2.0.4-3mdk 
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] update cogito cg-diff to use new git diff format
thread-index: AcVhYGy0lBRyABV6SLOmHRdYPJhX5g==
To: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Jg5AGqnWvBes9/c+wP1w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Updates cg-Xdiffdo to handle the new cg-diff-* output format

(Not strictly necessary, since git-diff-* -p is better anyway, but if
someone is relying on cg-* Porcelain....)

Signed-Off-By: Jason McMullan <jason.mcmullan@timesys.com>

Index: cg-Xdiffdo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- be7e79d03a25ad69405c8e17c024f0c83a9d16cd/cg-Xdiffdo  (mode:100755)
+++ uncommitted/cg-Xdiffdo  (mode:100755)
@@ -48,13 +48,13 @@
=20
 while [ "$1" ]; do
 	declare -a param
-	param=3D($1);
-	op=3D${param[0]:0:1}
-	mode=3D${param[0]:1}
-	type=3D${param[1]}
-	sha=3D${param[2]}
-	name=3D${param[3]}
+	param=3D($1 $2);
+	mode=3D${param[0]:1}"->"${param[1]}
+	sha=3D${param[2]}"->"${param[3]}
+	op=3D${param[4]}
+	name=3D${param[5]}
=20
+	type=3D`git-cat-file -t $sha`
 	if [ "$filter" ] && (echo "$name" | grep -vqxFf $filter); then
 		shift; continue
 	fi
@@ -72,15 +72,15 @@
 	([ -d "$dir1" ] && [ -d "$dir2" ]) || mkdir -p "$dir1" "$dir2"
=20
 	case $op in
-	"+")
+	"A")
 		mkbanner "$loc2" $id2 "$name" $mode $sha
 		diff -L "/dev/null  (tree:$id1)" -L "$label" -u /dev/null "$loc2"
 		;;
-	"-")
+	"D")
 		mkbanner "$loc1" $id1 "$name" $mode $sha
 		diff -L "$label" -L "/dev/null  (tree:$id2)" -u "$loc1" /dev/null
 		;;
-	"*")
+	"M")
 		modes=3D(${mode/->/ });
 		mode1=3D${modes[0]}; mode2=3D${modes[1]}
 		shas=3D(${sha/->/ });
@@ -94,7 +94,7 @@
 	esac
=20
 	#rm -f "$loc1" "$loc2"
-	shift
+	shift 2
 done
=20
 rm -rf "$diffdir"


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-Jg5AGqnWvBes9/c+wP1w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBClNQy8/0vJ5szK6kRAg+XAJ9kPfoExQMo+RiE1+PjARSYNZQwtgCgsy5A
1EZmwQFMn+LECqrYF9gtBFI=
=wYOh
-----END PGP SIGNATURE-----

--=-Jg5AGqnWvBes9/c+wP1w--
