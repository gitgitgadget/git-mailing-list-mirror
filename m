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
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C561F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfGERHF (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35547 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfGERHD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so3125567wmg.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdDSZBXVcoMZ/Y508gVESM2Hr6pVhWCk7JODi9DfH4A=;
        b=RLd48hYC6rypo7afvsGPTbujuAE3SSpR3phndiztXA7hMesG3Bcx1ExDIJnRJ7VH9U
         Md3d0d9NozR8iISLMw6EqR2hTLJDL3hxIPl2c5sr/fb6jw/NvR/9jaVZhfiT2epHBXEw
         3sBqy+8/x5RpBMbSW4DtHPdrNuPc5M7nyu3MEN+QbRTy43Cv9T8oYznCLRJl1Uil+DeX
         mAy/6wtTDGTU6+WaTFtRYg0gfZu/XCk+UlZ/hl9UN2diu8vW9XrX+19X0+NQHPpv8xfq
         J9jN5dDqtB1MACz0Sk3HLOiphrfNpn/gXhZSgjgdyRTZZTb9dPiI24k6Dv7ZqVoFxaPi
         BIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdDSZBXVcoMZ/Y508gVESM2Hr6pVhWCk7JODi9DfH4A=;
        b=IExpJSV+7Bx0woPgdT2W/+8HYu7KD8X0tQlfw3O74OVwOh1mFfQN0eRrM67AHYlBzd
         vnsc7i+za6fgFtRZdq2lrCLgMFbJywJMeap/Ip3sBwD1MABXlSdKl5RMfpEKgYe8Qgj8
         iVRYw2gnrvvAFmLEGxC4RJJHyYMGrW9u2AQYybeVOUZyQ7pSi/rz4Tl8ML83KLsWXQCq
         5FbLZDAGNV+KHKIYxuUPqif/1clXNcaTXARrlXkYuRDAGvibSzELCFV+KfLzWXFhf4fH
         jNYv+bmxJUpr03P9I7w+yshA7aQ9R5GPMGE5hqJssUah72H/109XLuw1PAKT1cm7ZLw3
         Qe7w==
X-Gm-Message-State: APjAAAWaJD/yBWTN/bfveiB796oHaa80I/BPaR++mXCPpg0WSxFtpFZQ
        v1I5jXK6RNJp9T8w8qyfRJt7ajjp
X-Google-Smtp-Source: APXvYqzCL0WpOoGtCxeQWadIBjPZJpChEWD3AfK5ltaV8YCYzyQqlMmnp5qNRbYqFpGSOREC6WDZCw==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr4181142wme.102.1562346420617;
        Fri, 05 Jul 2019 10:07:00 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id v124sm4176930wmf.23.2019.07.05.10.06.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:00 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 06/14] apply: only pass required data to gitdiff_* functions
Date:   Fri,  5 Jul 2019 18:06:22 +0100
Message-Id: <20190705170630.27500-7-t.gummerer@gmail.com>
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

Currently the 'gitdiff_*()' functions take 'struct apply_state' as
parameter, even though they only needs the root, linenr and p_value
from that struct.

These functions are in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 59 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/apply.c b/apply.c
index 3cd4e3d3b3..468f1d3fee 100644
--- a/apply.c
+++ b/apply.c
@@ -22,6 +22,12 @@
 #include "rerere.h"
 #include "apply.h"
 
