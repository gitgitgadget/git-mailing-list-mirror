Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537372022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdBWXHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:07:21 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34633 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdBWXHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:07:20 -0500
Received: by mail-pg0-f46.google.com with SMTP id 1so2328824pgi.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ctcxOn5xn+031fK1+Cf4jj5n7vYNbLtfYGAgiWFpCfE=;
        b=a2RIiDc3PquVStHf22BEBvr85k0mBA4YoI9ga2T5OlCfbVfzaMpx6AayIxMjucKp7x
         r9DmjyTr1O/ZipX3ZobTnNa1CtIm5a/eMQ8bBDq8Sj99hW8W/kHvbqZv2F6SNPEqaHX7
         CfgeVS8hewLY7uL5LZiTR2gjYQIBQ75jrIwZfvELa8NGpnHA4xeBUJlH6RtgTo+WNB3X
         gKIgAM/vHa7m2Gv/FRK0OdIdOenxYIhMWIOQEpBO+W52HJ3phZMC3lQAT7cuhoI1yceA
         13QxTWcgQIhEoXiqee2R9D0qCDF5GymL6ZJ7OAN4UyclOgwmr3FVFsyoOy4FSYuYO65a
         g1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ctcxOn5xn+031fK1+Cf4jj5n7vYNbLtfYGAgiWFpCfE=;
        b=jPeIpSCQMsKEKy+ZLfTX+9RSrrPr7rc4TfsFkzZLhvp2tIok4FJOIBtN27/PKrrCl1
         /40AdSVIf2aZR3uSf+7G9Gef5aE7xhFr+lN+3jpxMNVAXJP1rcanATROtJnPSwgxaVpE
         1vt3R/CIv6yOZyHWTu4zTeyU7ix6qMSGlOM+ZwRjS/Qr9K0wYFhd3inoJM+Ajp7iHr6b
         uxe3AXi6D8gEgkbjtXd/7s0MBynnkI+Mw7IUxLsidMnStGlTj8UdYChrf0eBJBc9K3Rp
         ebrv5AdDWbYgE5oo6WdJT09Inr9UbaEXJBztu6kb9EYOPKw/XEz4vDjLh4PW3Il4FEGE
         PxZA==
X-Gm-Message-State: AMke39ljrpbQrJmt6GHIeWCxKs/NlJjETU6npL9hiU6Vme7hPmAirVwEt4/VHH80K7vCnzPi
X-Received: by 10.84.212.2 with SMTP id d2mr58354244pli.152.1487890687678;
        Thu, 23 Feb 2017 14:58:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id p66sm11581453pfb.88.2017.02.23.14.58.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:58:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 13/15] read-cache, remove_marked_cache_entries: wipe selected submodules.
Date:   Thu, 23 Feb 2017 14:57:33 -0800
Message-Id: <20170223225735.10994-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
2.12.0.rc1.16.ge4278d41a0.dirty

