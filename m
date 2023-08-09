Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9519C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjHIRPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjHIRPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F046A2103
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 33A9F24315;
        Wed,  9 Aug 2023 13:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lEw-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] rebase: move parse_opt_keep_empty() down
Date:   Wed,  9 Aug 2023 19:15:31 +0200
Message-Id: <20230809171531.2564844-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
References: <xmqqiler8cga.fsf@gitster.g>
 <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves it right next to parse_opt_empty(), which is a much more
logical place. As a side effect, this removes the need for a forward
declaration of imply_merge().

Acked-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
i'm not sure how to "translate" phillip's informal approval; the
acked-by doesn't seem quite right. please adjust as necessary.

Cc: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a093bb125..13ca5a644b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -376,19 +376,6 @@ static int run_sequencer_rebase(struct rebase_options *opts)
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
@@ -982,6 +969,18 @@ static enum empty_type parse_empty_value(const char *value)
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

