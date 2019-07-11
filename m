Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82651F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfGKQJJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34444 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKQJI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so6950907wrm.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHvYJZH4IZ7ELFv3K/QTLwxkP5gJcypPwWDqRBGoxgc=;
        b=hz4QMHZtYWLZOt71DBMge8+SkBvbsKw713noWuuH4P2fQybYI3GK6E7j1IQZNlnPps
         a22ViiCrSspGkBQrwRUbMg8PhiJ+9Vrg5HVV2Im6GWUrrMbbyYGhErEkYp27QAqrEIfK
         5FWM7nWKeAeV28fi4Yy6EeEkJCTuK7VRU28NBuWRY3jChf7uffUQInQ3Xfa6J/eZUvSl
         BS9UrL6Yki+EoNJdFyd9tqXuFAsZDpFBeHvyqQJBQa72KeGl5fOJxjfwAVCN/cM2q6Rj
         h1ElHmmPZinIJeEhmeEK6IOK1GJJwjMjzzQI7hi83VFYrbX0pqgp8BSDOJEq6HlQmNQw
         /oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHvYJZH4IZ7ELFv3K/QTLwxkP5gJcypPwWDqRBGoxgc=;
        b=KG0gYQ4gTEMgIAe3SeXu7WgTqyMZqFGL9pxs/h1Mk6+Kh08+gvQ2g3KoWf/p+XOY8V
         n23QgZGtCNBG2QVxDX/3dgj3/BA/zg/rI9ehs7BKAPO5Jt6+FOazYuVUvC6e/zjkAnNO
         If1E37CK8ArsLiDqcPI9eWbNP3Kf+6ceCRU7LqF8mtrlmQKm8eAO4gqU5R/5F7XlyAaK
         VM84JciVUPESRuGcKITVxzB3fQWro8BOq1aDHgtvPpi8ylez47FzF5QpnYrdyH9tp+dr
         5rGOWz86wiheFmF5PL4m4Ie6xuwKozSoyt/eepTR1JxMeeFf1OmioNAbTgG8ZKQioCuE
         b74w==
X-Gm-Message-State: APjAAAX+6NUfJ6Pg/XfdC4dZjoTxtONFbOvu0mIT4gl2qTbU5gNe5YJ2
        IF7wckkK0mqpBqeDG4MOBcENsHliQ4I=
X-Google-Smtp-Source: APXvYqzINZ95tZfCVXdbhc8VW1MeMj4P+aPTWyrbaJGjokECrdip9TT5d8+7R9o1FgnuoGbYnZS4gA==
X-Received: by 2002:adf:a70b:: with SMTP id c11mr6235152wrd.172.1562861346706;
        Thu, 11 Jul 2019 09:09:06 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id t15sm5929546wrx.84.2019.07.11.09.09.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 05/14] apply: only pass required data to find_name_*
Date:   Thu, 11 Jul 2019 17:08:42 +0100
Message-Id: <20190711160851.14380-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'find_name_*()' functions take 'struct apply_state' as
parameter, even though they only need the 'root' member from that
struct.

These functions are in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/apply.c b/apply.c
index 1602fd5db0..3cd4e3d3b3 100644
--- a/apply.c
+++ b/apply.c
@@ -469,7 +469,7 @@ static char *squash_slash(char *name)
 	return name;
 }
 
-static char *find_name_gnu(struct apply_state *state,
+static char *find_name_gnu(struct strbuf *root,
 			   const char *line,
 			   int p_value)
 {
@@ -495,8 +495,8 @@ static char *find_name_gnu(struct apply_state *state,
 	}
 
 	strbuf_remove(&name, 0, cp - name.buf);
-	if (state->root.len)
-		strbuf_insert(&name, 0, state->root.buf, state->root.len);
+	if (root->len)
+		strbuf_insert(&name, 0, root->buf, root->len);
 	return squash_slash(strbuf_detach(&name, NULL));
 }
 
@@ -659,7 +659,7 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 	return line + len - end;
 }
 
