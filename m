Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEAE3537EE
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098733; cv=none; b=s7PlBlf+AWq0fm+1SWNP8KOU4UA2DuHMbmfQb5RQlf/A0GR/0YPPFKJWnlK2yos0pqQM/xe/1vCmqXgpP0d7VtJp40k2eDIBi9bhYF89uyFYAqI4/JoC6Fek2OOajsMebj0KezlfkUDySHBVGhMH3twhFUbjDByez6iQwyPpuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098733; c=relaxed/simple;
	bh=bt3XMRPsLjP3WUrYHIkuvhVqO9g/33y9bY9A3tzExvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCwykma01lynUEpVG9PtH4jMATKRZbkA3NhBjTkHYq8qOzbiqLbFpE+VwclefnHhfkaY+P82R6Q10aPEtUMUC64pGL+ISsGcrMR49Gcw1v+J4Btw/hhhcOc2yi3ZgCQVA9G0kOeDT+/OSAz2hkg8B1kSSfu/TEZPsYNKwDqrEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR64Zx5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR64Zx5J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB28AC2BCAF;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098732;
	bh=bt3XMRPsLjP3WUrYHIkuvhVqO9g/33y9bY9A3tzExvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lR64Zx5JHVGyy4teZKXkLf7CnS5vfBqeGToDSFPxXS/MmBKBT9htnOhr26zRFMa1Y
	 zDDu7ph1TO/toCkaaVEyvEbpExk/eaREFaOVjFO937IqSMNcdjrJSxBbM+zI4mxI0E
	 6eCRKAB44inviSdTjdnsZJNuEIri2ZBIHH6nqqKmdBSMZBNWQ3XuIprXU/75yo/Ffg
	 fSyW6hICDavYOyNF0LftSoAJXjpNe2/E50L1ljl1T4arBWA5L1MjleBm5+8haL7fa0
	 dSwdhNokbszDrWNwUmwgePA1Gy6FmLmxCQZWM3vP11nmU5FSSB5V+ag7plEbLWOzfk
	 TO6KgE/PZrSAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD896111227A;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Thu, 02 Apr 2026 10:58:47 +0800
Subject: [PATCH v2 3/3] t1305: add tests for includeIf "worktree"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-includeif-worktree-v2-3-36e339b898d7@black-desk.cn>
References: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
In-Reply-To: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=+pfu2Arw9XFq2kWFToTNGBZHP0Ni9fWe1yZKTTIyj8A=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzdtqkhBuxyP9jpANgdDyxRNhw7ab+cQQJQREa
 bXlEvALDjeJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCac3bagAKCRB2HuYUOZmu
 i8JXEACn7ZtCgb/CjBsq4gLGF+C7RzpcfNtARqZRPJbNPRCLN/o3a8fa4hJFGv+pNB4VAzAVeon
 UK/KfBpfP8+hxNjhEiRoJcclVzRyRyTsfCxwCqD/aU5/R7pWTS3UzuKWixEg4+Mlkduxgz4oWPP
 d/fXAAbNJrd4oI6LeJyBZFreL8EDoKsBYxP5Qxlgt5ee7IR1jUKoGGLMtmSUnIvAGfbI7Us3L1S
 bt1ffVq8H9ZwGPVvoxZ3Ecd8uEFGcHo+QYy2pSugGCpyP8Jlj+xndlRIf8c5OtrXUDVafL1GXyF
 scjimrBFDg46YmxdEUfsb7gJaJs0NgZe4ywLNcnMdgh9VAqSOjHBc0zRmm0QTSjmBDW4Jls3WWY
 rm7DV2P1A3s9s0SHNhJGQd4MOlAW6gFLRzoMS/JxyVA7vt8RCnbtiuEQIXQWqulH6eBrslVi4vM
 DDiRBx1HrbJMc6sHTXZ5BwnvG1Tt954OVLzlyJS/gGMw6+kmKZp+IDrpWJRMzpyb5t7kqz3b453
 ygKToAwGQUjWmP0YP7RkctbCAQ5hI7rBk6IpAt20CSuz+B9rliLUONeGUdSOzqqJW8pxHx0HNoF
 inC9vvLujXiJAr1RZXLpnfyoz7opd3rGVtwjWMKa+ZvWlnTHXRu9OLkH6TKTZpfvI4cH/BiDDsr
 7oHTXYXj9ytt7Fg==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

Cover the following scenarios unique to the "worktree" condition
(path matching features such as glob, tilde, icase are already
exercised by the gitdir tests):

  - bare repository (condition must not match)
  - multiple worktrees: main and linked worktrees each match their
    own path-based condition while sharing a single config file;
    a third linked worktree verifies directory-prefix matching with
    a trailing slash
  - symlinked worktree: the path is resolved before matching

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 t/t1305-config-include.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6e51f892f320..8a5ba4b884d3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -396,4 +396,70 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
 '
 
+# worktree: conditional include tests
+
+test_expect_success 'conditional include, worktree bare repo' '
+	git init --bare wt-bare &&
+	(
+		cd wt-bare &&
+		echo "[includeIf \"worktree:/\"]path=bar-bare" >>config &&
+		echo "[test]wtbare=1" >bar-bare &&
+		test_must_fail git config test.wtbare
+	)
+'
+
+test_expect_success 'conditional include, worktree multiple worktrees' '
+	git init wt-multi &&
+	(
+		cd wt-multi &&
+		test_commit initial &&
+		git worktree add -b linked-branch ../wt-linked HEAD &&
+		git worktree add -b prefix-branch ../wt-prefix/linked HEAD
+	) &&
+	wt_main="$(cd wt-multi && pwd)" &&
+	wt_linked="$(cd wt-linked && pwd)" &&
+	wt_prefix_parent="$(cd wt-prefix && pwd)" &&
+	cat >>wt-multi/.git/config <<-EOF &&
+	[includeIf "worktree:$wt_main"]
+		path = main-config
+	[includeIf "worktree:$wt_linked"]
+		path = linked-config
+	[includeIf "worktree:$wt_prefix_parent/"]
+		path = prefix-config
+	EOF
+	echo "[test]mainvar=main" >wt-multi/.git/main-config &&
+	echo "[test]linkedvar=linked" >wt-multi/.git/linked-config &&
+	echo "[test]prefixvar=prefix" >wt-multi/.git/prefix-config &&
+	echo main >expect &&
+	git -C wt-multi config test.mainvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-multi config test.linkedvar &&
+	test_must_fail git -C wt-multi config test.prefixvar &&
+	echo linked >expect &&
+	git -C wt-linked config test.linkedvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-linked config test.mainvar &&
+	test_must_fail git -C wt-linked config test.prefixvar &&
+	echo prefix >expect &&
+	git -C wt-prefix/linked config test.prefixvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-prefix/linked config test.mainvar &&
+	test_must_fail git -C wt-prefix/linked config test.linkedvar
+'
+
+test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
+	mkdir real-wt &&
+	ln -s real-wt link-wt &&
+	git init link-wt/repo &&
+	(
+		cd link-wt/repo &&
+		# repo->worktree resolves symlinks, so use real path in pattern
+		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
+		echo "[test]wtlink=2" >.git/bar-link &&
+		echo 2 >expect &&
+		git config test.wtlink >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

-- 
2.53.0


