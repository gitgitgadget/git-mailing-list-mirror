Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBFA1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755193AbdDAAZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:25:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35111 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754965AbdDAAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:25:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so1948734wmb.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tN+oLNaXhKpM+z2RCT5HjNwCXN690mLrotAnQ4yFVhM=;
        b=llYBslZwLH6Fhfg2MAdu4XPTT//jHzbFKiH5IzPXcpy/wCEn5pzB/du/nn0blBRB2q
         8Ymp3lp67Qg+gL5JVo0saY1aqsgpjnB3MuUKlcEWQMuba2YPJi6zXZR+xRbiaCH3/yps
         nN1qBHR9NzM5HESJBdfFHtaqP4X64rBeuhXzaFhjhLhq8/7Gy0Rl2IF1n3G1hYnSmbku
         HIofJ1IYXsoKBLqMS3LD8kjZjlXyAi9F5Gk730uSCKWySGlM2+gHCJ//VawsP0/luw7l
         /ICSmZ34U9pPGNAgN7vsD6Ht9OP4ki2Z4YsyeWDqy08MmmTVDM7sHN4MnXOIkI+vd0qR
         soeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tN+oLNaXhKpM+z2RCT5HjNwCXN690mLrotAnQ4yFVhM=;
        b=g5YeJYssg/NK4Dynys4XhJpT2N7cyVVEaQ9zcG3GWr/bKYF5O9wM2TLpqebDFHmBzV
         1cW/YXT6/jzAjcgv2RAUzAG6jKOH0ZAdzOlI5sShbAaw86dfFGfOizNQVrQECA26+9G/
         3ZnTOjZzZZc/AdzDrnJ0oN3YvuKoBb63Z3PTQIZjk1L4q2jKcD17rJ8xuZDEXqjIIfc8
         KjZiaf/E3f+3zBoIZNpHihz89e5MYdJYuqUFQNtzfmgrUPliwWqLQi/i9dScQWMcfnh3
         huJjCGmw0SDc/Nx2+ireuBlUo5sSl2zGQROVuvMb9lVOPRw5Zjdq6tFnFDcSI2r/Afgd
         6YpA==
X-Gm-Message-State: AFeK/H30rgHjC6iZzCxEo1h0DuaQpvD84Os2Xo5vtLT30USuyeZ11WiTJ1OXQoAazkW6TA==
X-Received: by 10.28.37.3 with SMTP id l3mr306953wml.100.1491006310414;
        Fri, 31 Mar 2017 17:25:10 -0700 (PDT)
Received: from localhost.localdomain ([178.156.154.74])
        by smtp.gmail.com with ESMTPSA id j32sm8514488wre.7.2017.03.31.17.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 17:25:09 -0700 (PDT)
From:   Robert Stanca <robert.stanca7@gmail.com>
To:     git@vger.kernel.org
Cc:     Robert Stanca <robert.stanca7@gmail.com>
Subject: [PATCH] [GSOC] remove_temporary_files(): reimplement using iterators
Date:   Sat,  1 Apr 2017 03:24:58 +0300
Message-Id: <20170401002458.3494-1-robert.stanca7@gmail.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f91.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replaces recursive traversing of opendir with dir_iterator

Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
---
 builtin/repack.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81..dba465814 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -7,6 +7,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -49,12 +51,7 @@ static void remove_temporary_files(void)
 {
 	struct strbuf buf = STRBUF_INIT;
 	size_t dirlen, prefixlen;
-	DIR *dir;
-	struct dirent *e;
-
-	dir = opendir(packdir);
-	if (!dir)
-		return;
+	struct dir_iterator *diter = dir_iterator_begin(packdir);
 
 	/* Point at the slash at the end of ".../objects/pack/" */
 	dirlen = strlen(packdir) + 1;
@@ -62,14 +59,13 @@ static void remove_temporary_files(void)
 	/* Hold the length of  ".tmp-%d-pack-" */
 	prefixlen = buf.len - dirlen;
 
-	while ((e = readdir(dir))) {
-		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (strncmp(diter->relative_path, buf.buf + dirlen, prefixlen))
 			continue;
 		strbuf_setlen(&buf, dirlen);
-		strbuf_addstr(&buf, e->d_name);
+		strbuf_addstr(&buf, diter->relative_path);
 		unlink(buf.buf);
 	}
-	closedir(dir);
 	strbuf_release(&buf);
 }
 
-- 
2.12.2.575.gb14f27f91.dirty

