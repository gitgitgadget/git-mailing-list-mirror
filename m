Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6141FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 16:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758268AbcLAQ3r (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:29:47 -0500
Received: from mout.web.de ([217.72.192.78]:58555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcLAQ3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:29:18 -0500
Received: from [192.168.178.36] ([79.213.126.9]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lfj2k-1d1oM528B0-00pKIR; Thu, 01
 Dec 2016 17:29:07 +0100
Subject: [PATCH 3/3] string-list: use QSORT_S in string_list_sort()
To:     Git List <git@vger.kernel.org>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <adc18b5e-21f5-2a5f-b788-1181a8d56d3c@web.de>
Date:   Thu, 1 Dec 2016 17:29:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:E4L1Jly/uOnme/4VweJms4hMEyg1XLeqWsndIDVqqyCsdVuj7cw
 Fh87+OZYxzwaiLX5LesU+Grgt6MN5uzShRgI550dBi3D5vnQ6w+4LW/foRWmLHEYoXzDNji
 1N1bwkUaqQDPk8zdjGbG6ew+5+IzRn9ShOu9J8ifikNOGUErL64b5Hz1YCNSYKxUm/0fK0r
 mQI3ZaYTrTTKYKBleZQjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3TOJkKnC718=:WzTLrjmQXJQuPVVXTvGFHg
 iFkUno5N67z8JeiJGL+jIeXoxW5I8U8z3jbzsiabqjaGiEbEOaau+fdRLpHXIrEGxpEHoxN8K
 /ofL98FSiqiQhspoptRupyZR/jtW9tP7XF4ZIr+suhpYmTggpa8yz7mdrWH6mBnbGpUTPXXF/
 NDhEeEVSqJ3kT3/uAQB8fdAYLnmCSzl2usWg1/j64brH/zT4NeVB0DI6+97sYrivht1DTeZQF
 J28Nsy4GabUMvubUW46N59suzPitqgMeZWJq/h017SCpkESLwwuF/R+5pyEecI5olqe8s9sQQ
 3xh759igxyEbJW0j7H1aoVp63G134t2y0xCg6Q6w9nIhHCxMCxU7z8/NuT71EQWCeEsA3rSrX
 AScBVzrvGgwAqc6eNo1m3oR+r1sYYpBKTq6efxiPxGJ9gs7N8wH8Qfdi33Zsc0p/HlKmaZWw6
 62SIVOcq7MjUhIwAf+JUljVxgC3xC9pgQh/Z8eVAqdXfVmSwU2sxD+Q3ym0Vr/fl1bh6sQF+1
 bKTYKB02V5iFaV8rMNtgiW/NYDnBlWLnmruAkl/oN8YuPcSu66XJnEt+0D1JAJF+MqLL+WnGr
 UEVWhVCJCOWKIb//Y3ej6Hu+rBothsNe05ZgxV58P7rSVAS+wI2Iyzm6QhbB7H4+6V/ECIo49
 IdoFAOTKQlgvw14jaOoViO1fgBleP+zXHhI/TV3acrQ7tS+S3SbFKAmvAHPb2rXmsCad48+AX
 XgDaOq5FnTrDeuM+tUUqAZ+1aY7FO02Z7ceWGmbruSwd1vocANmg+FkdoqBEXJGSyKdcfVBzB
 +/4KNJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the comparison function to cmp_items() via the context parameter of
qsort_s() instead of using a global variable.  That allows calling
string_list_sort() from multiple parallel threads.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 string-list.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/string-list.c b/string-list.c
index 8c83cac18..45016ad86 100644
--- a/string-list.c
+++ b/string-list.c
@@ -211,21 +211,18 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
-/* Yuck */
-static compare_strings_fn compare_for_qsort;
-
-/* Only call this from inside string_list_sort! */
-static int cmp_items(const void *a, const void *b)
+static int cmp_items(const void *a, const void *b, void *ctx)
 {
+	compare_strings_fn cmp = ctx;
 	const struct string_list_item *one = a;
 	const struct string_list_item *two = b;
-	return compare_for_qsort(one->string, two->string);
+	return cmp(one->string, two->string);
 }
 
 void string_list_sort(struct string_list *list)
 {
-	compare_for_qsort = list->cmp ? list->cmp : strcmp;
-	QSORT(list->items, list->nr, cmp_items);
+	QSORT_S(list->items, list->nr, cmp_items,
+		list->cmp ? list->cmp : strcmp);
 }
 
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
-- 
2.11.0

