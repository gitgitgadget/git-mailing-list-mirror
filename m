Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AD11F404
	for <e@80x24.org>; Sat, 24 Mar 2018 16:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCXQlW (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 12:41:22 -0400
Received: from mout.web.de ([212.227.15.4]:50565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbeCXQlV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 12:41:21 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqlAw-1eLkNo21q6-00eJQi; Sat, 24
 Mar 2018 17:41:10 +0100
Subject: [PATCH 4/3] sha1_name: use bsearch_pack() in unique_in_pack()
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     stolee@gmail.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
 <20180322174010.120117-1-dstolee@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <71b5cef0-abad-001f-6a23-3f2d874b9709@web.de>
Date:   Sat, 24 Mar 2018 17:41:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180322174010.120117-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:h+s4ywDmz/SuPbh01nREwvVHx3T1T764xzbWSv51xJ7UQQK0ZIq
 PoOPH9qLGF0sy7BLIl2l2gKBJwECXyxDr22MQcu3BjVlJo7bp4UyAa6ko/GsFAIjmy0rbQB
 oytZOUJbeLTaOOAUX1h9uLmFdUH7y189AZfE0sz17Jml+EhGjqOI0t9FDnHV4SgaWQhhDIP
 WF1HWP2sXyWX/iF5K5Y1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iLCtdS8tcaQ=:egNzfQKtp04hiod8epetHg
 26TFYUb+44jMMlZifAJmCueEkWaDTngAm5RYHMXNtB/ZJecfaIrOfMhh0odwuCeRyXQkHHOy0
 WzXxlHusr72nfbs+kRb+zl+0fox+xGXgp/h94dq+mNoeBJRvyIvFMyIJqYKQg7oRp00aFrW2P
 QctKIQ5/Lk1cVssKrgoB8d4TRcS10CX9qErxlwSXhNxm+UtB2T8kThs8ok6Rpg74GF6qhSx0i
 mFAHoIzKALTKEdsuw/zZJP+fbWCqSLQ/cL+YWfCRTz137jGUnpo/4b/a8YIElPGQQb2EoephP
 uMfLXw3njoNUamb3d72HbvR3hDxbE0e/uyTpCO/rveRs9Yj8nX/sAc95dBEFYM7vPVHJTjDlR
 Jy2YJKWotoNa+3mjsMkT88VOEaavQSH2056cHAF2DML3W31E6EjgpaKlJ/9iY4Y8M+D3hYNfc
 imvLTKvvJ2V0g9hknKFBgc9tsU4qOKp9pltmfrJyumlxfeaDAxNs3u5MShGouQJzKAns2uDZL
 eTMhE2cyeP3VCF+rTrAWkrfXpx4UY/ucN3+zQXXUd4Ct6zDUPraZAZC9mD8X8uvXZDE5E5I06
 gVq3PYShwUNZIjikYp42tPTUxXfC6Dffuax9VYydmAmWBImWndhTRpBGEpimsW53nylZgOIWm
 VNlxs6N07F7cJw5eAgVfqArVNhTPysgvlSG3TqzmXrM58NV+zlPy7NAvIre0gyRjMASDiZH75
 +tXqJXvIEAbJGH6rInWn+z1Nx/iVMPt+pOqiaa1FVGUzymn3zqMHDYpkAr1aoodUF27OFM5BV
 lkxxUR7MiCBMSzKyCPrZgcCo+ffEn/yvvxj3XxPz/euf8v7Q1o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the custom binary search in unique_in_pack() with a call to
bsearch_pack().  This reduces code duplication and makes use of the
fan-out table of packs.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This is basically the same replacement as done by patch 3.  Speed is
less of a concern here -- at least I don't know a commonly used
command that needs to resolve lots of short hashes.

 sha1_name.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 24894b3dbe..0185c6081a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -150,31 +150,14 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
-	uint32_t num, last, i, first = 0;
+	uint32_t num, i, first = 0;
 	const struct object_id *current = NULL;
 
 	if (open_pack_index(p) || !p->num_objects)
 		return;
 
 	num = p->num_objects;
-	last = num;
-	while (first < last) {
-		uint32_t mid = first + (last - first) / 2;
-		const unsigned char *current;
-		int cmp;
-
-		current = nth_packed_object_sha1(p, mid);
-		cmp = hashcmp(ds->bin_pfx.hash, current);
-		if (!cmp) {
-			first = mid;
-			break;
-		}
-		if (cmp > 0) {
-			first = mid+1;
-			continue;
-		}
-		last = mid;
-	}
+	bsearch_pack(&ds->bin_pfx, p, &first);
 
 	/*
 	 * At this point, "first" is the location of the lowest object
-- 
2.16.3
