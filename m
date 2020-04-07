Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7740AC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3562074F
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QS5Lq7gM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDGWLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:11:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49572 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGWLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:11:52 -0400
Received: by mail-pg1-f202.google.com with SMTP id d124so3720199pgc.16
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=43MYbE/hyG1izc8rMNXHcDfyydvqL4rfIdexbBL/YP4=;
        b=QS5Lq7gMSt9uo+66caFZaIubvqYh3e5tnYR3q9HOQeUqBYPc5QUgxuGNLNqCJsEpyO
         oSurAABFCNNkYB43xJZb6innI0TEK7Hjje6GchsDbjtGIXoQ/uinIM8od321QwRdWREa
         gBH9hTu1NvwejJ+WW8dlkixysDK1fEqPEp+qLDKPAmCnyMGWjx15jEZ08CQlWETSt6zU
         vMLvw70L7MpsKkSNwF5JDGhQ0asx6FfSsF06RsnICzW2nKAOF6V4pekvsM7AVOLN6p9w
         uE97Z6FBwXMhtPr215uPY3SRhRHqgEQ0J7hj3IXqkrydz3FXfo4DU6hMASeZFqWUq78A
         we/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=43MYbE/hyG1izc8rMNXHcDfyydvqL4rfIdexbBL/YP4=;
        b=VojrJ3nKDlbn+kpu3VjxY5YlFBcj1AYjtzJOJgWJ3v6Ez/qWr8lp5Xo2fe5ycdN1ZY
         nP5yXFsM5Ekl3JXsNEvUeUPvTiIHquRzallOKtxe/+6OaTNRKamhg16fzh1VHsjVMnsj
         tKSyn3HG21NbjdMPf7l1OXAvDKIi835xxxjGDuOtmJuR/gInWwK+gpb2/V1z+e9VOW2l
         A/jDTgeGCdlCHGlb0b4+thoVskZqmI5n33VB0GunFkwUkvANMOsJjp9BaClt9L5nmJJy
         6Aufk13LtV7T0hdjmMp31GnWbYnFsTypOhnrrM7vVvd2H/vQpI3J3eAGy9ybep3zg89g
         asLw==
X-Gm-Message-State: AGi0PuZlVzTRhcRCCcauIqyCc9Nl+CM/YbJiTR2g224MxOq531xkqxC1
        4o6TxA7YAT8eagmFCOWlAImo6jT+a/mj2vrzRYE7y8I4m3dgvBwNaBc1RWgOPDQ8C+9EJSRG0kH
        Gfb0rGc80nJZ7ic4Ade62oE5F2an3/civzGMlArNCbzWGbO7LoUrOKSyyKh2LZAnOBPj4y0//oR
        RO
X-Google-Smtp-Source: APiQypIDIv3613/lL4g3l1RllD90R57164vEWQz+p2nM/awk8gah65btHBFJTsbcwHdqymv/czdp5ULlpTawrlX3uApP
X-Received: by 2002:a17:90a:c206:: with SMTP id e6mr1520435pjt.35.1586297510980;
 Tue, 07 Apr 2020 15:11:50 -0700 (PDT)
Date:   Tue,  7 Apr 2020 15:11:41 -0700
In-Reply-To: <cover.1586296510.git.jonathantanmy@google.com>
Message-Id: <c1973fd6308109b0cc99544500d8932222b66726.1586296510.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com> <cover.1586296510.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v3 2/4] diff: make diff_populate_filespec_options struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, garimasigit@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of diff_populate_filespec() currently can be customized
through a bitflag, but a subsequent patch requires it to support a
non-boolean option. Replace the bitflag with an options struct.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c            | 54 ++++++++++++++++++++++++++++++-----------------
 diffcore-break.c  |  4 ++--
 diffcore-rename.c | 13 +++++++-----
 diffcore.h        |  9 +++++---
 line-log.c        |  6 +++---
 5 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/diff.c b/diff.c
