Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F8C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9C921D42
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 18:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MB1Jnl8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgISScH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 14:32:07 -0400
Received: from mout.web.de ([212.227.17.12]:35329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgISScH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 14:32:07 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 14:32:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600540325;
        bh=Ps8Zj8mZOmGvgQSMEYbdpl7ARj6UeEuHXu7p38S5LHA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=MB1Jnl8ot2NyyjmO9hh3CGFficPz2HLjeIs+mypLt/Mrcx1oVsiK2OkPgaVvEFkho
         2vlb5dXy0s6ORa5TsbVOJ0xNT9lR+kIIkFOp1GPlAr1n0gNE3sxIpoCZVpycEB3cxW
         Wa/Jckcy6esJjY4Zs/cwO4Nk3dF/LngJ73nt3dMk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZedc-1klMLc3tnA-00lVGJ; Sat, 19
 Sep 2020 20:26:56 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pack-write: use hashwrite_be32() in write_idx_file()
Message-ID: <4c561e04-7edc-448f-46ca-4d4ac33e9ab3@web.de>
Date:   Sat, 19 Sep 2020 20:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNhOv5fMRIdWqgdMOf5HiDfDOiuB8fOZuKDajxBXyuJm7F48hul
 16JgZN2IqscXfghhrVa3yB+9JeWbga5tj5r7GIax33fgXiZGZKAt4WRhAIvkk/CncRkA2h6
 NHoInPYSqpqtnSglCgOpmTHN5vNxofnnBGi94aS6akx3MvBYzAabONxVJZ+5ka+zP8+/9rR
 ACw5TzH+moljHiykXE1zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RR6SbXAd8J4=:XphJxjRIfcA3lvwGMROSZR
 G4y3dJHOtNWKqvFRMAD4frTjbOoKcSEX1+mZTERo4xN7LzWw/H2LCgTTLpVSDnk35HxxELUTS
 OgUy3JdcIys/5JaMxWUIAakDEDdK02TpzKGrta6F/Prmp7wBYEM/DnhPCSMSQkSi66BAp8l4G
 g9n7/4kNi1ZxLebI4+ZToNQDwJF1bECZJWme/Q5KPD+d16hYiMiSxbGqXBlshbEtph4rgnJH6
 WE7ZxmDGfNRCOKjszOJLO0FXly2eUu/gtq0XtTkABs8hP8O/IvDLgRtXT3v7o2iC78cw5Us+/
 9VZ23WWOZb4ARoGQfRzBqwj8IAigzlKn8naWGN/jXnUbed67jPugZB65nvqnPH9kbguks1dct
 HNudDtaL8NuqHbotNrkN5VwpvZ0jUskqkC3faDRMrqUAdMWSmuDhPagQcKBtzPSWW1dyXcLaN
 vKW1plj89hcyGJ1md3uNRbZrzlOC6LSpqssMfX7rJ9nMrC2vY/VaLn2WcnJgIFP9w3Xy69nin
 um2KVAX80F8TC+fwlWZ4bNfAAmmI/HxDpieXasOCX4jf/z/Z8IQn8jfTqHDPql6s1z8AmBnFv
 4yIAxnH/PFq9YddxwaFsfS/fhtJ/YqkUBeAo6HQRnIRBDnkfPC4KcWeAwTwdBb7Mewjmx8smU
 BP2epR70fBdGZfubqpzwZIo9c27PIv1y2kvwqyxds8X/J47qY4/2D38+/g2srfcDe3Xu0G182
 njSIVI2nzDAmdDWjhno50IyClF4DOpkOZedC78ftJqyEytkviJhRSzs2b+boDVlDOeLSBqgZs
 WqCymnPF2Oj6YwBPOt5QaI5dvvW+HN3ppzp7X82LekSnO6aPzqQffSBoY9J8UsQQL6xVxLv6F
 x0FYNI26N7ri3LD9OFaWl21Lfk9DSWeAsJRxAmDxdEHnmxiJHqNmK99cZMmKhrzctNM4cLqxY
 T7H3EqGeuTtdQvXQGHElBfBR5dDAM2LrE8XTFLQYcjSDh8C7ciVDBZ4YheL/vFkqui5go9a8b
 43pLcdUozGhElLqxlad+kTI3Q1c6lnugIerNCva5qtL6jkkaTs5YCDyxqfDVjpGSsTrZQNCIG
 49zGsJBrDs1GpzUYRfSeUeTtH9rGJknyTN5rUM6NXfw3oKvxK9SMwPoOFePPHm4gEoLefTnl3
 Nitnkz33Rp/YXTgCCKwm7oNTkMg3hvDPK1hcHjoWY0FpSV2RIK0gE2qHv8TVE7l51V6Fj59Gp
 nCniuXhXdf8jrljXy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call hashwrite_be32() instead of open-coding it.  This shortens the code
a bit and makes it easier to read.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pack-write.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 685d327d80..a6cdb3c67c 100644
=2D-- a/pack-write.c
+++ b/pack-write.c
@@ -117,10 +117,8 @@ const char *write_idx_file(const char *index_name, st=
ruct pack_idx_entry **objec
 	list =3D sorted_by_sha;
 	for (i =3D 0; i < nr_objects; i++) {
 		struct pack_idx_entry *obj =3D *list++;
-		if (index_version < 2) {
-			uint32_t offset =3D htonl(obj->offset);
-			hashwrite(f, &offset, 4);
-		}
+		if (index_version < 2)
+			hashwrite_be32(f, obj->offset);
 		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
@@ -135,8 +133,7 @@ const char *write_idx_file(const char *index_name, str=
uct pack_idx_entry **objec
 		list =3D sorted_by_sha;
 		for (i =3D 0; i < nr_objects; i++) {
 			struct pack_idx_entry *obj =3D *list++;
-			uint32_t crc32_val =3D htonl(obj->crc32);
-			hashwrite(f, &crc32_val, 4);
+			hashwrite_be32(f, obj->crc32);
 		}

 		/* write the 32-bit offset table */
@@ -148,8 +145,7 @@ const char *write_idx_file(const char *index_name, str=
uct pack_idx_entry **objec
 			offset =3D (need_large_offset(obj->offset, opts)
 				  ? (0x80000000 | nr_large_offset++)
 				  : obj->offset);
-			offset =3D htonl(offset);
-			hashwrite(f, &offset, 4);
+			hashwrite_be32(f, offset);
 		}

 		/* write the large offset table */
=2D-
2.28.0
