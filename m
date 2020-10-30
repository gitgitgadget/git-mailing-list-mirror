Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82066C4742C
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2178F20C09
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjPXlaHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgJ3Dmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D3C0613E0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h62so4441929oth.9
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLW3nDz6OxzlWDmz3MiImCCTFf58Op/P3wqn4AqZ5yU=;
        b=EjPXlaHdIoS0Elxw3yJNckxqmB0iX/3jXhA5DGv0bBvdHfjGUREiS9E7zjk4lyGyXT
         slqfOQd8nI1YHsFvHf7Efax5+zoe4GQM87nUHodjQDzGPfD14Lpp/J0tu/nkvwDI+bP2
         txV6e4nQNuEZkO8YlsS3w3CBRNogTbRYVzhkrfHPHRebR/r/eLQyIUbX+03ONcn+wQPY
         nGP5Js5r6l5si8WfBONbedTDXLfBaalim+S9iW1muqXM1blQqzd4dPhdTO1L+MUvsJR/
         Jsp/OT5c1XitwZzD1JW2binWo1U/6wP4rvqwVBwj61k0ehbV53IP+I9mA2ujUuwRCoht
         gkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLW3nDz6OxzlWDmz3MiImCCTFf58Op/P3wqn4AqZ5yU=;
        b=jop7dtrZL4bXUdLr1Do01ZQd2SuZ+OYZoc0p5SDxJ6xWlqOimbNyWjkRPozFHsJSp2
         rilxHG51pViGlcokR89dEGTs4Lfo45W3sWy2BKofNlzZ+VXpnXy4Bz0buWAtvAsLMNUS
         d9UVr0ecepDKjLZ21tvku7p6ufE8m/cVU9cAXyUwELGAP48dh6fGr5IpMFRdwoF7t4KA
         WM36aGeqJ/Dtsox2sY9fV9wNm2khsU6nFN859DY+5Tl3nWJ3MuwkJly8K8vRWnXHOcym
         6n5ufNyEJ9tudNOYBHnD7aocneHv/wHjyzwMi/UxWlIYrtL4FY3TEp2IBtATwrvNDv6X
         BUaA==
X-Gm-Message-State: AOAM531q7k01lFk5yoXzBgzsIdkd9qWy8CBMBjJzHinh4jhCdpZOaY4v
        Ljnerw7wfTe5Z082SVLXsGtxUPn18/3ORQ==
X-Google-Smtp-Source: ABdhPJyRsjaanj2bDoekFYPbjDQB10LaV+m9vRa5OA3blsUhcowH2J9SNV+pD/MGOjsAR5KFrAgYeA==
X-Received: by 2002:a9d:68da:: with SMTP id i26mr203289oto.200.1604029318677;
        Thu, 29 Oct 2020 20:41:58 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:58 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 15/20] merge-ort: step 3 of tree writing -- handling subdirectories as we go
Date:   Thu, 29 Oct 2020 20:41:26 -0700
Message-Id: <20201030034131.1479968-16-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
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
index ad34800705..ac58fa6f04 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -354,6 +354,9 @@ static int string_list_df_name_compare(const char *one, const char *two)
 
 struct directory_versions {
 	struct string_list versions;
+	struct string_list offsets;
+	const char *last_directory;
+	unsigned last_directory_len;
 };
 
 static void write_tree(struct object_id *result_oid,
@@ -410,12 +413,100 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
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
+	 * the entires in info->versions that are under info->last_directory.
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
@@ -529,6 +620,9 @@ static void process_entries(struct merge_options *opt,
 
 	/* other setup */
 	string_list_init(&dir_metadata.versions, 0);
+	string_list_init(&dir_metadata.offsets, 0);
+	dir_metadata.last_directory = NULL;
+	dir_metadata.last_directory_len = 0;
 
 	/*
 	 * Iterate over the items in reverse order, so we can handle paths
@@ -542,22 +636,27 @@ static void process_entries(struct merge_options *opt,
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
2.29.1.56.ga287c268e6.dirty

