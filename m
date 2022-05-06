Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D75C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbiEFSLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiEFSLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:11:00 -0400
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [217.11.48.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BC6A035
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:07:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a00:20:704b:4372:c7cc:d7c9:fd95:983d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy06.manitu.net (Postfix) with ESMTPSA id 7DB085803A6;
        Fri,  6 May 2022 20:07:14 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] http.c: avoid gcc warning
Date:   Fri,  6 May 2022 20:04:06 +0200
Message-Id: <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
X-Mailer: git-send-email 2.36.0.553.g068b50827d
In-Reply-To: <cover.1651859773.git.git@grubix.eu>
References: <cover.1651859773.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Related to -Wdangling-pointer.

In fact, this use of the pointer looks scary and has not created
problems so far only because the pointer in the struct is not used when
execution is out of the scope of the local function (and the pointer
invalid).

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 229da4d148..2f67fbb33c 100644
--- a/http.c
+++ b/http.c
@@ -1367,6 +1367,7 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	slot->finished = NULL;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
-- 
2.36.0.553.g068b50827d

