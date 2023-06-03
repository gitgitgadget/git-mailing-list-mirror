Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA08DC77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjFCBO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCBO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:14:27 -0400
X-Greylist: delayed 2726 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 18:14:04 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C1E62
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:14:04 -0700 (PDT)
Received: from [2400:4160:1877:2b00:5c92:28a8:5040:3bae] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <glandium@glandium.org>)
        id 1q5F88-000Gr3-2t;
        Sat, 03 Jun 2023 00:28:33 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1q5F83-004hvA-L6; Sat, 03 Jun 2023 09:28:23 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix memory leak in get_reachable_subset
Date:   Sat,  3 Jun 2023 09:28:19 +0900
Message-ID: <20230603002819.1122129-1-mh@glandium.org>
X-Mailer: git-send-email 2.41.0.6.ge371d37104
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Mike Hommey <mh@glandium.org>
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
2.41.0.6.ge371d37104

