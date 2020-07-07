Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDDC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D105D20738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tzTIhak5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGOmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:42:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF3C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:42:25 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so31904712qtf.6
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cgn1xZ2ho8wa0lv82iMe+YB9lHF31DpIK/Dy++1hnOU=;
        b=tzTIhak5rdASuKHcQ8NC5TtgiIQYV3KFtnyznIDOmxxqfuRH1r7nds4Ke2peZVGM46
         jOQ/os+m7g3A3rs1VQcGNSIlqotVzkZl5/Uq2k1q+Z9IF/YC/18MwNcJpXe6MOc4uezc
         JvuyuOiBOIt3rfP3qVkrYJKGxg62RtIxWQpxYxMg+42CN0rWtSCQNJ1fo6n2nZplwkiw
         MPmxEoE7gdlnvEf7frovTjUR7wTz3q2BVhjMeVzp4yUXQsL1OqiFYSIPJUZ2v4Bq54CN
         9od1fRp47D5w6ZjiSFyehWaNGxAgysWnQv0gYd+bL3qcvuNiR7pzSYkBWxkH9koD8Mjt
         niHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cgn1xZ2ho8wa0lv82iMe+YB9lHF31DpIK/Dy++1hnOU=;
        b=j1whAeFQAQBRPkGKE4oszRWUOx93rFJxNMLP0rrvbkCD8hxUDhHip34myTcJ2CPc8F
         LhdfWBqB+VY4zKltefuvuEZqcLRptauMc5VZnreYuDnBut8pkM2uz5OJ1N3qCNLhTEZZ
         VJ7fRXi9Jcf+NigaHxzdpeSycTK5pDkUbeWpvaybVKihEzyDUwuBK9cEjIlz9pqz39nG
         3WaSokWCrXJlEPGBwX0nPMTj0vcL+awGoGiGReurOCyBcxQ5PL1RvlQ9tBRe29bUVo3Y
         U4DSKFTpcIRIiDpvEbvHweEz0FUIKMdWNPUudZMcPj+frA5eP2HqZ9DvujGTkkE5MRtQ
         58jA==
X-Gm-Message-State: AOAM5315n9hQQcKrdLhdHftyVYOvzNN4ecaS0UjYvhD86M0ATS2UnwkC
        IFA0CKVggGnXXSdEyGIvmWAUTAEwAbpYQA==
X-Google-Smtp-Source: ABdhPJwtMFmPj0fxKWv9lVvAqprbF20v3gCu0966fEVlpI1FTXsiY/bCZBHHIfjwqkFrYZhnfc1HHw==
X-Received: by 2002:ac8:44d6:: with SMTP id b22mr54669242qto.391.1594132944097;
        Tue, 07 Jul 2020 07:42:24 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cc04:7df5:37b0:651d])
        by smtp.gmail.com with ESMTPSA id t48sm28273354qtb.50.2020.07.07.07.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:42:23 -0700 (PDT)
Date:   Tue, 7 Jul 2020 10:42:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     =dstolee@microsoft.com, =jrnieder@gmail.com, =gitster@pobox.com,
        =jayconrod@google.com, jonathantanmy@google.com
