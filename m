Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D551F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968592AbeE3Ate (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:34 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:46068 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968573AbeE3AtL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:11 -0400
Received: by mail-pf0-f169.google.com with SMTP id c10-v6so8093438pfi.12
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZ6z3qLL9TuvfekwniKsTr6yrPZAtnc9WE02nPDTCA0=;
        b=pq1etZcJfNvzLiznN6ZJ341ALGbWUfmouvh2cgUUPQEXNRaDOdbfa6mWs7SgVckn8r
         RuDS3+ExZQVyDffaMisum6pLgIyStZa8FB79HzpfN7+H02fUcyMXXSdw6uduTIOJDch4
         n8k1Wb8OV4lgYpGTPIOMcIRFFPuxZsgYZcQeMZ53PjA3IbXDa2AIO5m+nNiY5V73lriH
         xe59kn8qYT68YqZsZ7qPEWKAoL7WqP1rkthSHbOqDdXUEVNSapj6/dsLOPd3qALe7uFI
         I6M2d2S0+ytNMjhrfXkYv21P6ZIA5UUO9HksScpL2EoBvJbKG41+0gJWynrt+91MXvQX
         Z+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZ6z3qLL9TuvfekwniKsTr6yrPZAtnc9WE02nPDTCA0=;
        b=BQkj8TUt3FnSQjFsi+NBdBVm44G+5d4h6m3g12s/ciyZ8oQwdDiuZ2EJFekzkHzGVd
         zuJ0z0T84oycNS2h6gzVOhfNePGSmqKgr4wFA5ibUtQDd/J1nOqE/S8/NF72aE9bPzN2
         34kg40uWNZIUwx73uNv0n3KjbdO8nw0w4S4aYLqYywSFMifIQUC2C3mzLNpfPQ/6hrTi
         8z9l9yhx4nVWmaheHVoQlOguF4EXL+lnPeBQPlpJi7257quztmAsKZf9dFJZ/AbcWA8g
         tA4/lliFKmIg2FKJsOoXVQ/v2oNT0vbom7izYewbSQ2HDQCbB9HTwyJUHB+eSJsisi3I
         6zDg==
X-Gm-Message-State: ALKqPweahBJ7vUOLrf+s7PgIKIqbYwg58TNtql17tKWZUm/7+4jlMnKX
        VPEMQ5kYg2FO4OFvQ8tHV86W4LQ6tF4=
X-Google-Smtp-Source: ADUXVKIrSzKa016uBNonNXSelOZ8c44ZFCOZPfYFJw/I3TGl6cU5JBzMXqhHsY+zqx/didKxVirVZw==
X-Received: by 2002:a63:3201:: with SMTP id y1-v6mr366251pgy.419.1527641350099;
        Tue, 29 May 2018 17:49:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q82-v6sm18068828pfg.170.2018.05.29.17.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 34/35] commit.c: allow lookup_commit_reference_gently to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:09 -0700
Message-Id: <20180530004810.30076-35-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index 383997817f0..f1bea3d1612 100644
--- a/commit.c
+++ b/commit.c
@@ -23,16 +23,16 @@ int save_commit_buffer = 1;
 
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
index 90ab9c403fe..1fc55900fb5 100644
--- a/commit.h
+++ b/commit.h
@@ -57,9 +57,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
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
2.17.0.582.gccdcbd54c44.dirty