index f01b4d91b8..f337d837ac 100644
--- a/diff.c
+++ b/diff.c
@@ -573,7 +573,7 @@ static int fill_mmfile(struct repository *r, mmfile_t *mf,
 		mf->size = 0;
 		return 0;
 	}
-	else if (diff_populate_filespec(r, one, 0))
+	else if (diff_populate_filespec(r, one, NULL))
 		return -1;
 
 	mf->ptr = one->data;
@@ -585,9 +585,13 @@ static int fill_mmfile(struct repository *r, mmfile_t *mf,
 static unsigned long diff_filespec_size(struct repository *r,
 					struct diff_filespec *one)
 {
+	struct diff_populate_filespec_options dpf_options = {
+		.check_size_only = 1,
+	};
+
 	if (!DIFF_FILE_VALID(one))
 		return 0;
-	diff_populate_filespec(r, one, CHECK_SIZE_ONLY);
+	diff_populate_filespec(r, one, &dpf_options);
 	return one->size;
 }
 
@@ -3020,6 +3024,9 @@ static void show_dirstat(struct diff_options *options)
 		struct diff_filepair *p = q->queue[i];
 		const char *name;
 		unsigned long copied, added, damage;
+		struct diff_populate_filespec_options dpf_options = {
+			.check_size_only = 1,
+		};
 
 		name = p->two->path ? p->two->path : p->one->path;
 
@@ -3047,19 +3054,19 @@ static void show_dirstat(struct diff_options *options)
 		}
 
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
-			diff_populate_filespec(options->repo, p->one, 0);
-			diff_populate_filespec(options->repo, p->two, 0);
+			diff_populate_filespec(options->repo, p->one, NULL);
+			diff_populate_filespec(options->repo, p->two, NULL);
 			diffcore_count_changes(options->repo,
 					       p->one, p->two, NULL, NULL,
 					       &copied, &added);
 			diff_free_filespec_data(p->one);
 			diff_free_filespec_data(p->two);
 		} else if (DIFF_FILE_VALID(p->one)) {
-			diff_populate_filespec(options->repo, p->one, CHECK_SIZE_ONLY);
+			diff_populate_filespec(options->repo, p->one, &dpf_options);
 			copied = added = 0;
 			diff_free_filespec_data(p->one);
 		} else if (DIFF_FILE_VALID(p->two)) {
-			diff_populate_filespec(options->repo, p->two, CHECK_SIZE_ONLY);
+			diff_populate_filespec(options->repo, p->two, &dpf_options);
 			copied = 0;
 			added = p->two->size;
 			diff_free_filespec_data(p->two);
@@ -3339,13 +3346,17 @@ static void emit_binary_diff(struct diff_options *o,
 int diff_filespec_is_binary(struct repository *r,
 			    struct diff_filespec *one)
 {
+	struct diff_populate_filespec_options dpf_options = {
+		.check_binary = 1,
+	};
+
 	if (one->is_binary == -1) {
 		diff_filespec_load_driver(one, r->index);
 		if (one->driver->binary != -1)
 			one->is_binary = one->driver->binary;
 		else {
 			if (!one->data && DIFF_FILE_VALID(one))
-				diff_populate_filespec(r, one, CHECK_BINARY);
+				diff_populate_filespec(r, one, &dpf_options);
 			if (one->is_binary == -1 && one->data)
 				one->is_binary = buffer_is_binary(one->data,
 						one->size);
@@ -3677,8 +3688,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	}
 
 	else if (complete_rewrite) {
-		diff_populate_filespec(o->repo, one, 0);
-		diff_populate_filespec(o->repo, two, 0);
+		diff_populate_filespec(o->repo, one, NULL);
+		diff_populate_filespec(o->repo, two, NULL);
 		data->deleted = count_lines(one->data, one->size);
 		data->added = count_lines(two->data, two->size);
 	}
@@ -3914,9 +3925,10 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
  */
 int diff_populate_filespec(struct repository *r,
 			   struct diff_filespec *s,
-			   unsigned int flags)
+			   const struct diff_populate_filespec_options *options)
 {
-	int size_only = flags & CHECK_SIZE_ONLY;
+	int size_only = options ? options->check_size_only : 0;
+	int check_binary = options ? options->check_binary : 0;
 	int err = 0;
 	int conv_flags = global_conv_flags_eol;
 	/*
@@ -3986,7 +3998,7 @@ int diff_populate_filespec(struct repository *r,
 		 * opening the file and inspecting the contents, this
 		 * is probably fine.
 		 */
-		if ((flags & CHECK_BINARY) &&
+		if (check_binary &&
 		    s->size > big_file_threshold && s->is_binary == -1) {
 			s->is_binary = 1;
 			return 0;
@@ -4012,7 +4024,7 @@ int diff_populate_filespec(struct repository *r,
 	}
 	else {
 		enum object_type type;
-		if (size_only || (flags & CHECK_BINARY)) {
+		if (size_only || check_binary) {
 			type = oid_object_info(r, &s->oid, &s->size);
 			if (type < 0)
 				die("unable to read %s",
@@ -4144,7 +4156,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 		return temp;
 	}
 	else {
-		if (diff_populate_filespec(r, one, 0))
+		if (diff_populate_filespec(r, one, NULL))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(r->index, name, temp,
 			       one->data, one->size,
@@ -6410,9 +6422,9 @@ static int diff_filespec_is_identical(struct repository *r,
 {
 	if (S_ISGITLINK(one->mode))
 		return 0;
-	if (diff_populate_filespec(r, one, 0))
+	if (diff_populate_filespec(r, one, NULL))
 		return 0;
-	if (diff_populate_filespec(r, two, 0))
+	if (diff_populate_filespec(r, two, NULL))
 		return 0;
 	return !memcmp(one->data, two->data, one->size);
 }
@@ -6420,6 +6432,10 @@ static int diff_filespec_is_identical(struct repository *r,
 static int diff_filespec_check_stat_unmatch(struct repository *r,
 					    struct diff_filepair *p)
 {
+	struct diff_populate_filespec_options dpf_options = {
+		.check_size_only = 1,
+	};
+
 	if (p->done_skip_stat_unmatch)
 		return p->skip_stat_unmatch_result;
 
@@ -6442,8 +6458,8 @@ static int diff_filespec_check_stat_unmatch(struct repository *r,
 	    !DIFF_FILE_VALID(p->two) ||
 	    (p->one->oid_valid && p->two->oid_valid) ||
 	    (p->one->mode != p->two->mode) ||
-	    diff_populate_filespec(r, p->one, CHECK_SIZE_ONLY) ||
-	    diff_populate_filespec(r, p->two, CHECK_SIZE_ONLY) ||
+	    diff_populate_filespec(r, p->one, &dpf_options) ||
+	    diff_populate_filespec(r, p->two, &dpf_options) ||
 	    (p->one->size != p->two->size) ||
 	    !diff_filespec_is_identical(r, p->one, p->two)) /* (2) */
 		p->skip_stat_unmatch_result = 1;
@@ -6773,7 +6789,7 @@ size_t fill_textconv(struct repository *r,
 			*outbuf = "";
 			return 0;
 		}
-		if (diff_populate_filespec(r, df, 0))
+		if (diff_populate_filespec(r, df, NULL))
 			die("unable to read files to diff");
 		*outbuf = df->data;
 		return df->size;
diff --git a/diffcore-break.c b/diffcore-break.c
index 9d20a6a6fc..e8f6322c6a 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -62,8 +62,8 @@ static int should_break(struct repository *r,
 	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (diff_populate_filespec(r, src, 0) ||
-	    diff_populate_filespec(r, dst, 0))
+	if (diff_populate_filespec(r, src, NULL) ||
+	    diff_populate_filespec(r, dst, NULL))
 		return 0; /* error but caught downstream */
 
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index e189f407af..bf4c0b8740 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -148,6 +148,9 @@ static int estimate_similarity(struct repository *r,
 	 */
 	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
 	int score;
+	struct diff_populate_filespec_options dpf_options = {
+		.check_size_only = 1
+	};
 
 	/* We deal only with regular files.  Symlink renames are handled
 	 * only when they are exact matches --- in other words, no edits
@@ -166,10 +169,10 @@ static int estimate_similarity(struct repository *r,
 	 * say whether the size is valid or not!)
 	 */
 	if (!src->cnt_data &&
-	    diff_populate_filespec(r, src, CHECK_SIZE_ONLY))
+	    diff_populate_filespec(r, src, &dpf_options))
 		return 0;
 	if (!dst->cnt_data &&
-	    diff_populate_filespec(r, dst, CHECK_SIZE_ONLY))
+	    diff_populate_filespec(r, dst, &dpf_options))
 		return 0;
 
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
@@ -187,9 +190,9 @@ static int estimate_similarity(struct repository *r,
 	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
-	if (!src->cnt_data && diff_populate_filespec(r, src, 0))
+	if (!src->cnt_data && diff_populate_filespec(r, src, NULL))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(r, dst, 0))
+	if (!dst->cnt_data && diff_populate_filespec(r, dst, NULL))
 		return 0;
 
 	if (diffcore_count_changes(r, src, dst,
@@ -261,7 +264,7 @@ static unsigned int hash_filespec(struct repository *r,
 				  struct diff_filespec *filespec)
 {
 	if (!filespec->oid_valid) {
-		if (diff_populate_filespec(r, filespec, 0))
+		if (diff_populate_filespec(r, filespec, NULL))
 			return 0;
 		hash_object_file(r->hash_algo, filespec->data, filespec->size,
 				 "blob", &filespec->oid);
diff --git a/diffcore.h b/diffcore.h
index 7c07347e42..3b2020ce93 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -65,9 +65,12 @@ void free_filespec(struct diff_filespec *);
 void fill_filespec(struct diff_filespec *, const struct object_id *,
 		   int, unsigned short);
 
-#define CHECK_SIZE_ONLY 1
-#define CHECK_BINARY    2
-int diff_populate_filespec(struct repository *, struct diff_filespec *, unsigned int);
+struct diff_populate_filespec_options {
+	unsigned check_size_only : 1;
+	unsigned check_binary : 1;
+};
+int diff_populate_filespec(struct repository *, struct diff_filespec *,
+			   const struct diff_populate_filespec_options *);
 void diff_free_filespec_data(struct diff_filespec *);
 void diff_free_filespec_blob(struct diff_filespec *);
 int diff_filespec_is_binary(struct repository *, struct diff_filespec *);
diff --git a/line-log.c b/line-log.c
index 9010e00950..40e1738dbb 100644
--- a/line-log.c
+++ b/line-log.c
@@ -519,7 +519,7 @@ static void fill_line_ends(struct repository *r,
 	unsigned long *ends = NULL;
 	char *data = NULL;
 
-	if (diff_populate_filespec(r, spec, 0))
+	if (diff_populate_filespec(r, spec, NULL))
 		die("Cannot read blob %s", oid_to_hex(&spec->oid));
 
 	ALLOC_ARRAY(ends, size);
@@ -1045,12 +1045,12 @@ static int process_diff_filepair(struct rev_info *rev,
 		return 0;
 
 	assert(pair->two->oid_valid);
-	diff_populate_filespec(rev->diffopt.repo, pair->two, 0);
+	diff_populate_filespec(rev->diffopt.repo, pair->two, NULL);
 	file_target.ptr = pair->two->data;
 	file_target.size = pair->two->size;
 
 	if (pair->one->oid_valid) {
-		diff_populate_filespec(rev->diffopt.repo, pair->one, 0);
+		diff_populate_filespec(rev->diffopt.repo, pair->one, NULL);
 		file_parent.ptr = pair->one->data;
 		file_parent.size = pair->one->size;
 	} else {
-- 
2.26.0.292.g33ef6b2f38-goog

