Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C4CC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHEOnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEOnL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:43:11 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3831FE6
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246585; x=1691851385; i=l.s.r@web.de;
 bh=uCHtuznV0V+HFjbDpOTd4go/zg6Ajcr88wcutwlft3k=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=arBUMIjfA77eSAKfRwpbYrx1YspXWmxk68krLYvV77/psTVdjTBj4dRqv8aTd2leCRFxNEr
 meQqnCzAsa9zckhimnhtI1B6oxKyZ1JWgu4vqhPg4FIm7pYtZXSt00apcyywbCZd0uSlIve3S
 OMQOiCg3025Zz0ci9ypey1SbdZb4g67KBM8YNaCTZ48SwsrSmbG39lu6QYvwkwZaBWrfy65/C
 2leFcWc9H3BFBbxa3TinvNvzXte/LfrI9BxjUn0cvvh/pQZKmmiG4e7CYPsTHTflKc50/IUdp
 3HDKOQ3Hxp8H/G5hJfQUDntRiKuM9at8iSUNib8FM69cufUr9oJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl0r-1q3Pim1wzN-00qCQ4; Sat, 05
 Aug 2023 16:43:05 +0200
Message-ID: <65090b9f-182e-86a5-955d-184fa7164d38@web.de>
Date:   Sat, 5 Aug 2023 16:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 6/8] parse-options: factor out usage_indent() and
 usage_padding()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
In-Reply-To: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lhm1bIfo/SF1eACVwTv4NdINPnj3xuCSGbEImgxT7nWXpC9KY/v
 l14DADjvCIx/7WfkuQSfS71JajNYNF/7DrtcjVyObjMTR1r2PBelF3QVvlcIZE7G3K7Qa9F
 p5Xdn8FwuZDUnTWmt6tUGqHfhCQE6fogF2pCj/aVFicHeUEubyPDgL6RNA3vTWuXbKN1ne5
 4JNfZls3fb+jibgv+8+0g==
UI-OutboundReport: notjunk:1;M01:P0:6MSMBtsNpS8=;QcNeGZD3QoB5zyiZF1ZspfDICFL
 9yAVfz9QaHq+Rz5fJO1jCkv3qbS18xdw2tHsaA/57Xw8oyDnk0o3EGQjndQNSEpOJOh56ytrm
 rcF6aRYUu1SgtbcseO3jGZM51l6/y/Vp3l/diJnvmXA+rEw+yb51XTVRNPprrFR9jxAcbxowg
 oUb3olvdM9DG+yy3x/8qeihA4ngMc84jip+pqnAWA2N0Fy6EBPcBs14RaWPHF4CglqVxsCgan
 pHX52vRbJdbEthCpGnq9RPtshxNQOSI9j0Dj6W9iRVpdMHU8NXohPysTt3hnSKdjuI6Q38B9T
 /dzpwyj7SLFuUFVXK6os5F9YO2Y0HkUmv7mkXAHTslHpg14BqtWdM5pD3SYbaT3P4LLm7Xzhp
 n/92+fFZe9Yib4dDBDOCOcrjwk6Z5IFvRGONB262YdSUZgZ0wODT/d7Ni1YABPikapbMIk9JU
 STARQmHP2eo/KAh1Hhvope2UhJ2Ra/WrtIXKzL4usw7YYQtVGRc/nX89jCMyoM3F/bLwvXygv
 XYnTz1z1ZspPADyyXSrsCDJKyC7DyH01tYgZs4c+mUQC1H5ZMTJlJugK5HNWSkk8lHe/cpal+
 pDjZ57BPmBSGv0QREuU1KaS1kZ4U5YVbYE2O0VlQcgVU+LrcWhguW+yWlmaKx5r5yjk/E4Fu4
 5wIwwK2cPDYby0wf8eEuLzSLdAY4Ygvc9QfDhc2BArjMxuQ7C6qCMRr+IgAuQK/eP3g2ujcyU
 LzhzcDbOvG3IM94/jd8UI10yinQzEKpeE5p+hYHBA+yP5KWA5/hG/E3oaDS7n5ygVrFxN1ZdK
 fNuGHkxJMQrJyAHwsHl4qaHP7nuSJHen2BRJk3Dxrt9v3rEbPvevQEfM1V+se4+Qrhe0bFmnT
 +0xBo2u+kSk28mxPYhgyeDRz6GabJANQmZA+niDybipc6PXrWST56kqwTOdb315HEsbfIfGT4
 taaBgeLcSRxMZ19YjFEpHdwYBmI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract functions for printing spaces before and after options.  We'll
