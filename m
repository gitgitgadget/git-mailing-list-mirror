Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1B61F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 01:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbcJLB2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:28:47 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34536 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbcJLB2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:28:46 -0400
Received: by mail-pf0-f172.google.com with SMTP id 190so10793204pfv.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 18:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5g2fB0RcZ5MZp8l53hipGpFXax5F0pK07D+JUn7XpuA=;
        b=QWbWteB8ufUwVhpQr6CUYOGVaq9EYcIzv0hNL1OdydQBS7TeIXSISfklSDsFuih9uH
         yL2LJgcqi4h3vdu67v5sgfqjY4JUDjbe9DyGYQSOCKVOK7d1A+6HSDUf2IlDt3AFrh1t
         yuOCki9is4bneaaicTT+821IFw24FYKeG4KD5xm1gmNPryKdYE5OhmqGW9gtHufPodvv
         8oCcxu0AsTkszOIuu2wjQ1RF6lr47rZs6Xr0ScNq0EhOhV6YscuP4s3HWGmXIyNko8fm
         FC1lDYaaGA85Z6hFZLcVCc/FYBHR3MB2sTvYwG+CfuN2imegHsbpLSeO9LcwJRvBZcbD
         39vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5g2fB0RcZ5MZp8l53hipGpFXax5F0pK07D+JUn7XpuA=;
        b=lmE7giC2fFLrEqKSDnK9uQ3qWCcwUyGCagq2QMt2r/q5hjqSeVx4TkTm/1t8S+T/rx
         SiixQI8BO0qQX/5n0XoBQLuToFu8wfJd6wLmxUidNlmu0/SZAovWYE3ReV96rnR06y+q
         KgEp/EUWfFgLgEnh7uEkFy8cN5r8I8L46qGjKZrJn678G7m3hrIKmhz/eT6PLAXB4wxn
         4KOwv9QzFjwPLJqzGn08+JULvfyH9LcZU0x4nIip6EWYBOwlbkiIouBxccvJapV6Ckw/
         V3zEA+YN6F8ZASXIsXpbC5Jp0h687SIRJDTT2Qtg4+MRqY9Fppg3Y/EREf9W6EoJuJ8X
         mxAA==
X-Gm-Message-State: AA6/9RmsMR1TLKgJxhgF+j1QNqBKHK14vyR+rUWS02vCamSIlnb1LdeMA1ynfKQpnTk7VrWI
X-Received: by 10.99.119.205 with SMTP id s196mr5326048pgc.140.1476235415473;
        Tue, 11 Oct 2016 18:23:35 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b11sm7175042pfb.49.2016.10.11.18.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 18:23:34 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, gitster@pobox.com
Subject: [PATCH 1/5] trailer: use singly-linked list, not doubly
Date:   Tue, 11 Oct 2016 18:23:25 -0700
Message-Id: <8e12e0954f0a23d7c7905c58a3f7d8084d9338be.1476232683.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use singly-linked lists (instead of doubly-linked lists) in trailer to
keep track of arguments (whether implicit from configuration or explicit
from the command line) and trailer items.

This change significantly reduces the code length and simplifies the code.
There are now fewer pointers to be manipulated, but most trailer
manipulations now require seeking from beginning to end, so there might
be a slight net decrease in performance; however the number of trailers
is usually small (10 to 15 at the most) so this should not cause a big
impact.
---
 trailer.c | 357 ++++++++++++++++++++++----------------------------------------
 1 file changed, 125 insertions(+), 232 deletions(-)

