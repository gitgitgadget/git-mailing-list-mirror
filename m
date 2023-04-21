Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408DC77B61
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 00:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjDVA1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 20:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDVA1t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 20:27:49 -0400
X-Greylist: delayed 2587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 17:27:48 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8741FCB
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 17:27:48 -0700 (PDT)
Received: from [2400:4160:1877:2b00:92c5:b2c1:56d7:4a66] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <glandium@glandium.org>)
        id 1pq0Qa-009KQX-2c;
        Fri, 21 Apr 2023 23:44:37 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1pq0QU-0084uY-Cv; Sat, 22 Apr 2023 08:44:26 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix memory leak in get_reachable_subset
Date:   Sat, 22 Apr 2023 08:44:09 +0900
Message-Id: <20230421234409.1925489-1-mh@glandium.org>
X-Mailer: git-send-email 2.40.0.1.gc689dad23e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 commit-reach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 70bde8af05..f15d84566b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -944,6 +944,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		}
 	}
 
+	clear_prio_queue(&queue);
+
 	clear_commit_marks_many(nr_to, to, PARENT1);
 	clear_commit_marks_many(nr_from, from, PARENT2);
 
-- 
2.39.0.1.g6739ec1790

