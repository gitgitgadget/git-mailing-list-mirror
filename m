Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B58EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGUMmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGUMmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:42:16 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4112D6D
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943314; x=1690548114; i=l.s.r@web.de;
 bh=gRye8RCMK7B8IKIFAKX65qHCUe3huGphRRQ4Agaqshk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RoVz18BbHXODVG1JRXeeDjRJsyEB+f0LeCz08uoX+qGpBqTuPuIJidUxqAG6x1yL4rgRnW1
 AOfA7KA8ZmaEgDCCc1MrH2vTsmwIe+pDW7TqigTE6BiyhsQng8kFSe9f9E7Xj2Og0WJlcSf9S
 zWK+1rBA6PyE/uMZhru7w18nHte4tHoLq4GQzHR3WDC6TkRZFmTeT7xjYpuqv4L4nRzVHJvb2
 Yzo7IOLCNfFF+kmPpONpNJqr3sUhRCTOJzrWCsgY5d3tSeCyUFwR/SgRcMyunD3rD6y4Qesfg
 xSVsEyYemuiyf0UgUa+UbdVGxT8dirQVQIIvFpsP8D/1e+rkY/jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRUV-1qe5M904kF-00I9HI; Fri, 21
 Jul 2023 14:41:54 +0200
Message-ID: <9f2e78f8-9d97-880e-dd54-eb86a8172b1f@web.de>
Date:   Fri, 21 Jul 2023 14:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] pack-objects: fix --no-quiet
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0gOo3cVEExOaqrilFkgZ8+KhUnqwa64+Zxl5P4O3oSxaU9RDzXq
 G0483w+061B21qzRq5zWYB7h/nk4RaHAJi2ARq2yaNMczkDOzbIyci4Ubp/NNiNOSqwgGic
 C+a9QO2UqEiBF6gMFWa5OefBcssVPcVax9HoL7GLF+qr2CuQfW+FnrDbIF8cQTLwweY63NN
 ndPV+OFfoO57jCjCQDo4g==
UI-OutboundReport: notjunk:1;M01:P0:Id0LoVO6gkA=;vyxbsyCKM573rmy/ZcAj3mPBxrO
 5Qiu0a2lwpXpLf0RHqbOV1fsLbN8S8/QU8XVxPmlrg0z9AY7xKCb0YbdN33CPsXAEj+OJkHiU
 DkYVWzL1QN0CUefrW3Gfrdw896bPprJGVqQ6VMk/z+NcxS1J7PiZSVGoUGixnaPZMmEeGZ90G
 a3qj9pDx6EwfM0vqOeBLTEcbQnCBpddNhlZIUIuxbqowBNZM8XeWPWqM1VbiGIBUYghH2VlPl
 CJ2Ew8PquhtwSWbiM6lPTis3XkdrI34wU+ixr/qOwW2dPFahUHYlchVAh31ykIybANcrAOXAt
 KkNySmfPK721DTu0ASsAaTLp4W14FBSBQ4H1mVrciE622TvmckqfTSGeHNpHqOInhQErNf6m0
 LqfBd8XPBLO8tQtaGAbCMoBg4EmKcDceyioevJTI7CtUPe0H+zo7EJ90iu7JiKGJZx/Ur4p7e
 +U9yldM7v41VLEvGWxggt58hTNi/StO60xT2MCw4QSAecS0JbpdlBrHk+Zx0xpEPjmwebgrfh
 ehprpN4X/zh6/GWJQ3FK0z8+JiIXbns+vQoXuVQlXGFvoAWgui7CoKWFr0jembm5LD8497eDQ
 n6W2mjoY+EaXFITnthmUoY8Lvd5WiuUuQbkOTEcWEs9rA/ic1VnGHxlxDquSoomSOD3jCkevY
 fs3eLZbAoUifvMxEmMUOGOozo3fFhuQNOPMIIopQ1L/eaFaB+wCF97BTgeHATiQsnXFYpp60n
 JWiMp5QgVlOBW3I5i8gVkpqlh+6qt+gmNKiXci06An+ZTyLs5L3D2hCaWsq9332DyOvs/9Z+U
 z8ZQiewo0MSImv5SWHc/37MmzY4pZJ4ZrJlR407G/lrH6Bn+nNwzi94jMS0Z3c0k+z7M/WLna
 r4R/6DxGUAeAudX8hdA0thGMItdk8dEl9JuoUEKzqOrA6p8b3/26vxa0A5UEHstlSIomZCMYw
 b3LAIQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 99fb6e04cb (pack-objects: convert to use parse_options(),
2012-02-01) git pack-objects has accepted the option --no-quiet, but it
does the same as --quiet.  That's because it's defined using OPT_SET_INT
with a value of 0, which sets 0 when negated, too.

Make --no-quiet equivalent to --progress and ignore it if --all-progress
was given.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fcf591c466..ccf451ce70 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4117,6 +4117,18 @@ static void add_extra_kept_packs(const struct strin=
g_list *names)
 	}
 }

+static int option_parse_quiet(const struct option *opt, const char *arg,
+			      int unset)
+{
+	BUG_ON_OPT_ARG(arg);
+
+	if (!unset)
+		progress =3D 0;
+	else if (!progress)
+		progress =3D 1;
+	return 0;
+}
+
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
@@ -4178,8 +4190,9 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 		LIST_OBJECTS_FILTER_INIT;

 	struct option pack_objects_options[] =3D {
-		OPT_SET_INT('q', "quiet", &progress,
-			    N_("do not show progress meter"), 0),
+		OPT_CALLBACK_F('q', "quiet", NULL, NULL,
+			       N_("do not show progress meter"),
+			       PARSE_OPT_NOARG, option_parse_quiet),
 		OPT_SET_INT(0, "progress", &progress,
 			    N_("show progress meter"), 1),
 		OPT_SET_INT(0, "all-progress", &progress,
=2D-
2.41.0
