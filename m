Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140A280319
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558937; cv=pass; b=jEH3+avhAqx1+fhEtUTZ5OEGyBdgr5crAyawk1wKbSleo26ApvwzmTad6bq+oT5HvuRbfWOdupHmMLrbFYaN9jkVWLWqfPvvFP1dOt4KcutCGoA+OviQWtY0nlKLqxK0bEqf1HRIrg93u7uuXcdpLJN9wcGYuUJQt0hkRAcRPcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558937; c=relaxed/simple;
	bh=1ejp396dj59bFjOg7GZ2e8HH8Zdyfb2cpf/o4ZC0AuQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Afycf4Ehny+GcUFJEVKessVKWmCMejsXw1RqKN0EiqPDFMY4d59TUPtnIG9CbyLwNu4hZoasUINb84uaUM2WKmK40AXveefPxmse4g88Q/9Ei+Z5ap6FgWiTB3xtidUKu62xopnQV+F7f9IzABLOD2h6Riutam5g71/NnOO4t4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=nHuW7fKn; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="nHuW7fKn"
ARC-Seal: i=1; a=rsa-sha256; t=1749558908; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nRf2lsvzysgj+J5roOWG1dIWeNQvU9A0xAlr09agIx1fhtk23imwnmC64TJKEeYwdJWZg/0OjXh61togrYb33TXnIdWD7V5TJfqQ1G2BGfQ8BdmZ3N3uulaiP2mfltlp3ucdcITrM6EVR0AYwPNrHWjPElFWP4RViWDCJ5kyQNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749558908; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=QDpJhbiu8GCKSqyq7qkzqbTY7le+m4nxv1dq9uuKJsw=; 
	b=YfD8Z8MOtGJueR2wIVtpRVatJ0GZFmdhduQnP1zkbevjMz1McsGRg3FQBZG386le4+iPQK/s+XolgFeDYNCjWB/VQ/CSFxMlX4+vMjUh67ryKdGR7H1nGdRTaNlvjyYeZ/bUIqawLiPQDN1ubn5jbT9VwKTxPvlBs5j/t7Aq2jM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749558908;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=QDpJhbiu8GCKSqyq7qkzqbTY7le+m4nxv1dq9uuKJsw=;
	b=nHuW7fKnmuOj1Em2IN+oyJiKGLdDeqEXeecsR+CYET+qJ2gUiZFjpjWL6dfGVhIt
	X9Kt03dLGnp9Xgqf+j1Mk8xNnYX36ROgPkNazT+bXA3Mx5TAN54HO10E4qC0oeUEm6x
	FMsV/J5DX9TmW5+DkzgKi3agu4+KzD7wvrkvsuRU=
Received: by mx.zohomail.com with SMTPS id 1749558906672727.4799280599699;
	Tue, 10 Jun 2025 05:35:06 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v2 1/2] trailer: append trailers in-process and drop the fork to `interpret-trailers`
Date: Tue, 10 Jun 2025 20:34:58 +0800
Message-ID: <20250610123459.278582-2-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610123459.278582-1-me@linux.beauty>
References: <20250610123459.278582-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

The built-in commands that support `--trailer` (tag, commit --amend,
rebase --trailer, etc.) have always appended trailers by spawning an
external `git interpret-trailers --in-place` process.  That extra fork
is negligible for a single commit, but it scales poorly when hundreds or
thousands of commits are rewritten (e.g. an interactive rebase or a
history-wide `filter-repo`).  This patch moves the heavy lifting fully
in-process:

* `amend_strbuf_with_trailers()`
  – parses the existing message,
  – merges trailers from the command line and config,
  – formats the final trailer block, and
  – rewrites the supplied `struct strbuf`
  without ever leaving the current process.

* `amend_file_with_trailers()` becomes a thin wrapper that reads a file
  into a `strbuf`, calls the new helper, and writes the result back.

* `builtin/rebase.c` now calls `amend_file_with_trailers()` instead of
  executing `interpret-trailers`.

Edge-cases that used to be handled implicitly by the external helper are
now replicated:

  * `trailer.ifexists=replace` and other per-key policies are honoured by
    running the existing `parse_trailers_from_command_line_args()` logic
    on the raw CLI list, so the same *replace / add / ignore* semantics
    are preserved.

  * A message that contains an RFC-2822 style `---` separator but no
    prior trailer block gets its trailers appended **after** the
    separator, matching the external command’s output.

  * When `git commit --verbose` leaves a diff after the message (comment
    lines beginning with `#`), trailers are inserted before that comment
    section so they survive the subsequent strip-space cleanup.

  * Ordering remains identical to the old path: CLI trailers first,
    followed by trailers introduced via `trailer.<key>.*` config.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 trailer.h |  17 +++++++
 2 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/trailer.c b/trailer.c
