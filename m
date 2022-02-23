Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9148C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiBWSby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbiBWSbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62A45AE4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so41064621wra.12
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Aa7ncIT6vPEUq/ovGdDxjj1cqheO8Rxlz3GuEJwC19k=;
        b=khvYr5OHfooyQRfCkBHHdj2Hi2F7bR2nDXi/S6KZwEpqjOFR9tSa2BTqjLFagj5PvR
         +63YS5+/VZYE6HXpSN+U8XJWF/aEBp6x0I9TMMbpZtXuO00Ep32/QSj6SwMBomE3HsXp
         WV0bgWYTORokYcDxOjP2qcz2gLkxUZoMck20+yDmCW5u3mnvMdlRnMVbSzHh9H+0Bt/N
         uebYeEMazEWcU/2QNEhxjyDgLm3uA4ej9qlrjOubdnOjic1UrdyoSC7yaSQGcwjzaWTV
         jcg+jCXd1Gt/kbzUCJfXcNk0f3MftJdDUgPun4IQMt7ctljqdDNEYISXUiPOukXxPoZr
         LnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Aa7ncIT6vPEUq/ovGdDxjj1cqheO8Rxlz3GuEJwC19k=;
        b=l9/4QvQFv36BOUytKEaKjAEJhIFQSuXOY6AbBa6mVbaK+XKHOf38EPjDm5tiUIRS3D
         EdID4y1iTDhm5s5UXN5hMhzWejbLrB4OvgGvPSvTbYRquNWd5akwlO/80s1i9Bdl0gyq
         LQxBExqU80Zsxgtx2chsK93f13iDYwZtnxNTvcCH4iZxkQWIfvZj32UFwmcf5g6jc6W5
         mT5Mukbg1VK0C+LSz9cElyu4ey1hitzXUMZI5W/nDxkYUhh4bUMXx2mlrBJ/3Hs+IKRt
         M12zpGgM5N6tmcIcllW3u/2L7nrCjptiEHugiHjV2As25W+dHio4pGJhhG+zB4doFQB6
         Y4kw==
X-Gm-Message-State: AOAM530qRuMMSNtlSA7Pfm1iqQI/LY/LM1C8+r4yEh7onrwRl+mSGyJv
        MtT9uGhIxdW8pyykhuNcZUe+GVYtMow=
X-Google-Smtp-Source: ABdhPJyWd1DMRIYcbUm5ZF+RJzlxuGoJvIGFcolVVqrfMTOcevdVWn6qKdT4KUT0BI3stivUpEQO/g==
X-Received: by 2002:adf:f5c3:0:b0:1ed:c1da:9684 with SMTP id k3-20020adff5c3000000b001edc1da9684mr663579wrp.245.1645641073560;
        Wed, 23 Feb 2022 10:31:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0037c050d73dcsm464229wmq.46.2022.02.23.10.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:13 -0800 (PST)
Message-Id: <b993e7b47104f1d1740ab39d7ef3dc5bbccecbfc.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:46 +0000
Subject: [PATCH 08/25] bundle: implement 'fetch' command for direct bundles
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

The 'git bundle fetch <uri>' command will be used to download one or
more bundles from a specified '<uri>'. The implementation being added
here focuses only on downloading a file from '<uri>' and unbundling it
if it is a valid bundle file.

If it is not a bundle file, then we currently die(), but a later change
will attempt to interpret it as a table of contents with possibly
multiple bundles listed, along with other metadata for each bundle.

That explains a bit why cmd_bundle_fetch() has three steps carefully
commented, including a "stack" that currently can only hold one bundle.
We will later update this while loop to push onto the stack when
necessary.

RFC-TODO: Add documentation to Documentation/git-bundle.txt

RFC-TODO: Add direct tests of 'git bundle fetch' when the URI is a
bundle file.

RFC-TODO: Split out the docs and subcommand boilerplate into its own
commit.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 261 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 8187b7df739..0e06f1756d1 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -3,6 +3,10 @@
 #include "parse-options.h"
 #include "cache.h"
 #include "bundle.h"
