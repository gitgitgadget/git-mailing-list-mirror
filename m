Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E8A208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 15:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbdHUPsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 11:48:47 -0400
Received: from avasout06.plus.net ([212.159.14.18]:49175 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbdHUPsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 11:48:46 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id zrok1v00418PUFB01rolKY; Mon, 21 Aug 2017 16:48:45 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7N9iYcCwZR6D-h9GdggA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] repository: fix a sparse 'using integer a NULL pointer'
 warning
Message-ID: <91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com>
Date:   Mon, 21 Aug 2017 16:48:42 +0100
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


Commit 67a9dfcc00 ("hash-algo: integrate hash algorithm support with
repo setup", 21-08-2017) added a 'const struct git_hash_algo *hash_algo'
field to the repository structure, without modifying the initializer
of the 'the_repo' variable. This does not actually introduce a bug,
since the '0' initializer for the 'ignore_env:1' bit-field is
interpreted as a NULL pointer (hence the warning), and the final field
(now with no initializer) receives a default '0'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Brian,

If you need to re-roll your 'bc/hash-algo' branch, could you please
squash this into the relevant patch.

Thanks!

ATB,
Ramsay Jones

 repository.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 01af20dee..ceef73614 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
 
-- 
2.14.0
