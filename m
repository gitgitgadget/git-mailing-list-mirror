Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D423EC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18D020760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPLs8pvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgFJGb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJGb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:31:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85717C03E96B
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:31:56 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u13so898374iol.10
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eRV6TMV1XGB7vJDYyq0SUE8Us7DLrMhH5NvSqKeleQ=;
        b=dPLs8pvbCjAlXKacWDqIrMXfz9oyg0zOIdm7eN5g2PBHpNvdM6+cU8jXgoZq17mxI5
         mTyd04yPLuJx9cldZAgxaxpuHxzLNt3gV59nA6kZPhmVG8SM/sbqLVQ42bhyhhqs6A5x
         kWuxEzOq1zYQsQBr2UZfELuIdPUYn8EhZPsEMghU98oMH/mVC/XQSb77pGPwqXfuPDeh
         wsoN660MSztVFERIiIUovprLJyegc7TjHJQWZX4wpQrmlqciGVaYdYxrMAIswcg73cIs
         8DS6nyR3HC1SsWWC/v6u31N2E2aGmnQJWheZGTvR07FuQ7Xh+v8pajkfwV4MR5k0EBes
         QTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+eRV6TMV1XGB7vJDYyq0SUE8Us7DLrMhH5NvSqKeleQ=;
        b=e+07DDaFucLRvyHG3/SGEgBmqAvd+FuTTagWjaAVxylDMqjI6hE7nWihSwnDJQIGxF
         RsQjxLp0ThwLuL0e8CaUw7pU0QL6zeq8kHZqPZVKp+48x9a56UOqDtwEnoV8lg7PuAKW
         RoH1MNx/6LtezIQ3trtoa+oFkBteiMvlNJjWiRPx6iZhSbJcxeFg1yWeq8pNNPtPLGbu
         tvF/UKo06HdYj1/xy11l5rmBULhlbbvxVhmkEnUGE+dIl9ilOxk8RNLrFiaNsGnNQb6R
         qfo776rMfrYfYVm+XL2K1Wt+k5fv7bBxKoL56GonCfUzc+rMQPblsOXa3dFRCWdcv5WG
         2SWA==
X-Gm-Message-State: AOAM5322XLnaNxvBaSNgxnOdJuQ0sS9b8Mon7UftJcfhyzYSkKvjpVve
        usvT11DL45RGCyBUeYNxCwV5c+Ai920=
X-Google-Smtp-Source: ABdhPJygyT/rFGindCoJ+LR87o1ScyaFtzB/NkDleWQLPK+OEx252kTv2J3CZFLIV8pp1zV+wzm03w==
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr1877605iow.74.1591770714730;
        Tue, 09 Jun 2020 23:31:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:31:53 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/7] worktree: tighten duplicate path detection
Date:   Wed, 10 Jun 2020 02:30:42 -0400
Message-Id: <20200610063049.74666-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which teaches "git worktree prune" to detect
multiple worktrees referencing the same path, and makes "git worktree
move" disallow moving a worktree atop another registered worktree when
the destination worktree is missing (for instance, if it resides on
removable media).

Changes in v2:

* drop patch 2/8, which made 'prune' remove corrupt locked worktree
  entries, since it was difficult to justify the change

* fix a couple typos and a style violation

* fix a Sparse warning reported by Ramsay[2]

* fix a -Werror=main complaint noticed by Junio

[1]: https://lore.kernel.org/git/20200608062356.40264-1-sunshine@sunshineco.com/T/
[2]: https://lore.kernel.org/git/CAPig+cTF+pwBasVCzmucXmMZcm1K0ctkGOavj7bMcGsw2MvoKw@mail.gmail.com/T/

Eric Sunshine (7):
  worktree: factor out repeated string literal
  worktree: give "should be pruned?" function more meaningful name
  worktree: make high-level pruning re-usable
  worktree: prune duplicate entries referencing same worktree path
  worktree: prune linked worktree referencing main worktree path
  worktree: generalize candidate worktree path validation
  worktree: make "move" refuse to move atop missing registered worktree

 Documentation/git-worktree.txt |   4 +-
 builtin/worktree.c             | 128 ++++++++++++++++++++++++---------
 t/t2401-worktree-prune.sh      |  24 +++++++
 t/t2403-worktree-move.sh       |  21 ++++++
 4 files changed, 141 insertions(+), 36 deletions(-)

