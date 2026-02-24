Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84C28A72F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916791; cv=pass; b=pInJ2ikVhfrAKyY3YvhCAkGus1LrjNP0MkmlGuqusdyW2xCuykI/EIbFGoui9u5evWlaGT0qnPh4Zl0QfUNncePWk1u5HLRr8ntCNixWmHCP9xYmJ1+w4mELdZMT8x0jKKsFbtIx+wRzlhZ1+cDTQziTl0YYT6MeEebxU6RAQWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916791; c=relaxed/simple;
	bh=ZPeznRTerCy7NToBzC1q5cbzSNTcqIuXpEYzICDLgZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIB9tnho0pJJmd+220Q1O84LfHKOExgyPCVTwr5B+LWS/e6seN3OtTo+SE+VZxFjFlpzra5RIGSnCwDZHt7PsLIxoC2+smox4YyRRu+cxJ+wTJFTW4tnKQYVtRvxSh5rBGP5fyk5GZsEC2xCOtEBXrtvKYwjIqjUjezfUWXMRjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=J4s6AuXh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="J4s6AuXh"
ARC-Seal: i=1; a=rsa-sha256; t=1771916768; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IKKR+NtP6bbyJi/SaZ83n7bOx4ZALQigUrWXWPp4hVteTAECFFbFaNGcGaMzVRdEo1xaFlNbEZLR4CbT+R2YMmPTeWXhZCfSPmD9ojLk8PhVlgpqxOpLluhfBrL9yrVEKZzm5teE0S9sUf64Kb9ZpZkFtCMaMPdR0Jpo0VMdXiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771916768; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9OX4/57+1IP1A8Mo4b/yXq78HZsyd+STYIsUVFrJ0BE=; 
	b=RzAPfY/UJczYZEgujLMxh3p+X4i5iE+YlbUQKnFOs93ISAn7OyPeeCisbFFEE5OXSWy+1xyg0RNQbJMskDicUG7RSuxhiAT2VxKMWXRK8y1qlrarZWKyHuVh8gCQZ4xdaFN3lIBDImfyzVrq8kWH2U6IYacjwENwoZDd1RS9Ero=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771916768;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9OX4/57+1IP1A8Mo4b/yXq78HZsyd+STYIsUVFrJ0BE=;
	b=J4s6AuXh+SWZe76IOhY8/hD07rVyh2oufgHBze/SBKPtYQ6m0FZ3SkMIQ1vmZoZR
	3ZgcQqe9kcKjfSrwKYvEoUBkYbL6i6MUVlzPuLVosVNbnSjwDyBjw9vOvRHaebpPGKZ
	q25kthB87f/7nWahvzARcaapxO8lFqSM6Xtrb2d4=
Received: by mx.zohomail.com with SMTPS id 1771916767602133.5972484570708;
	Mon, 23 Feb 2026 23:06:07 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v7 1/5] interpret-trailers: factor trailer rewriting
Date: Tue, 24 Feb 2026 15:05:47 +0800
Message-ID: <20260224070552.148591-2-me@linux.beauty>
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

Extract the trailer rewriting logic into a helper that appends to an
output strbuf.

Update interpret_trailers() to handle file I/O only: read input once,
call the helper, and write the buffered result.

This separation makes it easier to move the helper into trailer.c in the
next commit.

Signed-off-by: Li Chen <me@linux.beauty>
---
v7:
Use strbuf_write() when emitting buffered output.

 builtin/interpret-trailers.c | 53 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 41b0750e5a..69f9d67ec0 100644
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
+			     struct strbuf *input, struct strbuf *out)
 {
 	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block_sb = STRBUF_INIT;
 	struct trailer_block *trailer_block;
-	FILE *outfile = stdout;
 
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	trailer_block = parse_trailers(opts, sb.buf, &head);
+	trailer_block = parse_trailers(opts, input->buf, &head);
 
 	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
+		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
 
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
+		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
+			   input->len - trailer_block_end(trailer_block));
 	trailer_block_release(trailer_block);
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	struct strbuf input = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&input, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	process_trailers(opts, new_trailer_head, &input, &out);
 
+	strbuf_write(&out, outfile);
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
-	strbuf_release(&sb);
+	strbuf_release(&input);
+	strbuf_release(&out);
 }
 
 int cmd_interpret_trailers(int argc,
-- 
2.52.0
