Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C4C47258
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E48C2137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZCvfggn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgEAPas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgEAPam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7AC08E859
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so11891056wrb.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rCCorV9k0ioosnIBpWXyIlzj+O22ODSVcE6Awzs0zJI=;
        b=WZCvfggnp7CJwF1Exe4FHIaTZUie/BfFuKfwzMYSKE8OpYqz4WjCup6wRTVIxNPWci
         Ejb1IFS4WstqAb9X3/RF662XLLjGGxfc0VPD74TI8Qq0nDj9vCoOQ9PtL1yp3MGcqaii
         mY7jBrXLASvtf99nql1Fi/Z6N7V3bemirdDf4Lq9cMJa+3uJqafzgrzHfOcryGmEfQqJ
         bhLNrb8+EEAZYmqUfh7QJMhyUMmNMto/QdDRyW5K9TFADPFMCYTXEHFkLzoGux6223nw
         7bYTn8qRstmzTCHsTv50T8lpr6JJLVSghjsTjT5lhdcYZxRbRSJFqourvIRXm5lSBCBA
         TkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rCCorV9k0ioosnIBpWXyIlzj+O22ODSVcE6Awzs0zJI=;
        b=tSh/xu/mLlGRehx/oyIc6UQ3mh36QVSEQS5dg362U2qzG/XvQwSs25HICURv5mco9J
         c9mxMK/1gI0y5IpBQ34M5pwe6dV6SgKz3b516J0Rc/jAZ1MsfODWaURKnnuFFMoOSisa
         Q3al0VLBK8pUEYsO6LMmiZOSWf/15PsURrkLpxAwEwS0WMl3MXVPVsOtYQYSrcDfh3Nk
         M/LN4kiipEqw4Ha/djv0a2ZM+MT6NXgEe1WRdmHcy38nnwHOHUrLBYG63sZZHJssKPbP
         eOWRL6n0E8ppvQhEBAsHBE9s7ME8nVJvtu3PvU7mdd9eI5bR25yene/LS2mk7GoJPq8T
         cCaw==
X-Gm-Message-State: AGi0PuYb7Pl6DTo3H2gHUKlc4ab50ywEyMlbCn3YX8haUEdxC1OMcu+Z
        ngIo5FrPa8e2Y9FSJ19DNUxzJimi
X-Google-Smtp-Source: APiQypKkPCINCVLpH5XgeGD5rDEd3z5eFUg9SrNlEF+DwjyDWMSGUYCHsXvRPYklzRBR5ZG0tglavw==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr5016188wrw.207.1588347040371;
        Fri, 01 May 2020 08:30:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 92sm5107891wrm.71.2020.05.01.08.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:39 -0700 (PDT)
Message-Id: <7e0c2871cf73dead655626442cc191d13b7bd94b.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:29 +0000
Subject: [PATCH 12/12] line-log: integrate with changed-path Bloom filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous changes to the line-log machinery focused on making the
first result appear faster. This was achieved by no longer walking the
entire commit history before returning the early results. There is still
another way to improve the performance: walk most commits much faster.
Let's use the changed-path Bloom filters to reduce time spent computing
diffs.

Since the line-log computation requires opening blobs and checking the
content-diff, there is still a lot of necessary computation that cannot
be replaced with changed-path Bloom filters. The part that we can reduce
is most effective when checking the history of a file that is deep in
several directories and those directories are modified frequently. In
this case, the computation to check if a commit is TREESAME to its first
parent takes a large fraction of the time. That is ripe for improvement
with changed-path Bloom filters.

We must ensure that prepare_to_use_bloom_filters() is called in
revision.c so that the bloom_filter_settings are loaded into the struct
rev_info from the commit-graph. Of course, some cases are still
forbidden, but in the line-log case the pathspec is provided in a
different way than normal.

Since multiple paths and segments could be requested, we compute the
struct bloom_key data dynamically during the commit walk. This could
likely be improved, but adds code complexity that is not valuable at
this time.

There are two cases to care about: merge commits and "ordinary" commits.
Merge commits have multiple parents, but if we are TREESAME to our first
parent in every range, then pass the blame for all ranges to the first
parent. Ordinary commits have the same condition, but each is done
slightly differently in the process_ranges_[merge|ordinary]_commit()
methods. By checking if the changed-path Bloom filter can guarantee
TREESAME, we can avoid that tree-diff cost. If the filter says "probably
changed", then we need to run the tree-diff and then the blob-diff if
there was a real edit.

The Linux kernel repository is a good testing ground for the performance
improvements claimed here. There are two different cases to test. The
first is the "entire history" case, where we output the entire history
to /dev/null to see how long it would take to compute the full line-log
history. The second is the "first result" case, where we find how long
it takes to show the first value, which is an indicator of how quickly a
user would see responses when waiting at a terminal.

To test, I selected the paths that were changed most frequently in the
top 10,000 commits using this command (stolen from StackOverflow [1]):

	git log --pretty=format: --name-only -n 10000 | sort | \
		uniq -c | sort -rg | head -10

which results in

    121 MAINTAINERS
     63 fs/namei.c
     60 arch/x86/kvm/cpuid.c
     59 fs/io_uring.c
     58 arch/x86/kvm/vmx/vmx.c
     51 arch/x86/kvm/x86.c
     45 arch/x86/kvm/svm.c
     42 fs/btrfs/disk-io.c
     42 Documentation/scsi/index.rst

