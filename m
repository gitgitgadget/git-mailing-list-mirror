Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB351F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeAEUaD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:30:03 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:42348 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeAEU2h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:37 -0500
Received: by mail-it0-f66.google.com with SMTP id p139so2888142itb.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YanUEuXYd0u/XhjyDx3TnjKuraFK2v32WD6KlQIg7c=;
        b=ReZKbu4yxEQW2vAs/gRJHV4UqRn6pwyLv2W4Yl0kKXs3yaUv0lrh4bapsRy1syxLOT
         x92h6D/PXetZz+2GqGwEZryKKalOLUF5Oap7Yiph+SyzQD+XTxCco5XfwNK5tARH6fJH
         0LhZ9W8UaDdVcHJD9KJFbd99JEAhA0IlpCeMoaLxK/FG2AL2XpgkILXuHNBXeueTBMG8
         17bk2FmywIC8XE4chP6SCcI/G7HmvmR325MuQOyjrYdDuDG+8xBEGUz5cYBC4k7QE/RK
         7f0gTvt5rh8Bx497btKXCxxcePpWWfnfwjNfI8DcArpQ7XaQBvm9+9ImqAFZQ7SEVRS3
         5VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YanUEuXYd0u/XhjyDx3TnjKuraFK2v32WD6KlQIg7c=;
        b=AgQPLGaOqS31vZZ5ezOpgiQsw3hvjm8/lHQf2ClV/GqVgc22/reTuIP6Q2CyNVoXVG
         bPzB6xDNK/KgzQaesR3sdrvBqXDJTlFNIOX+yrhf3lmBEHQu/LnoFNr1dUpKZ2oNmYB7
         Df+ScT3wDdJqwN00J8ccTYBUP3EuJucDUAj+cux/UCxi1ohCF6bn73RMRv22LGJj80Ir
         JuT+KFRTAEmgmkeu9MOQstMqALtzeLX7lgqDq3Y0SIoeyIP6SQWZIpvMayZ5ZB7AAdZ3
         GFJDCzA8+jMfefMEtWihBGI4ETPts4W2BMH9idqAuQ/L6+OFabWGZyYBO9Zob3WwOq6S
         cg0A==
X-Gm-Message-State: AKGB3mKD7PWdX8Bdo/WtRz8+4wbrno/bWrmiDuYhV+0roRCTG/nxeEOf
        uWf/yoiEoTKtkKXQEoWYg3+CISQ/
X-Google-Smtp-Source: ACJfBotmkesE4P70zFJVIBlobfxkAWLmf1DOZhwKakgmM8NtHMguKzG3FykOKAw137gjLG+1bemocw==
X-Received: by 10.36.77.139 with SMTP id l133mr4012531itb.52.1515184116640;
        Fri, 05 Jan 2018 12:28:36 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:36 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 13/31] merge-recursive: introduce new functions to handle rename logic
Date:   Fri,  5 Jan 2018 12:26:53 -0800
Message-Id: <20180105202711.24311-14-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
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
2.14.2

