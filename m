Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4ABB2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbcGELYj (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:64687 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbcGELYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:33 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LgISa-1bhNLW1cH6-00nfUG; Tue, 05 Jul 2016 13:24:14
 +0200
Date:	Tue, 5 Jul 2016 13:24:13 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 15/17] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <8e821762433961dad0794c39f90adf30baea7d62.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XsRQnoMLEdy74Th0dQ4xZl68DRlZXsGs9sONRUSqOHoMTxm7Wvi
 L4TJzJHUHuK/9B6UIx9uCAERQnaGlY9nij8C+tL+rWw2Hi1rndIFmxdiRTkHRFkv/8EWW2Q
 W8CdwEJ4ekDxMmRl0kYxAU3ak7lXEieaUBGqIWCfhtr8lQVAyOCpzP7J0rj3rK54zimDkNO
 V0m2y3Kt73xQoYxutVhuw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:h0dtLRvXHIA=:Ee7Q5LqnYAT2XQTUaKw/pn
 8ImtSg8kYTi2VLW5/y3iaoI+IchZaUHMjg4SgLfGOiTEhV/5qAo3Ii1k3VuQh39wzU1vBlWvu
 JJQx4D4NoW5/ngnJAxQx6FkD/Fo7WKTwagV1VhFhKBMYOim1KuCAt9voNXiLK/c4SQfQv54f5
 XS9Hywf6gx89MiARqVm15VmCBM+9/rRFKL4OqEXKZa98ThSjzDI6yHnFrOAEN25evw2vVsVbr
 0a357cMm4qqT3sO6dCgxKtMptZcIHc7gkeMhiYeVvcSnj2yProI6VkTIJkk/aE2mebpmcNTeZ
 NwofTXmjrRTuhUCUmzXMj1gjr9EtMV+cLnpTtJjxA5sZzOvkly+rJI9S+HJQg51kgUfoevN/B
 302HsGAWN9LBRw4k3wVxtLbhDS4mr7O89Jy36PhXyo3XTRy1VkbqpDLxWgqq+hyvg4QkVm1IE
 AVc7DrOPKunHCi5NArxXdOvnqNXzqUmssWMwHJlsq15Ystm2kJ27slK9WbS5NpVHxdiUtRjM6
 sB+H+xPsiXZP3MYb40AkEoYeap13vh9Zq+jMsIfI2Q4YWvqNmVtJmw1a1/sCAXN7K6sq0UdtZ
 U7x1HGWB+l9HKG1vudtotdHTEABSZ75N2V6eFVqVC/cLQ7DrsewigPuB6uVGJiPS+ZajbPCI0
 sioWKP3BAK8O1IZdPHKblhOitBTRIXJHFQC3VQagzDNMyCIWeHBV2CiOBUaU8/aVOx2YshM2c
 idZ/eKK+Cu4wZnGjttR1fs3pmWK6PoeATY7fT+hcNV1CQ1c+C52WqtsepQGP4JueGrFLw/AwD
 ChzusmW
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
index 81836f2..29cbdac 100644
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
index 52f0201..407d4fc 100644
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
2.9.0.280.g32e2a70