diff --git a/trailer.c b/trailer.c
index c6ea9ac..bf3d7d0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -25,7 +25,6 @@ struct conf_info {
 static struct conf_info default_conf_info;
 
 struct trailer_item {
-	struct trailer_item *previous;
 	struct trailer_item *next;
 	const char *token;
 	const char *value;
@@ -56,7 +55,8 @@ static size_t token_len_without_separator(const char *token, size_t len)
 	return len;
 }
 
-static int same_token(struct trailer_item *a, struct trailer_item *b)
+static int same_token(const struct trailer_item *a,
+		      const struct trailer_item *b)
 {
 	size_t a_len = token_len_without_separator(a->token, strlen(a->token));
 	size_t b_len = token_len_without_separator(b->token, strlen(b->token));
@@ -65,12 +65,14 @@ static int same_token(struct trailer_item *a, struct trailer_item *b)
 	return !strncasecmp(a->token, b->token, min_len);
 }
 
-static int same_value(struct trailer_item *a, struct trailer_item *b)
+static int same_value(const struct trailer_item *a,
+		      const struct trailer_item *b)
 {
 	return !strcasecmp(a->value, b->value);
 }
 
-static int same_trailer(struct trailer_item *a, struct trailer_item *b)
+static int same_trailer(const struct trailer_item *a,
+			const struct trailer_item *b)
 {
 	return same_token(a, b) && same_value(a, b);
 }
@@ -129,92 +131,6 @@ static void print_all(FILE *outfile, struct trailer_item *first, int trim_empty)
 	}
 }
 
-static void update_last(struct trailer_item **last)
-{
-	if (*last)
-		while ((*last)->next != NULL)
-			*last = (*last)->next;
-}
-
-static void update_first(struct trailer_item **first)
-{
-	if (*first)
-		while ((*first)->previous != NULL)
-			*first = (*first)->previous;
-}
-
-static void add_arg_to_input_list(struct trailer_item *on_tok,
-				  struct trailer_item *arg_tok,
-				  struct trailer_item **first,
-				  struct trailer_item **last)
-{
-	if (after_or_end(arg_tok->conf.where)) {
-		arg_tok->next = on_tok->next;
-		on_tok->next = arg_tok;
-		arg_tok->previous = on_tok;
-		if (arg_tok->next)
-			arg_tok->next->previous = arg_tok;
-		update_last(last);
-	} else {
-		arg_tok->previous = on_tok->previous;
-		on_tok->previous = arg_tok;
-		arg_tok->next = on_tok;
-		if (arg_tok->previous)
-			arg_tok->previous->next = arg_tok;
-		update_first(first);
-	}
-}
-
-static int check_if_different(struct trailer_item *in_tok,
-			      struct trailer_item *arg_tok,
-			      int check_all)
-{
-	enum action_where where = arg_tok->conf.where;
-	do {
-		if (!in_tok)
-			return 1;
-		if (same_trailer(in_tok, arg_tok))
-			return 0;
-		/*
-		 * if we want to add a trailer after another one,
-		 * we have to check those before this one
-		 */
-		in_tok = after_or_end(where) ? in_tok->previous : in_tok->next;
-	} while (check_all);
-	return 1;
-}
-
-static void remove_from_list(struct trailer_item *item,
-			     struct trailer_item **first,
-			     struct trailer_item **last)
-{
-	struct trailer_item *next = item->next;
-	struct trailer_item *previous = item->previous;
-
-	if (next) {
-		item->next->previous = previous;
-		item->next = NULL;
-	} else if (last)
-		*last = previous;
-
-	if (previous) {
-		item->previous->next = next;
-		item->previous = NULL;
-	} else if (first)
-		*first = next;
-}
-
-static struct trailer_item *remove_first(struct trailer_item **first)
-{
-	struct trailer_item *item = *first;
-	*first = item->next;
-	if (item->next) {
-		item->next->previous = NULL;
-		item->next = NULL;
-	}
-	return item;
-}
-
 static const char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
@@ -263,122 +179,116 @@ static void apply_item_command(struct trailer_item *in_tok, struct trailer_item
 	}
 }
 
