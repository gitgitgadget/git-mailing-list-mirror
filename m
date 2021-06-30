Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C0C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68AB61446
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhF3OJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhF3OIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 10:08:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D78C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a13so3783642wrf.10
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pos0WUZainsKtyfDEjCEmC8qjLvkC4PLFJVCpjGP6M=;
        b=Mt/lrMO1FZpNqjCHADGPwI6+ODjyxTlCHxk8+1wawZgJrDecaLjYdlvZ6Y0bljRTEW
         oZaj0x8Z9rAgXxR1sNzZQgpENp34rKx9MA0RarkxmLakle4o5v7BGt8RPmQ+Yz1BcHx7
         nsJCWBAP68bYpnY1H2Pp38xAmaVGS/SXq2FkRjKb19dILpxvbjhRsQ/iL+0ICD6XFpdI
         lVPzAewVyIXOMiJiRnXrg0EG6O4HWmDl0B0uJDewNnxV3oLhmWeq0yWqJM5CxfOSC2bm
         BeDLSVic3juaDwIBX9IsZ38CTSqqpg8CZ2fBUfqbhJz3eplZccllsBRzuoyjLnlEZl1H
         Mbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pos0WUZainsKtyfDEjCEmC8qjLvkC4PLFJVCpjGP6M=;
        b=iXklt4DauHEvfI860BnM57wb4jui5tlVy+nM/P1l/a2C9R7qIMca6vs/Q9TocszNPo
         67wnayhYaYgAWUfAxgGiPvHpLwiBJQ1SRs8/ieZTCl15zWTisvudPbXW0wmb+FOg1nO7
         HbcoQXCU0d+IJFhhwzoOPWJy2PFk1uMd9Lq8DeNY6zhC0gCjuClBLmlFT8QdLIqaDMD7
         FwkSv0iWQr8efIR1As9RL/u41rGc24aBij3Dhls1nEb4zPpGfX/o1AlxxiJPnPQ4unGB
         9Yhenr7X2WVVJlUz5h3jAMPpjXIW9Ugj5AAyEvBHnOTAsMC+zQC+So90kg5GEfbtXaxS
         2FVQ==
X-Gm-Message-State: AOAM531ef/YC9lwH4CU0jcokB0B7df2v3HgXm/er799pXh1vLzLBI+LD
        9sqQ+Ly0IsLi3H+VLy69bFuogArWQKWddA==
X-Google-Smtp-Source: ABdhPJyqNEeVymcM4dqPAjwsBn8gp2QVF97G/8xbr3yHNemat5XExtVuWA0OhjkvU5VSznxIKupprQ==
X-Received: by 2002:a5d:614d:: with SMTP id y13mr6060460wrt.403.1625061982008;
        Wed, 30 Jun 2021 07:06:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b20sm4763814wmj.7.2021.06.30.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:06:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] bundle: remove "ref_list" in favor of string-list.c API
Date:   Wed, 30 Jun 2021 16:06:16 +0200
Message-Id: <patch-3.3-f1066ee1b9a-20210630T140339Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com> <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
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
 builtin/bundle.c | 12 +++++------
 bundle.c         | 53 ++++++++++++++++++++++++++----------------------
 bundle.h         | 21 ++++++++++---------
 transport.c      |  8 +++++---
 4 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 15e2bd61965..053a51bea1b 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -100,7 +100,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 }
 
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
-	struct bundle_header header;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int quiet = 0;
 	int ret;
@@ -115,7 +115,6 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	memset(&header, 0, sizeof(header));
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
 		ret = 1;
 		goto cleanup;
@@ -130,11 +129,12 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
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
@@ -146,7 +146,6 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 			builtin_bundle_list_heads_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	memset(&header, 0, sizeof(header));
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
 		ret = 1;
 		goto cleanup;
@@ -155,11 +154,12 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
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
 	int ret;
 	struct option options[] = {
@@ -171,7 +171,6 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 			builtin_bundle_unbundle_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	memset(&header, 0, sizeof(header));
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
 		ret = 1;
 		goto cleanup;
@@ -180,6 +179,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		die(_("Need a repository to unbundle."));
 	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
 		list_bundle_refs(&header, argc, argv);
+	bundle_header_release(&header);
 cleanup:
 	free(bundle_file);
 	return ret;
diff --git a/bundle.c b/bundle.c
index 7210e5e7105..cd5356a66f3 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,13 +23,17 @@ static struct {
 	{ 3, v3_bundle_signature },
 };
 
-static void add_to_ref_list(const struct object_id *oid, const char *name,
-		struct ref_list *list)
+void bundle_header_init(struct bundle_header *header)
 {
-	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
-	oidcpy(&list->list[list->nr].oid, oid);
-	list->list[list->nr].name = xstrdup(name);
-	list->nr++;
+	memset(header, 0, sizeof(*header));
+	string_list_init(&header->prerequisites, 1);
+	string_list_init(&header->references, 1);
+}
+
+void bundle_header_release(struct bundle_header *header)
+{
+	string_list_clear(&header->prerequisites, 1);
+	string_list_clear(&header->references, 1);
 }
 
 static int parse_capability(struct bundle_header *header, const char *capability)
@@ -112,10 +116,11 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 			status = -1;
 			break;
 		} else {
+			struct object_id *dup = oiddup(&oid);
 			if (is_prereq)
-				add_to_ref_list(&oid, "", &header->prerequisites);
+				string_list_append(&header->prerequisites, "")->util = dup;
 			else
-				add_to_ref_list(&oid, p + 1, &header->references);
+				string_list_append(&header->references, p + 1)->util = dup;
 		}
 	}
 
@@ -139,19 +144,19 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 
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
 
@@ -162,14 +167,14 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
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
@@ -186,7 +191,7 @@ int verify_bundle(struct repository *r,
 	 * Do fast check, then if any prereqs are missing then go line by line
 	 * to be verbose about the errors
 	 */
-	struct ref_list *p = &header->prerequisites;
+	struct string_list *p = &header->prerequisites;
 	struct rev_info revs;
 	const char *argv[] = {NULL, "--all", NULL};
 	struct commit *commit;
@@ -198,9 +203,9 @@ int verify_bundle(struct repository *r,
 
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
@@ -225,9 +230,9 @@ int verify_bundle(struct repository *r,
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
@@ -239,15 +244,15 @@ int verify_bundle(struct repository *r,
 
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
diff --git a/bundle.h b/bundle.h
index f9e2d1c8ef5..1927d8cd6a4 100644
--- a/bundle.h
+++ b/bundle.h
@@ -3,22 +3,23 @@
 
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
+void bundle_header_init(struct bundle_header *header);
+void bundle_header_release(struct bundle_header *header);
+
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct repository *r, const char *path,
diff --git a/transport.c b/transport.c
index 95c1138e9ae..745ffa22474 100644
--- a/transport.c
+++ b/transport.c
@@ -147,10 +147,10 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
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
@@ -177,6 +177,7 @@ static int close_bundle(struct transport *transport)
 	struct bundle_transport_data *data = transport->data;
 	if (data->fd > 0)
 		close(data->fd);
+	bundle_header_release(&data->header);
 	free(data);
 	return 0;
 }
@@ -1083,6 +1084,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
+		bundle_header_init(&data->header);
 		transport_check_allowed("file");
 		ret->data = data;
 		ret->vtable = &bundle_vtable;
-- 
2.32.0.613.g8e17abc2eb

