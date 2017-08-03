Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243AD2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdHCJWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:22:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37343 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdHCJTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id t138so1419853wmt.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lxpY2pw1EowvtMKhtfcZSeBrGmWy60yvrcMt+/a5upk=;
        b=gLGeouWPRbrD/C4ZP6h9bAH4lt7ApCeZu5KEEzCSTzGuw01mSrVej4JY9c960/8/44
         zkcgFnyuYUygMY/YXtUyPDO9WnU+K8xMwkejQF/5CoGC6pQW9QuKHg9Kibh51gJM7cCD
         pU7Qothqhe695qlXKuyvlgJ4w8Px/CihEsxwzjHZF2IPnLmwjoZVORAVgEfpjpyuXlI/
         z1Zfjo+Z8iTLqo98uzQ/5GjD3Tns5XvOdGDXdc7cYe3wdhfeMiDdxV7y4TBobNPG1bNZ
         376PTwm5LkOpDOLVbtc4q3XC23enOJc4gKNr+5c1zfnI7M82tD7ZgR2FwSpncRYohdzx
         WfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lxpY2pw1EowvtMKhtfcZSeBrGmWy60yvrcMt+/a5upk=;
        b=o8trZAW2czjyfdva+uwFcjSNbV5+hM2rYguw+Q3ATcBlXxzo8MZlcGP3DiJ+5R7GQN
         mLQU/A6HiuuQUx3qzbchMgxW7HIWs3emkIZp1/0II3NEXpi/PIrjsRLAdxEGUPlon5lj
         BN/fet/fM6GjmavCQ/9nLfkqSRlewTLHQHgY56Mtsp/bEjCbmnJ9lrYcj4P0Sa+lhmqe
         aP4BSenjOSk8A53P/I/wwSjSOD7xV8TJRl/0A6kxRBGuTcAyL4HCw0QPJ56Z//sQav8M
         3w3eVwyGiVB6nfTSfCzni1Aras+7Ktw6zT8idHw8pB7QemYaPhkamGEaHyeqywukrhsM
         22qA==
X-Gm-Message-State: AIVw112+hBI9oK1SKhvBFokNq+XGig3Q04NlFHJCRHP3VPUovu0WPpZe
        4Tt8A+u9GX2kwJKy
X-Received: by 10.28.102.132 with SMTP id a126mr698596wmc.5.1501751990216;
        Thu, 03 Aug 2017 02:19:50 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 10/40] Add initial external odb support
Date:   Thu,  3 Aug 2017 11:18:56 +0200
Message-Id: <20170803091926.1755-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The external-odb.{c,h} files contains the functions that are
called by the rest of Git from "sha1_file.c".

The odb-helper.{c,h} files contains the functions to
actually implement communication with the external scripts or
processes that will manage external git objects.

For now only script mode is supported, and only the 'have' and
'get_git_obj' instructions are supported.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                |   2 +
 cache.h                 |   1 +
 external-odb.c          | 113 ++++++++++++++++++++++
 external-odb.h          |   8 ++
 odb-helper.c            | 249 ++++++++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h            |  25 +++++
 sha1_file.c             |  25 ++++-
 t/t0400-external-odb.sh |  46 +++++++++
 8 files changed, 468 insertions(+), 1 deletion(-)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100755 t/t0400-external-odb.sh

diff --git a/Makefile b/Makefile
index 461c845d33..dde4b0e868 100644
--- a/Makefile
+++ b/Makefile
@@ -783,6 +783,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += external-odb.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += gettext.o
@@ -815,6 +816,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += odb-helper.o
 LIB_OBJS += oidset.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
