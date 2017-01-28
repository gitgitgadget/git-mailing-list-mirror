Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B461F437
	for <e@80x24.org>; Sat, 28 Jan 2017 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbdA1VmX (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 16:42:23 -0500
Received: from mout.web.de ([212.227.15.3]:51632 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbdA1VmT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 16:42:19 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFvnC-1ckGSv0p1i-00EtxV; Sat, 28
 Jan 2017 22:41:59 +0100
Subject: [PATCH 4/5] diff: use SWAP macro
To:     Git List <git@vger.kernel.org>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <84944ecd-d14e-b5e9-7566-9ab2b68c02fb@web.de>
Date:   Sat, 28 Jan 2017 22:41:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pm5LP9t8UfVHqypWBzXhIa4skTLZNqdhnfu+ZK3DyF1xcXgLRQZ
 lypf1NRiCKvq1HAj+81RyogYT2+lrMjIaUyMXYsN8KUqHR9lksj2J3wZHjZY71SAunFs917
 kQwbuPuMQ8jT88Yc0+WtTFooq36TYb09/Axz5TkzDsr/2U3SiaregyeA0LmUpS0n5RMmXIH
 zSLRx7ZulVnaulHxuFrWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x9m5HfqNINA=:s4sv06AqL+hXT0rcIvBAXV
 hKTB8Hg9wGfbUezKgjpeUlJSPxtInBsMJz3R0ssZ5AadNv6ECQmjTQG9UWCkz46OUlGj00ck6
 lCvAcV320JCT2uI82hlKeuU9BdFuMKB+6iALNWL12qCCtGHtk5n8t3siJtg7GGuusVg8B599l
 e/sjwZpFJAxE+HXfiQg0NWpTTgRWK52CvjTkbWg2cVWqMCMYd3OebJeHWi7UXFi3ZE/AvOboU
 4MNf/Wqorb0sArdb+JiSak8uigXR+GhmgZ9G70vOhPxzTMwATQGQ2n7f+xC4eRc11v7lU+/ub
 w+Kf36FANx9C+h+U03nwlHPQsuiNruCql5I6aYMGQKLitpkU8yDHnbfQ71Gj0PgF9p399oAh5
 rAVjMZynOPTgIuo66URuEOkNgKmHYV3nCH6L3NiHGxAjusHY/5t67FY8J9bwBHYA0HL5KYLQE
 LQd2+ThzKwCuAvBkUMGiVkjRZ3PmOZbUylmDvy8bvPXqCi04ubx4I6wCpDZP6i6zcrEaeMh0L
 hEeoMv6Spxv0JSdSpVvhzB89eju5kwddxKRzd3p5RBU927jQig0W9bHnRhZAY5UIT1iFDZ0bc
 yOVGvrm4gQ24PeU01jQuvYylRl8X6I8a/h6Va4JJY6/ygLUx7dHA18FZ21D0gxBXajXXw/ivJ
 SQv6+jh0S3dxKDL+69xwZ92kjpvW/TGe+S0/anpHFBfGGEC5OgbTO4hJFg84gRRRaRnmRosf8
 7tmmSQurQ3MLi9YY2YDbpGTSe/HnTNliNCaKpsNLhMK26z+rc8GbfXSaA19vqgYEZpfWPoGge
 CJLw7cE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the macro SWAP to exchange the value of pairs of variables instead
of swapping them manually with the help of a temporary variable.  The
resulting code is shorter and easier to read.

The two cases were not transformed by the semantic patch swap.cocci
because it's extra careful and handles only cases where the types of all
variables are the same -- and here we swap two ints and use an unsigned
temporary variable for that.  Nevertheless the conversion is safe, as
the value range is preserved with and without the patch.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diff-no-index.c | 3 +--
 diff.c          | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 1ae09894d7..df762fd0f7 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -185,8 +185,7 @@ static int queue_diff(struct diff_options *o,
 		struct diff_filespec *d1, *d2;
 
 		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
-			unsigned tmp;
-			tmp = mode1; mode1 = mode2; mode2 = tmp;
+			SWAP(mode1, mode2);
 			SWAP(name1, name2);
 		}
 
diff --git a/diff.c b/diff.c
index 9de1ba264f..6c4f3f6b72 100644
--- a/diff.c
+++ b/diff.c
@@ -5117,11 +5117,9 @@ void diff_change(struct diff_options *options,
 		return;
 
 	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
-		unsigned tmp;
 		SWAP(old_mode, new_mode);
 		SWAP(old_sha1, new_sha1);
-		tmp = old_sha1_valid; old_sha1_valid = new_sha1_valid;
-			new_sha1_valid = tmp;
+		SWAP(old_sha1_valid, new_sha1_valid);
 		SWAP(old_dirty_submodule, new_dirty_submodule);
 	}
 
-- 
2.11.0

