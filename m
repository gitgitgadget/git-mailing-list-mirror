Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD321F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbdEATIa (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:08:30 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36779 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdEATI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:08:29 -0400
Received: by mail-pf0-f173.google.com with SMTP id q66so33969640pfi.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AjDb6WxLFRnSwJhvPGts/rFCQxnC0DqZ1q8LSH0+Yck=;
        b=AiCfOMRepQt56YLIhLcmfxp9hFEGINxPIY+rPwVc0v46uyucm23xTZ1NKD00AviGTb
         yJ7SLu4CgI0Ilrk4KFWUwSVtJC6iAXqfIz52rzt5Jl6xZb36V0o+WcqWrlg2Ur91rbRN
         zjsEWeo0jLV5Lv9eDqNpqxwe0tGUMbGPKiwomIQPi718CORVJlrXITDjkwK2bbaRoBHS
         z2uNdlGlAP0nrcCNWQj9DEb62rEi82+921fIjOosz6MzuC689dBaZJFw4dPwo2X4lVTo
         kYQA3kC/nDh4DPtz981de7hu32o2S1JSokNh1PxZAm8uMeFYlYRtgcmLHgv8bSBLhJh8
         4qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AjDb6WxLFRnSwJhvPGts/rFCQxnC0DqZ1q8LSH0+Yck=;
        b=QdvJNwnEXLhZ44JDNbAQtbD2fnfmm9+SkoWlU/TYFQc0boiP5IXrMevbK0NG96G0L6
         2Kzhc8T1GusCnbQrsYC4BCe5AzFkLRYYMZ50KJbR3rbfE0A+pqSxe9WTgHAZA+kvQIFO
         rLS6Xxg95zP1Se741To0diob6iL5sKG2XYtGA0hOR9WN+tOk12ia9eWN7L1r+ivQEhht
         7F76G+nXf9FB1bO0R83Hw1dmnVnKBK1k7auJBir/A4TzWjap2zYWnJ6MlkYsK3ohXufa
         madgWk/kg6QqoG5AYRpZF6VX/2rVIbuxHZyCrvo3L1+KuHZsxAtZNI5Yd5Yyuyat/wCv
         OkVg==
X-Gm-Message-State: AN3rC/4+CK0D5jG7XrnsUtK5btGP3MiijEXt7pfJh0M4n66xBpKP2iBv
        SepGdP2UcRSMtsoiFzmWsg==
X-Received: by 10.99.173.6 with SMTP id g6mr28337896pgf.75.1493665703439;
        Mon, 01 May 2017 12:08:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id e131sm23430101pfg.10.2017.05.01.12.08.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 12:08:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] cache.h: drop read_cache_from
Date:   Mon,  1 May 2017 12:07:17 -0700
Message-Id: <20170501190719.10669-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501190719.10669-1-sbeller@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression E; @@
-read_cache_from(E)
+read_index_from(&the_index, E)

additionally drop the define from cache.h manually

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c          | 2 +-
 builtin/am.c     | 4 ++--
 builtin/commit.c | 6 +++---
 cache.h          | 1 -
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index ae1b659b68..159e039a18 100644
--- a/apply.c
+++ b/apply.c
@@ -3985,7 +3985,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
-		return read_cache_from(state->index_file);
+		return read_index_from(&the_index, state->index_file);
 	else
 		return read_index(&the_index);
 }
diff --git a/builtin/am.c b/builtin/am.c
index c6a679d8e1..cb3e4dff63 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1557,7 +1557,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	if (index_file) {
 		/* Reload index as apply_all_patches() will have modified it. */
 		discard_cache();
-		read_cache_from(index_file);
+		read_index_from(&the_index, index_file);
 	}
 
 	return 0;
@@ -1600,7 +1600,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error("could not build fake ancestor");
 
 	discard_cache();
-	read_cache_from(index_path);
+	read_index_from(&the_index, index_path);
 
 	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
diff --git a/builtin/commit.c b/builtin/commit.c
index 01d298c836..65a04ac199 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -370,7 +370,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(get_lock_file_path(&index_lock));
+		read_index_from(&the_index, get_lock_file_path(&index_lock));
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -489,7 +489,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	discard_cache();
 	ret = get_lock_file_path(&false_lock);
-	read_cache_from(ret);
+	read_index_from(&the_index, ret);
 	return ret;
 }
 
@@ -949,7 +949,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * the editor and after we invoke run_status above.
 	 */
 	discard_cache();
-	read_cache_from(index_file);
+	read_index_from(&the_index, index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
 		return 0;
diff --git a/cache.h b/cache.h
index 4e913d1346..6abf48dcc3 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define read_cache_from(path) read_index_from(&the_index, (path))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
-- 
2.13.0.rc1.1.gbc33f0f778

