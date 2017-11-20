Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D676C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdKTXjJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 18:39:09 -0500
Received: from avasout04.plus.net ([212.159.14.19]:55894 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751243AbdKTXjI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 18:39:08 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id GvebejvhGzbmWGveceC1d5; Mon, 20 Nov 2017 23:39:07 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7gWbIBjvgrWuyaat1Y8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] list-objects-filter-options: fix up some sparse warnings
Message-ID: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
Date:   Mon, 20 Nov 2017 23:39:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGPfFRhxnsR8BWkYvptPDQxpPL33ZoI3ByaqhpjVqpTIxSaVM1KbStpEUN4m2ONeoO6apwHyWzJ0UY0Cjtm+egBohUCcsowxSQBdLJ9VKwYkc9es2ZBd
 3fni/GdMzXHbY3kjwkOXI2WgXnVU/9pa6lIPt5srRZu/CAyWTrqSUh1sIbKDJWpgpbYjdg6euqk8GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In particular, sparse complains that the armor_{en,de}code_arg()
functions are 'not declared - should they be static?'. Since the
armor_decode_arg() symbol does not require more than file visibility,
we can simply mark the declaration with static. The armor_encode_arg()
function has no callers, so we simply remove the (unused) definition.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jh/object-filtering' branch, could you
please squash this (or something like it) into the relevant patch
(commit bf0aedcbe1, "list-objects: filter objects in traverse_commit_list",
16-11-2017).

Thanks!

ATB,
Ramsay Jones

 list-objects-filter-options.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 0e4ad70ab..bdbadd5a3 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -34,19 +34,7 @@ static int arg_needs_armor(const char *arg)
 	return 0;
 }
 
-void armor_encode_arg(struct strbuf *buf, const char *arg)
-{
-	static const char hex[] = "0123456789abcdef";
-	const unsigned char *p;
-
-	for (p = (const unsigned char *)arg; *p; p++) {
-		unsigned int val = *p;
-		strbuf_addch(buf, hex[val >> 4]);
-		strbuf_addch(buf, hex[val & 0xf]);
-	}
-}
-
-int armor_decode_arg(struct strbuf *buf, const char *arg)
+static int armor_decode_arg(struct strbuf *buf, const char *arg)
 {
 	const char *p;
 
-- 
2.15.0
