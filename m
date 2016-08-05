Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C7D2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2997197AbcHEUmW (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:42:22 -0400
Received: from mout.web.de ([212.227.15.3]:64238 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426555AbcHEUmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:42:21 -0400
Received: from [192.168.178.36] ([79.213.113.59]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MgOQQ-1br8aJ2rN0-00Ngj2; Fri, 05 Aug 2016 22:42:13
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge-recursive: use STRING_LIST_INIT_NODUP
Message-ID: <57A4FA24.4050505@web.de>
Date:	Fri, 5 Aug 2016 22:42:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:lvgNIuAvdOG1UrTehiUU/bAMrPyFxuB4tt+C1Qw0+Xf8QrIlFNn
 T246/VAO2hzvwcxLsiM2sKXFwpO8NnWWWBYI9YHhLR5aHff6vFff0zBsJBa9uY17PfbUUKs
 H0LudK1ggctA6OdAsaOPYXKRVyINXASxMnKkkem/WmTdPgL81fqyWE1qqpqbeJu+wRJh05x
 JxVR94gjGZKf+oJ1De6og==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Aw4aE64Lb6Q=:N0tnencw3QahFd5O4hZYgz
 lI7HP8LsQwO0XOGQNwefq6NMOim9TtGFAYYhCXAf2sG/sYuBJOKufUYzUxMxO7+7EdoHzClkO
 gsfE/WQ9VodGqZCVHxmumkEYc+ryoU0dunvkDcFVNOqeXeG8GxyMJgB4ysWbaR3v8f24HyODe
 IlFMY/Ir8RrKDOffokNorFzdUdv0wDtepSuV3FHNnUyAJD3uUvmYLJK4pkUkjukxB03sRLl06
 tiOgd01Xt8iAmq2zfjUP1fcLkbYFQQ6YQhd7ofYVdOfhz2i6Jc8JXLeRMbebcPlszE/ZpX5F2
 Ap3bOxARKx+ySbnQdD2chCD9Z+eWa6bes5I75oxh2nzxxbTX3gonvLx6OwHTAnxRCEzpnNf9o
 9bpRY78tEpYlTeHsdxsYCIOQA6M220u6JwrGXJQF0LZxzaNF6bb1iUcXZ+40cmlVUNb9AqYxf
 SvGEBU3W5O68pGhbhRILunywU4bumqVK9c6gvCUMpr8fMJZQhsJtPcrrSqwY6CZWuU7XUM4uG
 pUG44Uqtu9m1i5fCS191fcNhinoPH4oSaM99/T8uk/yjXllQpE1oPDa+DUQ7P1xB0apX0W+N9
 EJ2OZ/aD7SqNVB9ZmX8yy7vailCGWS1CDyQ3mvEFTbLqx47DMmGYkFHNqMY3Eb7pT+DmjW+SW
 DNELaU+nDizgZSOB4AIRgQH4+eDPTyjiVCBufvi7ZMRbzLW3ZB+a2DvVVzd00QoudS5hry+UR
 Zn+THM4RlVodHrVaPxHi6YBbCMI1oLMxp5WqJwYobptopnrnn2M5YJevtYVXlKQjcvuDK9SgH
 M2CpGKY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Initialize a string_list right when it's defined.  That's shorter, saves
a function call and makes it more obvious that we're using the NODUP
variant here.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 merge-recursive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a4a1195..97e6737 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -409,7 +409,7 @@ static void record_df_conflict_files(struct merge_options *o,
 	 * and the file need to be present, then the D/F file will be
 	 * reinstated with a new unique name at the time it is processed.
 	 */
-	struct string_list df_sorted_entries;
+	struct string_list df_sorted_entries = STRING_LIST_INIT_NODUP;
 	const char *last_file = NULL;
 	int last_len = 0;
 	int i;
@@ -422,7 +422,6 @@ static void record_df_conflict_files(struct merge_options *o,
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
-	memset(&df_sorted_entries, 0, sizeof(struct string_list));
 	for (i = 0; i < entries->nr; i++) {
 		struct string_list_item *next = &entries->items[i];
 		string_list_append(&df_sorted_entries, next->string)->util =
-- 
2.9.2

