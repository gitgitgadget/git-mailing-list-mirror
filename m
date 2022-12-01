Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80517C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 13:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiLANoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiLANoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 08:44:10 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DE5BF92A
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669902241; bh=fa23jAKF3RtbRPndFLsNpr6FuJKV1ywF20beCIO5Zt0=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=p/k2Weyi9+Ngjx6nKUV76g9rXPKiDvjJ90RtDECNzzLnugaQy2i6SCkErKHIW3ySs
         l9ZFCbuLabBNLjK4nBkXCViebqTDaX0y/5lCpy0VR/yy0qxmIczTSP54Vo1/vS1eqG
         sVw9tmmKf6SF8kZH5elaOwwlYWVH2qDsaiI45z4z2AYvyfhy5W3doXke6itPRxt4lj
         LoiSwgdtZ65/DAeCPXQFh2V3jVA1sid/ZrMYUSzx6k8sH1ASPzDsn7yWgaATRID3vF
         AQMHjzNW5d3HlHt3gylHLFzJp1g277KpTGTaNAsdX1A2zFJPQbFtct9PKnT9PfeElV
         yTQBMhqjcquDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIEs-1pOxlh1TSq-00T7zX; Thu, 01
 Dec 2022 14:44:01 +0100
Message-ID: <ec70aee7-2cca-c184-930d-e61a6f4597c3@web.de>
Date:   Thu, 1 Dec 2022 14:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 3/3] diff: remove parseopts member from struct diff_options
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
In-Reply-To: <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5EX7BDlEBOesDW0+Q7J8Iv5o56uiTKCrpDnAVZixjdlNcWN/ypk
 m6ZlFzWoWdEs67RxBL/TRp2Ja81OW+0UgD4jIPUHgfmbNxNayYog9RIl+Jt3vVB5EYyXBhS
 7yAzeRX5Ob6eC7TOtpdP1hX6lJWR4wyJryrf7VepvaDUnuhVPsBfKXL79QGk+0QQMQoUxeS
 UCgUTYpMDmiBWau7WLjLA==
UI-OutboundReport: notjunk:1;M01:P0:xJ7elXeo1jM=;Usfx84ZDqz135guqhoawQEc50KS
 9nF9miHofFzFsiHsHC5xy4WIFb7Qhd6yP6duhoC9uO4UR4J8mZLeNQiMGcla7K7c5PCcwdFBW
 42BDxMfxKxWMGBejQXtqZvTgQlXBdPovqksJ1f6MXVveomlwGqrQ0T56rY+a/fMXsmfzwK8uQ
 UuCVjDxw7q2TKajHHSpXNRmXR1p9PpsQ4TivspIFhaN8V9CE52NMFP/POwnE8KcP3QpsDS1sA
 YP+XY0HeCnBXG3Z1PyS1iLdaFLtAxjNTDo0uTVbWgODpPqHPCLepCU/9N4J8zYI1eOSC16yFT
 DhZ/KpfAeF23oj70RXwX/CnKlj2dtdn/gjvJI3awfoUpxbAi3yEr3FalJ2ZW1KZnd+Z2HUQKP
 KicSmTffl7H7rbOFIl3tX2T/7H0DodLBybXeDqVs/WfUlWuQOBYPqZtd77QffzOdrXgthVtvT
 KEJAv++3b4AUqGh4VVTTK7W0jBjjeK1iNZVuR6KBZNCuAs4uNx3pxRcXUyf7k6mT/vAnzsqWK
 O24oP89G/LcDaYWGSM2mYJ0K97E60giTfzcbUA+gWyf+6emq/uf/ENLmEyJeFpI4mAppuOJb3
 M1uFCJwaCys8+IaqsrSIq+tKHJzd/iuesATXQfJOupczdYucMkOVpbKNmregcdWSBQMXaWGIR
 5byf+KXmAnc8XVjx2cPPvnlYKj/n82IXFY+nD35MuJM7uemVxNarhcAvB5WvrChExbH3jQfBV
 Q06qhNRw2EZpOlsfS0FDxGWxuBzEqByJH4us5ksJ+dOvQ3Hd7DFAlBD774uhPy9ws6chk8DYd
 KWPWAo2lxPPKSBVs7gEl2Rvns2VZ89EAxX70hozncfxB+jTjqJPaZW9Q5KWukPpKoaTfMbvsR
 cA0T2rD23Ht3RbKppbP5LP/kYPqtOF419SxkVF+Z/GJHaE0keO+cis4Zvm4a8YOtYbdmYCDly
 1aVVPnYGvPwkhBqKHCxgBg0/viI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

repo_diff_setup() builds the struct option array with git diff's command
line options and stores a pointer to it in the parseopts member of
struct diff_options.  The array is freed by diff_setup_done(), but not
by release_revisions().  Thus calling only repo_diff_setup() and
release_revisions() leaks that array.

We could free it in release_revisions() as well to plug that leak, but
there is a better way: Only build it when needed.  Move the
get_diff_parseopts() calls to the two places that use the array, free it
after use and get rid of the parseopts member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c | 17 ++++++++---------
 diff.h |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index e469d5d2a0..6415c4dc2d 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4615,8 +4615,6 @@ static void run_checkdiff(struct diff_filepair *p, s=
truct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }

-static struct option *get_diff_parseopts(struct diff_options *options);
-
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4662,8 +4660,6 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)

 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;
-
-	options->parseopts =3D get_diff_parseopts(options);
 }

 static const char diff_status_letters[] =3D {
@@ -4821,8 +4817,6 @@ void diff_setup_done(struct diff_options *options)
 			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &=3D ~options->filter_not;
 	}
-
-	FREE_AND_NULL(options->parseopts);
 }

 int parse_long_opt(const char *opt, const char **argv,
@@ -5695,21 +5689,27 @@ static struct option *get_diff_parseopts(struct di=
ff_options *options)
 struct option *add_diff_options(const struct option *parseopts,
 				struct diff_options *options)
 {
-	return parse_options_concat(parseopts, options->parseopts);
+	struct option *diff_parseopts =3D get_diff_parseopts(options);
+	struct option *result =3D parse_options_concat(parseopts, diff_parseopts=
);
+	free(diff_parseopts);
+	return result;
 }

 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
+	struct option *diff_parseopts =3D get_diff_parseopts(options);
+
 	if (!prefix)
 		prefix =3D "";

-	ac =3D parse_options(ac, av, prefix, options->parseopts, NULL,
+	ac =3D parse_options(ac, av, prefix, diff_parseopts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
 			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
+	free(diff_parseopts);

 	return ac;
 }
@@ -6518,7 +6518,6 @@ void diff_free(struct diff_options *options)
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
-	FREE_AND_NULL(options->parseopts);
 }

 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index c20a1ad76d..41eb2c3d42 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -394,7 +394,6 @@ struct diff_options {
 	unsigned color_moved_ws_handling;

 	struct repository *repo;
-	struct option *parseopts;
 	struct strmap *additional_path_headers;

 	int no_free;
=2D-
2.38.1