+#include "run-command.h"
+#include "hashmap.h"
+#include "object-store.h"
+#include "refs.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -13,6 +17,7 @@
 
 static const char * const builtin_bundle_usage[] = {
   N_("git bundle create [<options>] <file> <git-rev-list args>"),
+  N_("git bundle fetch [<options>] <uri>"),
   N_("git bundle list-heads <file> [<refname>...]"),
   N_("git bundle unbundle <file> [<refname>...]"),
   N_("git bundle verify [<options>] <file>"),
@@ -24,6 +29,11 @@ static const char * const builtin_bundle_create_usage[] = {
   NULL
 };
 
+static const char * const builtin_bundle_fetch_usage[] = {
+  N_("git bundle fetch [--filter=<spec>] <uri>"),
+  NULL
+};
+
 static const char * const builtin_bundle_list_heads_usage[] = {
   N_("git bundle list-heads <file> [<refname>...]"),
   NULL
@@ -131,6 +141,255 @@ cleanup:
 	return ret;
 }
 
+/**
+ * The remote_bundle_info struct contains the necessary data for
+ * the list of bundles advertised by a table of contents. If the
+ * bundle URI instead contains a single bundle, then this struct
+ * can represent a single bundle without a 'uri' but with a
+ * tempfile storing its current location on disk.
+ */
+struct remote_bundle_info {
+	struct hashmap_entry ent;
+
+	/**
+	 * The 'id' is a name given to the bundle for reference
+	 * by other bundle infos.
+	 */
+	char *id;
+
+	/**
+	 * The 'uri' is the location of the remote bundle so
+	 * it can be downloaded on-demand. This will be NULL
+	 * if there was no table of contents.
+	 */
+	char *uri;
+
+	/**
+	 * The 'next_id' string, if non-NULL, contains the 'id'
+	 * for a bundle that contains the prerequisites for this
+	 * bundle. Used by table of contents to allow fetching
+	 * a portion of a repository incrementally.
+	 */
+	char *next_id;
+
+	/**
+	 * A table of contents can include a timestamp for the
+	 * bundle as a heuristic for describing a list of bundles
+	 * in order of recency.
+	 */
+	timestamp_t timestamp;
+
+	/**
+	 * If the bundle has been downloaded, then 'file' is a
+	 * filename storing its contents. Otherwise, 'file' is
+	 * an empty string.
+	 */
+	struct strbuf file;
+
+	/**
+	 * The 'stack_next' pointer allows this struct to form
+	 * a stack.
+	 */
+	struct remote_bundle_info *stack_next;
+};
+
+static void download_uri_to_file(const char *uri, const char *file)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *child_in;
+
+	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
+	cp.in = -1;
+	cp.out = -1;
+
+	if (start_command(&cp))
+		die(_("failed to start remote helper"));
+
+	child_in = fdopen(cp.in, "w");
+	if (!child_in)
+		die(_("cannot write to child process"));
+
+	fprintf(child_in, "get %s %s\n\n", uri, file);
+	fclose(child_in);
+
+	if (finish_command(&cp))
+		die(_("remote helper failed"));
+}
+
+static void find_temp_filename(struct strbuf *name)
+{
+	int fd;
+	/*
+	 * Find a temporray filename that is available. This is briefly
+	 * racy, but unlikely to collide.
+	 */
+	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
+	if (fd < 0)
+		die(_("failed to create temporary file"));
+	close(fd);
+	unlink(name->buf);
+}
+
+static void unbundle_fetched_bundle(struct remote_bundle_info *info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *f;
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf bundle_ref = STRBUF_INIT;
+	size_t bundle_prefix_len;
+
+	strvec_pushl(&cp.args, "bundle", "unbundle",
+				info->file.buf, NULL);
+	cp.git_cmd = 1;
+	cp.out = -1;
+
+	if (start_command(&cp))
+		die(_("failed to start 'unbundle' process"));
+
+	strbuf_addstr(&bundle_ref, "refs/bundles/");
+	bundle_prefix_len = bundle_ref.len;
+
+	f = fdopen(cp.out, "r");
+	while (strbuf_getline(&line, f) != EOF) {
+		struct object_id oid, old_oid;
+		const char *refname, *branch_name, *end;
+		char *space;
+		int has_old;
+
+		strbuf_trim_trailing_newline(&line);
+
+		space = strchr(line.buf, ' ');
+
+		if (!space)
+			continue;
+
+		refname = space + 1;
+		*space = '\0';
+		parse_oid_hex(line.buf, &oid, &end);
+
+		if (!skip_prefix(refname, "refs/heads/", &branch_name))
+			continue;
+
+		strbuf_setlen(&bundle_ref, bundle_prefix_len);
+		strbuf_addstr(&bundle_ref, branch_name);
+
+		has_old = !read_ref(bundle_ref.buf, &old_oid);
+
+		update_ref("bundle fetch", bundle_ref.buf, &oid,
+				has_old ? &old_oid : NULL,
+				REF_SKIP_OID_VERIFICATION,
+				UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	if (finish_command(&cp))
+		die(_("failed to unbundle bundle from '%s'"), info->uri);
+
+	unlink_or_warn(info->file.buf);
+}
+
+static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
+{
+	int ret = 0;
+	int progress = isatty(2);
+	char *bundle_uri;
+	struct remote_bundle_info first_file = {
+		.file = STRBUF_INIT,
+	};
+	struct remote_bundle_info *stack = NULL;
+
+	struct option options[] = {
+		OPT_BOOL(0, "progress", &progress,
+			 N_("show progress meter")),
+		OPT_END()
+	};
+
+	argc = parse_options_cmd_bundle(argc, argv, prefix,
+			builtin_bundle_fetch_usage, options, &bundle_uri);
+
+	if (!startup_info->have_repository)
+		die(_("'fetch' requires a repository"));
+
+	/*
+	 * Step 1: determine protocol for uri, and download contents to
+	 * a temporary location.
+	 */
+	first_file.uri = bundle_uri;
+	find_temp_filename(&first_file.file);
+	download_uri_to_file(bundle_uri, first_file.file.buf);
+
+	/*
+	 * Step 2: Check if the file is a bundle (if so, add it to the
+	 * stack and move to step 3).
+	 */
+
+	if (is_bundle(first_file.file.buf, 1)) {
+		/* The simple case: only one file, no stack to worry about. */
+		stack = &first_file;
+	} else {
+		/* TODO: Expect and parse a table of contents. */
+		die(_("unexpected data at bundle URI"));
+	}
+
+	/*
+	 * Step 3: For each bundle in the stack:
+	 * 	i. If not downloaded to a temporary file, download it.
+	 * 	ii. Once downloaded, check that its prerequisites are in
+	 * 	    the object database. If not, then push its dependent
+	 * 	    bundle onto the stack. (Fail if no such bundle exists.)
+	 * 	iii. If all prerequisites are present, then unbundle the
+	 * 	     temporary file and pop the bundle from the stack.
+	 */
+	while (stack) {
+		int valid = 1;
+		int bundle_fd;
+		struct string_list_item *prereq;
+		struct bundle_header header = BUNDLE_HEADER_INIT;
+
+		if (!stack->file.len) {
+			find_temp_filename(&stack->file);
+			download_uri_to_file(stack->uri, stack->file.buf);
+			if (!is_bundle(stack->file.buf, 1))
+				die(_("file downloaded from '%s' is not a bundle"), stack->uri);
+		}
+
+		bundle_header_init(&header);
+		bundle_fd = read_bundle_header(stack->file.buf, &header);
+		if (bundle_fd < 0)
+			die(_("failed to read bundle from '%s'"), stack->uri);
+
+		for_each_string_list_item(prereq, &header.prerequisites) {
+			struct object_info info = OBJECT_INFO_INIT;
+			struct object_id *oid = prereq->util;
+
+			if (oid_object_info_extended(the_repository, oid, &info,
+						     OBJECT_INFO_QUICK)) {
+				valid = 0;
+				break;
+			}
+		}
+
+		close(bundle_fd);
+		bundle_header_release(&header);
+
+		if (valid) {
+			unbundle_fetched_bundle(stack);
+		} else if (stack->next_id) {
+			/*
+			 * Load the next bundle from the hashtable and
+			 * push it onto the stack.
+			 */
+		} else {
+			die(_("bundle from '%s' has missing prerequisites and no dependent bundle"),
+			    stack->uri);
+		}
+
+		stack = stack->stack_next;
+	}
+
+	free(bundle_uri);
+	return ret;
+}
+
 static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
@@ -209,6 +468,8 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 
 	else if (!strcmp(argv[0], "create"))
 		result = cmd_bundle_create(argc, argv, prefix);
+	else if (!strcmp(argv[0], "fetch"))
+		result = cmd_bundle_fetch(argc, argv, prefix);
 	else if (!strcmp(argv[0], "list-heads"))
 		result = cmd_bundle_list_heads(argc, argv, prefix);
 	else if (!strcmp(argv[0], "unbundle"))
-- 
gitgitgadget

