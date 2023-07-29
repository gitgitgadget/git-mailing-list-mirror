Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4EC04A6A
	for <git@archiver.kernel.org>; Sat, 29 Jul 2023 20:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjG2Ukd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG2Ukb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2023 16:40:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954F2D40
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690663227; x=1691268027; i=l.s.r@web.de;
 bh=YIQ0jy4B7hQxkN/FMCrdUtHFaL2RKQh69q4/QoRWxMY=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=FrPb++j7xXBmrrIpC6LZb2qj4+6bL1CCG1mhXzYGDQ+p5088KSOsddP/FUnvSxsKqsjOWO4
 tDPyw/EP1AtVyLlPd5JbfoJYqcgPdlmtm68B+0OxIOqV9v+h64++xfUokS3vbQiS47FsCnofJ
 cTdggoejBPyyaewyyrtOXYzbr/hnRSIOniTqJ2heo+8ICgZsLAeGUHeBPm7S8SBxMc8TeM1pY
 VFr+vd67sjB/L4uYxozm1im31BoeSh25ZfpPD5HRhax5nQd/1f4IkPAMV7X2NmiDltlv9EN3S
 d9NglHN1ocKXy5owxT6UNZsp/4+rKdR6zWAnB7Z4GbBx2dM8YSgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vNQ-1pgn9j2RQy-010udY for
 <git@vger.kernel.org>; Sat, 29 Jul 2023 22:40:27 +0200
Message-ID: <2dcb915f-b926-e024-6394-23aff200955c@web.de>
Date:   Sat, 29 Jul 2023 22:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] bundle: use OPT_PASSTHRU_ARGV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRi06y8KxOfJF0b7+jFYEcJfpxzIWQiYdQG5xx5YfxYtduolBz9
 SoXavPDbZN/VGF7iLLkCf3Uku+L1TIibIyCo77eUJ+MUct0vvTjH6cuzJi8xIVnMWJe7HNt
 YHvV7omIGwXnvFQKQcA0lFprKSlSgt5LOG/Mtw3jq39x67EgT9oqmEdSFj9FvK5+HYlCKTX
 u1HqcEQY8tGdztrlMJ0fA==
UI-OutboundReport: notjunk:1;M01:P0:e27PQll0Lv4=;mHqPj0UA2heH1YHV9keckg3AnUz
 aWg4iWnUQ1ndApTGVm32RygeRqfbg5V8cPwNcyb7BvgfFNxIaQZghKcBNHLNnpfmU9l1XbAJl
 jI6w6zIM3bxnuMRiwN9z29SfP2g4dHTg0rBeaklTb7T0RqECVsmrkLGAE7Xm41JsbO2ZAbdGl
 4+MTjZjxECTDIZ4cYGRWzp+W/X6WkzfA+nTg0wOIh8NjFhq01829ade6nyEV1aflwi07PD93+
 XC2cEjgrTSr9/is/o60LzEdXkMDDvWZSUx8wq3OUvRLa7GTQc8NWJbPc/xvPdnR70FpKS1YNw
 4u7GPbqIWt++BKk39WMx2//wZXZHPkVTsXwgb5Q+orLGsoKeFLYF+py5nIwItQiUA1iHhGkj4
 XM69YsZIQ6WX+EJjp/lw9VH/qxyWmvcd5Cb3Pfxjr5AVXtFuFZ+kOnte9l19msoD+wIEyTeIx
 hbml1X+yRMbVpXT+cFqdnqhLXSXkvpq6fEylfBlfyplgrU5zuEnx7XxisEPC5juOyoDOZ+as3
 gqTMUBciczJCT60fNOQCYZs6hww2OqVYVXvaDQ5dLs2C59gpn9l+fbP4/rpKWIGVf/ThEmDT1
 8P60tvJUleUoTdicsxujOQMfCKTLxH+q6l0nr7sxml2fGazMZfWK7MV9r+KY1IX63tlvDPVZT
 ct8xA3kds5Qg2fNhbm13XFENtRm5X07nr6ELJOuvbKGISGyuSOen1lkztvkd64KBLT5BW2dTt
 MlF8708cUQbZ+KD4NCqdz4pOK/cKHgaTULUNG8qzrm3Ke6j+NA5b/6ty8+KzuQ9mcp9q/JRn4
 ofzz/HpizTuuNd9In+rmPFEyivAq7kZIdS31s2pQ2lFR9btuDul+FZC7V1l0sZJAMO3zsk+YS
 zTIklNGBhIN/WPFCX+Fr912rKkX4YiI7Ubd0Jm1VqdZou1lzzEcWyJRuXZMg57pENpd1GTVS6
 nRjVEQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git bundle" passes the progress control options to "git pack-objects"
