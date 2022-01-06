Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E19C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 09:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiAFJyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 04:54:24 -0500
Received: from mout.web.de ([212.227.15.4]:41935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236542AbiAFJyY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 04:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641462860;
        bh=d5ePrYaxNbHHKcbzBy26EeWTg62HOtDQeqIIBTd66gA=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=HMTOdSPkXRi7tFLVY6TmmZewO6YVjGALsVIE8pqvJIac2eTooAX4FX0dnaOEabD2h
         dOFDMcT4BZGjpIL7WuWNE2ghseJHUVZpjRY9N0/t4X7l4ch4d+U6v+dvHJEPvRD2XS
         B2m4B4OA8pEi4jdp/yAZFiQfb1cVYzgXCMLEhjYo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYu16-1msEBg12lE-00VFDi; Thu, 06
 Jan 2022 10:54:20 +0100
Message-ID: <a913ad56-9083-d124-f1ec-58a1f48d48fc@web.de>
Date:   Thu, 6 Jan 2022 10:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: [PATCH 2/2] grep: use grep_not_expr() in compile_pattern_not()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
In-Reply-To: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8WQMr56ZbppNOFhe1jSI8wBdqoJUeex/bgLwNbZMz1XvjqqY9og
 vfpkoJc/UEc8Iue1DnqfRUu54lB23J4bnOFcD/RbclUbyiaUbthOoFtfScoTE14ZWOwJ443
 LoDhExaLR5oVlU9nGu6m6jTzUFIiP6xLyXmuXfjGE0tiiJ9YjxGXAlp41dXu/DNNtZ7/F3O
 t2ekcwi8m/3Iyf7oqvwwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TywV73hgDzA=:yXPhKjMP7upLpJZqgyIBnb
 rg/Dy0hoX4oSVSWSmvgWaFlc8Kqnvs0RYVJTbB94IG8NvTt8B1UrEaWr89Uny6LRqLUcW1h5v
 80oHJa1DqANIew4Ateia4mUhbVJtOeGXB/A8KBKn5qXzz9oUTfINZ2xJYbZAQsTJ1tWbcu1om
 wcCIG1G/BzYeDfvY2vEnZYPMnoCRy0lbYVNMA5Li/UhqAYxBRUytxrWMgfrtjHErzBeVYyrY/
 TVkTZA9Td9YQyotNNmbkrswPJJJIB/DpRoFXfz0Q9bNHg7YfPj8AR1gi6s1BLF81IOBZzdA7L
 bHvahn4z1dpADMtjY0Mlk5CgRpKJtokQnvP5OaNQZS0PyiOv+kM2dxVAsRmPMshVJoiHvLnyW
 sSi/F962JepbBhKr+oQtwCBJexw84aCH1WNjn1+T+OTFAgTEPJeI3IDjePdUUXD1ko5BMNhwu
 bLvV2zavOkYtVYN4CwttgFMtl40waA3Mk5HK3ZYwcKzK1pS6QRVdzSUN1UAXBTsmLCCWXQ+0S
 kQimnHh353g4ZAMy1GyMyYLdoo+jiPRl3KitFigAMZV+F8C1gI+kr9AlZ+7Jm2c2K1zqKDkmc
 NdKSaxHGwqzb6pnOfrzjc8elxo192xsF1hyYznccu3GnAUffnIvNOaT/e3rSvPPe5Z315UKUG
 lpkRcLcySHXyCk25a0u60JGIUG57456ilelqdwGs9imnaYGnAH/kYiGAPGLlO+GeJb0aFzmg8
 ENqBCXr3MkHbY9iqiyIN5hjgX6TdXnR7uo4dJjg9cPfvzCDnoSRkTo2uER5c7Db4+fJuHK6v/
 3mFHs5r6U4CZlQQbYs5Q+FE7/WQGtiUbVrCh3oAQOxD31oFtuNdnNhagebmZX4hzI8dI6Tzjc
 OVAxMe7kEsFVjAYbnehihHT4bUI/zzB7Tkpj5fIMZrkqUX2AixXhl5LN2S8Ql9GqjwhEuW/le
 hUa3VUqKYudkYTP6f6L/GBtrLEBIj7arDw5b9P0M5ysaeZxEYAvaRF062KYRzS5r/t/oYUJVo
 1DERmFvXUxtQnJGBa64RP24XbijnQH3tfvX01F2MAn9mMCz0fW6Hlv2dZis5iEBjjA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definition of grep_not_expr() up and use this function in
compile_pattern_not() to simplify the code and reduce duplication.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/grep.c b/grep.c
index f1bbe80ccb..bdbd06d437 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -595,6 +595,14 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
 	}
 }

+static struct grep_expr *grep_not_expr(struct grep_expr *expr)
+{
+	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
+	z->node =3D GREP_NODE_NOT;
+	z->u.unary =3D expr;
+	return z;
+}
+
 static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep=
_expr *right)
 {
 	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
@@ -647,12 +655,10 @@ static struct grep_expr *compile_pattern_not(struct =
grep_pat **list)
 		if (!p->next)
 			die("--not not followed by pattern expression");
 		*list =3D p->next;
-		CALLOC_ARRAY(x, 1);
-		x->node =3D GREP_NODE_NOT;
-		x->u.unary =3D compile_pattern_not(list);
-		if (!x->u.unary)
+		x =3D compile_pattern_not(list);
+		if (!x)
 			die("--not followed by non pattern expression");
-		return x;
+		return grep_not_expr(x);
 	default:
 		return compile_pattern_atom(list);
 	}
@@ -704,14 +710,6 @@ static struct grep_expr *compile_pattern_expr(struct =
grep_pat **list)
 	return compile_pattern_or(list);
 }

-static struct grep_expr *grep_not_expr(struct grep_expr *expr)
-{
-	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
-	z->node =3D GREP_NODE_NOT;
-	z->u.unary =3D expr;
-	return z;
-}
-
 static struct grep_expr *grep_true_expr(void)
 {
 	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
=2D-
2.34.1
