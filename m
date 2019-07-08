Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748AB1F4C0
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfGHQiC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHQiB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so11536430wrl.7
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpszmeiDGoE95yhbjtGiZDVw4dl2nsB9nuVIP6nMgZ0=;
        b=HKqwSpRDb6IGWiuzGQeTe7RGg/b00aCiG9zKSZIpZ/RTXmQnkzPahSeXUhLbmDpJZw
         zcSqShvr0TJZxe7CrPKgeUzVptlVHOkTDnEkKpfn+2Fdwi9ITuGwIBD4RvX9LYxLlKTp
         VmwT0C/ufko9mT/g8rq3KnwHmJhXOHPDhShGsZiFmzzlfjsuXhv0LVi4Q2UxLfs6t34g
         eoqxXJrg7OSiopWrj/nIS79W4trRTvqodTWb6PmyDcT302mdnqzfM4dEqZ+srSY5H2sU
         mozYo1rUkG2aHPxJQu431alJhj9ZYjIbQB20ChF+XyCShiDuT9CuWb/JpXMnUcI2xsh5
         Lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpszmeiDGoE95yhbjtGiZDVw4dl2nsB9nuVIP6nMgZ0=;
        b=c0p5myl5HOI44BQc+qVpbrkomu/w9ZC+MfyHxlrg2SYU6ijUMYfcJ3lIa+7n4CEx9V
         V631ZaC4asiS3EUb+o2cWHJr4BqUrVKjisFsMRQUTbSsJOzBknxomLB+p8nDH2Qm5IwB
         X3jBiM7H5SdvElsOw1uwE55Ml58RkVbnqL1ouZmsATvcRgh2gQ09xmed7kqqSZKfpiZv
         p7W0mDxsOQvCn7NAHvKKZ0GlPXe4YU/30v72C08bXn/MPqk7I/vtWWMjS0oidqdT2fFr
         CRspAucSwZtXU6/LBz5SmfGMFg2QNV9ENiQPi0ftXlsi9XSbxgbZ7iYRY4b48no3a9To
         oZ+g==
X-Gm-Message-State: APjAAAVQs2tpaH57aRQmGWmfFTMvEyEs1Fc5C7BFpRjIvWxz/yOq+QiL
        wneSjS9R29pfOXAN+ZS1RVupeAWo
X-Google-Smtp-Source: APXvYqzZJyuPBO+i9HeVcoHk1SAi2AYbxEJqZ5ZR4JN26flKyVWHwwESX15NtkWVK/+xvPWZ8JKm1g==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr15485892wrq.261.1562603879451;
        Mon, 08 Jul 2019 09:37:59 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id 5sm45076wmg.42.2019.07.08.09.37.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:37:58 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 06/14] apply: only pass required data to gitdiff_* functions
Date:   Mon,  8 Jul 2019 17:33:07 +0100
Message-Id: <20190708163315.29912-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
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

As these functions are called in a loop using their function pointers,
each function needs to be passed all the parameters even if only one
of the functions actually needs it.  We therefore pass this data along
in a struct to avoid adding too many unused parameters to each
function and making the code very verbose in the process.

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

