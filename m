Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69006203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113AbcGZQHJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:07:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:60700 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757068AbcGZQHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:07:04 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MY86C-1boCH111MW-00Uu6q; Tue, 26 Jul 2016 18:06:55
 +0200
Date:	Tue, 26 Jul 2016 18:06:42 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RlUOjkWS2cfkJupvzgbe4w/ONngacOJIqT6MCwYlYsfXPHa6Z+U
 C86njxn+jvMYeo4BZ9GUkVsI+OYBG/ytcKIcnabu1Ne0na7q60SvQ6s6DxKSzSUlZ58s94y
 0J/TQCPS5p3bWgFeACgFRVGbb9OEaBjEgVuuY11FyMEYcB7n5YQqiS/T6j5WRQjeBnDCCcO
 gQYDAqrJTx9fM5MVCo6Yg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XkAWyhvofgo=:LmTJP/3igr5x9JlgSSZ7Qy
 1HYMIf1ayCtU29+63j9P57NOnZAfv+vx9hEbJfSqdDNGKo0yu7zEgtzROPIZsFoMQ0iswTWV0
 NhSAv/tGhAHQoTdD7KgJwurEIDOArVssfwOtH9F5qSUzAFf8Nu4UX+nExD65QFtc3pn1Ez+Oy
 lM/HnWcKIcGwbut3vNd41+BJ1UI/puykJYHYvln7iKkshoH+CTE180LCcgFZUtCriIh0RhWQD
 ajA+MkajyVp543SmpI64E7N1um9Cyl8plZ+eE0iq+N2GF5T75Sqlq2Kka80ATV008OyxKWglP
 A9O0Z/fkNLB8zT62hKVmJmcl3xev4HO8dqGLdCO+wEjFyxnhopk1qWTs68Wk2GMN4WAl/vUaC
 FGEDEIQjN70l/TqaI5O1B7c1t83kRLq87Bbmn1bOEvefSsxTPEcpp9/GrafLR/6eSzrGBvw7q
 VMD1MB8b69NTRWSTK1L6Ao59NWkcM/zeq8QeLkBo9LgIpZ0T/95fQstVDR8K3uaGje6hPtxCL
 NYZrINOh4w1B78pPVx8lHyXvQsRefsu9CPoVbbWWFNQegxJe61jU3u8NgguhrC9qGRR0tnraZ
 ywZfG/JLR9iDPBTFR3x/vmINYAiZz64Nx97FAvbi7toRSVJPcm0rQoojDYVegTuqwjqs4hX/J
 DTyum2tkY0btDIHcQi60FTVSY1ZwbF/U9dXtupFfprLUwG468H7aY3Qnigvi/nFHI6v+0fp60
 AFfPixee8pJc1CfqhFQjZmLVbryibNeokUNw0j/NRcGIQnAHhkkTl+rqeUCUBCdp/UpBTvlXY
 td6KGRA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since 66a155b (Enable output buffering in merge-recursive., 2007-01-14),
we already accumulate the output in a buffer. The idea was to avoid
interfering with the progress output that goes to stderr, which is
unbuffered, when we write to stdout, which is buffered.

We extend that buffering to allow the caller to handle the output
(possibly suppressing it). This will help us when extending the
sequencer to do rebase -i's brunt work: it does not want the picks to
print anything by default but instead determine itself whether to print
the output or not.

Note that we also redirect the error messages into the output buffer
when the caller asked not to flush the output buffer, for two reasons:
1) to retain the correct output order, and 2) to allow the caller to
suppress *all* output.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 +++++++++++++----
 merge-recursive.h |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 723b8d0..311cfa4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -25,7 +25,7 @@
 
 static void flush_output(struct merge_options *o)
 {
-	if (o->obuf.len) {
+	if (o->buffer_output < 2 && o->obuf.len) {
 		fputs(o->obuf.buf, stdout);
 		strbuf_reset(&o->obuf);
 	}
@@ -36,10 +36,19 @@ static int err(struct merge_options *o, const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	flush_output(o);
+	if (o->buffer_output < 2)
+		flush_output(o);
+	else {
+		strbuf_complete(&o->obuf, '\n');
+		strbuf_addstr(&o->obuf, "error: ");
+	}
 	strbuf_vaddf(&o->obuf, err, params);
-	error("%s", o->obuf.buf);
-	strbuf_reset(&o->obuf);
+	if (o->buffer_output > 1)
+		strbuf_addch(&o->obuf, '\n');
+	else {
+		error("%s", o->obuf.buf);
+		strbuf_reset(&o->obuf);
+	}
 	va_end(params);
 
 	return -1;
diff --git a/merge-recursive.h b/merge-recursive.h
index d415724..340704c 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -13,7 +13,7 @@ struct merge_options {
 		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
 	const char *subtree_shift;
-	unsigned buffer_output : 1;
+	unsigned buffer_output : 2; /* 1: output at end, 2: keep buffered */
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-- 
2.9.0.281.g286a8d9


