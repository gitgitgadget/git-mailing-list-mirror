Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25F01F516
	for <e@80x24.org>; Sat, 30 Jun 2018 22:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeF3WSm (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 18:18:42 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57050 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeF3WSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 18:18:41 -0400
X-Greylist: delayed 2251 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jun 2018 18:18:40 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <glandium@glandium.org>)
        id 1fZNcA-0005As-1D; Sun, 01 Jul 2018 06:41:06 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] fast-import: Don't count delta attempts against an empty buffer
Date:   Sun,  1 Jul 2018 06:41:06 +0900
Message-Id: <20180630214106.19848-1-mh@glandium.org>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the reference buffer is empty, diff_delta returns NULL without
really attempting anything, yet fast-import counts that as a delta
attempt.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 4d55910ab9..12195d54d7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1076,7 +1076,7 @@ static int store_object(
 		return 1;
 	}
 
-	if (last && last->data.buf && last->depth < max_depth
+	if (last && last->data.len && last->data.buf && last->depth < max_depth
 		&& dat->len > the_hash_algo->rawsz) {
 
 		delta_count_attempts_by_type[type]++;
-- 
2.18.0

