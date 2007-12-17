From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 10:50:14 +0100
Message-ID: <20071217095014.GF7453@artemis.madism.org>
References: <20071217092013.GD7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="bGR76rFJjkSxVeRa";
	protocol="application/pgp-signature"; micalg=SHA1
To: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 10:50:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4CcZ-00013P-2n
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 10:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763201AbXLQJuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763473AbXLQJuR
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 04:50:17 -0500
Received: from pan.madism.org ([88.191.52.104]:58960 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763075AbXLQJuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 04:50:16 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2F27A197CB;
	Mon, 17 Dec 2007 10:50:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7C7422AD780; Mon, 17 Dec 2007 10:50:14 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217092013.GD7453@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68530>


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
    >     // ...
    >     /* when in `git --opt1 --opt2 foo -a -b -c` mode: */
    >     int cmd_pos =3D git_find_builtin_command_name(argc, argv);
    >     int count =3D parse_options(cmd_pos, argv, git_generic_options,
    > 	"git [special-options] cmd [options]", 0);
    >     if (count)
    > 	die("unknown git command: `%s`", argv[0]);
    >     argv +=3D cmd_pos;
    >     argc -=3D cmd_pos;
    >     /* here we simulate an argv of {"foo", "-a", "-b", "-c"} */

    Or even simpler, with the following specifically tailored patch you
    can directly write:

    argc =3D parse_options(argc, argv, git_generic_options,
	"git [generic-options] <command> [cmd-options]",
	PARSE_OPT_STOP_AT_ARG);

    and then {argc, argv} will exactly be the NULL-terminated array
    starting with the builtin command. Kind of nice :)

 parse-options.c |    2 ++
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 7a08a0c..4f5c55e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -229,6 +229,8 @@ int parse_options(int argc, const char **argv, const st=
ruct option *options,
 		const char *arg =3D args.argv[0];
=20
 		if (*arg !=3D '-' || !arg[1]) {
+			if (flags & PARSE_OPT_STOP_AT_ARG)
+				break;
 			argv[j++] =3D args.argv[0];
 			continue;
 		}
diff --git a/parse-options.h b/parse-options.h
index 102ac31..7c636b9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,6 +18,7 @@ enum parse_opt_type {
=20
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH =3D 1,
+	PARSE_OPT_STOP_AT_ARG   =3D 2,
 };
=20
 enum parse_opt_option_flags {
--=20
1.5.4.rc0.1147.gfd22d


--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZkZWvGr7W6HudhwRAls/AJ4vOJ19NYCZWAIdBYThqnvRXPLj/ACfQ0Lf
l32wFGgF3qbXwcg7Od1VZxk=
=nfle
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
