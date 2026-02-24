Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5351494C3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916812; cv=pass; b=Kzz6I51TCktQG3Fo6REyiU8a+CTfGd+cgS/zPCI9jUTOTc8mb6591xCoXRLg8ANUkVVnirfFF/79Xdus1gk7G638C5BNIDBFz/HT7p9xOuWwgFv1xjc+dIAFTyeG+zar4DUcWsdnKauzDjuz5w7V7K4UeaAR0thnRTSslZ6d6b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916812; c=relaxed/simple;
	bh=uKN7dP/hg9HbkmqaoJbBp8VFVJuIojOC3LUmAN5LnFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrRtmXJZkWJ2Ek9jwPugkO0wcFDg3h0lrWviCuC31q18HrFkRukBEcBv7JmJPiUI9xklscQpIuY80WG3O6C82UC41ZjEx5ZVXTdw12FyFcoTnrFkYLupH+KROi0chTBfBBsuvhC4vhtoVmut3Q5lgS8pr6cCu8+8otFX7b5neHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=FUwqssgO; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="FUwqssgO"
ARC-Seal: i=1; a=rsa-sha256; t=1771916775; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lYxZuPFINtbxBbasyCFKaYsd5ar0SHr68DidoOoL5fXOSEnjSdCOBUloUb3difP5xk0q1xnE/qMh+upiHxf5FASXc3zfm2aRtCHm3PNUM/2SnPbVYS5oEg8k1cLlqaSCBRFNtypAeJl5qg/k4v29SgtWghOo3EnsnBJBOxEIMBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771916775; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WUr7LRJjgMIvu7r2ezqNe/DPnMdEEhtZBM6ysawg3ik=; 
	b=E3PYL60M/2dTxIcIxp7mo4NE0LH4BZo2umY1e8sSfmIwKhsXtpsBfH8Hzfl7DX+fkQ0Oo4OHGlOaIOsiKjwYc7ChHAirvH9I6/VBHghRH/9oaN+lzxfmXxKJ6dpZHVF2rF1S9uUGNckGzuwtELthy+c2usa8NeS1beAxLn4hw60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771916775;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WUr7LRJjgMIvu7r2ezqNe/DPnMdEEhtZBM6ysawg3ik=;
	b=FUwqssgOaUUud63ldSf2cnTh0RcAyXjMyht39Fwu1Ty+lSgOzzLHeC1OH6CorNmj
	AUs3LhVDX/XN7OiAZpgnYLOlhbQ7/egff+3ElQSTxfczIWjxwt4d3Vel09Ui0U0xcis
	CUS/w9uzz8PaQSrvU/5kfJZqknCO26TbMoSQfp3c=
Received: by mx.zohomail.com with SMTPS id 1771916772311590.2880366382045;
	Mon, 23 Feb 2026 23:06:12 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v7 3/5] trailer: append trailers without fork/exec
Date: Tue, 24 Feb 2026 15:05:49 +0800
Message-ID: <20260224070552.148591-4-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224070552.148591-1-me@linux.beauty>
References: <20260224070552.148591-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Introduce amend_strbuf_with_trailers() to apply trailer additions to a
message buffer via process_trailers(), avoiding the need to run git
interpret-trailers as a child process.

Update amend_file_with_trailers() to use the in-process helper and
rewrite the target file via tempfile+rename, preserving the previous
in-place semantics.

Keep existing callers unchanged by continuing to accept argv-style
--trailer=<trailer> entries and stripping the prefix before feeding the
in-process implementation.

Signed-off-by: Li Chen <me@linux.beauty>
---
v7:
Drop wrapper.c/h and validate trailer args via validate_trailer_args().
Rewrite the target file via tempfile+rename to preserve --in-place semantics.

 builtin/interpret-trailers.c |   4 +-
 trailer.c                    | 162 +++++++++++++++++++++++++++++++++--
 trailer.h                    |  27 +++++-
 3 files changed, 179 insertions(+), 14 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 1354109e0f..d4aff68746 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -144,8 +144,6 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	struct strbuf out = STRBUF_INIT;
 	FILE *outfile = stdout;
 
-	trailer_config_init();
-
 	read_input_file(&input, file);
 
 	if (opts->in_place)
@@ -203,6 +201,8 @@ int cmd_interpret_trailers(int argc,
 			git_interpret_trailers_usage,
 			options);
 
