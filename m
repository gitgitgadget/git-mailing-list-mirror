Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD50C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeFFHj4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:39:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43179 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeFFHjt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so7540612lfn.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WD4sRbQbinWKhP9ZQefGGRE3/S6IsiSX0UgIqEtSn5M=;
        b=OWGJPu4gyjbkY+h0+IMRVsSMgWREFhL4HNv0SCFQMsJSAZ5amwdmi3f/vINY0z2bBP
         5eKLGx8wLSpbUT0HDoXGGxHKrt5hJ3N/tpntgxgOFFafIudJ/OV5W3MIr9wl+cURPmbo
         83uYh92Fo4GrY1fJPIdQ8aEGqkMjawB5Sxfzu4HUYiB5Ijsb2FKeGy+Qgy8s6vEepI98
         L9LfEL9KB23ulspvt2LJgGkST/utHQGFOIu9XVYx+jG1IAvhaNPvSJK2Woi+0w8plXY3
         PvB8P/Ck9bQC7auwJpGz1hCxfwnTRwgPdyv6tqaw7ALPs3qhPDcZN2m3VhlFVsANcMmF
         oZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD4sRbQbinWKhP9ZQefGGRE3/S6IsiSX0UgIqEtSn5M=;
        b=XI+iDLqPVAruEy9Xt+9Crf6NM7nYepboI6DFY6tioxXOYjboGyYvsAm4/UrUKzwJb3
         TiNk3WHOXBrWFgl/DRV4vyzWsh5QR89fWvUMSyhL/0FoByDBpqtIQhQzOe6xcVr96JWn
         1pfiDu3Z/tA2krqGyFOkasMQUDUWMUi3zb1a2Bkt/pVx3xOfbMrTC7gEIo76wI+8XGEb
         w7t6+9kZD2YPmUSWRPOMBgROoThv5kdHi4sGyJFGMhDFKpZ2ZFEa/zK08eVn1zvNo35b
         SOy2eeI7QKSMx64aRZmMJQdhTtzZRn+1YnjiTEQDSa6GXbLW4hUF2F/gB6+oeKGQdy6X
         p90w==
X-Gm-Message-State: APt69E2RwxMXLVsEy/nwhjCjyEmDGnRjfSye7I5gVjXdXY8PxvFvNXxM
        ZfEfemgCMixTn5P04+BCSsPhmg==
X-Google-Smtp-Source: ADUXVKKsi0xj9PjmIuOWCitOlsrC+raIvPD+DzyeFLgTxDVpw0csw8Ftj2jjv/4IrSWJDpUWNxYTGA==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr1226975ljh.132.1528270787848;
        Wed, 06 Jun 2018 00:39:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 03/20] unpack-trees: don't shadow global var the_index
Date:   Wed,  6 Jun 2018 09:39:16 +0200
Message-Id: <20180606073933.14755-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function mark_new_skip_worktree() has an argument named the_index
which is also the name of a global variable. While they have different
types (the global the_index is not a pointer) mistakes can easily
happen and it's also confusing for readers. Rename the function
argument to something other than the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5d06aa9c98..45fcda3169 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1231,7 +1231,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
 static void mark_new_skip_worktree(struct exclude_list *el,
-				   struct index_state *the_index,
+				   struct index_state *istate,
 				   int select_flag, int skip_wt_flag)
 {
 	int i;
@@ -1240,8 +1240,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 1. Pretend the narrowest worktree: only unmerged entries
 	 * are checked out
 	 */
-	for (i = 0; i < the_index->cache_nr; i++) {
-		struct cache_entry *ce = the_index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
@@ -1256,8 +1256,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(the_index->cache, the_index->cache_nr,
-		       select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate->cache, istate->cache_nr, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
-- 
2.18.0.rc0.333.g22e6ee6cdf

