Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B733997
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357164; cv=none; b=IL1uH8S+8877QKl9+VVovEbJu0X5OlA0tgpjUfQT1iv+qOjlv6qJEB4PQyz9C8r3ihJLT9rNULum3AYMZhfGQ37BBJ3u9oS4nyQ+8+tyS4QQPKKKLKx7Mt4kvX7J2EKP7m/Ue+ZGcbbKbGZDcx8MAw4Yu/CHFvM+JGY3dPVrv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357164; c=relaxed/simple;
	bh=gG8ILAzuSgKlG2hmvlndSE0W98a4ZW8oFRVzAgOnTc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuCfcczvgcOZbUNj5iJ6EtjHGVz7sfZifzRo2/r2GFUpCe1W6DULaZxAw3EXgUAlKWneRu/xhGqKteydjt+qaWTHGsM9hN67YUskopYiW3sF94YLCxlZCKKIKWC9tuuQPc2jBGIU5Am4tOcLIDmuQGsbh00nCRyEXfr8R8Omh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze9Xjp42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze9Xjp42"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED1AAC4CED0;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728357164;
	bh=gG8ILAzuSgKlG2hmvlndSE0W98a4ZW8oFRVzAgOnTc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ze9Xjp42yOTth3zVrarBA4AXvWbAxo/mfkeCazrf+6mnvU9irbMmaLEBEVt73Cxdv
	 xUyPQDJ6ugYT5C7sY1zmF89l7cTWaAD0im0REQP80bHdNg44Mo7yt23r31SRK8/ITS
	 o/XdzxpDvqpfMNrASVVObMxKc/bpghK+RhMFVT36plllU6L/GujQihOB+Gj+UqRUyh
	 pbP+lkFPVUQeoC/XBflT5njJFNmqaR/KSk1fo6nJGUptLAFpjHfdjR4yacjWB0v5cl
	 2u53uonxGi65MK9bFq10cB4/W51ssj9obozej3QYg+Km75fD4ox57t/40AfJszBbZq
	 JjCSdal8klwpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F5CED263;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
From: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>
Date: Mon, 07 Oct 2024 22:12:32 -0500
Subject: [PATCH v3 3/3] worktree: add test for path handling in linked
 worktrees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-wt_relative_paths-v3-3-622cf18c45eb@pm.me>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
In-Reply-To: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=cdwhite3@pm.me;
 h=from:subject:message-id;
 bh=jVeMwSXz6V0Ws/FxdC9tKiKw+TrVE9J7E72QZFqsvs8=;
 b=owGbwMvMwCVmxF73kO8jewrjabUkhnSWxVp7CgqDDsxcWDfJavOX6bI1CQfvX1375p7Rgsv8n
 //+P9y2sKOUhUGMi0FWTJHlzdbvBeqpjzO4P5TPhpnDygQyhIGLUwAmsv0Bw/942frqfb9W5nnc
 cHkdsMZsfc26KIeVX3a85/+uKTZ1s/hTRoY/rX0N29qWnVn8ckXpFgnB4weSzi1WWj+PYWn4r2+
 CUz14AQ==
X-Developer-Key: i=cdwhite3@pm.me; a=openpgp;
 fpr=99981A649E1CA829A335E77493EDE5A0C788BC38
X-Endpoint-Received: by B4 Relay for cdwhite3@pm.me/default with
 auth_id=237
X-Original-From: Caleb White <cdwhite3@pm.me>
Reply-To: cdwhite3@pm.me

From: Caleb White <cdwhite3@pm.me>

A failure scenario reported in an earlier patch series[1] that several
`git worktree` subcommands failed or misbehaved when invoked from within
linked worktrees that used relative paths.

This adds a test that executes a `worktree prune` command inside both an
internally and an externally linked worktree and asserts that the other
worktree was not pruned.

[1]: https://lore.kernel.org/git/CAPig+cQXFy=xPVpoSq6Wq0pxMRCjS=WbkgdO+3LySPX=q0nPCw@mail.gmail.com/

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 t/t2401-worktree-prune.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 71aa9bcd620f8a504fe628a2d7332d8b47fd4701..976d048e3efc74be9cd909ce76d552b3944d2e10 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -120,4 +120,23 @@ test_expect_success 'prune duplicate (main/linked)' '
 	! test -d .git/worktrees/wt
 '
 
+test_expect_success 'not prune proper worktrees when run inside linked worktree' '
+	test_when_finished rm -rf repo wt_ext &&
+	git init repo &&
+	(
+	    cd repo &&
+	    echo content >file &&
+	    git add file &&
+	    git commit -m msg &&
+	    git worktree add ../wt_ext &&
+	    git worktree add wt_int &&
+	    cd wt_int &&
+	    git worktree prune -v >out &&
+	    test_must_be_empty out &&
+	    cd ../../wt_ext &&
+	    git worktree prune -v >out &&
+	    test_must_be_empty out
+	)
+'
+
 test_done

-- 
2.46.2


