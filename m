Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10FC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjCWQrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjCWQrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:03 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECBDCC0A
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:32 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C78B824235
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B07-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 2/8] rebase: move parse_opt_keep_empty() down
Date:   Thu, 23 Mar 2023 17:22:29 +0100
Message-Id: <20230323162235.995574-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves it right next to parse_opt_empty(), which is a much more
logical place. As a side effect, this removes the need for a forward
declaration of imply_merge().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 builtin/rebase.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8ffea0f0d8..491759db19 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -362,19 +362,6 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 	return ret;
 }
 
-static void imply_merge(struct rebase_options *opts, const char *option);
-static int parse_opt_keep_empty(const struct option *opt, const char *arg,
-				int unset)
-{
-	struct rebase_options *opts = opt->value;
-
-	BUG_ON_OPT_ARG(arg);
-
-	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
-	opts->keep_empty = !unset;
-	return 0;
-}
-
 static int is_merge(struct rebase_options *opts)
 {
 	return opts->type == REBASE_MERGE;
@@ -969,6 +956,18 @@ static enum empty_type parse_empty_value(const char *value)
 	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
 }
 
+static int parse_opt_keep_empty(const struct option *opt, const char *arg,
+				int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+
+	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
+	opts->keep_empty = !unset;
+	return 0;
+}
+
 static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *options = opt->value;
-- 
2.40.0.152.g15d061e6df

