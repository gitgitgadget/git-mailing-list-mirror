Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B4C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbiBWSb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbiBWSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1AF4B403
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w13so13812958wmi.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dphLSFrZz7UAc1+gvJ5y8oPCJbsw/pv5ss6NDgClwYQ=;
        b=DOOaa7JZ4ZVWW2v/h/A449F46DWVQNGQOK3KfJnj+sNn/6w3NDzfG1ZN6BaLKmdEPE
         tEJPqIrKiBPJ5ijj0mG2nljVWhuUKJ+/ss2oW+430A0GZe9kbgNBf1iEhVd25+zXAdmh
         xrizE4tFQJRUNAhRDLD+CaheCGICuu99PH5pPaNmEBByYNfI7H/GEx3Z7rh3ATLG/cZH
         +CMvwPsa3A4sM5YIwAeSRwG7OUOF6VNUAX31xCHXcsOFH/WTgEZsOdhmkDivnQjcBD/H
         j+zhOzNxkNiEX5/biSQKseUBxIAULvzDfWowbkD506HgVNLmeATSUzz6C3VQoJzUyYXY
         xTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dphLSFrZz7UAc1+gvJ5y8oPCJbsw/pv5ss6NDgClwYQ=;
        b=4P+GYZaSriiVzaaeJ+B94KnT8Ecrp8erbMWKNZ/q4BfXXclxT/TrzGwOO3z6CPY0ok
         WL+GRC2A3vSA1AefXUwTmmDr0UqTBB9o4yup1wJcZwRymB7jgxwuYucoxHa998416ZbG
         bKZ5zmm/vLpjTssTxT+dd4bDcfEBfFIQWhRA8YVj6N0w8bwcnCbH54JUJbqKZSGkyFNh
         TOopJRxrNf0VGK6shRyZTrFQ0HAhyqYAp2GILW4tVG4nBVx0iE/NL71HWGo/7m8EJBvt
         ARht5LF0oQJSbQZZHulGV8MGTiGF8ncoLX3xExmi+H5l1QJAeClSvrUx6KiEfzw9tOmF
         rqgw==
X-Gm-Message-State: AOAM531+7xBwDgw1oovp8I4C3NHxEQMeEsoGUtMn2BSgXMJzjR7FcKgN
        AWfceGAkggUyT7dYPP7Px3KbS77Z4PM=
X-Google-Smtp-Source: ABdhPJy8lJXlH/+71vQa3QXo0xW8z6Wnu2zwpXRQzi5wVj7zwJhP3nq0uhX61mZBWaEjvnou7oycdw==
X-Received: by 2002:a7b:c016:0:b0:37b:ebf6:3d13 with SMTP id c22-20020a7bc016000000b0037bebf63d13mr8794446wmb.191.1645641074734;
        Wed, 23 Feb 2022 10:31:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm274386wrq.97.2022.02.23.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:13 -0800 (PST)
Message-Id: <7221bd9a8c7b3c81e20a0b5cd2f7b8b5e248a81f.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:47 +0000
Subject: [PATCH 09/25] bundle: parse table of contents during 'fetch'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In order to support a flexible bundle URI feature, we allow the server
to return a "table of contents" file that is formatted according to Git
config file standards. These files can describe multiple bundles,
intended to assist with using bundle URIs for fetching or with partial
clone.

Here is an example table of contents file:

[bundle "tableofcontents"]
	version = 1

[bundle "2022-02-09-1644442601-daily"]
	uri = 2022-02-09-1644442601-daily.bundle
	timestamp = 1644442601
	requires = 2022-02-02-1643842562

[bundle "2022-02-02-1643842562"]
	uri = 2022-02-02-1643842562.bundle
	timestamp = 1643842562

[bundle "2022-02-09-1644442631-daily-blobless"]
	uri = 2022-02-09-1644442631-daily-blobless.bundle
	timestamp = 1644442631
	requires = 2022-02-02-1643842568-blobless
	filter = blob:none

[bundle "2022-02-02-1643842568-blobless"]
	uri = 2022-02-02-1643842568-blobless.bundle
	timestamp = 1643842568
	filter = blob:none

(End of example.)

This file contains some important fixed values, such as

 * bundle.tableofcontents.version = 1

Also, different bundles are referenced by <id>, using keys with names

 * bundle.<id>.uri: the URI to download this bundle. This could be an
   absolute URI or a URI relative to the bundle file's URI.
 * bundle.<id>.timestamp: the timestamp when this file was generated.
 * bundle.<id>.filter: the partial clone filter applied on this bundle.
 * bundle.<id>.requires: the ID for the previous bundle.

The current change does not parse the '.filter' option, but does use the
'.requires' in the 'while (stack)' loop.

