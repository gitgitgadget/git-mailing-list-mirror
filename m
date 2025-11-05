Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A832D0E4
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353035; cv=pass; b=uwY2Yl6kBpW2aqYrp80vpYTagC/xJRd3Zlv87wZ8iWahxXzRRXR/Q3JWIyboA3MQVGYJUonNdvScCCaVkR9SKzzbJUHcnNXtA4l1HH7OkCa1RbjcBd/NLPbjI0NcBn3HB0EmAjQV2vA3+7EnmpqeKjdPmZXs68e9z0hFQZBy4jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353035; c=relaxed/simple;
	bh=Z60/z3f2sLCPReyu69Nn52c6JN3g0vFw1qjuv/+eXtw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+0c7yffpr7LI+6678lZo1rQ6iPSlJbUITVEQRv4C+z/+FbHfSONtYNRh8PHk5OUwvOBbJx4Gy+pPIk7tdBKawPKuxCEeiKif7+6frTuYKFV1le9Hp8uauI8NyZylw4ZydtBJCe2/2fl6KLp5RlVa3n3DeGGXNxbIG1xvQaaSAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=bQ3EZBhR; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="bQ3EZBhR"
ARC-Seal: i=1; a=rsa-sha256; t=1762353002; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hhrBVG/DxzGGS2ZVUQXE1wTOyjLMPQCJE8d44A7Znqt5KC3TizgM0MVPC23PTzNWcls+yEiXb1XoIHJ03jNaPxvdtKBQh21LIy5kRSvqezHuMqgGbdqC3i0NoKZe+6DHqXWIYhRPpf0Km6chh8zbMIYJx0TED8YHr4QY0xpqeVY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762353002; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=eitMeIZoQB1iKSQmSJqgailhp0c1Rexz9FKaj0bYOPU=; 
	b=C5dWC1Vbtq1/+CUh890JwoNpxTNsJG269AHVCL4khkULKyW+nIlZyrxECpeOXbtubTTtq7IA3DaoGr71H3ovIGhH/8haDdMEwLWcyfulgZlPvFdtQgCHxne67nL9TkzLeHfzNd0tz6G4ohygT/6e/6TfpdLDAyyL6s68s8vMnzw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762353002;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=eitMeIZoQB1iKSQmSJqgailhp0c1Rexz9FKaj0bYOPU=;
	b=bQ3EZBhRh+8EApT2y3ijNcgoLFoB4psimZU+I4CEVojBrqcfYGrfjOHINpAUMwHu
	DrGCjQ7wRYHAkj5TMimJrVj6d6brJ61x0pN+eu1qNcAk0W9ngnzMcyB6h19VP98ksxV
	VOklMslJ7H8Eo4PqwcpFkSjE7TSa79lAI9ui+Uoc=
Received: by mx.zohomail.com with SMTPS id 1762352999804605.1041190505144;
	Wed, 5 Nov 2025 06:29:59 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 2/4] trailer: move process_trailers to trailer.h
Date: Wed,  5 Nov 2025 22:29:42 +0800
Message-ID: <20251105142944.73061-3-me@linux.beauty>
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

This function would be used by trailer_process
in following commits.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/interpret-trailers.c | 36 ------------------------------------
 trailer.c                    | 36 ++++++++++++++++++++++++++++++++++++
 trailer.h                    |  3 +++
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 4c90580fff..bce2e791d6 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -136,42 +136,6 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
-static void process_trailers(const struct process_trailer_options *opts,
-			     struct list_head *new_trailer_head,
-			     struct strbuf *sb, struct strbuf *out)
-{
-	LIST_HEAD(head);
-	struct trailer_block *trailer_block;
-
-	trailer_block = parse_trailers(opts, sb->buf, &head);
-
-	/* Print the lines before the trailer block */
-	if (!opts->only_trailers)
-		strbuf_add(out, sb->buf, trailer_block_start(trailer_block));
-
-	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
-		strbuf_addch(out, '\n');
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
-	/* Print trailer block. */
-	format_trailers(opts, &head, out);
-	free_trailers(&head);
-
-	/* Print the lines after the trailer block as is. */
-	if (!opts->only_trailers)
-		strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
-			   sb->len - trailer_block_end(trailer_block));
-	trailer_block_release(trailer_block);
-}
-
 static void interpret_trailers(const struct process_trailer_options *opts,
 			       struct list_head *new_trailer_head,
 			       const char *file)
diff --git a/trailer.c b/trailer.c
index 911a81ed99..b735ec8a53 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1235,3 +1235,39 @@ int amend_file_with_trailers(const char *path, const struct strvec *trailer_args
 	strvec_pushv(&run_trailer.args, trailer_args->v);
 	return run_command(&run_trailer);
 }
+
+void process_trailers(const struct process_trailer_options *opts,
+		      struct list_head *new_trailer_head,
+		      struct strbuf *sb, struct strbuf *out)
+{
+	LIST_HEAD(head);
+	struct trailer_block *trailer_block;
+
+	trailer_block = parse_trailers(opts, sb->buf, &head);
+
+	/* Print the lines before the trailer block */
+	if (!opts->only_trailers)
+		strbuf_add(out, sb->buf, trailer_block_start(trailer_block));
+
+	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
+		strbuf_addch(out, '\n');
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
+	/* Print trailer block. */
+	format_trailers(opts, &head, out);
+	free_trailers(&head);
+
+	/* Print the lines after the trailer block as is. */
+	if (!opts->only_trailers)
+		strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
+			   sb->len - trailer_block_end(trailer_block));
+	trailer_block_release(trailer_block);
+}
diff --git a/trailer.h b/trailer.h
index 4740549586..44d406b763 100644
--- a/trailer.h
+++ b/trailer.h
@@ -202,4 +202,7 @@ void trailer_iterator_release(struct trailer_iterator *iter);
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
+void process_trailers(const struct process_trailer_options *opts,
+		      struct list_head *new_trailer_head,
+		      struct strbuf *sb, struct strbuf *out);
 #endif /* TRAILER_H */
-- 
2.51.0

