Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123AA1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbcHALpq (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:57906 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbcHALpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MDQp3-1bUxvO3Fs5-00Gte3; Mon, 01 Aug 2016 13:44:47
 +0200
Date:	Mon, 1 Aug 2016 13:44:45 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 13/16] merge-recursive: write the commit title in one go
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <2c46a4a536b4b70bb1ef26fe13faa00f3d287727.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fr8kT4+vyUDjf20HhVFiM38w428O2RM2+4SaDV1Eh/8VLpwpVF+
 bToZ01ZS+z0zyqpGufQzh7Yr8nll32Eh/HvLr7MZRaAE1rbxUjPE4U/uEmAQFyJqYUU6HWT
 zcLipj1QeQubGqzrAvhKr9NDITg2EqDkh1/ZOZwRAFiWJ+VWNOK6MHdmDHJ6nd7V8K4s/06
 rWpA9Zi29PVAvaRskl2xg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ieBujCwljGo=:uI4imT758u926YMUPUSG8y
 /rgyZuO1uzuBe7k7Wqt4+tyoSq6i172Q88PRKNXUAT9Tpw6fV+cOLD1qAt82Uc4ZtUtrmTA3t
 ETbqEEMKbV9tX1t+9GrlRC5Kdo+cx19Cl8geAcf6qiL4zGD3C7cW08XjuOZL6v49c5KVTgNUs
 KkC9O4YovbAO6U6Te68ECarhmPgHwP/xqtUEZ2ifvw83PX5HbWpGSudZEzWVwAbpB6e8QGQst
 PzFf639n4OPJG+zuvJmrs/bdeol38AF0Pfnak+dP7QmGSxet2/H/MalmtOjD9Qm4pEzMTHjOZ
 Ru814HOTtms2zH4BwLQQ9G8f7WxF3oGdCSUC/iomWFCLULcowaBQO8outb6GUxmpBaG9cm4kN
 12YuKtyewZDW7p1M7bbEMKEY4CcOu1uM3j1Ip6UlIOgfugP/SpxFS9YjO/TKE/2I5KxZzGLX0
 inVidljeQtT/LRGqb4bh2OUoEdzlGGbKGzcoI0RzHRCpmJEsEBk6JIZ0SHwr5RCAYARfpwdjr
 p9LHOlKcQqr+weTUdalWnSoaSMPB/sbJBD9opCLeOewJs6CqCgCA2UqTFoDtl3QDREA3JYTRC
 afZ7Q135RtZLDJXV42vd825jMr504tgpqluFuQV5+7OOzH5/ZmenAMkSZQKQdirqDZsOFlWqX
 O/wpKr4JlFld/VdW+aukE7h+omp6btjTIylWeLnNDk4xFHD/V6ewJd79tD/GYdKksRzvyyT1Z
 /2/UzjxgzQx+KR3W3zZGi1zSf9023eV8LK8HdVOgF4DQ6hSoPXC53/I/hq4sDre+5jXHKAXKy
 meKJbK6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In 66a155b (Enable output buffering in merge-recursive., 2007-01-14), we
changed the code such that it prints the output in one go, to avoid
interfering with the progress output.

Let's make sure that the same holds true when outputting the commit
title: previously, we used several printf() statements to stdout and
assumed that stdout's buffer is large enough to hold the entire
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
index b972a83..99c9635 100644
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
2.9.0.281.g286a8d9


