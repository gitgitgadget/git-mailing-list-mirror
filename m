Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433CB1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 20:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeJFDNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 23:13:52 -0400
Received: from mout.web.de ([212.227.15.14]:54805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeJFDNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 23:13:51 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaqwS-1fSd8o36JE-00kLzX; Fri, 05
 Oct 2018 22:13:26 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaqwS-1fSd8o36JE-00kLzX; Fri, 05
 Oct 2018 22:13:26 +0200
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004213813.158688-1-jonathantanmy@google.com>
 <a82bf622-8ef8-5525-c3a8-b983d0cfe662@web.de>
Message-ID: <413be4ec-2473-c971-8545-3b7effbc157e@web.de>
Date:   Fri, 5 Oct 2018 22:13:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a82bf622-8ef8-5525-c3a8-b983d0cfe662@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3j6tTUoQEk9rkQACMGlz1aS29VqXtSUzNF60N1AoVZfsRHzBIvQ
 awW9DzMcGoOR7Lc5ilbCld2QrRO4ArETrdPfx4vVNLAf/+gd6hjygx237ClPDnsDYv6BExG
 9Y7eyxPagUmn7LQ490RoiBFVgceGelfpVjOHbQiL++gNFRSaDdrQJzipDMfz3urtpCe+h3t
 0qBiSAIbom9AxbAGTUhRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5jEoDFG7TLQ=:E5cl97UkYetsIhlI8ka2DX
 2nOLt7ebLUoNaeq9MFrYznu55d3vlKJBa2kJrxPCfnZ0SifkODu6Wl4kh7Dc3wHpah02wgooP
 fldU8X67hXlsqeZsAOfZcAlPTwwiwMw/EXHmRKHGj8vbsAq8az/a/ivb91n3Q1AG1IJZ4ksjI
 sNdxFypDL3t1mk2bL/eWEgJwtlZKsSATyR/TUhEjqWlBG5whielu4Vwn/y69M3SUETov1bU06
 Fq5G4uW8kTdB5V4DUXM1Hbf9pV1d1i5nL4x29HqYJWL58yBgF3Po+KlQleOFpiI8YBcCJp2G3
 zGz81O3KSFqscKdw2vNH6goQSSuAvIu9za8HLmP8GSZskhV2IXkAq5v0XeI4S0RwneVgJ9ybb
 vxhJI1cRAT/iB3/Hv5jdnJcgKksrWQV3u0uXAEkapIGRdojMp1acWx0V0NqXLID33UDpsVdmI
 /t+6f1JkeYD/4yQxNNZ2stNA/JpPD5/8usM8PmXiXuI6VJZoHEzQOlRlWrp+/CFUUVh7B1KI5
 P0Ae24DXcSQ2orR9ZDFPFmmZszjoGSFqgMmJZSRAu4MFUwiabtIZnCQ97wEKg1OS/Jw3ayusy
 /Tho8oSsK3V4Pb+cRLH0Wtq3APiSqobvM2EqOl4A29AArR32wilQLol1jXFeGg0Hg8+WQYgvh
 Oymqm65Pw/1mqA4qNisLp4AiHm2u3SnPTZ6TQ8lNHz2Dprx3Wd8RNOd1IaCSbVygHRzB+ogQE
 B6/Uc0PjBmgo0BHyFn0P0oEx/OG90uz0rxPBRjHQzgBv7l+bPp5251qOj5caserNcd5K1KysG
 kMVS/Geb7N4U+Xnvjw3o1TeL6xhzwfAAd7fny0qGptyLDtVcpU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 00:11 schrieb René Scharfe:
> Am 04.10.2018 um 23:38 schrieb Jonathan Tan:
>> I don't think the concerns are truly separated - the first loop quoted
>> needs to know that in the second loop, tip_oids is accessed only if
>> there is at least one unmatched ref.
> 
> Right, the two loops are still closely related, but only the first one
> is concerned with loading refs.
> 
> For a true separation we could first build a list of unmatched refs and
> then loop through that instead of `sought`.  Not sure if that's better,
> but maybe the overhead I imagine it would introduce isn't all that big.

Here's what I mean, on top of the other two patches:

---
 fetch-pack.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 53914563b5..7f28584bce 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -543,6 +543,8 @@ static void filter_refs(struct fetch_pack_args *args,
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *unmatched = NULL;
+	struct ref **unfound;
+	int nr_unfound = 0;
 	struct ref *ref, *next;
 	struct oidset tip_oids = OIDSET_INIT;
 	int i;
@@ -584,23 +586,19 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
-	if (strict) {
-		for (i = 0; i < nr_sought; i++) {
-			ref = sought[i];
-			if (!is_unmatched_ref(ref))
-				continue;
-
-			add_refs_to_oidset(&tip_oids, unmatched);
-			add_refs_to_oidset(&tip_oids, newlist);
-			break;
-		}
+	ALLOC_ARRAY(unfound, nr_sought);
+	for (i = 0; i < nr_sought; i++) {
+		if (is_unmatched_ref(sought[i]))
+			unfound[nr_unfound++] = sought[i];
+	}
+	if (strict && nr_unfound) {
+		add_refs_to_oidset(&tip_oids, unmatched);
+		add_refs_to_oidset(&tip_oids, newlist);
 	}
 
 	/* Append unmatched requests to the list */
-	for (i = 0; i < nr_sought; i++) {
-		ref = sought[i];
-		if (!is_unmatched_ref(ref))
-			continue;
+	for (i = 0; i < nr_unfound; i++) {
+		ref = unfound[i];
 
 		if (!strict || oidset_contains(&tip_oids, &ref->old_oid)) {
 			ref->match_status = REF_MATCHED;
@@ -611,6 +609,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 	}
 
+	free(unfound);
 	oidset_clear(&tip_oids);
 	for (ref = unmatched; ref; ref = next) {
 		next = ref->next;
-- 
2.19.0