Interdiff against v1:
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dda7da497c..1238b6bab1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -68,11 +68,11 @@ static void delete_worktrees_dir_if_empty(void)
 }
 
 /*
- * Return NULL if worktree entry should be pruned (along with reason for
- * pruning), otherwise return the path of the worktree itself. Caller is
- * responsible for freeing return value.
+ * Return true if worktree entry should be pruned, along with the reason for
+ * pruning. Otherwise, return false and the worktree's path, or NULL if it
+ * cannot be determined. Caller is responsible for freeing returned path.
  */
-static char *worktree_disposition(const char *id, struct strbuf *reason)
+static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
 {
 	struct stat st;
 	char *path;
@@ -80,19 +80,22 @@ static char *worktree_disposition(const char *id, struct strbuf *reason)
 	size_t len;
 	ssize_t read_result;
 
+	*wtpath = NULL;
 	if (!is_directory(git_path("worktrees/%s", id))) {
 		strbuf_addstr(reason, _("not a valid directory"));
-		return NULL;
+		return 1;
 	}
+	if (file_exists(git_path("worktrees/%s/locked", id)))
+		return 0;
 	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
 		strbuf_addstr(reason, _("gitdir file does not exist"));
-		return NULL;
+		return 1;
 	}
 	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
 		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
 			    strerror(errno));
-		return NULL;
+		return 1;
 	}
 	len = xsize_t(st.st_size);
 	path = xmallocz(len);
@@ -103,7 +106,7 @@ static char *worktree_disposition(const char *id, struct strbuf *reason)
 			    strerror(errno));
 		close(fd);
 		free(path);
-		return NULL;
+		return 1;
 	}
 	close(fd);
 
@@ -112,29 +115,29 @@ static char *worktree_disposition(const char *id, struct strbuf *reason)
 			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
 			    (uintmax_t)len, (uintmax_t)read_result);
 		free(path);
-		return NULL;
+		return 1;
 	}
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
 		strbuf_addstr(reason, _("invalid gitdir file"));
 		free(path);
-		return NULL;
+		return 1;
 	}
 	path[len] = '\0';
 	if (!file_exists(path)) {
-		if (file_exists(git_path("worktrees/%s/locked", id)))
-			return path;
 		if (stat(git_path("worktrees/%s/index", id), &st) ||
 		    st.st_mtime <= expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
 			free(path);
-			return NULL;
+			return 1;
 		} else {
-			return path;
+			*wtpath = path;
+			return 0;
 		}
 	}
-	return path;
+	*wtpath = path;
+	return 0;
 }
 
 static void prune_worktree(const char *id, const char *reason)
@@ -153,7 +156,12 @@ static int prune_cmp(const void *a, const void *b)
 
 	if ((c = fspathcmp(x->string, y->string)))
 	    return c;
-	/* paths same; main worktee (util==0) sorts above all others */
+	/*
+	 * paths same; prune_dupes() removes all but the first worktree entry
+	 * having the same path, so sort main worktree ('util' is NULL) above
+	 * linked worktrees ('util' not NULL) since main worktree can't be
+	 * removed
+	 */
 	if (!x->util)
 		return -1;
 	if (!y->util)
@@ -176,7 +184,7 @@ static void prune_dups(struct string_list *l)
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
-	struct strbuf main = STRBUF_INIT;
+	struct strbuf main_path = STRBUF_INIT;
 	struct string_list kept = STRING_LIST_INIT_NODUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
@@ -187,19 +195,17 @@ static void prune_worktrees(void)
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		path = worktree_disposition(d->d_name, &reason);
-		if (path) {
+		if (should_prune_worktree(d->d_name, &reason, &path))
+			prune_worktree(d->d_name, reason.buf);
+		else if (path)
 			string_list_append(&kept, path)->util = xstrdup(d->d_name);
-			continue;
-		}
-		prune_worktree(d->d_name, reason.buf);
 	}
 	closedir(dir);
 
-	strbuf_add_absolute_path(&main, get_git_common_dir());
+	strbuf_add_absolute_path(&main_path, get_git_common_dir());
 	/* massage main worktree absolute path to match 'gitdir' content */
