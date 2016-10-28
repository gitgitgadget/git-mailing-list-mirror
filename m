Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849552035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034340AbcJ1S4Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:25 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36020 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034309AbcJ1S4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:18 -0400
Received: by mail-pf0-f169.google.com with SMTP id e6so41422097pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oabgskwnL5zI4Wc/wvCr46wYJRx3gi+sPEdHfeHqyX8=;
        b=cUzY4KmFndKs5YSVZT8gTcZoZwKuWM9zJeQ965+cs8UW/TXBplP5dbi/Jf6JJnkL6R
         wFeToh15W+M09UDw6MdEvf6VZnkniH9IBG+EqLbec8R/SZwzqtId7ABzLG3NmmCP7iO2
         hfYYR+BSKCX32PvkEa3nqiCcm8DH7eZN2Zu1cbEcxwCEyLv7LyfMA4MrpRF9MmSZMDUL
         OtyoyNkXD3pYD9DnIiwTUCzb5saOHGETQg7N1uquTV98WkJck6pNjyTQZOtTqon9LLTq
         rDmp3QShWrWIRwuycVK2wLo1dZd5FRUs7ysPZhRzVQmIs4XcWDRaOtoGWxv3rxrd97yM
         lyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oabgskwnL5zI4Wc/wvCr46wYJRx3gi+sPEdHfeHqyX8=;
        b=M/2zEd5OgI341cDnZTltJu5tgpPetZE/NVZzYsm92+6ZRXsNn8A6rzhJjO5YMTWAaS
         bWMjzsRSxBkCj0pmLLHu6WbECOr2uuYa2bVtpZi9rbSOdBMxZFr6IVAAnswKd/WoSdJB
         cPoFnFj9BUc7F2/T3NZx/iDRgh696f7UxRIkge/O26VX5TLRfD+yBLCf7yW3LjtXHjON
         Nz+WEtw/+dLEu54r49AtpN8YhrBYHy+BSIRMsY2HGbsf6h6LqGVMsOA+rcQeRG3FLIff
         /JWJfzesnAJFG3cySKuMaBIdb1fAOX0/tfzBCHC3FbtKIRZADSj4YHyHCDJ91lmwOJRH
         eaxQ==
X-Gm-Message-State: ABUngvdAXzur1rYyr04rUFTDzmLmzol6Mlzn+CamAYx9CtzozrH7PqNAZry2KKJ6a7DBsrn8
X-Received: by 10.98.73.21 with SMTP id w21mr5950443pfa.26.1477680977065;
        Fri, 28 Oct 2016 11:56:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id a140sm14466615pfa.14.2016.10.28.11.56.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 28/36] attr: keep attr stack for each check
Date:   Fri, 28 Oct 2016 11:54:54 -0700
Message-Id: <20161028185502.8789-29-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of having a global attr stack, attach the stack to each check.
This allows to use the attr in a multithreaded way.



Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c    | 101 +++++++++++++++++++++++++++++++++++++++-----------------------
 attr.h    |   4 ++-
 hashmap.h |   2 ++
 3 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 8c217ae593..a143807698 100644
--- a/attr.c
+++ b/attr.c
@@ -375,15 +375,17 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * .gitignore file and info/excludes file as a fallback.
  */
 