-static void apply_arg_if_exists(struct trailer_item *in_tok,
-				struct trailer_item *arg_tok,
-				struct trailer_item *on_tok,
-				struct trailer_item **in_tok_first,
-				struct trailer_item **in_tok_last)
+static void apply_existing_arg(struct trailer_item **found_next,
+			       struct trailer_item *arg_tok,
+			       struct trailer_item **position_to_add,
+			       const struct trailer_item *in_tok_head,
+			       const struct trailer_item *neighbor)
 {
-	switch (arg_tok->conf.if_exists) {
-	case EXISTS_DO_NOTHING:
+	if (arg_tok->conf.if_exists == EXISTS_DO_NOTHING) {
 		free_trailer_item(arg_tok);
-		break;
-	case EXISTS_REPLACE:
-		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok,
-				      in_tok_first, in_tok_last);
-		remove_from_list(in_tok, in_tok_first, in_tok_last);
-		free_trailer_item(in_tok);
-		break;
-	case EXISTS_ADD:
-		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok,
-				      in_tok_first, in_tok_last);
-		break;
-	case EXISTS_ADD_IF_DIFFERENT:
-		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(in_tok, arg_tok, 1))
-			add_arg_to_input_list(on_tok, arg_tok,
-					      in_tok_first, in_tok_last);
-		else
-			free_trailer_item(arg_tok);
-		break;
-	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
-		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(on_tok, arg_tok, 0))
-			add_arg_to_input_list(on_tok, arg_tok,
-					      in_tok_first, in_tok_last);
-		else
+		return;
+	}
+
+	apply_item_command(*found_next, arg_tok);
+
+	if (arg_tok->conf.if_exists == EXISTS_ADD_IF_DIFFERENT_NEIGHBOR) {
+		if (neighbor && same_trailer(neighbor, arg_tok)) {
 			free_trailer_item(arg_tok);
-		break;
+			return;
+		}
+	} else if (arg_tok->conf.if_exists == EXISTS_ADD_IF_DIFFERENT) {
+		const struct trailer_item *in_tok;
+		for (in_tok = in_tok_head; in_tok; in_tok = in_tok->next) {
+			if (same_trailer(in_tok, arg_tok)) {
+				free_trailer_item(arg_tok);
+				return;
+			}
+		}
+	}
+
+	arg_tok->next = *position_to_add;
+	*position_to_add = arg_tok;
+
+	if (arg_tok->conf.if_exists == EXISTS_REPLACE) {
+		struct trailer_item *new_next = (*found_next)->next;
+		free_trailer_item(*found_next);
+		*found_next = new_next;
 	}
 }
 
