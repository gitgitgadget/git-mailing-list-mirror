Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25515211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 20:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfAMUzQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 15:55:16 -0500
Received: from avasout04.plus.net ([212.159.14.19]:58012 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfAMUzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 15:55:16 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id immmgA15sAOoyimmog5e1M; Sun, 13 Jan 2019 20:55:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=KnjGbk9Dvs0PipAbkGQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] revision.c: fix sparse warnings (sparse algorithm)
Message-ID: <0f69cce6-a0a0-8972-93dd-5c1aa428f508@ramsayjones.plus.com>
Date:   Sun, 13 Jan 2019 20:55:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPBWXh4zRG19PcYhZjIlUEuL5RvlCTIS5nAOtc2JcGoIr2F/pGil/io8hTwCQDuvrP33xG/Yeu1q5WE4m2KWhXoveFaN6zmZ5ZsJN15s1LEVsdDlfEFq
 6z/4eCezz+3ArVRa+shQQaGPUyBtCbjfYakR/R49lD6q4a5lzZG7JLLGhsiFDGbci3THTaNfoNTFUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Derrick,

If you need to re-roll your 'ds/push-sparse-tree-walk' branch, could
you please squash this into the relevant patch [commit 9949aaeef4
("revision: implement sparse algorithm", 2018-12-14)]. 

This commit caused both 'sparse' and my 'static-check.pl' script to
complain about the visibility of the 'map_flags' variable (it is a
file local variable), so one solution would be to mark it 'static'.
However, it is simply not being used, so ...

Thanks!

ATB,
Ramsay Jones

 revision.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index a048da3cf5..c4982a70b1 100644
--- a/revision.c
+++ b/revision.c
@@ -114,10 +114,9 @@ static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
 	return strcmp(e1->path, e2->path);
 }
 
-int map_flags = 0;
 static void paths_and_oids_init(struct hashmap *map)
 {
-	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, &map_flags, 0);
+	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, NULL, 0);
 }
 
 static void paths_and_oids_clear(struct hashmap *map)
-- 
2.20.0
