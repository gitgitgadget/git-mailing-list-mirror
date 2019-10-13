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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFDA1F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 12:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfJMMt4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 08:49:56 -0400
Received: from mout.web.de ([217.72.192.78]:54081 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfJMMt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 08:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570970990;
        bh=vtybe+SqnjvzSpHkdVvNNo3KwnkS8IElkvJho5b1cHE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=llRixqbpvmVnDzLingnchsLFchp9axtgEf7RM4BHOFdi4xdsdTZFTJTIjnuxkKhyv
         EV5N+VUUOA9QZRvOQATTWSEJwXHd7B8y3OpOYlM2KTSEWyblOMNz2BSIY/fvKE/0re
         2eaMMu05+uW0N/7VzVLNQkcrirVuzhBoxGjD+KL0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls95v-1hvwFl2aYp-013t66; Sun, 13
 Oct 2019 14:49:50 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] column: use utf8_strnwidth() to strip out ANSI color escapes
Message-ID: <9b3f6960-ea75-c3a7-3a24-0554320bb359@web.de>
Date:   Sun, 13 Oct 2019 14:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qRmmnHy3IaliOqXY6IGA13mA6heya0Tak9ptWl1WAYvaIlzlnAz
 0yAsSMAMCdbmquaaP6tmFuXoY3CLJAyyvunRHv5o4CL/VEpfQvjeLTnMHxwsRk8QO5vl4ES
 YXTQIwBpKiU6Ye4dSVZUK+NrXDfB5XaEfP/ruLQR9GMCJ0K7vTWE5SUmmML1PXkMrecQv7N
 rG76y01jNGSQK+FIp0WUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z/VjRqrFPZQ=:xqOGU35ymOSJ6uF+xYMILh
 FnwowjVkMHTOVA3rNeqhUXxUOasur9l5+ca72oec99IH9CVfIBWZpMleOgP1yPvBcgKrMS8MW
 LEqs17quhtFymlKAZodigAVr1ESbGxdrCFeJ2asgpN3ybk8G/bAEPt5rmlhdiY8Xx5jAb4KeK
 iPBakFMdmNcCOohb4+Bx49BzwxSuUrCY0X8sn1LSOkju+IcSgV8GfBtLT27mVNuJQijnC8Y8p
 Heb5qiSBbmAfw+JAjqh/CxatNhL8l1gWc2tnFl+gBEkFX9uDrWFKKT9Z5R08+XDdS3kZ/gipY
 OzV+Laqi1jts8Af6Y7f4QCztBeHzJ/Ccq6krsarThpKjtkVQsNwZq3jJmqo3f2CidtMLh6DiI
 xGiUDHwcrKyP2Q/LLguQ9NOktAv0p6xmO+JogOtsaGuUlzpQJo2bTzFzgGSV/fBRa7aK+kNX2
 SmMW2fxqKVzaqtcUCd3b0boZ4F9oqAA+/2xWsbgW1Gm1HCNxZat2dI8smjI1LyApojsGQyLGK
 HINXzr6qdobDfBuYWtW68CDo53nAs2GObosVOiNidE3VkQmZISAgBTiNd6ebhw7cnpw4LvBVf
 R3CccYOqCjGrdkpq+uyfFcFA8NHiqnzGh5u9KKrPj6fHy+u7KG/RTSYtO34A4EMF//NvRoOP5
 WXoU5Nd7CJc39/qLOC1Y0Jl1r0ecVRe6aQByP4TE57VgNvUvQlYSnbtf98bAc/cE4F8qkHauC
 r8OexwDdYVzg4JezMqM0xdK9h73I59ldfEVLMLhPdda8YaB+Jm0CusTu18y/5wQ2bShmaii37
 uUmSf5DfGxjIv+AvqRO3cZeSZwdZYhiBE0MJH9wE0uV6D2LuCo21bY+sle/jptKNhhLWV2CPU
 qRb9P3v3hFbBUDPR57kZ2s89tcBxLhFiTOAvbcJfuXpJRXM7hHofWO5axypCAZe1c/xB0arHM
 5l1jpLo1aTnBRpBJbVCPnJnymozZCVTC2oYivH6IQ15jtooMJZTBSFeu+Li4Ii1JNFUX+oar8
 iH7kMSQHiP9Z6LR2GntI/15UwkKpO8k6QCfCYurE6g9M5nVJwW3hbshwmH/SMIZ8un6d7VWul
 wAqJ5Dy1XN24c3GIoGWq+Qd9RUZim6J/IrZK6bGDQtsIiHQGohoerUyUj+cOVTt7R9GuJ43X9
 VlfwwL7LbCgGuTKNI9lFoV85ZJ/wwPNW/QcCN5r1yaPMVcoa+NEj7roRUTSX+cHdUfg+eEwuP
 dlFaCC91eAbB40atsR9V7XXMNIgyCyT7I2Wfo5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of utf8_strnwidth()'s feature to skip ANSI escape sequences
instead of open-coding it.  This shortens the code and makes it more
consistent.

This changes the behavior, though: The old code skips all kinds of
Control Sequence Introducer sequences, while utf8_strnwidth() only skips
the Select Graphic Rendition kind, i.e. those ending with "m".  They are
used for specifying color and font attributes like boldness.  The only
other kind of escape sequence we print in Git is Erase in Line, ending
with "K".  That's not used for columnar output, so this difference
actually doesn't matter here.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 column.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/column.c b/column.c
index 7a17c14b82..4a38eed322 100644
=2D-- a/column.c
+++ b/column.c
@@ -23,18 +23,7 @@ struct column_data {
 /* return length of 's' in letters, ANSI escapes stripped */
 static int item_length(const char *s)
 {
-	int len, i =3D 0;
-	struct strbuf str =3D STRBUF_INIT;
-
-	strbuf_addstr(&str, s);
-	while ((s =3D strstr(str.buf + i, "\033[")) !=3D NULL) {
-		int len =3D strspn(s + 2, "0123456789;");
-		i =3D s - str.buf;
-		strbuf_remove(&str, i, len + 3); /* \033[<len><func char> */
-	}
-	len =3D utf8_strwidth(str.buf);
-	strbuf_release(&str);
-	return len;
+	return utf8_strnwidth(s, -1, 1);
 }

 /*
=2D-
2.23.0
