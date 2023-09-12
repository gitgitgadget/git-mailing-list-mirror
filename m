Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C0CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 10:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjILKzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjILKzr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 06:55:47 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E96B3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 03:55:43 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4B4CF202E9;
        Tue, 12 Sep 2023 06:55:42 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qg13V-902-00; Tue, 12 Sep 2023 12:55:41 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] sequencer: remove unreachable exit condition in pick_commits()
Date:   Tue, 12 Sep 2023 12:55:41 +0200
Message-ID: <20230912105541.272917-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <ddf8dc95-6583-4257-b48a-0115f59950ef@gmail.com>
References: <ddf8dc95-6583-4257-b48a-0115f59950ef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was introduced by 56dc3ab04 ("sequencer (rebase -i): implement the
'edit' command", 2017-01-02), and was pointless from the get-go: all
early exits from the loop above are returns, so todo_list->current ==
todo_list->nr is an invariant after the loop.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v2:
- improved commit message

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
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
2.42.0.419.g70bf8a5751

