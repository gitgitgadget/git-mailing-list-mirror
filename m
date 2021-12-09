Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E6C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhLITXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLITXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D1C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso7362706wms.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMgqAUYQa4j32ynP4DlVu4Ru+k35xMqbSkEZjLrdObI=;
        b=hgVTKXNzN3XrGqZORLkW0aG21jc132DDxMconudzfmyEDe7GmIQ4cluikj1H/iaGgD
         Hdgntih5sW98+YIYjftCs8R17fb1JmJHZ4I1iLI2hUd4XC2Xs7mTUM3/egvzgY3009sN
         gyCwlSwn+TRgz2qocDfdYLfFJHuKq1qlVTbi7q4QBBK3vvWtYfjhpbJolBBFsSVg+Ara
         1JqGTFwl2Xz0fG1Blw4OROzyiyCp36XQpboMYZs957LAfIkBEGYj99skFWSIjDD8DTu6
         nriLAGar7X7XN88PH0oZ4QB+i4E69L1ZIUnxDPcLzPsvWzOlq8RIDONFFQwbv599G9ZY
         VTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMgqAUYQa4j32ynP4DlVu4Ru+k35xMqbSkEZjLrdObI=;
        b=3jv1HOUsTaOke8tn4ys91/vkoo7c4Spqny7FELV144r0Ci1ufunMAZsTah3Iuei/4s
         3zmcBvfQoVSQAU6GZHGP0NoQodGmkA9e3brCASclJ+s+0gpg21/p6WlNUntk6fu4Feu1
         fXmT4M15ItiNG0TQXI27vyGEMjcne4EDBKaKxjC8THd+hGeZihMjWt/g45D5C7s2pFIM
         zgaoTnovx85Nd8V08gneCmDo4vfL6rjPYuXDcWdHXUYBP8yZwFHGvokT7xuK7j9lBzBt
         GFVobF4xIN+PhHeWU2Qo/xqnxrDmlqa5H8XJHkWwK9cLeK3tkIZHd/dqaT8zaFPCM1UN
         ZiEA==
X-Gm-Message-State: AOAM533Bfyv/rnqbwk+lNs7KmNix2dd/wpDFJgOGDV1ayvern2oMaLTM
        QDtnioZdqr9+A94ovX0a8Emc0eGheWycBA==
X-Google-Smtp-Source: ABdhPJyG3KE8wwIJgfwavxe3MVyD1vCb6Ad3pShT0zaCbAKx7tU+09xg4/v3XLvXvzhwVhfiKv2O7A==
X-Received: by 2002:a1c:a58d:: with SMTP id o135mr9432742wme.93.1639077572185;
        Thu, 09 Dec 2021 11:19:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 01/10] string-list API: change "nr" and "alloc" to "size_t"
Date:   Thu,  9 Dec 2021 20:19:18 +0100
Message-Id: <RFC-patch-01.10-7c929096381-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the recent change to the "struct strvec" let's change "struct
string_list"'s "alloc" and "nr" to be a "size_t" as well. This will be
used to fix an overflow in range-diff.c. See 8d133a4653a (strvec: use
size_t to store nr and alloc, 2021-09-11) for the recent change to
"struct strvec".

As with the "struct strvec" change I think it would make sense to go
through the users of the current "unsigned int" field and change
anyone copying it to an "int" or "unsigned int" to "size_t", but as
seen in [1] others disagree, so let's only change the things the
compiler complains about here.

