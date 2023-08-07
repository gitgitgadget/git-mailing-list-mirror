Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048AC04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjHGRJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjHGRJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76402E67
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 25C2B242B7;
        Mon,  7 Aug 2023 13:09:36 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nta-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
Date:   Mon,  7 Aug 2023 19:09:35 +0200
Message-Id: <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it obvious that the two conditional branches are mutually
exclusive. This makes it easier to comprehend and optimize, like a
switch statement would do, except that it would be overkill here.

As a drive-by, remove a pair of unnecessary braces.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2 & v3:
- slightly more verbose commit message

Cc: Taylor Blau <me@ttaylorr.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..97801d0489 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5880,12 +5880,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 			if (item->command == TODO_FIXUP) {
 				if (item->flags & TODO_EDIT_FIXUP_MSG)
 					strbuf_addstr(buf, " -c");
-				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
+				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
 					strbuf_addstr(buf, " -C");
-				}
-			}
-
-			if (item->command == TODO_MERGE) {
+			} else if (item->command == TODO_MERGE) {
 				if (item->flags & TODO_EDIT_MERGE_MSG)
 					strbuf_addstr(buf, " -c");
 				else
-- 
2.40.0.152.g15d061e6df

