Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED8B1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfKHU1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:27:38 -0500
Received: from mout.web.de ([212.227.15.4]:58113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKHU1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573244855;
        bh=Z9WBAi6mMD2jHMjdjDmlhdhErk1QVDRGl7XzafyUE6Q=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ni0/2XiND0DHjQolVJuZ+HObCVVABbOivOTFkLPppLC7/Ntc5UesN0Sqcg5qPUdqM
         YtsLB1qSCGT56A/UnGGo2hZ7zzxpY4Eg9NnOV4ypFJKImZy8u2JG82LE4Y9h73irCK
         PoPm64zSAbA1/YPIyWsIFAfFAqK7nMY66bXA1N1s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfqSa-1iEorK4AU8-00N9aO; Fri, 08
 Nov 2019 21:27:35 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] convert: use skip_iprefix() in validate_encoding()
Message-ID: <a61b60e4-77f4-10a9-65ff-f78348d4c4b7@web.de>
Date:   Fri, 8 Nov 2019 21:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4CuD7IMsIPSHEqN5omJFTvse7uO4Ctkok3uaJe1CBDaMRQ7JmIQ
 REirbomiACInGMr9LtmfnpgA6Oz1ni/gkHB3Voa+3QYx1+emKcukgN87+kT7NNvHZvG6YiO
 22jrQh16J2ESw4q5GP5YyMs7SAtxoyv5QvXUJMFMQoDjfiZXsja3mc1NgeHF4DOGFdJwseB
 Vi5eTTOD3LYqY7iIWOFtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Ckks3r+Nq4=:PwWtyaqIc/etCMrRsFvS+z
 IQyy8GOOqWy1nExsaFFklqty67h26nD+b8kC4ljWrPOugK1961N8EBr7SOTrmCdrDe9IRUII3
 vg4O6oF6lxJSWZVwocd5gl0ydoIT0IdBbNGx64AISozdnq0u3n6GWOqEb+xuLvvYAU63eExVI
 RA8MTsg/IvdnmFipA1+1REy+iry7qxMAvhza66d1IHEIdzR+qBN3ZbuYkldPjbVHbY+icJMDZ
 vGE3rWriiNuCQ0ZnFI8DyJzZUgEM4fvRxLa/3Dp6QU9WiQG/9E08iImrmsHL7W8yqRDgMGd53
 8LhnZ+Xe9+2FSbnEvh6I9cF/wSuIjMcFn6Lku47Q8KpwLGWAFBSgHgcn9UHWNjwVbzfFJbmLl
 VEBdnKqQRvGL1wjsJkekNkkcCi8N3CmTbKP9E1iY+YzRbxuzalj0TKgyYBeXw2dD7JUmgMv8A
 AWfCtte3QbJae1J4vu2ZBy6k8tBMynA/EqRJ2X4PYifZ77EhDl8Df9xCFlJWr2rC4OQNPe8Fx
 3fWhW/2ZJznRfylF5e22TfD4I6r1DzDvlRfXOg9u9D6RydjPF472NQBxgiZfhZ70Zitf/9kDW
 wG/7Ne1x/9P7MaAKqlqe5STFIO+nI5dzpRTynw1kTq0WCqD3A0XxwIGYb1PEHG/fH4ZM6f/aZ
 QvF9gNDwqGhc2Omb48GmTEuk0UrDh4jtAI1IhfbzSK9GYQSwL+TXbCb1I1qTw0ies2I65hJxq
 wQuEZ+z6neq8UKTY+33VTbmJTZesWkxNqX/1hOpllNuAnWInXiFcmOn1vkhocInJUwwuvl6z3
 snHU7opOjZ/tCOGspI+2x8z1UnGE+A6TcrH1F7BBAx1y8xN4z6AL2hCFD53kuTWeWYwUkEDEe
 JsCpgf206pAlR6HUOF2z4MDbM/7tGpBbV6zCSHbHFcM32Oe2hPKVJPEdVMp9AQYxcCWBhh3YG
 ig5oJEC2V1RgnSZjeu2PVuVanbJcZpIyN3ng/t6cJRAieZtWNBISoRVzugHDU3jsNeQ4LomIq
 H3RYv41RMCWvk8rG3S5mu4+pMdsjX9giXHU9N70VvQkfT3vGnX+RWe01firbhrGtXEEjgR3e2
 TwPOGh93gKFFPgfWNBRyVZtnGv0YPqlF/rSqoHgQEwQOw+KnxXwNvcGoen0C4kO76Zx1vsOu4
 3erqAhrFEpi3Po4TyMJpFSXT9XLPZQmYjRMr29rUW4Oy5k1a3a8dB6Tv4BRmhzFLj68jV64Bf
 pDKkxEBvFa8K7egl0cvMywWk6rpwYSxwYmhZtpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use skip_iprefix() to parse "UTF" case-insensitively instead of checking
with istarts_with(), building an upper-case version and then using
skip_prefix() on it.  This gets rid of duplicate code and of a small
allocation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 convert.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/convert.c b/convert.c
index 25ac525d5f..99f684bf3e 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -270,8 +270,12 @@ static int will_convert_lf_to_crlf(struct text_stat *=
stats,
 static int validate_encoding(const char *path, const char *enc,
 		      const char *data, size_t len, int die_on_error)
 {
+	const char *stripped;
+
 	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
-	if (istarts_with(enc, "UTF")) {
+	if (skip_iprefix(enc, "UTF", &stripped)) {
+		skip_prefix(stripped, "-", &stripped);
+
 		/*
 		 * Check for detectable errors in UTF encodings
 		 */
@@ -285,15 +289,10 @@ static int validate_encoding(const char *path, const=
 char *enc,
 			 */
 			const char *advise_msg =3D _(
 				"The file '%s' contains a byte order "
-				"mark (BOM). Please use UTF-%s as "
+				"mark (BOM). Please use UTF-%.*s as "
 				"working-tree-encoding.");
-			const char *stripped =3D NULL;
-			char *upper =3D xstrdup_toupper(enc);
-			upper[strlen(upper)-2] =3D '\0';
-			if (skip_prefix(upper, "UTF", &stripped))
-				skip_prefix(stripped, "-", &stripped);
-			advise(advise_msg, path, stripped);
-			free(upper);
+			int stripped_len =3D strlen(stripped) - strlen("BE");
+			advise(advise_msg, path, stripped_len, stripped);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
@@ -308,12 +307,7 @@ static int validate_encoding(const char *path, const =
char *enc,
 				"mark (BOM). Please use UTF-%sBE or UTF-%sLE "
 				"(depending on the byte order) as "
 				"working-tree-encoding.");
-			const char *stripped =3D NULL;
-			char *upper =3D xstrdup_toupper(enc);
-			if (skip_prefix(upper, "UTF", &stripped))
-				skip_prefix(stripped, "-", &stripped);
 			advise(advise_msg, path, stripped, stripped);
-			free(upper);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
=2D-
2.24.0
