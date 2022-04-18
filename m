Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4DC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbiDRR2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347076AbiDRR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8014344F7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y21so7628654wmi.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JymiesT8GdQwcSvAsoEGjxVbiDrXJC4cSXn2isaRjcQ=;
        b=WVqlhgvVe2mD1S2DGdIPigg6TsS/qTyG3J0itiCbGBdsHBFuBzGgyqfZ4qGJsbvJ5h
         xlvSQxrOprgQ/py4C59yopnorAtWwD79Rq1sOScQGMWJS8+iTaQelOzjWGjBkVooABNq
         4UJdDN7foNg5eqdKET0PvlO/gv7TzYbXPN3KUHkdx9gIjwp738338Xv9+tzbMr1YnAjr
         hfBFOZzXSduEkmXddw0ELRD8qhWKoZP8DrGat0OC8PJPJcb3Zl42L36cjMp6FWz1V6oH
         wuietLe4y/Kg3Kwzn8UW6EN+rw9GbeJrkYyP4SxC912frffwfHwe1Wm2gbQKYPDDFhvT
         kaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JymiesT8GdQwcSvAsoEGjxVbiDrXJC4cSXn2isaRjcQ=;
        b=6E5i1Fy+ne9BzOKPMa1IuQFk01iAxrq0tiwrV33oCrbKee0DpEnIZptKUB+R0B6Cn2
         6zQUjLxjLj4BdCpj3gW7xFNlmnRecVX6qTuHNCNTrSKMKUp7N/hCliX/s6+HnLlol1aB
         mEKM0jA8/ZrWLA7Q0MjIIQlKOmFQ4JsIrnd6hp7zu45YJEXQeCGjWquRROz96byKVzfD
         8VflAHds8B+kbs/NY4S7CSLHeP5m2vKChe2VxVYe5dn1UGIsv0UsiGo0zYstjriFcbVD
         PvDeVLm9axgIZRKh3nrxOoI5pPfd2s8iRqz2AayJ/JAKbgQjtTt71WUue0OzFSgcV9kh
         qxnA==
X-Gm-Message-State: AOAM533hBkBjrl1PN5SwWfl5Eb54wr1WWErnZ0riO1mSixWxAwlYpXnC
        YOpOPTpc4ltAjFLRNguIspcjZzkAA569GA==
X-Google-Smtp-Source: ABdhPJyMmKEEPiNjStml0cpf4y4/9+1RJrDs47MQf0ZfdJnIYLjk7cIIggdOF6XW7fakzsA5m2jAag==
X-Received: by 2002:a05:600c:3b8b:b0:392:9897:1edf with SMTP id n11-20020a05600c3b8b00b0039298971edfmr4349088wms.108.1650302660133;
        Mon, 18 Apr 2022 10:24:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 19/36] bundle: parse table of contents during 'fetch'
Date:   Mon, 18 Apr 2022 19:23:36 +0200
Message-Id: <RFC-patch-v2-19.36-a5245a31a12-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 172 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 7 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 6b6107d83cf..255d7aa774b 100644
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
@@ -166,12 +168,21 @@ struct remote_bundle_info {
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
@@ -192,7 +203,108 @@ struct remote_bundle_info {
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
+#define REMOTE_BUNDLE_INFO_INIT { \
+	.file = STRBUF_INIT, \
+}
+
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
+	struct remote_bundle_info info_lookup = REMOTE_BUNDLE_INFO_INIT;
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
 
 static void download_uri_to_file(const char *uri, const char *file)
 {
@@ -290,13 +402,14 @@ static void unbundle_fetched_bundle(struct remote_bundle_info *info)
 
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
@@ -320,15 +433,31 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
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
@@ -358,6 +487,7 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		if (bundle_fd < 0)
 			die(_("failed to read bundle from '%s'"), stack->uri);
 
+		reprepare_packed_git(the_repository);
 		for_each_string_list_item(prereq, &header.prerequisites) {
 			struct object_info info = OBJECT_INFO_INIT;
 			struct object_id *oid = prereq->util;
@@ -374,11 +504,28 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
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
+			struct remote_bundle_info info_lookup = REMOTE_BUNDLE_INFO_INIT;
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
@@ -387,6 +534,17 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
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
2.36.0.rc2.902.g60576bbc845

