Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A44973BE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461815; cv=none; b=Teemw0vK24zbgiqe+Mp+wPucCMCX6Cy78ulx4l5Ai5MERvhinB71IGmeSGFwJbUQf7uj0H1g+zdwRi9S2Ho+d1qMmW8QtKGf3tjW2FvkIgAuMhh0AqnuChYBIb93LrlxdPq+XCuj3iX1GCggm0gRCDVvzdN8FbXMJSB3sKyfnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461815; c=relaxed/simple;
	bh=cQQzwOkqKoY46SzsNRyv8VV/swaasZmpFy77Xr8zWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJEqV2LloJnL3e/DVfprgnxOrPeUzPi8GOlRu5QKzpOo4yY2nGw5MtxEx3/FjHOyI7U8l8ib8fBJHCWETqcNp2mfz8BeYlYXmMN5RL4/F5jjF00G0wtzFx7WeGT3OPlN8NyC9rezQKNaktSt4eWXdXjP6kTHwF01nwzyQKUo7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=h7D2Qogg; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="h7D2Qogg"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKjXSxhgC/b2h7mVBmDAkXD8WgmB2DNZh0ldDZxjxiA=;
	b=h7D2QoggsoKXc0gUMr3+11fj/iJ1xJJyZUAqe6LvqOqA548HXyst4utexPZ9lEUG2NqcDy
	WjSSZjo5H2GMA2KATQMiqbKCo1znOjfXWFXkiJCIYiiVv80iPitQZMRIU8CoBkTkVxtqTK
	r0WdxQ5paDY2Et2ixWMrbm1kIFvfCdgsmK70ekZmWu+117X4IY9QQ59OUaY6h6UlGm5zNp
	k0VjpULE2xfZN5j6yAQgINJu2HEvOVfR2g02K57oNCLuUKcihm3ag3NxNuXkuo+l24+Yls
	EMx4PtDUU3DqAwGccRX1fTMSLTUETa+8loPpWEqVzhLbxjbWjwFDLLuip54zDA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [RFC PATCH 2/6] dir.h: replace pattern macros with enum in attr.h
Date: Thu,  8 Oct 2026 14:06:58 +0200
Message-ID: <adbfbf5aab70bdf8cdb2ac080ed79a3144edcb8d.1791460418.git.mroik@delayed.space>
In-Reply-To: <cover.1791460418.git.mroik@delayed.space>
References: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3774; i=mroik@delayed.space; h=from:subject:message-id; bh=cQQzwOkqKoY46SzsNRyv8VV/swaasZmpFy77Xr8zWdw=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqx4dh1cVeaAUFRXCoRVz2dlu/fYqmWOBYTWbOY weQDq08hImJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaseHYQAKCRBIeX6hnBm+ 0Tf6D/9h+O+buozVxqvaj3LI4EtbRSpWpUrtXoSG53H9fP8mgzLo1573VH27r1WhJbS4z92ocmA XOblCvkzCaATNpbdD4SpzVdwwOJ0bcVgs+paVKIbCugFjRmej5osM8fOkIGv7jri9OazR2DyE4e jTzYRGxOfQ5mJgbm0LrEypZx+TpsFalYR8fSxi/qrTlPn4ejBsenr6FiI43Nbb07u2CEQZK9WGO F+A/xS0ki9yeciU2lqfTQLMMY67i0BliSuVZi22LXgaAPJDxrXKGy71Vu0346wSFLpVES5m/lS4 YETXagRQZz8PufXqeG7K4axzUP1NQ4EOIYNLCrN06PwdFD6NzEArrg7hRQVuJ6MH77DIiGp1jSS f0hYe8CE9iJ4oZRJlK3dd+hkx0VuBHaGjyMHTksPceApihbHtSR5XRij8k5ZBIZ028q35yG9A3Y +b+f3Ghqhj35lFpQUJStAkxoMj+B3MZ3sak7coCraN5E01ZXSQTwxGTkNDb7LyWHLjhD2Mrfwnw 5PlJe1rQnetpapvMHA0bYJorfA8lmoGexmfw06h+qRNzJpzJzP27IOBOQdQJp1ZzBRmcQF1fYdA 5Qixuiaw5LP7hVD4KlFriGI/nipTxZrppQzuuI9+HBhnwR7yQOH+t8Ia18cVnV83BgNyXApe/Al SqL4ZJqoR
 QaDJbQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

