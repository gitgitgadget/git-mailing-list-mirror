Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45054C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiCWOU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiCWOUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295D7C174
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so2336706wrr.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiTfAcJdJXo8A5uaC2Wd1+NkjJOfiwE6jVqaPd2koL0=;
        b=aBKgYwv6sOUSV4AlP/QNX76uIUaYXRTCb5LfPb0VpHCZxtxj/K44m0iUII1iyVQDyq
         0oFwRNS4XMFQrYcEAP+BZnj+M6bHanXSXO8TQpm1/1WLpNfzk3I/TQkkvpOJlt6NVXtd
         9lDQQXb0UCsnjFcAvTX+OidTWZSig4SFH/9yZ+yMKcddRMmagqrx0CNQ8vK9ZcagzxrK
         b39olKrJkbga9/yaCHkwtGFqhXHeinQJ3ovWpqy09vy8ks3ei8hV1yzJtw8Th4ygzGXU
         aVviP19xe1P+p1GIV4xfE0AeacoCnVbyKYO83CLd1MXtTomxkzAG4lj7C9zE2s93Y6xb
         p7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiTfAcJdJXo8A5uaC2Wd1+NkjJOfiwE6jVqaPd2koL0=;
        b=7nYPN9fcNQLMgyRA7hzwLm5RETMns2jcloyZsOVzEiLvkWyMV1HOKCkfcFNoOjOb0s
         moTqF+wrFgnjW7piADMaQtSGKQHm10DcOv8K6ZDhDMvFdr/bDPQLy87iE+5AqEjqD09m
         /iHuNJ93JLEUEigCmI33uQOUPUsHlDoslLNpBCO3RXl17PazzSIwZR3zbCzYfNPrSgqt
         vCnZbAfBwAvBYHRpStOl1hIYsNm7Zf+L8rGaoAYoLm+YlXQfqMx7qiEWt/PSOk7OaE7U
         ocajMH3hbpsCDQayJHkVyoI84mCTb5+gzgivNf8cD9i+e2GTX6Habnvk76LbqKuuTu3y
         Hjmw==
X-Gm-Message-State: AOAM532KJNCgUFdwBIhsPULuN0XouGMeRiQu/IiRwSWlvNJPQRipZgbs
        O9AsBiQlp0jN5/W9UMhfYARapDRAymg7oQ==
X-Google-Smtp-Source: ABdhPJyRxaRUv68L1HcRUvKIOYtOYwqIACuk912ybc0x+3zeYc/pXtE6l4gSNbKT3R3LLC6a4yr/tQ==
X-Received: by 2002:adf:fac8:0:b0:203:fb08:ff7 with SMTP id a8-20020adffac8000000b00203fb080ff7mr24158wrs.648.1648045126577;
        Wed, 23 Mar 2022 07:18:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 3/7] update-index: pass down skeleton "oflags" argument
Date:   Wed, 23 Mar 2022 15:18:27 +0100
Message-Id: <RFC-patch-v2-3.7-4df8012100a-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with a preceding change to "unpack-objects" add an "oflags" going
from cmd_update_index() all the way down to the code in
object-file.c. Note also how index_mem() will now call
write_object_file_flags().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 32 ++++++++++++++++++--------------
 object-file.c          |  2 +-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 95ed3c47b2e..34aaaa16c20 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -267,10 +267,12 @@ static int process_lstat_error(const char *path, int err)
 	return error("lstat(\"%s\"): %s", path, strerror(err));
 }
 
-static int add_one_path(const struct cache_entry *old, const char *path, int len, struct stat *st)
+static int add_one_path(const struct cache_entry *old, const char *path,
+			int len, struct stat *st, const unsigned oflags)
 {
 	int option;
 	struct cache_entry *ce;
+	unsigned f;
 
 	/* Was the old index entry already up-to-date? */
 	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
@@ -283,8 +285,8 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	fill_stat_cache_info(&the_index, ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(&the_index, &ce->oid, path, st,
-		       info_only ? 0 : HASH_WRITE_OBJECT)) {
+	f = oflags | (info_only ? 0 : HASH_WRITE_OBJECT);
+	if (index_path(&the_index, &ce->oid, path, st, f)) {
 		discard_cache_entry(ce);
 		return -1;
 	}
@@ -320,7 +322,8 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
  *  - it doesn't exist at all in the index, but it is a valid
  *    git directory, and it should be *added* as a gitlink.
  */
-static int process_directory(const char *path, int len, struct stat *st)
+static int process_directory(const char *path, int len, struct stat *st,
+			     const unsigned oflags)
 {
 	struct object_id oid;
 	int pos = cache_name_pos(path, len);
@@ -334,7 +337,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 			if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
 				return 0;
 
-			return add_one_path(ce, path, len, st);
+			return add_one_path(ce, path, len, st, oflags);
 		}
 		/* Should this be an unconditional error? */
 		return remove_one_path(path);
@@ -358,13 +361,14 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* No match - should we add it as a gitlink? */
 	if (!resolve_gitlink_ref(path, "HEAD", &oid))
-		return add_one_path(NULL, path, len, st);
+		return add_one_path(NULL, path, len, st, oflags);
 
 	/* Error out. */
 	return error("%s: is a directory - add files inside instead", path);
 }
 
-static int process_path(const char *path, struct stat *st, int stat_errno)
+static int process_path(const char *path, struct stat *st, int stat_errno,
+			const unsigned oflags)
 {
 	int pos, len;
 	const struct cache_entry *ce;
@@ -395,9 +399,9 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		return process_lstat_error(path, stat_errno);
 
 	if (S_ISDIR(st->st_mode))
-		return process_directory(path, len, st);
+		return process_directory(path, len, st, oflags);
 
-	return add_one_path(ce, path, len, st);
+	return add_one_path(ce, path, len, st, oflags);
 }
 
 static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
@@ -446,7 +450,7 @@ static void chmod_path(char flip, const char *path)
 	die("git update-index: cannot chmod %cx '%s'", flip, path);
 }
 
-static void update_one(const char *path)
+static void update_one(const char *path, const unsigned oflags)
 {
 	int stat_errno = 0;
 	struct stat st;
@@ -485,7 +489,7 @@ static void update_one(const char *path)
 		report("remove '%s'", path);
 		return;
 	}
-	if (process_path(path, &st, stat_errno))
+	if (process_path(path, &st, stat_errno, oflags))
 		die("Unable to process path %s", path);
 	report("add '%s'", path);
 }
@@ -776,7 +780,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		save_nr = active_nr;
 		path = xstrdup(ce->name);
-		update_one(path);
+		update_one(path, 0);
 		free(path);
 		discard_cache_entry(old);
 		if (save_nr != active_nr)
@@ -1138,7 +1142,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
-			update_one(p);
+			update_one(p, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
 			free(p);
@@ -1183,7 +1187,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p);
+			update_one(p, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
 			free(p);
diff --git a/object-file.c b/object-file.c
index dbeb3df502d..8999fce2b15 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2211,7 +2211,7 @@ static int index_mem(struct index_state *istate,
 	}
 
 	if (write_object)
-		ret = write_object_file(buf, size, type, oid);
+		ret = write_object_file_flags(buf, size, type, oid, flags);
 	else
 		hash_object_file(the_hash_algo, buf, size, type, oid);
 	if (re_allocated)
-- 
2.35.1.1428.g1c1a0152d61

