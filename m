Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7042720899
	for <e@80x24.org>; Wed,  9 Aug 2017 00:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdHIAv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 20:51:27 -0400
Received: from avasout05.plus.net ([84.93.230.250]:50090 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbdHIAv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 20:51:26 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id uorQ1v00218PUFB01orRUd; Wed, 09 Aug 2017 01:51:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=UfWjdcGjbSTrn8ewzUUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/add: add detail to a 'cannot chmod' error message
Message-ID: <aa004526-3e0d-66d4-287f-30abd29758fc@ramsayjones.plus.com>
Date:   Wed, 9 Aug 2017 01:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In addition to adding the missing newline, add the x-ecutable bit
'mode change' character to the error message. This message now has
the same form as similar messages output by 'update-index'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This is v2 of the earlier "add a newline" patch. Thanks!

ATB,
Ramsay Jones

 builtin/add.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e888fb8c5..5d5773d5c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -32,7 +32,7 @@ struct update_callback_data {
 	int add_errors;
 };
 
-static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
+static void chmod_pathspec(struct pathspec *pathspec, char flip)
 {
 	int i;
 
@@ -42,8 +42,8 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
 		if (pathspec && !ce_path_match(ce, pathspec, NULL))
 			continue;
 
-		if (chmod_cache_entry(ce, force_mode) < 0)
-			fprintf(stderr, "cannot chmod '%s'", ce->name);
+		if (chmod_cache_entry(ce, flip) < 0)
+			fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
 	}
 }
 
-- 
2.14.0
