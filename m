Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA2C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B65A206E9
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bozdHNAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGHVK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 17:10:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE827C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 14:10:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so39419qth.12
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GRMS4HrhNkEsr9WdKXOCMcxfufGlK5UcAKXtj2o7NIY=;
        b=bozdHNAh6lh30TwyzNoomKuDjy/Y477J4JIjvq1JUDknSKEvotWEeOlkQfP9LrY9SW
         1pevXb2lcbVJNAZqTApP3I8G9g37u/LTRiNrrORrJJZ+gzbt7Vxnv017cm5uQPTcsYk2
         E7X2UOEvDYPRQHekemF7Sss6m9OBxMU4W/GqCnVpyi7YUP/SZ4kJsMhGZ0MZqhd+/zaJ
         QSwdVsr6AuTfJsxal+ZciobXNSV3qQm4qe8n3u9w/uXfHCKRHZmqnOAZybzlRwjDTLWU
         7DkmWk2igeNszPwvV9VLsOywzv5Q3uzTkpR0Mto9G3WfeyJHv0pG8e8uyQv7XasuZCy1
         l9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GRMS4HrhNkEsr9WdKXOCMcxfufGlK5UcAKXtj2o7NIY=;
        b=iCR8VTH3Qilh3w0w0sTxp4TwiMqsw7da0MuvheqNujCMBnIOStyA8yBYFnmuSdfbyr
         P2AHJmXN8PGPidn42Wr8+PgVcc+TPcJqVlXW2M9huP/BktuBheHLfucIRvyjY5K78/e6
         6Jk+h344qez/KAmDYm9Du6yG0Uo4yT5iXMKpX2kvKf09tep/eUmS0LFd5AOS+dwS7DnK
         UdrS/8lR47AkZ2svZ8APIzMzQPkdcPDU5kRMee/S+ko4yKl0vRMfjQIokmlzBz6WiztW
         V3yjX8YOM5GMZDz1YpXYTjzu86Zo18MB2upCNuGYXZTbHI749AzJai6b+vTEErmvoDDQ
         8/iQ==
X-Gm-Message-State: AOAM530myBJ1DdwjE16CxkdKWcsw2GkmlpA70MiMXYEPZvUlBldC6Lb+
        CcpYs85wMaJqrbc6VWYfbfXYCP7ofEvmMw==
X-Google-Smtp-Source: ABdhPJxs0QxUot8pRmmvronsVmvMqgIZRRgXnkA8+r9v6qkrASS+H30ZGv0Y9o3AfdSqEuegEZHz9A==
X-Received: by 2002:ac8:4b63:: with SMTP id g3mr61554637qts.229.1594242655884;
        Wed, 08 Jul 2020 14:10:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:6410:18ef:f702:66bb])
        by smtp.gmail.com with ESMTPSA id s52sm1047439qtj.52.2020.07.08.14.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:10:55 -0700 (PDT)
Date:   Wed, 8 Jul 2020 17:10:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, jrnieder@gmail.com, gitster@pobox.com,
        jayconrod@google.com, jonathantanmy@google.com
Subject: [PATCH v2] commit.c: don't persist substituted parents when
 unshallowing
Message-ID: <1f769bbbb4f1b4ad67d29ee7b3e5282446e4cc0f.1594242582.git.me@ttaylorr.com>
References: <20200707144338.GA26342@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707144338.GA26342@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 37b9dcabfc (shallow.c: use '{commit,rollback}_shallow_file',
2020-04-22), Git knows how to reset stat-validity checks for the
$GIT_DIR/shallow file, allowing it to change between a shallow and
non-shallow state in the same process (e.g., in the case of 'git fetch
--unshallow').

However, when $GIT_DIR/shallow changes, Git does not alter or remove any
grafts (nor substituted parents) in memory.

This comes up in a "git fetch --unshallow" with fetch.writeCommitGraph
set to true. Ordinarily in a shallow repository (and before 37b9dcabfc,
even in this case), commit_graph_compatible() would return false,
indicating that the repository should not be used to write a
commit-graphs (since commit-graph files cannot represent a shallow
history). But since 37b9dcabfc, in an --unshallow operation that check
succeeds.

Thus even though the repository isn't shallow any longer (that is, we
have all of the objects), the in-core representation of those objects
still has munged parents at the shallow boundaries.  When the
commit-graph write proceeds, we use the incorrect parentage, producing
wrong results.

There are two ways for a user to work around this: either (1) set
'fetch.writeCommitGraph' to 'false', or (2) drop the commit-graph after
unshallowing.

One way to fix this would be to reset the parsed object pool entirely
(flushing the cache and thus preventing subsequent reads from modifying
their parents) after unshallowing. That would produce a problem when
callers have a now-stale reference to the old pool, and so this patch
implements a different approach. Instead, attach a new bit to the pool,
'substituted_parent', which indicates if the repository *ever* stored a
commit which had its parents modified (i.e., the shallow boundary
prior to unshallowing).