diff --git a/cache.h b/cache.h
index 06da3d8a3f..13694069b1 100644
--- a/cache.h
+++ b/cache.h
@@ -1553,6 +1553,7 @@ extern void read_info_alternates(const char * relative_base, int depth);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
+extern void prepare_external_alt_odb(void);
 
 /*
  * Allocate a "struct alternate_object_database" but do _not_ actually
diff --git a/external-odb.c b/external-odb.c
new file mode 100644
index 0000000000..e9c3f11666
--- /dev/null
+++ b/external-odb.c
@@ -0,0 +1,113 @@
+#include "cache.h"
+#include "external-odb.h"
+#include "odb-helper.h"
+
+static struct odb_helper *helpers;
+static struct odb_helper **helpers_tail = &helpers;
+
+static struct odb_helper *find_or_create_helper(const char *name, int len)
+{
+	struct odb_helper *o;
+
+	for (o = helpers; o; o = o->next)
+		if (!strncmp(o->name, name, len) && !o->name[len])
+			return o;
+
+	o = odb_helper_new(name, len);
+	*helpers_tail = o;
+	helpers_tail = &o->next;
+
+	return o;
+}
+
+static int external_odb_config(const char *var, const char *value, void *data)
+{
+	struct odb_helper *o;
+	const char *name;
+	int namelen;
+	const char *subkey;
+
+	if (parse_config_key(var, "odb", &name, &namelen, &subkey) < 0)
+		return 0;
+
+	o = find_or_create_helper(name, namelen);
+
+	if (!strcmp(subkey, "scriptcommand"))
+		return git_config_string(&o->cmd, var, value);
+
+	return 0;
+}
+
+static void external_odb_init(void)
+{
+	static int initialized;
+
+	if (initialized)
+		return;
+	initialized = 1;
+
+	git_config(external_odb_config, NULL);
+}
+
+const char *external_odb_root(void)
+{
+	static const char *root;
+	if (!root)
+		root = git_pathdup("objects/external");
+	return root;
+}
+
+int external_odb_has_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next)
+		if (odb_helper_has_object(o, sha1))
+			return 1;
+	return 0;
+}
+
+int external_odb_get_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+	const char *path;
+
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	path = sha1_file_name_alt(external_odb_root(), sha1);
+	safe_create_leading_directories_const(path);
+	prepare_external_alt_odb();
+
+	for (o = helpers; o; o = o->next) {
+		struct strbuf tmpfile = STRBUF_INIT;
+		int ret;
+		int fd;
+
+		if (!odb_helper_has_object(o, sha1))
+			continue;
+
+		fd = create_object_tmpfile(&tmpfile, path);
+		if (fd < 0) {
+			strbuf_release(&tmpfile);
+			return -1;
+		}
+
+		if (odb_helper_get_object(o, sha1, fd) < 0) {
+			close(fd);
+			unlink(tmpfile.buf);
+			strbuf_release(&tmpfile);
+			continue;
+		}
+
+		close_sha1_file(fd);
+		ret = finalize_object_file(tmpfile.buf, path);
+		strbuf_release(&tmpfile);
+		if (!ret)
+			return 0;
+	}
+
+	return -1;
+}
diff --git a/external-odb.h b/external-odb.h
new file mode 100644
index 0000000000..9989490c9e
--- /dev/null
+++ b/external-odb.h
@@ -0,0 +1,8 @@
+#ifndef EXTERNAL_ODB_H
+#define EXTERNAL_ODB_H
+
+const char *external_odb_root(void);
+int external_odb_has_object(const unsigned char *sha1);
+int external_odb_get_object(const unsigned char *sha1);
+
+#endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
new file mode 100644
index 0000000000..0e6f824e4a
--- /dev/null
+++ b/odb-helper.c
@@ -0,0 +1,249 @@
+#include "cache.h"
+#include "object.h"
+#include "argv-array.h"
+#include "odb-helper.h"
+#include "run-command.h"
+#include "sha1-lookup.h"
+
+struct odb_helper *odb_helper_new(const char *name, int namelen)
+{
+	struct odb_helper *o;
+
+	o = xcalloc(1, sizeof(*o));
+	o->name = xmemdupz(name, namelen);
+
+	return o;
+}
+
+struct odb_helper_cmd {
+	struct argv_array argv;
+	struct child_process child;
+};
+
+/*
+ * Callers are responsible to ensure that the result of vaddf(fmt, ap)
+ * is properly shell-quoted.
+ */
+static void prepare_helper_command(struct argv_array *argv, const char *cmd,
+				   const char *fmt, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, cmd);
+	strbuf_addch(&buf, ' ');
+	strbuf_vaddf(&buf, fmt, ap);
+
+	argv_array_push(argv, buf.buf);
+	strbuf_release(&buf);
+}
+
+__attribute__((format (printf,3,4)))
+static int odb_helper_start(struct odb_helper *o,
+			    struct odb_helper_cmd *cmd,
+			    const char *fmt, ...)
+{
+	va_list ap;
+
+	memset(cmd, 0, sizeof(*cmd));
+	argv_array_init(&cmd->argv);
+
+	if (!o->cmd)
+		return -1;
+
+	va_start(ap, fmt);
+	prepare_helper_command(&cmd->argv, o->cmd, fmt, ap);
+	va_end(ap);
+
+	cmd->child.argv = cmd->argv.argv;
+	cmd->child.use_shell = 1;
+	cmd->child.no_stdin = 1;
+	cmd->child.out = -1;
+
+	if (start_command(&cmd->child) < 0) {
+		argv_array_clear(&cmd->argv);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int odb_helper_finish(struct odb_helper *o,
+			     struct odb_helper_cmd *cmd)
+{
+	int ret = finish_command(&cmd->child);
+	argv_array_clear(&cmd->argv);
+	if (ret) {
+		warning("odb helper '%s' reported failure", o->name);
+		return -1;
+	}
+	return 0;
+}
+
+static int parse_object_line(struct odb_helper_object *o, const char *line)
+{
+	char *end;
+	if (get_sha1_hex(line, o->sha1) < 0)
+		return -1;
+
+	line += 40;
+	if (*line++ != ' ')
+		return -1;
+
+	o->size = strtoul(line, &end, 10);
+	if (line == end || *end++ != ' ')
+		return -1;
+
+	o->type = type_from_string(end);
+	return 0;
+}
+
+static int add_have_entry(struct odb_helper *o, const char *line)
+{
+	ALLOC_GROW(o->have, o->have_nr+1, o->have_alloc);
+	if (parse_object_line(&o->have[o->have_nr], line) < 0) {
+		warning("bad 'have' input from odb helper '%s': %s",
+			o->name, line);
+		return 1;
+	}
+	o->have_nr++;
+	return 0;
+}
+
+static int odb_helper_object_cmp(const void *va, const void *vb)
+{
+	const struct odb_helper_object *a = va, *b = vb;
+	return hashcmp(a->sha1, b->sha1);
+}
+
+static void odb_helper_load_have(struct odb_helper *o)
+{
+	struct odb_helper_cmd cmd;
+	FILE *fh;
+	struct strbuf line = STRBUF_INIT;
+
+	if (o->have_valid)
+		return;
+	o->have_valid = 1;
+
+	if (odb_helper_start(o, &cmd, "have") < 0)
+		return;
+
+	fh = xfdopen(cmd.child.out, "r");
+	while (strbuf_getline(&line, fh) != EOF)
+		if (add_have_entry(o, line.buf))
+			break;
+
+	strbuf_release(&line);
+	fclose(fh);
+	odb_helper_finish(o, &cmd);
+
+	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
+}
+
+static struct odb_helper_object *odb_helper_lookup(struct odb_helper *o,
+						   const unsigned char *sha1)
+{
+	int idx;
+
+	odb_helper_load_have(o);
+	idx = sha1_entry_pos(o->have, sizeof(*o->have), 0,
+			     0, o->have_nr, o->have_nr,
+			     sha1);
+	if (idx < 0)
+		return NULL;
+	return &o->have[idx];
+}
+
+int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
+{
+	return !!odb_helper_lookup(o, sha1);
+}
+
+int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
+			    int fd)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+	unsigned long total_got;
+	git_zstream stream;
+	int zret = Z_STREAM_END;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
+	git_SHA1_Init(&hash);
+	total_got = 0;
+
+	for (;;) {
+		unsigned char buf[4096];
+		int r;
+
+		r = xread(cmd.child.out, buf, sizeof(buf));
+		if (r < 0) {
+			error("unable to read from odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			git_inflate_end(&stream);
+			return -1;
+		}
+		if (r == 0)
+			break;
+
+		write_or_die(fd, buf, r);
+
+		stream.next_in = buf;
+		stream.avail_in = r;
+		do {
+			unsigned char inflated[4096];
+			unsigned long got;
+
+			stream.next_out = inflated;
+			stream.avail_out = sizeof(inflated);
+			zret = git_inflate(&stream, Z_SYNC_FLUSH);
+			got = sizeof(inflated) - stream.avail_out;
+
+			git_SHA1_Update(&hash, inflated, got);
+			/* skip header when counting size */
+			if (!total_got) {
+				const unsigned char *p = memchr(inflated, '\0', got);
+				if (p)
+					got -= p - inflated + 1;
+				else
+					got = 0;
+			}
+			total_got += got;
+		} while (stream.avail_in && zret == Z_OK);
+	}
+
+	close(cmd.child.out);
+	git_inflate_end(&stream);
+	git_SHA1_Final(real_sha1, &hash);
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+	if (zret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (total_got != obj->size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, obj->size);
+		return -1;
+	}
+	if (hashcmp(real_sha1, sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/odb-helper.h b/odb-helper.h
new file mode 100644
index 0000000000..5800661704
--- /dev/null
+++ b/odb-helper.h
@@ -0,0 +1,25 @@
+#ifndef ODB_HELPER_H
+#define ODB_HELPER_H
+
+struct odb_helper {
+	const char *name;
+	const char *cmd;
+
+	struct odb_helper_object {
+		unsigned char sha1[20];
+		unsigned long size;
+		enum object_type type;
+	} *have;
+	int have_nr;
+	int have_alloc;
+	int have_valid;
+
+	struct odb_helper *next;
+};
+
+struct odb_helper *odb_helper_new(const char *name, int namelen);
+int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
+int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
+			  int fd);
+
+#endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index d330996bc4..4bd790f6f8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -28,6 +28,7 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "external-odb.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -636,6 +637,21 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
+void prepare_external_alt_odb(void)
+{
+	static int linked_external;
+	const char *path;
+
+	if (linked_external)
+		return;
+
+	path = external_odb_root();
+	if (!access(path, F_OK)) {
+		link_alt_odb_entry(path, NULL, 0, "");
+		linked_external = 1;
+	}
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
@@ -650,6 +666,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
+	prepare_external_alt_odb();
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
@@ -690,7 +707,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 		if (check_and_freshen_file(path, freshen))
 			return 1;
 	}
-	return 0;
+	return external_odb_has_object(sha1);
 }
 
 static int check_and_freshen(const unsigned char *sha1, int freshen)
@@ -1729,6 +1746,9 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 			return 0;
 	}
 
+	if (!external_odb_get_object(sha1) && !lstat(*path, st))
+		return 0;
+
 	return -1;
 }
 