dir.h defines some macros that are used in the dir.c machinery for
.gitignore files. These macros are only used for the pattern struct
defined in attr.h so it really should belong there.

Remove the macro definitions from dir.h and replace them with the
pattern_flags enum in attr.h.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 attr.h                    | 9 ++++++++-
 builtin/check-ignore.c    | 1 +
 builtin/sparse-checkout.c | 1 +
 dir.c                     | 5 +++--
 dir.h                     | 8 ++------
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/attr.h b/attr.h
index a04a521092..c083d47df5 100644
--- a/attr.h
+++ b/attr.h
@@ -250,11 +250,18 @@ struct attr_state {
 	const char *setto;
 };
 
+enum pattern_flags {
+	PATTERN_FLAG_NODIR = 1,
+	PATTERN_FLAG_ENDSWITH = 4,
+	PATTERN_FLAG_MUSTBEDIR = 8,
+	PATTERN_FLAG_NEGATIVE = 16,
+};
+
 struct pattern {
 	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
-	unsigned flags;		/* PATTERN_FLAG_* */
+	enum pattern_flags flags;	/* PATTERN_FLAG_* */
 };
 
 /*
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 644c9a414f..fdf7610178 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "submodule.h"
 #include "write-or-die.h"
+#include "attr.h"
 
 static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cb4a037b77..83981e2b1e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -20,6 +20,7 @@
 #include "setup.h"
 #include "sparse-index.h"
 #include "worktree.h"
+#include "attr.h"
 
 static const char *empty_base = "";
 
diff --git a/dir.c b/dir.c
index d896e7be4b..c6342c882a 100644
--- a/dir.c
+++ b/dir.c
@@ -36,6 +36,7 @@
 #include "trace2.h"
 #include "tree.h"
 #include "hex.h"
+#include "attr.h"
 
  /*
   * The maximum size of a pattern/exclude file. If the file exceeds this size
@@ -701,7 +702,7 @@ int no_wildcard(const char *string)
 
 void parse_path_pattern(const char **pattern,
 			   int *patternlen,
-			   unsigned *flags,
+			   enum pattern_flags *flags,
 			   int *nowildcardlen)
 {
 	const char *p = *pattern;
@@ -979,7 +980,7 @@ void add_pattern(const char *string, const char *base,
 {
 	struct path_pattern *pattern;
 	int patternlen;
-	unsigned flags;
+	enum pattern_flags flags;
 	int nowildcardlen;
 
 	parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen);
diff --git a/dir.h b/dir.h
index 83e0f648a8..210ee8a98d 100644
--- a/dir.h
+++ b/dir.h
@@ -6,6 +6,7 @@
 #include "pathspec.h"
 #include "statinfo.h"
 #include "strbuf.h"
+#include "attr.h"
 
 struct repository;
 
@@ -49,11 +50,6 @@ struct dir_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
 
-#define PATTERN_FLAG_NODIR 1
-#define PATTERN_FLAG_ENDSWITH 4
-#define PATTERN_FLAG_MUSTBEDIR 8
-#define PATTERN_FLAG_NEGATIVE 16
-
 struct path_pattern {
 	/*
 	 * This allows callers of last_matching_pattern() etc.
@@ -469,7 +465,7 @@ int add_patterns_from_blob_to_list(struct object_id *oid,
 int add_patterns_from_buffer(char *buf, size_t size,
 			     const char *base, int baselen,
 			     struct pattern_list *pl);
-void parse_path_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
+void parse_path_pattern(const char **string, int *patternlen, enum pattern_flags *flags, int *nowildcardlen);
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos);
 void clear_pattern_list(struct pattern_list *pl);
-- 
2.56.0

