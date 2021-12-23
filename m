Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CFAC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 19:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbhLWTaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350022AbhLWT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 14:29:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E4C061756
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t18so13310031wrg.11
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rKL71I6AtVC0hVyJTHfIbKsa2OryKpItHJicvAy6AyQ=;
        b=HxBMIur1cfurON+rO17EJUzr8D727JWg3Y5mUEVS8pJjaIq24iIpZX2gDqzSAJKFGE
         ZiEXXGt6DWpQjN6/z10yScF9bWHEBxsXXeBPY4NfeFA/p0TgMF8T+1RcrYjfuvbN7Tk2
         kW13qA4nBxkK93PnAinCMl9e/iiIN6fkWSoXUl6Euyg2jvEfEvlOUFR44s55VuTrF0A2
         xw6rplQtuR6DejNYq2T+yNydNPLmfJ8yry5gJj4hu60eN/i2q8AQKfjGV/T2jGs/RiKo
         pSZepXIgtOBfQx7ELrY9dvJg+6wU9l6sRcV9B9AL0CqoDssbizobdVv60pe/Oz3OE7BV
         pgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rKL71I6AtVC0hVyJTHfIbKsa2OryKpItHJicvAy6AyQ=;
        b=BzZQcBEWuUcHS9MZYCQ5Y8xeNCk71LLoOz6Q0TGSKwFnqk/5O9s1vBuxhJVvcA+krK
         eV7rhxhNe1n9n0NjiICemLy7eaHORzg0idtB0iazgBuCShekM1YoAZVNA7FNpuYmjDkr
         NkiwqqUFtAGiVBmGnAjaWT8CUjQADPus9MCPmivp9R1OyXyb+7Pt7EMu2uCv1HzB/cGk
         8zAAEbmCZgfqNM7QaqgJPEsTjTJBkmJ/MvgOY3K3Fo8+2QOmh5evPI3+dhp0eNAA67Id
         YJI/mjwZwEf7WrDS7DTV0K+lNulOIQyolgvh0WrDnTymftxXIn+pI/QswZ0p57dZmTew
         YIHA==
X-Gm-Message-State: AOAM533QInReyewOucBDLo5HMGGlV11O4/eyFWyJEqFFwPO08jwqcv08
        3tHlrFwAVT1JlGifhQferj2HHxaz6Ag=
X-Google-Smtp-Source: ABdhPJzrmiFDvp8iImxwI7bNmAxTsenlBH7lfi4+Rh/UQgvs6lmGiNLzJjrpSGR5ho15NIrbUmqi2A==
X-Received: by 2002:a05:6000:24b:: with SMTP id m11mr2751463wrz.32.1640287793531;
        Thu, 23 Dec 2021 11:29:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14sm6574900wry.23.2021.12.23.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:29:53 -0800 (PST)
Message-Id: <c01b1c335a33e5f44289c520a1634d071d882223.1640287790.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 19:29:50 +0000
Subject: [PATCH 3/3] reftable: support preset file mode for writing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Create files with mode 0666, so umask works as intended. Provides an override,
which is useful to support shared repos (test t1301-shared-repo.sh).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reftable-writer.h |  3 +++
 reftable/stack.c           | 30 ++++++++++++++++++++++++------
 reftable/stack_test.c      | 33 +++++++++++++++++++++++++++++----
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index af36462ced5..a560dc17255 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -35,6 +35,9 @@ struct reftable_write_options {
 	 */
 	uint32_t hash_id;
 
+	/* Default mode for creating files. If unset, use 0666 (+umask) */
+	unsigned int default_permissions;
+
 	/* boolean: do not check ref names for validity or dir/file conflicts.
 	 */
 	unsigned skip_name_check : 1;
diff --git a/reftable/stack.c b/reftable/stack.c
index df5021ebf08..56bf5f2d84a 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -469,7 +469,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	strbuf_addstr(&add->lock_file_name, ".lock");
 
 	add->lock_file_fd = open(add->lock_file_name.buf,
-				 O_EXCL | O_CREAT | O_WRONLY, 0644);
+				 O_EXCL | O_CREAT | O_WRONLY, 0666);
 	if (add->lock_file_fd < 0) {
 		if (errno == EEXIST) {
 			err = REFTABLE_LOCK_ERROR;
@@ -478,6 +478,13 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 		}
 		goto done;
 	}
