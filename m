Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE777C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302F522228
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 12:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ARmREpV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKLMWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:22:24 -0500
Received: from mout.web.de ([217.72.192.78]:33161 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgKLMWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 07:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605183736;
        bh=3DmjWsXhrOG2ANEyzudvJa2jzGCS1QxLf+oW6EJLqYs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ARmREpV1mNInSbgRq2jjCSSTnCw/KEE5+L32YMzY5oF5k4yutl8DjEePgdB+LR2ge
         tLWMXZ+hTV8h2+RTbbxRPH7W7+QKQoras+AE3y/hAgtqKJ/+dl97sumwXh8OB1FLYt
         4c92BVIh6EtFtuHEcSfbYNCRVwLjiwQcKGR4t4+E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlWGZ-1k3JAV2dWx-00bMwE; Thu, 12
 Nov 2020 13:22:16 +0100
Subject: [PATCH 2/3] midx: use hashwrite_be64()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Message-ID: <d38ac2a6-261c-4767-8691-8d97d551381c@web.de>
Date:   Thu, 12 Nov 2020 13:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Ai0HiMrURbhAp0PAojVMWuzVWeodad1vxFdFtMd0mUxH4nATTS
 Auz8IUfb2fZe78pqmWkVxybGaWTZu6JR18z/Bmsz8Oy6Er1psbfqEgvRgBj/paqzcsC5SrL
 Ib5N+Dt9dckmhPtUK4HhKxTtZE/0B0rJqcCHIg3KPdoDDqh7GAfOzMIZynJfnE75tm/VinU
 PtatR4BJfTmSN091o3lzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzX1l9YkQjA=:6h5UIS9XBfub9Y/GloVXfF
 zU8ynuOBU/5KIh27/yrlurC0wx3JsAL4AXsYXYG+3noH5j4fYh2f/vKuCeChSY/DCWFb2iBR2
 yBFu5bclmZNoZZ2GZ+pKncE7Wos6iwURI75bh2aN1IdzBT79rwCgZBad+hyJv4FOUguBuydq4
 W1D3RIIvAXda5BEwBkSLiZg3wXLU6Jg3efneY3SFROpGHrpY4HoYdxbrnDUfLndzFa1eSsOyB
 gwO32k3iAeznzcjISNO/BrQxr6vpk7S0WT8A0etfCKBi2b30G3FdfJc4Ky2dvBa16HKqyPyep
 EkwGwViszhRTc6irbs4gtGCayWaQ3eF/BDCV/tuAJcH7kMo/8yq183kovJX18BNhpz3ywjYWV
 ZoYyL4BY+oEtoU1KRU96hwRwVUBhH/wm0xkJpZ77/BKumRjbIyputtqd27NS6YJqZbm+uJ36T
 f3LbeH6bm2syUyuY3AezsR3syuI40fPqdiK+OTBNthpr9O7C9XYe2SYVFuDuLap4piuobbT+2
 R8kYOK/qifVQQz/Kkihg+8jOrn+sRQw7ETktWLjLOEmbdvrT7HgHgugk3fWHEtdFiOnyaRmm8
 EUIdxC2eY5dSChDLRr7vuOZUdN6Qlwhrrn6f+ioo9B2bN22mYsnRypGCiP0MWRdLivPqpgJE6
 8LkbRkYtwpkzkJ8An/MQxSI3KA4SqLS1msM7/V5qYsWl9WZzD3HW1TauYb/pucxrO3rwi4ha6
 LxgeM7r4YzQ0DbJMZ+ZFSOXzCpAXuWvyTnzH42fZakeV91rp0eo9MgfXDCuNFSZep6BXNUyZp
 gBqRj6/CXKKhjyRTF7EZIxGO+1zzNAjpgbg0FaUHv7vOYw/N/ELz64tvKLY0wrSDv0l9WM1R4
 f+J4ekJgFOqhj9RfcAJg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call hashwrite_be64() to write 64-bit values instead of open-coding it
using hashwrite_be32() and sizeof.  This shortens the code and makes its
intent clearer.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
And it saves me from headache induced by trying to remember whether "big
endian" means that the most significant ("big") digit comes first (yes)
or at the end, like the name suggests (no).

 midx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index d233b54ac7..da03c1449a 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -785,9 +785,7 @@ static size_t write_midx_large_offsets(struct hashfile=
 *f, uint32_t nr_large_off
 		if (!(offset >> 31))
 			continue;

-		hashwrite_be32(f, offset >> 32);
-		hashwrite_be32(f, offset & 0xffffffffUL);
-		written +=3D 2 * sizeof(uint32_t);
+		written +=3D hashwrite_be64(f, offset);

 		nr_large_offset--;
 	}
@@ -975,8 +973,7 @@ static int write_midx_internal(const char *object_dir,=
 struct multi_pack_index *
 			    chunk_offsets[i]);

 		hashwrite_be32(f, chunk_ids[i]);
-		hashwrite_be32(f, chunk_offsets[i] >> 32);
-		hashwrite_be32(f, chunk_offsets[i]);
+		hashwrite_be64(f, chunk_offsets[i]);

 		written +=3D MIDX_CHUNKLOOKUP_WIDTH;
 	}
=2D-
2.29.2
