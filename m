Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98439C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BBE20708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 08:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKVIye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:54:34 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34194 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVIye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 03:54:34 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92.3)
        (envelope-from <glandium@glandium.org>)
        id 1iY4R6-0007cq-IG; Fri, 22 Nov 2019 17:37:04 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 1/2] revision: clear the topo-walk flags in reset_revision_walk
Date:   Fri, 22 Nov 2019 17:37:03 +0900
Message-Id: <20191122083704.29267-1-mh@glandium.org>
X-Mailer: git-send-email 2.24.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not doing so can lead to wrong topo-walks when using the revision walk API
consecutively.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

As mentioned in 20191108025007.bphr7ynvskeoe6tb@glandium.org, it feels
like maybe TOPO_WALK_EXPLORED and TOPO_WALK_INDEGREE should be in
ALL_REV_FLAGS too?

diff --git a/revision.c b/revision.c
index 0e39b2b8a5..765a56ae33 100644
--- a/revision.c
+++ b/revision.c
@@ -3098,7 +3098,7 @@ static void set_children(struct rev_info *revs)
 
 void reset_revision_walk(void)
 {
-	clear_object_flags(SEEN | ADDED | SHOWN);
+	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
 }
 
 static int mark_uninteresting(const struct object_id *oid,
-- 
2.24.0.dirty

