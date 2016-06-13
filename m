From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 1/8] Add initial external odb support
Date: Mon, 13 Jun 2016 10:55:39 +0200
Message-ID: <20160613085546.11784-2-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfT-0007BL-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbcFMI4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33018 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161119AbcFMI4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so13086695wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6XWPQTCFd42KkeVSsZgTY9EudZAocyJVGC3Ot4+daxI=;
        b=XLuXErF9+kwvPKNNKt2JRpz7+KHe5PDETYzrq9+PzFeVc1zd8tfhxlr/yEqWLWWKPa
         F3ohKkCrh17+wMMvtaa0kydd/+J4FEquMEbCPA9iqBox7trJM4HwY1S8HuHdoR1f1x1y
         XKbzOMP+FEWhPdm+cQlPwjDEW8+oxh1nKA44EB7Kt1GYqAPEqDK5sQo4pl4uAjnhcG1p
         hhmGZmfLcXxAhXbbhNrPuJgZv1H9iKtbLwpk1hrm/8aH/g8jAbwl42/neh0sKkQRom85
         tng+oZ/I++pkpRexmvFTu8nws2D3ijt/jhWKyUBwxfzamQUN4w93zNXUj4TBlb6aOmfB
         bIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6XWPQTCFd42KkeVSsZgTY9EudZAocyJVGC3Ot4+daxI=;
        b=ESTXuhdq6/dmoSMpVu4Exvhh5OwAQyViT/H6bBVv98UutnkJm6PEUNlqIl183aGgxP
         qclhAYdXa1CFLn7AYF/s+BtJ/PwWXGewcFj130sygyXMS6ECxpVd5r4Q0gVOBDWHtujD
         gO2Wo85/ywMfTmeYQM7Y5TTcl0jVT9YbyueXn6OaPtb638lSEY/x6OGunUi87isEa7u5
         qB1JWA4nKOkibR8+B7PbKvVw7Pyf+j29m4pT47COaPyDvY86xyy+yigYMhHKsrdz0F0b
         ypPDUDhCW9RKZt7fINDRwY+GN9Z05MRF75cvq4YnspSk0hsjvNHXywnofKk+D6tIS5uM
         vBJA==
X-Gm-Message-State: ALyK8tLhAnp8m4ByIdVuXDQlYcAfd9lihsilRvpsYimAvWx3BHNc164iUWaUYROGbwuc9g==
X-Received: by 10.194.176.132 with SMTP id ci4mr12937035wjc.138.1465808164698;
        Mon, 13 Jun 2016 01:56:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297167>

From: Jeff King <peff@peff.net>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                |   2 +
 cache.h                 |   9 ++
 external-odb.c          | 115 +++++++++++++++++++++++
 external-odb.h          |   8 ++
 odb-helper.c            | 239 ++++++++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h            |  25 +++++
 sha1_file.c             |  64 ++++++++++---
 t/t0400-external-odb.sh |  48 ++++++++++
 8 files changed, 495 insertions(+), 15 deletions(-)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100755 t/t0400-external-odb.sh

diff --git a/Makefile b/Makefile
index de5a030..8641318 100644
--- a/Makefile
+++ b/Makefile
@@ -726,6 +726,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += external-odb.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += gettext.o
@@ -757,6 +758,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += odb-helper.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
diff --git a/cache.h b/cache.h
index 6049f86..cc0a934 100644
--- a/cache.h
+++ b/cache.h
@@ -864,6 +864,12 @@ const char *git_path_shallow(void);
  */
 extern const char *sha1_file_name(const unsigned char *sha1);
 
