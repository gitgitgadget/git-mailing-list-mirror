Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500641F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJCUBU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:01:20 -0400
Received: from mout.web.de ([212.227.15.3]:36641 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbeJCUBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:01:20 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LilMD-1fZkJl2AlJ-00cz62; Wed, 03
 Oct 2018 15:12:52 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LilMD-1fZkJl2AlJ-00cz62; Wed, 03
 Oct 2018 15:12:52 +0200
Subject: [PATCH v2 1/2] khash: factor out kh_release_*
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <054cf3b9-e915-2669-0e24-a08f7dd1f35d@web.de>
Date:   Wed, 3 Oct 2018 15:12:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7S2hBB0o/LroOQv6uxYc0ezOxFJK8TeBPSw4CsGi7GJga14Ul7F
 gmVle8ok3IxNvMxJGWdsnMTCiEfrdD0klCzxv3iMFYi755hqgypVjsmLkoOAWFelIvADns3
 yPy+T5ym6Z7LdvcJ9E6xLUmMHhy2HgD+TH2yg/ewu3Q8eE4qnFRRsJR3uxqKmio4FnAVb6k
 Z3WwIJVev/jLkveIizfVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SVrRKmLMxQU=:LFoTBKoS+ttS4k09DXIPRu
 YZClPpmyMGOnG/HTv58VRssE4Hamr+z4CNXWzIAky4QBtr+zpkBCkVh3fZFqJzDiwr3CLx3tQ
 MDj8hLhkac01l3c4FKyCZ3RnBAC0K+XJJmHf2NBrdObdw7Iiw2GdM5yHRMlIVW3VWIlTNf0zL
 KBYaAE51uTmLH9FT90V61Th3Hiv2/OZcCGJ+JnjQiUAD+/jlr/HDWk6fq109ms16Prvu1SJwt
 CgZx4LO1mUNYErtsvFhC2mCa8ScRCZB0DsLRcZmloaTmV28yNGo/4bzyTU/0S9uyHx9DNaMcZ
 6jL/ABYPF7Fk/A/boJFwmqFj5JOjp7+TgeqXxLp6ayL3DcDU4V95tbz7Q1hDM8SczdCUVUqxf
 q3Ssvr7k915Mi8nFXnHEe41TzDjsNnYmXa3tlQwAkTkZzxU6nBf381macp/wl0lRXV95MNjjI
 LT74EapCO5JRNYaAdUj63CL7jpu3CgzbawSzmyUEMh2UCDUUcC6lyiJk+EgWr5y7w+x1eL87h
 e0CVxFedbpURjAvNmp0vgegFHZhq5AGz08z4h3548plBjHGMe+JsVhVveKKuHFdA4NLNiCuW8
 yRqJJFJyL1J1VF2H8BRbc0XkSp9CIdblEZtuYaJ3VeVxlrTf9Q+sljxrLIkVug1eW027geoji
 sQWwU7yf1Ev9/vFJvsfo+6JymD1Kz3OTdOvx4lY7+pBcUMTrkrfNobaqz0FdazYqvbPgEFHcw
 bTprkKQy5rN7ibzQ0e7i1qOHg+eUM92c3r8J75sv8yQfH76XHzRtU1fH+k6vbPiI1IFvsJfi1
 K/ek9NNXWWn73Pym0K+vBERkCrPCNMj0yco4kkQFQtH5iFwy98=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for releasing the khash-internal allocations, but not the
khash structure itself.  It can be used with on-stack khash structs.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
1 tab = 4 spaces here.

 khash.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/khash.h b/khash.h
index 07b4cc2e67..d10caa0c35 100644
--- a/khash.h
+++ b/khash.h
@@ -82,11 +82,16 @@ static const double __ac_HASH_UPPER = 0.77;
 	SCOPE kh_##name##_t *kh_init_##name(void) {							\
 		return (kh_##name##_t*)xcalloc(1, sizeof(kh_##name##_t));		\
 	}																	\
+	SCOPE void kh_release_##name(kh_##name##_t *h)						\
+	{																	\
+		free(h->flags);													\
+		free((void *)h->keys);											\
+		free((void *)h->vals);											\
+	}																	\
 	SCOPE void kh_destroy_##name(kh_##name##_t *h)						\
 	{																	\
 		if (h) {														\
-			free((void *)h->keys); free(h->flags);					\
-			free((void *)h->vals);										\
+			kh_release_##name(h);										\
 			free(h);													\
 		}																\
 	}																	\
-- 
2.19.0
