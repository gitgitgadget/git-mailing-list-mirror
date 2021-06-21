Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C76C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4D6113E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFUPSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhFUPSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:18:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1156C061760
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n7so20117958wri.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLhNur4GnoVoJcH+5jXoC7jp8q8JMVrhBgNqM2W7ARw=;
        b=QZpe9wzf30A/ojoYqddIvZaiBZ2s49q397xJkvYFXGh8yrTQia+X3LPxDWOyC+6gqe
         F74BRNsJEvEpBUfJrOpTKJY98W6MuwlBFWC/X3GwybBJkHIk3J4Ro6SMJjkUb4/1Fv8G
         4SvJHe0gbIXm+Gik/dmltSJJ211fje96EprM1a0Ba8ubA1FCIAVP82mnPy0BPeFYlU+F
         AzJe+oAM5Ewx3aYe7h9WGgwQrgO/KD8yLvrwYZXqlUr+Y1ka98wkJCLuFiod0eB1d2kI
         N4L5H/3sC8KQ+LWdn3OnddfpGqvsjpVFP0REfrUUVGrVeJNDRhdNAy7LKmyfywNH2YYl
         hQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLhNur4GnoVoJcH+5jXoC7jp8q8JMVrhBgNqM2W7ARw=;
        b=dZSO3v4W0qNAS6CtvP82FnFaPPWSWkMkDti+xy4OMdJxa54XNpFVGuqZ2Et7gKs4An
         39YcjYrdctLSM0zZxejDSE+MMpVMKCMleQqh6ql/EHc2lxGjz8tay9UJfd9K6Yub8nP+
         GWOE9Bjzy6gPzPhB2kxT/3ef+QhS6GSuqMlAmfPuc9dtKIUIv+umEqlDPITDam8hc7s7
         LD0vztxLJvjDE10MQ9upnLcv886/eZHR6Zrxz1M+8NFtBSZ2HlfaIgLKKaxRHYAKnHoX
         IGGJCcgoz5Ry9fAwM/llO+iFBt9WbqD/xswqNL0FjKuLz+W+FnvML8CYJLHlabWxe2hb
         SePQ==
X-Gm-Message-State: AOAM533HRrFPs07Tmtxj8yMOb6owEJQqKKIGSL+nMZZ+HIOjVzGUWyJZ
        0aS1cTImFIATLF1FR+qU5/zRdzSxhxOSug==
X-Google-Smtp-Source: ABdhPJzq/u5uZuJQQVMpaOXALQtOg65iMkiFpiKcbKRz1tTCxFost2Q1F1Xpe16wOS3m4U3LhLxVkg==
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr5259116wrm.44.1624288582298;
        Mon, 21 Jun 2021 08:16:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u15sm15716019wmq.1.2021.06.21.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:16:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] bundle: remove "ref_list" in favor of string-list.c API
Date:   Mon, 21 Jun 2021 17:16:14 +0200
Message-Id: <patch-3.3-9d9cb5aaf9e-20210621T151357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com> <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move away from the "struct ref_list" in bundle.c in favor of the
almost identical string-list.c API.

That API fits this use-case perfectly, but did not exist in its
current form when this code was added in 2e0afafebd (Add git-bundle:
move objects and references by archive, 2007-02-22), with hindsight we
could have used the path-list API, which later got renamed to
string-list. See 8fd2cb4069 (Extract helper bits from
c-merge-recursive work, 2006-07-25)

We need to change "name" to "string" and "oid" to "util" to make this
conversion, but other than that the APIs are pretty much identical for
what bundle.c made use of.

Let's also replace the memset(..,0,...) pattern with a more idiomatic
"INIT" macro, and finally add a *_release() function so to free the
allocated memory.

Before this the add_to_ref_list() would leak memory, now e.g. "bundle
list-heads" reports no memory leaks at all under valgrind.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 12 +++++-----
 bundle.c         | 62 ++++++++++++++++++++++++------------------------
 bundle.h         | 20 ++++++++--------
 transport.c      | 10 +++++---
 4 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 7778297277a..8d822552808 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -106,7 +106,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 }
 
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
-	struct bundle_header header;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int quiet = 0;
 	int ret;
@@ -121,7 +121,6 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	memset(&header, 0, sizeof(header));
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
 		ret = 1;
 		goto cleanup;
@@ -136,11 +135,12 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	ret = 0;
 cleanup:
 	free(bundle_file);