+	trailer_config_init();
+
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
diff --git a/trailer.c b/trailer.c
index 0c9200506d..8e87d185d9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -7,8 +7,11 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
+#include "strvec.h"
+#include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
+
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -772,6 +775,30 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
+void validate_trailer_args(const struct strvec *cli_args)
+{
+	char *cl_separators;
+
+	trailer_config_init();
+
+	cl_separators = xstrfmt("=%s", separators);
+
+	for (size_t i = 0; i < cli_args->nr; i++) {
+		const char *txt = cli_args->v[i];
+		ssize_t separator_pos;
+
+		if (!*txt)
+			die(_("empty --trailer argument"));
+
+		separator_pos = find_separator(txt, cl_separators);
+		if (separator_pos == 0)
+			die(_("invalid trailer '%s': missing key before separator"),
+			    txt);
+	}
+
+	free(cl_separators);
+}
+
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1224,16 +1251,133 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
+static void new_trailer_items_clear(struct list_head *items)
+{
+	while (!list_empty(items)) {
+		struct new_trailer_item *item =
+			list_first_entry(items, struct new_trailer_item, list);
+		list_del(&item->list);
+		free(item);
+	}
+}
+
+void amend_strbuf_with_trailers(struct strbuf *buf,
+				const struct strvec *trailer_args)
+{
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
+			die(_("empty --trailer argument"));
+		item = xcalloc(1, sizeof(*item));
+		item->text = text;
+		list_add_tail(&item->list, &new_trailer_head);
+	}
+
+	trailer_config_init();
+	process_trailers(&opts, &new_trailer_head, buf, &out);
+
+	strbuf_swap(buf, &out);
+	strbuf_release(&out);
+
+	new_trailer_items_clear(&new_trailer_head);
+}
+
+static int write_file_in_place(const char *path, const struct strbuf *buf)
+{
+	struct stat st;
+	struct strbuf filename_template = STRBUF_INIT;
+	const char *tail;
+	struct tempfile *tempfile;
+	FILE *outfile;
+
+	if (stat(path, &st))
+		return error_errno(_("could not stat %s"), path);
+	if (!S_ISREG(st.st_mode))
+		return error(_("file %s is not a regular file"), path);
+	if (!(st.st_mode & S_IWUSR))
+		return error(_("file %s is not writable by user"), path);
+
+	/* Create temporary file in the same directory as the original */
+	tail = strrchr(path, '/');
+	if (tail)
+		strbuf_add(&filename_template, path, tail - path + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
+
+	tempfile = mks_tempfile_sm(filename_template.buf, 0, st.st_mode);
+	strbuf_release(&filename_template);
+	if (!tempfile)
+		return error_errno(_("could not create temporary file"));
+
+	outfile = fdopen_tempfile(tempfile, "w");
+	if (!outfile) {
+		int saved_errno = errno;
+		delete_tempfile(&tempfile);
+		errno = saved_errno;
+		return error_errno(_("could not open temporary file"));
+	}
+
+	if (buf->len && fwrite(buf->buf, 1, buf->len, outfile) < buf->len) {
+		int saved_errno = errno;
+		delete_tempfile(&tempfile);
+		errno = saved_errno;
+		return error_errno(_("could not write to temporary file"));
+	}
+
+	if (rename_tempfile(&tempfile, path))
+		return error_errno(_("could not rename temporary file to %s"), path);
+
+	return 0;
+}
+
+int amend_file_with_trailers(const char *path,
+			     const struct strvec *trailer_args)
 {
-	struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-	run_trailer.git_cmd = 1;
-	strvec_pushl(&run_trailer.args, "interpret-trailers",
-		     "--in-place", "--no-divider",
-		     path, NULL);
-	strvec_pushv(&run_trailer.args, trailer_args->v);
-	return run_command(&run_trailer);
+	struct strbuf buf = STRBUF_INIT;
+	struct strvec stripped_trailer_args = STRVEC_INIT;
+	int ret = 0;
+	size_t i;
+
+	if (!trailer_args)
+		BUG("amend_file_with_trailers called with NULL trailer_args");
+	if (!trailer_args->nr)
+		return 0;
+
+	for (i = 0; i < trailer_args->nr; i++) {
+		const char *txt = trailer_args->v[i];
+
+		/*
+		 * Historically amend_file_with_trailers() passed its arguments
+		 * to "git interpret-trailers", which expected argv entries in
+		 * "--trailer=<trailer>" form. Continue to accept those for
+		 * existing callers, but pass only the value portion to the
+		 * in-process implementation.
+		 */
+		skip_prefix(txt, "--trailer=", &txt);
+		if (!*txt)
+			die(_("empty --trailer argument"));
+		strvec_push(&stripped_trailer_args, txt);
+	}
+
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		ret = error_errno(_("could not read '%s'"), path);
+	else
+		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
+
+	if (!ret)
+		ret = write_file_in_place(path, &buf);
+
+	strvec_clear(&stripped_trailer_args);
+	strbuf_release(&buf);
+	return ret;
 }
 
 void process_trailers(const struct process_trailer_options *opts,
diff --git a/trailer.h b/trailer.h
index 531fa1a13f..d05dab050b 100644
--- a/trailer.h
+++ b/trailer.h
@@ -68,6 +68,8 @@ void parse_trailers_from_config(struct list_head *config_head);
 void parse_trailers_from_command_line_args(struct list_head *arg_head,
 					   struct list_head *new_trailer_head);
 
+void validate_trailer_args(const struct strvec *cli_args);
+
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
@@ -196,12 +198,31 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
 void trailer_iterator_release(struct trailer_iterator *iter);
 
 /*
- * Augment a file to add trailers to it by running git-interpret-trailers.
- * This calls run_command() and its return value is the same (i.e. 0 for
- * success, various non-zero for other errors). See run-command.h.
+ * Append trailers specified in trailer_args to buf in-place.
+ *
+ * Each element of trailer_args should be in the same format as the value
+ * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
+ */
+void amend_strbuf_with_trailers(struct strbuf *buf,
+				const struct strvec *trailer_args);
+
+/*
+ * Augment a file by appending trailers specified in trailer_args.
+ *
+ * Each element of trailer_args should be an argv-style --trailer=<trailer>
+ * option (i.e., including the --trailer= prefix).
+ *
+ * Returns 0 on success or a non-zero error code on failure.
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
+/*
+ * Rewrite the contents of input by processing its trailer block according to
+ * opts and (optionally) appending trailers from new_trailer_head.
+ *
+ * The rewritten message is appended to out (callers should strbuf_reset()
+ * first if needed).
+ */
 void process_trailers(const struct process_trailer_options *opts,
 		      struct list_head *new_trailer_head,
 		      struct strbuf *input, struct strbuf *out);
-- 
2.52.0
