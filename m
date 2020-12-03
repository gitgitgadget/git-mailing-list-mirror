Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2DBC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45199207A9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgLCQBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbgLCQBL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:01:11 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3BC08E85E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:00:00 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so3220769wml.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=twWa+J1WG9e02gxYA2qg9SNA45rlybzJ7QhS9MSllrk=;
        b=anfjaFyc8P19erogV2iLhkSrYUSfkJZZyklwFnsi9tFJG8Kj/mT6OpzIDNQZebQVPU
         enroijYL3pzsHgjW5U4OgoOw+Ko1CPN4MLrYsYfllVzjanW+8id4JLUOM+PI2+f3Dz5R
         eXuO+1FzK2WMYsoW47Ges4hM5DwgQk3mZiXwSnc7/U6MXWZdQQ/A8y363+rr8P7RI5At
         3tbzY5q0UglAD9gaBEpMrckRB2mVOrfWEFvIKaC9yanLDL7nQtC7G238X4CHpJw/0Gd6
         /QIMtAxy7GmXnJxPSlo3G2EVgzuNIkDz3OcXvHkQulkQx7qnn9O0bp2iFPF0uIrujs4M
         j7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=twWa+J1WG9e02gxYA2qg9SNA45rlybzJ7QhS9MSllrk=;
        b=hILDcTsAR5rHiUSzDA7z787f5lNDQHadZbQh+2mNgBMgYMzOYBlVBsleJJYPkNAqpx
         4XD9eG+jtpvL9RX8KVI9ENWE4zlS5hCpkP81wcysn1XuIoiLxD0RQmO78qasrZre3bbE
         t4db+Kr8LbeG+ciyOpelTEDa9gwrVjGEqd4DOg5SSfM0E4FBMXarYEFQA857CM77vZFS
         xKCzE6T7jaRCP+OCqFN9mXpYAuQFGyxpy6Bgk10Ug9iAqMs7hqT79fYAazwkc00ydKUb
         kubaPU7bIkOotoCzBzvpXVIBUXzNxO+sYfi0zbwQxeIhYI2UV88aHTL0FRTUZ046/MIt
         +wzQ==
X-Gm-Message-State: AOAM531/Naly7uHkT+PP5NgmWfClOEtZjZV+n40pg7asz43jMhkiyNlb
        VvSAwI/W6fa5ZipJGzT8yYtkdavnJbc=
X-Google-Smtp-Source: ABdhPJxJlTgdgBDZW6kBRNQk5Tr+WnOZrNU+Mp0LmCrpGk0IV+7SfTOLirNd2FPFMJQJ8T18DgM2oA==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr4153219wml.64.1607011198486;
        Thu, 03 Dec 2020 07:59:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm2322495wrv.77.2020.12.03.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:57 -0800 (PST)
Message-Id: <8ab55a6ecb0b3c7139520d09d752420d7e90f6c2.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:46 +0000
Subject: [PATCH 7/7] merge-ort: add modify/delete handling and delayed output
 processing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The focus here is on adding a path_msg() which will queue up
warning/conflict/notice messages about the merge for later processing,
storing these in a pathname -> strbuf map.  It might seem like a big
change, but it really just is:

  * declaration of necessary map with some comments
  * initialization and recording of data
  * a bunch of code to iterate over the map at print/free time
  * at least one caller in order to avoid an error about having an
    unused function (which we provide in the form of implementing
    modify/delete conflict handling).

