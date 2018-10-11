Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069C71F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJLErg (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:36 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45325 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:35 -0400
Received: by mail-vk1-f202.google.com with SMTP id l5-v6so3898219vkd.12
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0FW3TH6n5gGc2SzHQ9YWmVLQYSXqLZZRv4D2QCbVZjM=;
        b=qoS9tBeHvSRR4s7EfsUp0Ntq8gMHq5hEYDusPIHf26mlURPpplb9tYn8IqidUoKt+n
         RD6rh3JfHm+nhH9jtmrzxX+iiQYwiArlXITQ/+kij7XjLh61eGMlUpI24Xr8giDBkVyV
         u6p2Ni8X3Yh76I7A/pQiXQu+Jj1jkje+xD2lRS2+5GeR7jXzLnkyC4mSLbGX90sq5vLs
         r2EH4NhBwKNGZiUzJA11vua/y4nHcLDgWFnyiygJLgBXOo7IbQMpYFqxGaOW7+QeXCaQ
         Y3yl3hc74YLhtA9RPkr5tP2AP7JZYsYAhdLNEnnnRfklOF728yXeecy2czcOgLaqsaJC
         lmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0FW3TH6n5gGc2SzHQ9YWmVLQYSXqLZZRv4D2QCbVZjM=;
        b=iezYnt3uso6AQiTky0e4i//urQPklDc4/i7zBzlba/Taunf/YGjB3AE7Sa0ruT7lUB
         qqUiWNz0Mr3RWYyKO6Ou7j5c6Xd4ubxE1QDdL42NoVgorV6/8OP2BF+jIXyVw5HG5zwi
         BSxGrpHRPxQKl2LWkyJSq95o7CUHkqQbAjCdjkdVCXYwe8mMclgauTW2Gjw9fKLowZ90
         zQFv08joGvaZTjd0iKRuJiYsrRRz4vXD7cSuFdIv5WRDHYHXdxuNEY6JR4IWzCBhK6eE
         nsrngVk8yfMk9lwy3CLrZMtQaN8YJRkAgZPejCCqUQoG4jSqeZFnTm0giI3y0KgvJ2M6
         KzUQ==
X-Gm-Message-State: ABuFfog7MQvlJfqs2Zb54S7GMukPINPdPpvPhUroBgSLbayk4FcC9SIC
        USJPIURyUypnzu2ViDEYs0ABAWnGSQ16lBIQzm5jhRN4oeAFdqL5D8nuXzDjDUI00OA40HHzVRf
        X0TIQ6uetfOFDrC/vzkVEMuM7l+mEGYH8lUgtzQr6HR5LyUG08D1MXZiwpNke
X-Google-Smtp-Source: ACcGV635KDO093nGgLYAAXA60/KBpReW0+bT6p9+/FnA7JOXUhqJE5crr0qokLzhGbEciC9OlmcIzSqUGOaA
X-Received: by 2002:a67:3d41:: with SMTP id k62mr3277020vsa.2.1539292710291;
 Thu, 11 Oct 2018 14:18:30 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:49 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-15-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 14/19] commit: prepare repo_unuse_commit_buffer to handle
 arbitrary repositories
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
 commit.c                                | 6 ++++--
 commit.h                                | 7 ++++++-
 contrib/coccinelle/the_repository.cocci | 8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index eca9a475c7..526b33758d 100644
--- a/commit.c
+++ b/commit.c
@@ -318,10 +318,12 @@ const void *repo_get_commit_buffer(struct repository *r,
 	return ret;
 }
 
-void unuse_commit_buffer(const struct commit *commit, const void *buffer)
+void repo_unuse_commit_buffer(struct repository *r,
+			      const struct commit *commit,
+			      const void *buffer)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
 		free((void *)buffer);
 }
diff --git a/commit.h b/commit.h
index fead381651..0976bf2562 100644
--- a/commit.h
+++ b/commit.h
@@ -130,7 +130,12 @@ const void *repo_get_commit_buffer(struct repository *r,
  * from an earlier call to get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
  */
-void unuse_commit_buffer(const struct commit *, const void *buffer);
+void repo_unuse_commit_buffer(struct repository *r,
+			      const struct commit *,
+			      const void *buffer);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define unuse_commit_buffer(c, b) repo_unuse_commit_buffer(the_repository, c, b)
+#endif
 
 /*
  * Free any cached object buffer associated with the commit.
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index ec579682f6..8c07185195 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -69,6 +69,14 @@ expression F;
 + repo_get_commit_buffer(the_repository,
   E, F);
 
+@@
+expression E;
+expression F;
+@@
+- unuse_commit_buffer(
++ repo_unuse_commit_buffer(the_repository,
+  E, F);
+
 @@
 expression E;
 expression F;
-- 
2.19.0

