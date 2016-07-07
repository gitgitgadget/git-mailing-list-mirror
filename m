Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3657A2070F
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbcGGOgX (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:54571 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbcGGOgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:18 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LpsmR-1bokf71DUd-00fhOC; Thu, 07 Jul 2016 16:36:10
 +0200
Date:	Thu, 7 Jul 2016 16:36:09 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <c22a956c2b9669f3cf61638fd269c82afd294eb5.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R3RT1yJAIg6ap/477mrhQqFzL+W4iRIuqkcP9CwRh6A4BVgT2jB
 NPfy8jbVCXHUtjeqWa1VeCahv9ZQz3vrkaC/7Zh69NGE66DvFzEgFKQ3wXOv1DmOnoQIQ0L
 bWWfvTeW8YVECzVi/60l5kb+jmL4KItgdjjgMkxApGIl9elVzR1LdZbkUlUeh6bpIunCCZH
 JgHHHLPkMsz2py7ARl9Zg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XB4naw5c1NU=:jlpYyjnTkgyh2PxAnxwQT0
 zZWdPxrn5yIMlcM9sK42HG8aTEaNWWa+/YDUslxYk7AWomS4kGBpIB1KePvheiM6kcs8TB44u
 X0F/2011AkUUJItbXhCfQX+JSdGDnxHRo0tRtvmKd9BZyM8au7BZ1Rz97cTc5ak21Oafkhq69
 WY6X67EMnCNUkLcCZgnWqsUKecE6iL6bvnR0iNe2VdcYHzCk7dw2c0Czqsg5o00LPv0T+QMrv
 QKA/u3PUWqTinA7r8thyY0WFgmd9UbflzVRDFbHx3EJ7xUcZ9ECleNVJB4LaDvBT33A07MqEn
 +XobzovrdwpO3vwyCuGChmghTeYIAmrjNDsum+bVEdGgmaBTgFX83nG0BS5q1i3kTrB+CnSaL
 dEU7kylYUashPjK4kxDqhBAJixssqhOaRY5bsRnJzswSUzgtSQL9JMrML2cpNeXwe/YU00ZI4
 Y0ryKiWrDTBdWTtQbphKWGlF82bM08+I8BA6OLVDEcs8yYSjZA7ahvlimec59hL4n3ADJijlI
 3WYYt2vdaGRGcm6j3ivMsp5/3O/cwwqsqObAwZo1yNy932DMLVmON9Q9mXt9MOUlEKLjLJJ31
 zj/3SSv9CX35ylnMNDfvyPP92WHVIM20N0nS/C13TvGNzBoRRmNXWuMAkphk0R/nBKSt+OaOx
 YNYBHe9FmxTuibgPISwsDf2ibK0XBeNslFrCqkXk1JuDoyoRoi+Ma1lsGJVl/sGeZIDAa9rz0
 xHyC0fhHYGQPnD3cmWWB1UfhRgMXera2uEzYmJMLCZOfxPOs6dIIRbPelp2SOW8wfKyT5y2tM
 YwycfgP
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
index ad5b961..10d3355 100644
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
2.9.0.278.g1caae67