At this stage, it is probably not clear why I am opting for delayed
output processing.  There are multiple reasons:

  1. Merges are supposed to abort if they would overwrite dirty changes
     in the working tree.  We cannot correctly determine whether changes
     would be overwritten until both rename detection has occurred and
     full processing of entries with the renames has finalized.
     Warning/conflict/notice messages come up at intermediate codepaths
     along the way, so unless we want spurious conflict/warning messages
     being printed when the merge will be aborted anyway, we need to
     save these messages and only print them when relevant.

  2. There can be multiple messages for a single path, and we want all
     messages for a give path to appear together instead of having them
     grouped by conflict/warning type.  This was a problem already with
     merge-recursive.c but became even more important due to the
     splitting apart of conflict types as discussed in the commit
     message for 1f3c9ba707 ("t6425: be more flexible with rename/delete
     conflict messages", 2020-08-10)

  3. Some callers might want to avoid showing the output in certain
     cases, such as if the end result is a clean merge.  Rebases have
     typically done this.

  4. Some callers might not want the output to go to stdout or even
     stderr, but might want to do something else with it entirely.
     For example, a --remerge-diff option to `git show` or `git log
     -p` that remerges on the fly and diffs merge commits against the
     remerged version would benefit from stdout/stderr not being
     written to in the standard form.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e7220cbbb4..64468f0706 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -87,6 +87,15 @@ struct merge_options_internal {
 	 */
 	struct string_list paths_to_free;
 
+	/*
+	 * output: special messages and conflict notices for various paths
+	 *
+	 * This is a map of pathnames (a subset of the keys in "paths" above)
+	 * to strbufs.  It gathers various warning/conflict/notice messages
+	 * for later processing.
+	 */
+	struct strmap output;
+
 	/*
 	 * current_dir_name: temporary var used in collect_merge_info_callback()
 	 *
@@ -247,6 +256,27 @@ static void clear_internal_opts(struct merge_options_internal *opti,
 	opti->paths_to_free.strdup_strings = 1;
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
+
+	if (!reinitialize) {
+		struct hashmap_iter iter;
+		struct strmap_entry *e;
+
+		/* Release and free each strbuf found in output */
+		strmap_for_each_entry(&opti->output, &iter, e) {
+			struct strbuf *sb = e->value;
+			strbuf_release(sb);
+			/*
+			 * While strictly speaking we don't need to free(sb)
+			 * here because we could pass free_values=1 when
+			 * calling strmap_clear() on opti->output, that would
+			 * require strmap_clear to do another
+			 * strmap_for_each_entry() loop, so we just free it
+			 * while we're iterating anyway.
+			 */
+			free(sb);
+		}
+		strmap_clear(&opti->output, 0);
+	}
 }
 
 static int err(struct merge_options *opt, const char *err, ...)
@@ -265,6 +295,27 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+__attribute__((format (printf, 4, 5)))
+static void path_msg(struct merge_options *opt,
+		     const char *path,
+		     int omittable_hint, /* skippable under --remerge-diff */
+		     const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf *sb = strmap_get(&opt->priv->output, path);
+	if (!sb) {
+		sb = xmalloc(sizeof(*sb));
+		strbuf_init(sb, 0);
+		strmap_put(&opt->priv->output, path, sb);
+	}
+
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+
+	strbuf_addch(sb, '\n');
+}
+
 /*** Function Grouping: functions related to collect_merge_info() ***/
 
 static void setup_path_info(struct merge_options *opt,
@@ -935,7 +986,23 @@ static void process_entry(struct merge_options *opt,
 		(void)handle_content_merge;
 	} else if (ci->filemask == 3 || ci->filemask == 5) {
 		/* Modify/delete */
-		die("Not yet implemented.");
+		const char *modify_branch, *delete_branch;
+		int side = (ci->filemask == 5) ? 2 : 1;
+		int index = opt->priv->call_depth ? 0 : side;
+
+		ci->merged.result.mode = ci->stages[index].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[index].oid);
+		ci->merged.clean = 0;
+
+		modify_branch = (side == 1) ? opt->branch1 : opt->branch2;
+		delete_branch = (side == 1) ? opt->branch2 : opt->branch1;
+
+		path_msg(opt, path, 0,
+			 _("CONFLICT (modify/delete): %s deleted in %s "
+			   "and modified in %s.  Version %s of %s left "
+			   "in tree."),
+			 path, delete_branch, modify_branch,
+			 modify_branch, path);
 	} else if (ci->filemask == 2 || ci->filemask == 4) {
 		/* Added on one side */
 		int side = (ci->filemask == 4) ? 2 : 1;
@@ -1203,7 +1270,29 @@ void merge_switch_to_result(struct merge_options *opt,
 	}
 
 	if (display_update_msgs) {
-		/* TODO: print out CONFLICT and other informational messages. */
+		struct merge_options_internal *opti = result->priv;
+		struct hashmap_iter iter;
+		struct strmap_entry *e;
+		struct string_list olist = STRING_LIST_INIT_NODUP;
+		int i;
+
+		/* Hack to pre-allocate olist to the desired size */
+		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
+			   olist.alloc);
+
+		/* Put every entry from output into olist, then sort */
+		strmap_for_each_entry(&opti->output, &iter, e) {
+			string_list_append(&olist, e->key)->util = e->value;
+		}
+		string_list_sort(&olist);
+
+		/* Iterate over the items, printing them */
+		for (i = 0; i < olist.nr; ++i) {
+			struct strbuf *sb = olist.items[i].util;
+
+			printf("%s", sb->buf);
+		}
+		string_list_clear(&olist, 0);
 	}
 
 	merge_finalize(opt, result);
@@ -1270,6 +1359,13 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	strmap_init_with_options(&opt->priv->paths, NULL, 0);
 	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
 	string_list_init(&opt->priv->paths_to_free, 0);
+
+	/*
+	 * keys & strbufs in output will sometimes need to outlive "paths",
+	 * so it will have a copy of relevant keys.  It's probably a small
+	 * subset of the overall paths that have special output.
+	 */
+	strmap_init(&opt->priv->output);
 }
 
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
-- 
gitgitgadget
