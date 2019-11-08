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
	by dcvr.yhbt.net (Postfix) with ESMTP id 053E51F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfKHUZd (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:25:33 -0500
Received: from mout.web.de ([212.227.15.4]:51019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKHUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573244725;
        bh=alkxyPvDiVWXF0mb50vk666MlcI34uhd4VBNjNvpbqQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=FInoUiNcgTCCGzqtt+V76cjogyY+yB2vwgfO7X+YJXuSWx3aHWuSVMhmTU7NYPiBW
         c4kZQQyuLqCxb/GVG6zHxHsZilbYYdOnnsPUulVA+LgWRypDTeb6xPvPsQ1dOX9Csk
         0R4kJ9+PyT+U2SJEDCyoAy8ruFL8KSCk7pO6xkZ0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4Zps-1hhfw10xWm-00yk2F; Fri, 08
 Nov 2019 21:25:25 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] utf8: use skip_iprefix() in same_utf_encoding()
Message-ID: <b27cc95d-8cb8-db49-c2d1-3eb591624000@web.de>
Date:   Fri, 8 Nov 2019 21:25:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:20JnqEV+YT0/hWUvDCkrRybuamXPcgngAys/DH+62PjQe39sJi5
 YnfuMAmwWdAfsX1sVqSVndcuc1m7Vv4R+1LHTQIpcKUfS7gcybRu7KQy4hSU+IHnUfwZkUb
 mL4VjbsPgfkbYeDaGiP54VhqoNdIXjwdd8s8JnZz2frgf23vjrBdK5Ol3MEKO1cQzSOyzFa
 fJdc05/cClqlJGN9XxQsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kjDhmo6jEgI=:Aky7ami6itjIlNkN+8CjmL
 Z99ZNrupLKikn0WLakFPOwMsrUUA9Y1zGPu0qqeaKrVbe088P89JF57toWvNtehPBEynEDln+
 R30TpXu77yvy1D71tTNP+i2e31MUIz6OaS1D2JOV4wVSpx3Gs81hi1uGrQ27xk/BXqu2YDfu0
 nyEKDW8wCi3B7FiFxomu3z+LTTOLSP4mFpk8qZpswyw2bxWgOpL0qXGI434mr8nxsgisd3Jsq
 o1Op1II+Q6TIcaNC/PpwG9NB+c49HUFufmo6++VKrwK499Y1CgDTk4vqGufmCfv7C2XuNEjvI
 78PU0Hk05SUaQMKOYGVeT79PYqjgiAdz5908PUu8dI6zLyu0OCXAL0hm7Up5ILAck2yqGZViw
 yvOKebmjtrSrdLl4e2JfXzKKf7tDm5EVojiyp+8ZebD6bkCr4op/WpNIvbR7xgWWL2XRoamOv
 f3akkxjI8oyPVva4mVr0893K1BMqJo2ACVxFNHfEn/++b86+vDTqVEUDzqigCT5X8Kc9hlui9
 +vDVX8bp1c7KMAMPM0xDCLSHM4aJ+clGUStXTMLRupENb83jFD+axYLb+ahBdPdvakuM5B2fz
 OcN8KHYReNc4Y3XD+VDjpgzCYb7gK/VCKXj6sBSbWCG69JsvvbdcrWxn90h4ryUNPvatQuuB6
 0h7qRuP+dJ+SeAaf4uOoms2/lX/xj6nfCd5N7O4ARwKxmmN8X+SH4WMRnViAXLG8AI6dtjmFO
 cchxK+VSyaegn5lePeVDqCoMLDB99iAwtomNmi2ddF7M7aO66AyvANwHvQ4+2W8wDIP7gqGjK
 EF6JgS2KuvK6H8nPJJyTroxsg+Waho4O/OSQYqexqk5vEzA10NihMEZbqifkR3sIP9FjPh9XQ
 wRRKPH0zowbAqiuWzrngBnCyQO7wgZDNEVU1sBU7Uv+fuKRACtUn5+MYc1b/Ow9uHItNW3qgR
 xg6mxsT7QI57oMglhAeTx7z28zRq7XVA1miKPBbSDL29Vq2pyv9DLDgWGJ9OOUtW0iYGDo9VF
 S08Ria55lYBRQJi5F134R9reQmhGuy7N6I8UkU2Jznli3ppB95HIBXEUZTwUKKgsON5yh8tdv
 udEZrwanix8hKhV4fMeVFN6/WFag7tbGN5boF2EMDhU10bNRaLjo24gjJocU1JDwOhc2xLAD9
 UydbgXj2PdQritvEPFkveVRDunGDxyAxsJZp4zYlOLoZ1l9baGi+JeE5ZMqv/rfrueTxwJFTe
 LXEsJH55lNStp+7PF4l8rcj1PGzTjTg7aR0ixmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of magic numbers by using skip_iprefix() and skip_prefix() for
parsing the leading "[uU][tT][fF]-?" of both strings instead of checking
with istarts_with() and an explicit comparison.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 utf8.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/utf8.c b/utf8.c
index 5c8f151f75..5b39361ada 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -411,11 +411,10 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int =
pos, int width,
  */
 static int same_utf_encoding(const char *src, const char *dst)
 {
-	if (istarts_with(src, "utf") && istarts_with(dst, "utf")) {
-		/* src[3] or dst[3] might be '\0' */
-		int i =3D (src[3] =3D=3D '-' ? 4 : 3);
-		int j =3D (dst[3] =3D=3D '-' ? 4 : 3);
-		return !strcasecmp(src+i, dst+j);
+	if (skip_iprefix(src, "utf", &src) && skip_iprefix(dst, "utf", &dst)) {
+		skip_prefix(src, "-", &src);
+		skip_prefix(dst, "-", &dst);
+		return !strcasecmp(src, dst);
 	}
 	return 0;
 }
=2D-
2.24.0
