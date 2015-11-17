From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/5] parse-options: deduplicate parse_options_usage() calls
Date: Tue, 17 Nov 2015 11:25:14 +0100
Message-ID: <564B008A.9000102@web.de>
References: <564AFF32.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZydSL-0004Gz-BS
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 11:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbbKQKZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 05:25:39 -0500
Received: from mout.web.de ([212.227.17.12]:61262 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbbKQKZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 05:25:37 -0500
Received: from [192.168.178.36] ([79.253.153.213]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MFc1h-1aCiTk0Iar-00EZuL; Tue, 17 Nov 2015 11:25:21
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564AFF32.1030406@web.de>
X-Provags-ID: V03:K0:kExfIGuy+dCmfTsMR/DPs3+t6SqVyIc1+e93k5Y8xBi5cn0FZTt
 /8ukD7KnJxS7E0VVCiHAileRtGS2Flv5ytjXUVYTJrUgJIQ9zn08EcvUUOJZzmshTWStCFU
 NgjErpsite/ShJdCU2I6nayeElQeam8cVuhfmB4QuOMd75Tvb3J1+cR6fJ0TGhN7mACTKVL
 ndTQEWlEwpAUgQuSK6KwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t1NH5nkfpfY=:89d90x5ULvr2HErHtwi8LE
 LWovFAVPjastgV5oSp+VP7g0qjlnBoUWGGvcq0bdB1m+LHJw+p+ZLY6S2ATV3fj5pT8Q1+2Fm
 wtTXTdJyJcLdQcWKC8sjLvndMKlY73Pud8kpocYlfQnq1yEcLCQwYFCcMNWhS+nbgXhKMqY/u
 xaTqNa8KJl2TFyMJAfVPuxfVJ+Lv6ww8jEpvNhsNTTIG3c4cplf1TqloGv0nK22CYAM8uOfJQ
 gIKB4v7biTHCuaRfMNf4YztmJ1kaP2BPSFl2ZhaEP5NN46+Oowqlie0g1J9ry9eNEeeADI94S
 PHMvNIXO6lJRVqdn3/zXx5XRYK1SehWDCVtCIHZHtJ0qLSxeyxS3Uv1+FVpB/64kYdCp/Ei7r
 B5Bek2hvtxXDes+7lAbz9FljNcecnhv/A2DogGujr8cG3VqSYLTFXwMFYiOYmVKOgm6MwlOO0
 v51F2RzvsfiURIDz08/+iHNrzxPw9Vq4edKXTRkEaf5i36Ix4t6ZTANz++3pi9O3Dr1qcDwwA
 3j19sZ+/bapoTC2M8rLx7Oq3LpE++iyw1Zr+DvDVNnyk79uIvmx9UkeG04UwA4hZxYdWeiUfk
 uz5Fm7B6MKPs/W/BUl212cwzWYMixD+xh4TA1UZpP4+PKw86G0QdsvTyyJR8H1sro4Lw+/Krp
 JWaxkw6UkCiloprl+VSCk56637qFKjctbYxBS4qJNOe8aQbCDkMWmdm8QzoX/4KTGAAGrXCOU
 BdJiiYsE4aBfCTV5KPUuZRDEbCSWJyqw9QdeAGFMw8dGgEiQNWJstVp3rYG9XscLur2+hzIv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281395>

Avoid long lines and repeating parse_options_usage() calls with their
duplicate parameters by providing labels with speaking names to jump to.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 parse-options.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 3eceba4..f0b6d9b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -435,6 +435,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
+	int err = 0;
 
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
@@ -454,10 +455,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			if (internal_help && *ctx->opt == 'h')
-				return parse_options_usage(ctx, usagestr, options, 0);
+				goto show_usage;
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
-				return parse_options_usage(ctx, usagestr, options, 1);
+				goto show_usage_error;
 			case -2:
 				if (ctx->opt)
 					check_typos(arg + 1, options);
@@ -467,10 +468,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
 				if (internal_help && *ctx->opt == 'h')
-					return parse_options_usage(ctx, usagestr, options, 0);
+					goto show_usage;
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
-					return parse_options_usage(ctx, usagestr, options, 1);
+					goto show_usage_error;
 				case -2:
 					/* fake a short option thing to hide the fact that we may have
 					 * started to parse aggregated stuff
@@ -496,10 +497,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (internal_help && !strcmp(arg + 2, "help-all"))
 			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
 		if (internal_help && !strcmp(arg + 2, "help"))
-			return parse_options_usage(ctx, usagestr, options, 0);
+			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
-			return parse_options_usage(ctx, usagestr, options, 1);
+			goto show_usage_error;
 		case -2:
 			goto unknown;
 		}
@@ -511,6 +512,11 @@ unknown:
 		ctx->opt = NULL;
 	}
 	return PARSE_OPT_DONE;
+
+ show_usage_error:
+	err = 1;
+ show_usage:
+	return parse_options_usage(ctx, usagestr, options, err);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
-- 
2.6.3
