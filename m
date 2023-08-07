Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE44C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHGRJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjHGRJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37948E63
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id AC8F024298;
        Mon,  7 Aug 2023 13:09:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nsb-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] t/lib-rebase: improve documentation of set_fake_editor()
Date:   Mon,  7 Aug 2023 19:09:35 +0200
Message-Id: <20230807170935.2336663-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
 <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Make it reflect better what actually happens. This makes it easier to
  fully exploit the possibilities and to modify the code.
- Improve the structure, putting more general info further up.
- Document `fakesha` and `break`.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 t/lib-rebase.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 9ed87ca7ab..184b25b427 100644
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
+#       "pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword",
+#       "drop", "merge[_-{c|C}_<SHA1>]", or "bad" for an invalid command.
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
+#   "exec_[...]", "break" -- add the specified command.
 #
 #   "#" -- Add a comment line.
 #
-- 
2.40.0.152.g15d061e6df

