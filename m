Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450BE313E1B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444786; cv=pass; b=B50oVUB7+7SHyKF7YS5lgyxrdql92HY1GMxQxd31S23K5tUt4Ar3mjiLH+8c01+kadwUom6l4Cmy2v3TMA/9TSh8W1k5i5U/XKUD4Gp1nGscsIN0avlTQBMQ59el32us0Win8ipruFb7QZLE7yd/J9K5EKa3428u1U2jTafCiAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444786; c=relaxed/simple;
	bh=iQ+PX4NErNjRtE2rUDRIz8YBIl+s/TLa3Fn3y4RP+d4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbZEmQTCqe20xsCroehrC0+2URVlawG2ZpViaZpBOyFuodvScGEn71tg1w8D6NoVDeOD1pkt85gqDSXRcbgQ456XO9Rprplz0DR0Mny7EiCAujfeYXAdjhskXuDBr3V28fRNuwYVpXu4tBeJpNsEmeSorz5vUg7AALH8RlAro5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=FAuWfo11; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="FAuWfo11"
ARC-Seal: i=1; a=rsa-sha256; t=1760444728; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kH2zZs2Lf14HIfX7je0EWnkjPZYZ+3YA92VsE/0VaIjHvsTV7P0sDUquuS+66qGgSdqw5HHhlU7lqly61cKawL5qbB+xwcQG/pRyCZR9lkmA6iddRIw9Az6zGL1Uuo8/iw48bErLQya8rjZWtU9jXOJJlZxzqrQ5oxKNipLhXQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444728; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ghhMiCEdFgNdwZt7dI6vKLJVPMV8qFZKRQjNu8GKgrc=; 
	b=looHZUiLOdVeJGE0eJ1q3NsJT/JOzWSqShli7NUIO0TIEu+S79tCu7ie2wjJi+8sQlTzPioxdy86A+XedM4paqujpJgDHkxua8nEgRRT5LN67jYdNNPuckIupsu7su0YQ2/pXScUe0YfukD/NHOMaUHIy8GFDDbWnLhuYRQ6hIU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444728;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ghhMiCEdFgNdwZt7dI6vKLJVPMV8qFZKRQjNu8GKgrc=;
	b=FAuWfo11HNAtl50phsL75BdDJRiGTfsFWWYZ4xdp2C+T5UMTbLcbVE/aGtvmQRFC
	Dr9rw/zZYs6x9D55/kUGh6ICoRwElWX5aZeVJn3dtpToT+7cXdZHXmW0EiMrWEd7KSc
	CQIW8HyMXQ+x4IqW4Y4C7Dn2NwnZ5ycgww9b1oKk=
Received: by mx.zohomail.com with SMTPS id 1760444726832728.1309014414254;
	Tue, 14 Oct 2025 05:25:26 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 07/29] trailer: mirror interpret-trailers output flow
Date: Tue, 14 Oct 2025 20:24:20 +0800
Message-ID: <20251014122452.1851103-8-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Drop the early-return branch that mirrored the
special case. Let trailer_process() always
follow the same path as interpret-trailers.
Ensure trailer lists and buffers are freed
along the unified exit path.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/trailer.c b/trailer.c
index ac756020a3..5329589064 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1266,10 +1266,8 @@ int trailer_process(const struct process_trailer_options *opts,
 	struct trailer_block *blk;
 	LIST_HEAD(orig_head);
 	struct strbuf trailers_sb = STRBUF_INIT;
-	bool had_trailer_before;
 
 	blk = parse_trailers(opts, msg, &orig_head);
-	had_trailer_before = !list_empty(&orig_head);
 	if (!opts->only_input) {
 		LIST_HEAD(config_head);
 		LIST_HEAD(arg_head);
@@ -1280,40 +1278,18 @@ int trailer_process(const struct process_trailer_options *opts,
 		process_trailers_lists(&orig_head, &arg_head);
 	}
 	format_trailers(opts, &orig_head, &trailers_sb);
-	if (!opts->only_trailers && !opts->only_input && !opts->unfold &&
-	    !opts->trim_empty && list_empty(&orig_head) &&
-	    (list_empty(new_trailer_head) || opts->only_input)) {
-		size_t split = trailer_block_start(blk); /* end-of-log-msg */
-		if (!blank_line_before_trailer_block(blk)) {
-			strbuf_add(out, msg, split);
-			strbuf_addch(out, '\n');
-			strbuf_addstr(out, msg + split);
-		} else
-			strbuf_addstr(out, msg);
-
-		strbuf_release(&trailers_sb);
-		trailer_block_release(blk);
-		return 0;
-	}
 	if (opts->only_trailers) {
 		strbuf_addbuf(out, &trailers_sb);
-	} else if (had_trailer_before) {
-		strbuf_add(out, msg, trailer_block_start(blk));
-		if (!blank_line_before_trailer_block(blk))
-			strbuf_addch(out, '\n');
-		strbuf_addbuf(out, &trailers_sb);
-		strbuf_add(out, msg + trailer_block_end(blk),
-			   strlen(msg) - trailer_block_end(blk));
 	} else {
-		size_t cpos = trailer_block_start(blk);
-		strbuf_add(out, msg, cpos);
-		if (cpos == 0) /* empty body → just one \n */
-			strbuf_addch(out, '\n');
-		else if (!blank_line_before_trailer_block(blk))
-			strbuf_addch(out, '\n'); /* body without trailing blank */
+		size_t block_start = trailer_block_start(blk);
+		size_t block_end = trailer_block_end(blk);
+		bool need_blank_line = !blank_line_before_trailer_block(blk);
 
+		strbuf_add(out, msg, block_start);
+		if (need_blank_line)
+			strbuf_addch(out, '\n');
 		strbuf_addbuf(out, &trailers_sb);
-		strbuf_add(out, msg + cpos, strlen(msg) - cpos);
+		strbuf_add(out, msg + block_end, strlen(msg) - block_end);
 	}
 	strbuf_release(&trailers_sb);
 	free_trailers(&orig_head);
-- 
2.51.0

