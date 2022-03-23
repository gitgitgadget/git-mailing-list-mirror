Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA98C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiCWDt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241690AbiCWDtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D326250
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b19so303619wrh.11
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22FC1NRZgAaxQ6ttq3aBYbpJdnl1kjJOZSZHVV+X/Bg=;
        b=NGjvsNmlUat4im8kkw26niEUgVDdMeYg+xSbPW0x19uzaf19OCEpisG1PoPqZSWlvA
         mAdKpRTCFGG1hbr1zF+hDuylZBIgOo0dS54rZThnpSs4qL2S4RM+bopWmXw7yduqumV5
         HmeNEKHH9ce80MCk/fxCBKKJCZPU6tLsAsET3US9pQM5QAiwlywllncer0nx9FAfgX2C
         K4EgW5hsb4WKHoO6Ckt9D8xpw7ykQ6casGQFb8gaBmdFzhmpHMXtzMraJyu/n4QbNYfR
         cNOk5mAUFaWURLcAYV1jdmCocyRa2Hunol8XaxOtWJBvaU3wtoUdcYkKxGTVaLCB9xix
         GVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22FC1NRZgAaxQ6ttq3aBYbpJdnl1kjJOZSZHVV+X/Bg=;
        b=mxP3ZdEbGALOu/qE2iagRxmSPa/ut8DvaBjaU/0qB9YiAno0qiFwPBdYdgeYWGe2KY
         rcVuFDrUZ7uuEWegusrZiOeKpLAOvV3PMAC6FmANnHYrvk9iWYOrCVsawLqsEuWGqJnt
         S0/zvwVzBgW+kY8zNOLAUaXQr4s92p1XcBNWgJqzgQjyr/HfLVtaKzNFAZQFu63WCc3i
         UAe+9O23Cm2Dc7heVoIxSQGTq9gWGLKJZF64okkW1zRJWSGWAt0dzAHvVR81M7WsRDuZ
         l/N43Ev8iJRMZ9Hcy+EzZ6sUPR+8OL6TqGZ5OU+9/daxE9tEBrPQTDVdC8lFptyl4upr
         Occw==
X-Gm-Message-State: AOAM531OxVbF/rRdGgzlGBqUHqaG8sOG795n+S0U5VOnaH9hy1DuVPUa
        yuAfIthtsDm8V/mXM929qrac0waLB16oag==
X-Google-Smtp-Source: ABdhPJwlqNj68/a+oidPBXKC8UWiVKHgNCUXsHLkoLFuEKKwxkv63bWgI29n+gAOiHOpMFnaWMlyqA==
X-Received: by 2002:a05:6000:15c3:b0:204:1185:7033 with SMTP id y3-20020a05600015c300b0020411857033mr10786445wry.625.1648007284371;
        Tue, 22 Mar 2022 20:48:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:48:03 -0700 (PDT)
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
Subject: [RFC PATCH 5/7] update-index: pass down an "oflags" argument
Date:   Wed, 23 Mar 2022 04:47:34 +0100
Message-Id: <RFC-patch-5.7-a1474968991-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com> <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do nothing with this yet, but will soon.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 37 +++++++++++++++++++++----------------
 object-file.c          |  2 +-
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 80b96ec5721..1884124224c 100644
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
@@ -973,7 +977,8 @@ static enum parse_opt_result reupdate_callback(
 
 static void line_from_stdin(struct strbuf *buf, struct strbuf *unquoted,
 			    const char *prefix, int prefix_length,
-			    const int nul_term_line, const int set_executable_bit)
+			    const int nul_term_line, const int set_executable_bit,
+			    const unsigned oflags)
 {
 	char *p;
 
@@ -984,7 +989,7 @@ static void line_from_stdin(struct strbuf *buf, struct strbuf *unquoted,
 		strbuf_swap(buf, unquoted);
 	}
 	p = prefix_path(prefix, prefix_length, buf->buf);
-	update_one(p);
+	update_one(p, oflags);
 	if (set_executable_bit)
 		chmod_path(set_executable_bit, p);
 	free(p);
@@ -1157,7 +1162,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
-			update_one(p);
+			update_one(p, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
 			free(p);
@@ -1195,7 +1200,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 		while (getline_fn(&buf, stdin) != EOF)
 			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
-					nul_term_line, set_executable_bit);
+					nul_term_line, set_executable_bit, 0);
 		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
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

