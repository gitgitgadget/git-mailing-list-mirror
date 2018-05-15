Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B24E1F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEOXne (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:34 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:38862 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeEOXmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:43 -0400
Received: by mail-pf0-f180.google.com with SMTP id o76-v6so821210pfi.5
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TL/Bg0d0QSw324KPdSCQnshcwKhBNzGZgaC2lHWiEns=;
        b=vjeYycGa5JdMLXbWmKYIdYe8k/blgQPrxbdsr1fU/mezqFe1CkS4Ol9xZkNT9Jbzek
         1TykSgFFoax20MxjSNPHFZAG8DansgopRL/H1KgnJogmkkBOTaf0tLZi7AtIOS1sKK/h
         2UcNlj3Ge60RtTiNm1ZQmqLb8ignlDbduVT5QMMTcSCPEP2yFpRCNBr1E7WPI0y26G1P
         bAWL8XDLIhXcDvykST5fDLhlRQNOPrLdSYyFuG3jPDc/J1RD82WhpP0cNoRpUhT0FsEM
         VTfKyT0B3xmBEurMQVnuNbdxnz3UagLfJNfIzH/5VRRr4zQEjXqk1qDsqV82N2WTcJhK
         j8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TL/Bg0d0QSw324KPdSCQnshcwKhBNzGZgaC2lHWiEns=;
        b=fWkAuGECFcThxXVKtBZguKJUTcBREfxCjIXChZb5BWWB1TEzAeDvlEFfUSsYtckUFo
         fPS+HrYfAFVJQPeWQJ5z9IQcNe0v/lLGkseG12AploI9RVu3gMyCDX/pbjgRsT/vXUWR
         9S+URfFoL8l6G30dHh5q6OxtBQbM2jD0R+Mhcy5IS+1dLcqkO/TVnCw2DOlCYBGhz7AA
         HTja3a4HD8W9x5tyuC1UTJpfQ0A1G4w7jshQidkrmFrBTNVAk/cUk/ye7NQTF9mhvl6k
         9/XdGzvqjdx/PMSn1gY8FkMIoVll83SXLsGuok/HCDZ5mJ/0afi1lB67FaMGG/hdg3w4
         PB2A==
X-Gm-Message-State: ALKqPwcMHC2JEWd9OHMVX2Kyt9iPQewzCVRJVoMU4WA60T2Kj3ceTIUL
        n9Z0isNcIBwB8bi/dbPWeu2uktGv/kU=
X-Google-Smtp-Source: AB8JxZqoIgU7I9KXclC7yVsehdUJeWrO3STA2cwGGEoWqQoYawvoE50P7CSXcrbzviKxAGjfbeXlvA==
X-Received: by 2002:a63:3c08:: with SMTP id j8-v6mr14314692pga.203.1526427761988;
        Tue, 15 May 2018 16:42:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1021525pgc.80.2018.05.15.16.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/19] commit: add repository argument to register_commit_graft
Date:   Tue, 15 May 2018 16:42:18 -0700
Message-Id: <20180515234233.143708-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of register_commit_graft to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/blame.c | 3 ++-
 commit.c        | 4 ++--
 commit.h        | 3 ++-
 shallow.c       | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0ffd1d443ea..7a07bff2423 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "repository.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
@@ -491,7 +492,7 @@ static int read_ancestry(const char *graft_file)
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (graft)
-			register_commit_graft(graft, 0);
+			register_commit_graft(the_repository, graft, 0);
 	}
 	fclose(fp);
 	strbuf_release(&buf);
diff --git a/commit.c b/commit.c
index 2cd5b8a0b96..4e8d3488425 100644
--- a/commit.c
+++ b/commit.c
@@ -112,7 +112,7 @@ static int commit_graft_pos_the_repository(const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
-int register_commit_graft(struct commit_graft *graft, int ignore_dups)
+int register_commit_graft_the_repository(struct commit_graft *graft, int ignore_dups)
 {
 	int pos = commit_graft_pos(the_repository, graft->oid.hash);
 
@@ -188,7 +188,7 @@ static int read_graft_file(const char *graft_file)
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
-		if (register_commit_graft(graft, 1))
+		if (register_commit_graft(the_repository, graft, 1))
 			error("duplicate graft data: %s", buf.buf);
 	}
 	fclose(fp);
diff --git a/commit.h b/commit.h
index 2d764ab7d8e..40a5b5e2585 100644
--- a/commit.h
+++ b/commit.h
@@ -174,7 +174,8 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
-int register_commit_graft(struct commit_graft *, int);
+#define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
+int register_commit_graft_the_repository(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
diff --git a/shallow.c b/shallow.c
index c2f81a5a5a8..ef802deed41 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "object-store.h"
@@ -38,7 +39,7 @@ int register_shallow(const struct object_id *oid)
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
 		commit->parents = NULL;
-	return register_commit_graft(graft, 0);
+	return register_commit_graft(the_repository, graft, 0);
 }
 
 int is_repository_shallow(void)
-- 
2.17.0.582.gccdcbd54c44.dirty