@@ -1768,6 +1788,9 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	if (fd >= 0)
 		return fd;
 
+	if (!external_odb_get_object(sha1))
+		fd = open_sha1_file_alt(sha1, path);
+
 	return fd;
 }
 
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
new file mode 100755
index 0000000000..2f4749fab1
--- /dev/null
+++ b/t/t0400-external-odb.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='basic tests for external object databases'
+
+. ./test-lib.sh
+
+ALT_SOURCE="$PWD/alt-repo/.git"
+export ALT_SOURCE
+write_script odb-helper <<\EOF
+GIT_DIR=$ALT_SOURCE; export GIT_DIR
+case "$1" in
+have)
+	git cat-file --batch-check --batch-all-objects |
+	awk '{print $1 " " $3 " " $2}'
+	;;
+get_git_obj)
+	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
+	;;
+esac
+EOF
+HELPER="\"$PWD\"/odb-helper"
+
+test_expect_success 'setup alternate repo' '
+	git init alt-repo &&
+	(cd alt-repo &&
+	 test_commit one &&
+	 test_commit two
+	) &&
+	alt_head=`cd alt-repo && git rev-parse HEAD`
+'
+
+test_expect_success 'alt objects are missing' '
+	test_must_fail git log --format=%s $alt_head
+'
+
+test_expect_success 'helper can retrieve alt objects' '
+	test_config odb.magic.scriptCommand "$HELPER" &&
+	cat >expect <<-\EOF &&
+	two
+	one
+	EOF
+	git log --format=%s $alt_head >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

