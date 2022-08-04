Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3AC19F21
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiHDTvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiHDTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 15:51:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FBC2B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 12:51:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m12-20020a170902db0c00b0016f89376ad3so413360plx.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=LQzE5jDAtag/Bbwde8/6oeEgeQRNxLU7iN6CqL9KcK8=;
        b=iL7Av1I2LhUy7BoAhDGvl31IvCH/SVuzEbp+YmYt6DBbG//+UhMVpSQHdY1PnHBLLs
         e//CysP1CVmNMiecjYkHjsx9eOO090B3LBmWMguPwg8wnefVF6HDzSdS8Cw+yuKHBTzy
         q701+oTmZHIyuiIP3x7vl/FLZHDPV0OdWT9H2EOyE84UomGWGlTvnZoyiej11vwSQwn/
         49xr/t46QeE3ItY6+ov2/ZqYi7tpJu6xx5tNNqnRO3FQF3luxpQ4Pb3QUzKp49/g5hwJ
         2afjj2DxUWWn/KiyGycNvrymKZoDb8qeJLC3SddKawtRG9We8aSVlmoDfpMU8iKpz+BJ
         854g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=LQzE5jDAtag/Bbwde8/6oeEgeQRNxLU7iN6CqL9KcK8=;
        b=maP7UMeb1XuEy/uopwE2KEPjrv+1J5lMx9Aq6mJSulDPx4QWjibnORggJKfNYIsM+z
         QLgAwGO+aVTpnZUHApZVESUXTiL3srHRwJ5OsvBd8hSgANu5VkavxSfA0dBKVf74aV2j
         HQNUc8/SZv5ksCyNXn/ym9JR/3+iCuFAjx9MI7nyqS9fN2i20B+s926vmpsmPNeJ3Ewn
         rXW1Ufv1ynXgCOHG+4CP5SN3qBtGbDcxpmjoxOFyeuOodut4R9yS6nLENTe2IC/1Q3EX
         qvhAy5jntLGT4iucALb7UcU6oRhRr+Fdlx8eMwfGmH8mORfAfKGZrZu5J/ZeKE0pItGy
         udMg==
X-Gm-Message-State: ACgBeo06J9bbyvb5WsbFy1gLvsicFEq3rII7sN1WLKPDb8Y6/BSvcnkr
        RaLh86rt70ZNCiwzci8kVd2e8HBH8601s2P1FkCI+EMst0/8JL/shtPDXUwSKH/qxwSQVcmqTUs
        13gRymDvx6Kbm8iU8qK7W9K/55mbzDimeh5kRvRnCZrgXd6hT+sZ1Nx0/R0/3gCfQSg==
X-Google-Smtp-Source: AA6agR6QXXaWmMAJTYdt28BexkIMjgxfE8KAGRNMTaXSFWN7Cx3zF4Pwwtz6+m12PTDJ05umH69o5NTNJnu1HSY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:4ac7:b0:1f5:3441:d11a with SMTP
 id mh7-20020a17090b4ac700b001f53441d11amr3650627pjb.182.1659642673455; Thu,
 04 Aug 2022 12:51:13 -0700 (PDT)
Date:   Thu,  4 Aug 2022 19:51:05 +0000
In-Reply-To: <20220728211221.2913928-1-calvinwan@google.com>
Message-Id: <20220804195105.1303455-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220728211221.2913928-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v8] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        newren@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to merge in a superproject with conflicting submodule
pointers that cannot be fast-forwarded or trivially resolved, the merge
fails and Git prints an error message that accurately describes the
failure, but does not provide steps for the user to resolve the error.

Git is left in a conflicted state, which requires the user to:
 1. merge submodules or update submodules to an already existing
	commit that reflects the merge
 2. add submodules changes to the superproject
 3. finish merging superproject
These steps are non-obvious for newer submodule users to figure out
based on the error message and neither `git submodule status` nor `git
status` provide any useful pointers.

Update error message to provide steps to resolve submodule merge
conflict. Future work could involve adding an advice flag to the
message. Although the message is long, it also has the id of the 
submodule commit that needs to be merged, which could be useful
information for the user.

Additionally, 5 merge failures that resulted in an early return have
been updated to reflect the status of the merge.
1. Null merge base (null o): CONFLICT_SUBMODULE_NULL_MERGE_BASE added
   as a new conflict type and will print updated error message.