The process is that 'git bundle fetch' will parse the table of contents
and pick the most-recent bundle and download that one. That bundle
header has a ref listing, including (possibly) a list of commits that
are missing from the bundle. If any of those commits are missing, then
Git downloads the bundle specified by the '.requires' value and tries
again.  Eventually, Git should download a bundle where all missing
commits actually exist in the current repository, or Git downloads a
bundle with no missing commits.

Of course, the server could be advertising incorrect information, so it
could advertise bundles that never satisfy the missing objects. It could
also create a directed cycle in its '.requires' specifications. In each
of these cases, Git will die with a "bundle '<id>' still invalid after
downloading required bundle" message or a "bundle from '<uri>' has
missing prerequisites and no dependent bundle" message.

RFC-TODO: add a direct test of table of contents parsing in this change.
RFC-TODO: create tests that check these erroneous cases.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 169 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 7 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 0e06f1756d1..66f3b3c9376 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -7,6 +7,8 @@
 #include "hashmap.h"
 #include "object-store.h"
 #include "refs.h"
+#include "config.h"
+#include "packfile.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -165,12 +167,21 @@ struct remote_bundle_info {
 	char *uri;
 
 	/**
-	 * The 'next_id' string, if non-NULL, contains the 'id'
+	 * The 'requires_id' string, if non-NULL, contains the 'id'
 	 * for a bundle that contains the prerequisites for this
 	 * bundle. Used by table of contents to allow fetching
 	 * a portion of a repository incrementally.
 	 */
-	char *next_id;
+	char *requires_id;
+
+	/**
+	 * The 'filter_str' string, if non-NULL, specifies the
+	 * filter capability exists in this bundle with the given
+	 * specification. Allows selecting bundles that match the
+	 * client's desired filter. If NULL, then no filter exists
+	 * on the bundle.
+	 */
+	char *filter_str;
 
 	/**
 	 * A table of contents can include a timestamp for the
@@ -191,8 +202,106 @@ struct remote_bundle_info {
 	 * a stack.
 	 */
 	struct remote_bundle_info *stack_next;
+
+	/**
+	 * 'pushed' is set when first pushing the required bundle
+	 * onto the stack. Used to error out when verifying the
+	 * prerequisites and avoiding an infinite loop.
+	 */
+	unsigned pushed:1;
 };
 
