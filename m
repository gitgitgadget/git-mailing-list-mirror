Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B1C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 08:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA576207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZTZKL6d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIFI7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 04:59:15 -0400
Received: from mout.web.de ([212.227.15.4]:45581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgIFI7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 04:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599382743;
        bh=Nja/3Lbg1ZLojgsuCdmbvBpvpnS0z0KSV1qZ7IjWOWk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ZTZKL6d1BKBiXo0Pcl7+9rmUhaL7UBDDYz9OeaplkXeOKvSnNXXImGokuGn9HjI5+
         Qh0RZAeQyhFBNtrX7HaZLW1er3GrTStU8GH4O7w2CgcsQDDjFntC7zxDW5539WRAZr
         K8QpCrB6zFnM27CA1bE84+0yV9apPbgoI41MvdY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1koSRh0Rs2-00Znok; Sun, 06
 Sep 2020 10:59:03 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] midx: use hashwrite_u8() in write_midx_header()
Message-ID: <ae03833d-d597-f902-38d5-9e67bd768d93@web.de>
Date:   Sun, 6 Sep 2020 10:59:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Olt4uSmlZo9e1aGd0TBV3PXiw86l6mVnzjZT2gmZR7NFktXV3Qr
 VtiJgDM+/Gv3m+ZaUMnchs0ywi+qrWe2kjp1DpcSGRK2CzdFCMfvcdgoLZrZwf9tozlPxW/
 ZnoSMWr0VgcC/pNlxqvHjx3bWrY4C/+uWwEjJ/aXVhxMCR5LQ2fYYxZ/yQg5pXODUewdoOS
 MdsLn4nm3JyIR5dOtr7Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9LQTAjtG0As=:jfRoxGjYljXDkHdDr+mbsp
 B6NfwfNtOemBhhzZHNon0zg/ScEZqDDiOCJTySsq1JeLxyzoAoxm6MhJIGRATsmWZzkPOAIn4
 Of1IyRoZYYCXKwvT0glMBKXe/0G2UeMSHmOqbV9q8qErNOndczwujzEVLg0Pnla7vyio6sVx/
 EtYKKug6E+jhoxGt5rfV/OuZ5b4iSIcIwgRMxKSCEfTXWQmwrKTuydDLi7/qAgoNOccIUhmP8
 PPqumGE92owBfvIZp0hxhLouJZdvzXicTFD4h3mnN4R/TsnXmPvq6tfu+LO+Ayv1+udIyEAxJ
 4cAVG4vVt5A4gzdgUjZcR4xxwMFyG9grlYjmq+Iwlih1017cU3hx0D23KgGPf06hSCbZcByoq
 Rw+L+jFAERAGFqfgr2rlatgmGKUmLWyyndW2XD0xhfIKMBRCkmb8r2HMpmbH6+D2vxCb4k5JT
 qTDWN0CMgxMcxNQBUY/LofJmXtuHmyx5XEfAlSQNVisVFT5GVCJXHTg8/85d9OMd+Es+rTZw4
 mwtk3ZDe1Jf0gjfBReU2lsdNBJHb25uqp4VxpiwBk1gLxN6WcjOjsOFkHR8LZSqBxgI0sdn+O
 979p08RBhsZmlWe5DJV09nkfcMscVWdYmXXuXfbWZweJG+bx9ps495uwQZsWaqVpMo5eZuQV/
 g26Mov4V6tJGxb0llSBwDyDJ8SkjtnqtySrfItW+S45j+4AWxBh63Jn3LNojiBCUWjOguq+EL
 9QZ2hNSqrd/KOju1s5fLYf3CQY2sWWVraMu/DzRyQlWKyl4JcBBBVuFoo36alr+OQiKmeIGOO
 4tLuLafSXf0yOSwOYIN3ctquIleAGyr1kygEtJPBwBZw7OOWQqhW2dv6flMLjp3ljVw0CAeSt
 Lsw3Ay9SAAshYJ4tnZNjxgywVgGclnZUgsFxmFwavnEf27YrjUf3n3H9eCS/Mcj7qHJunsXN1
 84FzqCLAtgQczUOtjdTUjPfPLL5xKWfDoCD8/1qIrlkEcYIYIp3XB63iRbCjidSix7GZ0lMGV
 8gyT4ttKIqfsTOgUuT3juqyGrLK/XHdjkY7rGpwyaaxjAgZqHnU8V6fG5ouBsJSzEj9aR6GLt
 +MxmVH7geMTdopH7RpBF0Sxds056tQ9p0jhDg+o62Tf7wVNa+kpir/inH6iNvaGOTywnokiTF
 6LpvEtDO2OrL4BNeckFNhnKWvHbbgkL51/83Prf2hXopX0y/8TiN8vEVdPpyFB7txE6Cgenuk
 cYOVXzIhiYv1Efk5h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emit byte-sized values using hashwrite_u8() instead of buffering them
locally first.  The hashwrite functions already do their own buffering,
so this double-buffering does not reduce the number of system calls.
Getting rid of it shortens and simplifies the code a bit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index e9b2e1253a..6326ae17c6 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -428,14 +428,11 @@ static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
 {
-	unsigned char byte_values[4];
-
 	hashwrite_be32(f, MIDX_SIGNATURE);
-	byte_values[0] =3D MIDX_VERSION;
-	byte_values[1] =3D oid_version();
-	byte_values[2] =3D num_chunks;
-	byte_values[3] =3D 0; /* unused */
-	hashwrite(f, byte_values, sizeof(byte_values));
+	hashwrite_u8(f, MIDX_VERSION);
+	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);

 	return MIDX_HEADER_SIZE;
=2D-
2.28.0