Subject: [PATCH] commit.c: don't persist substituted parents when unshallowing
Message-ID: <82939831ad88f7750b1d024b2031f688ecdf6755.1594132839.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 37b9dcabfc (shallow.c: use '{commit,rollback}_shallow_file',
2020-04-22), Git learned how to reset stat-validity checks for the
'$GIT_DIR/shallow' file, allowing it to change between a shallow and
non-shallow state in the same process (e.g., in the case of 'git fetch
--unshallow').

However, 37b9dcabfc does not alter or remove any grafts nor substituted
parents. This produces a problem when unshallowing if another part of
the code relies on the un-grafted and/or non-substituted parentage for
commits after, say, fetching.

This can arise 'fetch.writeCommitGraph' is true. Ordinarily (and
certainly previous to 37b9dcabfc), 'commit_graph_compatible()' would
return 0, indicating that the repository should not generate
commit-graphs (since at one point in the same process it was shallow).
But with 37b9dcabfc, that check succeeds.

This is where the bug occurs: even though the repository isn't shallow
any longer (that is, we have all of the objects), the in-core
representation of those objects still has munged parents at the shallow
boundaries. If a commit-graph write proceeds, we will use the incorrect
parentage, producing wrong results.

(Prior to this patch, there were two ways of fixing this: either (1)
set 'fetch.writeCommitGraph' to 'false', or (2) drop the commit-graph
after unshallowing).

One way to fix this would be to reset the parsed object pool entirely
(flushing the cache and thus preventing subsequent reads from modifying
their parents) after unshallowing. This can produce a problem when
callers have a now-stale reference to the old pool, and so this patch
implements a different approach. Instead, we attach a new bit to the
pool, 'substituted_parent' which indicates if the repository *ever*
stored a commit which had its parents modified (i.e., the shallow
boundary *before* unshallowing).

This bit is sticky, since all subsequent reads after modifying a
commit's parent are unreliable when unshallowing. This patch modifies
the check in 'commit_graph_compatible' to take this bit into account,
and correctly avoid generating commit-graphs in this case.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Reported-by: Jay Conrod <jayconrod@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
This is a follow-up to Jonathan Nieder's recent message; this patch
fixes the persistent-shallow issue originally reported by Jay Conrod in:

  https://lore.kernel.org/git/20200603034213.GB253041@google.com/

Like Jonathan, I am also late to send this with -rc0 so close around the
corner. I think that this *could* wait until v2.28.1 or v2.29.0 since
fetch.writeCommitGraph is no longer implied by feature.experimental, but
I figure that it is probably better to get this into v2.28.0 since it
fixes the issue once and for all, so long as there is consensus that the
patch is good.

Thanks in advance for a review.

 commit-graph.c           |  3 ++-
 commit.c                 |  2 ++
 object.h                 |  1 +
 t/t5537-fetch-shallow.sh | 14 ++++++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index fdd1c4fa7c..328ab06fd4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -203,7 +203,8 @@ static int commit_graph_compatible(struct repository *r)
 	}

 	prepare_commit_graft(r);
-	if (r->parsed_objects && r->parsed_objects->grafts_nr)
+	if (r->parsed_objects &&
+	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))
 		return 0;
 	if (is_repository_shallow(r))
 		return 0;
diff --git a/commit.c b/commit.c
index 43d29a800d..7128895c3a 100644
--- a/commit.c
+++ b/commit.c
@@ -423,6 +423,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	pptr = &item->parents;

 	graft = lookup_commit_graft(r, &item->object.oid);
+	if (graft)
+		r->parsed_objects->substituted_parent = 1;
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;

diff --git a/object.h b/object.h
index 38dc2d5a6c..96a2105859 100644
--- a/object.h
+++ b/object.h
@@ -25,6 +25,7 @@ struct parsed_object_pool {
 	char *alternate_shallow_file;

 	int commit_graft_prepared;
+	int substituted_parent;

 	struct buffer_slab *buffer_slab;
 };
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index d427a2d7f7..a55202d2d3 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -81,6 +81,20 @@ test_expect_success 'fetch --unshallow from shallow clone' '
 	)
 '

+test_expect_success 'fetch --unshallow from a full clone' '
+	git clone --no-local --depth=2 .git shallow3 &&
+	(
+	cd shallow3 &&
+	git log --format=%s >actual &&
+	test_write_lines 4 3 >expect &&
+	test_cmp expect actual &&
+	git -c fetch.writeCommitGraph fetch --unshallow &&
+	git log origin/master --format=%s >actual &&
+	test_write_lines 4 3 2 1 >expect &&
+	test_cmp expect actual
+	)
+'
+
 test_expect_success 'fetch something upstream has but hidden by clients shallow boundaries' '
 	# the blob "1" is available in .git but hidden by the
 	# shallow2/.git/shallow and it should be resent
--
2.27.0.225.g9fa765a71d