-static void apply_arg_if_missing(struct trailer_item **in_tok_first,
-				 struct trailer_item **in_tok_last,
-				 struct trailer_item *arg_tok)
+static void apply_missing_arg(struct trailer_item *arg_tok,
+			      struct trailer_item **position_to_add)
 {
-	struct trailer_item **in_tok;
-	enum action_where where;
-
-	switch (arg_tok->conf.if_missing) {
-	case MISSING_DO_NOTHING:
+	if (arg_tok->conf.if_missing == MISSING_DO_NOTHING) {
 		free_trailer_item(arg_tok);
-		break;
-	case MISSING_ADD:
-		where = arg_tok->conf.where;
-		in_tok = after_or_end(where) ? in_tok_last : in_tok_first;
-		apply_item_command(NULL, arg_tok);
-		if (*in_tok) {
-			add_arg_to_input_list(*in_tok, arg_tok,
-					      in_tok_first, in_tok_last);
-		} else {
-			*in_tok_first = arg_tok;
-			*in_tok_last = arg_tok;
-		}
-		break;
+		return;
 	}
+
+	apply_item_command(NULL, arg_tok);
+
+	arg_tok->next = *position_to_add;
+	*position_to_add = arg_tok;
 }
 
-static int find_same_and_apply_arg(struct trailer_item **in_tok_first,
-				   struct trailer_item **in_tok_last,
-				   struct trailer_item *arg_tok)
+static void apply_arg(struct trailer_item **in_tok_head,
+		      struct trailer_item *arg_tok)
 {
-	struct trailer_item *in_tok;
-	struct trailer_item *on_tok;
-	struct trailer_item *following_tok;
-
+	struct trailer_item **next, **found_next = NULL, *last = NULL;
 	enum action_where where = arg_tok->conf.where;
-	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
 	int backwards = after_or_end(where);
-	struct trailer_item *start_tok = backwards ? *in_tok_last : *in_tok_first;
 
-	for (in_tok = start_tok; in_tok; in_tok = following_tok) {
-		following_tok = backwards ? in_tok->previous : in_tok->next;
-		if (!same_token(in_tok, arg_tok))
-			continue;
-		on_tok = middle ? in_tok : start_tok;
-		apply_arg_if_exists(in_tok, arg_tok, on_tok,
-				    in_tok_first, in_tok_last);
-		return 1;
+	for (next = in_tok_head; *next; next = &(*next)->next) {
+		last = *next;
+		if ((!found_next || backwards) &&
+		    same_token(*next, arg_tok))
+			found_next = next;
+	}
+
+	if (found_next) {
+		struct trailer_item **position_to_add, *neighbor;
+		switch (where) {
+		case WHERE_START:
+			position_to_add = in_tok_head;
+			neighbor = *in_tok_head;
+			break;
+		case WHERE_BEFORE:
+			position_to_add = found_next;
+			neighbor = *found_next;
+			break;
+		case WHERE_AFTER:
+			position_to_add = &(*found_next)->next;
+			neighbor = *found_next;
+			break;
+		default:
+			position_to_add = next;
+			neighbor = last;
+			break;
+		}
+		apply_existing_arg(found_next, arg_tok, position_to_add,
+				   *in_tok_head, neighbor);
+	} else {
+		struct trailer_item **position_to_add;
+		switch (where) {
+		case WHERE_START:
+		case WHERE_BEFORE:
+			position_to_add = in_tok_head;
+			break;
+		default:
+			position_to_add = next;
+			break;
+		}
+		apply_missing_arg(arg_tok, position_to_add);
 	}
-	return 0;
 }
 
-static void process_trailers_lists(struct trailer_item **in_tok_first,
-				   struct trailer_item **in_tok_last,
-				   struct trailer_item **arg_tok_first)
+static void process_trailers_lists(struct trailer_item **in_tok_head,
+				   struct trailer_item *arg_tok_head)
 {
-	struct trailer_item *arg_tok;
-	struct trailer_item *next_arg;
-
-	if (!*arg_tok_first)
-		return;
-
-	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
-		int applied = 0;
-
-		next_arg = arg_tok->next;
-		remove_from_list(arg_tok, arg_tok_first, NULL);
-
-		applied = find_same_and_apply_arg(in_tok_first,
-						  in_tok_last,
-						  arg_tok);
-
-		if (!applied)
-			apply_arg_if_missing(in_tok_first,
-					     in_tok_last,
-					     arg_tok);
+	struct trailer_item *arg_tok, *next;
+	for (arg_tok = arg_tok_head; arg_tok; arg_tok = next) {
+		next = arg_tok->next;
+		apply_arg(in_tok_head, arg_tok);
 	}
 }
 
@@ -438,29 +348,19 @@ static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
 
 static struct trailer_item *get_conf_item(const char *name)
 {
+	struct trailer_item **next = &first_conf_item;
 	struct trailer_item *item;
-	struct trailer_item *previous;
 
 	/* Look up item with same name */
-	for (previous = NULL, item = first_conf_item;
-	     item;
-	     previous = item, item = item->next) {
-		if (!strcasecmp(item->conf.name, name))
-			return item;
-	}
+	for (next = &first_conf_item; *next; next = &(*next)->next)
+		if (!strcasecmp((*next)->conf.name, name))
+			return *next;
 
 	/* Item does not already exists, create it */
 	item = xcalloc(sizeof(struct trailer_item), 1);
 	duplicate_conf(&item->conf, &default_conf_info);
 	item->conf.name = xstrdup(name);
-
-	if (!previous)
-		first_conf_item = item;
-	else {
-		previous->next = item;
-		item->previous = previous;
-	}
-
+	*next = item;
 	return item;
 }
 
@@ -652,26 +552,19 @@ static struct trailer_item *create_trailer_item(const char *string)
 				strbuf_detach(&val, NULL));
 }
 
