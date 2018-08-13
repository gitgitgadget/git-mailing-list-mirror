Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BD41F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeHMS60 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43713 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMS6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so13014566ljg.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BhCbnxXq3tlY7H8OazZNbVLASh1acVRI06J80yd9/s=;
        b=je2AosCkz2RiDt8hOJV9cGqMBqRxxF3lWiSaKznRbJtuT/eo+e2jy8r4gPMc4ROnS3
         y7sY3a/l4fTP3EY62krNwNE99oIsEY2uju2Ls6c1sVLTh3oPRGXL5FAl3kvTZ+k8+kvi
         tsQaNaSXFPeJ5BavgJ9M6A5WcHYap2I0MqJM0Ot1zm7+cXTYu1zIoGWWV+K5p449fNmp
         rJEesIax76YaJxLoWjGPR2tGLg8IbbxZ7HGJA7xJ4t1xam3IDDfn+n2lkq6jhyPz/rFw
         wuqREXpjPtDoFQagx1Ur36XoVZoQ9zRuNwZeWtpS8otFMAIaJ+RQ19KGVMiQyifF1Yjo
         ulnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BhCbnxXq3tlY7H8OazZNbVLASh1acVRI06J80yd9/s=;
        b=QDmk6TctiI14ra1JUMF+kbsbkC8j2fCbGgSL2hPctBZup1TgYWpvgLO/iMFp11/fAF
         WBSEchuQBz5Ac72LvFpssNNRlMEIi7X5I3PriGcRHX99sMZVvQx7jCIaGqWIMkWrMoGL
         TdnHD8qb7xy9EUXDyZOHmfN3PTLSjWu9ZwTc2CtruVoZgAYpgM/AQJk2k50z13FnpS7n
         X0iJfOUOCpmU5UFtNPqypKcAEWgLbubrMRcNKaiCePjTYog8dkAUcJnkQpRd1haH86WN
         FjTcvXnBIluXtbDgjPztSmbeNIAtOeavdXMYyhg33jBZ87kXfa7iBSpulcPq23wFaFR7
         9/gQ==
X-Gm-Message-State: AOUpUlFKX0pXMmoU/1ywPwux0dNH85kXapiVzIBh/oQg/VNDDpkbJbKU
        8XDM9HOVcsUmbN1Ows0KnHHzO2vJ
X-Google-Smtp-Source: AA+uWPzcZ2qqCzqW2bXvcovAZcD22+fzaBjQXZ4BAhEP9us0oWrWZ6KKGoejZG4MAs/+fPKKnW/WSg==
X-Received: by 2002:a2e:944:: with SMTP id 65-v6mr12375626ljj.30.1534176930259;
        Mon, 13 Aug 2018 09:15:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/24] unpack-trees: don't shadow global var the_index
Date:   Mon, 13 Aug 2018 18:14:27 +0200
Message-Id: <20180813161441.16824-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
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
index c07a6cd646..f50b463f65 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1238,7 +1238,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
 static void mark_new_skip_worktree(struct exclude_list *el,
-				   struct index_state *the_index,
+				   struct index_state *istate,
 				   int select_flag, int skip_wt_flag)
 {
 	int i;
@@ -1247,8 +1247,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 1. Pretend the narrowest worktree: only unmerged entries
 	 * are checked out
 	 */
-	for (i = 0; i < the_index->cache_nr; i++) {
-		struct cache_entry *ce = the_index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
@@ -1263,8 +1263,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(the_index->cache, the_index->cache_nr,
-		       select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate->cache, istate->cache_nr, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
-- 
2.18.0.1004.g6639190530

