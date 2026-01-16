Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6450203710
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569791; cv=none; b=t/xLDmET4FvWXXzwls7Y0Nu+wpFbCKDVbVZVzCipA6xJzXeRC9J5zz6DUIMz/bnDSeSC8BGmCMLRgwEX6qiRaSCmfs5v8jQqpbIdqWzmFJxGMhyjeG6xYO39eb6nkAUt92hde0P7DS6Vhxyvd6EX/dW3+D3j2DqggMuTZ9TYeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569791; c=relaxed/simple;
	bh=S3aKjnQrKnt+oB5T+S09SQc943qKAg6q6umOQf6TAZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8NaIqIkwD6TL+lvWFCL1Jt2KtkOzfu587/Cxcp2w4JuPfpOzkbyXE7v8Gzgw09EOzGcK8TWFfYs57z/ewqCRqZ2cEZ7cN6wNHP/i/J3snXO6q56T7Oo3R0uS2LvQp7kcbIIczpu7OAoRUk7BBcsxY7ChzLssTnmE76NChJJOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OgxcNAAb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OgxcNAAb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ZiANCxoydFSL4KDUYiBIFJJwfjTjcbiMc1sj2jn6A=;
	b=OgxcNAAbkEak/nApb8nio/3ikNAAFDdB0RRgVs4RTT4Fl1EfQo5DGxy8UMKUiJY3GvoTzl
	tfHP8sofDxBo6FvHr9Oh8Yc/zXaDLbYeMl5X+gQkc2xgi8yNAjP34VpBkaLLuXkB2d/ES8
	CferDKwJN6sYYakSclToz6PPvXAWs9E=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:22:49 +0100
Subject: [PATCH v2 1/5] last-modified: document NUL termination
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-zzzz-v2-1-79e44f2806fe@iotcl.com>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The command git-last-modified(1) already recognizes the option '-z', and
similar to many other commands this will make the output NUL-terminated
instead of using newlines. Although, this option is missing from the
documentation, so add it.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 22 +++++++++++++++++++++-
 builtin/last-modified.c              |  4 ++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 602843e095..2e5f370c15 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,8 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees] [<revision-range>] [[--] <path>...]
+git last-modified [--recursive] [--show-trees] [-z]
+		  [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -32,6 +33,9 @@ OPTIONS
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
+`-z`::
+	Terminate each line with a _NUL_ character rather than a newline.
+
 `<revision-range>`::
 	Only traverse commits in the specified revision range. When no
 	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
@@ -44,6 +48,22 @@ OPTIONS
 	Without an optional path parameter, all files and subdirectories
 	in path traversal the are included in the output.
 
+OUTPUT
+------
+
+The output is in the format:
+
+------------
+ <oid> TAB <path> LF
+------------
+
+If a path contains any special characters, the path is C-style quoted. To
+avoid quoting, pass option `-z` to terminate each line with a NUL.
+
+------------
+ <oid> TAB <path> NUL
+------------
+
 SEE ALSO
 --------
 linkgit:git-blame[1],
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c80f0535f6..cac66d03fd 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -510,8 +510,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = { 0 };
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] "
-		   "[<revision-range>] [[--] <path>...]"),
+		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
+		   "                  [<revision-range>] [[--] <path>...]"),
 		NULL
 	};
 

-- 
2.52.0

