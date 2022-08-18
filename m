Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8EBC3F6B0
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbiHRNOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244970AbiHRNNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:13:47 -0400
Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FDB2493
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:13:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a5d:5400:e242:9824:2cff:8bd5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id 5943112600A7;
        Thu, 18 Aug 2022 15:13:32 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/4] sequencer: do not translate command names
Date:   Thu, 18 Aug 2022 15:13:28 +0200
Message-Id: <f1d4ee05af8f88bfdca94c5e2030228e8ad5610f.1660828108.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.2.596.g72ccb331cf
In-Reply-To: <cover.1660828108.git.git@grubix.eu>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When action_name is used to denote a command `git %s` do not translate
since command names are never translated.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8b32b239b9..79dad522f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2422,7 +2422,7 @@ static int read_and_refresh_cache(struct repository *r,
 	if (repo_read_index(r) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
-			_(action_name(opts)));
+			action_name(opts));
 	}
 	refresh_index(r->index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 
@@ -2430,7 +2430,7 @@ static int read_and_refresh_cache(struct repository *r,
 		if (write_locked_index(r->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED)) {
 			return error(_("git %s: failed to refresh the index"),
-				_(action_name(opts)));
+				action_name(opts));
 		}
 	}
 
-- 
2.37.2.596.g72ccb331cf

