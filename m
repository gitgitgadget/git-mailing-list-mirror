Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346C51F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJQH3N (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:13 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:33878 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:13 -0400
Received: by mail-io1-f73.google.com with SMTP id y3-v6so23073218iob.1
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3gHZxvmy6BQ5j1K5mVW5xHRXGJDY/6tRKrsUKBLQlXw=;
        b=dPpFAJ5JW1XVyO97lZ/mfmoAS4/kI+2de9hRw1+uHW4y7r84d9oCxUuLyIMkvhmBt1
         C3C2V5VUXA/D1axjuaGxUMUNsxnNkqq3seWLMLdGVgFeHm7sproX22hVgFy4swsDFnuc
         KWgU08sNOCwHI11od8kVWoHdxaZlCbocrv9qv/UWF2Wyi5ssx42xSjaHkrt3cYWEDA9F
         FXelD5RT0kLHC9ASPinKZmZckuRlFIcvTgNy51QPx+VEHpZZ0iaGY87en7MbikTYyBXb
         IiEhO9wi6ErzlSMJG1qmAmL7jsCz9PVUCzppyKtZiCBokhGUdgniKZB7CPVC3qMIKMjE
         praA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3gHZxvmy6BQ5j1K5mVW5xHRXGJDY/6tRKrsUKBLQlXw=;
        b=LkW2qnkVAdeRT3YJm66hR/MJXl7Jri5s8opmpT0gh/jx2KfHk6wGChBnrVEAFbLdk9
         VvCSKqDH5cTA2FWg1FT+2oiTq1WugtAuhWbsjHxISl0M5bnjAGnXHzn3uJSn1ToxEzpx
         5BepK1xA0YbG/Cx4ym9GGrhui1IHDvQhjHjCvgsPCnaUogdi8ilIHjhQY/u+Bn+IXPzb
         D03JFzS53OCJRXmqo/x3FISSaQUhC8Ijw1Pi+uABoJuA05p/dR4G46JPAz5NbCZGwhYn
         uCYVq9iMcY8xePH1C6DT6sEqeUzt/P4UjACTU29jgs9WxQ7i5YS3MWDfnL9eYG1Cc1Nb
         RyAQ==
X-Gm-Message-State: ABuFfohuFC8tY3jrzHLAz7FB8qzRtya6j68sJtJgj4pyWa+TOJ5Rogtr
        ta4QrVECi5e9Jm4r55sD6VBOxk0sMHuAdELEauoHXUzDZ9DFvYgiBwIPvS93m0oEdlj/HI6RdK2
        I0WFIbdz5gMSd5wUM/WI6cP3RJHjo2uywuLJ2aBkdrPSK0SwgO+0cefO/suCI
X-Google-Smtp-Source: AJdET5dDAtKJoljfoD4+grGbMrsleJg1ckYW663Mxr8CExIeBYL4wwrmwyzHizzFkgxsebtYVnT/iWodNIAk
X-Received: by 2002:a05:660c:b0c:: with SMTP id f12mr179746itk.22.1539732988016;
 Tue, 16 Oct 2018 16:36:28 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:45 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-15-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 14/19] commit: prepare get_commit_buffer to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                                | 8 +++++---
 commit.h                                | 7 ++++++-
 contrib/coccinelle/the_repository.cocci | 8 ++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index fe942754e2..cc5321af8c 100644
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
index 58a0c5409b..b8437f66e2 100644
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
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 8c6a71bf64..4018e6eaf7 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
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
2.19.0

