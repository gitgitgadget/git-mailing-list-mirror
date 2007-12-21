From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-tag: fix -l switch handling regression.
Date: Fri, 21 Dec 2007 11:50:58 +0100
Message-ID: <20071221105058.GD17701@artemis.madism.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org> <20071221104704.GC17701@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BI5RvnYi6R4T2M87";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 11:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fTZ-0001Vm-Rv
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 11:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbXLUKvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 05:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbXLUKvA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 05:51:00 -0500
Received: from pan.madism.org ([88.191.52.104]:58765 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbXLUKu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 05:50:59 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 090071D425;
	Fri, 21 Dec 2007 11:50:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5892E324722; Fri, 21 Dec 2007 11:50:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071221104704.GC17701@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69056>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

It seems that you didnt took that patch either, that IMHO gives a better
semantics to git tag -l than yours, while keeping backward
compatibility.


 builtin-tag.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..020ee1c 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -16,7 +16,7 @@
 static const char * const git_tag_usage[] =3D {
 	"git-tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]=
",
 	"git-tag -d <tagname>...",
-	"git-tag [-n [<num>]] -l [<pattern>]",
+	"git-tag -l [-n [<num>]] [<pattern>]",
 	"git-tag -v <tagname>...",
 	NULL
 };
@@ -370,13 +370,11 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
 	struct ref_lock *lock;
=20
 	int annotate =3D 0, sign =3D 0, force =3D 0, lines =3D 0,
-					delete =3D 0, verify =3D 0;
-	char *list =3D NULL, *msgfile =3D NULL, *keyid =3D NULL;
-	const char *no_pattern =3D "NO_PATTERN";
+		list =3D 0, delete =3D 0, verify =3D 0;
+	char *msgfile =3D NULL, *keyid =3D NULL;
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct option options[] =3D {
-		{ OPTION_STRING, 'l', NULL, &list, "pattern", "list tag names",
-			PARSE_OPT_OPTARG, NULL, (intptr_t) no_pattern },
+		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
 				"print n lines of each tag message",
 				PARSE_OPT_OPTARG, NULL, 1 },
@@ -408,7 +406,7 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
 		annotate =3D 1;
=20
 	if (list)
-		return list_tags(list =3D=3D no_pattern ? NULL : list, lines);
+		return list_tags(argv[0], lines);
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
--=20
1.5.4.rc1.1096.g37c7b


--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHa5qSvGr7W6HudhwRAqAoAKCnidRsorR1k3EsfIU3AKmNSFn2rQCgqK8n
KmD2udrnD2Vy5SmBgmL4VB0=
=fLc5
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
