Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01F91F406
	for <e@80x24.org>; Tue, 15 May 2018 23:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeEOXm5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:57 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:40180 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeEOXm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:56 -0400
Received: by mail-pf0-f174.google.com with SMTP id f189-v6so818182pfa.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kng7SkoLbcjDsoOnFQ+jZZbQqIoaQSTjrbhHPLFFXwo=;
        b=kNaVCYmpgkmilMkh8D5sv0pKKigsx47MmuglfA31BfXKWk+S3iJqn8QN6XfVLLwRCI
         jWGhjQaRa5G3N0IEaNDkmoDFfVmp0/mj6+cAWqD4ScA7ETFr1aGc23+1mXwZkNieWA5W
         HEQfUhsegnaP78Re+GZbBL7z379CrxqiWtPCZlydfkIJn166rcwnlNjLz40bOsXZUXRM
         7F6kvUgLhbHqlD6ukcnZTNzz8J1Lac2ig/OY4c6Pjxpqp5LQg0U+CB1/3x5/b7YYJ5Po
         mHh9ZJbbkyFdjHo6zUE2EzfCtURINgRm1Hlad7zqrVHQZGn68l0GIDVTdnDPOQ8Bs6XG
         tLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kng7SkoLbcjDsoOnFQ+jZZbQqIoaQSTjrbhHPLFFXwo=;
        b=VqSZlJ7m6epQjzUxJDOpo3aMv63khbtd498B0zFAN3X6HN4Jf7IiKsaJ4Nw4ZDaIFN
         4EmL71t6zUrgMDtNuAGzdBd9Nh9/85vsXq/S2pMCz1QfaviXJfuD8XA2k2/EUvMJWYTB
         TxsZSJS88300W4g0IHkLUIEAtOlUBzuYWJYuOSdV3YGymfJjzWxdUKFp7jXQquF+Ktje
         KoMkFFir5Q4xgMiX+82k/XMPO0b8zHj41NPbt2z/Kku2oyKIurykD7V/cApEShPxTKeI
         4yjXgWcmuUUtddwBscmfb5PXSYX0eqgTQ0of7/43EFrTeoIPDQRcWGoS386dxiuJ0O+G
         YurA==
X-Gm-Message-State: ALKqPwcIBPDDjmBI6sY5BFH7XZcBaxSrs+6lYnrurYIugN6++YxBmmUL
        V30sqUBMElR/71WsgylYleBmJsAOx2Y=
X-Google-Smtp-Source: AB8JxZrVT22DnNV5ydhQaNCPntY3+8/IB8t4FKW3cxtpbHRrJ9PwmeBvOII+qw6M/oXpp7FtP5mXrQ==
X-Received: by 2002:a65:484c:: with SMTP id i12-v6mr13378897pgs.162.1526427775115;
        Tue, 15 May 2018 16:42:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w8-v6sm1450786pfk.112.2018.05.15.16.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/19] commit: convert register_commit_graft to handle arbitrary repositories
Date:   Tue, 15 May 2018 16:42:27 -0700
Message-Id: <20180515234233.143708-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 29 +++++++++++++++--------------
 commit.h |  3 +--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 0ec3d22813a..8a2ab53fc67 100644
--- a/commit.c
+++ b/commit.c
@@ -111,30 +111,31 @@ static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
-int register_commit_graft_the_repository(struct commit_graft *graft, int ignore_dups)
+int register_commit_graft(struct repository *r, struct commit_graft *graft,
+			  int ignore_dups)
 {
-	int pos = commit_graft_pos(the_repository, graft->oid.hash);
+	int pos = commit_graft_pos(r, graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
 			free(graft);
 		else {
-			free(the_repository->parsed_objects->grafts[pos]);
-			the_repository->parsed_objects->grafts[pos] = graft;
+			free(r->parsed_objects->grafts[pos]);
+			r->parsed_objects->grafts[pos] = graft;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(the_repository->parsed_objects->grafts,
-		   the_repository->parsed_objects->grafts_nr + 1,
-		   the_repository->parsed_objects->grafts_alloc);
-	the_repository->parsed_objects->grafts_nr++;
-	if (pos < the_repository->parsed_objects->grafts_nr)
-		memmove(the_repository->parsed_objects->grafts + pos + 1,
-			the_repository->parsed_objects->grafts + pos,
-			(the_repository->parsed_objects->grafts_nr - pos - 1) *
-			sizeof(*the_repository->parsed_objects->grafts));
-	the_repository->parsed_objects->grafts[pos] = graft;
+	ALLOC_GROW(r->parsed_objects->grafts,
+		   r->parsed_objects->grafts_nr + 1,
+		   r->parsed_objects->grafts_alloc);
+	r->parsed_objects->grafts_nr++;
+	if (pos < r->parsed_objects->grafts_nr)
+		memmove(r->parsed_objects->grafts + pos + 1,
+			r->parsed_objects->grafts + pos,
+			(r->parsed_objects->grafts_nr - pos - 1) *
+			sizeof(*r->parsed_objects->grafts));
+	r->parsed_objects->grafts[pos] = graft;
 	return 0;
 }
 
diff --git a/commit.h b/commit.h
index c7f25d6490a..d04bbed81cf 100644
--- a/commit.h
+++ b/commit.h
@@ -174,8 +174,7 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
-#define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
-int register_commit_graft_the_repository(struct commit_graft *, int);
+int register_commit_graft(struct repository *r, struct commit_graft *, int);
 #define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
 struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
 
-- 
2.17.0.582.gccdcbd54c44.dirty

