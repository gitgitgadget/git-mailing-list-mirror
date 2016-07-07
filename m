Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8E72070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbcGGOg0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:58039 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbcGGOgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:20 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M4GND-1bcYtw0M1j-00rsFw; Thu, 07 Jul 2016 16:36:07
 +0200
Date:	Thu, 7 Jul 2016 16:36:06 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 13/16] merge-recursive: write the commit title in one go
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <12170348e4a9f44cdbcb060ea9505bb7b6c830e8.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BPXPyQGsH6pGBUGZ4wHRoP1IWRnffa1JHQGP4w6XfnNrSq3m6Qo
 g/xIDIEWq/k5H+C8zEFyvyjsQA5P7B0AaPHudc6Obu+zPrV0oCt3ggfSZbRSJvjCXfwtpao
 ZiO4ebxNP9/Bndxp/D9CL3GHDqZOpVG/3MOcl2cyVpmmfezvojQnY1BQgjr22PvuT2x91wt
 oSny89SGBHkmVcHeEoqdQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:DxvPIEz7UG8=:ljWmjMhcd6FzEcBcdm2AXX
 MqSb7ABoi8Ks+in3sWZlyg3jsdxp5rRK9KVntXauAGQaPgpEtoDx/ESfhSymgSmg7g6EmhpV+
 QcHEkut5izvoaXPptlOVl25+qrKppxoqLvbjUoErPM4/CzvCwloRfsAhVJayDItxPwqlTCTMH
 K7TMRbjrVygnp85twEzaP4frdjQejmNYRW8S2nZ1G5LwYOZFfn1il9f9/Su0mVk7wRlcyoE2I
 18RSRuKRlXNkOvRUXAfuZqxMUKko7AMhPPY1dLV1CE2uuNSEQQMDJa8wduH29cUHaBV2ILtRK
 Zjm4kSSLaSy7LGmrXgS5e54EQLfWp+bF/nJ2cpzmB5LWqQUivHspQne9MI3i/b1/KPJXajysG
 +plknHh4KYiLNrP1+jPpBs/fBSDChpIWtiQSMPbuewF9THwgMKF1bvge8vStG4VU9HoDspiMA
 SqxuzGVeFWoR/OaGwCSIGoBpUh6fp/3Xuy26j4L3ej3oxzoeDDxiglUICH84gAdvCcrjyPw7I
 DC0ZXFR98pr/YCdjRk1Rrxt/H6xc0IlKuBhlRqBnBP3C5Brgol6Z+GpAU8wKRdc7YPaFjh2eu
 MtcQ+d47aXI7LyBy5bDzWdl7gxZg3kCtLirdYBx/1JZ6Bn4smJgrVe66ym4p1BbKkmmzUF4y1
 KAm/xE6kZfWJDmbcLR6m+yhEp5FMtWBPBtzaubuOVKvVHJivDjaaVBV+lngkl6xmVuAG22FMZ
 zoTdDjzLWhevj8w8+omuUX4dqwVv/C8XhJFQZug0Vaml3E1l/akqqylQElltK3sQIAF2kieWh
 Rxnipe1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In 66a155b (Enable output buffering in merge-recursive., 2007-01-14), we
changed the code such that it prints the output in one go, to avoid
interfering with the progress output.

Let's make sure that the same holds true when outputting the commit
title: previously, we used several printf() statements to stdout and
speculated that stdout's buffer is large enough to hold the entire
commit title.

Apart from making that speculation unnecessary, we change the code to
add the message to the output buffer before flushing for another reason:
the next commit will introduce a new level of output buffering, where
the caller can request the output not to be flushed, but to be retained
for further processing.

This latter feature will be needed when teaching the sequencer to do
rebase -i's brunt work: it wants to control the output of the
cherry-picks (i.e. recursive merges).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 205ea04..ad5b961 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -191,25 +191,26 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 
 static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
-	int i;
-	flush_output(o);
-	for (i = o->call_depth; i--;)
-		fputs("  ", stdout);
+	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
 	if (commit->util)
-		printf("virtual %s\n", merge_remote_util(commit)->name);
+		strbuf_addf(&o->obuf, "virtual %s\n",
+			merge_remote_util(commit)->name);
 	else {
-		printf("%s ", find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+		strbuf_addf(&o->obuf, "%s ",
+			find_unique_abbrev(commit->object.oid.hash,
+				DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
-			printf(_("(bad commit)\n"));
+			strbuf_addf(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
 			const char *msg = get_commit_buffer(commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
-				printf("%.*s\n", len, title);
+				strbuf_addf(&o->obuf, "%.*s\n", len, title);
 			unuse_commit_buffer(commit, msg);
 		}
 	}
+	flush_output(o);
 }
 
 static int add_cacheinfo(struct merge_options *o,
-- 
2.9.0.278.g1caae67