2. Null merge side a (null a): BUG(). See [1] for discussion
3. Null merge side b (null b): BUG(). See [1] for discussion
4. Submodule not checked out: added NEEDSWORK bit
5. Submodule commits not present: added NEEDSWORK bit
The errors with a NEEDSWORK bit deserve a more detailed explanation of
how to resolve them. See [2] for more context.

[1] https://lore.kernel.org/git/CABPp-BE0qGwUy80dmVszkJQ+tcpfLRW0OZyErymzhZ9+HWY1mw@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqpmhjjwo9.fsf@gitster.g/

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
Range-diff against v7:
1:  0640133250 ! 1:  24a4652b25 submodule merge: update conflict error message
    @@ merge-ort.c: struct merge_options_internal {
     +
     +	/* field that holds submodule conflict information */
     +	struct string_list conflicted_submodules;
    ++};
    ++
    ++struct conflicted_submodule_item {
    ++	char *abbrev;
    ++	int flag;
      };
      
    ++static void conflicted_submodule_item_free(void *util, const char *str)
    ++{
    ++	struct conflicted_submodule_item *item = util;
    ++
    ++	free(item->abbrev);
    ++	free(item);
    ++}
    ++
      struct version_info {
    + 	struct object_id oid;
    + 	unsigned short mode;
     @@ merge-ort.c: enum conflict_and_info_types {
      	CONFLICT_SUBMODULE_NOT_INITIALIZED,
      	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
    @@ merge-ort.c: static const char *type_short_descriptions[] = {
      	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =
      		"CONFLICT (submodule may have rewinds)",
     +	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
    -+		"CONFLICT (submodule no merge base)"
    ++		"CONFLICT (submodule lacks merge base)"
      };
      
      struct logical_conflict_info {
    @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_inte
      
      	mem_pool_discard(&opti->pool, 0);
      
    -+	string_list_clear(&opti->conflicted_submodules, 1);
    ++	string_list_clear_func(&opti->conflicted_submodules,
    ++					conflicted_submodule_item_free);
     +
      	/* Clean out callback_data as well. */
      	FREE_AND_NULL(renames->callback_data);
    @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      
      	int i;
      	int search = !opt->priv->call_depth;
    -+	int sub_initialized = 1;
    ++	int sub_not_initialized = 1;
    ++	int sub_flag = -1;
      
      	/* store fallback answer in result in case we fail */
      	oidcpy(result, opt->priv->call_depth ? o : a);
    @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      	/* we can not handle deletion conflicts */
     -	if (is_null_oid(o))
     -		return 0;
    - 	if (is_null_oid(a))
    +-	if (is_null_oid(a))
     -		return 0;
    -+		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()"); 
    - 	if (is_null_oid(b))
    +-	if (is_null_oid(b))
     -		return 0;
    ++	if (is_null_oid(a) || is_null_oid(b))
     +		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()");
      
     -	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
    -+	if ((sub_initialized = repo_submodule_init(&subrepo,
    -+									opt->repo, path, null_oid()))) {
    ++	if ((sub_not_initialized = repo_submodule_init(&subrepo,
    ++		opt->repo, path, null_oid()))) {
      		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
      			 path, NULL, NULL, NULL,
      			 _("Failed to merge submodule %s (not checked out)"),
      			 path);
    -+		/*
    -+		 * NEEDSWORK: Since the steps to resolve this error are
    -+		 * more involved than what is currently in 
    -+		 * print_submodule_conflict_suggestion(), we return
    -+		 * immediately rather than generating an error message
    -+		 */
    - 		return 0;
    - 	}
    - 
    +-		return 0;
    ++		sub_flag = CONFLICT_SUBMODULE_NOT_INITIALIZED;
    ++		goto cleanup;
    ++	}
    ++
     +	if (is_null_oid(o)) {
     +		path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
     +			 path, NULL, NULL, NULL,
     +			 _("Failed to merge submodule %s (no merge base)"),
     +			 path);
     +		goto cleanup;
    -+	}
    -+
    + 	}
    + 
      	if (!(commit_o = lookup_commit_reference(&subrepo, o)) ||
    - 	    !(commit_a = lookup_commit_reference(&subrepo, a)) ||
    - 	    !(commit_b = lookup_commit_reference(&subrepo, b))) {
    +@@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
    + 			 path, NULL, NULL, NULL,
    + 			 _("Failed to merge submodule %s (commits not present)"),
    + 			 path);
    ++		sub_flag = CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE;
    + 		goto cleanup;
    + 	}
    + 
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      
      	object_array_clear(&merges);
    @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
     -	repo_clear(&subrepo);
     +	if (!opt->priv->call_depth && !ret) {
     +		struct string_list *csub = &opt->priv->conflicted_submodules;
    ++		struct conflicted_submodule_item *util;
    ++		const char *abbrev;
     +
    -+		string_list_append(csub, path)->util =
    -+				xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV));
    ++		util = xmalloc(sizeof(*util));
    ++		util->flag = sub_flag;
    ++		util->abbrev = NULL;
    ++		if (!sub_not_initialized) {
    ++			abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
    ++			util->abbrev = xstrdup(abbrev);
    ++		}
    ++		string_list_append(csub, path)->util = util;
     +	}
     +
    -+	if (!sub_initialized)
    ++	if (!sub_not_initialized)
     +		repo_clear(&subrepo);
      	return ret;
      }
    @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      	return errs;
      }
      
    -+static void print_submodule_conflict_suggestion(struct string_list *csub) {
    -+	if (csub->nr > 0) {
    -+		struct string_list_item *item;
    -+		struct strbuf msg = STRBUF_INIT;
    -+		struct strbuf tmp = STRBUF_INIT;
    -+
    -+		strbuf_addf(&tmp, _("Recursive merging with submodules currently only supports trivial cases."));
    -+		strbuf_addf(&msg, "%s\n", tmp.buf);
    -+		strbuf_release(&tmp);
    ++static void format_submodule_conflict_suggestion(struct strbuf *msg) {
    ++	struct strbuf tmp = STRBUF_INIT;
    ++	struct string_list msg_list = STRING_LIST_INIT_DUP;
    ++	int i;
     +
    -+		strbuf_addf(&tmp, _("Please manually handle the merging of each conflicted submodule."));
    -+		strbuf_addf(&msg, "%s\n", tmp.buf);
    -+		strbuf_release(&tmp);
    -+
    -+		strbuf_addf(&tmp, _("This can be accomplished with the following steps:"));
    -+		strbuf_addf(&msg, "%s\n", tmp.buf);
    -+		strbuf_release(&tmp);
    -+
    -+		for_each_string_list_item(item, csub) {
    -+			const char *abbrev= item->util;
    ++	string_list_split(&msg_list, msg->buf, '\n', -1);
    ++	for (i = 0; i < msg_list.nr; i++) {
    ++		if (!i)
     +			/*
    -+			 * TRANSLATORS: This is a line of advice to resolve a merge conflict
    -+			 * in a submodule. The second argument is the abbreviated id of the
    -+			 * commit that needs to be merged.
    -+			 * E.g. - go to submodule (sub), and either merge commit abc1234"
    ++			 * TRANSLATORS: This is line item of submodule conflict message
    ++			 * from print_submodule_conflict_suggestion() below. For RTL
    ++			 * languages, the following swap is suggested:
    ++			 *      " - %s\n" -> "%s - \n"
     +			 */
    -+			strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s"),
    -+													item->string, abbrev);
    -+			strbuf_addf(&msg, _(" - %s"), tmp.buf);
    -+			strbuf_addf(&msg, "\n");
    -+			strbuf_release(&tmp);
    -+			strbuf_addf(&tmp, _("or update to an existing commit which has merged those changes"));
    -+			strbuf_addf(&msg, _("   %s"), tmp.buf);
    -+			strbuf_addf(&msg, "\n");
    -+			strbuf_release(&tmp);
    -+		}
    -+		strbuf_addf(&tmp, _("come back to superproject and run:"));
    -+		strbuf_addf(&msg, _(" - %s"), tmp.buf);
    -+		strbuf_addf(&msg, "\n\n");
    -+		strbuf_release(&tmp);
    ++			strbuf_addf(&tmp, _(" - %s\n"), msg_list.items[i].string);
    ++		else
    ++			/*
    ++			 * TRANSLATORS: This is line item of submodule conflict message
    ++			 * from print_submodule_conflict_suggestion() below. For RTL
    ++			 * languages, the following swap is suggested:
    ++			 *      "   %s\n" -> "%s   \n"
    ++			 */
    ++			strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
    ++	}
    ++	strbuf_reset(msg);
    ++	strbuf_add(msg, tmp.buf, tmp.len);
    ++}
     +
    -+		strbuf_addf(&tmp, "git add ");
    -+		strbuf_add_separated_string_list(&tmp, " ", csub);
    -+		strbuf_addf(&msg, _("       %s"), tmp.buf);
    -+		strbuf_addf(&msg, "\n\n");
    -+		strbuf_release(&tmp);
    ++static void print_submodule_conflict_suggestion(struct string_list *csub) {
    ++	struct string_list_item *item;
    ++	struct strbuf msg = STRBUF_INIT;
    ++	struct strbuf tmp = STRBUF_INIT;
    ++	struct strbuf subs = STRBUF_INIT;
     +
    -+		strbuf_addf(&tmp, _("to record the above merge or update"));
    -+		strbuf_addf(&msg, _("   %s"), tmp.buf);
    -+		strbuf_addf(&msg, "\n");
    -+		strbuf_release(&tmp);
    ++	if (!csub->nr)
    ++		return;
    ++	
    ++	/*
    ++	 * NEEDSWORK: The steps to resolve these errors deserve a more
    ++	 * detailed explanation than what is currently printed below.
    ++	 */
    ++	for_each_string_list_item(item, csub) {
    ++		struct conflicted_submodule_item *util = item->util;
     +
    -+		strbuf_addf(&tmp, _("resolve any other conflicts in the superproject"));
    -+		strbuf_addf(&msg, _(" - %s"), tmp.buf);
    -+		strbuf_addf(&msg, "\n");
    -+		strbuf_release(&tmp);
    ++		if (util->flag == CONFLICT_SUBMODULE_NOT_INITIALIZED ||
    ++			util->flag == CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE)
    ++			return;
    ++	}
     +
    -+		strbuf_addf(&tmp, _("commit the resulting index in the superproject"));
    -+		strbuf_addf(&msg, _(" - %s"), tmp.buf);
    -+		strbuf_addf(&msg, "\n");
    -+		strbuf_release(&tmp);
    ++	printf(_("Recursive merging with submodules currently only supports "
    ++		"trivial cases.\nPlease manually handle the merging of each "
    ++		"conflicted submodule.\nThis can be accomplished with the following "
    ++		"steps:"));
    ++	putchar('\n');
     +
    -+		printf("%s", msg.buf);
    -+		strbuf_release(&msg);
    ++	for_each_string_list_item(item, csub) {
    ++		struct conflicted_submodule_item *util = item->util;
    ++		/*
    ++		 * TRANSLATORS: This is a line of advice to resolve a merge conflict
    ++		 * in a submodule. The second argument is the abbreviated id of the
    ++		 * commit that needs to be merged.
    ++		 * E.g. - go to submodule (sub), and either merge commit abc1234"
    ++		 */
    ++		strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s\n"
    ++			"or update to an existing commit which has merged those changes"),
    ++			item->string, util->abbrev);
    ++		format_submodule_conflict_suggestion(&tmp);
    ++		strbuf_add(&msg, tmp.buf, tmp.len);
    ++		strbuf_reset(&tmp);
     +	}
    ++	strbuf_add_separated_string_list(&subs, " ", csub);
    ++	strbuf_addstr(&tmp, _("come back to superproject and run:"));
    ++	strbuf_addf(&tmp, "\n\ngit add %s\n\n", subs.buf);
    ++	strbuf_addstr(&tmp, _("to record the above merge or update"));
    ++	format_submodule_conflict_suggestion(&tmp);
    ++	strbuf_add(&msg, tmp.buf, tmp.len);
    ++	strbuf_reset(&tmp);
    ++
    ++	strbuf_addstr(&tmp, _("resolve any other conflicts in the superproject"));
    ++	format_submodule_conflict_suggestion(&tmp);
    ++	strbuf_add(&msg, tmp.buf, tmp.len);
    ++	strbuf_reset(&tmp);
    ++
    ++	strbuf_addstr(&tmp, _("commit the resulting index in the superproject"));
    ++	format_submodule_conflict_suggestion(&tmp);
    ++	strbuf_add(&msg, tmp.buf, tmp.len);
    ++
    ++	printf("%s", msg.buf);
    ++	strbuf_release(&subs);
    ++	strbuf_release(&tmp);
    ++	strbuf_release(&msg);
     +}
     +
      void merge_display_update_messages(struct merge_options *opt,

 merge-ort.c                 | 161 ++++++++++++++++++++++++++++++++++--
 t/t6437-submodule-merge.sh  |  78 +++++++++++++++--
 t/t7402-submodule-rebase.sh |   9 +-
 3 files changed, 231 insertions(+), 17 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 01f150ef3b..86985d5c61 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -387,8 +387,24 @@ struct merge_options_internal {
 
 	/* call_depth: recursion level counter for merging merge bases */
 	int call_depth;
+
+	/* field that holds submodule conflict information */
+	struct string_list conflicted_submodules;
+};
+
+struct conflicted_submodule_item {
+	char *abbrev;
+	int flag;
 };
 
+static void conflicted_submodule_item_free(void *util, const char *str)
+{
+	struct conflicted_submodule_item *item = util;
+
+	free(item->abbrev);
+	free(item);
+}
+
 struct version_info {
 	struct object_id oid;
 	unsigned short mode;
@@ -517,6 +533,7 @@ enum conflict_and_info_types {
 	CONFLICT_SUBMODULE_NOT_INITIALIZED,
 	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
 	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
+	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
 
 	/* Keep this entry _last_ in the list */
 	NB_CONFLICT_TYPES,
@@ -570,6 +587,8 @@ static const char *type_short_descriptions[] = {
 		"CONFLICT (submodule history not available)",
 	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =
 		"CONFLICT (submodule may have rewinds)",
+	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
+		"CONFLICT (submodule lacks merge base)"
 };
 
 struct logical_conflict_info {
@@ -686,6 +705,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 
 	mem_pool_discard(&opti->pool, 0);
 
+	string_list_clear_func(&opti->conflicted_submodules,
+					conflicted_submodule_item_free);
+
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
@@ -1744,24 +1766,32 @@ static int merge_submodule(struct merge_options *opt,
 
 	int i;
 	int search = !opt->priv->call_depth;
+	int sub_not_initialized = 1;
+	int sub_flag = -1;
 
 	/* store fallback answer in result in case we fail */
 	oidcpy(result, opt->priv->call_depth ? o : a);
 
 	/* we can not handle deletion conflicts */
-	if (is_null_oid(o))
-		return 0;
-	if (is_null_oid(a))
-		return 0;
-	if (is_null_oid(b))
-		return 0;
+	if (is_null_oid(a) || is_null_oid(b))
+		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()");
 
-	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
+	if ((sub_not_initialized = repo_submodule_init(&subrepo,
+		opt->repo, path, null_oid()))) {
 		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s (not checked out)"),
 			 path);
-		return 0;
+		sub_flag = CONFLICT_SUBMODULE_NOT_INITIALIZED;
+		goto cleanup;
+	}
+
+	if (is_null_oid(o)) {
+		path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s (no merge base)"),
+			 path);
+		goto cleanup;
 	}
 
 	if (!(commit_o = lookup_commit_reference(&subrepo, o)) ||
@@ -1771,6 +1801,7 @@ static int merge_submodule(struct merge_options *opt,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s (commits not present)"),
 			 path);
+		sub_flag = CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE;
 		goto cleanup;
 	}
 
@@ -1849,7 +1880,23 @@ static int merge_submodule(struct merge_options *opt,
 
 	object_array_clear(&merges);
 cleanup:
-	repo_clear(&subrepo);
+	if (!opt->priv->call_depth && !ret) {
+		struct string_list *csub = &opt->priv->conflicted_submodules;
+		struct conflicted_submodule_item *util;
+		const char *abbrev;
+
+		util = xmalloc(sizeof(*util));
+		util->flag = sub_flag;
+		util->abbrev = NULL;
+		if (!sub_not_initialized) {
+			abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
+			util->abbrev = xstrdup(abbrev);
+		}
+		string_list_append(csub, path)->util = util;
+	}
+
+	if (!sub_not_initialized)
+		repo_clear(&subrepo);
 	return ret;
 }
 
@@ -4412,6 +4459,99 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	return errs;
 }
 
+static void format_submodule_conflict_suggestion(struct strbuf *msg) {
+	struct strbuf tmp = STRBUF_INIT;
+	struct string_list msg_list = STRING_LIST_INIT_DUP;
+	int i;
+
+	string_list_split(&msg_list, msg->buf, '\n', -1);
+	for (i = 0; i < msg_list.nr; i++) {
+		if (!i)
+			/*
+			 * TRANSLATORS: This is line item of submodule conflict message
+			 * from print_submodule_conflict_suggestion() below. For RTL
+			 * languages, the following swap is suggested:
+			 *      " - %s\n" -> "%s - \n"
+			 */
+			strbuf_addf(&tmp, _(" - %s\n"), msg_list.items[i].string);
+		else
+			/*
+			 * TRANSLATORS: This is line item of submodule conflict message
+			 * from print_submodule_conflict_suggestion() below. For RTL
+			 * languages, the following swap is suggested:
+			 *      "   %s\n" -> "%s   \n"
+			 */
+			strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
+	}
+	strbuf_reset(msg);
+	strbuf_add(msg, tmp.buf, tmp.len);
+}
+
+static void print_submodule_conflict_suggestion(struct string_list *csub) {
+	struct string_list_item *item;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+	struct strbuf subs = STRBUF_INIT;
+
+	if (!csub->nr)
+		return;
+	
+	/*
+	 * NEEDSWORK: The steps to resolve these errors deserve a more
+	 * detailed explanation than what is currently printed below.
+	 */
+	for_each_string_list_item(item, csub) {
+		struct conflicted_submodule_item *util = item->util;
+
+		if (util->flag == CONFLICT_SUBMODULE_NOT_INITIALIZED ||
+			util->flag == CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE)
+			return;
+	}
+
+	printf(_("Recursive merging with submodules currently only supports "
+		"trivial cases.\nPlease manually handle the merging of each "
+		"conflicted submodule.\nThis can be accomplished with the following "
+		"steps:"));
+	putchar('\n');
+
+	for_each_string_list_item(item, csub) {
+		struct conflicted_submodule_item *util = item->util;
+		/*
+		 * TRANSLATORS: This is a line of advice to resolve a merge conflict
+		 * in a submodule. The second argument is the abbreviated id of the
+		 * commit that needs to be merged.
+		 * E.g. - go to submodule (sub), and either merge commit abc1234"
+		 */
+		strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s\n"
+			"or update to an existing commit which has merged those changes"),
+			item->string, util->abbrev);
+		format_submodule_conflict_suggestion(&tmp);
+		strbuf_add(&msg, tmp.buf, tmp.len);
+		strbuf_reset(&tmp);
+	}
+	strbuf_add_separated_string_list(&subs, " ", csub);
+	strbuf_addstr(&tmp, _("come back to superproject and run:"));
+	strbuf_addf(&tmp, "\n\ngit add %s\n\n", subs.buf);
+	strbuf_addstr(&tmp, _("to record the above merge or update"));
+	format_submodule_conflict_suggestion(&tmp);
+	strbuf_add(&msg, tmp.buf, tmp.len);
+	strbuf_reset(&tmp);
+
+	strbuf_addstr(&tmp, _("resolve any other conflicts in the superproject"));
+	format_submodule_conflict_suggestion(&tmp);
+	strbuf_add(&msg, tmp.buf, tmp.len);
+	strbuf_reset(&tmp);
+
+	strbuf_addstr(&tmp, _("commit the resulting index in the superproject"));
+	format_submodule_conflict_suggestion(&tmp);
+	strbuf_add(&msg, tmp.buf, tmp.len);
+
+	printf("%s", msg.buf);
+	strbuf_release(&subs);
+	strbuf_release(&tmp);
+	strbuf_release(&msg);
+}
+
 void merge_display_update_messages(struct merge_options *opt,
 				   int detailed,
 				   struct merge_result *result)