by parsing and then recreating them explicitly.  Simplify that process
by using OPT_PASSTHRU_ARGV instead.

This also fixes --no-quiet, which has been doing the same as --quiet
since its introduction by 79862b6b77 (bundle-create: progress output
control, 2019-11-10) because it had been defined using OPT_SET_INT with
a value of 0, which sets 0 when negated as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/bundle.c       | 40 +++++++++++++++++-----------------------
 t/t6020-bundle-misc.sh |  6 ++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3f63631c03..3ad11dc5d0 100644
=2D-- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -68,42 +68,36 @@ static int parse_options_cmd_bundle(int argc,
 }

 static int cmd_bundle_create(int argc, const char **argv, const char *pre=
fix) {
-	int all_progress_implied =3D 1;
-	int progress =3D isatty(STDERR_FILENO);
-	struct strvec pack_opts;
+	struct strvec pack_opts =3D STRVEC_INIT;
 	int version =3D -1;
 	int ret;
 	struct option options[] =3D {
-		OPT_SET_INT('q', "quiet", &progress,
-			    N_("do not show progress meter"), 0),
-		OPT_SET_INT(0, "progress", &progress,
-			    N_("show progress meter"), 1),
-		OPT_SET_INT_F(0, "all-progress", &progress,
-			      N_("historical; same as --progress"), 2,
-			      PARSE_OPT_HIDDEN),
-		OPT_HIDDEN_BOOL(0, "all-progress-implied",
-				&all_progress_implied,
-				N_("historical; does nothing")),
+		OPT_PASSTHRU_ARGV('q', "quiet", &pack_opts, NULL,
+				  N_("do not show progress meter"),
+				  PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "progress", &pack_opts, NULL,
+				  N_("show progress meter"),
+				  PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "all-progress", &pack_opts, NULL,
+				  N_("historical; same as --progress"),
+				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+		OPT_PASSTHRU_ARGV(0, "all-progress-implied", &pack_opts, NULL,
+				  N_("historical; does nothing"),
+				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
 		OPT_INTEGER(0, "version", &version,
 			    N_("specify bundle format version")),
 		OPT_END()
 	};
 	char *bundle_file;

+	if (isatty(STDERR_FILENO))
+		strvec_push(&pack_opts, "--progress");
+	strvec_push(&pack_opts, "--all-progress-implied");
+
 	argc =3D parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */

-	strvec_init(&pack_opts);
-	if (progress =3D=3D 0)
-		strvec_push(&pack_opts, "--quiet");
-	else if (progress =3D=3D 1)
-		strvec_push(&pack_opts, "--progress");
-	else if (progress =3D=3D 2)
-		strvec_push(&pack_opts, "--all-progress");
-	if (progress && all_progress_implied)
-		strvec_push(&pack_opts, "--all-progress-implied");
-
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
 	ret =3D !!create_bundle(the_repository, bundle_file, argc, argv, &pack_o=
pts, version);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index dface8bcfe..3e6bcbf30c 100755
=2D-- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -619,6 +619,12 @@ test_expect_success TTY 'create --quiet disables all =
bundle progress' '
 	test_must_be_empty err
 '

+test_expect_success 'bundle progress with --no-quiet' '
+	GIT_PROGRESS_DELAY=3D0 \
+		git bundle create --no-quiet out.bundle --all 2>err &&
+	grep "%" err
+'
+
 test_expect_success 'read bundle over stdin' '
 	git bundle create some.bundle HEAD &&

=2D-
2.41.0
