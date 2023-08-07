Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ABC04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjHGRJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjHGRJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7EE65
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id A595324228;
        Mon,  7 Aug 2023 13:09:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nsV-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] t/lib-rebase: set_fake_editor(): handle FAKE_LINES more consistently
Date:   Mon,  7 Aug 2023 19:09:34 +0200
Message-Id: <20230807170935.2336663-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
 <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Default next action after 'fakesha' to preserving the command instead
of forcing 'pick', consistently with other "instant-effect" keywords.
There is no reason why one would want that inconsistency, so this was
clearly just an oversight in commit 5dcdd740 ("t/lib-rebase: prepare
for testing `git rebase --rebase-merges`"). Rectifying it makes the
behavior easier to reason about and document.

This would affect hypothetical "fakesha <n>" sequences where line <n>
already isn't a pick, which currently don't appear.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 t/lib-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index e6179ab529..9ed87ca7ab 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -64,7 +64,7 @@ set_fake_editor () {
 		fakesha)
 			test \& != "$action" || action=pick
 			echo "$action XXXXXXX False commit" >> "$1"
-			action=pick;;
+			action=\&;;
 		*)
 			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
 			action=\&;;
-- 
2.40.0.152.g15d061e6df

