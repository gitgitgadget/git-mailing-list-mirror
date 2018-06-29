Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BAD31F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936472AbeF2BXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:04 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:54847 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936465AbeF2BXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:01 -0400
Received: by mail-qt0-f201.google.com with SMTP id d7-v6so7591420qth.21
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=OVlrOX8b/PQO+YMJ5/osTUdwNJFxIKSpbYpzfRfsL2E=;
        b=Qj2nAHz1OWsKlK032qsZRKwaO9zrMV4kCVqp+O7fkT/L15IkzHjiLLVhYjK130EIfh
         Um7sGx/z9WV0/l7bZ25yYZoo5dkHoCfxnnvsHrZRCEfUzleDEG3VxEkCAPbH+Rkd/q6A
         FkZg/EVKU05l/qc/5GgabKl2GNuRRh/9arPqE8nzbIM01E2k1aAF+KH23oN3zXOosMju
         htJyjbq1TGpm0D2g0M5z1MpoUd1/pzDePRimJVEwVb5xKuvnVbxIMHRz+d0lcYR56aJl
         TOQZR2kpm5xU4yNtoDa1XvPHwWji+3AXzxCCN9T/i6g7W3stps7UlKA8tJrGOOUof7IV
         ufAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=OVlrOX8b/PQO+YMJ5/osTUdwNJFxIKSpbYpzfRfsL2E=;
        b=X2lCeYvIln4cQAX5Pie9+BbPP7JQzeRo0goeiT0yyvqnzLC+Oj/IKVdbD4OTwCaQIX
         lkK+8qBcmlIUz7FEGJ1oNPXuqfntu179e/j0YXTNiKlLTlkDRGQ27phaeNVqzWf68F/7
         4oc1ht5Mn4es5wuwj9HpVH5NqiE4QL0jZA2smelzLGd0Qg6B8ltEhHDX36RwbN+vL4hl
         wDv8zmb+5P+nUD1EAxuQLxXgaGF21YMAAaQEnBp1Vn49CNNWSkzYvMs0L8XfeVRe6Rsz
         IW2/xR/4C+TjGmxd0F598XXTLPWCtQb6qXMorRDwO23rMvPss40qdXkAePqVrBUDhlPG
         vQ2g==
X-Gm-Message-State: APt69E0C9atWxKdP0lTF8QMEOPI2C3sEZig2faopN5tIvxk2Dtdn40yx
        MtlcbJk/DJIwDyXyPRngpqpJ5h0aADzyCll88AYzpy5Oixnms1/qga6OZ2PQHtt971CO3CYlJJ0
        5XBDgLCHXe0tASrfi/VOBnQvNTJymfQQzKIRsNn7FZpZShUDpityIfQhvBGFK
X-Google-Smtp-Source: AAOMgpfzBrQQQLxSn/w8nz9od/27nChstlMTyA7dnhEEeezVl7+tK5iKdCHR3Y6S2/xTQkNKk88/CXyGtLK6
MIME-Version: 1.0
X-Received: by 2002:a0c:f9c1:: with SMTP id j1-v6mr183708qvo.25.1530235380483;
 Thu, 28 Jun 2018 18:23:00 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:02 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-13-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 12/32] commit: add repository argument to get_cached_commit_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index cdfb1a025b6..9e2899bd5ad 100644
--- a/commit.c
+++ b/commit.c
@@ -269,7 +269,7 @@ void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsig
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (!v) {
@@ -284,7 +284,7 @@ const void *get_cached_commit_buffer(const struct commit *commit, unsigned long
 
 const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(commit, sizep);
+	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
diff --git a/commit.h b/commit.h
index 7c14dfdc54b..237607d64cb 100644
--- a/commit.h
+++ b/commit.h
@@ -102,7 +102,8 @@ void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned lo
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(const struct commit *, unsigned long *size);
+#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
+const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
diff --git a/object.c b/object.c
index d1f77565af6..f08a8874de3 100644
--- a/object.c
+++ b/object.c
@@ -216,7 +216,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 		if (commit) {
 			if (parse_commit_buffer(the_repository, commit, buffer, size, 1))
 				return NULL;
-			if (!get_cached_commit_buffer(commit, NULL)) {
+			if (!get_cached_commit_buffer(the_repository, commit, NULL)) {
 				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
diff --git a/pretty.c b/pretty.c
index cbd25b6ceae..cde4fe07db0 100644
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
2.18.0.399.gad0ab374a1-goog

