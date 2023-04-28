Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6F3C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 12:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjD1M4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjD1M4K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 08:56:10 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05C2701
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 05:56:05 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id F073223FF7
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 08:56:01 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psNdp-DO3-00
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 14:56:01 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH v2] rebase: clarify conditionals in todo_list_to_strbuf()
Date:   Fri, 28 Apr 2023 14:56:01 +0200
Message-Id: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it obvious that the two conditional branches are mutually
exclusive. This makes it easier to comprehend and optimize.

As a drive-by, remove a pair of unnecessary braces.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- slightly more verbose commit message
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..9169876441 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5868,12 +5868,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
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

