Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB8C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A3208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LHhCv8SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgD2Wjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wjt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:39:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF3C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so1427854plt.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNWk2mKWb0iPa5yOQ/fYd8YsI2T86DD1ZAaKO3D/Rlc=;
        b=LHhCv8SOkwffjeEU70vwY0QhYZYi2i8jusFYGtiMTkjYWQsnzNPqtrR1q0WyiR8wmS
         H9Ofun4TJUrmNiva0id6YC+6qrhZ0TPLQE7nbd/K6LwkUnxvcmvWWczs2e7v++AFBuQm
         g6pnG5QaH9HbmWV3qzC2xmUd78NVDfSyLqgVAB2KrhhYVP6RXDEbvBL2OXige5NDFLXf
         hsJn8zj4sgIDEtwpBOpyljfC1xSuWR3S998vRVrWoDLxts8W3pHfn+meq3jC8N/Qwciy
         CgZqUcj84Wp0CXLH6XO3RzuY0wX5ctUKXLAgZt9Dk+Lpxqfw4QDiwpEys+gZTaXauqxC
         pN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNWk2mKWb0iPa5yOQ/fYd8YsI2T86DD1ZAaKO3D/Rlc=;
        b=IlnB3EOtoaL1bdSsuArImi80g7Q3TuSOQ51aARrF9xkP4U38avdR0rSOqJGoqDhtFH
         WKYQtKk01VIMdrzU44nYJpEINXxTJzXhcwaTO/MAmnx1OiEJUbGSEDn/fQ2frXH346IC
         U/gkuBSaiQUm3LSbA8VOZh1zNGGHuHa2wCduGhoF75lBpQufj5hM6QsCGlcj2Qm7l03O
         gY/D6LWIhAgFLENvWd3uy4Lk9pi3cvNFMHvIbXV2U4iOczcwBdoN65RDJKTJUxamEAzi
         6EBHPB2CVLo2anNP6xUAJiB1jLXsTUIFW/A8vufjdVNq1vQTsxPgombr7SFPHbIEW43I
         iY2w==
X-Gm-Message-State: AGi0PuZvEq5mQm6hr+c/Xg7dTe2+6CCSMQGJLqMzvcpNktNG9f16PAnp
        0OalWCgJwA0+aViCNsVWit6GQ0b9it0pAdZP
X-Google-Smtp-Source: APiQypL4oLEVbGptj1VkTbF3+9dcr7C4dUitjOGoOKkcuY6AHo1JUki6ePaslQGyDcQWJZkDknMAdA==
X-Received: by 2002:a17:90a:20a8:: with SMTP id f37mr824351pjg.148.1588199988117;
        Wed, 29 Apr 2020 15:39:48 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c2sm1863040pfp.118.2020.04.29.15.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:39:47 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:39:46 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional safety
Message-ID: <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
References: <cover.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588199705.git.me@ttaylorr.com>
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
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c |  2 +-
 fetch-pack.c           |  2 +-
 shallow.c              | 22 +++++++++++-----------
 shallow.h              | 16 +++++++++++++---
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 652661fa99..10fd2c52ec 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -855,7 +855,7 @@ static void refuse_unconfigured_deny_delete_current(void)
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
index 76e00893fe..1acf8ce95b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -92,16 +92,16 @@ static void reset_repository_shallow(struct repository *r)
 	stat_validity_clear(r->parsed_objects->shallow_stat);
 }
 
-int commit_shallow_file(struct repository *r, struct lock_file *lk)
+int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
 {
-	int res = commit_lock_file(lk);
+	int res = commit_lock_file(&lk->lk);
 	reset_repository_shallow(r);
 	return res;
 }
 
-void rollback_shallow_file(struct repository *r, struct lock_file *lk)
+void rollback_shallow_file(struct repository *r, struct shallow_lock *lk)
 {
-	rollback_lock_file(lk);
+	rollback_lock_file(&lk->lk);
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
+	fd = hold_lock_file_for_update(&shallow_lock->lk,
 				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-				  get_lock_file_path(shallow_lock));
-		*alternate_shallow_file = get_lock_file_path(shallow_lock);
+				  get_lock_file_path(&shallow_lock->lk));
+		*alternate_shallow_file = get_lock_file_path(&shallow_lock->lk);
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
+	fd = hold_lock_file_for_update(&shallow_lock.lk,
 				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-				  get_lock_file_path(&shallow_lock));
+				  get_lock_file_path(&shallow_lock.lk));
 		commit_shallow_file(the_repository, &shallow_lock);
 	} else {
 		unlink(git_path_shallow(the_repository));
diff --git a/shallow.h b/shallow.h
index 08e1bc4fd0..d12096fbc4 100644
--- a/shallow.h
+++ b/shallow.h
@@ -10,12 +10,22 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
+
+/*
+ * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
+ * which locks can be used with '{commit,rollback}_shallow_file()'.
+ */
+struct shallow_lock {
+	struct lock_file lk;
+};
+#define SHALLOW_LOCK_INIT { LOCK_INIT }
+
 /*
  * {commit,rollback}_shallow_file commits or performs a rollback to the
  * '.git/shallow' file, respectively, and resets stat-validity checks.
  */
-int commit_shallow_file(struct repository *r, struct lock_file *lk);
-void rollback_shallow_file(struct repository *r, struct lock_file *lk);
+int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
+void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
@@ -24,7 +34,7 @@ struct commit_list *get_shallow_commits_by_rev_list(
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 			  const struct oid_array *extra);
 
-void setup_alternate_shallow(struct lock_file *shallow_lock,
+void setup_alternate_shallow(struct shallow_lock *shallow_lock,
 			     const char **alternate_shallow_file,
 			     const struct oid_array *extra);
 
-- 
2.26.0.113.ge9739cdccc
