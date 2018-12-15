Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C0120A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeLOAKU (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:20 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54799 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeLOAKU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:20 -0500
Received: by mail-qt1-f202.google.com with SMTP id z6so7272641qtj.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J+42hj3ZmivEwJlhvnMqR7aqGjOf6M4lReIfT0AEgEM=;
        b=rw82E47ePV81aIdadnfb/jDy0y6iRJ2pBLkUEDAjc1rNhP5waopx5kJNMk20wlFNSv
         TK7XvG/AgKe1a/pd1LOWhqtorRUKG48cqthReehv24VWFy8glDKBiI3+su9MPlWeEdz9
         2Dg5TwcRQP6BWUQJtzr+uHnOGJ3sQbF8dqSWGpB3cDHqGGE8Y/9E92GpvSzACDLoHmbz
         2TgMDASUUioHhMM5ZqcO25PK5aZe197lZen7N6X2jaNgyr3TEUsCBaH+noBxao3njqL4
         lKkvBTBvVF6IbGMEgdphbnS5nw/PWqPZsJOhOhSCK08y6ZylaAiN82ZsMCqkcsyLubnR
         Xgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J+42hj3ZmivEwJlhvnMqR7aqGjOf6M4lReIfT0AEgEM=;
        b=Vo7H25Xeo7Mld08pjDkh4CqlpdGP3CUnrNBqfVo2BUSQdWq2ReW30i8nAGvAug8mcK
         uN4aQYxf4zSeCY04tu0RGzEY3R/LP1AuyHBriFFl5vB/4iG2IciE7X5bv+7xJhiO/Q2f
         LjPTspyZ1OFhk+op9bw0P0L3v0qvvHW5qv/z3TZ/0roqT0+It6EwUX2u6bi+RrizXdOJ
         SEU0vJZvsFIeTuQVodOfn7Z10+2LTNRpG5gN4KOtoNBuqYFbIKZPLfQT9Rt70NqPrCjH
         AzXoQ1tuAZ40kIttunpetLtfbMwr09U8bLB9DcSFtckng1hohqgGMGMzkprafy7s7Y7H
         kMtg==
X-Gm-Message-State: AA+aEWZWwwmnp5e8CHbk6F/qlS+nZjRsus7oJgyWXqtKvdJKP+gJyu81
        MnWAFWMnXQjsI2pfR5PEEQtW79jsRzxbz3cPjfxrV+ywwupCxoP4MN4HkPYsy2QMGe7tVWonbfr
        PHC1K6lPf3Vm9JG1PzBLHFW3h3pLlcvU7CBLCkdBsyEGOXXULw+0/asDla0lJ
X-Google-Smtp-Source: AFSGD/Xh4PugkvWw9pwb5BZk5HZxM9L3MYqgbwmzXZS6KL0BMEYKhH4/sJ99Nt07PhNqLIfVcFw0ES+4usXE
X-Received: by 2002:a0c:b58d:: with SMTP id g13mr4868620qve.1.1544832619185;
 Fri, 14 Dec 2018 16:10:19 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:33 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-15-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 14/23] commit: prepare get_commit_buffer to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c                                        | 8 +++++---
 commit.h                                        | 7 ++++++-
 contrib/coccinelle/the_repository.pending.cocci | 8 ++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 7a931d7fd4..4034def16c 100644
--- a/commit.c
+++ b/commit.c
@@ -297,13 +297,15 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 	return v->buffer;
 }
 
-const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *repo_get_commit_buffer(struct repository *r,
+				   const struct commit *commit,
+				   unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
+	const void *ret = get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_object_file(&commit->object.oid, &type, &size);
+		ret = repo_read_object_file(r, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
diff --git a/commit.h b/commit.h
index 08935f9a19..591a77a5bb 100644
--- a/commit.h
+++ b/commit.h
@@ -117,7 +117,12 @@ const void *get_cached_commit_buffer(struct repository *, const struct commit *,
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-const void *get_commit_buffer(const struct commit *, unsigned long *size);
+const void *repo_get_commit_buffer(struct repository *r,
+				   const struct commit *,
+				   unsigned long *size);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define get_commit_buffer(c, s) repo_get_commit_buffer(the_repository, c, s)
+#endif
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 8c6a71bf64..4018e6eaf7 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -107,3 +107,11 @@ expression G;
 - in_merge_bases_many(
 + repo_in_merge_bases_many(the_repository,
   E, F, G);
+
+@@
+expression E;
+expression F;
+@@
+- get_commit_buffer(
++ repo_get_commit_buffer(the_repository,
+  E, F);
-- 
2.20.0.405.gbc1bbc6f85-goog

