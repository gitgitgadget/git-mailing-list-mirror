Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E6BC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D2222CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgLDUt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgLDUtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:25 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436CAC08E864
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so6609193wrt.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t2s9uic3y9iLNpiRf7m/spmlzdIvl6f1Dda1So6z99w=;
        b=QgXYsAHkGp+m8snXjpneAMvJhMoFcbu5sAoZNkxYFTMpylY9N6zO6vGELVuRhsy5BL
         JUsHKTqYDzSGeApQcgGrOl23grGBRmG/9IMWbGHafrHgkbvzO7awkNts/+bn9aQMxsCk
         Xc3Sbd3klXDznfft3cGgf80H4mxUvRuvTLIyoB8Xq9/YmjjVigAB+nZEYGPICr00DwWH
         G9zXEpggdrGrZfGczer/Ymd48tfvXm95EnOm3wAEr+4zNNoXc4OCJXVoENM/q+vSAh1r
         9Wu1RLFS+8ddZW6usUNuDd8POO8OP9Oxahfzhr9wuuG0AiiQr0AVp5/c4s992xSnzXHC
         c26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t2s9uic3y9iLNpiRf7m/spmlzdIvl6f1Dda1So6z99w=;
        b=iAFn0x6D7Fb4ObuTJ131xG/vocBwicTb+kgiq9LW/9Fc4sc5zjxx9EqVOvcT0Ib+VQ
         iYGN6Dsqkf3ZZZrzf8HNciObeP34i/yt8qEhz8jPXBWW8JAHNiAYGTy6cJvBU6ZxcmIi
         Ppo+aQWCCEyaNixQDsTA7K7PlYjtVihHCpSGm4efxHpcvG5COrKT5tu2/3OnTwJEkQvf
         dgPL0QNjQr/H6muG5uk4tWv+aZb0D70IFtC4q93ej5m0DLSKKlVeWeC4x9Lmu8YLmsg5
         1a22QTTQaYJDNpUDm6RpT/fRPIbJ21T0BYSljHRB90q8R7OgG+zF9/gDNQXASWMvsGxR
         FPog==
X-Gm-Message-State: AOAM530aXkYDQrNStREfLAU0CcMToZzD9YzkKJqLYdw5GlmxKwV//6qm
        wmjJ/J/OuQgFyrThFMXnjXFhB/0pw/4=
X-Google-Smtp-Source: ABdhPJyDviQrCMMysSBJDffaPbxjQCqgxaybq4r1An6wh+sWu0y6yThUmVO5MIzvy6J29g6oGrKbKg==
X-Received: by 2002:adf:f607:: with SMTP id t7mr6879579wrp.169.1607114908399;
        Fri, 04 Dec 2020 12:48:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm4918046wrw.15.2020.12.04.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:27 -0800 (PST)
Message-Id: <da4fe900496008193173cbdfb31200243b124d86.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:05 +0000
Subject: [PATCH v2 15/20] merge-ort: step 3 of tree writing -- handling
 subdirectories as we go
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Our order for processing of entries means that if we have a tree of
files that looks like
   Makefile
   src/moduleA/foo.c
   src/moduleA/bar.c
   src/moduleB/baz.c
   src/moduleB/umm.c
   tokens.txt

