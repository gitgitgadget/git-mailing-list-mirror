Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9FECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 18:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIQSRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 14:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQSQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 14:16:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D33056F
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 11:16:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z6so8401774wrq.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=LTWRwCp7xMMkWTDrAveQ0ubS4zJ0oH8y/aUfh10EnCw=;
        b=BlaZHzIVsPjdaQD7c09NDjxGMF4+l5CoFWGjJh1hGgRbvBoCcwSo6JwusvFvtEo1re
         yqOGmnl/emU+vTUs+c2FJFDWSfoVM/t0db5/qboVk+66BLGRp4fPK7FtxVoB/FOj82QQ
         mlaJc1U+Xyg7iIZ6lhnZ74axYspWflWtaZh3uaredCrWDWyOY95m5pck3tC4RKSCBYi3
         qeVTO5phqRbU4mBuLyOdua9DzDJ55VQO40a0M9Xc3eYpXY5AtONTZ6QD0dLhtijIa0C0
         uFurr/YB+YcpXW/074S5wVIxU05Yce/yxNE3kbrNwlS36rAuzOKQbZ1WG+V/3WN1/SPR
         IiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LTWRwCp7xMMkWTDrAveQ0ubS4zJ0oH8y/aUfh10EnCw=;
        b=muPbjoOJpaHeUt6vw5JyQ8hUt+bd6x4OOxz9+pGIohlNJ8blI8pvX9cVKHc1qENZJY
         17R3VxhhukgMcdZI6d2oOo74u/oPKEXZh3hyjtT34QNmLG+oqOa6q3DqPTYKNdjFDWpv
         xI1HTSw2cgBPdHaqCo0Hm3yi/sE4dAk/md8Jsuca4OKNcnbWLJXiXEVjMR1UWSFSwhzI
         0zYNW6+zjvc0eCRRWR5rccnDBW6DZmBTN6lZx80OS10oAFTpEi8X/XUtKor/4AwYEgId
         FnYM4ddoabl1uciNKtmPado4MKQrjrEF9yuT2Y0Cg/U4Bz5PL9IxT6bZ5lgKjxaSBXA+
         iycQ==
X-Gm-Message-State: ACrzQf07eWqu5BwjO+GXvS/STCJbFnqS4oTw/6X5wF+JOHCmwhZFOIxM
        KH6yp0kRZDaVFcfpPUhlhpRwIfmQKG4=
X-Google-Smtp-Source: AMsMyM54Nsm5CkKV+yCFLO+iFHwy9ZqacncQBIXT7FnGHUJxIoopUt48aIoXsnDq+OUXZnFC6qqEIQ==
X-Received: by 2002:a05:6000:186d:b0:22a:f6ce:72d9 with SMTP id d13-20020a056000186d00b0022af6ce72d9mr653600wri.426.1663438616498;
        Sat, 17 Sep 2022 11:16:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b003b2878b9e0dsm7052916wmq.20.2022.09.17.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 11:16:56 -0700 (PDT)
Message-Id: <pull.1354.git.1663438615413.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 18:16:55 +0000
Subject: [PATCH] diagnose.c: refactor to safely use 'd_type'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Refactor usage of the 'd_type' property of 'struct dirent' in 'diagnose.c'
to instead utilize the compatibility macro 'DTYPE()'. On systems where
'd_type' is not present in 'struct dirent', this macro will always return
'DT_UNKNOWN'. In that case, instead fall back on using the 'stat.st_mode' to
determine whether the dirent points to a dir, file, or link.

Additionally, add a test to 't0092-diagnose.sh' to verify that files (e.g.,
loose objects) are counted properly.

Note that the new function 'get_dtype()' is based on 'resolve_dtype()' in
'dir.c' (which itself was refactored from a prior 'get_dtype()' in
ad6f2157f9 (dir: restructure in a way to avoid passing around a struct
dirent, 2020-01-16)), but differs in that it is meant for use on arbitrary
files, such as those inside the '.git' dir. Because of this, it does not
search the index for a matching entry to derive the 'd_type'.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    diagnose.c: refactor to safely use 'd_type'
    
    This fixes the compilation error reported by Randall in [1], which
    happens because 'd_type' doesn't exist in the 'dirent' struct on all
    platforms.
    
    The implementation of new-'get_dtype()' shares some code with
    'resolve_dtype()' (and its previous incarnations as old-'get_dtype()')
    but, to keep this fix down to a single patch, I didn't refactor the bits
    of shared logic into a common location. I'm happy to do that if it would
    be a valuable addition to this fix, but I wanted to start small and
    avoid the churn of a refactor if it isn't something people want here.
    
    Thanks!
    
     * Victoria
    
    [1]
    https://lore.kernel.org/git/011001d8ca20$bc4d81f0$34e885d0$@nexbridge.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1354%2Fvdye%2Fbugfix%2Ffix-dtype-usage-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1354/vdye/bugfix/fix-dtype-usage-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1354

 diagnose.c          | 70 ++++++++++++++++++++++++++++++++++++---------
 t/t0092-diagnose.sh | 12 ++++++++
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/diagnose.c b/diagnose.c
index beb0a8741ba..8f265698966 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -66,17 +66,53 @@ static int dir_file_stats(struct object_directory *object_dir, void *data)
 	return 0;
 }
 
