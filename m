Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D26C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78A20726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnwr+W/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIOxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:53:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33820 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIOxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:53:54 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so2737856qvf.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SGVSEWR+/hN4jf6vhKFRgdo2rIjGFuwc8rZC+2zPSyg=;
        b=Bnwr+W/chpFNuqPureGq+EfpG6j6b761UMIsk/3ZbS/bIloulq7G8nGZRwKAAQ3ve6
         DjD4ct8F6cvrxb3GIZhV+Cuf4cp0MdTCZF8SImOWvjem4Iy3BDLKJG7DPmVpfTwfnVGN
         8REt9QRctSSU6K1qwDNUiHJq1sB1jyckFG//F58r2ujPaqY2OsEvLIH0PYcL9wX0a0ES
         O+iGKZSaR4GvGqTXXozUemgZRTBqhIjqTuqcEED8eYsLq2dTrZiLROu1EsFPln1hGB3P
         nDU+D9LfEmjeVEp57VM7hZkAH7L5zYSwHk8ATb/46DPbH2Ufwjuf0zeCt+WANC/VNZPK
         Ujkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SGVSEWR+/hN4jf6vhKFRgdo2rIjGFuwc8rZC+2zPSyg=;
        b=KJ13EdC62IeFLwS44YT+eyvv9sEHwBuufnvP+m0B1BtZkBVy4Rz73THXD8LDFUZjFA
         +w/TsDIeTNZB1rSc3T3x4K1zRhaMBZUjAESZmZK5lSmDVMduhDCyVN8iJL25/vAiYCa9
         H6ePfW+qG+jZKdQGHNlgJo5hcjttDidTtskhaFs61VK7lwSx7Ha49e6Fj3su09V1GKA6
         +eWC38InIUi2TqxXK15N9qie28onbRM8SM7V38nUbvb5iK/0uN97UmbhTZckUOO8e3PL
         mh9y97XU4hGYKidlfaI4ZJVnX54FAjsENqS0d5ary7fvT6ioa8eBSrplwEDVmFHz+WSD
         5qxQ==
X-Gm-Message-State: APjAAAW8axYWIj0otAiGnCaadlyQGl1E9DT8bMcbiS1f+6CIg3v1FEWq
        6cnbW1fY+ycavRrXxvWeNCK8QVidw2U=
X-Google-Smtp-Source: APXvYqw4fB9sGFYpKI0HUb+A2hAjRjQWrGuY8JpCxdZsatBPbj41MCXf31lsdEn5/uifOM1Q/DHmng==
X-Received: by 2002:a0c:d6c8:: with SMTP id l8mr24462700qvi.44.1575903232845;
        Mon, 09 Dec 2019 06:53:52 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.253])
        by smtp.googlemail.com with ESMTPSA id 16sm2367855qkj.77.2019.12.09.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:53:51 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH v3 1/1] rebase: fix --fork-point with short refname
Date:   Mon,  9 Dec 2019 09:53:12 -0500
Message-Id: <20191209145312.3251-2-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209145312.3251-1-alext9@gmail.com>
References: <20191205235704.31385-1-alext9@gmail.com>
 <20191209145312.3251-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were directly passing in the user-provided upstream_name into
get_fork_point(), but get_fork_point() was expecting a fully qualified
ref name. This resulted in `--fork-point` not working as expected.
Without the full ref name, get_fork_point could not find the fork point,
and rebase behaved as if no `--fork-point` flag was passed in.

Pull logic for getting the full dwim ref name out of merge-base.c
handle_fork_point into get_fork_point. This allows both of the locations
that call get_fork_point to not need to handle doing the dwim ref lookup
before trying to get the fork point.

Duplicate all of the rebase tests with a short refname to ensure that
they work with short and long refnames.

Signed-off-by: Alex Torok <alext9@gmail.com>
---

One thing that I'm not super sure about is the error messaging that gets
printed when a short refname is given to rebase. In the ambigous refname
test that I added, the command output is:

warning: refname 'one' is ambiguous.
error: ambiguous refname: 'one'
fatal: could not get fork point

Which seems a bit odd ot have a warning, error, fatal stacked on top of
each other. From a user-facing perspective it feels a bit odd to me, but
I'm not sure what the general rules for error messaging are in git.


 builtin/merge-base.c         | 14 +++-----------
 builtin/rebase.c             |  5 +++--
 commit.c                     | 19 +++++++++++++------
 commit.h                     |  2 +-
 refs.c                       | 14 ++++++++++++++
 refs.h                       |  2 ++
 t/t3431-rebase-fork-point.sh | 20 ++++++++++++++++++++
 7 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b6..ecc4268d43 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -114,26 +114,18 @@ static int handle_is_ancestor(int argc, const char **argv)
 static int handle_fork_point(int argc, const char **argv)
 {
 	struct object_id oid;
-	char *refname;
 	struct commit *derived, *fork_point;
 	const char *commitname;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
-	case 0:
-		die("No such ref: '%s'", argv[0]);
-	case 1:
-		break; /* good */
-	default:
-		die("Ambiguous refname: '%s'", argv[0]);
-	}
-
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
 
