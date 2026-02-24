Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D028A72F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916802; cv=pass; b=i+9kzMzPwzhJRf8jQUic8KZEVBmkRlErk0h00EkasOoTxAlpn5KM/hsQ4koXBLX3r0ybzp8kkOzBwU/D29Jx8S6eXXYFXU0g1gCvk5eEKL8XzQetz/5xtsPDTO6mAduUisH8I0+fdRI3zriu2RC26Zpz9BlSuX2hTRNxUdIxKA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916802; c=relaxed/simple;
	bh=7ng+928pLbiMYrlYDOn+BzT3vuL0j/88jOO4EHhvMQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrArC1cuVApY6ZHe/0rVXTCG/iHXKdTjdUTZgp+yy3ZJd6J4adHhEg/xsNnw41kfZuMaWmB4DWdzdCw5DqKvVAlmJItB8obPjBDBNRqAab13GodEBAjINjWpCwOJJ5Mao8Dl+Tjegu4cwdoVkwf5HyP31S3F1tFqkxfNslqE6tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Emy8YRQb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Emy8YRQb"
ARC-Seal: i=1; a=rsa-sha256; t=1771916770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nyJpCqeT5NKRt5VrS+0eWNMZuqML4sbzps0G95hvAkkF4S2sPoAGL0QLEIY1+swN4IJsTFgYbFcuVYWDtvxzbJ7rLYN6zrUtgziJlgrxRpES+PT3Bd3DQaeo2nKjl/tIZiDLAeaFYtZlXy8dKZvfWtNIb9TsUFjWR8XbwBHYtxE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771916770; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TZsBZiCl9G1ge/dd5/3qWjIpJF6yrlF/gDLw76NJz4E=; 
	b=fSi20DJXO0o+UciTnuO4oHsABQCswCj3SNmNAooQuySeruQ9DO1Gl1VJAH7LDDFI2Z2BTICrnyO7DWae7WT2j2yDimdQjZ7NwqJxQpFslenRxjGyFnl2MPur+yMxQ2kwNTqG1YGGAN6WNyeLhJns7IvSUCgQR3XxCnYHKkIpTes=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771916770;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TZsBZiCl9G1ge/dd5/3qWjIpJF6yrlF/gDLw76NJz4E=;
	b=Emy8YRQbuutAX8LsfI/UO02yvNgnK/vMouS6KiONgum0Mt8aRG9oV0Xh/FsjyyiP
	k9iBC+DIqp/XWWdrpMju3q38EcPZcqviJ7i+Wq7Bn60bOw7AA69Y1vNFjTcFMhDwQD0
	8rOy1urPPuC4JuqMRHjgpQRVt2O1sc3Gpudgzvx8=
Received: by mx.zohomail.com with SMTPS id 1771916769801765.4237856903284;
	Mon, 23 Feb 2026 23:06:09 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v7 2/5] trailer: move process_trailers to trailer.h
Date: Tue, 24 Feb 2026 15:05:48 +0800
Message-ID: <20260224070552.148591-3-me@linux.beauty>
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

Move process_trailers() from builtin/interpret-trailers.c into trailer.c
and expose it via trailer.h.

This lets other call sites reuse the same trailer rewriting logic.

Signed-off-by: Li Chen <me@linux.beauty>
---
v7:
Rename the input parameter from sb to input.

 builtin/interpret-trailers.c | 36 ------------------------------------
 trailer.c                    | 36 ++++++++++++++++++++++++++++++++++++
 trailer.h                    |  3 +++
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 69f9d67ec0..1354109e0f 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -136,42 +136,6 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
-static void process_trailers(const struct process_trailer_options *opts,
-			     struct list_head *new_trailer_head,
-			     struct strbuf *input, struct strbuf *out)
-{
-	LIST_HEAD(head);
-	struct trailer_block *trailer_block;
-
-	trailer_block = parse_trailers(opts, input->buf, &head);
-
-	/* Print the lines before the trailer block */
-	if (!opts->only_trailers)
-		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
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
-		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
-			   input->len - trailer_block_end(trailer_block));
-	trailer_block_release(trailer_block);
-}
-
 static void interpret_trailers(const struct process_trailer_options *opts,
 			       struct list_head *new_trailer_head,
 			       const char *file)
diff --git a/trailer.c b/trailer.c
index 911a81ed99..0c9200506d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1235,3 +1235,39 @@ int amend_file_with_trailers(const char *path, const struct strvec *trailer_args
 	strvec_pushv(&run_trailer.args, trailer_args->v);
 	return run_command(&run_trailer);
 }
+
+void process_trailers(const struct process_trailer_options *opts,
+		      struct list_head *new_trailer_head,
+		      struct strbuf *input, struct strbuf *out)
+{
+	LIST_HEAD(head);
+	struct trailer_block *trailer_block;
+
+	trailer_block = parse_trailers(opts, input->buf, &head);
+
+	/* Print the lines before the trailer block */
+	if (!opts->only_trailers)
+		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
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
+		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
+			   input->len - trailer_block_end(trailer_block));
+	trailer_block_release(trailer_block);
+}
diff --git a/trailer.h b/trailer.h
index 4740549586..531fa1a13f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -202,4 +202,7 @@ void trailer_iterator_release(struct trailer_iterator *iter);
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
+void process_trailers(const struct process_trailer_options *opts,
+		      struct list_head *new_trailer_head,
+		      struct strbuf *input, struct strbuf *out);
 #endif /* TRAILER_H */
-- 
2.52.0
