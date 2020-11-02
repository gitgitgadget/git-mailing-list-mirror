Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37756C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D1222226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2qUlyQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgKBUoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgKBUoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:11 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56AEC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:10 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id t143so4466705oif.10
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P26CaB+rlL/P8c0N/tACqXuNUFzNe7fXIG2qiTPrY7w=;
        b=f2qUlyQ3FSOGGghRvSw+Y1I4fRz76ZR04LbxPzyoDT2fO1jD0a8SyEef0hdcIWtFWc
         x6c/Xj5F+PG9wlKxD9I04ECZ5rJxGimpmhLe6/ej+7a2Uc4CefbokhM/39/wviQ+XV/5
         smi9tyYbXmLd+7SwgxUSxqSij/D8VlrgcOo9Y/aOMqVUpukqzJqcnHO37jAOxHjsmKp2
         ScUIB4PSLyLtebzEd1fkd+F+IrGwVICMDZvDvzWbm2iQ43C6ntuV+aJULvnYBZ6lpFUS
         ns8Rb/3B/c8KNlzbU7DLIMBFVGyBfNPR8EJo8E8lqTF2ifZ0kogiRSmzTI4tvoVU02IL
         AQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P26CaB+rlL/P8c0N/tACqXuNUFzNe7fXIG2qiTPrY7w=;
        b=Vz/qpuGwKTufSzNfXKfkQcLVgC/1XBMSjFDdLoRMlW/zEmxadTRSj4rni3P26Mc/GM
         PitUaGR/72OLhFawtK0ttkmaVZ2c2ux5kv8bnqbzKRfe0SUipt2E8tk2fG+3jgOjW5Tq
         pQmYGVMm1FIb/ax8uM3qy3YNZtHWT9pW+D+ofJLvxM0o8PfUo4Bls2QPNFTADXBDn9qV
         Kvk581gBOvA5i1TypHWin5tJyK4o8VX3Zz418ApKj5/Td8ZCVxAcm4qrTVnFirFtQ9TB
         x3fLRnq5vnv07rsxYDfeRYuJi7xKYWxWfV3ZeOj9rp7/iP0Y1lxFJlJoi0DBSN41H9yf
         EGvg==
X-Gm-Message-State: AOAM530piB0Qiqi7ihjgwJylUQHxVSpbVp1//qZGBXZw7LGiiIJd086a
        BKyJLDeb9asksUc6ax+umiRVyWoDZUESfQ==
X-Google-Smtp-Source: ABdhPJwSleS747w7CwtnKmLydmAvw/NFWNiF9Q4m0GvF1jgzUrX1yHDYmnQUKFFd7Dwx1XtR6FeGAw==
X-Received: by 2002:a05:6808:8cc:: with SMTP id k12mr11525776oij.179.1604349849888;
        Mon, 02 Nov 2020 12:44:09 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 15/20] merge-ort: step 3 of tree writing -- handling subdirectories as we go
Date:   Mon,  2 Nov 2020 12:43:39 -0800
Message-Id: <20201102204344.342633-16-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 merge-ort.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c560dd1634..20b7c0d8b0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -353,6 +353,9 @@ static int string_list_df_name_compare(const char *one, const char *two)
 
 struct directory_versions {
 	struct string_list versions;
+	struct string_list offsets;
+	const char *last_directory;
+	unsigned last_directory_len;
 };
 
 static void write_tree(struct object_id *result_oid,
@@ -409,12 +412,100 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
 		/* nothing to record */
 		return;
 
+	/*
+	 * Note: write_completed_directories() already added
+	 * entries for directories to dir_metadata->versions,
+	 * so no need to handle ci->filemask == 0 again.
+	 */
+	if (!ci->merged.clean && !ci->filemask)
+		return;
+
 	basename = path + ci->merged.basename_offset;
 	assert(strchr(basename, '/') == NULL);
 	string_list_append(&dir_metadata->versions,
 			   basename)->util = &ci->merged.result;
 }
 
+static void write_completed_directories(struct merge_options *opt,
+					const char *new_directory_name,
+					struct directory_versions *info)
+{
+	const char *prev_dir;
+	struct merged_info *dir_info = NULL;
+	unsigned int offset;
+	int wrote_a_new_tree = 0;
+
+	if (new_directory_name == info->last_directory)
+		return;
+
+	/*
+	 * If we are just starting (last_directory is NULL), or last_directory
+	 * is a prefix of the current directory, then we can just update
+	 * last_directory and record the offset where we started this directory.
+	 */
+	if (info->last_directory == NULL ||
+	    !strncmp(new_directory_name, info->last_directory,
+		     info->last_directory_len)) {
+		uintptr_t offset = info->versions.nr;
+
+		info->last_directory = new_directory_name;
+		info->last_directory_len = strlen(info->last_directory);
+		string_list_append(&info->offsets,
+				   info->last_directory)->util = (void*)offset;
+		return;
+	}
+
+	/*
+	 * At this point, ne (next entry) is within a different directory
+	 * than the last entry, so we need to create a tree object for all
+	 * the entries in info->versions that are under info->last_directory.
+	 */
+	dir_info = strmap_get(&opt->priv->paths, info->last_directory);
+	assert(dir_info);
+	offset = (uintptr_t)info->offsets.items[info->offsets.nr-1].util;
+	if (offset == info->versions.nr) {
+		dir_info->is_null = 1;
+	} else {
+		dir_info->result.mode = S_IFDIR;
+		write_tree(&dir_info->result.oid, &info->versions, offset);
+		wrote_a_new_tree = 1;
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
+	 * Now we've got an OID for last_directory in dir_info.  We need to
+	 * add it to info->versions for it to be part of the computation of
+	 * its parent directories' OID.  But first, we have to find out what
+	 * its' parent name was and whether that matches the previous
+	 * info->offsets or we need to set up a new one.
+	 */
+	prev_dir = info->offsets.nr == 0 ? NULL :
+		   info->offsets.items[info->offsets.nr-1].string;
+	if (new_directory_name != prev_dir) {
+		uintptr_t c = info->versions.nr;
+		string_list_append(&info->offsets,
+				   new_directory_name)->util = (void*)c;
+	}
+
+	/*
+	 * Okay, finally record OID for last_directory in info->versions,
+	 * and update last_directory.
+	 */
+	if (wrote_a_new_tree) {
+		const char *dir_name = strrchr(info->last_directory, '/');
+		dir_name = dir_name ? dir_name+1 : info->last_directory;
+		string_list_append(&info->versions, dir_name)->util = dir_info;
+	}
+	info->last_directory = new_directory_name;
+	info->last_directory_len = strlen(info->last_directory);
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -528,6 +619,9 @@ static void process_entries(struct merge_options *opt,
 
 	/* other setup */
 	string_list_init(&dir_metadata.versions, 0);
+	string_list_init(&dir_metadata.offsets, 0);
+	dir_metadata.last_directory = NULL;
+	dir_metadata.last_directory_len = 0;
 
 	/*
 	 * Iterate over the items in reverse order, so we can handle paths
@@ -541,22 +635,27 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct conflict_info *ci = entry->util;
 
+		write_completed_directories(opt, ci->merged.directory_name,
+					    &dir_metadata);
 		if (ci->merged.clean)
 			record_entry_for_tree(&dir_metadata, path, ci);
 		else
 			process_entry(opt, path, ci, &dir_metadata);
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
 	write_tree(result_oid, &dir_metadata.versions, 0);
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
+	string_list_clear(&dir_metadata.offsets, 0);
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
2.29.0.471.ga4f56089c0

