Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC081F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfGKQJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40931 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfGKQJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so6910395wrl.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhmadcU2Rhqw/ySCLOA3sGdYVP5KAb5UxizO12/IrsU=;
        b=pqe0TXzMYk2MKPpHJOk8YZ1sl03u58mHGb942H86v/xG8+5jmoytbfIi4xfm91BOub
         vb/nZlclAvJu+E9ha2O+BGL13lP28Fu16F9l5JbrTSSwUpUWne/ur/fvnPfqP2roDMKp
         NXESCsnYEKMGz2g4TTXk8dZ5LCZYZhQSAhpY/YpBMY7oG1erH2eb1x1FdaR784CGcGXY
         eZmtm9FDziHLNfPeVxE2ghLA/Otqey0DDapc86Q7xUlD9tm3sbtmaA+2et4fEh5OYZCQ
         3ztY5OTbgZyQe2OCdEVsO/A13wkeG01QILTJd2gtn3log5LDhmjJeWzO2Fr8u6FgpnuJ
         grdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhmadcU2Rhqw/ySCLOA3sGdYVP5KAb5UxizO12/IrsU=;
        b=afARtusG0e+gDHbETa2t1H+Wjs+zGNBQel/jdSP0zEWbsVTd6kBJ0tRBp09ziFjElk
         FBQyb/Qqt1MQ7EaHC9yXsbGeNOjb9BhOyx//jCMDFVwVIVH8Ct8LHkazhz7X1OKRDIl5
         82uZj2DbhgSQasW4kpYQmvNfLfD4olBc3aPfziRATyVlo/WtFzC+eIpJJJDfat7liHGF
         LmlbMlqX9gmeTgI5sitnAoIy+UmaPyrp0UWrh820NSHyXtjoyz88hKWeTqZnNl2AOFJ1
         VPtBV0uprlwr0LsHHVxI5vt6nQ880u/Kt5bdg87ARGIkVef3THutGC+hDDMdhrYAEDAl
         qmEg==
X-Gm-Message-State: APjAAAXjRQej4h1NaZ3DZXz6WxEylLCgnhRRf7sfKqtz43IztMU4QokH
        jhaIPxXIXKPjHe7dZiAzKMIdzL96itE=
X-Google-Smtp-Source: APXvYqyb0GsGXOzYfhuH/CZOxAP/v5hQahAUUII1YjmMe6EaGVc3ZI59z7sG9K6NWoc4BK3ZzmAoNA==
X-Received: by 2002:adf:f042:: with SMTP id t2mr5979523wro.139.1562861348645;
        Thu, 11 Jul 2019 09:09:08 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id s2sm4153728wmj.33.2019.07.11.09.09.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 06/14] apply: only pass required data to gitdiff_* functions
Date:   Thu, 11 Jul 2019 17:08:43 +0100
Message-Id: <20190711160851.14380-7-t.gummerer@gmail.com>
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
index 3cd4e3d3b3..034d134dd5 100644
--- a/apply.c
+++ b/apply.c
@@ -22,6 +22,12 @@
 #include "rerere.h"
 #include "apply.h"
 
+struct gitdiff_data {
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
+static int gitdiff_hdrend(struct gitdiff_data *state,
 			  const char *line,
 			  struct patch *patch)
 {
@@ -933,14 +939,14 @@ static int gitdiff_hdrend(struct apply_state *state,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static int gitdiff_verify_name(struct apply_state *state,
+static int gitdiff_verify_name(struct gitdiff_data *state,
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
+static int gitdiff_oldname(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
@@ -974,7 +980,7 @@ static int gitdiff_oldname(struct apply_state *state,
 				   DIFF_OLD_NAME);
 }
 
-static int gitdiff_newname(struct apply_state *state,
+static int gitdiff_newname(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
@@ -992,21 +998,21 @@ static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
 	return 0;
 }
 
-static int gitdiff_oldmode(struct apply_state *state,
+static int gitdiff_oldmode(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
 	return parse_mode_line(line, state->linenr, &patch->old_mode);
 }
 
-static int gitdiff_newmode(struct apply_state *state,
+static int gitdiff_newmode(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
 	return parse_mode_line(line, state->linenr, &patch->new_mode);
 }
 
-static int gitdiff_delete(struct apply_state *state,
+static int gitdiff_delete(struct gitdiff_data *state,
 			  const char *line,
 			  struct patch *patch)
 {
@@ -1016,7 +1022,7 @@ static int gitdiff_delete(struct apply_state *state,
 	return gitdiff_oldmode(state, line, patch);
 }
 
-static int gitdiff_newfile(struct apply_state *state,
+static int gitdiff_newfile(struct gitdiff_data *state,
 			   const char *line,
 			   struct patch *patch)
 {
@@ -1026,47 +1032,47 @@ static int gitdiff_newfile(struct apply_state *state,
 	return gitdiff_newmode(state, line, patch);
 }
 
-static int gitdiff_copysrc(struct apply_state *state,
+static int gitdiff_copysrc(struct gitdiff_data *state,
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
+static int gitdiff_copydst(struct gitdiff_data *state,
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
+static int gitdiff_renamesrc(struct gitdiff_data *state,
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
+static int gitdiff_renamedst(struct gitdiff_data *state,
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
+static int gitdiff_similarity(struct gitdiff_data *state,
 			      const char *line,
 			      struct patch *patch)
 {
@@ -1076,7 +1082,7 @@ static int gitdiff_similarity(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_dissimilarity(struct apply_state *state,
+static int gitdiff_dissimilarity(struct gitdiff_data *state,
 				 const char *line,
 				 struct patch *patch)
 {
@@ -1086,7 +1092,7 @@ static int gitdiff_dissimilarity(struct apply_state *state,
 	return 0;
 }
 
-static int gitdiff_index(struct apply_state *state,
+static int gitdiff_index(struct gitdiff_data *state,
 			 const char *line,
 			 struct patch *patch)
 {
@@ -1126,7 +1132,7 @@ static int gitdiff_index(struct apply_state *state,
  * This is normal for a diff that doesn't change anything: we'll fall through
  * into the next diff. Tell the parser to break out.
  */
-static int gitdiff_unrecognized(struct apply_state *state,
+static int gitdiff_unrecognized(struct gitdiff_data *state,
 				const char *line,
 				struct patch *patch)
 {
@@ -1322,6 +1328,7 @@ static int parse_git_header(struct apply_state *state,
 			    struct patch *patch)
 {
 	unsigned long offset;
+	struct gitdiff_data parse_hdr_state;
 
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
+			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
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

