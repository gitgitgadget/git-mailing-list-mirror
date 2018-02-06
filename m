Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5697E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBFAWW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:22:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35576 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBFAWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:22:20 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so174915pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=diO8kgw/u6V9c6WK7ClEDbZSUkWfE6fZYEJczDKpqd0=;
        b=YSZfkWoDdFaON7zsPwD8/bttTrT5rgpl5sp0X1YmI7+CncLmQwO7rMe0HyHasJdhLL
         NpMt+v4dw+0ctu3vR1ib/LDEd/IMszYR/2J/+vfUZUgVLY7csErDB/s/oe9rk0krIGPi
         zGxKUK8ApxTlOxmkE3RHKpYt4PJC9U0rIiD9HPgyJRvbLiKAlq+Pl7eIc19y1O3lTVFI
         xstcREc2TpsYPN/mIMGvrIThcneGv1WbBwNCVbZnJjDqwODraAM2eUkpFNMibtx+tJev
         tksi4F+H5bXMwTQypcI/CHKAGwOf3aEv1Uw3CW/5pqrnvbufz2ZDUmZyUTMKzpFf7/9v
         Cj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=diO8kgw/u6V9c6WK7ClEDbZSUkWfE6fZYEJczDKpqd0=;
        b=cdy1LiGCvpMarhby+b9hB/ASoHP6efTmp/BcUlL7FhdHutQaFdAxwnKAnhdFUt9JVc
         7uHhlziI0bzmyqdoNBfVfzMGPDsGuy4mZj4ZP+xnmcgoYJvuTyq6n364XWhSyGjr1Wrl
         sAXQCjAcXxQYUpp6P2F5JhWsSIaSHtE0RhNtJb3O2RgVsNRTUz31MmcYEpFDDcHcqXRx
         DRPcAwAqX8ZuhsegWlSKPxCSil5wwLyKA1m/5XAzQs7mZidsfA2TblgIEtt4R4xEy/Ai
         7JtrgGrvmdBybAE4LSOSqlWsjrd8IJ/ZDbgvlvLezUbzs+96WcMbv+ZGG18KNWpy/Idm
         bFgQ==
X-Gm-Message-State: APf1xPCoNtTBg1WGPO7eoUjhK18+6aANA+KUq3SNQ2I3dKVYNmryuFu/
        MExWFtU+exe1XS7QO7uweOGAiOTkbyA=
X-Google-Smtp-Source: AH8x225WsypGpkbuqYlsPh0Ycri24BHg3IHLFTVAhXJVzsbnrb0Cx0Y/saFM7eu4VLJnudUN263IFQ==
X-Received: by 10.99.60.86 with SMTP id i22mr416003pgn.399.1517876538931;
        Mon, 05 Feb 2018 16:22:18 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j12sm300403pfa.95.2018.02.05.16.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:22:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 127/194] alternates: convert add_to_alternates_memory to handle arbitrary repos
Date:   Mon,  5 Feb 2018 16:16:42 -0800
Message-Id: <20180206001749.218943-29-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alternates.h | 3 +--
 sha1_file.c  | 7 +++----
 tmp-objdir.c | 1 +
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/alternates.h b/alternates.h
index e4520ae5c7..b3d8d57ba4 100644
--- a/alternates.h
+++ b/alternates.h
@@ -56,8 +56,7 @@ extern void add_to_alternates_file_the_repository(const char *dir);
  * recursive alternates it points to), but do not modify the on-disk alternates
  * file.
  */
-#define add_to_alternates_memory(r, d) add_to_alternates_memory_##r(d)
-extern void add_to_alternates_memory_the_repository(const char *dir);
+extern void add_to_alternates_memory(struct repository *r, const char *dir);
 
 /*
  * Returns a scratch strbuf pre-filled with the alternate object directory,
diff --git a/sha1_file.c b/sha1_file.c
index 743ada360d..3c39e34c72 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -581,16 +581,15 @@ void add_to_alternates_file_the_repository(const char *reference)
 	free(alts);
 }
 
-void add_to_alternates_memory_the_repository(const char *reference)
+void add_to_alternates_memory(struct repository *r, const char *reference)
 {
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 
-	link_alt_odb_entries(the_repository, reference,
-			     '\n', NULL, 0);
+	link_alt_odb_entries(r, reference, '\n', NULL, 0);
 }
 
 /*
diff --git a/tmp-objdir.c b/tmp-objdir.c
index a9334d3fc5..acd55680c8 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tmp-objdir.h"
 #include "alternates.h"
+#include "repository.h"
 #include "dir.h"
 #include "sigchain.h"
 #include "string-list.h"
-- 
2.15.1.433.g936d1b9894.dirty

