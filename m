Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43787C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbiDRR2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347070AbiDRR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A53344F2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q20so9126355wmq.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mRzZTE/eUo2BdTevQumHmSVF8zbmIWC/Jl501Nud6M=;
        b=hC1YHmKLbv/r14eJc0fxyLVzLbUSn2fKo8HZ8jI3PeKEn8UfyCTdVyEV6j62CcBnas
         oTZ1+5guyoduru5UXsDjc3CQJACf5Moa2w7zmYvtHj1ay+GY9eofUwB4BIgpw1F69B9A
         kW/o8CzBbArHCDE+B1uPAN1R3//6TtJioYoHvKYl2/vv/Gt2TXtFb6vuXCDH9D4H6Zp3
         m9jECf0Uaz6DGWGnOTR5aOnDkTzS22NbBb+e7+gsFrjb6jSS38Lk2LEGzz+Kv3RfmWzY
         tQnKWqXFhTxhks08oR6e99aLB7C6zmy7447rR7Um03L9+IQaJCvDKWJIBGji6yy1yxGO
         B+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mRzZTE/eUo2BdTevQumHmSVF8zbmIWC/Jl501Nud6M=;
        b=Q7vmLw5i8APL0+kX7fnUpxgb5bQQs+bw8Ew3QONQfkN7OUOstq7DIGxcr1imSXnWjp
         6k0Qd1sTdhsJnugKaJah/vFdgYgMb67KjTY898O+4NVnzyHKODeuJGQgrgpu7TSQrpq8
         pCJY4gnED2/aZECBO5EVMsiKG5n9BazE70VwP70/qLT3AEN+fFd0oZaTG1Zpo0trty1y
         Ke/RUeT1CI2BVcm6R1TDKHOaWrTwGbzFeI1KHJwDlyVVbodcr9X5LO9j45ar0reftYEK
         PgwW8cwJuJGvRHfUX6qXlccd/p0SuVTUZEnme3wQCuMQMJNsRlsF4caJEYEiUVIZZohZ
         m/vg==
X-Gm-Message-State: AOAM530j3ahCPFfZW1eHx3ki3oMGt1WqRIcj6uFSjC7MnqcxefCQbjmB
        YS0uCFbfrGRpFi5C/GwglQjlQ8fRwFivXQ==
X-Google-Smtp-Source: ABdhPJzbK9TfpvYDBRvYONBkO4scX8T0VTnXsM41GN5h1S7HEy4zgpLQ9JIEV8DQXKYlPwzvr+fOnA==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id q11-20020a1cf30b000000b0037bb5dec804mr16102166wmq.166.1650302659068;
        Mon, 18 Apr 2022 10:24:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 18/36] bundle: implement 'fetch' command for direct bundles
Date:   Mon, 18 Apr 2022 19:23:35 +0200
Message-Id: <RFC-patch-v2-18.36-ff9a7afaccd-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 Documentation/git-bundle.txt |   1 +
 builtin/bundle.c             | 261 +++++++++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7685b570455..bf5cd90391c 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
 		    [--version=<version>] <file> <git-rev-list-args>
 'git bundle' verify [-q | --quiet] <file>
+'git bundle' fetch [--filter=<spec>] <uri>
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle [--progress] <file> [<refname>...]
 
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2adad545a2e..6b6107d83cf 100644
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
@@ -14,6 +18,7 @@
 static const char * const builtin_bundle_usage[] = {
   N_("git bundle create [<options>] <file> <git-rev-list args>"),
   N_("git bundle verify [<options>] <file>"),
+  N_("git bundle fetch [<options>] <uri>"),
   N_("git bundle list-heads <file> [<refname>...]"),
   N_("git bundle unbundle <file> [<refname>...]"),
   NULL
@@ -29,6 +34,11 @@ static const char * const builtin_bundle_verify_usage[] = {
   NULL
 };
 
+static const char * const builtin_bundle_fetch_usage[] = {
+	N_("git bundle fetch [--filter=<spec>] <uri>"),
+	NULL
+};
+
 static const char * const builtin_bundle_list_heads_usage[] = {
   N_("git bundle list-heads <file> [<refname>...]"),
   NULL
@@ -132,6 +142,255 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
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
@@ -212,6 +471,8 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		result = cmd_bundle_create(argc, argv, prefix);
 	else if (!strcmp(argv[0], "verify"))
 		result = cmd_bundle_verify(argc, argv, prefix);
+	else if (!strcmp(argv[0], "fetch"))
+		result = cmd_bundle_fetch(argc, argv, prefix);
 	else if (!strcmp(argv[0], "list-heads"))
 		result = cmd_bundle_list_heads(argc, argv, prefix);
 	else if (!strcmp(argv[0], "unbundle"))
-- 
2.36.0.rc2.902.g60576bbc845