-static char *find_name_common(struct apply_state *state,
+static char *find_name_common(struct strbuf *root,
 			      const char *line,
 			      const char *def,
 			      int p_value,
@@ -702,30 +702,30 @@ static char *find_name_common(struct apply_state *state,
 			return squash_slash(xstrdup(def));
 	}
 
-	if (state->root.len) {
-		char *ret = xstrfmt("%s%.*s", state->root.buf, len, start);
+	if (root->len) {
+		char *ret = xstrfmt("%s%.*s", root->buf, len, start);
 		return squash_slash(ret);
 	}
 
 	return squash_slash(xmemdupz(start, len));
 }
 
-static char *find_name(struct apply_state *state,
+static char *find_name(struct strbuf *root,
 		       const char *line,
 		       char *def,
 		       int p_value,
 		       int terminate)
 {
 	if (*line == '"') {
-		char *name = find_name_gnu(state, line, p_value);
+		char *name = find_name_gnu(root, line, p_value);
 		if (name)
 			return name;
 	}
 
-	return find_name_common(state, line, def, p_value, NULL, terminate);
+	return find_name_common(root, line, def, p_value, NULL, terminate);
 }
 
-static char *find_name_traditional(struct apply_state *state,
+static char *find_name_traditional(struct strbuf *root,
 				   const char *line,
 				   char *def,
 				   int p_value)
@@ -734,7 +734,7 @@ static char *find_name_traditional(struct apply_state *state,
 	size_t date_len;
 
 	if (*line == '"') {
-		char *name = find_name_gnu(state, line, p_value);
+		char *name = find_name_gnu(root, line, p_value);
 		if (name)
 			return name;
 	}
@@ -742,10 +742,10 @@ static char *find_name_traditional(struct apply_state *state,
 	len = strchrnul(line, '\n') - line;
 	date_len = diff_timestamp_len(line, len);
 	if (!date_len)
-		return find_name_common(state, line, def, p_value, NULL, TERM_TAB);
+		return find_name_common(root, line, def, p_value, NULL, TERM_TAB);
 	len -= date_len;
 
-	return find_name_common(state, line, def, p_value, line + len, 0);
+	return find_name_common(root, line, def, p_value, line + len, 0);
 }
 
 /*
@@ -759,7 +759,7 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
 
 	if (is_dev_null(nameline))
 		return -1;
-	name = find_name_traditional(state, nameline, NULL, 0);
+	name = find_name_traditional(&state->root, nameline, NULL, 0);
 	if (!name)
 		return -1;
 	cp = strchr(name, '/');
@@ -883,17 +883,17 @@ static int parse_traditional_patch(struct apply_state *state,
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
-		name = find_name_traditional(state, second, NULL, state->p_value);
+		name = find_name_traditional(&state->root, second, NULL, state->p_value);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
 		patch->is_new = 0;
 		patch->is_delete = 1;
-		name = find_name_traditional(state, first, NULL, state->p_value);
+		name = find_name_traditional(&state->root, first, NULL, state->p_value);
 		patch->old_name = name;
 	} else {
 		char *first_name;
-		first_name = find_name_traditional(state, first, NULL, state->p_value);
-		name = find_name_traditional(state, second, first_name, state->p_value);
+		first_name = find_name_traditional(&state->root, first, NULL, state->p_value);
+		name = find_name_traditional(&state->root, second, first_name, state->p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new = 1;
@@ -940,7 +940,7 @@ static int gitdiff_verify_name(struct apply_state *state,
 			       int side)
 {
 	if (!*name && !isnull) {
-		*name = find_name(state, line, NULL, state->p_value, TERM_TAB);
+		*name = find_name(&state->root, line, NULL, state->p_value, TERM_TAB);
 		return 0;
 	}
 
@@ -949,7 +949,7 @@ static int gitdiff_verify_name(struct apply_state *state,
 		if (isnull)
 			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 				     *name, state->linenr);
-		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
+		another = find_name(&state->root, line, NULL, state->p_value, TERM_TAB);
 		if (!another || strcmp(another, *name)) {
 			free(another);
 			return error((side == DIFF_NEW_NAME) ?
@@ -1032,7 +1032,7 @@ static int gitdiff_copysrc(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1042,7 +1042,7 @@ static int gitdiff_copydst(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1052,7 +1052,7 @@ static int gitdiff_renamesrc(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1062,7 +1062,7 @@ static int gitdiff_renamedst(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-- 
2.22.0.510.g264f2c817a

