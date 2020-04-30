Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB2C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BA2207DD
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JTF0vsdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD3TtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3TtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:49:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E130C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:49:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so366089pfc.12
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B2Qp8AOA/6mpv8ufXqFA1xB/3MkCoJgEm5WIHnMHgH8=;
        b=JTF0vsdVGlXodDV2twUbvs/iQd1EEbzAV72I/JpQwTBtwQqGKCOjLQS5Y11yEI4r/0
         9+UvXpDN6nNZgusdnVN+kCsKSZZUVx5vf9Ryg5W/kHqLAv94S9+obzwQDf4YwQbMY7x5
         izBreTQqQt/HKnKXqoas2f5WFC6/fL0ZmWu/w8wEeyPrK0sPgSm/yyFVvFa8ahfwuDQ0
         UKS/41r+b9/ZJElRKSlXIEvjXcOSg+FXwtrpYscFdwgS0OtQFBsLOG52HMdHIx2J2nOi
         Qmf6Nc2uTA2YXBuTY+SFuZllRnmUOIQEYSD7lAUHiiEX1/0XWepujn3Diao3NJrJ50x4
         19YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2Qp8AOA/6mpv8ufXqFA1xB/3MkCoJgEm5WIHnMHgH8=;
        b=P4cH+8jlcVI82Xu4JvfjgGIABQZpmu7EbjjzSnqB/Caiq2ZRA4/B1tGec09nARrG2L
         6mRUXv6rZ8B54HwjFeyCtUxePWqWozZnULt5A1gwahvox4/ZTyswhoOehOH/50fzdHff
         3QRmLoYbYx7z/ZWJOsitJ1XagCRj8mKC5uIESyNrOJv4Gbgi75pROnB5YvBZfOrOeIcP
         TEUQMUkEXKL+PXN3gxg0i5HcUPWX75r8Gel6FtQQXokthI/JUPUCTd9R2rfGItiAbFrj
         N6fbPkc5Fdo0R+mmk495th9Ve/8fRubQutbD+IEWtLE5zZMLYbdb9cAF02aIam7S09it
         tKsg==
X-Gm-Message-State: AGi0PubU1Y5rp36g2/hroxmo7JaJ13uwFZJ0FHUnJpZcgpx1PM12hJw5
        X9iEoiT1eezbqjTFU3tDSKVd7O+d4OFEGg==
X-Google-Smtp-Source: APiQypLfoyWLRsFw4yGSk3jk63Z8LVokKuHh04RWYtw81NPV4XHc1rJNqpZg1iRtkAzcIR08wqhuMw==
X-Received: by 2002:aa7:8bd3:: with SMTP id s19mr384440pfd.143.1588276139261;
        Thu, 30 Apr 2020 12:48:59 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x19sm491298pfq.137.2020.04.30.12.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:48:58 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:48:57 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 4/4] shallow: use struct 'shallow_lock' for additional
 safety
Message-ID: <08d8a915a0d1a19f8ad119f43141ba2b8f52df2c.1588275891.git.me@ttaylorr.com>
References: <cover.1588275891.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588275891.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous patches, the functions 'commit_shallow_file' and
'rollback_shallow_file' were introduced to reset the shallowness
validity checks on a repository after potentially modifying
'.git/shallow'.

These functions can be made safer by wrapping the 'struct lockfile *' in
a new type, 'shallow_lock', so that they cannot be called with a raw
lock (and potentially misused by other code that happens to possess a
lockfile, but has nothing to do with shallowness).

This patch introduces that type as a thin wrapper around 'struct
lockfile', and updates the two aforementioned functions and their
callers to use it.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c |  2 +-
 fetch-pack.c           |  2 +-
 shallow.c              | 22 +++++++++++-----------
 shallow.h              | 21 ++++++++++++++++++---
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8e3f9bc35f..73cebc2f55 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -856,7 +856,7 @@ static void refuse_unconfigured_deny_delete_current(void)
 static int command_singleton_iterator(void *cb_data, struct object_id *oid);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