index 310cf582dc..70b04736a8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1224,14 +1224,143 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
+static size_t first_comment_pos(const struct strbuf *buf)
 {
-	struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-	run_trailer.git_cmd = 1;
-	strvec_pushl(&run_trailer.args, "interpret-trailers",
-		     "--in-place", "--no-divider",
-		     path, NULL);
-	strvec_pushv(&run_trailer.args, trailer_args->v);
-	return run_command(&run_trailer);
+	const char *p = buf->buf;
+	const char *end = buf->buf + buf->len;
+
+	while (p < end) {
+		const char *line = p;
+		const char *nl = memchr(p, '\n', end - p);
+		size_t len = nl ? (size_t)(nl - p) : (size_t)(end - p);
+
+		/* skip leading whitespace */
+		size_t i = 0;
+		while (i < len && isspace((unsigned char)line[i]))
+			i++;
+
+		if (i < len && line[i] == '#')
+			return (size_t)(line - buf->buf); /* comment starts here */
+
+		if (!nl)              /* last line without newline */
+			break;
+		p = nl + 1;
+	}
+	return buf->len;          /* no comment line found */
+}
+
+int amend_strbuf_with_trailers(struct strbuf *buf,
+							   const struct strvec *trailer_args)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	struct strbuf trailers_sb = STRBUF_INIT;
+	struct strbuf out         = STRBUF_INIT;
+	size_t i;
+	/* 1. parse message ------------------------------------------------- */
+	LIST_HEAD(orig_head);   /* existing trailers, if any          */
+	LIST_HEAD(cfg_head);    /* config trailers                    */
+	LIST_HEAD(cli_raw);     /* new_trailer_item from CLI          */
+	LIST_HEAD(cli_head);    /* arg_item after helper              */
+	LIST_HEAD(all_new);     /* merged list                        */
+	struct trailer_block *blk = parse_trailers(&opts, buf->buf, &orig_head);
+	bool had_trailer_before = !list_empty(&orig_head);
+
+	/* 2. CLI trailers -------------------------------------------------- */
+	if (trailer_args && trailer_args->nr) {
+		for (i = 0; i < trailer_args->nr; i++) {
+				const char *arg  = trailer_args->v[i];
+				const char *text;
+				struct new_trailer_item *ni;
+
+				if (!skip_prefix(arg, "--trailer=", &text))
+						text = arg;
+
+				if (!*text)
+						continue;
+
+				ni = xcalloc(1, sizeof(*ni));
+				INIT_LIST_HEAD(&ni->list);
+				ni->text = (char *)text;
+				list_add_tail(&ni->list, &cli_raw);
+		}
+		parse_trailers_from_command_line_args(&cli_head, &cli_raw);
+
+		while (!list_empty(&cli_raw)) {
+				struct new_trailer_item *ni =
+						list_first_entry(&cli_raw, struct new_trailer_item, list);
+				list_del(&ni->list);
+				free(ni);
+		}
+	}
+
+	/* 3. config trailers ---------------------------------------------- */
+	parse_trailers_from_config(&cfg_head);
+
+	/* 4. merge lists --------------------------------------------------- */
+	list_splice(&cli_head, &all_new);
+	list_splice(&cfg_head, &all_new);
+
+	/* 5. apply --------------------------------------------------------- */
+	process_trailers_lists(&orig_head, &all_new);
+
+	/* 6. format updated trailer block --------------------------------- */
+	format_trailers(&opts, &orig_head, &trailers_sb);
+
+	/* 7. decide insertion point --------------------------------------- */
+	if (had_trailer_before) {
+		/* insert at existing trailer block */
+		strbuf_add(&out, buf->buf, trailer_block_start(blk));
+		if (!blank_line_before_trailer_block(blk))
+			strbuf_addch(&out, '\n');
+		strbuf_addbuf(&out, &trailers_sb);
+		strbuf_add(&out,
+				   buf->buf + trailer_block_end(blk),
+				   buf->len - trailer_block_end(blk));
+	} else {
+		/* insert before first comment (git --verbose) if any */
+		size_t cpos = first_comment_pos(buf);
+
+		/* copy body up to comment (or whole buf if none) */
+		strbuf_add(&out, buf->buf, cpos);
+
+		/* ensure single blank line separating body & trailers */
+		if (!out.len || out.buf[out.len - 1] != '\n')
+			strbuf_addch(&out, '\n');
+		if (out.len >= 2 && out.buf[out.len - 2] != '\n')
+			strbuf_addch(&out, '\n');
+
+		strbuf_addbuf(&out, &trailers_sb);
+
+		/* copy remaining comment lines (if any) */
+		strbuf_add(&out, buf->buf + cpos, buf->len - cpos);
+	}
+
+	strbuf_swap(buf, &out);
+
+	/* 8. cleanup ------------------------------------------------------- */
+	strbuf_release(&out);
+	strbuf_release(&trailers_sb);
+	free_trailers(&orig_head);
+	trailer_block_release(blk);
+	return 0;
+}
+
+int amend_file_with_trailers(const char *path,
+							 const struct strvec *trailer_args)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!trailer_args || !trailer_args->nr)
+		return 0;
+
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		return error_errno("could not read '%s'", path);
+
+	if (amend_strbuf_with_trailers(&buf, trailer_args))
+		die("failed to append trailers");
+
+	/* `write_file_buf()` aborts on error internally */
+	write_file_buf(path, buf.buf, buf.len);
+	strbuf_release(&buf);
+	return 0;
 }
diff --git a/trailer.h b/trailer.h
index 4740549586..17986d5dd0 100644
--- a/trailer.h
+++ b/trailer.h
@@ -202,4 +202,21 @@ void trailer_iterator_release(struct trailer_iterator *iter);
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
+/*
+ * In‑memory variant of amend_file_with_trailers(): instead of rewriting a file
+ * on disk (and therefore spawning a separate `git interpret‑trailers` process)
+ * we operate directly on a struct strbuf that already contains the commit
+ * message.  The rules for positioning, deduplication, and formatting are the
+ * same as those implemented by the builtin `interpret‑trailers` command.
+ *
+ *  - @buf          : the message to be amended.  On success, its contents are
+ *                    replaced with the new message that has the trailers
+ *                    inserted.
+ *  - @trailer_args : the list of trailer strings exactly as would be passed on
+ *                    the command‑line via repeated `--trailer` options.
+ *
+ * Returns 0 on success, <0 on error.
+ */
+int amend_strbuf_with_trailers(struct strbuf *buf,
+                               const struct strvec *trailer_args);
 #endif /* TRAILER_H */
-- 
2.49.0