-	strbuf_strip_suffix(&main, "/.");
-	string_list_append(&kept, strbuf_detach(&main, 0));
+	strbuf_strip_suffix(&main_path, "/.");
+	string_list_append(&kept, strbuf_detach(&main_path, NULL));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 5f3db93b31..a6ce7f590b 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -69,21 +69,11 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 '
 
 test_expect_success 'not prune locked checkout' '
-	test_when_finished rm -fr .git/worktrees ghi &&
-	git worktree add ghi &&
-	: >.git/worktrees/ghi/locked &&
-	rm -r ghi &&
-	git worktree prune &&
-	test -d .git/worktrees/ghi
-'
-
-test_expect_success 'prune corrupt despite lock' '
-	test_when_finished rm -fr .git/worktrees ghi &&
+	test_when_finished rm -r .git/worktrees &&
 	mkdir -p .git/worktrees/ghi &&
-	: >.git/worktrees/ghi/gitdir &&
 	: >.git/worktrees/ghi/locked &&
 	git worktree prune &&
-	! test -d .git/worktrees/ghi
+	test -d .git/worktrees/ghi
 '
 
 test_expect_success 'not prune recent checkouts' '
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 7035c9d72e..a4e1a178e0 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -113,7 +113,7 @@ test_expect_success 'move locked worktree (force)' '
 '
 
 test_expect_success 'refuse to move worktree atop existing path' '
-	> bobble &&
+	>bobble &&
 	git worktree add --detach beeble &&
 	test_must_fail git worktree move beeble bobble
 '

Range-diff against v1:
1:  75e2f832bf = 1:  75e2f832bf worktree: factor out repeated string literal
2:  24662000d2 < -:  ---------- worktree: prune corrupted worktree even if locked
3:  4fb95b3eea = 2:  0e458b3da5 worktree: give "should be pruned?" function more meaningful name
4:  d16d993aa2 = 3:  7cf5b6ca40 worktree: make high-level pruning re-usable
5:  f6bf2f0e72 ! 4:  e28790761f worktree: prune duplicate entries referencing same worktree path
    @@ builtin/worktree.c: static void delete_worktrees_dir_if_empty(void)
      
     -static int should_prune_worktree(const char *id, struct strbuf *reason)
     +/*
    -+ * Return NULL if worktree entry should be pruned (along with reason for
    -+ * pruning), otherwise return the path of the worktree itself. Caller is
    -+ * responsible for freeing return value.
    ++ * Return true if worktree entry should be pruned, along with the reason for
    ++ * pruning. Otherwise, return false and the worktree's path, or NULL if it
    ++ * cannot be determined. Caller is responsible for freeing returned path.
     + */
    -+static char *worktree_disposition(const char *id, struct strbuf *reason)
    ++static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
      {
      	struct stat st;
      	char *path;
     @@ builtin/worktree.c: static int should_prune_worktree(const char *id, struct strbuf *reason)
    + 	size_t len;
    + 	ssize_t read_result;
      
    ++	*wtpath = NULL;
      	if (!is_directory(git_path("worktrees/%s", id))) {
      		strbuf_addstr(reason, _("not a valid directory"));
    --		return 1;
    -+		return NULL;
    - 	}
    - 	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
    - 		strbuf_addstr(reason, _("gitdir file does not exist"));
    --		return 1;
    -+		return NULL;
    - 	}
    - 	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
    - 	if (fd < 0) {
    - 		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
    - 			    strerror(errno));
    --		return 1;
    -+		return NULL;
    - 	}
    - 	len = xsize_t(st.st_size);
    - 	path = xmallocz(len);
    -@@ builtin/worktree.c: static int should_prune_worktree(const char *id, struct strbuf *reason)
    - 			    strerror(errno));
    - 		close(fd);
    - 		free(path);
    --		return 1;
    -+		return NULL;
    - 	}
    - 	close(fd);
    - 
    + 		return 1;
     @@ builtin/worktree.c: static int should_prune_worktree(const char *id, struct strbuf *reason)
    - 			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
    - 			    (uintmax_t)len, (uintmax_t)read_result);
    - 		free(path);
    --		return 1;
    -+		return NULL;
    - 	}
    - 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
    - 		len--;
    - 	if (!len) {
    - 		strbuf_addstr(reason, _("invalid gitdir file"));
    - 		free(path);
    --		return 1;
    -+		return NULL;
      	}
      	path[len] = '\0';
      	if (!file_exists(path)) {
     -		free(path);
    - 		if (file_exists(git_path("worktrees/%s/locked", id)))
    --			return 0;
    -+			return path;
      		if (stat(git_path("worktrees/%s/index", id), &st) ||
      		    st.st_mtime <= expire) {
      			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
    --			return 1;
     +			free(path);
    -+			return NULL;
    + 			return 1;
      		} else {
    --			return 0;
    -+			return path;
    ++			*wtpath = path;
    + 			return 0;
      		}
      	}
     -	free(path);
    --	return 0;
    -+	return path;
    ++	*wtpath = path;
    + 	return 0;
      }
      
    - static void prune_worktree(const char *id, const char *reason)
     @@ builtin/worktree.c: static void prune_worktree(const char *id, const char *reason)
      		delete_git_dir(id);
      }
    @@ builtin/worktree.c: static void prune_worktree(const char *id, const char *reaso
      			continue;
      		strbuf_reset(&reason);
     -		if (!should_prune_worktree(d->d_name, &reason))
    -+		path = worktree_disposition(d->d_name, &reason);
    -+		if (path) {
    +-			continue;
    +-		prune_worktree(d->d_name, reason.buf);
    ++		if (should_prune_worktree(d->d_name, &reason, &path))
    ++			prune_worktree(d->d_name, reason.buf);
    ++		else if (path)
     +			string_list_append(&kept, path)->util = xstrdup(d->d_name);
    - 			continue;
    -+		}
    - 		prune_worktree(d->d_name, reason.buf);
      	}
      	closedir(dir);
     +
