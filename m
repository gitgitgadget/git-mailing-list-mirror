Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642A1C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiJRBFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJRBFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:05:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C386819
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:05:33 -0700 (PDT)
Received: (qmail 28787 invoked by uid 109); 18 Oct 2022 01:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13460 invoked by uid 111); 18 Oct 2022 01:05:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:05:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:05:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/12] string-list: mark unused callback parameters
Message-ID: <Y0373IoJfIkb0QIP@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

String-lists may be used with callbacks for clearing or iteration. These
callbacks need to conform to a particular interface, even though not
every callback needs all of its parameters. Mark the unused ones to make
-Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c                  | 2 +-
 builtin/gc.c               | 2 +-
 builtin/remote.c           | 2 +-
 merge-ort.c                | 2 +-
 reflog-walk.c              | 2 +-
 string-list.c              | 2 +-
 t/helper/test-path-utils.c | 3 ++-
 7 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index 61a79e4a22..16f85e5475 100644
--- a/archive.c
+++ b/archive.c
@@ -500,7 +500,7 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time = archive_time;
 }
 
-static void extra_file_info_clear(void *util, const char *str)
+static void extra_file_info_clear(void *util, const char *str UNUSED)
 {
 	struct extra_file_info *info = util;
 	free(info->base);
diff --git a/builtin/gc.c b/builtin/gc.c
index 243ee85d28..24ea85c7af 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -322,7 +322,7 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
 	return os_cache + heap;
 }
 
-static int keep_one_pack(struct string_list_item *item, void *data)
+static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
 {
 	strvec_pushf(&repack, "--keep-pack=%s", basename(item->string));
 	return 0;
diff --git a/builtin/remote.c b/builtin/remote.c
index 910f7b9316..93285fc06e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -942,7 +942,7 @@ static int rm(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static void clear_push_info(void *util, const char *string)
+static void clear_push_info(void *util, const char *string UNUSED)
 {
 	struct push_info *info = util;
 	free(info->dest);
diff --git a/merge-ort.c b/merge-ort.c
index e5f41cce48..7e83ebfaa9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -397,7 +397,7 @@ struct conflicted_submodule_item {
 	int flag;
 };
 
-static void conflicted_submodule_item_free(void *util, const char *str)
+static void conflicted_submodule_item_free(void *util, const char *str UNUSED)
 {
 	struct conflicted_submodule_item *item = util;
 
diff --git a/reflog-walk.c b/reflog-walk.c
index 7aa6595a51..8a4d8fa3bd 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -55,7 +55,7 @@ static void free_complete_reflog(struct complete_reflogs *array)
 	free(array);
 }
 
-static void complete_reflogs_clear(void *util, const char *str)
+static void complete_reflogs_clear(void *util, const char *str UNUSED)
 {
 	struct complete_reflogs *array = util;
 	free_complete_reflog(array);
diff --git a/string-list.c b/string-list.c
index 549fc416d6..42bacaec55 100644
--- a/string-list.c
+++ b/string-list.c
@@ -156,7 +156,7 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
-static int item_is_not_empty(struct string_list_item *item, void *unused)
+static int item_is_not_empty(struct string_list_item *item, void *data UNUSED)
 {
 	return *item->string != '\0';
 }
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index d20e1b7a18..f69709d674 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -8,7 +8,8 @@
  * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
  * die with an explanation.
  */
-static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
+static int normalize_ceiling_entry(struct string_list_item *item,
+				   void *data UNUSED)
 {
 	char *ceil = item->string;
 
-- 
2.38.0.371.g300879f34e