Then we will process paths in the order of the leftmost column below.  I
have added two additional columns that help explain the algorithm that
follows; the 2nd column is there to remind us we have oid & mode info we
are tracking for each of these paths (which differs between the paths
which I'm not representing well here), and the third column annotates
the parent directory of the entry:
   tokens.txt               <version_info>    ""
   src/moduleB/umm.c        <version_info>    src/moduleB
   src/moduleB/baz.c        <version_info>    src/moduleB
   src/moduleB              <version_info>    src
   src/moduleA/foo.c        <version_info>    src/moduleA
   src/moduleA/bar.c        <version_info>    src/moduleA
   src/moduleA              <version_info>    src
   src                      <version_info>    ""
   Makefile                 <version_info>    ""

When the parent directory changes, if it's a subdirectory of the previous
parent directory (e.g. "" -> src/moduleB) then we can just keep appending.
If the parent directory differs from the previous parent directory and is
not a subdirectory, then we should process that directory.

So, for example, when we get to this point:
   tokens.txt               <version_info>    ""
   src/moduleB/umm.c        <version_info>    src/moduleB
   src/moduleB/baz.c        <version_info>    src/moduleB

and note that the next entry (src/moduleB) has a different parent than
the last one that isn't a subdirectory, we should write out a tree for it
   100644 blob <HASH> umm.c
   100644 blob <HASH> baz.c

then pop all the entries under that directory while recording the new
hash for that directory, leaving us with
   tokens.txt               <version_info>        ""
   src/moduleB              <new version_info>    src

This process repeats until at the end we get to
   tokens.txt               <version_info>        ""
   src                      <new version_info>    ""
   Makefile                 <version_info>        ""

and then we can write out the toplevel tree.  Since we potentially have
entries in our string_list corresponding to multiple different toplevel
directories, e.g. a slightly different repository might have:
   whizbang.txt             <version_info>        ""
   tokens.txt               <version_info>        ""
   src/moduleD              <new version_info>    src
   src/moduleC              <new version_info>    src
   src/moduleB              <new version_info>    src
   src/moduleA/foo.c        <version_info>        src/moduleA
   src/moduleA/bar.c        <version_info>        src/moduleA

When src/moduleA is popped off, we need to know that the "last
directory" reverts back to src, and how many entries in our string_list
are associated with that parent directory.  So I use an auxiliary
offsets string_list which would have (parent_directory,offset)
information of the form
   ""             0
   src            2
   src/moduleA    5

Whenever I write out a tree for a subdirectory, I set versions.nr to
the final offset value and then decrement offsets.nr...and then add
an entry to versions with a hash for the new directory.

The idea is relatively simple, there's just a lot of accounting to
implement this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 234 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index eec6874943..cf6f395c69 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -494,7 +494,46 @@ static int string_list_df_name_compare(const char *one, const char *two)
 }
 
 struct directory_versions {
+	/*
+	 * versions: list of (basename -> version_info)
+	 *
+	 * The basenames are in reverse lexicographic order of full pathnames,
+	 * as processed in process_entries().  This puts all entries within
+	 * a directory together, and covers the directory itself after
+	 * everything within it, allowing us to write subtrees before needing
+	 * to record information for the tree itself.
+	 */
 	struct string_list versions;
+
+	/*
+	 * offsets: list of (full relative path directories -> integer offsets)
+	 *
+	 * Since versions contains basenames from files in multiple different
+	 * directories, we need to know which entries in versions correspond
+	 * to which directories.  Values of e.g.
+	 *     ""             0
+	 *     src            2
+	 *     src/moduleA    5
+	 * Would mean that entries 0-1 of versions are files in the toplevel
+	 * directory, entries 2-4 are files under src/, and the remaining
+	 * entries starting at index 5 are files under src/moduleA/.
+	 */
+	struct string_list offsets;
+
+	/*
+	 * last_directory: directory that previously processed file found in
+	 *
+	 * last_directory starts NULL, but records the directory in which the
+	 * previous file was found within.  As soon as
+	 *    directory(current_file) != last_directory
+	 * then we need to start updating accounting in versions & offsets.
+	 * Note that last_directory is always the last path in "offsets" (or
+	 * NULL if "offsets" is empty) so this exists just for quick access.
+	 */
+	const char *last_directory;
+
+	/* last_directory_len: cached computation of strlen(last_directory) */
+	unsigned last_directory_len;
 };
 
 static int tree_entry_order(const void *a_, const void *b_)
@@ -569,6 +608,181 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
 			   basename)->util = &mi->result;
 }
 
