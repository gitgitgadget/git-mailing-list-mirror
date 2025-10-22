Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF22EC568
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111783; cv=pass; b=Dv5l+2C3y4xXI0bx/AidyYwO5sUHZ4/Wn3lIqLqNVpekQbq3deER9wjm7O0vSeIIkHMEVifzlyp122I7NkYlT9Bw6vXszLEACuiGKG3o3PowaqWPq+gAVApDbSyLg7pj6O97DtrtS8Ux1+9Sl9/Yy0RSwzgZb2zbwEwATDP74dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111783; c=relaxed/simple;
	bh=AiEys76qAjfvHbKweLz01/pdLjatLtiDuiwY/XSehfM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTJen+hEG6QBB1mbeXh6nKSuDFPKtVUfNBftDJIhZkUIDQ+cxsSj6PnIJHKqx07B4MHy6nRSKnGezYNKLVVkODWWmEep76jPdGFuyyrepsNPr0XdAHK481dZd+x+uGQX12MQTSFjP+F65lnGxHFaTPasCpkcmsJzRNpnxC7G9RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=OQtJT+Lz; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="OQtJT+Lz"
ARC-Seal: i=1; a=rsa-sha256; t=1761111630; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HQ8baq0GUFd4LI9fksqOPu/mXYjKMjmXMr8JJGMXt87m2teWGEWz8J7bfTJ+pfh+KtYrbSKvkAjAHJti0Y0xkWzolZUB0NQDTt0jsX78gUnnWydu4kIXb0iM7Aw1Eg4YKTq2JpYFRxUOnqDMRNkAzYpQYSxoHGD6EvGmHplLoWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111630; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=xoLvhdlg7qOcu3L0DcQ7Df8Jx8xs8lqmqSGHlo8t9oQ=; 
	b=fvN/MuA0NWvQsVg1MMgN8MGNaMJmedhqVDmbO25Ccj3O/PtiDSQI8k+UB8ryyKJmlRycqPGzP9/Y09udF353zpbBJ2Snx1X08TwVZaBAl9FdxQYi/C2EnhMe5iUUwOqT8bC5lJosBXafP32y7NCakCQB1alneT6n/vZNhJSKmwc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111630;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xoLvhdlg7qOcu3L0DcQ7Df8Jx8xs8lqmqSGHlo8t9oQ=;
	b=OQtJT+LzjyVm0Vvr/q3GrvZFhTgHk+umHFAZaqShygh0WSw/oDFcxnMB/1KDLLX4
	mvcgLP56XbLSpnfT8axwxEnNLJsw9bInbNws1yFIkSYlky8Tmhj+l1D8rBqgIoM1qpo
	WJ92PAGYIoEykBkpAGVVRcsi5EyPG+mHi7odvda8=
Received: by mx.zohomail.com with SMTPS id 1761111628125731.0146033402801;
	Tue, 21 Oct 2025 22:40:28 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 16/29] sequencer: add trailers to message before writing file
Date: Wed, 22 Oct 2025 13:39:36 +0800
Message-ID: <20251022053951.602605-17-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Added trailer processing to the in-memory commit message
within do_pick_commit, ensuring fixup/squash commands
remain untouched before the message is written.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 sequencer.c | 19 ++++++++-----------
 trailer.c   |  4 ++--
 trailer.h   |  3 +++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5103ae786c..552e629e4f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2444,6 +2444,14 @@ static int do_pick_commit(struct repository *r,
 	if (opts->signoff && !is_fixup(command))
 		append_signoff(&ctx->message, 0, 0);
 
+	if (opts->trailer_args.nr && !is_fixup(command)) {
+		if (amend_strbuf_with_trailers(&ctx->message,
+					       &opts->trailer_args)) {
+			res = error(_("unable to add trailers to commit message"));
+			goto leave;
+		}
+	}
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy ||
@@ -2519,17 +2527,6 @@ static int do_pick_commit(struct repository *r,
 			oid_to_hex(&commit->object.oid), msg.subject);
 	} /* else allow == 0 and there's nothing special to do */
 
-	if (!res && opts->trailer_args.nr && !drop_commit) {
-		const char *trailer_file =
-			msg_file ? msg_file : git_path_merge_msg(r);
-
-		if (amend_file_with_trailers(trailer_file,
-						&opts->trailer_args)) {
-			res = error(_("unable to add trailers to commit message"));
-			goto leave;
-		}
-	}
-
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
diff --git a/trailer.c b/trailer.c
index 85e42859ca..3e96d1624a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1250,8 +1250,8 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-static int amend_strbuf_with_trailers(struct strbuf *buf,
-									  const struct strvec *trailer_args)
+int amend_strbuf_with_trailers(struct strbuf *buf,
+			       const struct strvec *trailer_args)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	LIST_HEAD(new_trailer_head);
diff --git a/trailer.h b/trailer.h
index 4654ff9c96..479bc137cd 100644
--- a/trailer.h
+++ b/trailer.h
@@ -197,6 +197,9 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+int amend_strbuf_with_trailers(struct strbuf *buf,
+			       const struct strvec *trailer_args);
+
 /*
  * Augment a file to add trailers to it (similar to 'git interpret-trailers').
  * Returns 0 on success or a non-zero error code on failure.
-- 
2.51.0

