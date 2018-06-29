Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5721F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030445AbeF2BXr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:47 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:33700 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030419AbeF2BXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:44 -0400
Received: by mail-vk0-f73.google.com with SMTP id s185-v6so2812940vke.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SYtwqyG6SRbe59RMxgxJXP+r2J2RtBgYnHd/vrpEyqI=;
        b=RErJVZrsOtZGmXQd+FzSfjqK9n/e8g0yNPWnlTJ9aJkzjDfPzC77ibo8j0cFa3v6cM
         4AluXTX/lzgOzGZoveIPEN4hEe9bx6wNSQepcSEwjACPq9vLB8+ZALbRVJDfsV8EFljb
         wMtq3l7heFn16W08W2M354yhKeS/kxashyto+Gwr0V6hi8JrtmDtSSrGzFqJuGMmh/8H
         IvVppPPMG6UI2pHWUD0h3NPVECgCjOnLlfpC4nmCXrztlM28F1RBgbg444FZUx5Ymkvu
         JQdkibUxqoNzbhYZj9GYBiEIKZMcILQgcjQ91F/BEjDjxA7WcRrjnqnJGFpGP9HxGoWw
         JZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SYtwqyG6SRbe59RMxgxJXP+r2J2RtBgYnHd/vrpEyqI=;
        b=q9kiQQh/AgPclC9Cl9ngtjbKsBylUWfgdBlpemSwizBhoQ4GcT1N7AKr+Qm8txKmgf
         AfD1lZ1etzlmDc+hJdxLRlhGVGyEl6aPcbvv1UhYOvG1wkU1gpPLOOo/U6pJfq5DPubg
         4RM/Q/lKomJihaDgX97eUFl03siOt0pipANnA0/WPKxCF/gkIhmLzl/9pOJxjyGMIa3x
         usX4VwXd4JU51e2TyNB1QijGo0EUMDgQd6XNmZ77hmhS4+ZDGnYFp8VrmwKg5ENVqDgo
         nq1jGrsW4eIk7LH1icrxgz7XpRJEABKl11+XWadLc6aidm1+Rc5Zu84xQbszmiLJfEmC
         UjWw==
X-Gm-Message-State: APt69E1doZTz4OG8mOdt9q9wgJrWyIjPOreYFnI7ulBrShLVkEsbA71B
        KhrAZyfp1ZR4+K7evqwtzgp5XMzvfYsqBa4Ubw8RRr0cd9zA5WTz/0k77oSe8/LYo6Dkq099rkP
        OIvLlkzfoCp7PfvQOnlEvtyw+/+g7uHCNvZmMLAset9mbZNVWjfilFYsBqila
X-Google-Smtp-Source: AAOMgpdjJEO25z7Q8Wub3peuzR3YeQhM+GHhVIMzvNsA2iys78JX/FvUANYOsBP81XTMA+DtKK0PcNoswDIa
MIME-Version: 1.0
X-Received: by 2002:ab0:47e3:: with SMTP id w35-v6mr2900845uac.102.1530235424285;
 Thu, 28 Jun 2018 18:23:44 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:21 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-32-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 31/32] commit.c: allow lookup_commit_reference_gently to
 handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 8 ++++----
 commit.h | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 15b044331a1..08b4602f43f 100644
--- a/commit.c
+++ b/commit.c
@@ -24,16 +24,16 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-struct commit *lookup_commit_reference_gently_the_repository(
+struct commit *lookup_commit_reference_gently(struct repository *r,
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(the_repository,
-				       parse_object(the_repository, oid),
+	struct object *obj = deref_tag(r,
+				       parse_object(r, oid),
 				       NULL, 0);
 
 	if (!obj)
 		return NULL;
-	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
+	return object_as_type(r, obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
diff --git a/commit.h b/commit.h
index d61585df5bc..f1f25957de4 100644
--- a/commit.h
+++ b/commit.h
@@ -67,9 +67,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-#define lookup_commit_reference_gently(r, o, q) \
-		lookup_commit_reference_gently_##r(o, q)
-struct commit *lookup_commit_reference_gently_the_repository(
+struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
-- 
2.18.0.399.gad0ab374a1-goog

