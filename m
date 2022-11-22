Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A91C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 03:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiKVDRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVDRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 22:17:50 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28AC5175A3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 19:17:48 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3368B1E80D9E
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:14:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iLeAsTkYyYXw; Tue, 22 Nov 2022 11:14:12 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 290941E80D9A;
        Tue, 22 Nov 2022 11:14:12 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     git@vger.kernel.org
Cc:     Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] builtin: submodule--helper: Add allocation check of module_cb structure objects may be helpful in case of allocation failure
Date:   Tue, 22 Nov 2022 11:17:39 +0800
Message-Id: <20221122031739.3440-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of using temp is unknown, but adding an allocation failure
report should be helpful.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 builtin/submodule--helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b63f420ece..2e379623ea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1077,6 +1077,9 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
 			continue;
 		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		if (!temp)
+			 BUG("The module_cb structure object fails to be allocated and the program may terminate abnormally");
+
 		temp->mod_src = p->one->mode;
 		temp->mod_dst = p->two->mode;
 		temp->oid_src = p->one->oid;
-- 
2.18.2

