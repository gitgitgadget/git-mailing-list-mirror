Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9224C83F2D
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 15:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbjICPLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbjICPLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 11:11:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A2D11A
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 08:11:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 76FF0243A4;
        Sun,  3 Sep 2023 11:11:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qcolA-6Hw-00; Sun, 03 Sep 2023 17:11:32 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] sequencer: remove unreachable exit condition in pick_commits()
Date:   Sun,  3 Sep 2023 17:11:32 +0200
Message-Id: <20230903151132.739151-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was introduced by 56dc3ab04 ("sequencer (rebase -i): implement the
'edit' command", 2017-01-02), and was pointless from the get-go, as the
command causes an early return.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
this remains valid after phillip's pending series, through it becomes
marginally harder to prove (c.f. "sequencer: factor out part of
pick_commits()").

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 sequencer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a66dcf8ab2..99e9c520ca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4832,10 +4832,6 @@ static int pick_commits(struct repository *r,
 		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
 		struct stat st;
 
-		/* Stopped in the middle, as planned? */
-		if (todo_list->current < todo_list->nr)
-			return 0;
-
 		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
 				starts_with(head_ref.buf, "refs/")) {
 			const char *msg;
-- 
2.40.0.152.g15d061e6df