+struct parse_git_header_state {
+	struct strbuf *root;
+	int linenr;
+	int p_value;
+};
+
 static void git_apply_config(void)
 {
 	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
@@ -914,7 +920,7 @@ static int parse_traditional_patch(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_hdrend(struct apply_state *state,
+static int gitdiff_hdrend(struct parse_git_header_state *state,
 			  const char *line,
 			  struct patch *patch)
 {
@@ -933,14 +939,14 @@ static int gitdiff_hdrend(struct apply_state *state,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static int gitdiff_verify_name(struct apply_state *state,
+static int gitdiff_verify_name(struct parse_git_header_state *state,
 			       const char *line,
 			       int isnull,
 			       char **name,
 			       int side)
 {
 	if (!*name && !isnull) {
-		*name = find_name(&state->root, line, NULL, state->p_value, TERM_TAB);
+		*name = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
 		return 0;
 	}
 
@@ -949,7 +955,7 @@ static int gitdiff_verify_name(struct apply_state *state,
 		if (isnull)
 			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 				     *name, state->linenr);
-		another = find_name(&state->root, line, NULL, state->p_value, TERM_TAB);
+		another = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
 		if (!another || strcmp(another, *name)) {
 			free(another);
 			return error((side == DIFF_NEW_NAME) ?
@@ -965,7 +971,7 @@ static int gitdiff_verify_name(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_oldname(struct apply_state *state,
+static int gitdiff_oldname(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
@@ -974,7 +980,7 @@ static int gitdiff_oldname(struct apply_state *state,
 				   DIFF_OLD_NAME);
 }
 
-static int gitdiff_newname(struct apply_state *state,
+static int gitdiff_newname(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
@@ -992,21 +998,21 @@ static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
 	return 0;
 }
 
-static int gitdiff_oldmode(struct apply_state *state,
+static int gitdiff_oldmode(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
 	return parse_mode_line(line, state->linenr, &patch->old_mode);
 }
 
-static int gitdiff_newmode(struct apply_state *state,
+static int gitdiff_newmode(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
 	return parse_mode_line(line, state->linenr, &patch->new_mode);
 }
 
-static int gitdiff_delete(struct apply_state *state,
+static int gitdiff_delete(struct parse_git_header_state *state,
 			  const char *line,
 			  struct patch *patch)
 {
@@ -1016,7 +1022,7 @@ static int gitdiff_delete(struct apply_state *state,
 	return gitdiff_oldmode(state, line, patch);
 }
 
-static int gitdiff_newfile(struct apply_state *state,
+static int gitdiff_newfile(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
@@ -1026,47 +1032,47 @@ static int gitdiff_newfile(struct apply_state *state,
 	return gitdiff_newmode(state, line, patch);
 }
 
-static int gitdiff_copysrc(struct apply_state *state,
+static int gitdiff_copysrc(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_copydst(struct apply_state *state,
+static int gitdiff_copydst(struct parse_git_header_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_renamesrc(struct apply_state *state,
+static int gitdiff_renamesrc(struct parse_git_header_state *state,
 			     const char *line,
 			     struct patch *patch)
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_renamedst(struct apply_state *state,
+static int gitdiff_renamedst(struct parse_git_header_state *state,
 			     const char *line,
 			     struct patch *patch)
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(&state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state->root, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_similarity(struct apply_state *state,
+static int gitdiff_similarity(struct parse_git_header_state *state,
 			      const char *line,
 			      struct patch *patch)
 {
@@ -1076,7 +1082,7 @@ static int gitdiff_similarity(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_dissimilarity(struct apply_state *state,
+static int gitdiff_dissimilarity(struct parse_git_header_state *state,
 				 const char *line,
 				 struct patch *patch)
 {
@@ -1086,7 +1092,7 @@ static int gitdiff_dissimilarity(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_index(struct apply_state *state,
+static int gitdiff_index(struct parse_git_header_state *state,
 			 const char *line,
 			 struct patch *patch)
 {
@@ -1126,7 +1132,7 @@ static int gitdiff_index(struct apply_state *state,
  * This is normal for a diff that doesn't change anything: we'll fall through
  * into the next diff. Tell the parser to break out.
  */
-static int gitdiff_unrecognized(struct apply_state *state,
+static int gitdiff_unrecognized(struct parse_git_header_state *state,
 				const char *line,
 				struct patch *patch)
 {
@@ -1322,6 +1328,7 @@ static int parse_git_header(struct apply_state *state,
 			    struct patch *patch)
 {
 	unsigned long offset;
+	struct parse_git_header_state parse_hdr_state;
 
 	/* A git diff has explicit new/delete information, so we don't guess */
 	patch->is_new = 0;
@@ -1343,10 +1350,14 @@ static int parse_git_header(struct apply_state *state,
 	line += len;
 	size -= len;
 	state->linenr++;
+	parse_hdr_state.root = &state->root;
+	parse_hdr_state.linenr = state->linenr;
+	parse_hdr_state.p_value = state->p_value;
+
 	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state->linenr++) {
 		static const struct opentry {
 			const char *str;
-			int (*fn)(struct apply_state *, const char *, struct patch *);
+			int (*fn)(struct parse_git_header_state *, const char *, struct patch *);
 		} optable[] = {
 			{ "@@ -", gitdiff_hdrend },
 			{ "--- ", gitdiff_oldname },
@@ -1377,7 +1388,7 @@ static int parse_git_header(struct apply_state *state,
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			res = p->fn(state, line + oplen, patch);
+			res = p->fn(&parse_hdr_state, line + oplen, patch);
 			if (res < 0)
 				return -1;
 			if (check_header_line(state->linenr, patch))
-- 
2.22.0.510.g264f2c817a

