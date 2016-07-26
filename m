Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C08203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbcGZQHQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:07:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:53088 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095AbcGZQHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:07:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MZlEg-1bkHzX2Viw-00LaKu; Tue, 26 Jul 2016 18:07:01
 +0200
Date:	Tue, 26 Jul 2016 18:06:49 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 16/16] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <af195979d2c0cf9958b7811b4d2294deeea30b75.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6Xw5ty3aT0lJfGCm7bvl4M/OKHMjdoo7xpi4g5x5v+uOFE4NH0/
 hOZGAAq55h2jzMNa1z+0MjvfJ5W7+TBlYCd8VoN1fOsDUrpU1a7f6of4XZv07wGl2SUaipo
 j4UYnEvOqmSXhWKHsIpwRqEPN2425Hz/1IH2J62uyJqFqTLGjieFHVe1J2paiecVI6eTR4G
 FID3STsTB0HRyplmsaDSw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pxfaxuCrELM=:MaO6y6msG70R1mNY8haS6T
 8r5y2t3mrHG5AtRFa6ALK9yln0Gk7H1oIRkKR04I8fUqVrkhn9sESdwG4zXGIe1RpVPM/y3Z8
 LKrCwGu9zxoIvLSWzrDWY9tXe29MN9601Oi08JRek+5JT8dv2xA3g7xbDdnhtFsdWLpc4ppfs
 uevkOOS8Dix5upyNyGY7vDhzdwsWcUy+9h6sqHvhymUTCnwHBjV3wPbN7OzodykKm0csuM/oy
 ctbk4vY64HJ+uVcuFfyRIH2O/oq1sruhd5YFyKAt2PmkWhdvMWjSNE0Tp6Ngpp5Ii9YtKnGwO
 aPRt2MI9ytK1qz2NRHSMaee01ye5e2FA/ta2m+UBcKjm8XQdV0HQM5Rvd6KWis902ZmD2prV5
 J0jyzsOHFoM04jX1bw4h0Qd3+EzojQcf+c9c4sbHGVycuT2vQMkEedCuJVHcjixltOwI+gVMt
 nCc+nn3HidAxMtIEh+NImvfJY4CyH988BZhiq2RgWXO9mLCgKUiJ8LzEBv3e269PteM+4sQAp
 E2hyn/9Bt4UfTu2BBum+6YE5+/leX/wGTtC70WFiuBpRM9ovpzdJMT+CKCXCvAhbBLl0c4vUV
 jfz39+v5zcAeuyh4uJl4IX+64xyslM5RanP7Wm9IR4AqqdEUUOWcLkOtWRkw2Z+1Df1m2JKqv
 8YQsDDTmpNqszcDvuRyCXYtf99mnz6dmuzTe8RnOawBJpGO0exi12I/TkiuF3Pmz17KJOI4f/
 CxEadVS6wT4saa8y734qwx588CPMqE2Kdm0BV2PSBKqRHakenW7PuRg0NXeHBnHvJcHYMaDxN
 KIFOYVx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ever since 66a155b (Enable output buffering in merge-recursive.,
2007-01-14), we had a problem: When the merge failed in a fatal way, all
regular output was swallowed because we called die() and did not get a
chance to drain the output buffers.

To fix this, several modifications were necessary:

- we needed to stop die()ing, to give callers a chance to do something
  when an error occurred (in this case, flush the output buffers),

- we needed to delay printing the error message so that the caller can
  print the buffered output before that, and

- we needed to make sure that the output buffers are flushed even when
  the return value indicates an error.

The first two changes were introduced through earlier commits in this
patch series, and this commit addresses the third one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a16b150..66e93e0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2069,6 +2069,7 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	flush_output(o);
 	if (clean < 0)
 		return clean;
 
@@ -2077,7 +2078,6 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(o);
 	if (o->buffer_output < 2)
 		strbuf_release(&o->obuf);
 	if (show(o, 2))
-- 
2.9.0.281.g286a8d9