need them in the next commit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b750bf91cd..4b76fc81e9 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -1020,9 +1020,28 @@ static int usage_argh(const struct option *opts, FI=
LE *outfile)
 	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }

+static int usage_indent(FILE *outfile)
+{
+	return fprintf(outfile, "    ");
+}
+
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2

+static void usage_padding(FILE *outfile, size_t pos)
+{
+	int pad;
+	if (pos =3D=3D USAGE_OPTS_WIDTH + 1)
+		pad =3D -1;
+	else if (pos <=3D USAGE_OPTS_WIDTH)
+		pad =3D USAGE_OPTS_WIDTH - pos;
+	else {
+		fputc('\n', outfile);
+		pad =3D USAGE_OPTS_WIDTH;
+	}
+	fprintf(outfile, "%*s", pad + USAGE_GAP, "");
+}
+
 static enum parse_opt_result usage_with_options_internal(struct parse_opt=
_ctx_t *ctx,
 							 const char * const *usagestr,
 							 const struct option *opts,
@@ -1108,7 +1127,6 @@ static enum parse_opt_result usage_with_options_inte=
rnal(struct parse_opt_ctx_t

 	for (; opts->type !=3D OPTION_END; opts++) {
 		size_t pos;
-		int pad;
 		const char *cp, *np;

 		if (opts->type =3D=3D OPTION_SUBCOMMAND)
@@ -1128,7 +1146,7 @@ static enum parse_opt_result usage_with_options_inte=
rnal(struct parse_opt_ctx_t
 			need_newline =3D 0;
 		}

-		pos =3D fprintf(outfile, "    ");
+		pos =3D usage_indent(outfile);
 		if (opts->short_name) {
 			if (opts->flags & PARSE_OPT_NODASH)
 				pos +=3D fprintf(outfile, "%c", opts->short_name);
@@ -1152,16 +1170,8 @@ static enum parse_opt_result usage_with_options_int=
ernal(struct parse_opt_ctx_t
 		    !(opts->flags & PARSE_OPT_NOARG))
 			pos +=3D usage_argh(opts, outfile);

-		if (pos =3D=3D USAGE_OPTS_WIDTH + 1)
-			pad =3D -1;
-		else if (pos <=3D USAGE_OPTS_WIDTH)
-			pad =3D USAGE_OPTS_WIDTH - pos;
-		else {
-			fputc('\n', outfile);
-			pad =3D USAGE_OPTS_WIDTH;
-		}
 		if (opts->type =3D=3D OPTION_ALIAS) {
-			fprintf(outfile, "%*s", pad + USAGE_GAP, "");
+			usage_padding(outfile, pos);
 			fprintf_ln(outfile, _("alias of --%s"),
 				   (const char *)opts->value);
 			continue;
@@ -1169,12 +1179,11 @@ static enum parse_opt_result usage_with_options_in=
ternal(struct parse_opt_ctx_t

 		for (cp =3D _(opts->help); *cp; cp =3D np) {
 			np =3D strchrnul(cp, '\n');
-			fprintf(outfile,
-				"%*s%.*s\n", pad + USAGE_GAP, "",
-				(int)(np - cp), cp);
+			usage_padding(outfile, pos);
+			fprintf(outfile, "%.*s\n", (int)(np - cp), cp);
 			if (*np)
 				np++;
-			pad =3D USAGE_OPTS_WIDTH;
+			pos =3D 0;
 		}
 	}
 	fputc('\n', outfile);
=2D-
2.41.0
