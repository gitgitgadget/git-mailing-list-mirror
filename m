Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0C3C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 08:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F2420882
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 08:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IHIXzXN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgKAIwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 03:52:18 -0500
Received: from mout.web.de ([212.227.15.3]:36657 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgKAIwR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 03:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604220733;
        bh=g/yPg4qiW1lJU/wkC69NmxFjLyqqOg51xgO8rcewBtc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=IHIXzXN1VSyOkNBYxd+tnfsO19yAV2yumAzvX/1yjAl8+2f+59Dmcd178+C9Rv9lP
         ajPY4VSqokM9KfGVN5/WVeAz1QDaG2fcFhqePfoYvgoPyCF6yriZQETLVKCUu7n/51
         v2pHvOADoHjPHdw5hCzMLpB/En4VyU8a0Jx1bfHs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlJzS-1jyQhP0nuo-00b64C; Sun, 01
 Nov 2020 09:52:13 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pack-write: use hashwrite_be32() instead of double-buffering
 array
Message-ID: <aec69531-d621-ab26-efd4-96e1ae0ed3a4@web.de>
Date:   Sun, 1 Nov 2020 09:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1PtRaepRIvax8bQ9C5WVU5xTSRkl1Y2cL0TI1BfAp/XTbs1T8Z0
 /choyyXwixAVTLv0MYdzaQK3jCNyaf6uoGPBmjy+CqTrILEmTG7LuLklkWx6eVLLSakEeNy
 WNyoNTttzGmKgAwFAIbhwbMX5jyZb8+5qD/rctOXbGpQ3x4pzLRw2ExcdmwbPQHu6v+0vRX
 TDCv59ebJMtQni2fcrNxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:22xUYg4C0VM=:egjKsCe31dq0wRfDfsPMYM
 5rYeyzn5xl9O13S6uEruPfPpsj4fR+hDKf5T00PV8HAbDDI95+1ms8Tgu5Ync4Y+xtV+ufx2J
 TchjRIIsPn6QwyOV/LSSxt3y06kGmdsdztuuTjCkipeRMtEh8uyEsWB5J+7b+JmJu4bUWTmBA
 PXDTsKAwO5CaZk9FT0ISurJrEG4fOP1xcPPLorGzQW4vK+UrRxxAI9yCHVGnK+JM2193iZobN
 vEdxbjWyb/CrZVUyDdBBnj0SFLfTocuKMnWahkGNBCOymU9JjNx6SYM6wvvymZqemfjY1151C
 hiKNrWkiul/scisBvpuEomBci5OqDAMrfw7zsairOurN+TEUBGWK72tMoO/UM6KwmoyxHV7+l
 S+Bejg5NIgdF+JO80Xl2y0pquRXkLBmF4+r3rWPaAD0GqnldQyVNgTWh6caFw8azypFNSKeRj
 k5bdSg3G2AhSp3clidXWAc9ErbDxKpLVQDmhxAfnNNVjBGMu1OBoCjOIey253Qf93nmf7zBrx
 eoe7LQKWkHUf2JGxhaODeVdVWIMtMYaLFtw+IzGYFaI0KJDvAGAqmFde05TsicBLeuB4dV9X+
 BtTfUkLLd4LSE/STxnjfSt5JLADPfq0BYYrwGI1ykfx9Qi2fjfHVsDJk9wMxW6yGFl8bZHasF
 ygoMIaLD8J3S819nZxC2RZTo/n5pKtAWq4h1T9cN4wKF8qMFlUTWxntQwDiU4+lUck74IimdN
 8grEOjZvS7M3QOvvyucvnGofr2r5tg9zM4xfVf6smYWuAIfA/pcyRc1fxatFH0BZswJxC7rrj
 i38Tv9mT1baduDaswgwksT2crm++TxYXQJK1QabebNZQnkl4bJIS+gNp0IKevIcOtuTVeKM8m
 8S0DgIieqTKcY+SOoKJg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hashwrite() already buffers writes, so pass the fanout table entries
individually via hashwrite_be32(), which also does the endianess
conversion for us.  This avoids a memory copy, shortens the code and
reduces the number of magic numbers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with -U8 for easier review.

 pack-write.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index a6cdb3c67c..23e19cc1ec 100644
=2D-- a/pack-write.c
+++ b/pack-write.c
@@ -43,17 +43,16 @@ static int need_large_offset(off_t offset, const struc=
t pack_idx_option *opts)
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry =
**objects,
 			   int nr_objects, const struct pack_idx_option *opts,
 			   const unsigned char *sha1)
 {
 	struct hashfile *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
 	off_t last_obj_offset =3D 0;
-	uint32_t array[256];
 	int i, fd;
 	uint32_t index_version;

 	if (nr_objects) {
 		sorted_by_sha =3D objects;
 		list =3D sorted_by_sha;
 		last =3D sorted_by_sha + nr_objects;
 		for (i =3D 0; i < nr_objects; ++i) {
@@ -101,20 +100,19 @@ const char *write_idx_file(const char *index_name, s=
truct pack_idx_entry **objec
 	for (i =3D 0; i < 256; i++) {
 		struct pack_idx_entry **next =3D list;
 		while (next < last) {
 			struct pack_idx_entry *obj =3D *next;
 			if (obj->oid.hash[0] !=3D i)
 				break;
 			next++;
 		}
-		array[i] =3D htonl(next - sorted_by_sha);
+		hashwrite_be32(f, next - sorted_by_sha);
 		list =3D next;
 	}
-	hashwrite(f, array, 256 * 4);

 	/*
 	 * Write the actual SHA1 entries..
 	 */
 	list =3D sorted_by_sha;
 	for (i =3D 0; i < nr_objects; i++) {
 		struct pack_idx_entry *obj =3D *list++;
 		if (index_version < 2)
=2D-
2.29.2
