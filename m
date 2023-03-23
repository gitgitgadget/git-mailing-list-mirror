Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD8BC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjCWQrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjCWQrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:05 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37082FF04
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 2B46524212
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-Ayp-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] sequencer: rectify empty hint in call of require_clean_work_tree()
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The canonical way to represent "no error hint" is making it null, which
shortcuts the error() call altogether.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..7c275c9a65 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6168,7 +6168,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		goto cleanup;
 
-	if (require_clean_work_tree(r, "rebase", "", 1, 1))
+	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
 		goto cleanup;
 
 	todo_list_write_total_nr(&new_todo);
-- 
2.40.0.152.g15d061e6df

