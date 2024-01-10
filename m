Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDA24A14
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVWeVRTS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e4f71288bso15864825e9.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869489; x=1705474289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDu0A81Wnf88vB97RoIFzf86XD+FgkHNeSEcwAyLyvM=;
        b=XVWeVRTSqbtxd6m5VM8EHib6YVz87nmRMDC0yDo8VbF0Tzy3Vn9G9679gVYTF41fCr
         a9h/2I7N38BOw+d1LddQX3BCDIPCPXVaQnZ4GkxxXB7RPuS1a+KfidEMhaWXKjDFbkES
         VNvgq7wDA2/6a7GP3is0OyPOVuhyuM6oTpevkom/NTESi1dp46f+SyTXg/kXm3rRGlKK
         EET0pYjViQlPSfdMkDS2Sp+oiHwa/p4N34q8VrH5ZITF39bIZhT1MBjzZsoAj/Ha0WER
         J+KQpfOoteJbctxrM0IrieQcKOwVww/h13cR3rZfkjDC/IWmjLbNjEze7MEVYsZHqY4U
         4bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869489; x=1705474289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDu0A81Wnf88vB97RoIFzf86XD+FgkHNeSEcwAyLyvM=;
        b=S4MrShdLcrJZ2uLk/1o2F50sFgREoTlWUcTPrc0tkpWf/7ItefgQB0Etq7J3G9zSxG
         6mDk9PC/um7YdNlbf7H8k850jpHCHr7xT3X1ni2/a8jKdliY+t7TiIT5oXHfBsednJhb
         gEC4sn6GqgUmheQZWFnawEry5uVzChJuYujGIL0TGk/lBjCSvP9+JtuMFm1fTnP2Z+O6
         fc3Ts+K8ZhHSkq3lzWuBB6h7/qGDPYLFn4TlaewsrD+J5rx/BRuuE9WsHS0vV6YT9EV8
         NtfhatXbqv2McfNNvJYdAxagQzRtOY+3xSZRU3NrK9uP1S0Jn0WWdYRxS62baJX0oRL7
         PYuA==
X-Gm-Message-State: AOJu0Yx+MlGuHg2Qg9KzILgp90eO5TgLCPnB4BMAS2YILj8ni3TbM3sb
	5ghBP5isqCOIl+zQtiykumujqNDpPt0=
X-Google-Smtp-Source: AGHT+IFXLlh1TBxlIPEojcjiOY2P4rklTCap9wk0Ozi5Vp0SknGWdQYqIMf9ogTOzY9DoFrbPilSow==
X-Received: by 2002:a05:600c:190c:b0:40e:3538:a5ff with SMTP id j12-20020a05600c190c00b0040e3538a5ffmr171897wmq.118.1704869489136;
        Tue, 09 Jan 2024 22:51:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040d8eca092esm988759wmq.47.2024.01.09.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:28 -0800 (PST)
Message-ID: <2dc3279b37f3aa81ba20e3dd08b029ca655ac3d8.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:17 +0000
Subject: [PATCH 01/10] trailer: move process_trailers() to
 interpret-trailers.c
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

The interpret-trailers.c builtin is the only place we need to call
process_trailers(). As it stands, process_trailers() is inherently tied
to how the builtin behaves, so move its definition there.

Delete the corresponding declaration from trailer.h, which then forces
us to expose the working innards of that function. This enriches
trailer.h to include a more granular API, which can then be unit-tested
in the future (because process_trailers() by itself does too many things
to be able to be easily unit-tested).

Take this opportunity to demote some file-handling functions out of the
trailer API implementation, as these have nothing to do with trailers.

While we're at it, rename process_trailers() to interpret_trailers() in
the builtin for consistency with the existing cmd_interpret_trailers(),
which wraps around this function.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  98 +++++++++++++++++++++++++++-
 trailer.c                    | 120 ++++-------------------------------
 trailer.h                    |  20 +++++-
 3 files changed, 126 insertions(+), 112 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 033bd1556cf..444f8fb70c9 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "tempfile.h"
 #include "trailer.h"
 #include "config.h"
 
