Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438911F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGERHC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfGERHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so10597879wrt.6
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHvYJZH4IZ7ELFv3K/QTLwxkP5gJcypPwWDqRBGoxgc=;
        b=oEftES1isV/n7zxYEn2p+0ke11ij17vFBnpxm8gWGX8ZJDjOpsR7LH8qLf6rdizzl6
         3Ld4EGWixeklbvLcF5AR9Sh2R2Z7I0Prpfe0e5soqpBb00ElcOSGq6OGpQjeF/P5frtV
         o3XCFh4CSQp77aEAxLkzNMta/fmDSoxE0hU6jhdHlvEXFE7GMqbfKmnzaQ3L6Ba1cDHY
         lkvaY+5QMdM4e5YG6uQsDA8LOWZ0BGcXmzIZk6mP4FcvkjNgk2HrLVVliyMW7DFuigv5
         akFREizOVOJZgy09KuTG5Vtqyqlrvy/OQjbFN3sYGtGA0o+NxlZ3c608kfSCI6m0g2uU
         H4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHvYJZH4IZ7ELFv3K/QTLwxkP5gJcypPwWDqRBGoxgc=;
        b=Clt6ZtbW2jiiUQ6lBTY9xWeBajP1BGmS5u3YzRMZuI8ybrhJjY9nswwMWLgcQvbw/T
         tQ6tV1bVa6rvTAkytGnzL06UEaDLL6BNqNHdlOu946tetGbCwLfsBCjwl/+ilWH1rlWh
         0g5e8XVfDnWVaol6MTnXN6ggiJKTYdFiWKs6pQh4yX5ZdC58mzVD2w43HNX0dMT/dGVT
         i+obBqTonNJfQ/ui5957sJfGHbh9V9RLdylEVXWngzoR+enhI1A+MwDdIzlER383l3ix
         Rr56z/dc6Smx2YUTvfdqKemUHx7By9Eclt9wbb0pXbTErXEXbkmq2f2lU+YFET9odO2g
         L0IA==
X-Gm-Message-State: APjAAAWjSSroBqGOPoTQmVaaUnj4bm3x1Eiy04naBVKbwk/uGC818TqH
        Vu7R5etbejj1y0ZjIzf3TugSlQis
X-Google-Smtp-Source: APXvYqzQZRMZddUr7jqB8bRuSHhgz5wJx2ASKpnQn9viB22IKoz7ezlpbqm19VQxs5tTCRB0q/Ny8A==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr4920824wro.306.1562346419275;
        Fri, 05 Jul 2019 10:06:59 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id f17sm3561675wmf.27.2019.07.05.10.06.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:06:58 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 05/14] apply: only pass required data to find_name_*
Date:   Fri,  5 Jul 2019 18:06:21 +0100
Message-Id: <20190705170630.27500-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
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

