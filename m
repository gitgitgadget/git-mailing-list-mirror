Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C404C43214
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDBF6102A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhHaC1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbhHaC1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25274C061760
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o39-20020a05600c512700b002e74638b567so1274570wms.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dGJBQ+9lxfP/ACKoQmXCfr25w0hleBh5682flMvpaH4=;
        b=vTliHpzSDHUpOF/oyshzCiwaKAzisAssXF88vx1mwCycmjXa26hhIhHwIZbpgG52ZJ
         0ztxOmdUexEhNCPcxA7w/DwsxL9VYNJ8U/J30VodRxTDIeCG+KlSBExDINL+m2btjGoP
         jSHT9z420Gvw1g2IngX9y+v1zBr9smTI/TKzD5yQnEWil/fPb8g7KaEPNM5ocbdD45A7
         qff1BMkWHftWK8evTPeutbFYgpbP294nPd4DzrwlG2UYnAmRPhQgno0kWRPfxD69e4hu
         ZiedKmUs/n4KN7hcDETKAF1XOP05pKQ2hWKQW5nhwdRCE02mpirD4BRbePEkTR2ZHbbK
         NlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dGJBQ+9lxfP/ACKoQmXCfr25w0hleBh5682flMvpaH4=;
        b=Ms1IleQi5lvS1qa2j7n6VK3MRAGeEpqGafUZYeiu7fLMzlBMZRa/7UnsIgb43iNHuh
         gwvl19hpce7V1VINBJMjipolpO3uWCDJcPeGcWrS4zpGp7vjfbm3tDMGk/czG2HvrqOV
         GuUc5Jspcenh4tnu5UInQPPD4ioSx5uksC+h4BA8UfRAqKBgsogdMQjl/ejAAhWsO7XZ
         rojaD+saK5RxWCHIVm3tbrgcprPQBwhf+HPqkq3HoZqXJkF/FCGGzV+RBZn3WEfPkqi+
         8IWM6kWvW0kTpmaROt30Lv4VSEdfjjgz7qE7t3SJtVLrmXGCMLc84cXjJptZQvi+mOug
         GMeg==
X-Gm-Message-State: AOAM531Oxol7l+lbM0LTXwfwNRIUs+NVzIF9HLftv1DXx4Eik4BmBof2
        IeQMx9d0p3GVoYIAfH8CLxoooRIiHUs=
X-Google-Smtp-Source: ABdhPJycMDBh43Opom8B8NPRQMdI1Vusls/6n3uWKq9ku7fEXHPC8oP1/JwSu43eCE7MKi3aCMsWZQ==
X-Received: by 2002:a1c:115:: with SMTP id 21mr1690203wmb.95.1630376802752;
        Mon, 30 Aug 2021 19:26:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l124sm1091746wml.8.2021.08.30.19.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:42 -0700 (PDT)
Message-Id: <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:35 +0000
Subject: [PATCH 2/7] merge-ort: add ability to record conflict messages in a
 file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to add an ability for users to run
    git show --remerge-diff $MERGE_COMMIT
or even
    git log -p --remerge-diff ...
and have git show the differences between where the merge machinery
would stop and what is recorded in merge commits.  However, in such
cases, stdout is not an appropriate location to dump conflict messages.
Write those messages to a file in the merge result (not to the working
tree or index, but just to a blob recorded in the relevant tree object).

There are several considerations here:
  * We have to pick file(s) where we write these conflict messages too
  * We want to make it as clear as possible that it's not a real file
    but a set of messages about another file
  * We want conflict messages about a file to appear near the file in
    question in a diff, preferably immediately preceding the file in
    question
  * Related to the above, per-file conflict messages are preferred
    over lumping all conflict messages into one big file

