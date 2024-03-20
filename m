Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCD85947
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968938; cv=none; b=ktVjWpqR3KUkurnhYWpo7cOhBXiYirkH9zg/Uj/40nX0hpFdRru78VeQs/6YAN0KqetcdIaR+hRXX2hmrNqcq2WUPZ63OC3Md0n3J6eH1f78S2JwOsR0yisv0zKy3Ljmk7ALh8KZwKcpgHtKQzKAP2TiLd7YHpQn91Kpnv/Ragw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968938; c=relaxed/simple;
	bh=ldNOCgKAz7SYzP1y3ibPhkg/AnUpIagIJIAM9BbLx1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEEFXY2EYP+qJ8AkFsc/9a/MBN3rnKLWeI2N2W/GeUbOQ1EH/hSLdr6+p+QEtwsXqhWcYAHsdkUst1HLDgUaVC98Wj4J/6AEQBNby6O8BZfEpV7bXptSYUW0jeBIcFbCwuaenxWQBZH0xe6F/9Uuhq8DMWWp8jTdBXaB+ZuOhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FymHkjUC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FymHkjUC"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710968932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV7wFHmYZ+9N/CAQ4I6z8LpBlI61nz9WblxsO5zSdCY=;
	b=FymHkjUCGcXvu9ygFHvVW4XfbctSXpD70M/mTe9yoB3893oYW4PRJxRk/+QKEH1r+RlRnf
	4//iG67cCiFeQ2nZ1YJeJXH5aBp7taW7R4atsYlQb9VUn6DKX95AYFzVwMVzFsivb4wAEo
	4FmIxuATbNAFWxAIcvntX6gZkvTVWyL7HmokeL4fFLcICB0g6LGrIdUhWSwfQUElijnJ1v
	/7WbHkNhX91LUs7BTySGi7YMFPdmFfvOy9v8R5oU/wK3FY/tRWFH5lZLM4DFMcmqg7Zajv
	SZXnVw2XxXeoRYhZGcN7fGzIchFLRKr5jfs8geVEcV8jDPlFjbz/YBu7pdcmXg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com
Subject: [PATCH 3/3] grep docs: describe --no-index further and improve formatting a bit
Date: Wed, 20 Mar 2024 22:08:46 +0100
Message-Id: <264643a638fd1ee9970f96e7aa4914c37e30b3d2.1710968761.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710968761.git.dsimic@manjaro.org>
References: <cover.1710968761.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Improve the description of --no-index, to make a bit more clear what this
option actually does under the hood, and how it is meant to be used.  Describe
the dependency between --no-index and either of the --cached and --untracked
options, which cannot be used together.

As part of that, shuffle a couple of the options, to make the documentation
flow a bit better;  it makes more sense to describe first the options that
have something in common, and to after that describe an option that has some
dependency on the already described options.

While there, improve the descriptions of grep worker threads a bit, to give
them better context.  Adjust the language a bit, to avoid addressing the
reader, and perform some minor formatting improvements, to make it clear
it's the git commands, command parameters, and configuration option names.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch is salvaged from my earlier series, [1] for which it has been
    concluded to be not acceptable for merging, because of possible issues
    with various git scripts. [2]
    
    Compared to the previous version, this version continues the effort to
    improve the description of --no-index, by also incorporating the possible
    improvements pointed out by Junio. [3]  This version also improves the
    wording of some related descriptions, mainly related to grep.threads,
    and performs some additional small formatting improvements.
    
    [1] https://lore.kernel.org/git/cover.1710781235.git.dsimic@manjaro.org/T/#u
    [2] https://lore.kernel.org/git/d8475579f014a90b27efaf6207bc6fb0@manjaro.org/
    [3] https://lore.kernel.org/git/xmqqwmpzrqfv.fsf@gitster.g/

 Documentation/git-grep.txt | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index f64f40e9775a..b144401b3698 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,7 +28,7 @@ SYNOPSIS
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --untracked | --no-index] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -45,13 +45,20 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
---no-index::
-	Search files in the current directory that is not managed by Git.
-
 --untracked::
 	In addition to searching in the tracked files in the working
 	tree, search also in untracked files.
 
+--no-index::
+	Search files in the current directory that is not managed by Git,
+	or by ignoring that the current directory is managed by Git.  This
+	allows `git-grep(1)` to be used as the regular `grep(1)` utility,
+	with the additional benefits, such as using multiple worker threads
+	to speed up searches.
++
+This option cannot be used together with `--cached` or `--untracked`.
+See also `grep.fallbackToNoIndex` in 'CONFIGURATION' below.
+
 --no-exclude-standard::
 	Also search in ignored files by not honoring the `.gitignore`
 	mechanism. Only useful with `--untracked`.
@@ -248,8 +255,9 @@ providing this option will cause it to die.
 	a non-zero status.
 
 --threads <num>::
-	Number of grep worker threads to use.
-	See `grep.threads` in 'CONFIGURATION' for more information.
+	Number of `grep` worker threads to use, to speed up searches.
+	See 'NOTES ON THREADS' and `grep.threads` in 'CONFIGURATION'
+	for more information.
 
 -f <file>::
 	Read patterns from <file>, one per line.
@@ -336,9 +344,9 @@ The `--threads` option (and the `grep.threads` configuration) will be ignored wh
 `--open-files-in-pager` is used, forcing a single-threaded execution.
 
 When grepping the object store (with `--cached` or giving tree objects), running
-with multiple threads might perform slower than single threaded if `--textconv`
-is given and there are too many text conversions. So if you experience low
-performance in this case, it might be desirable to use `--threads=1`.
+with multiple threads might perform slower than single-threaded if `--textconv`
+is given and there are too many text conversions.  Thus, if low performance is
+experienced in this case, it might be desirable to use `--threads=1`.
 
 CONFIGURATION
 -------------