-	struct lock_file shallow_lock = LOCK_INIT;
+	struct shallow_lock shallow_lock = SHALLOW_LOCK_INIT;
 	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
diff --git a/fetch-pack.c b/fetch-pack.c
index 401d028e41..27d2d08cc0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,7 +35,7 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
-static struct lock_file shallow_lock;
+static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 
diff --git a/shallow.c b/shallow.c
index 76e00893fe..7e0a41ea68 100644
--- a/shallow.c
+++ b/shallow.c
@@ -92,16 +92,16 @@ static void reset_repository_shallow(struct repository *r)
 	stat_validity_clear(r->parsed_objects->shallow_stat);
 }
 
-int commit_shallow_file(struct repository *r, struct lock_file *lk)
+int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
 {
-	int res = commit_lock_file(lk);
+	int res = commit_lock_file(&lk->lock);
 	reset_repository_shallow(r);
 	return res;
 }
 
-void rollback_shallow_file(struct repository *r, struct lock_file *lk)
+void rollback_shallow_file(struct repository *r, struct shallow_lock *lk)
 {
-	rollback_lock_file(lk);
+	rollback_lock_file(&lk->lock);
 	reset_repository_shallow(r);
 }
 
@@ -366,22 +366,22 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 	return "";
 }
 
-void setup_alternate_shallow(struct lock_file *shallow_lock,
+void setup_alternate_shallow(struct shallow_lock *shallow_lock,
 			     const char **alternate_shallow_file,
 			     const struct oid_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(shallow_lock,
+	fd = hold_lock_file_for_update(&shallow_lock->lock,
 				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-				  get_lock_file_path(shallow_lock));
-		*alternate_shallow_file = get_lock_file_path(shallow_lock);
+				  get_lock_file_path(&shallow_lock->lock));
+		*alternate_shallow_file = get_lock_file_path(&shallow_lock->lock);
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -414,7 +414,7 @@ void advertise_shallow_grafts(int fd)
  */
 void prune_shallow(unsigned options)
 {
-	struct lock_file shallow_lock = LOCK_INIT;
+	struct shallow_lock shallow_lock = SHALLOW_LOCK_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = SEEN_ONLY;
 	int fd;
@@ -428,14 +428,14 @@ void prune_shallow(unsigned options)
 		strbuf_release(&sb);
 		return;
 	}
-	fd = hold_lock_file_for_update(&shallow_lock,
+	fd = hold_lock_file_for_update(&shallow_lock.lock,
 				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-				  get_lock_file_path(&shallow_lock));
+				  get_lock_file_path(&shallow_lock.lock));
 		commit_shallow_file(the_repository, &shallow_lock);
 	} else {
 		unlink(git_path_shallow(the_repository));
diff --git a/shallow.h b/shallow.h
index b3bf200bf9..5b4a96dcd6 100644
--- a/shallow.h
+++ b/shallow.h
@@ -10,10 +10,25 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
+
+/*
+ * Lock for updating the $GIT_DIR/shallow file.
+ *
+ * Use `commit_shallow_file()` to commit an update, or
+ * `rollback_shallow_file()` to roll it back. In either case, any
+ * in-memory cached information about which commits are shallow will be
+ * appropriately invalidated so that future operations reflect the new
+ * state.
+ */
+struct shallow_lock {
+	struct lock_file lock;
+};
+#define SHALLOW_LOCK_INIT { LOCK_INIT }
+
 /* commit $GIT_DIR/shallow and reset stat-validity checks */
-int commit_shallow_file(struct repository *r, struct lock_file *lk);
+int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
 /* rollback $GIT_DIR/shallow and reset stat-validity checks */
-void rollback_shallow_file(struct repository *r, struct lock_file *lk);
+void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
@@ -22,7 +37,7 @@ struct commit_list *get_shallow_commits_by_rev_list(
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 			  const struct oid_array *extra);
 
-void setup_alternate_shallow(struct lock_file *shallow_lock,
+void setup_alternate_shallow(struct shallow_lock *shallow_lock,
 			     const char **alternate_shallow_file,
 			     const struct oid_array *extra);
 
-- 
2.26.0.113.ge9739cdccc
