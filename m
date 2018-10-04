Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352E11F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJDWEr (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 18:04:47 -0400
Received: from mout.web.de ([212.227.15.4]:34559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbeJDWEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 18:04:46 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvS5r-1fhaFN2v4N-010ZLG; Thu, 04
 Oct 2018 17:10:58 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvS5r-1fhaFN2v4N-010ZLG; Thu, 04
 Oct 2018 17:10:58 +0200
Subject: [PATCH v3 3/5] khash: factor out kh_release_*
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <46f34917-eafd-2970-17f4-c2df92a00352@web.de>
Date:   Thu, 4 Oct 2018 17:10:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:V6gOV89ppLTSLM6Q5AUmtH54iOKlKJl3NtwQE9al7MJ+oESyllg
 43Fb/0/UFi5YFE82QnsINK2w7hmohXKUxPHFDZ1gO27648Gqghn7lHHlLiX+KUG0Sqwqbk+
 y0WgwtuBhbK6MHgLsJYpKhNDuukkm8QKCiaGZvmGCnBbvTwQGhwcVi6FKiWSO08RzHQAIAH
 CgfHUukdGYQTcj04jR+pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uYg8tJ4M7KU=:ppnSHUxAv41Us73V3tBk8j
 gfcm+1MxBq15QnvFVFK9XguXyC3h4BcvAQtXLsfQ3zjtjRePE7PAVhhAadsOxc9ljAsSylKAQ
 viKanYsQM6By09YpvAI+LABZBAJ/K4QHfwlP+LjesY0wVtKWJV1lB0acUnUIFIYoP3MnJJ4Ie
 LJGwnmYPj9NmfXvQGC883LIaczl/b5VXYSmChGtMtE04q5incwhOBclZ+p8xm3cYJP/cNmO+n
 3tWec7OKizjzkJVDdT0vnm0+xW3CLyR7l0+SiA5lLPxXpRh2JTI4p/IiaR3fKX1SkueNRIhyo
 cLLDmR9JPVdws89QXqjBBoL84gWsP3oXllBvpyShJpS/kT4ekYeu9lEhJJo4GWGcdxBE4Cekb
 ASDNwZrRrdKaQoyFQ7Q5oryvGAKjqUM3jmzW4CSi94KLaGa5o6FVubxgHqLEXEER5qMWg2MLw
 FP1sS/QlLo619ytsGQVd0cXnmLURPdBs2cOgJrCrtNtUt17GwujuKwf1Zn3Zh+ltM2TAJCi4a
 EpZqL8m6cLt93FQN/wtuLFUcmCKcSb8D2et8Fwik9UqGeO4m4ZZNh8SeO2KikBXuin+aJqYJZ
 U2KUIYhAcY4jAMahwA+o6rupibRjyC73u/lkXHvQzrExin21sfIz/+y8xEKC0szyvB6FHUvQS
 i2uUYP6RxJD7V+NGOpvgldVPzX0JWVsLAPujES/0Gc83Utv4Aqy222wXROkhFJRgGTUUxvKZq
 4uCdOyd0fQrsYQB1i5NaO1HooZ9R/CEorBiBWALoHM2Du5zw6/0fxzP2UPNYEW46QbHE7gLJv
 cYpOTbSQLL0IzcXo6JGTxhKMIK9WLvHHVn6syGGFFp/Y7/34rQ=
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
