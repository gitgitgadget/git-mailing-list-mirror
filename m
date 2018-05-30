Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903151F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968442AbeE3AtB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38477 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968521AbeE3Asi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:38 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so4502620pgf.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8sZTEoin/apt+/e8rudaJYRfMOdX59dblikId3uYX9Y=;
        b=d/73l5mOqqsOtFBpliKyXQPXsS/lWXAb/AcXzIj41Yf4Kb2dKQVhckJ2bKggDeOcSo
         /c8Ca4nqvpaCkIwQ+J3pBDsyyFpPxQPWXWxK5XBTlGmZMEHMWNP9HNYGhpzM3QaHKueg
         rd4TnEbxN/0jOSn0EANg3pqU5kA8EreAQonzVNOKOL49iGhvZ7sc1WiXTaEy3O8DL65Q
         VgFwuiOTPtW+rdlQiJys/FsS95D2kshUud0EjZi31ZM5nAxLYULXVNMhjbYWaRwAETOM
         DWYZQv9005mV/y3NlGebkQ5U3TXJaGsdzHvV39opieAywPbPLkXEsgnkrC8Q2uG3/1PA
         euCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8sZTEoin/apt+/e8rudaJYRfMOdX59dblikId3uYX9Y=;
        b=lys13RgZdz1WQfvc6HGjiU6wHtUoSnIdrsBfRRninaPUYd2p1c1l/9vlwnbSfmjhE6
         NteBd4DpniRG+HPIuLK7B7N5C+/gAQPhwedH2XKd907LF4HSHqhtf0Nq0TFCjKfDijTV
         w8unUgE1gLx7ypNocQhcl11jwI9hw6RlJpUXdROlyHyMy0LbnzB7ZgTTEAthSjUC50NC
         cwXX4HWFW4Y0Zv4Ycm8pXnAf/DQYtYuNw6+XWKJJ4HEdWvuS6+1YVfaUOW5dNDeKnJuy
         J9SJVcddElkCKt3qSVfAKF6SUm55RQQu6preBEdN5zNIA17PZ0wVdgHJYY1tR1qzXGLJ
         fhvQ==
X-Gm-Message-State: ALKqPwdumz0BRJJWjbOtXKLAIbyMrBfVDmWasFqUxl8lWxitCkO+d4dc
        tzAMCzvBcJn2c3T85Cg10RtK8IsebCM=
X-Google-Smtp-Source: ADUXVKKNcXqmQFvAQsE6lzBwAcvV8fxjEPYsDmImLccr2UWMp74QscKNcUwZxVs/sn4R4hOP/t6HVw==
X-Received: by 2002:a65:5c09:: with SMTP id u9-v6mr485975pgr.304.1527641317188;
        Tue, 29 May 2018 17:48:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d22-v6sm26760307pfk.126.2018.05.29.17.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/35] commit: add repository argument to parse_commit_buffer
Date:   Tue, 29 May 2018 17:47:46 -0700
Message-Id: <20180530004810.30076-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_commit_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c    | 4 ++--
 commit.h    | 3 ++-
 object.c    | 2 +-
 sha1-file.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 5e3f18801a1..dda585025ed 100644
--- a/commit.c
+++ b/commit.c
@@ -334,7 +334,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -416,7 +416,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_commit_buffer(item, buffer, size);
+	ret = parse_commit_buffer(the_repository, item, buffer, size);
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
 		return 0;
diff --git a/commit.h b/commit.h
index 431a7d97a24..05b9eccaf66 100644
--- a/commit.h
+++ b/commit.h
@@ -72,7 +72,8 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
+#define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/object.c b/object.c
index f4207d09e9f..5b756b5184d 100644
--- a/object.c
+++ b/object.c
@@ -214,7 +214,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size))
+			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
diff --git a/sha1-file.c b/sha1-file.c
index f66059ed7dd..00b1b2b8660 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1780,7 +1780,7 @@ static void check_commit(const void *buf, size_t size)
 {
 	struct commit c;
 	memset(&c, 0, sizeof(c));
-	if (parse_commit_buffer(&c, buf, size))
+	if (parse_commit_buffer(the_repository, &c, buf, size))
 		die("corrupt commit");
 }
 
-- 
2.17.0.582.gccdcbd54c44.dirty