+	bundle_header_release(&header);
 	return ret;
 }
 
 static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
-	struct bundle_header header;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
 	struct option options[] = {
@@ -152,7 +152,6 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 			builtin_bundle_list_heads_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	memset(&header, 0, sizeof(header));
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
 		ret = 1;
 		goto cleanup;
@@ -161,11 +160,12 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 	ret = !!list_bundle_refs(&header, argc, argv);
 cleanup:
 	free(bundle_file);
+	bundle_header_release(&header);
 	return ret;
 }
 
 static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
-	struct bundle_header header;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int die_no_repo = 0;
 	int ret;
@@ -178,7 +178,6 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 			builtin_bundle_unbundle_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	memset(&header, 0, sizeof(header));
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
 		ret = 1;
 		goto cleanup;
@@ -189,6 +188,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
 		list_bundle_refs(&header, argc, argv);
+	bundle_header_release(&header);
 cleanup:
 	if (die_no_repo)
 		die(_("Need a repository to unbundle."));
diff --git a/bundle.c b/bundle.c
index 7210e5e7105..1c3ae9e02ea 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,15 +23,6 @@ static struct {
 	{ 3, v3_bundle_signature },
 };
 
-static void add_to_ref_list(const struct object_id *oid, const char *name,
-		struct ref_list *list)
-{
-	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
-	oidcpy(&list->list[list->nr].oid, oid);
-	list->list[list->nr].name = xstrdup(name);
-	list->nr++;
-}
-
 static int parse_capability(struct bundle_header *header, const char *capability)
 {
 	const char *arg;
@@ -79,7 +70,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	/* The bundle header ends with an empty line */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
 	       buf.len && buf.buf[0] != '\n') {
-		struct object_id oid;
+		struct object_id *oid;
 		int is_prereq = 0;
 		const char *p;
 
@@ -103,19 +94,22 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		 * Prerequisites have object name that is optionally
 		 * followed by SP and subject line.
 		 */
-		if (parse_oid_hex_algop(buf.buf, &oid, &p, header->hash_algo) ||
+		oid = xmalloc(sizeof(struct object_id));
+		if (parse_oid_hex_algop(buf.buf, oid, &p, header->hash_algo) ||
 		    (*p && !isspace(*p)) ||
 		    (!is_prereq && !*p)) {
 			if (report_path)
 				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
 			status = -1;
+			free(oid);
 			break;
 		} else {
-			if (is_prereq)
-				add_to_ref_list(&oid, "", &header->prerequisites);
-			else
-				add_to_ref_list(&oid, p + 1, &header->references);
+			const char *string = is_prereq ? "" : p + 1;
+			struct string_list *list = is_prereq
+				? &header->prerequisites
+				: &header->references;
+			string_list_append(list, string)->util = oid;
 		}
 	}
 
@@ -139,19 +133,19 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 
 int is_bundle(const char *path, int quiet)
 {
-	struct bundle_header header;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int fd = open(path, O_RDONLY);
 
 	if (fd < 0)
 		return 0;
-	memset(&header, 0, sizeof(header));
 	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
 	if (fd >= 0)
 		close(fd);
+	bundle_header_release(&header);
 	return (fd >= 0);
 }
 
-static int list_refs(struct ref_list *r, int argc, const char **argv)
+static int list_refs(struct string_list *r, int argc, const char **argv)
 {
 	int i;
 
@@ -162,14 +156,14 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
 		if (argc > 1) {
 			int j;
 			for (j = 1; j < argc; j++)
-				if (!strcmp(r->list[i].name, argv[j]))
+				if (!strcmp(r->items[i].string, argv[j]))
 					break;
 			if (j == argc)
 				continue;
 		}
 
-		oid = &r->list[i].oid;
-		name = r->list[i].name;
+		oid = r->items[i].util;
+		name = r->items[i].string;
 		printf("%s %s\n", oid_to_hex(oid), name);
 	}
 	return 0;
@@ -186,7 +180,7 @@ int verify_bundle(struct repository *r,
 	 * Do fast check, then if any prereqs are missing then go line by line
 	 * to be verbose about the errors
 	 */
-	struct ref_list *p = &header->prerequisites;
+	struct string_list *p = &header->prerequisites;
 	struct rev_info revs;
 	const char *argv[] = {NULL, "--all", NULL};
 	struct commit *commit;
@@ -198,9 +192,9 @@ int verify_bundle(struct repository *r,
 
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
-		struct ref_list_entry *e = p->list + i;
-		const char *name = e->name;
-		struct object_id *oid = &e->oid;
+		struct string_list_item *e = p->items + i;
+		const char *name = e->string;
+		struct object_id *oid = e->util;
 		struct object *o = parse_object(r, oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
@@ -225,9 +219,9 @@ int verify_bundle(struct repository *r,
 			i--;
 
 	for (i = 0; i < p->nr; i++) {
-		struct ref_list_entry *e = p->list + i;
-		const char *name = e->name;
-		struct object_id *oid = &e->oid;
+		struct string_list_item *e = p->items + i;
+		const char *name = e->string;
+		const struct object_id *oid = e->util;
 		struct object *o = parse_object(r, oid);
 		assert(o); /* otherwise we'd have returned early */
 		if (o->flags & SHOWN)
@@ -239,15 +233,15 @@ int verify_bundle(struct repository *r,
 
 	/* Clean up objects used, as they will be reused. */
 	for (i = 0; i < p->nr; i++) {
-		struct ref_list_entry *e = p->list + i;
-		struct object_id *oid = &e->oid;
+		struct string_list_item *e = p->items + i;
+		struct object_id *oid = e->util;
 		commit = lookup_commit_reference_gently(r, oid, 1);
 		if (commit)
 			clear_commit_marks(commit, ALL_REV_FLAGS);
 	}
 
 	if (verbose) {
-		struct ref_list *r;
+		struct string_list *r;
 
 		r = &header->references;
 		printf_ln(Q_("The bundle contains this ref:",
@@ -584,3 +578,9 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		return error(_("index-pack died"));
 	return 0;
 }
+
+void bundle_header_release(struct bundle_header *header)
+{
+	string_list_clear(&header->prerequisites, 1);
+	string_list_clear(&header->references, 1);
+}
diff --git a/bundle.h b/bundle.h
index f9e2d1c8ef5..f98c1d24d9a 100644
--- a/bundle.h
+++ b/bundle.h
@@ -3,22 +3,21 @@
 
 #include "strvec.h"
 #include "cache.h"
-
-struct ref_list {
-	unsigned int nr, alloc;
-	struct ref_list_entry {
-		struct object_id oid;
-		char *name;
-	} *list;
-};
+#include "string-list.h"
 
 struct bundle_header {
 	unsigned version;
-	struct ref_list prerequisites;
-	struct ref_list references;
+	struct string_list prerequisites;
+	struct string_list references;
 	const struct git_hash_algo *hash_algo;
 };
 
+#define BUNDLE_HEADER_INIT \
+{ \
+	.prerequisites = STRING_LIST_INIT_DUP, \
+	.references = STRING_LIST_INIT_DUP, \
+}
+
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct repository *r, const char *path,
@@ -30,5 +29,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
+void bundle_header_release(struct bundle_header *header);
 
 #endif
diff --git a/transport.c b/transport.c
index 95c1138e9ae..963655c772c 100644
--- a/transport.c
+++ b/transport.c
@@ -147,14 +147,15 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	transport->hash_algo = data->header.hash_algo;
 
 	for (i = 0; i < data->header.references.nr; i++) {
-		struct ref_list_entry *e = data->header.references.list + i;
-		const char *name = e->name;
+		struct string_list_item *e = data->header.references.items + i;
+		const char *name = e->string;
 		struct ref *ref = alloc_ref(name);
-		struct object_id *oid = &e->oid;
+		struct object_id *oid = e->util;
 		oidcpy(&ref->old_oid, oid);
 		ref->next = result;
 		result = ref;
 	}
+	string_list_clear(&data->header.references, 1);
 	return result;
 }
 
@@ -177,6 +178,7 @@ static int close_bundle(struct transport *transport)
 	struct bundle_transport_data *data = transport->data;
 	if (data->fd > 0)
 		close(data->fd);
+	bundle_header_release(&data->header);
 	free(data);
 	return 0;
 }
@@ -1083,6 +1085,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
+		string_list_init(&data->header.prerequisites, 1);
+		string_list_init(&data->header.references, 1);
 		transport_check_allowed("file");
 		ret->data = data;
 		ret->vtable = &bundle_vtable;
-- 
2.32.0.599.g3967b4fa4ac