-/* NEEDSWORK: This will become per git_attr_check */
-static struct attr_stack {
+struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
 	size_t originlen;
 	unsigned num_matches;
 	unsigned alloc;
 	struct match_attr **attrs;
-} *attr_stack;
+};
+
+static struct hashmap all_attr_stacks;
+static int all_attr_stacks_init;
 
 static void free_attr_elem(struct attr_stack *e)
 {
@@ -564,11 +566,23 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 
 static void drop_attr_stack(void)
 {
-	while (attr_stack) {
-		struct attr_stack *elem = attr_stack;
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
+	struct hashmap_iter iter;
+	struct git_attr_check *check;
+
+	attr_lock();
+	if (!all_attr_stacks_init) {
+		attr_unlock();
+		return;
 	}
+	hashmap_iter_init(&all_attr_stacks, &iter);
+	while ((check = hashmap_iter_next(&iter))) {
+		while (check->attr_stack) {
+			struct attr_stack *elem = check->attr_stack;
+			check->attr_stack = elem->prev;
+			free_attr_elem(elem);
+		}
+	}
+	attr_unlock();
 }
 
 static const char *git_etc_gitattributes(void)
@@ -598,30 +612,31 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(void)
+static void bootstrap_attr_stack(struct git_attr_check *check)
 {
 	struct attr_stack *elem;
 
-	if (attr_stack)
+	if (check->attr_stack)
 		return;
 
-	push_stack(&attr_stack, read_attr_from_array(builtin_attr), NULL, 0);
+	push_stack(&check->attr_stack,
+		   read_attr_from_array(builtin_attr), NULL, 0);
 
 	if (git_attr_system())
-		push_stack(&attr_stack,
+		push_stack(&check->attr_stack,
 			   read_attr_from_file(git_etc_gitattributes(), 1),
 			   NULL, 0);
 
 	if (!git_attributes_file)
 		git_attributes_file = xdg_config_home("attributes");
 	if (git_attributes_file)
-		push_stack(&attr_stack,
+		push_stack(&check->attr_stack,
 			   read_attr_from_file(git_attributes_file, 1),
 			   NULL, 0);
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
 		elem = read_attr(GITATTRIBUTES_FILE, 1);
-		push_stack(&attr_stack, elem, xstrdup(""), 0);
+		push_stack(&check->attr_stack, elem, xstrdup(""), 0);
 		debug_push(elem);
 	}
 
@@ -632,10 +647,11 @@ static void bootstrap_attr_stack(void)
 
 	if (!elem)
 		elem = xcalloc(1, sizeof(*elem));
-	push_stack(&attr_stack, elem, NULL, 0);
+	push_stack(&check->attr_stack, elem, NULL, 0);
 }
 
-static void prepare_attr_stack(const char *path, int dirlen)
+static void prepare_attr_stack(const char *path, int dirlen,
+			       struct git_attr_check *check)
 {
 	struct attr_stack *elem, *info;
 	const char *cp;
@@ -655,13 +671,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack();
+	bootstrap_attr_stack(check);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
 	 */
-	info = attr_stack;
-	attr_stack = info->prev;
+	info = check->attr_stack;
+	check->attr_stack = info->prev;
 
 	/*
 	 * Pop the ones from directories that are not the prefix of
@@ -669,17 +685,17 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * the root one (whose origin is an empty string "") or the builtin
 	 * one (whose origin is NULL) without popping it.
 	 */
-	while (attr_stack->origin) {
-		int namelen = strlen(attr_stack->origin);
+	while (check->attr_stack->origin) {
+		int namelen = strlen(check->attr_stack->origin);
 
-		elem = attr_stack;
+		elem = check->attr_stack;
 		if (namelen <= dirlen &&
 		    !strncmp(elem->origin, path, namelen) &&
 		    (!namelen || path[namelen] == '/'))
 			break;
 
 		debug_pop(elem);
-		attr_stack = elem->prev;
+		check->attr_stack = elem->prev;
 		free_attr_elem(elem);
 	}
 
@@ -695,9 +711,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		 */
 		struct strbuf pathbuf = STRBUF_INIT;
 
-		assert(attr_stack->origin);
+		assert(check->attr_stack->origin);
 		while (1) {
-			size_t len = strlen(attr_stack->origin);
+			size_t len = strlen(check->attr_stack->origin);
 			char *origin;
 
 			if (dirlen <= len)
@@ -711,7 +727,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 			elem = read_attr(pathbuf.buf, 0);
 			strbuf_setlen(&pathbuf, cp - path);
 			origin = strbuf_detach(&pathbuf, &len);
-			push_stack(&attr_stack, elem, origin, len);
+			push_stack(&check->attr_stack, elem, origin, len);
 			debug_push(elem);
 		}
 
@@ -721,7 +737,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-	push_stack(&attr_stack, info, NULL, 0);
+	push_stack(&check->attr_stack, info, NULL, 0);
+	if (!all_attr_stacks_init) {
+		hashmap_init(&all_attr_stacks, NULL, 0);
+		all_attr_stacks_init = 1;
+	}
+	if (!hashmap_get(&all_attr_stacks, check, NULL))
+		hashmap_put(&all_attr_stacks, check);
 }
 
 static int path_matches(const char *pathname, int pathlen,
@@ -747,9 +769,10 @@ static int path_matches(const char *pathname, int pathlen,
 			      pattern, prefix, pat->patternlen, pat->flags);
 }
 
-static int macroexpand_one(int attr_nr, int rem);
+static int macroexpand_one(int attr_nr, int rem, struct git_attr_check *check);
 
-static int fill_one(const char *what, struct match_attr *a, int rem)
+static int fill_one(const char *what, struct match_attr *a, int rem,
+		    struct git_attr_check *check)
 {
 	struct git_attr_check_elem *celem = check_all_attr;
 	int i;
@@ -765,14 +788,14 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 				  attr, v);
 			*n = v;
 			rem--;
-			rem = macroexpand_one(attr->attr_nr, rem);
+			rem = macroexpand_one(attr->attr_nr, rem, check);
 		}
 	}
 	return rem;
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, int rem)
+		struct attr_stack *stk, int rem, struct git_attr_check *check)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -783,12 +806,12 @@ static int fill(const char *path, int pathlen, int basename_offset,
 			continue;
 		if (path_matches(path, pathlen, basename_offset,
 				 &a->u.pat, base, stk->originlen))
-			rem = fill_one("fill", a, rem);
+			rem = fill_one("fill", a, rem, check);
 	}
 	return rem;
 }
 
