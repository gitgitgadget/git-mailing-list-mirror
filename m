Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6CA2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbcGELYb (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:63151 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbcGELYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:19 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MTCDO-1aueeC44hC-00S5Kn; Tue, 05 Jul 2016 13:24:11
 +0200
Date:	Tue, 5 Jul 2016 13:24:10 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 14/17] merge-recursive: write the commit title in one go
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <0bc1729b4098c3d5b97be5cf7cd09a0c03352edd.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PANkilJjL9CI0uhaIXFnvWAa8/66WAx4tMkimYS3JtP6KJR1y9T
 87JQrD+KnAqjanczvf38QTyovi5LpzAzSNCZ6P3Tpg+pugup/JoPD6eWFga9qQya7GwE68n
 RAQMly8EUWj9zyVBd8F8k0RMuoyd13zwpyvB3vNGS2ABDzJOgQ7Lgq81pQikIF3zPJwadns
 LQdKkoGspu8OuYI/zWxDg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7jm7csUht2w=:nI8gCaVJeWzk1nGy/DmqRQ
 KEp+qxz59pmKt+fio0z7RRVTdqTlmvP6MjkeAGl26mf8iO2FPed5L9XeBz5FlUERJOqn+uF3+
 uu3PwSjGycde5Esr+/oOQsvSNmg8irfMrMsx43eXOIGcg7W5VbTqAFZR5o68m+ilJgfCI0uZ5
 NissJe8RJVjK219pUXVs21+S0iQOR0r/trZenWP+ANziNffpMjQSCu8i5u7gHnDVb+YHJP4Ok
 bgrTeq2G6rjkPSM7J+O0KFoU0IdzYBAueoaQ9C85F/GldXyU2XVpcu4nNsc9XSoVq7/wdV5Ji
 t3AQRmaXSRNXdtAo2f+vFFREpCJP8EuQOqH7Cqz3oHapem/xGz0AqeYQOryM95JkDs7MiRjxo
 vtIggsKHEtgYFYimSmq7UijS46nLZZC878U5Ycs8N5G+cIFS+2Hl7vdBpSrWMRxT+mm3ueYE9
 aH3uyl1QYvQ3a+CuJwJVMHv74AA/xZ7eBt/VAWFqdfXQXglX1zGYIWcnxkVojEYmm/Sxm2s3c
 HbldSzErAobjgefDi2dAPPOL96OzDNvE1VD/lb8CM15OMtmKxxMYc2v/V6I/KRy8bfmUzcE2N
 MY8sotHPR/99NLZHv6t+1PlmUqsGjSYMlRL1UYsjO3f6vUVxHOjUNCLT2qpN1UqKujfOwyf/u
 kNOb5HCStfNZjCORlohej9uNo4Ox02JUB1Et3jnjvg3YYT3aTL7I2U1p93eQzGZ5xhbCBuEPk
 woxXgLR/2WMznwlvbt5b6y67+4fttqoXGx8AQ15nN1ikgAA4VHGK3n2DNUU4pN4wD/qdOO7qm
 LCwsSFY
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
index 0eb23a6..81836f2 100644
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
2.9.0.280.g32e2a70