1. https://lore.kernel.org/git/87mtog4pai.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c      | 6 +++---
 builtin/shortlog.c          | 8 ++++----
 bundle.c                    | 4 ++--
 commit-graph.c              | 4 ++--
 mailmap.c                   | 4 ++--
 merge-ort.c                 | 2 +-
 string-list.h               | 2 +-
 t/helper/test-run-command.c | 4 ++--
 wt-status.c                 | 8 ++++----
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..4c681a64784 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -827,12 +827,12 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.trace2_hook_name = hook_name;
 
 	if (feed_state->push_options) {
-		int i;
+		size_t i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
 			strvec_pushf(&proc.env_array,
-				     "GIT_PUSH_OPTION_%d=%s", i,
+				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s", i,
 				     feed_state->push_options->items[i].string);
-		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
+		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
 			     feed_state->push_options->nr);
 	} else
 		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e7f7af5de3f..32c457956c7 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -434,7 +434,7 @@ static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
 
 void shortlog_output(struct shortlog *log)
 {
-	int i, j;
+	size_t i, j;
 	struct strbuf sb = STRBUF_INIT;
 
 	if (log->sort_by_number)
@@ -447,10 +447,10 @@ void shortlog_output(struct shortlog *log)
 				(int)UTIL_TO_INT(item), item->string);
 		} else {
 			struct string_list *onelines = item->util;
-			fprintf(log->file, "%s (%d):\n",
+			fprintf(log->file, "%s (%"PRIuMAX"):\n",
 				item->string, onelines->nr);
-			for (j = onelines->nr - 1; j >= 0; j--) {
-				const char *msg = onelines->items[j].string;
+			for (j = onelines->nr; j >= 1; j--) {
+				const char *msg = onelines->items[j - 1].string;
 
 				if (log->wrap_lines) {
 					strbuf_reset(&sb);
diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..54dff6d9960 100644
--- a/bundle.c
+++ b/bundle.c
@@ -255,7 +255,7 @@ int verify_bundle(struct repository *r,
 
 		r = &header->references;
 		printf_ln(Q_("The bundle contains this ref:",
-			     "The bundle contains these %d refs:",
+			     "The bundle contains these %"PRIuMAX" refs:",
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
@@ -264,7 +264,7 @@ int verify_bundle(struct repository *r,
 			printf_ln(_("The bundle records a complete history."));
 		} else {
 			printf_ln(Q_("The bundle requires this ref:",
-				     "The bundle requires these %d refs:",
+				     "The bundle requires these %"PRIuMAX" refs:",
 				     r->nr),
 				  r->nr);
 			list_refs(r, 0, NULL);
diff --git a/commit-graph.c b/commit-graph.c
index 2706683acfe..88a7621f2f7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1687,8 +1687,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
-			    Q_("Finding commits for commit graph in %d pack",
-			       "Finding commits for commit graph in %d packs",
+			    Q_("Finding commits for commit graph in %"PRIuMAX" pack",
+			       "Finding commits for commit graph in %"PRIuMAX" packs",
 			       pack_indexes->nr),
 			    pack_indexes->nr);
 		ctx->progress = start_delayed_progress(progress_title.buf, 0);
diff --git a/mailmap.c b/mailmap.c
index 40ce152024d..9ce15a9e2fd 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -43,7 +43,7 @@ static void free_mailmap_info(void *p, const char *s)
 static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
-	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n",
+	debug_mm("mailmap: removing entries for <%s>, with %"PRIuMAX" sub-entries\n",
 		 s, me->namemap.nr);
 	debug_mm("mailmap: - simple: '%s' <%s>\n",
 		 debug_str(me->name), debug_str(me->email));
@@ -250,7 +250,7 @@ int read_mailmap(struct string_list *map)
 
 void clear_mailmap(struct string_list *map)
 {
-	debug_mm("mailmap: clearing %d entries...\n", map->nr);
+	debug_mm("mailmap: clearing %"PRIuMAX" entries...\n", map->nr);
 	map->strdup_strings = 1;
 	string_list_clear_func(map, free_mailmap_entry);
 	debug_mm("mailmap: cleared\n");
diff --git a/merge-ort.c b/merge-ort.c
index 0342f104836..28a7cffdb96 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4004,7 +4004,7 @@ static void process_entries(struct merge_options *opt,
 	trace2_region_enter("merge", "process_entries cleanup", opt->repo);
 	if (dir_metadata.offsets.nr != 1 ||
 	    (uintptr_t)dir_metadata.offsets.items[0].util != 0) {
-		printf("dir_metadata.offsets.nr = %d (should be 1)\n",
+		printf("dir_metadata.offsets.nr = %"PRIuMAX" (should be 1)\n",
 		       dir_metadata.offsets.nr);
 		printf("dir_metadata.offsets.items[0].util = %u (should be 0)\n",
 		       (unsigned)(uintptr_t)dir_metadata.offsets.items[0].util);
diff --git a/string-list.h b/string-list.h
index 267d6e5769d..ab331643685 100644
--- a/string-list.h
+++ b/string-list.h
@@ -86,7 +86,7 @@ typedef int (*compare_strings_fn)(const char *, const char *);
  */
 struct string_list {
 	struct string_list_item *items;
-	unsigned int nr, alloc;
+	size_t nr, alloc;
 	unsigned int strdup_strings:1;
 	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3c4fb862234..8e932700201 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -180,7 +180,7 @@ static int testsuite(int argc, const char **argv)
 	if (max_jobs > suite.tests.nr)
 		max_jobs = suite.tests.nr;
 
-	fprintf(stderr, "Running %d tests (%d at a time)\n",
+	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
 		suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
@@ -188,7 +188,7 @@ static int testsuite(int argc, const char **argv)
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
-		fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
+		fprintf(stderr, "%"PRIuMAX" tests failed:\n\n", suite.failed.nr);
 		for (i = 0; i < suite.failed.nr; i++)
 			fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
 	}
diff --git a/wt-status.c b/wt-status.c
index 5d215f4e4f1..79b83caa0f3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1368,8 +1368,8 @@ static void show_rebase_information(struct wt_status *s,
 			status_printf_ln(s, color, _("No commands done."));
 		else {
 			status_printf_ln(s, color,
-				Q_("Last command done (%d command done):",
-					"Last commands done (%d commands done):",
+				Q_("Last command done (%"PRIuMAX" command done):",
+					"Last commands done (%"PRIuMAX" commands done):",
 					have_done.nr),
 				have_done.nr);
 			for (i = (have_done.nr > nr_lines_to_show)
@@ -1387,8 +1387,8 @@ static void show_rebase_information(struct wt_status *s,
 					 _("No commands remaining."));
 		else {
 			status_printf_ln(s, color,
-				Q_("Next command to do (%d remaining command):",
-					"Next commands to do (%d remaining commands):",
+				Q_("Next command to do (%"PRIuMAX" remaining command):",
+					"Next commands to do (%"PRIuMAX" remaining commands):",
 					yet_to_do.nr),
 				yet_to_do.nr);
 			for (i = 0; i < nr_lines_to_show && i < yet_to_do.nr; i++)
-- 
2.34.1.930.g0f9292b224d