-static int macroexpand_one(int nr, int rem)
+static int macroexpand_one(int nr, int rem, struct git_attr_check *check)
 {
 	struct attr_stack *stk;
 	int i;
@@ -797,13 +820,13 @@ static int macroexpand_one(int nr, int rem)
 	    !check_all_attr[nr].attr->maybe_macro)
 		return rem;
 
-	for (stk = attr_stack; stk; stk = stk->prev) {
+	for (stk = check->attr_stack; stk; stk = stk->prev) {
 		for (i = stk->num_matches - 1; 0 <= i; i--) {
 			struct match_attr *ma = stk->attrs[i];
 			if (!ma->is_macro)
 				continue;
 			if (ma->u.attr->attr_nr == nr)
-				return fill_one("expand", ma, rem);
+				return fill_one("expand", ma, rem, check);
 		}
 	}
 
@@ -852,7 +875,7 @@ static void collect_some_attrs(const char *path, int pathlen,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(path, dirlen);
+	prepare_attr_stack(path, dirlen, check);
 
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
@@ -872,8 +895,8 @@ static void collect_some_attrs(const char *path, int pathlen,
 	}
 
 	rem = attr_nr;
-	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, rem);
+	for (stk = check->attr_stack; 0 < rem && stk; stk = stk->prev)
+		rem = fill(path, pathlen, basename_offset, stk, rem, check);
 
 	if (collect_all) {
 		int check_nr = 0, check_alloc = 0;
@@ -906,6 +929,8 @@ static int git_check_attrs(const char *path, int pathlen,
 {
 	int i;
 
+	attr_lock();
+
 	collect_some_attrs(path, pathlen, check, &result, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
@@ -915,6 +940,8 @@ static int git_check_attrs(const char *path, int pathlen,
 		result[i].value = value;
 	}
 
+	attr_unlock();
+
 	return 0;
 }
 
diff --git a/attr.h b/attr.h
index daa2eeae83..e7534da318 100644
--- a/attr.h
+++ b/attr.h
@@ -30,12 +30,14 @@ extern const char git_attr__false[];
 #define ATTR_UNSET(v) ((v) == NULL)
 
 struct git_attr_check {
+	struct hashmap_entry entry;
 	int finalized;
 	int check_nr;
 	int check_alloc;
 	const struct git_attr **attr;
+	struct attr_stack *attr_stack;
 };
-#define GIT_ATTR_CHECK_INIT {0, 0, 0, NULL}
+#define GIT_ATTR_CHECK_INIT {HASHMAP_ENTRY_INIT, 0, 0, 0, NULL, NULL}
 
 struct git_attr_result {
 	const char *value;
diff --git a/hashmap.h b/hashmap.h
index ab7958ae33..d247c62970 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -31,6 +31,8 @@ struct hashmap_entry {
 	unsigned int hash;
 };
 
+#define HASHMAP_ENTRY_INIT {NULL, 0}
+
 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
 		const void *keydata);
 
-- 
2.10.1.714.ge3da0db

