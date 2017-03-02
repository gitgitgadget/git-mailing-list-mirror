Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C7E2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 01:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbdCBBnD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 20:43:03 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32839 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbdCBBnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 20:43:02 -0500
Received: by mail-pf0-f170.google.com with SMTP id w189so16401659pfb.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 17:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPJ/DKIkcCKuMHbFogJK3yf1A9OnP4NPqE1Z6fWwan8=;
        b=VHhr56Uv9ZuKDTs/HpXN4rcUbfAgXPI7iGmax5QKvf09/VTPssuUrs+l/R/xcSgCM1
         1dkIXda3Qznsar2TcpIn03Pl7XubpBR/s0/4ceFDzjvK/mzGNa6TlIIupJLyHQbZER1O
         hAX0UNpsx0qYDe2x1JukS1nPCcXVfqCb3raVh6NTdDNv5fH3luXcmLwsMHpCjsDbxo1B
         cB1Uky/kx5RHrletfJtBIFjBLX4zNPxv/W5RMLhaZC5PS+yVG0TUzfZEbs8OMHlBJnlz
         ZC5wfUFdIF9aMFxH393+x9K6n8P715Vocy130rKMAK7geHw96SNFqpQxt9Vj6+TWnOjs
         8IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPJ/DKIkcCKuMHbFogJK3yf1A9OnP4NPqE1Z6fWwan8=;
        b=LW50friikgtg7VeLPMnTv2mPokA4vqfkfOQlJKxMKI2smHnzsvMPT9XT9nLgeZNuFi
         Wf5v4pcUsPPxU77DBI0z2dUBC/AWtP7PK9rxtk9oJ2AcXHSTMYDiH3CTbfjbn6XkrriU
         x1Gj4Tr8blQkwhB7uj+4WsiYOrjifYWGJxzgusPDCw/GhujvZDqOMwESs1m2Y5MR1QhY
         SOy3cBmyh8g3OJAnSsvWy6qzlDStLnOTUcz4mzY7NZtKW3c3C5xeRnxJaXVF6jNjVV5L
         vGKDX4R5eNKL21kt9WpQ5vUfymzDpHj95fvnkTGBsSBQ5VDPuqJWhJpV2kP5UKZJXh4R
         xrrA==
X-Gm-Message-State: AMke39klEXPv/OJTMkwSxI8qGCSZP4ix7kO4bs3GdBk/broZNj1wibcG7RENVjOwaikO/mLG
X-Received: by 10.98.68.199 with SMTP id m68mr12147867pfi.31.1488415703026;
        Wed, 01 Mar 2017 16:48:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id z27sm12775720pfg.38.2017.03.01.16.48.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe selected submodules.
Date:   Wed,  1 Mar 2017 16:47:56 -0800
Message-Id: <20170302004759.27852-16-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9054369dd0..9a2abacf7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,8 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -520,6 +522,22 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	return 1;
 }
 
+static void remove_submodule_according_to_strategy(const struct submodule *sub)
+{
+	switch (sub->update_strategy.type) {
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_CHECKOUT:
+	case SM_UPDATE_REBASE:
+	case SM_UPDATE_MERGE:
+		submodule_move_head(sub->path, "HEAD", NULL, \
+				    SUBMODULE_MOVE_HEAD_FORCE);
+		break;
+	case SM_UPDATE_NONE:
+	case SM_UPDATE_COMMAND:
+		; /* Do not touch the submodule. */
+	}
+}
+
 /*
  * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
@@ -532,8 +550,13 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
-			remove_name_hash(istate, ce_array[i]);
-			save_or_free_index_entry(istate, ce_array[i]);
+			const struct submodule *sub = submodule_from_ce(ce_array[i]);
+			if (sub) {
+				remove_submodule_according_to_strategy(sub);
+			} else {
+				remove_name_hash(istate, ce_array[i]);
+				save_or_free_index_entry(istate, ce_array[i]);
+			}
 		}
 		else
 			ce_array[j++] = ce_array[i];
-- 
2.12.0.rc1.52.ge239d7e709.dirty

