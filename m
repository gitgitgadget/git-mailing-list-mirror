Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464ECEE14AA
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 21:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjIIVKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 17:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIIVKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 17:10:54 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21F1B5
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694293837; x=1694898637; i=l.s.r@web.de;
 bh=GRg+v1R+qPvl1aRBJRT7o1A35kXIKC2qual24Dj4xG0=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=oTthu8SV127WHE2yn2o3VsbbnHH2NG9T02t/WlzslfIjdm2wW/NokhmupxfCkiS2J5aRRh2
 KtM1kCWZ4ozc/Ffz1J/6lKD4zkP3JQjwzebMmzL7Y1XBBHlF/EAg3qwbQShJiimy7joyvj0Cu
 5vLy5xdpBq40EhL6idKC3g1jVJ9iD9b5czJUzfgcOFtjhJrLnIDNH4VpHElHW0Nkl7oPyEVy/
 JKpgyjVFnV+Cz9tJvTzQrpRaO237j2jsgRYb+TLn1plaZAwlM6Sn/8kCzCYOFneGDCWaerYBL
 SW9yI0dpmr5R/nnXT5g4BCv6XoaKBWW3E1Ytu1imAISxYdQ2J29w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.6]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1qAmVj3SPC-00VcPa; Sat, 09
 Sep 2023 23:10:37 +0200
Message-ID: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
Date:   Sat, 9 Sep 2023 23:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] parse-options: add int value pointer to struct option
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LfF0U2dReMlMKZK3L3+PHlNkvSvWsJGDPFbI++IXzL5k3PbNIPh
 tVRsrm7RIqLLNQQm4XpXHFmRkD47QAdFRe2mk9mgNzfNpzoXWDYJ6ztV+NdTj5epvDBRkMZ
 lF4kyyjI9FjFhkZHMNtEsLQbLEL6cAo8hrvnQNZNFHW9ByfaFWtHUhmZH+w7yhjj0fqACr3
 c1MswQ+EVC4N1/m2K4MXA==
UI-OutboundReport: notjunk:1;M01:P0:vm4SFUDZB9M=;9blWi7T1/TN4G9W2P5Q6890bxZ8
 x5/10SVtV8gCQ9s3r1KYF4LgHSchgOuxH6/t4TmwEFWN6itMGxSTf5b2Mp0JbwOENCeq3Z+/7
 TBiVIOpsYsWL6xTdatCF97hfkhcj/H2XSMa9mTqjuErBIpkO8zw3ABF+rEdGr0q7rQZagaioP
 MCmii6Om4Hi4WGw0C3zo27Zw4v8yBYrLgZsdYIJIvCqrQxNGTJhE5oBj0u/81wOzh4UeDBFCK
 uAXfmkvxXgW5X8Q139RNWKQFjvi6nmU5wXpxL7+DjVER+zj7kWvrYJ1Ew2G7Y0fe1LuTsAYhp
 PSya1SG13QJA8gOoX+vB8EaOXT4/vFrXcz/LvS3rxGXCXTwV38YhM0BKX1Rp4pTrdk+hr6Fer
 ueO8FLm5aCcQTNsBhMWPNwBNaCWQ8PcxIJKxid585VF5tq92m87er/ys6P/B3eFHF3+rZM+BM
 lQsgciivhyK8n2RFm/rW1QlJvSxnV84Zx7TU5fSzJuBX8T9pz375EYVk2dOkJGS4UgJKhSmbX
 TQiscV4nRXEsTtMyQTYAdn5dq7bOci+CgeHpMpcprIMCtk93O2fXSPZ4eUVpQ7PrVZ57WS1qM
 S+y9sdsQA0GlYPTUl4uIVLfmJYcGhRAmQ3n+vJdV724doZXxjJkdkrZ0n8e6OloNafWI3yaxY
 F8X0f0NPDGzoeXSRlzTU6sq2fDmcFGEN0TmujDVCf0GgNhnYBniibw98g2ELmsvkkJl8cAuso
 XSns4ha+MhbwY1A9Yi8ws3PwvmY3QxEyVvJMicSGnrSiNgMvADw4My9oh02LmU1hidg/OuXTn
 PK8iQqDWFI4YaRJasiWUEiAFbPW5qSiS7chKgG11SPjLzEd41IW810FMZZWQkJr9rlIu3gFFk
 eh/qF5QzKTGSQ8nskSU8s8sMcWAtLy2Ei9JQAJUkArryd7uM5BI7HP955o+hkeNWfeVOfd7sc
 wbgbbl13JoGehFTHx0xFgw6c4S0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an int pointer, value_int, to struct option to provide a typed value