6:  6244cbb689 ! 5:  ded0632001 worktree: prune linked worktree referencing main worktree path
    @@ builtin/worktree.c: static int prune_cmp(const void *a, const void *b)
      
      	if ((c = fspathcmp(x->string, y->string)))
      	    return c;
    -+	/* paths same; main worktee (util==0) sorts above all others */
    ++	/*
    ++	 * paths same; prune_dupes() removes all but the first worktree entry
    ++	 * having the same path, so sort main worktree ('util' is NULL) above
    ++	 * linked worktrees ('util' not NULL) since main worktree can't be
    ++	 * removed
    ++	 */
     +	if (!x->util)
     +		return -1;
     +	if (!y->util)
    @@ builtin/worktree.c: static void prune_dups(struct string_list *l)
      static void prune_worktrees(void)
      {
      	struct strbuf reason = STRBUF_INIT;
    -+	struct strbuf main = STRBUF_INIT;
    ++	struct strbuf main_path = STRBUF_INIT;
      	struct string_list kept = STRING_LIST_INIT_NODUP;
      	DIR *dir = opendir(git_path("worktrees"));
      	struct dirent *d;
    @@ builtin/worktree.c: static void prune_worktrees(void)
      	}
      	closedir(dir);
      
    -+	strbuf_add_absolute_path(&main, get_git_common_dir());
    ++	strbuf_add_absolute_path(&main_path, get_git_common_dir());
     +	/* massage main worktree absolute path to match 'gitdir' content */
    -+	strbuf_strip_suffix(&main, "/.");
    -+	string_list_append(&kept, strbuf_detach(&main, 0));
    ++	strbuf_strip_suffix(&main_path, "/.");
    ++	string_list_append(&kept, strbuf_detach(&main_path, NULL));
      	prune_dups(&kept);
      	string_list_clear(&kept, 1);
      
7:  1355b373d3 = 6:  2ca210fa73 worktree: generalize candidate worktree path validation
8:  8bfe91bfd2 ! 7:  74dd7d1ac0 worktree: make "move" refuse to move atop missing registered worktree
    @@ Commit message
         careful when validating the destination location and will happily move
         the source worktree atop the location of a missing worktree. This leads
         to the anomalous situation of multiple worktrees being associated with
    -    the same path, which is expressively forbidden by design. For example:
    +    the same path, which is expressly forbidden by design. For example:
     
             $ git clone foo.git
             $ cd foo
    @@ t/t2403-worktree-move.sh: test_expect_success 'move locked worktree (force)' '
      '
      
     +test_expect_success 'refuse to move worktree atop existing path' '
    -+	> bobble &&
    ++	>bobble &&
     +	git worktree add --detach beeble &&
     +	test_must_fail git worktree move beeble bobble
     +'
-- 
2.27.0.90.gabb59f83a2