@@ -91,6 +92,99 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static struct tempfile *trailers_tempfile;
+
+static FILE *create_in_place_tempfile(const char *file)
+{
+	struct stat st;
+	struct strbuf filename_template = STRBUF_INIT;
+	const char *tail;
+	FILE *outfile;
+
+	if (stat(file, &st))
+		die_errno(_("could not stat %s"), file);
+	if (!S_ISREG(st.st_mode))
+		die(_("file %s is not a regular file"), file);
+	if (!(st.st_mode & S_IWUSR))
+		die(_("file %s is not writable by user"), file);
+
+	/* Create temporary file in the same directory as the original */
+	tail = strrchr(file, '/');
+	if (tail)
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
+
+	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	strbuf_release(&filename_template);
+	outfile = fdopen_tempfile(trailers_tempfile, "w");
+	if (!outfile)
+		die_errno(_("could not open temporary file"));
+
+	return outfile;
+}
+
+static void read_input_file(struct strbuf *sb, const char *file)
+{
+	if (file) {
+		if (strbuf_read_file(sb, file, 0) < 0)
+			die_errno(_("could not read input file '%s'"), file);
+	} else {
+		if (strbuf_read(sb, fileno(stdin), 0) < 0)
+			die_errno(_("could not read from stdin"));
+	}
+}
+
+static void interpret_trailers(const char *file,
+			       const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head)
+{
+	LIST_HEAD(head);
+	struct strbuf sb = STRBUF_INIT;
+	struct trailer_info info;
+	FILE *outfile = stdout;
+
+	ensure_configured();
+
+	read_input_file(&sb, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	parse_trailers(&info, sb.buf, &head, opts);
+
+	/* Print the lines before the trailers */
+	if (!opts->only_trailers)
+		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
+		fprintf(outfile, "\n");
+
+
+	if (!opts->only_input) {
+		LIST_HEAD(config_head);
+		LIST_HEAD(arg_head);
+		parse_trailers_from_config(&config_head);
+		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
+		list_splice(&config_head, &arg_head);
+		process_trailers_lists(&head, &arg_head);
+	}
+
+	print_all(outfile, &head, opts);
+
+	free_all(&head);
+	trailer_info_release(&info);
+
+	/* Print the lines after the trailers as is */
+	if (!opts->only_trailers)
+		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+
+	if (opts->in_place)
+		if (rename_tempfile(&trailers_tempfile, file))
+			die_errno(_("could not rename temporary file to %s"), file);
+
+	strbuf_release(&sb);
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
@@ -132,11 +226,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], &opts, &trailers);
+			interpret_trailers(argv[i], &opts, &trailers);
 	} else {
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, &opts, &trailers);
+		interpret_trailers(NULL, &opts, &trailers);
 	}
 
 	new_trailers_clear(&trailers);
diff --git a/trailer.c b/trailer.c
index 3a0710a4583..9d70c9946bd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -5,7 +5,6 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
-#include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
 /*
@@ -163,8 +162,8 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct list_head *head,
-		      const struct process_trailer_options *opts)
+void print_all(FILE *outfile, struct list_head *head,
+	       const struct process_trailer_options *opts)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -366,8 +365,8 @@ static int find_same_and_apply_arg(struct list_head *head,
 	return 0;
 }
 
-static void process_trailers_lists(struct list_head *head,
-				   struct list_head *arg_head)
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head)
 {
 	struct list_head *pos, *p;
 	struct arg_item *arg_tok;
@@ -589,7 +588,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-static void ensure_configured(void)
+void ensure_configured(void)
 {
 	if (configured)
 		return;
@@ -719,7 +718,7 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	list_add_tail(&new_item->list, arg_head);
 }
 
-static void parse_trailers_from_config(struct list_head *config_head)
+void parse_trailers_from_config(struct list_head *config_head)
 {
 	struct arg_item *item;
 	struct list_head *pos;
@@ -735,8 +734,8 @@ static void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-static void parse_trailers_from_command_line_args(struct list_head *arg_head,
-						  struct list_head *new_trailer_head)
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -775,17 +774,6 @@ static void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
-static void read_input_file(struct strbuf *sb, const char *file)
-{
-	if (file) {
-		if (strbuf_read_file(sb, file, 0) < 0)
-			die_errno(_("could not read input file '%s'"), file);
-	} else {
-		if (strbuf_read(sb, fileno(stdin), 0) < 0)
-			die_errno(_("could not read from stdin"));
-	}
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1000,10 +988,10 @@ static void unfold_value(struct strbuf *val)
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
  */
-static void parse_trailers(struct trailer_info *info,
-			     const char *str,
-			     struct list_head *head,
-			     const struct process_trailer_options *opts)
+void parse_trailers(struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head,
+		    const struct process_trailer_options *opts)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -1035,7 +1023,7 @@ static void parse_trailers(struct trailer_info *info,
 	}
 }
 
-static void free_all(struct list_head *head)
+void free_all(struct list_head *head)
 {
 	struct list_head *pos, *p;
 	list_for_each_safe(pos, p, head) {
@@ -1044,88 +1032,6 @@ static void free_all(struct list_head *head)
 	}
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
-void process_trailers(const char *file,
-		      const struct process_trailer_options *opts,
-		      struct list_head *new_trailer_head)
-{
-	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct trailer_info info;
-	FILE *outfile = stdout;
-
-	ensure_configured();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	parse_trailers(&info, sb.buf, &head, opts);
-
-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
-
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
-		fprintf(outfile, "\n");
-
-
-	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
-	}
-
-	print_all(outfile, &head, opts);
-
-	free_all(&head);
-	trailer_info_release(&info);
-
-	/* Print the lines after the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-
-	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
-			die_errno(_("could not rename temporary file to %s"), file);
-
-	strbuf_release(&sb);
-}
-
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
diff --git a/trailer.h b/trailer.h
index 1644cd05f60..b3e4a5e127d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -81,15 +81,29 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void process_trailers(const char *file,
-		      const struct process_trailer_options *opts,
-		      struct list_head *new_trailer_head);
+void parse_trailers_from_config(struct list_head *config_head);
+
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head);
+
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head);
+
+void parse_trailers(struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head,
+		    const struct process_trailer_options *opts);
 
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts);
 
 void trailer_info_release(struct trailer_info *info);
 
+void ensure_configured(void);
+void print_all(FILE *outfile, struct list_head *head,
+	       const struct process_trailer_options *opts);
+void free_all(struct list_head *head);
+
 /*
  * Format the trailers from the commit msg "msg" into the strbuf "out".
  * Note two caveats about "opts":
-- 
gitgitgadget