To achive the above:
  * We put the conflict messages for $filename in
      $filename[0:-1] + " " + $filename[-1] + ".conflict_msg"
    or, in words, we insert a space before the final character of
    the filename and then also add ".conflict_msg" at the end.
  * We start the file with a "== Conflict notices for $filename =="
    banner

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c       | 79 ++++++++++++++++++++++++++++++++++++++++++++++-
 merge-recursive.c |  3 ++
 merge-recursive.h |  1 +
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4dbf0a477af..a9e69d9cbb0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -632,7 +632,11 @@ static void path_msg(struct merge_options *opt,
 		     const char *fmt, ...)
 {
 	va_list ap;
-	struct strbuf *sb = strmap_get(&opt->priv->output, path);
+	struct strbuf *sb;
+
+	if (opt->record_conflict_msgs_in_tree && omittable_hint)
+		return; /* Do not record mere hints in tree */
+	sb = strmap_get(&opt->priv->output, path);
 	if (!sb) {
 		sb = xmalloc(sizeof(*sb));
 		strbuf_init(sb, 0);
@@ -3531,6 +3535,74 @@ static void write_completed_directory(struct merge_options *opt,
 	info->last_directory_len = strlen(info->last_directory);
 }
 
+static void put_path_msgs_in_file(struct merge_options *opt,
+				  const char *path,
+				  struct merged_info *mi,
+				  struct directory_versions *dir_metadata)
+{
+	struct strbuf tmp = STRBUF_INIT, new_path_contents = STRBUF_INIT;
+	char *new_path;
+	int new_path_basic_len, unique_counter;
+	struct merged_info *new_mi;
+	char final;
+	struct strbuf *sb = strmap_get(&opt->priv->output, path);
+
+	assert(opt->record_conflict_msgs_in_tree);
+	if (!sb)
+		return;
+
+	/*
+	 * Determine a pathname for recording conflict messages.  We'd like it
+	 * to sort just before path, but have a name very similar to what path
+	 * has.
+	 */
+	strbuf_addstr(&tmp, path);
+	final = tmp.buf[tmp.len-1];
+	strbuf_setlen(&tmp, tmp.len-1);
+	strbuf_addf(&tmp, " %c.conflict_msg", final);
+
+	/*
+	 * In extremely unlikely event this filename is not unique, modify it
+	 * with ".<integer>" suffixes until it is.
+	 */
+	new_path_basic_len = tmp.len;
+	unique_counter = 0;
+	while (strmap_contains(&opt->priv->paths, tmp.buf)) {
+		strbuf_setlen(&tmp, new_path_basic_len);
+		strbuf_addf(&tmp, ".%d", ++unique_counter);
+	}
+
+	/* Now that we have a unique string, move it to our pool */
+	new_path = mem_pool_strdup(&opt->priv->pool, tmp.buf);
+	strbuf_release(&tmp);
+
+	/* Set up contents we want to place in the file. */
+	strbuf_addf(&new_path_contents, "== Conflict notices for %s ==\n",
+		    path);
+	strbuf_addbuf(&new_path_contents, sb);
+
+	/* Set up new_mi */
+	new_mi = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*new_mi));
+	new_mi->result.mode = 0100644;
+	new_mi->is_null = 0;
+	new_mi->clean = 1;
+	new_mi->basename_offset = mi->basename_offset;
+	new_mi->directory_name = mi->directory_name;
+	if (write_object_file(new_path_contents.buf, new_path_contents.len,
+			      blob_type, &new_mi->result.oid))
+		die(_("Unable to add %s to database"), new_path);
+
+	/*
+	 * Save new_mi in opt->priv->path (so that something will deallocate
+	 * it later), and record the entry for it.
+	 */
+	strmap_put(&opt->priv->paths, new_path, new_mi);
+	record_entry_for_tree(dir_metadata, new_path, new_mi);
+
+	/* Cleanup */
+	strbuf_release(&new_path_contents);
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -3991,6 +4063,8 @@ static void process_entries(struct merge_options *opt,
 			struct conflict_info *ci = (struct conflict_info *)mi;
 			process_entry(opt, path, ci, &dir_metadata);
 		}
+		if (!opt->priv->call_depth && opt->record_conflict_msgs_in_tree)
+			put_path_msgs_in_file(opt, path, mi, &dir_metadata);
 	}
 	trace2_region_leave("merge", "processing", opt->repo);
 
@@ -4226,6 +4300,9 @@ void merge_switch_to_result(struct merge_options *opt,
 		struct string_list olist = STRING_LIST_INIT_NODUP;
 		int i;
 
+		if (opt->record_conflict_msgs_in_tree)
+			BUG("Either display conflict messages or record them in tree, not both");
+
 		trace2_region_enter("merge", "display messages", opt->repo);
 
 		/* Hack to pre-allocate olist to the desired size */
diff --git a/merge-recursive.c b/merge-recursive.c
index 3355d50e8ad..b14fa15be91 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3697,6 +3697,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 	assert(opt->priv == NULL);
 
+	/* Not supported; option specific to merge-ort */
+	assert(!opt->record_conflict_msgs_in_tree);
+
 	/* Sanity check on repo state; index must match head */
 	if (repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
diff --git a/merge-recursive.h b/merge-recursive.h
index 0795a1d3ec1..2e2fab37f46 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -46,6 +46,7 @@ struct merge_options {
 	/* miscellaneous control options */
 	const char *subtree_shift;
 	unsigned renormalize : 1;
+	unsigned record_conflict_msgs_in_tree : 1;
 
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
-- 
gitgitgadget

