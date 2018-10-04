Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37341F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJDWDb (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 18:03:31 -0400
Received: from mout.web.de ([212.227.15.3]:45357 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDWDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 18:03:30 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNLRJ-1g6ANa4BKr-006xtw; Thu, 04
 Oct 2018 17:09:44 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNLRJ-1g6ANa4BKr-006xtw; Thu, 04
 Oct 2018 17:09:44 +0200
Subject: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
Date:   Thu, 4 Oct 2018 17:09:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jtX6vYyEkBvGwyuP8hS4luFJMrxtB3Y1wfyi7MFqYO3t5pwqfws
 cXoFXBUOsV5zk4S8bKg2MJ59/IWvNt8joTwjwHVlUQcZBZqD1l0oIC67Bi43AsOcXfGP0eV
 sQJ4BX1gu1wDXNHfHP2tQd2Z+qKvNzyVuE3JUVmSAdiYsUnaiksT6TwQzdBQdlLHl3cavek
 jeUDr8kHo22YTvYxBeYkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EQ/nXDRTFV4=:MxTqSwUfu+R8H7OYzz3QLi
 Hk1ZmjbxUsKpRXIulUSGMlCciWGdSeCZGkHrRLcohTiMzonI+kIwiDoet/Hu2xZDM9HfGz54f
 ZHpq65bZwMuc9Zng5c0+2fWz6zG3dnjhYHaym+brK6DFrrZ2nJ6xxI2hmjpC/BCvfZiB/ADh0
 NIVwD+nGEWu7UxRi9m17a5H664HUYltMBImbJ0K6E2p6fIajLLPK0ERw6PRYilrooVxPjHTvR
 F56+W5OhtQNc1PI47BWzgQxn4/9aQXw3LqAKXh2losTrdWQ8KOmCDPBCT5NJp9er/NOfnYcyv
 fXZ45im70hJ3U+Om6m6yxDB7GJ86Lv2eoNryXCuhylr2AU5a2e1iMEQxAqVZgITbqd0eTa1jU
 jywmuoYjyXqC2UNPCmwg8vnPBJrpoK2ek3JTpF7gdTkqoipKM90KHe/knZmuFzY1R+Qb/RgMb
 cMe+jg8WxE80d+EE2e//Au8tI6tICO748ybHTPyOxvZEZ7Ycj9i09Fstia3B0P+1Vfu8Yvpc3
 rotI6P9S5h6GQDLYRuKqtdeQ1KKGqPdRnTk+39npdKOkjBpWS66govENPBp3xceLED5qdnUwY
 loG2914eBlgphTXAv+Xr7N2H2pkuqREv/3zNfVfmqszTWWCdf7xmtgIGpuY8PEX4R3xKDxG57
 92i2j2iwys5g2WGeXwWzi4LxJpBOX9GZjgp6nmeZRwdvBlrtUxdUMt2q1ltFa+C5PbxN0jWn9
 hpQBqaUiuPWkqH/Rbm8GMWOtsw4z2lkYyd4Z5z9MrCIPwqGiUWXU5qZWqXpnSfoFWkuq5ydXX
 WQbI2RNYDhsmYmakKpiX8PfPw6c6bNLHWnPqO4/fAWQ/tgFYZA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tip_oids_contain() lazily loads refs into an oidset at its first call.
It abuses the internal (sub)member .map.tablesize of that oidset to
check if it has done that already.

Determine if the oidset needs to be populated upfront and then do that
instead.  This duplicates a loop, but simplifies the existing one by
separating concerns between the two.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fetch-pack.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3b317952f0..53914563b5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -526,23 +526,6 @@ static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
 		oidset_insert(oids, &refs->old_oid);
 }
 
-static int tip_oids_contain(struct oidset *tip_oids,
-			    struct ref *unmatched, struct ref *newlist,
-			    const struct object_id *id)
-{
-	/*
-	 * Note that this only looks at the ref lists the first time it's
-	 * called. This works out in filter_refs() because even though it may
-	 * add to "newlist" between calls, the additions will always be for
-	 * oids that are already in the set.
-	 */
-	if (!tip_oids->map.map.tablesize) {
-		add_refs_to_oidset(tip_oids, unmatched);
-		add_refs_to_oidset(tip_oids, newlist);
-	}
-	return oidset_contains(tip_oids, id);
-}
-
 static int is_unmatched_ref(const struct ref *ref)
 {
 	struct object_id oid;
@@ -563,6 +546,8 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref *ref, *next;
 	struct oidset tip_oids = OIDSET_INIT;
 	int i;
+	int strict = !(allow_unadvertised_object_request &
+		       (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 
 	i = 0;
 	for (ref = *refs; ref; ref = next) {
@@ -599,16 +584,25 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
+	if (strict) {
+		for (i = 0; i < nr_sought; i++) {
+			ref = sought[i];
+			if (!is_unmatched_ref(ref))
+				continue;
+
+			add_refs_to_oidset(&tip_oids, unmatched);
+			add_refs_to_oidset(&tip_oids, newlist);
+			break;
+		}
+	}
+
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
 		ref = sought[i];
 		if (!is_unmatched_ref(ref))
 			continue;
 
-		if ((allow_unadvertised_object_request &
-		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
-		    tip_oids_contain(&tip_oids, unmatched, newlist,
-				     &ref->old_oid)) {
+		if (!strict || oidset_contains(&tip_oids, &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
-- 
2.19.0
