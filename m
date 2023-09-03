Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ECC83F3F
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbjICPLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjICPLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 11:11:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D3118
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 08:11:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 78F0F243A5;
        Sun,  3 Sep 2023 11:11:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qcolA-6Hh-00; Sun, 03 Sep 2023 17:11:32 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sequencer: fix error message on failure to copy SQUASH_MSG
Date:   Sun,  3 Sep 2023 17:11:32 +0200
Message-Id: <20230903151132.739136-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message talked about renaming, while the actual action is copying.
This was introduced by 6e98de72c ("sequencer (rebase -i): add support
for the 'fixup' and 'squash' commands", 2017-01-02).

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
i didn't try verifying whether the action shouldn't be actually be a
move, as i'm getting lost in this forest of files.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>

---
totally on a tangent, does someone feel like teaching copy_file() to try
ioctl(FICLONE) (i.e., reflink) first?
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index a66dcf8ab2..2f3d7d4eee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2320,7 +2320,7 @@ static int do_pick_commit(struct repository *r,
 			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
 			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
-				res = error(_("could not rename '%s' to '%s'"),
+				res = error(_("could not copy '%s' to '%s'"),
 					    rebase_path_squash_msg(), dest);
 				goto leave;
 			}
-- 
2.40.0.152.g15d061e6df

