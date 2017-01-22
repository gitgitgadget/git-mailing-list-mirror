Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080B420A17
	for <e@80x24.org>; Sun, 22 Jan 2017 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbdAVR6h (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 12:58:37 -0500
Received: from mout.web.de ([212.227.15.4]:61196 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbdAVR6g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 12:58:36 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxaUl-1cTjc82j9f-017I5A; Sun, 22
 Jan 2017 18:58:11 +0100
Subject: [PATCH v2 5/5] ref-filter: use QSORT_S in ref_array_sort()
To:     Git List <git@vger.kernel.org>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <991872fc-dca6-566b-4e9f-d5b92e9ed8bf@web.de>
Date:   Sun, 22 Jan 2017 18:58:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dhQnjR3SGLYFJW/aHvQKfGab6r4K+GoiTR9IzKs/Wl+klIMA1aj
 vm2O4DXi5r1iEYtabDgrtevCrCywn4US3DJgr9+3HvvjGdULtz+k87k37iSqnkdi4gQuzHY
 S1JDx5AJLC3A3+LAOVB0iL8tIKpm0yfOS2zYjHMGusnHgyNA8B3NtZnYL3jwKEV+E8/W1L+
 OaKnJE2CDgvkuOO6aFp3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tFMiXxew9t4=:2F5UlBYQrjS/UO3Cr9G8d/
 HVoDtYTFocxToBZMKRZE3gP7+Brh8ynuqC2H5JVSAEF/txhpuzVQ0M0LAJEXyGncz0EXIeEKL
 TQY72R1PKyeYHKGCcy3fvFhDWSJrP6FUBoEdWdJsWKxroL4TB8VML4TRUAKEc1Oc25l3NVzGG
 ZBu0crxknZmHN2uD7Rcc0pANFQAYc4MR91JhdDph94rt+nAJ7j3zctWo3vAwHCUaM0oTxHXrC
 jgNwGrtYPah0anMDeEQ0ApoHevn2bleCwKe4L1FXlgVyYQVOWm2guwa097dbr5RVbNXIDIQ89
 RYm7hTa1LldFIICJtYN5v+v3dsBYuNv9V2EQT/2zHy1iLn4HJxJb/T0tYe2u4+O9ZBZSBu6ID
 s9CoEq84zrVu3vO6FNiMsPfhJj8uNM9JCuf/tC24f1KSRWQb2++xd1ApIYki9ftHhc9JiHEDR
 EgqNBbyQnhP0X7FX6Z/J3rn6wmWojU04YwUAtMLnZHum86dPMCvub6mCqCvRPqNzfCBxgRfEY
 1Zr5Wcjky8rI4uxPC7IqoM2krGFhkSq5X5rsXB1mEGCWYjDfkUXYOGr2aOsJ8wKi3+Mm+Zt9U
 0Sy07aQEBqi3LqL7AG1e8A29tvfAsXqX2xuXxV8HYbfSMdTZGbTGZ5solgJOMsuqwa2GKBdAL
 /6ZkHaOKbymLBrBSJ8wRBMC6f7COGeiaKvpS3WuoS7twLT8BTjmgMC6kSKQiad8kQhD5FEA3B
 MJteeV0WIuQumTfteZwXc1V8mPmnmRSBckGtbrE8MbQX+A721zZEDr2JWzK4ruJEGHJEttArF
 nRUSnPN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the array of sort keys to compare_refs() via the context parameter
of qsort_s() instead of using a global variable; that's cleaner and
simpler.  If ref_array_sort() is to be called from multiple parallel
threads then care still needs to be taken that the global variable
used_atom is not modified concurrently.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 ref-filter.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1a978405e6..3975022c88 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1589,8 +1589,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	return (s->reverse) ? -cmp : cmp;
 }
 
-static struct ref_sorting *ref_sorting;
-static int compare_refs(const void *a_, const void *b_)
+static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
 {
 	struct ref_array_item *a = *((struct ref_array_item **)a_);
 	struct ref_array_item *b = *((struct ref_array_item **)b_);
@@ -1606,8 +1605,7 @@ static int compare_refs(const void *a_, const void *b_)
 
 void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
-	ref_sorting = sorting;
-	QSORT(array->items, array->nr, compare_refs);
+	QSORT_S(array->items, array->nr, compare_refs, sorting);
 }
 
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
-- 
2.11.0

