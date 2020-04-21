Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93BCC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D70206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vioUgSjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgDUSJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUSJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 14:09:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D03C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:09:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g2so5553250plo.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=h9MNzsbQFM7zJ3eVsHOen6fk0FJs4SBoZ5muf8v21CE=;
        b=vioUgSjSws2C6vthH8v8RDga3HzRUVhQNqvq5OptV0xZRaHRPesCooMYpLJRvpNZMT
         w7wvosj+m/bulZ8jTraOeEOfxztfn2nG4FuEnkZCaG2Kyfrzo/GjNoaOvpQX/Ex32Z/c
         KIvqy2KmqnQSgUkMqBSlegIHFFt3D2Tlqhr/jAaQ5Bz2KzJWl1WP6I2JXCvqoD25ouj3
         1cY/pXAZRWP1FumHsiPkAlwVpn0TmF1gKeUuU6QqjvwzY81g/mNuXCDV8LCyOrREN3kD
         NM3NvTCixihdgz6uA5K69g6CrfrLeMdreXPtxv+aWhrIhoc/A34GsZH5zrEWGRCDaadW
         rO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=h9MNzsbQFM7zJ3eVsHOen6fk0FJs4SBoZ5muf8v21CE=;
        b=PXweAt5uAMUyByQpErJD/RQN7OqmG8sdfHGMmdltQzAilJxSVLBdYsX7tzeya4d785
         QZj8niQeCcbc1GlPUow+9pHJIAgEMw4atG6gGy3vnranJWT+KhIoita/D23sWir1eJWm
         aFm5TIwR5wqzWFnt8rAu/ZvSCg4mXfu+q/yYxas4HWGyJlFQ/2Zl+b5rUd3p3votk7gu
         FbvGxajMRRkL/Z4ZqYWi0plBNNm+Ooz1BxvW63inH8xhZpxg/Y4sR+yH5K/phI4i5qLq
         UoFnsoj7wEcC7UC4MN27PcSZyTM+dFVxSuIKr6j1v65ZhqAeR1gjWd34xRiQYNDIjj78
         Mnfw==
X-Gm-Message-State: AGi0PuZ2tCecPqa6Pbgk+BCk6IgrYmgV3LasAj/8xfVm28K7H9/kkSHc
        zT/2PzqG5vH1Ymz+HWlKkcI11wZKBhMBqw==
X-Google-Smtp-Source: APiQypKUGoFotyHm6gbXQbpY1hz9U6Kdcww08URsKRiuxPm30T7m/VjFzpQMW/75AoE49cb0TjZeDQ==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr4254130plb.71.1587492561228;
        Tue, 21 Apr 2020 11:09:21 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d8sm3090646pfd.159.2020.04.21.11.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 11:09:20 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:09:18 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
Message-ID: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
2019-01-10), the author noted that 'is_repository_shallow' produces
visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.

This is a problem for e.g., fetching with '--update-shallow' in a
shallow repsoitory with 'fetch.writeCommitGraph' enabled, since the
update to '.git/shallow' will cause Git to think that the repository
isn't shallow when it is, thereby circumventing the commit-graph
compatability check.

This causes problems in shallow repositories with at least shallow refs
that have at least one ancestor (since the client won't have those
objects, and therefore can't take the reachability closure over commits
when writing a commit-graph).

Address this by introducing 'reset_repository_shallow()', and calling
it whenever the shallow files is updated. This happens in two cases:

  * during 'update_shallow', when either the repository is
    un-shallowing, or after commit_lock_file, when the contents of
    .git/shallow is changing, and

  * in 'prune_shallow', when the repository can go from shallow to
    un-shallow when the shallow file is updated, forcing
    'is_repository_shallow' to re-evaluate whether the repository is
    still shallow after fetching in the above scenario.

As a result of the second change, 'prune_shallow' can now only be called
once (since 'check_shallow_file_for_update' will die after calling
'reset_repository_shallow'). But, this is OK since we only call
'prune_shallow' at most once per process.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---

Here's a cleaned up version of the patch that we were originally
discussing in
https://lore.kernel.org/git/20200414235057.GA6863@syl.local/, which
addresses some of Jonathan's feedback and adds a test to make sure that
the new behavior is working correctly.

 commit.h                 |  1 +
 fetch-pack.c             |  1 +
 shallow.c                | 15 ++++++++-------
 t/t5537-fetch-shallow.sh | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/commit.h b/commit.h
index 008a0fa4a0..ee1ba139d4 100644
--- a/commit.h
+++ b/commit.h
@@ -251,6 +251,7 @@ int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int for_each_commit_graft(each_commit_graft_fn, void *);
 int is_repository_shallow(struct repository *r);
+void reset_repository_shallow(struct repository *r);
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
 struct commit_list *get_shallow_commits_by_rev_list(
diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..684868bc17 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1632,6 +1632,7 @@ static void update_shallow(struct fetch_pack_args *args,
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
+		reset_repository_shallow(the_repository);
 		alternate_shallow_file = NULL;
 		return;
 	}
diff --git a/shallow.c b/shallow.c
index 7fd04afed1..9d1304e786 100644
--- a/shallow.c
+++ b/shallow.c
@@ -40,13 +40,6 @@ int register_shallow(struct repository *r, const struct object_id *oid)

 int is_repository_shallow(struct repository *r)
 {
-	/*
-	 * NEEDSWORK: This function updates
-	 * r->parsed_objects->{is_shallow,shallow_stat} as a side effect but
-	 * there is no corresponding function to clear them when the shallow
-	 * file is updated.
-	 */
-
 	FILE *fp;
 	char buf[1024];
 	const char *path = r->parsed_objects->alternate_shallow_file;
@@ -79,6 +72,12 @@ int is_repository_shallow(struct repository *r)
 	return r->parsed_objects->is_shallow;
 }

+void reset_repository_shallow(struct repository *r)
+{
+	r->parsed_objects->is_shallow = -1;
+	stat_validity_clear(r->parsed_objects->shallow_stat);
+}
+
 /*
  * TODO: use "int" elemtype instead of "int *" when/if commit-slab
  * supports a "valid" flag.
@@ -362,6 +361,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 		 * shallow file".
 		 */
 		*alternate_shallow_file = "";
+	reset_repository_shallow(the_repository);
 	strbuf_release(&sb);
 }

@@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
 	} else {
 		unlink(git_path_shallow(the_repository));
 		rollback_lock_file(&shallow_lock);
+		reset_repository_shallow(the_repository);
 	}
 	strbuf_release(&sb);
 }
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 4f681dbbe1..c9c731c7a9 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -177,6 +177,42 @@ EOF
 	)
 '

+test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
+	(
+	cd shallow &&
+	git checkout master &&
+	commit 8 &&
+	git tag -m foo heavy-tag-for-graph HEAD^ &&
+	git tag light-tag-for-graph HEAD^:tracked
+	) &&
+	(
+	cd notshallow &&
+	test_config fetch.writeCommitGraph true &&
+	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
+	git fsck &&
+	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
+	cat <<EOF >expect.refs &&
+refs/remotes/shallow/master
+refs/remotes/shallow/no-shallow
+refs/tags/heavy-tag
+refs/tags/heavy-tag-for-graph
+refs/tags/light-tag
+refs/tags/light-tag-for-graph
+EOF
+	test_cmp expect.refs actual.refs &&
+	git log --format=%s shallow/master >actual &&
+	cat <<EOF >expect &&
+8
+7
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
 test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	cp -R .git read-only.git &&
 	test_when_finished "find read-only.git -type d -print | xargs chmod +w" &&
--
2.26.2.108.g048abe1751
