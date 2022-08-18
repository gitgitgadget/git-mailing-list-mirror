Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC74C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiHRNOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbiHRNNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:13:49 -0400
Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02991005
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:13:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a5d:5400:e242:9824:2cff:8bd5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id 809B112600A5;
        Thu, 18 Aug 2022 15:13:31 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/4] sequencer: do not translate parameters to error_resolve_conflict()
Date:   Thu, 18 Aug 2022 15:13:27 +0200
Message-Id: <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.2.596.g72ccb331cf
In-Reply-To: <cover.1660828108.git.git@grubix.eu>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`error_resolve_conflict()` checks the untranslated action_name
parameter, so pass it as is.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 51d75dfbe1..8b32b239b9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -537,7 +537,7 @@ static struct tree *empty_tree(struct repository *r)
 static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
 {
 	if (repo_read_index_unmerged(repo))
-		return error_resolve_conflict(_(action_name(opts)));
+		return error_resolve_conflict(action_name(opts));
 
 	error(_("your local changes would be overwritten by %s."),
 		_(action_name(opts)));
@@ -3753,7 +3753,7 @@ static int do_reset(struct repository *r,
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
-		ret = error_resolve_conflict(_(action_name(opts)));
+		ret = error_resolve_conflict(action_name(opts));
 		goto cleanup;
 	}
 
-- 
2.37.2.596.g72ccb331cf

