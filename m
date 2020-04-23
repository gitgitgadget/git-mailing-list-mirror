Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94927C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BC12074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MFYMpmI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDWAZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWAZs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 20:25:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6633C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:25:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o10so1971170pgb.6
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3og/My9+IPhw+r/2JK3sL8vcCmSpOvBmVTp+qeqE23w=;
        b=MFYMpmI+hlAwyJhutDED32WQ/9xSK6gvr+Q2wPiovcGWuwD35DaBQpdAIbkq8QsQ5J
         Tkc4BCBchjaJOt/SYGsMLt1/Pjr/0/Go2tj8ai76gJcW3v3RG9AY5I60ps2mYDtqxd4b
         3rfP/YXb6Orzo5IRIvlImbdYtYHyoypSx6xAp/98qD+FOll2haxku8y67OM6cED1UqV5
         bpkCbvtCbM2qgK0KYKyKSrKfXQJTC7dcGpCX/kdmL/NizVDCmj0LfW9dpk5MmlTaHNjs
         wO2SoPTa9LssyDDejRnpY56xmuZrsXPFgRCxnfvAzd+hXUpSXQt34sYgzod9lwn4OECh
         GcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3og/My9+IPhw+r/2JK3sL8vcCmSpOvBmVTp+qeqE23w=;
        b=jkt/b1HS9WIErHDaqQyBC26p0IIh76VO4Dghlt91USDuzxhG5N2/lBTw7QdkAuUwNZ
         DM7KL5fARu4ACjWDnb1euudUuW7UFjPhRg7C025ov2xAozllz2rykKNAzlhmpImF/daj
         0lwKUaQF3pbrpbu0cKyEoRdJGBPvOKNOIPzch1uOqFh0o00MIU4dp0ShHHKUMox/Qivc
         2NshWv+tQXMVFC4KM5m2sM9XQaY6XtPAEGP7ZAzcA1SE1xr3QG2kGQWq4Ob8jH0KN1Qh
         dDqmYsUbwmvTnwNK/jBc5oqmxSigpBDG+9lDAuL1SS1NlXpGwFVfJvbrBkaCk8UsAQ6Y
         /PIQ==
X-Gm-Message-State: AGi0PuZ0SfgijG3Dz3zzWMVB5Ct4XtDZkckA5KafCFOcsTL8ffvN09DX
        SUQYOiWJeZO6+MzZuFEfINYleIBto/ZeSw==
X-Google-Smtp-Source: APiQypLM7EsONN01ASCBUtqwEpEq1sGY4KwySr6Kz2lMhjPqJoLswSbzLDS0wb7EmLK+3qnEmLq/gQ==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr1162070pfb.211.1587601546919;
        Wed, 22 Apr 2020 17:25:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b13sm679723pfo.67.2020.04.22.17.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 17:25:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:25:45 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com
Subject: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587601501.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
2019-01-10), the author noted that 'is_repository_shallow' produces
visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.

This is a problem for e.g., fetching with '--update-shallow' in a
shallow repository with 'fetch.writeCommitGraph' enabled, since the
update to '.git/shallow' will cause Git to think that the repository
isn't shallow when it is, thereby circumventing the commit-graph
compatibility check.

This causes problems in shallow repositories with at least shallow refs
that have at least one ancestor (since the client won't have those
objects, and therefore can't take the reachability closure over commits
when writing a commit-graph).

Address this by introducing thin wrappers over 'commit_lock_file' and
'rollback_lock_file' for use specifically when the lock is held over
'.git/shallow'. These wrappers (appropriately called
'commit_shallow_file' and 'rollback_shallow_file') call into their
respective functions in 'lockfile.h', but additionally reset validity
checks used by the shallow machinery.

Replace each instance of 'commit_lock_file' and 'rollback_lock_file'
with 'commit_shallow_file' and 'rollback_shallow_file' when the lock
being held is over the '.git/shallow' file.

As a result, 'prune_shallow' can now only be called once (since
'check_shallow_file_for_update' will die after calling
'reset_repository_shallow'). But, this is OK since we only call
'prune_shallow' at most once per process.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c   |  4 ++--
 commit.h                 |  2 ++
 fetch-pack.c             | 10 +++++-----
 shallow.c                | 30 +++++++++++++++++++++---------
 t/t5537-fetch-shallow.sh | 29 +++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..652661fa99 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -872,12 +872,12 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
-		rollback_lock_file(&shallow_lock);
+		rollback_shallow_file(the_repository, &shallow_lock);
 		oid_array_clear(&extra);
 		return -1;
 	}
 
