Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C455C27
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781425; cv=none; b=UXmqAWS88ZjV0V4qb+J9MoFeCIoa0WyR5P1nnCYbzqaDCDX+27+lEYvHTkTYRGHX4M0nX7pyuQVxsF5fQOZ2Pz6bpb0qzyrwf7P1TmfgQUnfJQ3TtQ3iAh2il+w2ekenqd+PhQD2xTVFqoPzss7yrXFgxldr0zr1R4pmKFl35wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781425; c=relaxed/simple;
	bh=+Nt9TIz1lSngdEfuWLTdgFFrbxiQIl+eUd/uAKaKTTU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ou/RBMxdFSF/Agak5YbZXsNmQ1YC5KXnol+H0nYaE/IQfCS46DZfkJJ8VNAmiwCwFojQsmgAc+AUMSNuvarnbLfOXkvzpsO7McuVzaMkQ/gfk83jtILshfgnYPGSqxU+WzXFiJ6omQA3wUh2fUD+AfLtRS1da5rB0mTrYWBXxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bU4KqN0Z; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bU4KqN0Z"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710781412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKyO4gerwcF0Z9g8rQ8oDKQEc077zWWTUptWOuap30g=;
	b=bU4KqN0Zy9wJGShfSydOiDhqJ9NNnRP/vBZggb+sfBDbjdSffRZhDOjMi6AgD1hKCNleGw
	FmmPtjXIDYfmQEyhJsKl2SOmx1W8whIMrQu75bAsM59caFUv+Fd8brd7d50JYalnezvS/w
	Yu74F0BqHd2Dv1BxZ3OZ6aRQF+n7ho1nJkB7QbwXGMAj8DjOmLgfWN1VXX0ouAhPqXBEq2
	fP6hmgH8w5eQo4+ttpqGQIKaXmPKUqmYqqdfJyDDwD/rN0BqpxOI3vSKm0S3nAdSuRhF3v
	XmJLnXYyCbhWeI0HviHbFPcVspIHVWN+rDBqVDeSDLGJrz9ul6V5sV0GK7BpqQ==
To: git@vger.kernel.org
Subject: [PATCH 5/5] grep docs: describe new config option to include untracked files
Date: Mon, 18 Mar 2024 18:03:25 +0100
Message-Id: <9ce006509306136bb2354006e3b14ceaf26d0d32.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710781235.git.dsimic@manjaro.org>
References: <cover.1710781235.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Describe the new configuration option grep.includeUntracked, including the
dependencies with the already existing options, and the conditions that
make this option ignored, which allows other options to be used while the
new option is enabled in one's git configuration file.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config/grep.txt | 6 ++++++
 Documentation/git-grep.txt    | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 10041f27b0c8..32f086997596 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -23,6 +23,12 @@ grep.threads::
 grep.fullName::
 	If set to true, enable `--full-name` option by default.
 
+grep.includeUntracked::
+	If set to true, enable `--untracked` option by default, to search also
+	in untracked files, in addition to searching in the tracked files in the
+	working tree.  If `--cached` or `--no-index` is specified, this option is
+	ignored.  Also, it cannot be enabled together with `submodule.recurse`.
+
 grep.fallbackToNoIndex::
 	If set to true, fall back to `git grep --no-index` if `git grep`
 	is executed outside of a git repository.  Defaults to false.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b377523381bb..af5f6572df16 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -47,7 +47,8 @@ OPTIONS
 
 --untracked::
 	In addition to searching in the tracked files in the working
-	tree, search also in untracked files.
+	tree, search also in untracked files.  See also `grep.includeUntracked`
+	in CONFIGURATION below.
 
 --no-index::
 	Search files in the current directory that is not managed by Git.
