Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD7CC76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjCWQsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjCWQrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:07 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137910242
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DA93C241F5
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-Ay7-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] sequencer: beautify subject of reverts of reverts
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of generating a silly-looking `Revert "Revert "foo""`, make it
`Reapply "foo"`.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..853b4ed334 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2234,6 +2234,9 @@ static int do_pick_commit(struct repository *r,
 		if (opts->commit_use_reference) {
 			strbuf_addstr(&msgbuf,
 				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+		} else if (starts_with(msg.subject, "Revert \"")) {
+			strbuf_addstr(&msgbuf, "Reapply ");
+			strbuf_addstr(&msgbuf, msg.subject + 7);
 		} else {
 			strbuf_addstr(&msgbuf, "Revert \"");
 			strbuf_addstr(&msgbuf, msg.subject);
-- 
2.40.0.152.g15d061e6df