+static int remote_bundle_cmp(const void *unused_cmp_data,
+			     const struct hashmap_entry *a,
+			     const struct hashmap_entry *b,
+			     const void *key)
+{
+	const struct remote_bundle_info *ee1 =
+			container_of(a, struct remote_bundle_info, ent);
+	const struct remote_bundle_info *ee2 =
+			container_of(b, struct remote_bundle_info, ent);
+
+	return strcmp(ee1->id, ee2->id);
+}
+
+static int parse_toc_config(const char *key, const char *value, void *data)
+{
+	struct hashmap *toc = data;
+	const char *key1, *key2, *id_end;
+	struct strbuf id = STRBUF_INIT;
+	struct remote_bundle_info info_lookup;
+	struct remote_bundle_info *info;
+
+	if (!skip_prefix(key, "bundle.", &key1))
+		return -1;
+
+	if (skip_prefix(key1, "tableofcontents.", &key2)) {
+		if (!strcmp(key2, "version")) {
+			int version = git_config_int(key, value);
+
+			if (version != 1) {
+				warning(_("table of contents version %d not understood"), version);
+				return -1;
+			}
+		}
+
+		return 0;
+	}
+
+	id_end = strchr(key1, '.');
+
+	/*
+	 * If this key is of the form "bundle.<x>" with no third item,
+	 * then we do not know about it. We should ignore it. Later versions
+	 * might start caring about this data on an optional basis. Increase
+	 * the version number to add keys that must be understood.
+	 */
+	if (!id_end)
+		return 0;
+
+	strbuf_add(&id, key1, id_end - key1);
+	key2 = id_end + 1;
+
+	info_lookup.id = id.buf;
+	hashmap_entry_init(&info_lookup.ent, strhash(info_lookup.id));
+	if (!(info = hashmap_get_entry(toc, &info_lookup, ent, NULL))) {
+		CALLOC_ARRAY(info, 1);
+		info->id = strbuf_detach(&id, NULL);
+		strbuf_init(&info->file, 0);
+		hashmap_entry_init(&info->ent, strhash(info->id));
+		hashmap_add(toc, &info->ent);
+	}
+
+	if (!strcmp(key2, "uri")) {
+		if (info->uri)
+			warning(_("duplicate 'uri' value for id '%s'"), info->id);
+		else
+			info->uri = xstrdup(value);
+		return 0;
+	} else if (!strcmp(key2, "timestamp")) {
+		if (info->timestamp)
+			warning(_("duplicate 'timestamp' value for id '%s'"), info->id);
+		else
+			info->timestamp = git_config_int64(key, value);
+		return 0;
+	} else if (!strcmp(key2, "requires")) {
+		if (info->requires_id)
+			warning(_("duplicate 'requires' value for id '%s'"), info->id);
+		else
+			info->requires_id = xstrdup(value);
+		return 0;
+	} else if (!strcmp(key2, "filter")) {
+		if (info->filter_str)
+			warning(_("duplicate 'filter' value for id '%s'"), info->id);
+		else
+			info->filter_str = xstrdup(value);
+		return 0;
+	}
+
+	/* Return 0 here to ignore unknown options. */
+	return 0;
+}
+
 static void download_uri_to_file(const char *uri, const char *file)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -289,13 +398,14 @@ static void unbundle_fetched_bundle(struct remote_bundle_info *info)
 
 static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 {
-	int ret = 0;
+	int ret = 0, used_hashmap = 0;
 	int progress = isatty(2);
 	char *bundle_uri;
 	struct remote_bundle_info first_file = {
 		.file = STRBUF_INIT,
 	};
 	struct remote_bundle_info *stack = NULL;
+	struct hashmap toc = { 0 };
 
 	struct option options[] = {
 		OPT_BOOL(0, "progress", &progress,
@@ -319,15 +429,31 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Step 2: Check if the file is a bundle (if so, add it to the
-	 * stack and move to step 3).
+	 * stack and move to step 3). Otherwise, expect it to be a table
+	 * of contents. Use the table to populate a hashtable of bundles
+	 * and push the most recent bundle to the stack.
 	 */
 
 	if (is_bundle(first_file.file.buf, 1)) {
 		/* The simple case: only one file, no stack to worry about. */
 		stack = &first_file;
 	} else {
-		/* TODO: Expect and parse a table of contents. */
-		die(_("unexpected data at bundle URI"));
+		struct hashmap_iter iter;
+		struct remote_bundle_info *info;
+		timestamp_t max_time = 0;
+
+		/* populate a hashtable with all relevant bundles. */
+		used_hashmap = 1;
+		hashmap_init(&toc, remote_bundle_cmp, NULL, 0);
+		git_config_from_file(parse_toc_config, first_file.file.buf, &toc);
+
+		/* initialize stack using timestamp heuristic. */
+		hashmap_for_each_entry(&toc, &iter, info, ent) {
+			if (info->timestamp > max_time || !stack) {
+				stack = info;
+				max_time = info->timestamp;
+			}
+		}
 	}
 
 	/*
@@ -357,6 +483,7 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		if (bundle_fd < 0)
 			die(_("failed to read bundle from '%s'"), stack->uri);
 
+		reprepare_packed_git(the_repository);
 		for_each_string_list_item(prereq, &header.prerequisites) {
 			struct object_info info = OBJECT_INFO_INIT;
 			struct object_id *oid = prereq->util;
@@ -373,11 +500,28 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
 		if (valid) {
 			unbundle_fetched_bundle(stack);
-		} else if (stack->next_id) {
+		} else if (stack->pushed) {
+			die(_("bundle '%s' still invalid after downloading required bundle"), stack->id);
+		} else if (stack->requires_id) {
 			/*
 			 * Load the next bundle from the hashtable and
 			 * push it onto the stack.
 			 */
+			struct remote_bundle_info *info;
+			struct remote_bundle_info info_lookup = { 0 };
+			info_lookup.id = stack->requires_id;
+
+			hashmap_entry_init(&info_lookup.ent, strhash(info_lookup.id));
+			if ((info = hashmap_get_entry(&toc, &info_lookup, ent, NULL))) {
+				/* Push onto the stack */
+				stack->pushed = 1;
+				info->stack_next = stack;
+				stack = info;
+				continue;
+			} else {
+				die(_("unable to find bundle '%s' required by bundle '%s'"),
+				    stack->requires_id, stack->id);
+			}
 		} else {
 			die(_("bundle from '%s' has missing prerequisites and no dependent bundle"),
 			    stack->uri);
@@ -386,6 +530,17 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		stack = stack->stack_next;
 	}
 
+	if (used_hashmap) {
+		struct hashmap_iter iter;
+		struct remote_bundle_info *info;
+		hashmap_for_each_entry(&toc, &iter, info, ent) {
+			free(info->id);
+			free(info->uri);
+			free(info->requires_id);
+			free(info->filter_str);
+		}
+		hashmap_clear_and_free(&toc, struct remote_bundle_info, ent);
+	}
 	free(bundle_uri);
 	return ret;
 }
-- 
gitgitgadget

