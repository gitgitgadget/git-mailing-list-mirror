Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A01EA84
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353046; cv=pass; b=ZdyDqtsYU8qgqprA1n0iwjuNJAL/7J69rkMW3Qk+dsTeWNRU2zMVCKjNKjj+O/wnvIMPXNES6iWl9iJ7Wkk7Tzc6ENm66ZWdIZbCCa++b+X98QOrL1+Acb+hYUQMJh0+EzMvY2FqwN9JAx665OSKeKYhsHSUy18oeTD5mUM5orI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353046; c=relaxed/simple;
	bh=h09bzYJ9VKsI7eMwVyfdnwO42YAr292CqJt98B3nVbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLv3rZXw46RPSw3YEU7lhst8GUztlwmJeLzUtw4jnxAKdYhxBdaow+e3qEbbdsSOjpTzMGcg7uphSvGvcJnPkifjgcueOE4iiNsMB4YFEZa9KHI9v0AeKkxHBsHQQsyBKNDJV/qP+dTrd/fifAQWgYpRvnTUNX3EYlnwuwIEHIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=TC/j8x3D; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="TC/j8x3D"
ARC-Seal: i=1; a=rsa-sha256; t=1762353004; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SFSOcNH+ZXEEmE5LBhtVdQrcw8A4MVjDMqFcISN3Ps9LoljQjRQglrBllwD/666WVdHCDFyeHa9iyOvSsfstkbhMFcrHQxPfFbJDIECE+N9K+A6ilnbXySK/nh3pJto4WI1RfA4nhWSZcXJ1p/YYpkOJ33ILLP+uEJEEdBPoKCA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762353004; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=RrdQZyDh1+CxHJmkfPUrRyQlYb5tqSpPvNMG6t2azJM=; 
	b=NBLY66Ak1KHvIhORpLNo03QCySlzwoC1HWRQpUlpvd4vGDBBoYMit4+mM70rQchhyitosRJVIQeGUGVnt4pfqZs9AHs4nk486L0ee2XE4HhFcSdwaSreCgH8giNZm/MMAU3YOVYxxqswf4NA8LNJ3nrZcl1ztwtNQT97C1nvH8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762353004;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=RrdQZyDh1+CxHJmkfPUrRyQlYb5tqSpPvNMG6t2azJM=;
	b=TC/j8x3Dmzrv7wugKYyUG9ysQgpAgjAH9dmv2Sdb9CVetVfWVzuBce/CG/ifI0x7
	HkK360u/DpwBCDreOu24Y/yOBe4NKucJfLgPPy4/OUnkzqefal4BPAzpzvm8A3GnD+n
	wAk62Cnk3GGaR6mKMBlxRLlFsokCD21wZ5WWqBYI=
Received: by mx.zohomail.com with SMTPS id 1762353001897433.8034774692761;
	Wed, 5 Nov 2025 06:30:01 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 3/4] trailer: append trailers in-process and drop the fork to `interpret-trailers`
Date: Wed,  5 Nov 2025 22:29:43 +0800
Message-ID: <20251105142944.73061-4-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105142944.73061-1-me@linux.beauty>
References: <20251105142944.73061-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Route all trailer insertion through trailer_process() and make
builtin/interpret-trailers just do file I/O before calling into it.
amend_file_with_trailers() now shares the same code path.

