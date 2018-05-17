Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F2E1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEQWwU (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33100 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeEQWwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:16 -0400
Received: by mail-pf0-f174.google.com with SMTP id a20-v6so2785663pfo.0
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cczt6NAlfIpFqlBDQpRIpp02JoWef8NwcganwS8FyPE=;
        b=QYkUr2E29jPIHMV95H22Y1S4CLXYuCZpDokEil1CU2S3tfUePNHlt3epUSO9deuexi
         ukUZPuXv8jGb8dMzesVLpWjSyx1DOU4j1HAelEsqRNjvaiwd9yB4+3/By8akVzdP97Oy
         b+VU6GrpnM2A+ju8pLCxKyvxPnla9OICXh8R86fhYboEDytrl1wS7MMHtwy6Khr9kKgi
         TOeHei07kpXTcGkOCa6W14RH4HVTZE/NLBoemtjcwkZ7ejilfAz0aaXoKNbhMrOmTJP8
         ojlhFRai7cnFBdJog+ON3Df9eMnPjdTrngyH1PTH8sgHCllvij906yrToZICdJXpYW3x
         AtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cczt6NAlfIpFqlBDQpRIpp02JoWef8NwcganwS8FyPE=;
        b=bMZuNVzLjBH6IYGkTb7aXecQNGNOFm2kkMY19wQOjiWrHNJNDY5KD9RV9hCiZK5MvD
         WJAPgPKtW3NzOWOBobCuBcmPLQMwIMM66hGT+9dQJ+30xV/Prbj3qpjGvZyPb85m01Md
         oZLRgMGAk6AngPrgNFFlu55tCVOkNqSsx06WflmdzIyFS23SaUeHbCHOn4aVEcgW0kzy
         58HkrEr8NNJWeO6Wjaxecaf5+uWcnHLstOY5CgePpOt+sLT5NCFgznJNII/oj8+9YfK7
         yisDtwMhfiz+jG4MqyqIYeSkZjIXLP95q5CuJOF0QvkWQdU8s/L089WRWAarl79dVprK
         ELUw==
X-Gm-Message-State: ALKqPwfNVaE8RzQFJHyaztRQ5JgSDMNK6WWvI022omHieVJeynCK3leG
        jgnBwnyKJITQmSIbTjsx7Rxvyg==
X-Google-Smtp-Source: AB8JxZr6fJKIYDOdOqC/b56LTHd7EnKitVGrp1jT2TZh1PVdOm39c1d08zz9NwJ0csYJ2iiEVRrKpA==
X-Received: by 2002:a63:7b1d:: with SMTP id w29-v6mr5447493pgc.417.1526597535228;
        Thu, 17 May 2018 15:52:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j1-v6sm12341347pfc.159.2018.05.17.15.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/19] commit: add repository argument to register_commit_graft
Date:   Thu, 17 May 2018 15:51:39 -0700
Message-Id: <20180517225154.9200-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