+/*
+ * Like sha1_file_name, but return the filename within a specific alternate
+ * object directory. Shares the same static buffer with sha1_file_name.
+ */
+extern const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1);
+
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
@@ -1093,6 +1099,8 @@ extern int do_check_packed_object_crc;
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
+extern int create_object_tmpfile(struct strbuf *tmp, const char *filename);
+extern void close_sha1_file(int fd);
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
@@ -1338,6 +1346,7 @@ extern void read_info_alternates(const char * relative_base, int depth);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
+extern void prepare_external_alt_odb(void);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/external-odb.c b/external-odb.c
new file mode 100644
index 0000000..1ccfa99
--- /dev/null
+++ b/external-odb.c
@@ -0,0 +1,115 @@
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
+	const char *key, *dot;
+
+	if (!skip_prefix(var, "odb.", &key))
+		return 0;
+	dot = strrchr(key, '.');
+	if (!dot)
+		return 0;
+
+	o = find_or_create_helper(key, dot - key);
+	key = dot + 1;
+
+	if (!strcmp(key, "command"))
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
+int external_odb_fetch_object(const unsigned char *sha1)
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
+		if (odb_helper_fetch_object(o, sha1, fd) < 0) {
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
index 0000000..2397477
--- /dev/null
+++ b/external-odb.h
@@ -0,0 +1,8 @@
+#ifndef EXTERNAL_ODB_H
+#define EXTERNAL_ODB_H
+
+const char *external_odb_root(void);
+int external_odb_has_object(const unsigned char *sha1);
+int external_odb_fetch_object(const unsigned char *sha1);
+
+#endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
new file mode 100644
index 0000000..7029a59
--- /dev/null
+++ b/odb-helper.c
@@ -0,0 +1,239 @@
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
+	while (strbuf_getline(&line, fh) != EOF) {
+		ALLOC_GROW(o->have, o->have_nr+1, o->have_alloc);
+		if (parse_object_line(&o->have[o->have_nr], line.buf) < 0) {
+			warning("bad 'have' input from odb helper '%s': %s",
+				o->name, line.buf);
+			break;
+		}
+		o->have_nr++;
+	}
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
+int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
+			    int fd)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+	unsigned long total_got;
+	git_zstream stream;
+	int zret;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, "get %s", sha1_to_hex(sha1)) < 0)
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
index 0000000..0f704f9
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
+int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
+			    int fd);
+
+#endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..a707bc1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "bulk-checkin.h"
 #include "streaming.h"
 #include "dir.h"
+#include "external-odb.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -183,13 +184,11 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1)
 {
 	static char buf[PATH_MAX];
-	const char *objdir;
 	int len;
 
-	objdir = get_object_directory();
 	len = strlen(objdir);
 
 	/* '/' + sha1(2) + '/' + sha1(38) + '\0' */
@@ -203,6 +202,11 @@ const char *sha1_file_name(const unsigned char *sha1)
 	return buf;
 }
 
+const char *sha1_file_name(const unsigned char *sha1)
+{
+	return sha1_file_name_alt(get_object_directory(), sha1);
+}
+
 /*
  * Return the name of the pack or index file with the specified sha1
  * in its filename.  *base and *name are scratch space that must be
@@ -439,6 +443,21 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
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
@@ -453,6 +472,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
+	prepare_external_alt_odb();
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
@@ -493,7 +513,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 		if (check_and_freshen_file(alt->base, freshen))
 			return 1;
 	}
-	return 0;
+	return external_odb_has_object(sha1);
 }
 
 static int check_and_freshen(const unsigned char *sha1, int freshen)
@@ -1523,19 +1543,15 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
 	return -1;
 }
 
-static int open_sha1_file(const unsigned char *sha1)
+static int open_sha1_file_alt(const unsigned char *sha1)
 {
-	int fd;
 	struct alternate_object_database *alt;
-	int most_interesting_errno;
-
-	fd = git_open_noatime(sha1_file_name(sha1));
-	if (fd >= 0)
-		return fd;
-	most_interesting_errno = errno;
+	int most_interesting_errno = errno;
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
+		int fd;
+
 		fill_sha1_path(alt->name, sha1);
 		fd = git_open_noatime(alt->base);
 		if (fd >= 0)
@@ -1547,6 +1563,24 @@ static int open_sha1_file(const unsigned char *sha1)
 	return -1;
 }
 
+static int open_sha1_file(const unsigned char *sha1)
+{
+	int fd;
+
+	fd = git_open_noatime(sha1_file_name(sha1));
+	if (fd >= 0)
+		return fd;
+
+	fd = open_sha1_file_alt(sha1);
+	if (fd >= 0)
+		return fd;
+
+	if (!external_odb_fetch_object(sha1))
+		fd = open_sha1_file_alt(sha1);
+
+	return fd;
+}
+
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
@@ -3011,7 +3045,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_sha1_file(int fd)
+void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
@@ -3035,7 +3069,7 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+int create_object_tmpfile(struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -3075,7 +3109,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	const char *filename = sha1_file_name(sha1);
 
-	fd = create_tmpfile(&tmp_file, filename);
+	fd = create_object_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
new file mode 100755
index 0000000..2b01617
--- /dev/null
+++ b/t/t0400-external-odb.sh
@@ -0,0 +1,48 @@
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
+	git rev-list --all --objects |
+	cut -d' ' -f1 |
+	git cat-file --batch-check |
+	awk '{print $1 " " $3 " " $2}'
+	;;
+get)
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
+	test_config odb.magic.command "$HELPER" &&
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
2.9.0.rc2.362.g3cd93d0