@@ -4461,6 +4601,8 @@ void merge_display_update_messages(struct merge_options *opt,
 	}
 	string_list_clear(&olist, 0);
 
+	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
 			       opti->renames.needed_limit, 0);
@@ -4657,6 +4799,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	trace2_region_enter("merge", "allocate/init", opt->repo);
 	if (opt->priv) {
 		clear_or_reinit_internal_opts(opt->priv, 1);
+		string_list_init_nodup(&opt->priv->conflicted_submodules);
 		trace2_region_leave("merge", "allocate/init", opt->repo);
 		return;
 	}
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c253bf759a..414597a420 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
 	 echo "file-c" > file-c &&
 	 git add file-c &&
 	 git commit -m "sub-c") &&
-	git commit -a -m "c" &&
+	git commit -a -m "c")
+'
 
+test_expect_success 'merging should conflict for non fast-forward' '
+	test_when_finished "git -C merge-search reset --hard" &&
+	(cd merge-search &&
+	 git checkout -b test-nonforward-a b &&
+	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	  then
+		test_must_fail git merge c >actual &&
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 	grep "$sub_expect" actual
+	  else
+		test_must_fail git merge c 2> actual
+	  fi)
+'
+
+test_expect_success 'finish setup for merge-search' '
+	(cd merge-search &&
 	git checkout -b d a &&
 	(cd sub &&
 	 git checkout -b sub-d sub-b &&
@@ -129,14 +146,16 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
 	 test_cmp expect actual)
 '
 
-test_expect_success 'merging should conflict for non fast-forward' '
+test_expect_success 'merging should conflict for non fast-forward (resolution exists)' '
 	(cd merge-search &&
-	 git checkout -b test-nonforward b &&
+	 git checkout -b test-nonforward-b b &&
 	 (cd sub &&
 	  git rev-parse --short sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 	grep "$sub_expect" actual
 	  else
 		test_must_fail git merge c 2> actual
 	  fi &&
@@ -161,7 +180,9 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 ) &&
 	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	 then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+		grep "$sub_expect" actual
 	 else
 		test_must_fail git merge c 2> actual
 	 fi &&
@@ -205,7 +226,12 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f)
+	test_must_fail git merge f >actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+    then
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
+		grep "$sub_expect" actual
+	fi)
 '
 
 