-	commit_lock_file(&shallow_lock);
+	commit_shallow_file(the_repository, &shallow_lock);
 
 	/*
 	 * Make sure setup_alternate_shallow() for the next ref does
diff --git a/commit.h b/commit.h
index 008a0fa4a0..ab91d21131 100644
--- a/commit.h
+++ b/commit.h
@@ -249,6 +249,8 @@ struct oid_array;
 struct ref;
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
+int commit_shallow_file(struct repository *r, struct lock_file *lk);
+void rollback_shallow_file(struct repository *r, struct lock_file *lk);
 int for_each_commit_graft(each_commit_graft_fn, void *);
 int is_repository_shallow(struct repository *r);
 struct commit_list *get_shallow_commits(struct object_array *heads,
diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..a618f3b029 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1629,9 +1629,9 @@ static void update_shallow(struct fetch_pack_args *args,
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
 			unlink_or_warn(git_path_shallow(the_repository));
-			rollback_lock_file(&shallow_lock);
+			rollback_shallow_file(the_repository, &shallow_lock);
 		} else
-			commit_lock_file(&shallow_lock);
+			commit_shallow_file(the_repository, &shallow_lock);
 		alternate_shallow_file = NULL;
 		return;
 	}
@@ -1655,7 +1655,7 @@ static void update_shallow(struct fetch_pack_args *args,
 			setup_alternate_shallow(&shallow_lock,
 						&alternate_shallow_file,
 						&extra);
-			commit_lock_file(&shallow_lock);
+			commit_shallow_file(the_repository, &shallow_lock);
 			alternate_shallow_file = NULL;
 		}
 		oid_array_clear(&extra);
@@ -1693,7 +1693,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		setup_alternate_shallow(&shallow_lock,
 					&alternate_shallow_file,
 					&extra);
-		commit_lock_file(&shallow_lock);
+		commit_shallow_file(the_repository, &shallow_lock);
 		oid_array_clear(&extra);
 		oid_array_clear(&ref);
 		alternate_shallow_file = NULL;
@@ -1785,7 +1785,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 			error(_("remote did not send all necessary objects"));
 			free_refs(ref_cpy);
 			ref_cpy = NULL;
-			rollback_lock_file(&shallow_lock);
+			rollback_shallow_file(the_repository, &shallow_lock);
 			goto cleanup;
 		}
 		args->connectivity_checked = 1;
diff --git a/shallow.c b/shallow.c
index 7fd04afed1..5010a6c732 100644
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
@@ -79,6 +72,25 @@ int is_repository_shallow(struct repository *r)
 	return r->parsed_objects->is_shallow;
 }
 
+static void reset_repository_shallow(struct repository *r)
+{
+	r->parsed_objects->is_shallow = -1;
+	stat_validity_clear(r->parsed_objects->shallow_stat);
+}
+
+int commit_shallow_file(struct repository *r, struct lock_file *lk)
+{
+	int res = commit_lock_file(lk);
+	reset_repository_shallow(r);
+	return res;
+}
+
+void rollback_shallow_file(struct repository *r, struct lock_file *lk)
+{
+	rollback_lock_file(lk);
+	reset_repository_shallow(r);
+}
+
 /*
  * TODO: use "int" elemtype instead of "int *" when/if commit-slab
  * supports a "valid" flag.
@@ -410,10 +422,10 @@ void prune_shallow(unsigned options)
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
 				  get_lock_file_path(&shallow_lock));
-		commit_lock_file(&shallow_lock);
+		commit_shallow_file(the_repository, &shallow_lock);
 	} else {
 		unlink(git_path_shallow(the_repository));
-		rollback_lock_file(&shallow_lock);
+		rollback_shallow_file(the_repository, &shallow_lock);
 	}
 	strbuf_release(&sb);
 }
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index d66b3656c0..a51c4b39d9 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -146,6 +146,35 @@ test_expect_success 'fetch --update-shallow' '
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
+	test_config -C notshallow fetch.writeCommitGraph true &&
+	(
+	cd notshallow &&
+	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
+	git fsck &&
+	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
+	cat <<-EOF >expect.refs &&
+	refs/remotes/shallow/master
+	refs/remotes/shallow/no-shallow
+	refs/tags/heavy-tag
+	refs/tags/heavy-tag-for-graph
+	refs/tags/light-tag
+	refs/tags/light-tag-for-graph
+	EOF
+	test_cmp expect.refs actual.refs &&
+	git log --format=%s shallow/master >actual &&
+	test_write_lines 8 7 6 5 4 3 >expect &&
+	test_cmp expect actual
+	)
+'
+
 test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	cp -R .git read-only.git &&
 	test_when_finished "find read-only.git -type d -print | xargs chmod +w" &&
-- 
2.26.0.113.ge9739cdccc