-static int count_files(char *path)
+/*
+ * Get the d_type of a dirent. If the d_type is unknown, derive it from
+ * stat.st_mode.
+ *
+ * Note that 'path' is assumed to have a trailing slash. It is also modified
+ * in-place during the execution of the function, but is then reverted to its
+ * original value before returning.
+ */
+static unsigned char get_dtype(struct dirent *e, struct strbuf *path)
 {
-	DIR *dir = opendir(path);
+	struct stat st;
+	unsigned char dtype = DTYPE(e);
+	size_t base_path_len;
+
+	if (dtype != DT_UNKNOWN)
+		return dtype;
+
+	/* d_type unknown in dirent, try to fall back on lstat results */
+	base_path_len = path->len;
+	strbuf_addstr(path, e->d_name);
+	if (lstat(path->buf, &st))
+		goto cleanup;
+
+	/* determine d_type from st_mode */
+	if (S_ISREG(st.st_mode))
+		dtype = DT_REG;
+	else if (S_ISDIR(st.st_mode))
+		dtype = DT_DIR;
+	else if (S_ISLNK(st.st_mode))
+		dtype = DT_LNK;
+
+cleanup:
+	strbuf_setlen(path, base_path_len);
+	return dtype;
+}
+
+static int count_files(struct strbuf *path)
+{
+	DIR *dir = opendir(path->buf);
 	struct dirent *e;
 	int count = 0;
 
 	if (!dir)
 		return 0;
 
-	while ((e = readdir(dir)) != NULL)
-		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
+	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
+		if (get_dtype(e, path) == DT_REG)
 			count++;
 
 	closedir(dir);
@@ -104,13 +140,13 @@ static void loose_objs_stats(struct strbuf *buf, const char *path)
 	strbuf_addch(&count_path, '/');
 	base_path_len = count_path.len;
 
-	while ((e = readdir(dir)) != NULL)
-		if (!is_dot_or_dotdot(e->d_name) &&
-		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
+	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
+		if (get_dtype(e, &count_path) == DT_DIR &&
+		    strlen(e->d_name) == 2 &&
 		    !hex_to_bytes(&c, e->d_name, 1)) {
 			strbuf_setlen(&count_path, base_path_len);
-			strbuf_addstr(&count_path, e->d_name);
-			total += (count = count_files(count_path.buf));
+			strbuf_addf(&count_path, "%s/", e->d_name);
+			total += (count = count_files(&count_path));
 			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
 		}
 
@@ -144,22 +180,28 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	len = buf.len;
 	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
 
-	while (!res && (e = readdir(dir))) {
-		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
-			continue;
+	while (!res && (e = readdir_skip_dot_and_dotdot(dir))) {
+		struct strbuf abspath = STRBUF_INIT;
+		unsigned char dtype;
+
+		strbuf_add_absolute_path(&abspath, at_root ? "." : path);
+		strbuf_addch(&abspath, '/');
+		dtype = get_dtype(e, &abspath);
 
 		strbuf_setlen(&buf, len);
 		strbuf_addstr(&buf, e->d_name);
 
-		if (e->d_type == DT_REG)
+		if (dtype == DT_REG)
 			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
-		else if (e->d_type != DT_DIR)
+		else if (dtype != DT_DIR)
 			warning(_("skipping '%s', which is neither file nor "
 				  "directory"), buf.buf);
 		else if (recurse &&
 			 add_directory_to_archiver(archiver_args,
 						   buf.buf, recurse) < 0)
 			res = -1;
+
+		strbuf_release(&abspath);
 	}
 
 	closedir(dir);
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index fca9b58489c..133e5747d61 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -28,12 +28,23 @@ test_expect_success UNZIP 'creates diagnostics zip archive' '
 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
 '
 
+test_expect_success UNZIP 'counts loose objects' '
+	test_commit A &&
+
+	# After committing, should have non-zero loose objects
+	git diagnose -o test-count -s 1 >out &&
+	zip_path=test-count/git-diagnostics-1.zip &&
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [1-9][0-9]* loose objects" out
+'
+
 test_expect_success UNZIP '--mode=stats excludes .git dir contents' '
 	test_when_finished rm -rf report &&
 
 	git diagnose -o report -s test --mode=stats >out &&
 
 	# Includes pack quantity/size info
+	zip_path=report/git-diagnostics-test.zip &&
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
 	grep ".git/objects" out &&
 
@@ -47,6 +58,7 @@ test_expect_success UNZIP '--mode=all includes .git dir contents' '
 	git diagnose -o report -s test --mode=all >out &&
 
 	# Includes pack quantity/size info
+	zip_path=report/git-diagnostics-test.zip &&
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
 	grep ".git/objects" out &&
 

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
