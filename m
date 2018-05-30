Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6201F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968612AbeE3AuT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:50:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34787 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968488AbeE3Asl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:41 -0400
Received: by mail-pg0-f65.google.com with SMTP id k2-v6so7325781pgc.1
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ORSKekmFf2A4nrOzYb0RFfuaI8IXunP3BUntKoYuVEo=;
        b=iAIgvP05tTlNcxeUP4o90d4MS5ayXSnJfLwlbkodMSawr3zDLa+vNzmCQUfus6ueeA
         e29shLfWs4BjMQZVvPu6qGXvM3ketaifOYGzSRM4Jj9z1NhFT+25LmNlFafzvuY+ndP+
         ZZL+a2IQsxLVOVxUqNR0dUADBqXkTbuQY9PKyjvZmQ9eLBdJGNPNPTccTMRVcqavak7I
         8HTwjL1MUjPUWpxnMvlDjyiSLvKGQUX0Z3uXCHs7etL4ZfETxhT10iaZKqVr8jxwXtNZ
         NleTGrtGLM82/w2g8tYHfu6IqjG10hEOyFRhdIDki+2G+ADKUrg3Qdm02FuGMvA8GraJ
         PWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ORSKekmFf2A4nrOzYb0RFfuaI8IXunP3BUntKoYuVEo=;
        b=QgUk62ColD4os4H8Eb6mSRjc+NSe/QvwIAUwzQ5Ny8MrJBIALG3y8KOUsl3W8A3Bhe
         wjoFGCv8MplFyAXqs4+m/iu4HA14MO+LWxqNz9RKF6MLZ4OvbQxdVAIX4Cqr2e5xZ+W0
         aFH3zvhQBHl1XRaLYAoqnBbYAVj96yZOlvJfpYfZ/HI3cEJA5W/WukHBOAQjYIA6kZFS
         XRZkzHAPi9JuzjhvB1DwEzQnCXNGmrY/fqRGVOD211eX7LV2fwaXNR2SStuy629tuw7m
         zGN43JtgEYK8T5q+O1LBQSfREWgBYq+t3/vJdTfEZcXsKGxkih3onA3v2HkCYPZNgMjz
         MSXQ==
X-Gm-Message-State: ALKqPwf6arlCtkzHFVM78G865Wa7exmarDQKILgMy5a2LnVCEctMy6F4
        w7Uf6aFnGoATIwxPsZ1qhz2FuakLjVA=
X-Google-Smtp-Source: ADUXVKLlxO4ovfKa5gwsgFXv2nZEpEhOI5eBz2HrF5AxedF3j0ptQyByFrZt4qdmI1EwItY2i7TdxQ==
X-Received: by 2002:a63:7905:: with SMTP id u5-v6mr449868pgc.411.1527641320171;
        Tue, 29 May 2018 17:48:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k64-v6sm49264973pgk.17.2018.05.29.17.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/35] commit: add repository argument to get_cached_commit_buffer
Date:   Tue, 29 May 2018 17:47:48 -0700
Message-Id: <20180530004810.30076-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of get_cached_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 3 ++-
 object.c | 2 +-
 pretty.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 667d4dc6cfd..ba06918ba41 100644
--- a/commit.c
+++ b/commit.c
@@ -256,7 +256,7 @@ void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsig
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (!v) {
@@ -271,7 +271,7 @@ const void *get_cached_commit_buffer(const struct commit *commit, unsigned long
 
 const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(commit, sizep);
+	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
diff --git a/commit.h b/commit.h
index a1ecd067ccc..66eb576897f 100644
--- a/commit.h
+++ b/commit.h
@@ -92,7 +92,8 @@ void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned lo
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(const struct commit *, unsigned long *size);
+#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
+const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
diff --git a/object.c b/object.c
index 71dbd49b675..e859662c63c 100644
--- a/object.c
+++ b/object.c
@@ -216,7 +216,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 		if (commit) {
 			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
-			if (!get_cached_commit_buffer(commit, NULL)) {
+			if (!get_cached_commit_buffer(the_repository, commit, NULL)) {
 				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
diff --git a/pretty.c b/pretty.c
index c99f8243faf..5b139775eac 100644
--- a/pretty.c
+++ b/pretty.c
@@ -630,7 +630,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(commit, NULL))
+		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
-- 
2.17.0.582.gccdcbd54c44.dirty

