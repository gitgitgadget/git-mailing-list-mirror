Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFA314A83
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353024; cv=pass; b=ES4Nvr7BwLQvqdZ++bozV72juFIiAF/p96q2DOP8Tpfmauq5aoIcHobc6dmvxbfckna9tCBVOZY1JvuIH3OZytnmadaWGtHyqiaj44yruqzbYRFLNsHU/W85Uj/hGL+ochgxfnraIEzE4SCttJPdns8dveB1HUKo4qBTAPZ1TYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353024; c=relaxed/simple;
	bh=hBpybWByQ75flqgh+Se1j37c+eHQwCRWVjavBdq81/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmBTBQWJ5l/LhZEf6HfOzu9VuGwKZr9Y3tITRTFOtxSIyRY5XAelkfp9CbWFxJL2gFGw4kiO50X/wEiil2aoypUrsDgewtDM8vQxXqPcgPJyqM7/q81507wtarJto3K7tjOdkFNk6VNec6z5beShhA0FBrdgxzAEVaAE8SO+0qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=KOkRmvWn; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="KOkRmvWn"
ARC-Seal: i=1; a=rsa-sha256; t=1762352998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G+AKgK1BY2HBARaYNtd8rokJZXHNcwSHOi2VJ4m7PhVOW2zoC7yhfOD6COvF9K0fiqUg75KNnviHqkZL70QEX2z/uuoz73/iJgndT/DDXzHQiwoBfUPU70SQ7T4M7sokCisIvVge0IkMJdW6UrGo6mTZEqvlY6j5DdAzY3e5XzI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762352998; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=12P3XXPd/WYjH9dawfwQm0YoXNBNW7gkg66gYYs+NS0=; 
	b=gg0YOO1tRADOlhYmMe8Rfs+aqZuLxuGuVEqXJL9XEYzavFcZ9z67mVqfb/EX6guu0PJVuOI+BlUCpgSciEfIiJSfohe3KU0dlteFuhcF/3xV+vDIkSztm5T46JiLmvyu0sP9wz75Ve9SKes6i3Y4vzGOnX6JNV3JGeSC0svcqz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762352998;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=12P3XXPd/WYjH9dawfwQm0YoXNBNW7gkg66gYYs+NS0=;
	b=KOkRmvWnk0sIHe6L03DdAC5ToCvZaQYRAR6JYhPXkMJJzZtLfR4qSQrAiOeUbci5
	oyz5cJ4fR0J8e3qnCZIje2NKQIypEik8xGEdvGSIp5mCdIhuzVCDWPO+Z1j6He5klZm
	DCos6RJQgrlRUrVUgInBenCXZUKossNPajHX4jME=
Received: by mx.zohomail.com with SMTPS id 1762352996688212.08967570682216;
	Wed, 5 Nov 2025 06:29:56 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 1/4] interpret-trailers: factor out buffer-based processing to process_trailers()
Date: Wed,  5 Nov 2025 22:29:41 +0800
Message-ID: <20251105142944.73061-2-me@linux.beauty>
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

Extracted trailer processing into a helper that accumulates output in
a strbuf before writing.

Updated interpret_trailers() to reuse the helper, buffer output, and
clean up both input and output buffers after writing.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/interpret-trailers.c | 51 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 41b0750e5a..4c90580fff 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
-static void interpret_trailers(const struct process_trailer_options *opts,
-			       struct list_head *new_trailer_head,
-			       const char *file)
+static void process_trailers(const struct process_trailer_options *opts,
+			     struct list_head *new_trailer_head,
+			     struct strbuf *sb, struct strbuf *out)
 {
 	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block_sb = STRBUF_INIT;
 	struct trailer_block *trailer_block;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
 
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	trailer_block = parse_trailers(opts, sb.buf, &head);
+	trailer_block = parse_trailers(opts, sb->buf, &head);
 
 	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
+		strbuf_add(out, sb->buf, trailer_block_start(trailer_block));
 
 	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
-		fprintf(outfile, "\n");
-
+		strbuf_addch(out, '\n');
 
 	if (!opts->only_input) {
 		LIST_HEAD(config_head);
@@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block_sb);
+	format_trailers(opts, &head, out);
 	free_trailers(&head);
-	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
-	strbuf_release(&trailer_block_sb);
 
 	/* Print the lines after the trailer block as is. */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
-		       sb.len - trailer_block_end(trailer_block), outfile);
+		strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
+			   sb->len - trailer_block_end(trailer_block));
 	trailer_block_release(trailer_block);
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&sb, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	process_trailers(opts, new_trailer_head, &sb, &out);
 
+	fwrite(out.buf, out.len, 1, outfile);
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
 	strbuf_release(&sb);
+	strbuf_release(&out);
 }
 
 int cmd_interpret_trailers(int argc,
-- 
2.51.0