-static void add_trailer_item(struct trailer_item **first,
-			     struct trailer_item **last,
+static void add_trailer_item(struct trailer_item ***tail,
 			     struct trailer_item *new)
 {
 	if (!new)
 		return;
-	if (!*last) {
-		*first = new;
-		*last = new;
-	} else {
-		(*last)->next = new;
-		new->previous = *last;
-		*last = new;
-	}
+	**tail = new;
+	*tail = &new->next;
 }
 
 static struct trailer_item *process_command_line_args(struct string_list *trailers)
 {
-	struct trailer_item *arg_tok_first = NULL;
-	struct trailer_item *arg_tok_last = NULL;
+	struct trailer_item *arg_tok_head = NULL;
+	struct trailer_item **arg_tok_tail = &arg_tok_head;
 	struct string_list_item *tr;
 	struct trailer_item *item;
 
@@ -679,17 +572,17 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 	for (item = first_conf_item; item; item = item->next) {
 		if (item->conf.command) {
 			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
-			add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+			add_trailer_item(&arg_tok_tail, new);
 		}
 	}
 
 	/* Add a trailer item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
 		struct trailer_item *new = create_trailer_item(tr->string);
-		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+		add_trailer_item(&arg_tok_tail, new);
 	}
 
-	return arg_tok_first;
+	return arg_tok_head;
 }
 
 static struct strbuf **read_input_file(const char *file)
@@ -805,8 +698,7 @@ static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end
 
 static int process_input_file(FILE *outfile,
 			      struct strbuf **lines,
-			      struct trailer_item **in_tok_first,
-			      struct trailer_item **in_tok_last)
+			      struct trailer_item ***in_tok_tail)
 {
 	int count = 0;
 	int patch_start, trailer_start, trailer_end, i;
@@ -829,18 +721,19 @@ static int process_input_file(FILE *outfile,
 	for (i = trailer_start; i < trailer_end; i++) {
 		if (lines[i]->buf[0] != comment_line_char) {
 			struct trailer_item *new = create_trailer_item(lines[i]->buf);
-			add_trailer_item(in_tok_first, in_tok_last, new);
+			add_trailer_item(in_tok_tail, new);
 		}
 	}
 
 	return trailer_end;
 }
 
-static void free_all(struct trailer_item **first)
+static void free_all(struct trailer_item *head)
 {
-	while (*first) {
-		struct trailer_item *item = remove_first(first);
-		free_trailer_item(item);
+	while (head) {
+		struct trailer_item *next = head->next;
+		free_trailer_item(head);
+		head = next;
 	}
 }
 
@@ -877,9 +770,9 @@ static FILE *create_in_place_tempfile(const char *file)
 
 void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
 {
-	struct trailer_item *in_tok_first = NULL;
-	struct trailer_item *in_tok_last = NULL;
-	struct trailer_item *arg_tok_first;
+	struct trailer_item *in_tok_head = NULL;
+	struct trailer_item **in_tok_tail = &in_tok_head;
+	struct trailer_item *arg_tok_head;
 	struct strbuf **lines;
 	int trailer_end;
 	FILE *outfile = stdout;
@@ -894,15 +787,15 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
+	trailer_end = process_input_file(outfile, lines, &in_tok_tail);
 
-	arg_tok_first = process_command_line_args(trailers);
+	arg_tok_head = process_command_line_args(trailers);
 
-	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
+	process_trailers_lists(&in_tok_head, arg_tok_head);
 
-	print_all(outfile, in_tok_first, trim_empty);
+	print_all(outfile, in_tok_head, trim_empty);
 
-	free_all(&in_tok_first);
+	free_all(in_tok_head);
 
 	/* Print the lines after the trailers as is */
 	print_lines(outfile, lines, trailer_end, INT_MAX);
-- 
2.8.0.rc3.226.g39d4020

