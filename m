Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74B36923B
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028859; cv=none; b=j+/rFwKyu7X7VO5EX7PqZd3K+D8cchw0zDxrq2yBckacIXoDlo6qpJWvfL7yoSJrhAP12kEHgGKevY3G1hxVeTnNtSZmHWGPKW5WgkHP6TqcOcdovtohs7r3wBGZy9b4i5m9vC6DxfAsHE9TdFB4mVmupbqlZ9mGeg58aQbTUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028859; c=relaxed/simple;
	bh=a/2O2tSGomMqQZNMNjvcn4+QFf/tfpobqoQ7KDKpntc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGdUgq+7RlePtUzhNs6cn/A0xjuotkywn30i5F65yrkx1yWIRzJlwWQUmYOdhMyuFUeE9UaT7ilc+SjDhhjrnkbcKWKHzLL65XXIMREp9O8cfuft3U0ZnQwjZO4vmDP6Tr+vQtyeenx5jnLPe8cvo89zH2srBSt0YQ4uwp+6k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCQhGvN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCQhGvN0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D86B5C2BC9E;
	Wed,  1 Apr 2026 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028858;
	bh=a/2O2tSGomMqQZNMNjvcn4+QFf/tfpobqoQ7KDKpntc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kCQhGvN0B27jnVnWwWdQDE1SGYQQ1l0xF00EnnHxTC7qNdImHiy3bcyQXTjEtFJ02
	 rVMa7HK0NpkxYQODHuY/RVnFZ9Xm+u9A2ODgEjceipmyHMC3t57Hx5Yq0TyRIl5L84
	 lorjBOkUQeD/7VJWPDIO6UVt2Bnm7WscVq5BHHMBinLya7nP5xyxGPCcycjqDadsmE
	 0B36hq2PenV900ak/WJd5zAz7XzQUYEWiculWPrA/+BPqwONAhFK6gfWKPuhWsqJ3o
	 qdCz2vYOnKUMTwvLWKd1svlsmfFAFzcuxvvDtNTwhHRO5+8tVC9DFzMcV5BEBS7pC8
	 S16fHYD0xmaEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0BD3514F;
	Wed,  1 Apr 2026 07:34:18 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Wed, 01 Apr 2026 15:33:41 +0800
Subject: [PATCH 1/3] config: add "worktree" and "worktree/i" includeIf
 conditions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-includeif-worktree-v1-1-906db69f2c79@black-desk.cn>
References: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
In-Reply-To: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
To: git@vger.kernel.org
Cc: Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3883; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=kaFWC9wBISxy3RLvDFRPmLRUew78/tUn1vwIu1C4hEE=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzMp2cM8+vn625kfXIE5OFKG5xG4i7TPRZMpb/
 8gZRajr3cmJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaczKdgAKCRB2HuYUOZmu
 izLGEAC0x0WK+uNP7crQXgXKc2J5U3/xnp63EJ4GG4TWSHuQq393pmxJ02ig6ORksuRXFUuNrG8
 DQsi4Sb00PCMpu/tZp5hpqZQioHg89JvKxPuo9a8CKW5AlT2w/Kw1lfJgFAhIqnsf7L8wsihD7z
 IbdPQqfcgqzQXjEjBn2+E8nnjggD8sAVnQhAwtRM3L0w3WA8HbCuSx0pq+UqPaVCDJLSYtN5G6M
 7mizHM+ZiFUMjW35WFc5rcJcTKY64e8xSAlHI5q0FSvx3sfDbsrFJfYAtlhAyAXsU6kMamTp2iF
 4M2v0dz+x+YLUiBtFoeitWb+ZOaaaEKJV9tQ41H7mOT8xWB1mDLSKeQzDpEDTX+OmcseSO9grFH
 ni3gWNwtkygmQQ44KVBW5AaaPSwrNL5R0ceTtBlXGsvcu/mmOstB1/VdIJbRyA9BBJ6wmtfhJOh
 VJIoFgkeBfKbViDMXcQRtQAJcZoXT7h9sGzmY2rub9DxnvUyzRFYI0H7p/VbcVPIxrUA2JcOd4Y
 qM8KupbYQgjTzvHi/jGw5gmMFrXLK6sdQBsOtzsxHHhwW/Hu3VbI4at1uqto6UhYrs9uzNg899J
 V17OEOFNEC8HQC9q4AZGv3mDqGD+s3KJCOv1/gByZz2fh5mbMXxTPsetzwJuCrgdldryJMaKYUd
 BQq1Vqh19qFJetw==
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


