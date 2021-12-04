Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30613C433FE
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384120AbhLDC7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384109AbhLDC7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 21:59:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2783C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 18:55:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q3so9635086wru.5
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RCAwdo7xN8gcjveEiLdl9mi6DH/LDVC/khrn2BpYtwk=;
        b=XFCFSUcRnUVQufR5MqPahK5+wt6IeUI1+hV7xwrjflHEbH+G2JGPsTX0v91CiYQ2Ku
         Uu0bbWPGkYFqoGf5XtjkQYjK3SvjQWQMCTRIFOESugqPNsMyzqmXx9OXCEyUgPAh2lgK
         CPP3BsDQ4V+Dw7nNpeEHquVR4+Ojw3m3czabinmlEU9sSTiSXVi2Mh/HZ4+YBJDQHnRS
         MPs4X6YakzH2bJmoVsVca0fGxjfVwlKj0F8smcJFbm3V+jqYnYwBQgbco718lysDQQ+n
         yv1vkVp2C7Le3m7cwd/6BeA/Rb5p38Wpq6fiRpmAKr/iwlHS8A3G7mcQ81f4dUTr67uC
         P2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RCAwdo7xN8gcjveEiLdl9mi6DH/LDVC/khrn2BpYtwk=;
        b=a/SnwWzEbq+udNVO60KsBb2LQ5mvChnJ/7+Hf6vGQHTiJ4qpUDOb6Wsmeq3aYTu3KO
         Zqs6WFvK91GJFQ9tgEXRtGhNJ9O24k6ZWdKt2HgNp4IUzLK9h8DhRY6KLz2+Uxz3oSKs
         C+Z/J0AseePC5lnZB0z8XC7wMU+oCiuc5ITCoMAoFO5bnB3peSae0a46uLI2jOHhRUxx
         u/Ln9ptAjSgscts/wobGNzSQIXjTYyNr0FdrEiX/AkySvwNhM4JOv5pShR7yxbskAZFP
         THvYf/Z58RjXVOEcO5s960oRq6qQyl9D5YY2BFhpB1r3c3kLtTe62RIM8j2z4bNp/Muy
         x8rw==
X-Gm-Message-State: AOAM532BlafjdiqY0sGZvVYRS/9NZwgWHHlp7eFIEDl+3o7xsxMUOngq
        33UIbsE3RzP5CWlCccDplarFL4RSpHQ=
X-Google-Smtp-Source: ABdhPJxu/WJwaBpH1PZAvdI33RX194p0vgm8zEoH6YaSdSQL7DdtGrRi20952AVfuUOuWT2xxfy/9w==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr26702244wrr.522.1638586537303;
        Fri, 03 Dec 2021 18:55:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm4217785wro.12.2021.12.03.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:55:36 -0800 (PST)
Message-Id: <c91421996562ecedab18f8af4ed8a02896584540.1638586534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 02:55:34 +0000
Subject: [PATCH 2/2] unpack-trees: use traverse_path instead of name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, vdye@github.com, gitster@pobox.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse_dir_matches_path() method compares a cache entry that is a
sparse directory entry against a 'struct traverse_info *info' and a
'struct name_entry *p' to see if the cache entry has exactly the right
name for those other inputs.

This method was introduced in 523506d (unpack-trees: unpack sparse
directory entries, 2021-07-14), but included a significant mistake. The
path comparisons used 'info->name' instead of 'info->traverse_path'.
Since 'info->name' only stores a single tree entry name while
'info->traverse_path' stores the full path from root, this method does
not work when 'info' is in a subdirectory of a directory. Replacing the
right strings and their corresponding lengths make the method work
properly.

The previous change included a failing test that exposes this issue.
That test now passes. The critical detail is that as we go deep into
unpack_trees(), the logic for merging a sparse directory entry with a
tree entry during 'git checkout' relies on this
sparse_dir_matches_path() in order to avoid calling
traverse_trees_recursive() during unpack_callback() in this hunk:

	if (!is_sparse_directory_entry(src[0], names, info) &&
	    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
					    names, info) < 0) {
		return -1;
	}

For deep paths, the short-circuit never occurred and
traverse_trees_recursive() was being called incorrectly and that was
causing other strange issues. Specifically, the error message from the
now-passing test previously included this:

      error: Your local changes to the following files would be overwritten by checkout:
              deep/deeper1/deepest2/a
              deep/deeper1/deepest3/a
      Please commit your changes or stash them before you switch branches.
      Aborting

These messages occurred because the 'current' cache entry in
twoway_merge() was showing as NULL because the index did not contain
entries for the paths contained within the sparse directory entries. We
instead had 'oldtree' given as the entry at HEAD and 'newtree' as the
entry in the target tree. This led to reject_merge() listing these
paths.

Now that sparse_dir_matches_path() works the same for deep paths as it
does for shallow depths, the rest of the logic kicks in to properly
handle modifying the sparse directory entries as designed.

Reported-by: Gustave Granroth <gus.gran@gmail.com>
Reported-by: Mike Marcelais <michmarc@exchange.microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 unpack-trees.c                           | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e6aef40e9b3..f04a02c6b20 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -307,7 +307,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
-test_expect_failure 'deep changes during checkout' '
+test_expect_success 'deep changes during checkout' '
 	init_repos &&
 
 	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 89ca95ce90b..7381c275768 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1243,11 +1243,11 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
 	assert(S_ISSPARSEDIR(ce->ce_mode));
 	assert(ce->name[ce->ce_namelen - 1] == '/');
 
-	if (info->namelen)
-		return ce->ce_namelen == info->namelen + p->pathlen + 2 &&
-		       ce->name[info->namelen] == '/' &&
-		       !strncmp(ce->name, info->name, info->namelen) &&
-		       !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen);
+	if (info->pathlen)
+		return ce->ce_namelen == info->pathlen + p->pathlen + 1 &&
+		       ce->name[info->pathlen - 1] == '/' &&
+		       !strncmp(ce->name, info->traverse_path, info->pathlen) &&
+		       !strncmp(ce->name + info->pathlen, p->path, p->pathlen);
 	return ce->ce_namelen == p->pathlen + 1 &&
 	       !strncmp(ce->name, p->path, p->pathlen);
 }
-- 
gitgitgadget