This removes the fork/exec and tempfile juggling, cutting overhead and
simplifying error handling. No functional change. It also
centralizes logic to prepare for follow-up rebase --trailer patch.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/commit.c             |  2 +-
 builtin/interpret-trailers.c | 46 +++---------------------
 builtin/tag.c                |  3 +-
 trailer.c                    | 68 +++++++++++++++++++++++++++++++-----
 trailer.h                    |  5 ++-
 wrapper.c                    | 16 +++++++++
 wrapper.h                    |  6 ++++
 7 files changed, 90 insertions(+), 56 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..67070d6a54 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1719,7 +1719,7 @@ int cmd_commit(int argc,
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index bce2e791d6..268a43372b 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -10,7 +10,6 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
-#include "tempfile.h"
 #include "trailer.h"
 #include "config.h"
 
@@ -93,37 +92,6 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static struct tempfile *trailers_tempfile;
-
-static FILE *create_in_place_tempfile(const char *file)
-{
-	struct stat st;
-	struct strbuf filename_template = STRBUF_INIT;
-	const char *tail;
-	FILE *outfile;
-
-	if (stat(file, &st))
-		die_errno(_("could not stat %s"), file);
-	if (!S_ISREG(st.st_mode))
-		die(_("file %s is not a regular file"), file);
-	if (!(st.st_mode & S_IWUSR))
-		die(_("file %s is not writable by user"), file);
-
-	/* Create temporary file in the same directory as the original */
-	tail = strrchr(file, '/');
-	if (tail)
-		strbuf_add(&filename_template, file, tail - file + 1);
-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
-
-	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
-	strbuf_release(&filename_template);
-	outfile = fdopen_tempfile(trailers_tempfile, "w");
-	if (!outfile)
-		die_errno(_("could not open temporary file"));
-
-	return outfile;
-}
-
 static void read_input_file(struct strbuf *sb, const char *file)
 {
 	if (file) {
@@ -142,21 +110,15 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf out = STRBUF_INIT;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
 
 	read_input_file(&sb, file);
 
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
 	process_trailers(opts, new_trailer_head, &sb, &out);
 
-	fwrite(out.buf, out.len, 1, outfile);
 	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
-			die_errno(_("could not rename temporary file to %s"), file);
+		write_file_buf(file, out.buf, out.len);
+	else
+		strbuf_write(&out, stdout);
 
 	strbuf_release(&sb);
 	strbuf_release(&out);
@@ -203,6 +165,8 @@ int cmd_interpret_trailers(int argc,
 			git_interpret_trailers_usage,
 			options);
 
+	trailer_config_init();
+
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
diff --git a/builtin/tag.c b/builtin/tag.c
index f0665af3ac..65c4a0b36b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -499,8 +499,7 @@ int cmd_tag(int argc,
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
-				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/trailer.c b/trailer.c
index b735ec8a53..f5838f5699 100644
--- a/trailer.c
+++ b/trailer.c
@@ -9,6 +9,8 @@
 #include "commit.h"
 #include "trailer.h"
 #include "list.h"
+#include "wrapper.h"
+
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -1224,18 +1226,66 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
+static int amend_strbuf_with_trailers(struct strbuf *buf,
+				      const struct strvec *trailer_args)
 {
-	struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-	run_trailer.git_cmd = 1;
-	strvec_pushl(&run_trailer.args, "interpret-trailers",
-		     "--in-place", "--no-divider",
-		     path, NULL);
-	strvec_pushv(&run_trailer.args, trailer_args->v);
-	return run_command(&run_trailer);
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	LIST_HEAD(new_trailer_head);
+	struct strbuf out = STRBUF_INIT;
+	size_t i;
+
+	opts.no_divider = 1;
+
+	for (i = 0; i < trailer_args->nr; i++) {
+		const char *text = trailer_args->v[i];
+		struct new_trailer_item *item;
+
+		if (!*text)
+			continue;
+		item = xcalloc(1, sizeof(*item));
+		INIT_LIST_HEAD(&item->list);
+		item->text = text;
+		list_add_tail(&item->list, &new_trailer_head);
+	}
+
+	process_trailers(&opts, &new_trailer_head, buf, &out);
+
+	strbuf_swap(buf, &out);
+	strbuf_release(&out);
+	while (!list_empty(&new_trailer_head)) {
+		struct new_trailer_item *item =
+			list_first_entry(&new_trailer_head, struct new_trailer_item, list);
+		list_del(&item->list);
+		free(item);
+	}
+	return 0;
 }
 
+int amend_file_with_trailers(const char *path,
+			     const struct strvec *trailer_args)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!trailer_args || !trailer_args->nr)
+		return 0;
+
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		return error_errno("could not read '%s'", path);
+
+	if (amend_strbuf_with_trailers(&buf, trailer_args)) {
+		strbuf_release(&buf);
+		return error("failed to append trailers");
+	}
+
+	if (write_file_buf_gently(path, buf.buf, buf.len)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_release(&buf);
+	return 0;
+ }
+
 void process_trailers(const struct process_trailer_options *opts,
 		      struct list_head *new_trailer_head,
 		      struct strbuf *sb, struct strbuf *out)
diff --git a/trailer.h b/trailer.h
index 44d406b763..daea46ca5d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -196,9 +196,8 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
 void trailer_iterator_release(struct trailer_iterator *iter);
 
 /*
- * Augment a file to add trailers to it by running git-interpret-trailers.
- * This calls run_command() and its return value is the same (i.e. 0 for
- * success, various non-zero for other errors). See run-command.h.
+ * Augment a file to add trailers to it (similar to 'git interpret-trailers').
+ * Returns 0 on success or a non-zero error code on failure.
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
diff --git a/wrapper.c b/wrapper.c
index 3d507d4204..1f12dbb2fa 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -688,6 +688,22 @@ void write_file_buf(const char *path, const char *buf, size_t len)
 		die_errno(_("could not close '%s'"), path);
 }
 
+int write_file_buf_gently(const char *path, const char *buf, size_t len)
+{
+	int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+
+	if (fd < 0)
+		return error_errno(_("could not open '%s'"), path);
+	if (write_in_full(fd, buf, len) < 0) {
+		int ret = error_errno(_("could not write to '%s'"), path);
+		close(fd);
+		return ret;
+	}
+	if (close(fd))
+		return error_errno(_("could not close '%s'"), path);
+	return 0;
+}
+
 void write_file(const char *path, const char *fmt, ...)
 {
 	va_list params;
diff --git a/wrapper.h b/wrapper.h
index 44a8597ac3..e5f867b200 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -56,6 +56,12 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
  */
 void write_file_buf(const char *path, const char *buf, size_t len);
 
+/**
+ * Like write_file_buf(), but report errors instead of exiting. Returns 0 on
+ * success or a negative value on error after emitting a message.
+ */
+int write_file_buf_gently(const char *path, const char *buf, size_t len);
+
 /**
  * Like write_file_buf(), but format the contents into a buffer first.
  * Additionally, write_file() will append a newline if one is not already
-- 
2.51.0