+static void write_completed_directory(struct merge_options *opt,
+				      const char *new_directory_name,
+				      struct directory_versions *info)
+{
+	const char *prev_dir;
+	struct merged_info *dir_info = NULL;
+	unsigned int offset;
+
+	/*
+	 * Some explanation of info->versions and info->offsets...
+	 *
+	 * process_entries() iterates over all relevant files AND
+	 * directories in reverse lexicographic order, and calls this
+	 * function.  Thus, an example of the paths that process_entries()
+	 * could operate on (along with the directories for those paths
+	 * being shown) is:
+	 *
+	 *     xtract.c             ""
+	 *     tokens.txt           ""
+	 *     src/moduleB/umm.c    src/moduleB
+	 *     src/moduleB/stuff.h  src/moduleB
+	 *     src/moduleB/baz.c    src/moduleB
+	 *     src/moduleB          src
+	 *     src/moduleA/foo.c    src/moduleA
+	 *     src/moduleA/bar.c    src/moduleA
+	 *     src/moduleA          src
+	 *     src                  ""
+	 *     Makefile             ""
+	 *
+	 * info->versions:
+	 *
+	 *     always contains the unprocessed entries and their
+	 *     version_info information.  For example, after the first five
+	 *     entries above, info->versions would be:
+	 *
+	 *     	   xtract.c     <xtract.c's version_info>
+	 *     	   token.txt    <token.txt's version_info>
+	 *     	   umm.c        <src/moduleB/umm.c's version_info>
+	 *     	   stuff.h      <src/moduleB/stuff.h's version_info>
+	 *     	   baz.c        <src/moduleB/baz.c's version_info>
+	 *
+	 *     Once a subdirectory is completed we remove the entries in
+	 *     that subdirectory from info->versions, writing it as a tree
+	 *     (write_tree()).  Thus, as soon as we get to src/moduleB,
+	 *     info->versions would be updated to
+	 *
+	 *     	   xtract.c     <xtract.c's version_info>
+	 *     	   token.txt    <token.txt's version_info>
+	 *     	   moduleB      <src/moduleB's version_info>
+	 *
+	 * info->offsets:
+	 *
+	 *     helps us track which entries in info->versions correspond to
+	 *     which directories.  When we are N directories deep (e.g. 4
+	 *     for src/modA/submod/subdir/), we have up to N+1 unprocessed
+	 *     directories (+1 because of toplevel dir).  Corresponding to
+	 *     the info->versions example above, after processing five entries
+	 *     info->offsets will be:
+	 *
+	 *     	   ""           0
+	 *     	   src/moduleB  2
+	 *
+	 *     which is used to know that xtract.c & token.txt are from the
+	 *     toplevel dirctory, while umm.c & stuff.h & baz.c are from the
+	 *     src/moduleB directory.  Again, following the example above,
+	 *     once we need to process src/moduleB, then info->offsets is
+	 *     updated to
+	 *
+	 *     	   ""           0
+	 *     	   src          2
+	 *
+	 *     which says that moduleB (and only moduleB so far) is in the
+	 *     src directory.
+	 *
+	 *     One unique thing to note about info->offsets here is that
+	 *     "src" was not added to info->offsets until there was a path
+	 *     (a file OR directory) immediately below src/ that got
+	 *     processed.
+	 *
+	 * Since process_entry() just appends new entries to info->versions,
+	 * write_completed_directory() only needs to do work if the next path
+	 * is in a directory that is different than the last directory found
+	 * in info->offsets.
+	 */
+
+	/*
+	 * If we are working with the same directory as the last entry, there
+	 * is no work to do.  (See comments above the directory_name member of
+	 * struct merged_info for why we can use pointer comparison instead of
+	 * strcmp here.)
+	 */
+	if (new_directory_name == info->last_directory)
+		return;
+
+	/*
+	 * If we are just starting (last_directory is NULL), or last_directory
+	 * is a prefix of the current directory, then we can just update
+	 * info->offsets to record the offset where we started this directory
+	 * and update last_directory to have quick access to it.
+	 */
+	if (info->last_directory == NULL ||
+	    !strncmp(new_directory_name, info->last_directory,
+		     info->last_directory_len)) {
+		uintptr_t offset = info->versions.nr;
+
+		info->last_directory = new_directory_name;
+		info->last_directory_len = strlen(info->last_directory);
+		/*
+		 * Record the offset into info->versions where we will
+		 * start recording basenames of paths found within
+		 * new_directory_name.
+		 */
+		string_list_append(&info->offsets,
+				   info->last_directory)->util = (void*)offset;
+		return;
+	}
+
+	/*
+	 * The next entry that will be processed will be within
+	 * new_directory_name.  Since at this point we know that
+	 * new_directory_name is within a different directory than
+	 * info->last_directory, we have all entries for info->last_directory
+	 * in info->versions and we need to create a tree object for them.
+	 */
+	dir_info = strmap_get(&opt->priv->paths, info->last_directory);
+	assert(dir_info);
+	offset = (uintptr_t)info->offsets.items[info->offsets.nr-1].util;
+	if (offset == info->versions.nr) {
+		/*
+		 * Actually, we don't need to create a tree object in this
+		 * case.  Whenever all files within a directory disappear
+		 * during the merge (e.g. unmodified on one side and
+		 * deleted on the other, or files were renamed elsewhere),
+		 * then we get here and the directory itself needs to be
+		 * omitted from its parent tree as well.
+		 */
+		dir_info->is_null = 1;
+	} else {
+		/*
+		 * Write out the tree to the git object directory, and also
+		 * record the mode and oid in dir_info->result.
+		 */
+		dir_info->is_null = 0;
+		dir_info->result.mode = S_IFDIR;
+		write_tree(&dir_info->result.oid, &info->versions, offset,
+			   opt->repo->hash_algo->rawsz);
+	}
+
+	/*
+	 * We've now used several entries from info->versions and one entry
+	 * from info->offsets, so we get rid of those values.
+	 */
+	info->offsets.nr--;
+	info->versions.nr = offset;
+
+	/*
+	 * Now we've taken care of the completed directory, but we need to
+	 * prepare things since future entries will be in
+	 * new_directory_name.  (In particular, process_entry() will be
+	 * appending new entries to info->versions.)  So, we need to make
+	 * sure new_directory_name is the last entry in info->offsets.
+	 */
+	prev_dir = info->offsets.nr == 0 ? NULL :
+		   info->offsets.items[info->offsets.nr-1].string;
+	if (new_directory_name != prev_dir) {
+		uintptr_t c = info->versions.nr;
+		string_list_append(&info->offsets,
+				   new_directory_name)->util = (void*)c;
+	}
+
+	/* And, of course, we need to update last_directory to match. */
+	info->last_directory = new_directory_name;
+	info->last_directory_len = strlen(info->last_directory);
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -667,7 +881,9 @@ static void process_entries(struct merge_options *opt,
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
 	struct string_list_item *entry;
-	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP };
+	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
+						   STRING_LIST_INIT_NODUP,
+						   NULL, 0 };
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
@@ -687,6 +903,11 @@ static void process_entries(struct merge_options *opt,
 	/*
 	 * Iterate over the items in reverse order, so we can handle paths
 	 * below a directory before needing to handle the directory itself.
+	 *
+	 * This allows us to write subtrees before we need to write trees,
+	 * and it also enables sane handling of directory/file conflicts
+	 * (because it allows us to know whether the directory is still in
+	 * the way when it is time to process the file at the same path).
 	 */
 	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
 		char *path = entry->string;
@@ -697,6 +918,8 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct merged_info *mi = entry->util;
 
+		write_completed_directory(opt, mi->directory_name,
+					  &dir_metadata);
 		if (mi->clean)
 			record_entry_for_tree(&dir_metadata, path, mi);
 		else {
@@ -705,17 +928,20 @@ static void process_entries(struct merge_options *opt,
 		}
 	}
 
-	/*
-	 * TODO: We can't actually write a tree yet, because dir_metadata just
-	 * contains all basenames of all files throughout the tree with their
-	 * mode and hash.  Not only is that a nonsensical tree, it will have
-	 * lots of duplicates for paths such as "Makefile" or ".gitignore".
-	 */
-	die("Not yet implemented; need to process subtrees separately");
+	if (dir_metadata.offsets.nr != 1 ||
+	    (uintptr_t)dir_metadata.offsets.items[0].util != 0) {
+		printf("dir_metadata.offsets.nr = %d (should be 1)\n",
+		       dir_metadata.offsets.nr);
+		printf("dir_metadata.offsets.items[0].util = %u (should be 0)\n",
+		       (unsigned)(uintptr_t)dir_metadata.offsets.items[0].util);
+		fflush(stdout);
+		BUG("dir_metadata accounting completely off; shouldn't happen");
+	}
 	write_tree(result_oid, &dir_metadata.versions, 0,
 		   opt->repo->hash_algo->rawsz);
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
+	string_list_clear(&dir_metadata.offsets, 0);
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
gitgitgadget

