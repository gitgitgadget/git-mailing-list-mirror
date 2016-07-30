Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3951F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 18:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbcG3SZT (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 14:25:19 -0400
Received: from mout.web.de ([217.72.192.78]:58641 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbcG3SZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 14:25:17 -0400
Received: from [192.168.178.36] ([79.237.49.94]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MeSGJ-1beDX33Snf-00QDrT; Sat, 30 Jul 2016 20:18:34
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pass constants as first argument to st_mult()
Message-ID: <579CEF77.9070202@web.de>
Date:	Sat, 30 Jul 2016 20:18:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Fzh0pqIP2w+yxbPMoIEdKcFzs6U5n00RAVBfZ+K2xS6lGgEnCZ4
 7uTEOxzkrzIEswFB0cMgXRU2csKPer9iy92NxcODPATXxg5MZVG5AJvcjDdWO19o2LzZ385
 5bfzOadW3YjT400nKk2jkJluV8PR7tSluQAGzSk4Q6c3HuAOkvRrrBDOpWCoe5L/l0Aq/Yu
 x34X62R2/Sqs38PivBKPg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0ZfGTU7n7zM=:9Fazs/HLAj/DaxUC06CAgo
 Eihm1XY90Fuo7odQjCkR1k9UDLYZnLe5TlLnoEm1g2WPmQnW1IJBIMG+Pe9koNlwr+T4GqxRl
 xv/OuxkE3kjaVqqNCu2DG3GYk+hT6d5eCSdqCB4Gi250C2BbvjazjjPTw4+HeeD7EUlV+CoBg
 B8IO24dg5fer/tscXIeXofDA7bqbUrK1ddk2iq2sN6mp38XjsmUDg5TCq+53DN98znPNI/e8Q
 HWesPIiZooFJUFNUk3wCabVFDPJUOhBiX0UVB0TKHJtYoUMy4yFxvuDxXaLiCa0cHaxLteBs0
 /PKQxoLcAKPUVBlNDvnoPx5Fas346CHm4NtZAClBeMllv7g52U5TkDUu+1/utMN9jmn5RfVTf
 xi/E6idNk8r5xUuG5cjCGB1V2Y1FqYU5XHkkgM3hH1loWOeJfKZvrWREELo5yDkC8dGcqaS2j
 6HjLSNlnwemrg45H1FtVbUDib0UgfcgQwSUMJQqSAdkLJXBnVj4hegBMneA8oDDXN6ebWqwmj
 2iLyisNOz/cd5+z4RPjLNLRF4+H3YC4u2ov6tnda+RW0a2QQVemVgjx16I48D/ycQfUu9qvWS
 bEtypVUhq/csrCnVuiPz81zFEIrPe9iUshRh/Jf7Z+BlDQpURbxtJBXtaO31FtRsji9IyIi+t
 /dyhyWLbFKZYUk6hdp9MPvROu1vlZdaOiHzp0LxrvfdSBDUu4DPl3W1mnFe1Jbgz8OfpsU7Pe
 4vmoAOdKuEoX+1Qe8o2rRlNa9eXNQDdnLrTkKXBfGItwArX6GF5+Ce10l4C3dSLQ0nKO/hklc
 4OFGXuM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The result of st_mult() is the same no matter the order of its
arguments.  It invokes the macro unsigned_mult_overflows(), which
divides the second parameter by the first one.  Pass constants
first to allow that division to be done already at compile time.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diffcore-rename.c | 2 +-
 refs.c            | 2 +-
 shallow.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 58ac0a5..73d003a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -541,7 +541,7 @@ void diffcore_rename(struct diff_options *options)
 				rename_dst_nr * rename_src_nr, 50, 1);
 	}
 
-	mx = xcalloc(st_mult(num_create, NUM_CANDIDATE_PER_DST), sizeof(*mx));
+	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
 		struct diff_score *m;
diff --git a/refs.c b/refs.c
index 814cad3..b4e7cac 100644
--- a/refs.c
+++ b/refs.c
@@ -922,7 +922,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
 			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
 
-		scanf_fmts = xmalloc(st_add(st_mult(nr_rules, sizeof(char *)), total_len));
+		scanf_fmts = xmalloc(st_add(st_mult(sizeof(char *), nr_rules), total_len));
 
 		offset = 0;
 		for (i = 0; i < nr_rules; i++) {
diff --git a/shallow.c b/shallow.c
index 4d554ca..54e2db7 100644
--- a/shallow.c
+++ b/shallow.c
@@ -389,7 +389,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	unsigned int i, nr;
 	struct commit_list *head = NULL;
 	int bitmap_nr = (info->nr_bits + 31) / 32;
-	size_t bitmap_size = st_mult(bitmap_nr, sizeof(uint32_t));
+	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
 	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
 	uint32_t *bitmap = paint_alloc(info);
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
-- 
2.9.2