@@ -476,4 +502,44 @@ test_expect_failure 'directory/submodule conflict; merge --abort works afterward
 	)
 '
 
+# Setup:
+#   - Submodule has 2 commits: a and b
+#   - Superproject branch 'a' adds and commits submodule pointing to 'commit a'
+#   - Superproject branch 'b' adds and commits submodule pointing to 'commit b'
+# If these two branches are now merged, there is no merge base
+test_expect_success 'setup for null merge base' '
+	mkdir no-merge-base &&
+	(cd no-merge-base &&
+	git init &&
+	mkdir sub &&
+	(cd sub &&
+	 git init &&
+	 echo "file-a" > file-a &&
+	 git add file-a &&
+	 git commit -m "commit a") &&
+	git commit --allow-empty -m init &&
+	git branch init &&
+	git checkout -b a init &&
+	git add sub &&
+	git commit -m "a" &&
+	git switch main &&
+	(cd sub &&
+	 echo "file-b" > file-b &&
+	 git add file-b &&
+	 git commit -m "commit b"))
+'
+
+test_expect_success 'merging should fail with no merge base' '
+	(cd no-merge-base &&
+	git checkout -b b init &&
+	git add sub &&
+	git commit -m "b" &&
+	test_must_fail git merge a >actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+    then
+		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short HEAD^1)" &&
+		grep "$sub_expect" actual
+	fi)
+'
+
 test_done
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..ebeca12a71 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should conflict' '
 	test_tick &&
 	git commit -m fourth &&
 
-	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
+	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
 	git ls-files -s submodule >actual &&
 	(
 		cd submodule &&
@@ -112,7 +112,12 @@ test_expect_success 'rebasing submodule that should conflict' '
 		echo "160000 $(git rev-parse HEAD^^) 2	submodule" &&
 		echo "160000 $(git rev-parse HEAD) 3	submodule"
 	) >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+    then
+		sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
+		grep "$sub_expect" actual_output
+	fi
 '
 
 test_done

base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
-- 
2.37.1.559.g78731f0fdb-goog

