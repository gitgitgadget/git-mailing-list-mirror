From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: 1.5.4-rc2 plans
Date: Fri, 21 Dec 2007 11:47:04 +0100
Message-ID: <20071221104704.GC17701@artemis.madism.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Clx92ZfkiYIKRjnr";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 11:47:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fPh-0000EK-PR
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 11:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbXLUKrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 05:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502AbXLUKrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 05:47:09 -0500
Received: from pan.madism.org ([88.191.52.104]:42604 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732AbXLUKrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 05:47:07 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4C9A51D425;
	Fri, 21 Dec 2007 11:47:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 51A0A322FE6; Fri, 21 Dec 2007 11:47:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69053>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2007 at 12:32:28AM +0000, Junio C Hamano wrote:
> I've tagged -rc1 last night.  The changes are mostly fixes.  There are
> some remaining issues I'd like to see fixed/decided before 1.5.4.
>=20
> One important issue is to identify and fix regressions since 1.5.3
> series.  No "rewrite scripted git-foo completely in C" can be regression
> free, and we had quite a few internal changes during 1.5.4 cycle (not
> just rewrite to C, but C level uses new and improved API such as strbuf
> and parse-options).  Currently I am aware of these regressions:
>=20
>  * handling of options, "--abbrev 10 HEAD", "--abbrev=3D10 HEAD" and
>    "--abbrev HEAD".  The last one does not work for commands that use
>    parse-options.  Pierre is on top of this, I hope.

Hmm now I'm confused, I believed we settled for the: --abbrev 10 HEAD is
forbidden, --abbrev=3D10 HEAD works, and --abbrev HEAD too. This would
introduce no regressions _yet_ as none of the commands that use
parse-options and take --abbrev accepted the --abbrev 10 form before. I
already sent this once, and assumed you took it, hence me being silent
the last days. Here is it again then.  Of course this does not affects
other long options for which `--long-option arg` still works (if they do
take an argument).

I'd also like to see any kind of form of gitcli(5) be merged for 1.5.4
too, I believe the first version I ever sent. In the thread where I
posted the proposal using `{}` the patch introducing it is the version
formed using:
  * my first proposal for it ;
  * your english fixes squashed on top of it ;
  * a fix wrt the '--no-' prefix and Boolean options that we discussed.
This version describes the current state of things properly IMHO. I can
find the message id if you need, but I don't have the commit locally
anymore atm.

Cheers,

=46rom 37c7baaa82f36d16697fa190635f5d3efbe2a83d Mon Sep 17 00:00:00 2001
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Fri, 21 Dec 2007 11:41:41 +0100
Subject: [PATCH] Force the sticked form for options with optional arguments.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 574ed31..4f5c55e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -89,7 +89,7 @@ static int get_value(struct optparse_t *p,
 			*(const char **)opt->value =3D NULL;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg =3D=3D '-')) {
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			*(const char **)opt->value =3D (const char *)opt->defval;
 			return 0;
 		}
@@ -103,7 +103,7 @@ static int get_value(struct optparse_t *p,
 			return (*opt->callback)(opt, NULL, 1);
 		if (opt->flags & PARSE_OPT_NOARG)
 			return (*opt->callback)(opt, NULL, 0);
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg =3D=3D '-'))
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
 			return (*opt->callback)(opt, NULL, 0);
 		if (!arg)
 			return opterror(opt, "requires a value", flags);
@@ -114,7 +114,7 @@ static int get_value(struct optparse_t *p,
 			*(int *)opt->value =3D 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || !isdigit(*arg))) {
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			*(int *)opt->value =3D opt->defval;
 			return 0;
 		}
--=20
1.5.4.rc1.1096.g37c7b


--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHa5movGr7W6HudhwRAqk/AJ0aDGf3NRZFz0dIB88m8e2whQ7OoACghlzh
8/mxChLd0HKtDTYgoMM3EdQ=
=XIsz
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
