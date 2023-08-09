Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26106C001E0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjHIRPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjHIRPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8701FF5
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3332E24267;
        Wed,  9 Aug 2023 13:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lEq-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/3] rebase: handle --strategy via imply_merge() as well
Date:   Wed,  9 Aug 2023 19:15:30 +0200
Message-Id: <20230809171531.2564844-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
References: <xmqqiler8cga.fsf@gitster.g>
 <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At least after the successive trimming of enum rebase_type mentioned in
the previous commit, this code did exactly what imply_merge() does, so
just call it instead.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 44cc1eed12..4a093bb125 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1490,18 +1490,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.strategy) {
 		options.strategy = xstrdup(options.strategy);
-		switch (options.type) {
-		case REBASE_APPLY:
-			die(_("--strategy requires --merge or --interactive"));
-		case REBASE_MERGE:
-			/* compatible */
-			break;
-		case REBASE_UNSPECIFIED:
-			options.type = REBASE_MERGE;
-			break;
-		default:
-			BUG("unhandled rebase type (%d)", options.type);
-		}
+		imply_merge(&options, "--strategy");
 	}
 
 	if (options.root && !options.onto_name)
-- 
2.40.0.152.g15d061e6df

