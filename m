Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6EF1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEPWVs (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:48 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34493 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeEPWVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:42 -0400
Received: by mail-pg0-f41.google.com with SMTP id k2-v6so906221pgc.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SaWcDNYzVWbxobb4XidkdsfAVtoo5nhhSmJbjPHap1I=;
        b=tp7KwK20sdULGuHIXuLDTkZePMHz+iUfyNPhncwKTg4JmcvxHATZPzQ+TJItV87kLU
         W4F1FA8znvSB/6oItVMAUZzWnY8QOs9+5N/WedM7s4EotHsdpV6jE8sWi76EZMQ/mMDs
         4gVKqcmNeKRvtqBz+GQN5EuEOUoHmj3POYEvCpCg1MAIAtJKIgZ3uKBOP229tugSaPfs
         qI00KTdOwx4CqbobeyIBqRSbaU59aSeBQQ4ATh9JmtOekBHlbUSQ41HvvAswylD06ChZ
         eZyh9bQefiqQGkBOmhVY3WvSjOfcJs/4I6Pk5myZOH95UjEWdh9JOKYIsYuDtBZbyiUy
         ioyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SaWcDNYzVWbxobb4XidkdsfAVtoo5nhhSmJbjPHap1I=;
        b=B1/+zCLGW2uPT60duVp0l8D9MLLaSOjFwczQiVO/WUmMJNW4khhfw+15pksAHyBp5e
         SxrU8isomWJ/YMJH0/vcrKWDu4tSySTVtk4RzfMmGlIPnijpWnDHO0EW8y+0YAuO9XCa
         vmz/nIJVX/2TXgiQocbd0bN0uxpclFQrbyiwjqr7e+0RA2f2pBXucxQv9cJNoWWCNq33
         wmSg9CFxnzk1j4iYtjQuiQRkG79MDoAC80h+ZjA19g7Rs6g+aMNyX+G+PJA2ePnS8TaG
         irkbr/Om0IBciBmWg5E6GatAgNiQlHmjsFJCUozlGI9QNganLitwjh71cYt2CWxJLUdb
         z+1g==
X-Gm-Message-State: ALKqPwe2HtmhNNdeZwZe3L2yTaK5a0cH+xozlrxbvCE+YmJEPY69O8Fr
        JamvLOdCfq4gS/NvkBs7jNFupQ==
X-Google-Smtp-Source: AB8JxZqWiMY9sy9yqeRO2YtE2GajoP7KWLLP761gPwnKrByac0U+XJ5dm/WBm8iL9VDi3kg7Bwlw3Q==
X-Received: by 2002:a62:8dc9:: with SMTP id p70-v6mr2749025pfk.72.1526509301267;
        Wed, 16 May 2018 15:21:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x25-v6sm5072506pfn.11.2018.05.16.15.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 07/11] rerere: use repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:14 -0700
Message-Id: <20180516222118.233868-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By switching to repo_read_index_or_die, we'll get a slightly different
error message ("index file corrupt") as well as localization of it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 rerere.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index 18cae2d11c9..5f35dd66f90 100644
--- a/rerere.c
+++ b/rerere.c
@@ -10,6 +10,7 @@
 #include "attr.h"
 #include "pathspec.h"
 #include "sha1-lookup.h"
+#include "repository.h"
 
 #define RESOLVED 0
 #define PUNTED 1
@@ -567,8 +568,7 @@ static int check_one_conflict(int i, int *type)
 static int find_conflict(struct string_list *conflict)
 {
 	int i;
-	if (read_cache() < 0)
-		return error("Could not read index");
+	repo_read_index_or_die(the_repository);
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -600,8 +600,7 @@ int rerere_remaining(struct string_list *merge_rr)
 	int i;
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
-	if (read_cache() < 0)
-		return error("Could not read index");
+	repo_read_index_or_die(the_repository);
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -1103,8 +1102,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	if (read_cache() < 0)
-		return error("Could not read index");
+	repo_read_index_or_die(the_repository);
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
-- 
2.17.0.582.gccdcbd54c44.dirty