pointer for the various integer options.  It allows type checks at
compile time, which is not possible with the void pointer, value.  Its
use is optional for now.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 34 +++++++++++++++++++---------------
 parse-options.h |  2 ++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e8e076c3a6..2552745804 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -82,10 +82,11 @@ static enum parse_opt_result opt_command_mode_error(
 	 * already, and report that this is not compatible with it.
 	 */
 	for (that =3D all_opts; that->type !=3D OPTION_END; that++) {
+		int *value_int =3D opt->value_int ? opt->value_int : opt->value;
 		if (that =3D=3D opt ||
 		    !(that->flags & PARSE_OPT_CMDMODE) ||
 		    that->value !=3D opt->value ||
-		    that->defval !=3D *(int *)opt->value)
+		    that->defval !=3D *value_int)
 			continue;

 		if (that->long_name)
@@ -109,6 +110,7 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 	const char *s, *arg;
 	const int unset =3D flags & OPT_UNSET;
 	int err;
+	int *value_int =3D opt->value_int ? opt->value_int : opt->value;

 	if (unset && p->opt)
 		return error(_("%s takes no value"), optname(opt, flags));
@@ -122,7 +124,7 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 	 * is not a grave error, so let it pass.
 	 */
 	if ((opt->flags & PARSE_OPT_CMDMODE) &&
-	    *(int *)opt->value && *(int *)opt->value !=3D opt->defval)
+	    *value_int && *value_int !=3D opt->defval)
 		return opt_command_mode_error(opt, all_opts, flags);

 	switch (opt->type) {
@@ -131,33 +133,33 @@ static enum parse_opt_result get_value(struct parse_=
opt_ctx_t *p,

 	case OPTION_BIT:
 		if (unset)
-			*(int *)opt->value &=3D ~opt->defval;
+			*value_int &=3D ~opt->defval;
 		else
-			*(int *)opt->value |=3D opt->defval;
+			*value_int |=3D opt->defval;
 		return 0;

 	case OPTION_NEGBIT:
 		if (unset)
-			*(int *)opt->value |=3D opt->defval;
+			*value_int |=3D opt->defval;
 		else
-			*(int *)opt->value &=3D ~opt->defval;
+			*value_int &=3D ~opt->defval;
 		return 0;

 	case OPTION_BITOP:
 		if (unset)
 			BUG("BITOP can't have unset form");
-		*(int *)opt->value &=3D ~opt->extra;
-		*(int *)opt->value |=3D opt->defval;
+		*value_int &=3D ~opt->extra;
+		*value_int |=3D opt->defval;
 		return 0;

 	case OPTION_COUNTUP:
-		if (*(int *)opt->value < 0)
-			*(int *)opt->value =3D 0;
-		*(int *)opt->value =3D unset ? 0 : *(int *)opt->value + 1;
+		if (*value_int < 0)
+			*value_int =3D 0;
+		*value_int =3D unset ? 0 : *value_int + 1;
 		return 0;

 	case OPTION_SET_INT:
-		*(int *)opt->value =3D unset ? 0 : opt->defval;
+		*value_int =3D unset ? 0 : opt->defval;
 		return 0;

 	case OPTION_STRING:
@@ -206,11 +208,11 @@ static enum parse_opt_result get_value(struct parse_=
opt_ctx_t *p,
 	}
 	case OPTION_INTEGER:
 		if (unset) {
-			*(int *)opt->value =3D 0;
+			*value_int =3D 0;
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(int *)opt->value =3D opt->defval;
+			*value_int =3D opt->defval;
 			return 0;
 		}
 		if (get_arg(p, opt, flags, &arg))
@@ -218,7 +220,7 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 		if (!*arg)
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
-		*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
+		*value_int =3D strtol(arg, (char **)&s, 10);
 		if (*s)
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
@@ -483,6 +485,8 @@ static void parse_options_check(const struct option *o=
pts)
 		if (opts->type =3D=3D OPTION_SET_INT && !opts->defval &&
 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
+		if (opts->value && opts->value_int)
+			optbug(opts, "only a single value type supported");
 		switch (opts->type) {
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
diff --git a/parse-options.h b/parse-options.h
index 57a7fe9d91..5e7475bd2d 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -158,6 +158,8 @@ struct option {
 	parse_opt_ll_cb *ll_callback;
 	intptr_t extra;
 	parse_opt_subcommand_fn *subcommand_fn;
+
+	int *value_int;
 };

 #define OPT_BIT_F(s, l, v, h, b, f) { \
=2D-
2.42.0