(along with a bogus first result). It appears that the path
arch/x86/kvm/svm.c was renamed, so we ignore that entry. This leaves the
following results:

|                              | Entire History  | First Result    |
| Path                         | Before | After  | Before | After  |
|------------------------------|--------|--------|--------|--------|
| MAINTAINERS                  | 4.26 s | 3.87 s | 0.41 s | 0.39 s |
| fs/namei.c                   | 1.99 s | 0.99 s | 0.42 s | 0.21 s |
| arch/x86/kvm/cpuid.c         | 5.28 s | 1.12 s | 0.16 s | 0.09 s |
| fs/io_uring.c                | 4.34 s | 0.99 s | 0.94 s | 0.27 s |
| arch/x86/kvm/vmx/vmx.c       | 5.01 s | 1.34 s | 0.21 s | 0.12 s |
| arch/x86/kvm/x86.c           | 2.24 s | 1.18 s | 0.21 s | 0.14 s |
| fs/btrfs/disk-io.c           | 1.82 s | 1.01 s | 0.06 s | 0.05 s |
| Documentation/scsi/index.rst | 3.30 s | 0.89 s | 1.46 s | 0.03 s |

It is worth noting that the least speedup comes for the MAINTAINERS file
which is

 * edited frequently,
 * low in the directory heirarchy, and
 * quite a large file.

All of those points lead to spending more time doing the blob diff and
less time doing the tree diff. Still, we see some improvement in that
case and significant improvement in other cases. A 2-4x speedup is
likely the more typical case as opposed to the small 5% change for that
file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c    |  5 +++++
 bloom.h    |  1 +
 line-log.c | 39 ++++++++++++++++++++++++++++++++++++++-
 revision.c |  5 ++++-
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/bloom.c b/bloom.c
index 9a8386ac676..e22c0108f39 100644
--- a/bloom.c
+++ b/bloom.c
@@ -138,6 +138,11 @@ void fill_bloom_key(const char *data,
 		key->hashes[i] = hash0 + i * hash1;
 }
 
+void clear_bloom_key(struct bloom_key *key)
+{
+	FREE_AND_NULL(key->hashes);
+}
+
 void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
 		       const struct bloom_filter_settings *settings)
diff --git a/bloom.h b/bloom.h
index a51e3715296..d0c69172e67 100644
--- a/bloom.h
+++ b/bloom.h
@@ -72,6 +72,7 @@ void fill_bloom_key(const char *data,
 		    size_t len,
 		    struct bloom_key *key,
 		    const struct bloom_filter_settings *settings);
+void clear_bloom_key(struct bloom_key *key);
 
 void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
diff --git a/line-log.c b/line-log.c
index 520ee715bcd..7dc411da8f6 100644
--- a/line-log.c
+++ b/line-log.c
@@ -15,6 +15,7 @@
 #include "userdiff.h"
 #include "line-log.h"
 #include "argv-array.h"
+#include "bloom.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
 {
@@ -1146,6 +1147,37 @@ int line_log_print(struct rev_info *rev, struct commit *commit)
 	return 1;
 }
 
+static int bloom_filter_check(struct rev_info *rev,
+			      struct commit *commit,
+			      struct line_log_data *range)
+{
+	struct bloom_filter *filter;
+	struct bloom_key key;
+	int result = 0;
+
+	if (!commit->parents)
+		return 1;
+
+	if (!rev->bloom_filter_settings ||
+	    !(filter = get_bloom_filter(rev->repo, commit, 0)))
+		return 1;
+
+	if (!range)
+		return 0;
+
+	while (!result && range) {
+		fill_bloom_key(range->path, strlen(range->path), &key, rev->bloom_filter_settings);
+
+		if (bloom_filter_contains(filter, &key, rev->bloom_filter_settings))
+			result = 1;
+
+		clear_bloom_key(&key);
+		range = range->next;
+	}
+
+	return result;
+}
+
 static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *commit,
 					  struct line_log_data *range)
 {
@@ -1159,6 +1191,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 
 	queue_diffs(range, &rev->diffopt, &queue, commit, parent);
 	changed = process_all_files(&parent_range, rev, &queue, range);
+
 	if (parent)
 		add_line_range(rev, parent, parent_range);
 	free_line_log_data(parent_range);
@@ -1233,7 +1266,11 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
 	int changed = 0;
 
 	if (range) {
-		if (!commit->parents || !commit->parents->next)
+		if (commit->parents && !bloom_filter_check(rev, commit, range)) {
+			struct line_log_data *prange = line_log_data_copy(range);
+			add_line_range(rev, commit->parents->item, prange);
+			clear_commit_line_range(rev, commit);
+		} else if (!commit->parents || !commit->parents->next)
 			changed = process_ranges_ordinary_commit(rev, commit, range);
 		else
 			changed = process_ranges_merge_commit(rev, commit, range);
diff --git a/revision.c b/revision.c
index 3356ede9a20..cbf4b61aa67 100644
--- a/revision.c
+++ b/revision.c
@@ -689,6 +689,9 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->bloom_filter_settings)
 		return;
 
+	if (!revs->pruning.pathspec.nr)
+		return;
+
 	pi = &revs->pruning.pathspec.items[0];
 	last_index = pi->len - 1;
 
@@ -3501,7 +3504,7 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
-	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info)
+	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
-- 
gitgitgadget
