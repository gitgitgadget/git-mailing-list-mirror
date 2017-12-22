Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DD61F404
	for <e@80x24.org>; Fri, 22 Dec 2017 08:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbdLVIOI (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 03:14:08 -0500
Received: from mout.web.de ([212.227.15.14]:52822 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdLVIOH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 03:14:07 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjrU9-1ezQME2cnZ-00bp28; Fri, 22
 Dec 2017 09:14:03 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] http: use internal argv_array of struct child_process
Message-ID: <504cafe3-2960-af2d-10fe-51e8ba3d2213@web.de>
Date:   Fri, 22 Dec 2017 09:14:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hYPo/NkJLWaGIGVufucxw+1FE+clqQBYtJY1VMJJYA3gjDaFgRj
 JRIbG/wFm/WA0WiiFtNP/HA4EiRvRHZ2odpWpJz9QELm6UWOyOa+haOM65KMb81DfvsEO0x
 sxUZyujMWFERCBtNTLp7X3nfKv4jWW52KEsnIFjSgBsuriWbmt01jZ5csrcCebwS9HjB/2j
 +1NW90DQmJXg1JBErVa5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8pZrTJkkgkc=:C4rlO7HMwqCyPxdDKQkfqs
 kFso3qYVfsS/38f9uK5eh0qnSDjeGQF4Q/8n3hujNDiEJrnxFabyQcSrcDggOT++24qejmi45
 UrN1ITy+blDLMz5eZG4fJAzrv8JjOxbyPbZuK7IOSUQo14dSrZkFXl9NVrtM1nd3tjYNKExdE
 Ig8KtSp9XMVLlRjkR8ReGaWOGmF08IZ1t+AV4X77TUyf7KvLnFtLUgPmQPpG2WCuKIFG7o0Is
 F0EghbivtjEV+gjM/7wkpKHciI/D8lnSxko4rE9PNNDqkxBvGdjssllGRHc7IMWJr3JSYZdS1
 CZjjHMD9yxwC9Rv8qrD9ARi/rHfmPUzDq8tcMPWXFKcQxJHC2iD4wY1RZqycEuH7wxk3AyFXb
 +W+nVrCcp23GOs473GLq/6mwWoMlygKN5+sJ7/RT/LPd/WT/FqhHC5T4SGCDh0pCsMWhYhEbC
 vVGNqxaDgIVo3+3JJH/7TqA1wCT3bPMah6oi1VVwoyugXalErZDQyPf0lC7639kM3is8tlxUU
 xQ8+y6PFSMMF+mKUeyGaYSzGrfF03F1vLsBKkcxzoBZF1jineL6EtYtCt/m9QwAC8g9lf1LGT
 KatsFrlzcJzJk+KyCG8gPyOMObxmlOt75ap+f5UzkujFsB1oTdWApkumnRusbzwfuuSQq0hQP
 TxS3/mI1U7dNDotF5wmObQyHYwZBzmxF8TayXqrJGoo+6v7J7d6XqswjBgQmN/2W2y1sW5g7T
 AsLAJy5XaVv0jQyjnMe068ObQ0yRRl/tB2Q0nZWtYsTf5jcG8XDr0/EkLRTy6887GUKqIdmXa
 6mOY34KJFiMwb4ajWCV1N19LfDlt8E8vatLTnfR5ZNvxIm77hGLQpstvayaPbEtbnfg8QVm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid a strangely magic array size (it's slightly too big) and explicit
index numbers by building the command line for index-pack using the
embedded argv_array of the child_process.  The resulting code is shorter
and easier to extend.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 http.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 215bebef1b..b22b4ada58 100644
--- a/http.c
+++ b/http.c
@@ -2025,7 +2025,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	char *tmp_idx;
 	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
-	const char *ip_argv[8];
 
 	close_pack_index(p);
 
@@ -2041,13 +2040,10 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		die("BUG: pack tmpfile does not end in .pack.temp?");
 	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
 
-	ip_argv[0] = "index-pack";
-	ip_argv[1] = "-o";
-	ip_argv[2] = tmp_idx;
-	ip_argv[3] = preq->tmpfile;
-	ip_argv[4] = NULL;
-
-	ip.argv = ip_argv;
+	argv_array_push(&ip.args, "index-pack");
+	argv_array_push(&ip.args, "-o");
+	argv_array_push(&ip.args, tmp_idx);
+	argv_array_push(&ip.args, preq->tmpfile);
 	ip.git_cmd = 1;
 	ip.no_stdin = 1;
 	ip.no_stdout = 1;
-- 
2.15.1
