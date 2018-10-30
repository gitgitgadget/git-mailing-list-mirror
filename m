Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BAE1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeJaHE2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:28 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47959 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJaHE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id m185so6430194vkf.14
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MhE5q6S1YU+4LARM6xli8HeegWRWqtTX3ZRv0PbjFH0=;
        b=Yv1Ch5P0smXXzqrtlaKDCGW2QFzxs36YsQbeG+gP+DETAwBJxKoOeA+nbE5AszRdSm
         qIXege7N9DaMxR60FL7GTm0IkVwK7AIPCb8y0Sr7kOEr7Eo4/jYweH8ic/A/DixQyvKP
         nD3Tp2mLZH+7SK+7wJiJfweSY2yxsPEB2eqE/uENts0vJJPt7G+vXAS1Q453m2nEtfPa
         OObM+C66dIlYkQdGb9ifuSTi7tehba6o6EvV84d7NvddPLEIeXFX8RdxR72YisQ4mnUX
         0/gZMiWmJaP+QIsveq/wma4qob9CiF11SAhrjtTvlCM6SRuK7FPPxbh8R+yVLqHXvP4e
         mvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhE5q6S1YU+4LARM6xli8HeegWRWqtTX3ZRv0PbjFH0=;
        b=jA2SRHDrgBx2Pqp0DeIDQTU+RPK1mYG6B2etMnq9G1460NTvJ2jwt6v1TnHj98YDYS
         cHEzZ80chYqR6m+oFI/L4TzPMQO22MD6hbY5UeeLGRuo3QJBIYvLoGhGF1/JwdAs+Khg
         RKAUqKbRk1uqdM/+MdB5cbO7yvqGUPosvmYL62U8a/YeC/ejQgDMG9jMlEY//JjWPl9y
         vVzu3AyAM2yzj9Cn5dRsHBMiR0J2gJH6pjd8Y0h5lp4LkFIyFdHLUWoh1nO3VtWaTy+t
         inzvowDoz1rHGQJ5f1hwEdQZ2Cwa3Sw361vStq7D5KHXAGpyH5aKg/dvr3nY++P6a9a+
         Koow==
X-Gm-Message-State: AGRZ1gLueuG3EXm2xta+F587pGwaUZ2NHnzhAZKFByzv4cq4kV5zQIh/
        B4SPKpD+lH5lust/QFm21liVChnlyM5FYKn4RqHGHDcQqVb0lTDGNxDA1qzGH/F+Uco3Odp4m5g
        BKPQiKhHMG65LZj3mhOXOFahIOlL/Ol2gV3IRvbCxX9guqTLxsHEW6DRLg59H
X-Google-Smtp-Source: AJdET5e9K9nzkeDRY43yTSc7+6N5cobe2YZUnQC7eDDeIs0OmEayyFaKTUcos+NYtXkLOsmyVcUjyy9vJQCY
X-Received: by 2002:a67:4a0c:: with SMTP id x12mr513901vsa.11.1540937351585;
 Tue, 30 Oct 2018 15:09:11 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:09 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-17-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 16/24] commit: prepare repo_unuse_commit_buffer to handle
 arbitrary repositories
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
 commit.c                                        | 6 ++++--
 commit.h                                        | 7 ++++++-
 contrib/coccinelle/the_repository.pending.cocci | 8 ++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 4034def16c..7d2f3a9a93 100644
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
index 591a77a5bb..57375e3239 100644
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
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 4018e6eaf7..516f19ffee 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -115,3 +115,11 @@ expression F;
 - get_commit_buffer(
 + repo_get_commit_buffer(the_repository,
   E, F);
+
+@@
+expression E;
+expression F;
+@@
+- unuse_commit_buffer(
++ repo_unuse_commit_buffer(the_repository,
+  E, F);
-- 
2.19.1.930.g4563a0d9d0-goog

