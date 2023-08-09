Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD1C04A94
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjHIRPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHIRPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:36 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECBA1FF5
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:35 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B635D24310;
        Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lDl-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/1] t/lib-rebase: improve documentation of set_fake_editor()
Date:   Wed,  9 Aug 2023 19:15:31 +0200
Message-Id: <20230809171531.2564785-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
 <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firstly, make it reflect better what actually happens. Not omitting some
possibilities makes it easier to fully exploit them, and not
contradicting the implementation makes it easier to grok and thus modify
the code.

Secondly, improve the overall structure, putting more general info
further up.

Thirdly, document `merge`, `fakesha`, and `break`, which were previously
omitted entirely.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v2:
- everything phillip asked for, i think. of course, it's still bullet
  points, just without the punctuation - i wouldn't know what else to
  do about it which would be an actual improvement.

Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 t/lib-rebase.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ca5b918f0..133c856992 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -8,18 +8,21 @@
 # - check that non-commit messages have a certain line count with $EXPECT_COUNT
 # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
 # - rewrite a rebase -i script as directed by $FAKE_LINES.
-#   $FAKE_LINES consists of a sequence of words separated by spaces.
-#   The following word combinations are possible:
+#   $FAKE_LINES consists of a sequence of words separated by spaces;
+#   spaces inside the words are encoded as underscores.
+#   The following words are possible:
 #
-#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
-#       specified line.
+#   "<cmd>" -- override the command for the next line specification. Can be
+#       "pick", "squash", "fixup[_-(c|C)]", "edit", "reword", "drop",
+#       "merge[_-{c|C}_<rev>]", or "bad" for an invalid command.
 #
-#   "<cmd> <lineno>" -- add a line with the specified command
-#       ("pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword" or "drop")
-#       and the SHA1 taken from the specified line.
+#   "<lineno>" -- add a command, using the specified line as a template.
+#       If the command has not been overridden, the line will be copied
+#       verbatim, usually resulting in a "pick" line.
 #
-#   "_" -- add a space, like "fixup_-C" implies "fixup -C" and
-#       "exec_cmd_with_args" add an "exec cmd with args" line.
+#   "fakesha" -- add a command ("pick" by default), using a fake SHA1.
+#
+#   "exec_[command...]", "break" -- add the specified command.
 #
 #   "#" -- Add a comment line.
 #
-- 
2.40.0.152.g15d061e6df

