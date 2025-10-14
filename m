Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D231352D
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444863; cv=pass; b=FbV+eCvMYFjsHZl8KLYS/CgJvDGwK599J8WWlR3HxhJHEKiKSVE3e0tyj19i3xMB/kKzffGtICAGuWsxSR2n/1eh3+KIxnXbY5vv/YPR4eTp1JQTZDV3armBFD/Pwfk7dgaj7LDyCAvtI7dNPq+LLJDkmpUi0nEVdM52M3/ffas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444863; c=relaxed/simple;
	bh=+8dyEn2/IRLLpyGqMc+DQaw0m2neQVYK+vP8E76HSsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH5JJaR4XB+0sze7xnNc2Vy4QKF8EN0ug2ofzDoYiVJMnjQSsJCD4bXEPT21H2klyBdNII/v5PNXHOWFtehGfzvRxVfNy5BURIMCkAD+jm1bwdqv9oEs0NJeS4C9ZUJalnlFirPj74YelJou4lczhzeznYaYTqi6LFnHN4UV0LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=oT0DUEu9; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="oT0DUEu9"
ARC-Seal: i=1; a=rsa-sha256; t=1760444750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QEQ4OE7LuQ7GEwHzB3/TJvDWCIhYgzyiPe5xDC6oW0/sRNFIa1+oGHm9PfgV8a8mSKFEGs4Y58KzjID5yY2zGlRGwfDER3fxDqYe5v4l5C/mo7zkvU1zB49CkK21kw9yqTH83vs+H9TvqkWLa+vE3PtSJBCwgG3c2hQXp8S/FyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444750; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=29oBenzBktculL+mwrHeJOmh0rPp4cGNz+DNGWKZQlo=; 
	b=gN+bg+Lo4nt+3GHHdnzT1stkCdtvd1oIxvHAxkpf8qcJH0QzCkYwUkKnIpEL2KHwjvrtXSeLw67oVxogAoBNtcgifj9bKgJtHZMOLb4uINxLrwBX0Wvnz5fi7LFzsNsxeg8kHJROAsmhkBtfkaIXBdmUS2ZP5lUyCn21DhoR9sQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444750;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=29oBenzBktculL+mwrHeJOmh0rPp4cGNz+DNGWKZQlo=;
	b=oT0DUEu9zZcXkRsnkFGL/0is4Zgj7mhPA6IGZmY64ZSpFAaVIE0tzGC2EoqCnl8F
	nJiZ/aZXJS8IoWTK7gi0iYIMyt2lrxluQl2+qmXyfVqOX9n7X7Ynqk95g5vVljxNAbJ
	/7+Lk6RWLWdnD4wsc5nYi1jw8NfU6ksTb9GyllHU=
Received: by mx.zohomail.com with SMTPS id 1760444747774662.450718066609;
	Tue, 14 Oct 2025 05:25:47 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 16/29] sequencer: add trailers to message before writing file
Date: Tue, 14 Oct 2025 20:24:29 +0800
Message-ID: <20251014122452.1851103-17-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
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
index 5ff518b436..fb691c6400 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1250,8 +1250,8 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-static int amend_strbuf_with_trailers(struct strbuf *buf,
-									  const struct strvec *trailer_args)
+int amend_strbuf_with_trailers(struct strbuf *buf,
+       const struct strvec *trailer_args)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	LIST_HEAD(new_trailer_head);
diff --git a/trailer.h b/trailer.h
index 28719aa480..e4b1de855e 100644
--- a/trailer.h
+++ b/trailer.h
@@ -197,6 +197,9 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+int amend_strbuf_with_trailers(struct strbuf *buf,
+       const struct strvec *trailer_args);
+
 /*
  * Augment a file to add trailers to it (similar to 'git interpret-trailers').
  * Returns 0 on success or a non-zero error code on failure.
-- 
2.51.0

