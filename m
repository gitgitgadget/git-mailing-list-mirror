Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77511F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbdL1EPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:24 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:42331 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbdL1EOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:18 -0500
Received: by mail-it0-f68.google.com with SMTP id p139so27006331itb.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FWcu2+nbSjDo1tRFleaI0z2czUjQAfR5OXIglrmbfsU=;
        b=BTPEhVU7y0c2TpyMo/SmrUrjhNie5X0QKZ+UGqO/mINNUqX4RW5Go2S7rlYg2Gmeb9
         wPGGI6wI8ukjbWv2Tas8XV+4rwxqiE7g4gCPDDMIhHDI6A8UQuQOD/S8+WajeA5tWihl
         /ShTaPuE5eYi/S+9ajwhWvXuUtyYBzFpWWnDT8x5Zo045F7Bj1Gl/PZqgbnZp5afjuN+
         bY/+ETPAtBlQFEexSHC3WWqXFxtqcZoqlNVO2GJV28jC19WZX6bAtW57auzVlE3MCncB
         089LV636mXQaY/lRO8zIps2mlK+rvraaEo74H7tD7250R5ulZPyRm2EuGHD2aTnaRaZP
         w01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FWcu2+nbSjDo1tRFleaI0z2czUjQAfR5OXIglrmbfsU=;
        b=DbE4/Q26hpsmrRNZ1Xv1RfW07boCv4PxQLd6FvSLRDpyJjIZrqnRF+CEP5UuFPAarE
         qyWTW6utWNG3esoCClMC7BMYp90ZUwEXxVJ0vbd7PXPjvIvsB+D0uSnwoxW0cn/CeNfM
         EpyWSrorSVznc54JUs0mFBhNc6kUreRsWYeMhCgxk7166Fii8yY4ahr9d3r8734j7R2k
         oLcAE/096QDe5H4M0wqS5BiMndWX8q0aov8IIIk41UNeUbnATj/FQxelnZwlyVSyjQ/G
         en3G/1ietYw3dZDr7lnRXFmJVWorSP/5qWparEEjZTeez2Bu8HmY7Uy6K/v1ZyC8URXz
         3Nwg==
X-Gm-Message-State: AKGB3mKxLd5vgJMDnZA8xXWsRqvyDGhW3avdiI7mP1Avi2HKjFV0qZzm
        QBr1JRQcyvmDz8Agk1VzZRdISA==
X-Google-Smtp-Source: ACJfBouBr9jlKHRUx6aki+PDMBouSFrIVpfXBcsD8QVNbmp3BvKgAhXaJAxEteCm1IiWJA9IxvW6wQ==
X-Received: by 10.36.40.194 with SMTP id h185mr41667744ith.101.1514434457151;
        Wed, 27 Dec 2017 20:14:17 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:16 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 16/34] merge-recursive: introduce new functions to handle rename logic
Date:   Wed, 27 Dec 2017 20:13:34 -0800
Message-Id: <20171228041352.27880-17-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The amount of logic in merge_trees() relative to renames was just a few
lines, but split it out into new handle_renames() and cleanup_renames()
functions to prepare for additional logic to be added to each.  No code or
logic changes, just a new place to put stuff for when the rename detection
gains additional checks.

Note that process_renames() records pointers to various information (such
as diff_filepairs) into rename_conflict_info structs.  Even though the
rename string_lists are not directly used once handle_renames() completes,
we should not immediately free the lists at the end of that function
because they store the information referenced in the rename_conflict_info,
which is used later in process_entry().  Thus the reason for a separate
cleanup_renames().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 08bf26b9c..e95eac2c7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1636,6 +1636,32 @@ static int process_renames(struct merge_options *o,
 	return clean_merge;
 }
 
+struct rename_info {
+	struct string_list *head_renames;
+	struct string_list *merge_renames;
+};
+
+static int handle_renames(struct merge_options *o,
+			  struct tree *common,
+			  struct tree *head,
+			  struct tree *merge,
+			  struct string_list *entries,
+			  struct rename_info *ri)
+{
+	ri->head_renames  = get_renames(o, head, common, head, merge, entries);
+	ri->merge_renames = get_renames(o, merge, common, head, merge, entries);
+	return process_renames(o, ri->head_renames, ri->merge_renames);
+}
+
+static void cleanup_renames(struct rename_info *re_info)
+{
+	string_list_clear(re_info->head_renames, 0);
+	string_list_clear(re_info->merge_renames, 0);
+
+	free(re_info->head_renames);
+	free(re_info->merge_renames);
+}
+
 static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 {
 	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
@@ -1988,7 +2014,8 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (unmerged_cache()) {
-		struct string_list *entries, *re_head, *re_merge;
+		struct string_list *entries;
+		struct rename_info re_info;
 		int i;
 		/*
 		 * Only need the hashmap while processing entries, so
@@ -2002,9 +2029,8 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		re_head  = get_renames(o, head, common, head, merge, entries);
-		re_merge = get_renames(o, merge, common, head, merge, entries);
-		clean = process_renames(o, re_head, re_merge);
+		clean = handle_renames(o, common, head, merge, entries,
+				       &re_info);
 		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
@@ -2029,16 +2055,13 @@ int merge_trees(struct merge_options *o,
 		}
 
 cleanup:
-		string_list_clear(re_merge, 0);
-		string_list_clear(re_head, 0);
+		cleanup_renames(&re_info);
+
 		string_list_clear(entries, 1);
+		free(entries);
 
 		hashmap_free(&o->current_file_dir_set, 1);
 
-		free(re_merge);
-		free(re_head);
-		free(entries);
-
 		if (clean < 0)
 			return clean;
 	}
-- 
2.15.0.408.g8e199d483

