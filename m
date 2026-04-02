Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B4353EF7
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098733; cv=none; b=mgyptMYIA7OTvZIqvDH8ptNTAOQYBh4jquZuYLkPi202X+FaibcAmpdINTSfHE256WJoAGRhFRMdlOlPvOuQnI+jPnlUKod8fj3xIyTiZUag6UW89wiWsiR/rS7JwUva45p0T/7bP9JTQmUeJ5fkDXswotmHjWPx9X7mnYLc9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098733; c=relaxed/simple;
	bh=IeYuWro7WSGxFTB+PHhcuDbDHskLWSbu7U40auqJMlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPAzLiegJrSQbeOGvOc3ks24xSZg3c2wc2rCsuyh5sIEilHi0uY1jkR7YVslDGwLXaAfIeiHjTVeLlQOwtA7k7eBKhth4hEO18uf3P3Yum04lrULtYT06AP0rdtMHynGlVYATDuKC9WWb8t9yxMXjAhRkc1n00tys6gUwk4pDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnBH4I9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnBH4I9M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE2C6C19423;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098732;
	bh=IeYuWro7WSGxFTB+PHhcuDbDHskLWSbu7U40auqJMlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BnBH4I9MtfKa+6DqO6o1k4qI33xop4j8K3me3AXqS5697hERcL2oKzzb4ySXkIB8j
	 DGae/7FjvbP2Tu0afWYsMh7aZRv8SuoA+EHogpiKNT4Oln95YVYCdnXJa7rA2DhT6s
	 XtHoMWCnPMcDzVo5lMravBt1O2TJ95+zIyjMnWPkHQ0ktkoj27e5el7ybHzNZoel/B
	 aU/BOllmeCPbC6viP2ejyat9oxkidVZeB+3z/U+ELfX1W1509/f/GfiRG0lfPfErsy
	 YNzM2vpBidPD8S5F5xhqSw1QRNK9RN5y/gzYlyIrTV+190j1jdeGUPzWtFh2C4ZRCI
	 aWfLIWLkQAV2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3EE111227B;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Thu, 02 Apr 2026 10:58:45 +0800
Subject: [PATCH v2 1/3] config: add "worktree" and "worktree/i" includeIf
 conditions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-includeif-worktree-v2-1-36e339b898d7@black-desk.cn>
References: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
In-Reply-To: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=UJNFZfyEBrlzkVUL9x9d6o1OcrWt6gtIxYvdk4Eotmo=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzdtoWxJ182FLjLkSpDp6gerPNoMHxymXK7mkN
 Xd+xZ4S31qJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCac3baAAKCRB2HuYUOZmu
 i7iqD/4nnl+NaPYEt9q4PsoB2U5yBoWZaXFuaNFE0f4hrzi7AUFclbTZHn6dxS6QlQkxGWXPW15
 2zchAHIEn3diQ23yjxdGamWkXNBFbmUZ/0S8feZtn7j3UZwgKvtTaHyMa0Psv/7h24xCJY/Wu7C
 RJezsNmGvZ+sa0E0wEPzU0uucBdw/jaFkswEmopBWwEGfs423upMyCXAaQjwWioSQWXgUfsg9rc
 bSAzx7W8orHpwQOYc6M8xeRHGvuJAevkTaDq9ONwLC2UHMUZqRZ0gSDOpwLxd2jVvAYrd4dbAQ5
 6i1KBk15K+XVlwyW0AWe4oLOEp3V4uCudy79xb2n/TEQ6wWfDteA7SRfBBbvsXXRj5CiItV8y3T
 t5KqK42mTzM7BXgbaSRvNdb9Iiy94mZPFb+qb2oklEQSHXoLWUQrFjZKfzJ4GGrW9Y06pycSM68
 5QT+xUdr5rP36z9ZXlZuYK+UDC95tDcSZJ1E9BGNhFyVGBMxBl3klo1PuPU8ux2sx+luj+hicu3
 9JT81XLyxoEtzaxfm2fsh0dp11e9CR946Lfm5Tdu4VYqCWKEDogeN3nwHnx2E/uIU+caJ33lLgU
 foRmPpT1f1Nyzv4JFgjXJDTJUyxZo8PgV7d8FqNePfc7gpJRgbhupgJ8Eym64luzrB2Hj9tH8mw
 rYV36U4mUQe+nJA==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

The `includeIf` mechanism already supports matching on the `.git`
directory path (`gitdir`) and the currently checked out branch
(`onbranch`).  But in multi-worktree setups the `.git` directory of a
linked worktree points into the main repository's `.git/worktrees/`
area, which makes `gitdir` patterns cumbersome when one wants to
include config based on the working tree's checkout path instead.

Introduce two new condition keywords:

  - `worktree:<pattern>` matches the realpath of the current worktree's
    working directory (i.e. `repo_get_work_tree()`) against a glob
    pattern.  This is the path returned by `git rev-parse
    --show-toplevel`.

  - `worktree/i:<pattern>` is the case-insensitive variant.

The implementation follows the same structure as `include_by_gitdir()`:
the worktree path is resolved via `strbuf_realpath()`, the condition
pattern is prepared with `prepare_include_condition_pattern()` (which
handles `~` expansion, `./` relative paths, `**/` prefix insertion and
trailing-`/` expansion), and matching is done with `wildmatch()`.  A
second attempt using `strbuf_add_absolute_path()` is performed to
handle symlinked paths.

The condition never matches in bare repositories (where there is no
worktree) or during early config reading (where no repository is
available).

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 config.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 156f2a24fa00..6d0c2d0725e4 100644
--- a/config.c
+++ b/config.c
@@ -235,23 +235,20 @@ static int prepare_include_condition_pattern(const struct key_value_info *kvi,
 	return 0;
 }
 
-static int include_by_gitdir(const struct key_value_info *kvi,
-			     const struct config_options *opts,
-			     const char *cond, size_t cond_len, int icase)
+static int include_by_path(const struct key_value_info *kvi,
+			   const char *path,
+			   const char *cond, size_t cond_len, int icase)
 {
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
 	size_t prefix;
 	int ret = 0;
-	const char *git_dir;
 	int already_tried_absolute = 0;
 
-	if (opts->git_dir)
-		git_dir = opts->git_dir;
-	else
+	if (!path)
 		goto done;
 
-	strbuf_realpath(&text, git_dir, 1);
+	strbuf_realpath(&text, path, 1);
 	strbuf_add(&pattern, cond, cond_len);
 	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
 	if (ret < 0)
@@ -284,7 +281,7 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 		 * which'll do the right thing
 		 */
 		strbuf_reset(&text);
-		strbuf_add_absolute_path(&text, git_dir);
+		strbuf_add_absolute_path(&text, path);
 		already_tried_absolute = 1;
 		goto again;
 	}
@@ -400,9 +397,15 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
+		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
+		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
+		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
+				       cond, cond_len, 0);
+	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
+		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
+				       cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,

-- 
2.53.0