This bit needs to be sticky because all reads subsequent to modifying a
commit's parents are unreliable when unshallowing. Modify the check in
'commit_graph_compatible' to take this bit into account, and correctly
avoid generating commit-graphs in this case, thus solving the bug.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Reported-by: Jay Conrod <jayconrod@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
The patch contents are unchanged from v1, but the patch's message is
wordsmithed with jrn's help. This should be ready for -rc0 now.

Range-diff below for easier review:

Range-diff against v1:
1:  82939831ad ! 1:  1f769bbbb4 commit.c: don't persist substituted parents when unshallowing
    @@ Metadata
      ## Commit message ##
         commit.c: don't persist substituted parents when unshallowing

    -    In 37b9dcabfc (shallow.c: use '{commit,rollback}_shallow_file',
    -    2020-04-22), Git learned how to reset stat-validity checks for the
    -    '$GIT_DIR/shallow' file, allowing it to change between a shallow and
    +    Since 37b9dcabfc (shallow.c: use '{commit,rollback}_shallow_file',
    +    2020-04-22), Git knows how to reset stat-validity checks for the
    +    $GIT_DIR/shallow file, allowing it to change between a shallow and
         non-shallow state in the same process (e.g., in the case of 'git fetch
         --unshallow').

    -    However, 37b9dcabfc does not alter or remove any grafts nor substituted
    -    parents. This produces a problem when unshallowing if another part of
    -    the code relies on the un-grafted and/or non-substituted parentage for
    -    commits after, say, fetching.
    +    However, when $GIT_DIR/shallow changes, Git does not alter or remove any
    +    grafts (nor substituted parents) in memory.

    -    This can arise 'fetch.writeCommitGraph' is true. Ordinarily (and
    -    certainly previous to 37b9dcabfc), 'commit_graph_compatible()' would
    -    return 0, indicating that the repository should not generate
    -    commit-graphs (since at one point in the same process it was shallow).
    -    But with 37b9dcabfc, that check succeeds.
    +    This comes up in a "git fetch --unshallow" with fetch.writeCommitGraph
    +    set to true. Ordinarily in a shallow repository (and before 37b9dcabfc,
    +    even in this case), commit_graph_compatible() would return false,
    +    indicating that the repository should not be used to write a
    +    commit-graphs (since commit-graph files cannot represent a shallow
    +    history). But since 37b9dcabfc, in an --unshallow operation that check
    +    succeeds.

    -    This is where the bug occurs: even though the repository isn't shallow
    -    any longer (that is, we have all of the objects), the in-core
    -    representation of those objects still has munged parents at the shallow
    -    boundaries. If a commit-graph write proceeds, we will use the incorrect
    -    parentage, producing wrong results.
    +    Thus even though the repository isn't shallow any longer (that is, we
    +    have all of the objects), the in-core representation of those objects
    +    still has munged parents at the shallow boundaries.  When the
    +    commit-graph write proceeds, we use the incorrect parentage, producing
    +    wrong results.

    -    (Prior to this patch, there were two ways of fixing this: either (1)
    -    set 'fetch.writeCommitGraph' to 'false', or (2) drop the commit-graph
    -    after unshallowing).
    +    There are two ways for a user to work around this: either (1) set
    +    'fetch.writeCommitGraph' to 'false', or (2) drop the commit-graph after
    +    unshallowing.

         One way to fix this would be to reset the parsed object pool entirely
         (flushing the cache and thus preventing subsequent reads from modifying
    -    their parents) after unshallowing. This can produce a problem when
    +    their parents) after unshallowing. That would produce a problem when
         callers have a now-stale reference to the old pool, and so this patch
    -    implements a different approach. Instead, we attach a new bit to the
    -    pool, 'substituted_parent' which indicates if the repository *ever*
    -    stored a commit which had its parents modified (i.e., the shallow
    -    boundary *before* unshallowing).
    +    implements a different approach. Instead, attach a new bit to the pool,
    +    'substituted_parent', which indicates if the repository *ever* stored a
    +    commit which had its parents modified (i.e., the shallow boundary
    +    prior to unshallowing).

    -    This bit is sticky, since all subsequent reads after modifying a
    -    commit's parent are unreliable when unshallowing. This patch modifies
    -    the check in 'commit_graph_compatible' to take this bit into account,
    -    and correctly avoid generating commit-graphs in this case.
    +    This bit needs to be sticky because all reads subsequent to modifying a
    +    commit's parents are unreliable when unshallowing. Modify the check in
    +    'commit_graph_compatible' to take this bit into account, and correctly
    +    avoid generating commit-graphs in this case, thus solving the bug.

         Helped-by: Derrick Stolee <dstolee@microsoft.com>
         Helped-by: Jonathan Nieder <jrnieder@gmail.com>
         Reported-by: Jay Conrod <jayconrod@google.com>
    +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## commit-graph.c ##

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
