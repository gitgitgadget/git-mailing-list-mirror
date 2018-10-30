Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300521F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeJaHEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:24 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:38605 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJaHEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:24 -0400
Received: by mail-oi1-f201.google.com with SMTP id b5-v6so10739263oic.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RrrSrj4uGteYbSs+MvRgYtPk39MXieBiTAQIPoLXx4s=;
        b=SAofBrEmhV/tJjhlmF72ZBwDSrxum+M+YrJxaQ4m2RVemx9hfEFRWf5uH4mxvMdXYd
         pndYR4Hzm2PIOqLM5MkaAnoXjUDHeEXnsJLpSwjbnzmKj5cTLZUi5wecpIhrJoA3ane4
         v1d/1wromsWlU/rw03cJrmSonZ0hMR6s5/0LZPewfUxbTj7Ofk8OSq5wpE46eJhKttRu
         kRr+EmveWaweZ1jl8pk+9357jAxThImtn5/8hRdkljwJ8AE4oR7+UYqQ5IOP55JQh6vE
         8eDzfGDn6zVzYijyP70dfOkCCDo0qnIFgqqWo3JuwkUYVXNVMuaQeOrWM1hdUCD+PieT
         bm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RrrSrj4uGteYbSs+MvRgYtPk39MXieBiTAQIPoLXx4s=;
        b=dweWKiO0MHMbngGoTIK0qJrkWhir40BzTZ4dprFbh+BhMIzO+uD9e+qy/JIY1/lMuo
         9zj7YHQedVj9gY0zdlL/EkTQJLJTv0m2d5VDaAm9pCb0cXhdDy06M2RezihEa2V2VnGi
         cjXTEeOr7P/a28tIxflyWwmLb0K93DLcNP0tjcPgqgU08xkXZIK2AnFlq8EzdBZ9fbcV
         9s9AmRvKcgJc3xc8eBeMHfyKn7AkAoOp/5+KovpndLyzykkwHhCnSUrR5o/QVYu8na6E
         YvmS/CAqEMx3hU24heeB22RsAbvg6lufvWn+jC6IsuvwyaiOuaCvfb8YTPBsebaFAALv
         MorA==
X-Gm-Message-State: AGRZ1gI8tRWovg/fMnxvgugaI9r7ZYONXjho2SgLT9dC47NOlacy1FEx
        g5wVVYNtQYFhnV50lTSov/Irx88kydABpr6PIX7a1BXgRr+mz9zRRsTWVhwDWTSaIjXs9vHFX6E
        B1HlVB1PxbnaDriScCFuImu4tQeOqtL8oM/BDwxLrolszxtWf+7woJrzwqI0a
X-Google-Smtp-Source: AJdET5fp6M5mOGlMzPWbX3tk3+3pqfv8D0AvzyK4Sp5TkVekotAYwD1RkjKk5PvuEXzwarZxhm8YVyv/gjsN
X-Received: by 2002:aca:dd55:: with SMTP id u82-v6mr390606oig.58.1540937348959;
 Tue, 30 Oct 2018 15:09:08 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:08 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-16-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 15/24] commit: prepare get_commit_buffer to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.19.1.930.g4563a0d9d0-goog