-	fork_point = get_fork_point(refname, derived);
+	fork_point = NULL;
+	if (get_fork_point(argv[0], derived, &fork_point) < 0)
+		return 1;
 
 	if (!fork_point)
 		return 1;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e755087b0f..782cf5a890 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1980,8 +1980,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct commit *head =
 			lookup_commit_reference(the_repository,
 						&options.orig_head);
-		options.restrict_revision =
-			get_fork_point(options.upstream_name, head);
+		options.restrict_revision = NULL;
+		if (get_fork_point(options.upstream_name, head, &options.restrict_revision) < 0)
+			die(_("could not get fork point"));
 	}
 
 	if (repo_read_index(the_repository) < 0)
diff --git a/commit.c b/commit.c
index 434ec030d6..874bc0cdf1 100644
--- a/commit.c
+++ b/commit.c
@@ -920,19 +920,25 @@ static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid
 	return 0;
 }
 
-struct commit *get_fork_point(const char *refname, struct commit *commit)
+int get_fork_point(const char *refname, struct commit *commit, struct commit **fork_point)
 {
 	struct object_id oid;
 	struct rev_collect revs;
 	struct commit_list *bases;
 	int i;
-	struct commit *ret = NULL;
+	char *full_refname;
+
+	if (dwim_unique_ref(refname, strlen(refname), &oid, &full_refname) < 0) {
+		free(full_refname);
+		return -1;
+	}
+
 
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
-	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+	for_each_reflog_ent(full_refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_oid(refname, &oid))
+	if (!revs.nr && !get_oid(full_refname, &oid))
 		add_one_commit(&oid, &revs);
 
 	for (i = 0; i < revs.nr; i++)
@@ -954,11 +960,12 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	if (revs.nr <= i)
 		goto cleanup_return;
 
-	ret = bases->item;
+	*fork_point = bases->item;
 
 cleanup_return:
+	free(full_refname);
 	free_commit_list(bases);
-	return ret;
+	return 0;
 }
 
 static const char gpg_sig_header[] = "gpgsig";
diff --git a/commit.h b/commit.h
index 221cdaa34b..d79a8eab48 100644
--- a/commit.h
+++ b/commit.h
@@ -240,7 +240,7 @@ int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
-struct commit *get_fork_point(const char *refname, struct commit *commit);
+int get_fork_point(const char *refname, struct commit *commit, struct commit **fork_point);
 
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
diff --git a/refs.c b/refs.c
index 1ab0bb54d3..853e45a6a3 100644
--- a/refs.c
+++ b/refs.c
@@ -639,6 +639,20 @@ int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 	return repo_dwim_ref(the_repository, str, len, oid, ref);
 }
 
+int dwim_unique_ref(const char* str, int len, struct object_id *oid, char **ref)
+{
+	struct object_id discard;
+	switch (dwim_ref(str, len, &discard, ref)) {
+	case 0:
+		return error(_("no such ref: '%s'"), str);
+	case 1:
+		break; /* good */
+	default:
+		return error(_("ambiguous refname: '%s'"), str);
+	}
+	return 0;
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index 730d05ad91..7aa348052b 100644
--- a/refs.h
+++ b/refs.h
@@ -154,6 +154,8 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
+int dwim_unique_ref(const char* str, int len, struct object_id *oid, char **ref);
+
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 78851b9a2a..5b09aecd13 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -47,11 +47,31 @@ test_rebase 'G F B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
+
 test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F E D B A' --fork-point master
+
 test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D master
+
 test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
+test_rebase 'G F B A' --fork-point --keep-base master
+
 test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C E D B A' master
+
 test_rebase 'G F C D B A' --onto D refs/heads/master
+test_rebase 'G F C D B A' --onto D master
+
 test_rebase 'G F C B A' --keep-base refs/heads/master
+test_rebase 'G F C B A' --keep-base master
+
+test_expect_success "git rebase --fork-point with ambigous refname" "
+	git checkout master &&
+	git checkout -b one &&
+	git checkout side &&
+	git tag one &&
+	test_must_fail git rebase --fork-point --onto D one
+"
 
 test_done
-- 
2.17.1

