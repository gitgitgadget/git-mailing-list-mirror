Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB18207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755571AbdEETxv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:53:51 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34868 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbdEETxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:48 -0400
Received: by mail-pg0-f46.google.com with SMTP id o3so7631654pgn.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6UAaQctsFW4kX8DyuRjqecSvTh1felL0YhreeOYzFo=;
        b=N/pGEUvafUP5aUB/LWtDSVlxYcL6j4FgOPBObmgzugqU217dMEbKCgmm7ikTUh45HS
         Iix/gkdvlVNtUoVdHqTyPu+hWhlBhMmr2LEwtCXA/6CT8PkB3nbQyKOQfXb658bjk3RM
         2ortrkUYIVlVyZOFBlxAvcj0+hoL0Wk1LZUdG4y6pEhpcbyWjR+6Qhy/ssaeYxVONtca
         OzQ+cqlVKtfBXiKppwwE0tSiL7PBMT5rJvEjLRLzP/5zN4U9eIZS3ELudhJqyCIdK10f
         ZjULYfxEZw0rFBwQfR6b3wmrd6MJbpJF9QQxvAlA80Tt0AEEzqAGDom8BQuKLi2+Ea+b
         dgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6UAaQctsFW4kX8DyuRjqecSvTh1felL0YhreeOYzFo=;
        b=ZE+iqBhe/iE3e0h0zcGy3/8BpGrxXEYCRk5//NPK7icL46Xfh7s1GI5GDe8nzdluK9
         /B2w6c9own6ku28LubOSIODIyMuVWDalOA/AOoYEDWLyoKQ06L5Gkf+pHMZP8rX2sRXu
         XqosCIIzUay2/ZegNbXwahsuZt/VnW/sRyqfbQLJazsdYKTY90AjQmVDrt9SD9cLhj10
         a91SvM7QChV/mpNYmrBB3grSb3jVIoEWIWchBdJWze4rW0cnfZmeRyPDR6kcHM6CzqrT
         CY6N2ZxZeSSEYT1gfL9udbwXvVyunG66mbEw7iaVnh8p2uHFFCqGi/5+HEFkrgmKv7ub
         2x+A==
X-Gm-Message-State: AN3rC/67L++d+AA1FiaROBUVv5O4pd3hfOZnxNLQFW3BaCMLpCVJDj79
        lNG7OMUhra5aYWNz
X-Received: by 10.98.87.78 with SMTP id l75mr19142895pfb.92.1494014027899;
        Fri, 05 May 2017 12:53:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 02/14] dir: convert read_skip_worktree_file_from_index to take an index
Date:   Fri,  5 May 2017 12:53:22 -0700
Message-Id: <20170505195334.121856-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 97eadd45e..44307b963 100644
--- a/dir.c
+++ b/dir.c
@@ -588,7 +588,8 @@ void add_exclude(const char *string, const char *base,
 	x->el = el;
 }
 
-static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
+static void *read_skip_worktree_file_from_index(const struct index_state *istate,
+						const char *path, size_t *size,
 						struct sha1_stat *sha1_stat)
 {
 	int pos, len;
@@ -597,12 +598,12 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	void *data;
 
 	len = strlen(path);
-	pos = index_name_pos(&the_index, path, len);
+	pos = index_name_pos(istate, path, len);
 	if (pos < 0)
 		return NULL;
-	if (!ce_skip_worktree(the_index.cache[pos]))
+	if (!ce_skip_worktree(istate->cache[pos]))
 		return NULL;
-	data = read_sha1_file(the_index.cache[pos]->oid.hash, &type, &sz);
+	data = read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -610,7 +611,7 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	*size = xsize_t(sz);
 	if (sha1_stat) {
 		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, the_index.cache[pos]->oid.hash);
+		hashcpy(sha1_stat->sha1, istate->cache[pos]->oid.hash);
 	}
 	return data;
 }
@@ -751,7 +752,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
-		    (buf = read_skip_worktree_file_from_index(fname, &size, sha1_stat)) == NULL)
+		    (buf = read_skip_worktree_file_from_index(&the_index, fname, &size, sha1_stat)) == NULL)
 			return -1;
 		if (size == 0) {
 			free(buf);
-- 
2.13.0.rc1.294.g07d810a77f-goog