+	if (st->config.default_permissions) {
+		if (chmod(add->lock_file_name.buf, st->config.default_permissions) < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
+
 	err = stack_uptodate(st);
 	if (err < 0)
 		goto done;
@@ -644,7 +651,12 @@ int reftable_addition_add(struct reftable_addition *add,
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
-
+	if (add->stack->config.default_permissions) {
+		if (chmod(temp_tab_file_name.buf, add->stack->config.default_permissions)) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
 	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
 				 &add->stack->config);
 	err = write_table(wr, arg);
@@ -900,7 +912,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	strbuf_addstr(&lock_file_name, ".lock");
 
 	lock_file_fd =
-		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
+		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0666);
 	if (lock_file_fd < 0) {
 		if (errno == EEXIST) {
 			err = 1;
@@ -931,8 +943,8 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		strbuf_addstr(&subtab_lock, ".lock");
 
 		sublock_file_fd = open(subtab_lock.buf,
-				       O_EXCL | O_CREAT | O_WRONLY, 0644);
-		if (sublock_file_fd > 0) {
+				       O_EXCL | O_CREAT | O_WRONLY, 0666);
+		if (sublock_file_fd >= 0) {
 			close(sublock_file_fd);
 		} else if (sublock_file_fd < 0) {
 			if (errno == EEXIST) {
@@ -967,7 +979,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 
 	lock_file_fd =
-		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
+		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0666);
 	if (lock_file_fd < 0) {
 		if (errno == EEXIST) {
 			err = 1;
@@ -977,6 +989,12 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	have_lock = 1;
+	if (st->config.default_permissions) {
+		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
 
 	format_name(&new_table_name, st->readers[first]->min_update_index,
 		    st->readers[last]->max_update_index);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index eb0b7228b0c..f4c743db80c 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -17,6 +17,7 @@ https://developers.google.com/open-source/licenses/bsd
 #include "record.h"
 #include "test_framework.h"
 #include "reftable-tests.h"
+#include "reader.h"
 
 #include <sys/types.h>
 #include <dirent.h>
@@ -138,8 +139,11 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 static void test_reftable_stack_add_one(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-
-	struct reftable_write_options cfg = { 0 };
+	struct strbuf scratch = STRBUF_INIT;
+	int mask = umask(002);
+	struct reftable_write_options cfg = {
+		.default_permissions = 0660,
+	};
 	struct reftable_stack *st = NULL;
 	int err;
 	struct reftable_ref_record ref = {
@@ -149,8 +153,7 @@ static void test_reftable_stack_add_one(void)
 		.value.symref = "master",
 	};
 	struct reftable_ref_record dest = { NULL };
-
-
+	struct stat stat_result = { 0 };
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 
@@ -160,6 +163,7 @@ static void test_reftable_stack_add_one(void)
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	EXPECT_ERR(err);
 	EXPECT(0 == strcmp("master", dest.value.symref));
+	EXPECT(st->readers_len > 0);
 
 	printf("testing print functionality:\n");
 	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
@@ -168,9 +172,30 @@ static void test_reftable_stack_add_one(void)
 	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
 	EXPECT(err == REFTABLE_FORMAT_ERROR);
 
+#ifndef GIT_WINDOWS_NATIVE
+	strbuf_addstr(&scratch, dir);
+	strbuf_addstr(&scratch, "/tables.list");
+	err = stat(scratch.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) == cfg.default_permissions);
+
+	strbuf_reset(&scratch);
+	strbuf_addstr(&scratch, dir);
+	strbuf_addstr(&scratch, "/");
+	/* do not try at home; not an external API for reftable. */
+	strbuf_addstr(&scratch, st->readers[0]->name);
+	err = stat(scratch.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) == cfg.default_permissions);
+#else
+	(void) stat_result;
+#endif
+
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
+	strbuf_release(&scratch);
 	clear_dir(dir);
+	umask(mask);
 }
 
 static void test_reftable_stack_uptodate(void)
-- 
gitgitgadget
