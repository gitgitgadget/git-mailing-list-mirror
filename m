Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73B1BF2F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398901; cv=none; b=GjUVTSRqaVDQDWjypOVPEaxXexjLfahImQEnsYbBoabsybPuKgSFgP+qTJzI0DEGcIRUJOlN/DnHP8mF9xuFe0I8zKJJt6+BftQlh+il0Wal1z5C6wMSJI2Jk3XadfkQeUWaqXpyqJYT0T48emh1IncMdLtSFW+li7EzOkRfiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398901; c=relaxed/simple;
	bh=QcnBF4IPQ03di61u/7kKFFpSZTIa1TcB4xuab/owmic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giCvMomQ2CEFiR3KZe5+Xh/7E5cZxMI5+grhBZ6jnXXH+IkuRlTV7Gch2e9EUlPx3NJaKBDBRTjKTIbf821n8UiLqRHnrjQvlnI6uys98DJvk0c/sPCXOEinr7pZqnP9fTvxsxa/IFdYPaQjED1ZbxqaTL5BaJ+KeXvyMdBlXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mES5xr9A; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mES5xr9A"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711398897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJU0x073KLBv0l2TCljMp+bxfJbOy8hZnj5YjL35PxA=;
	b=mES5xr9AGENSi8J+Ibpkz1oUo7GkkpqdZmpIgcQH2+Xqn80cjPJhInG81wJs0e1k1vAcRb
	gyUgW7JGzykTU6iT9J9mSVPk2Zg2VEJAlylYB6iMZCwRkvGsgMX21SGUUUbzUfUH5eqjw6
	9RKBVoNgmN/ZYi8MDcO9MhOegFoCzwPJ9vm3Cow3YUwQB7OSFOqQr3fw+7nOXoWftnX2Ui
	U5AIWKo4TOVSl80WIGLrdLMw5qXWNXpr/o2nEPFfncMrWlSLm6S4Q7ej40DYdDcOE/SxDM
	4uFW+z0/9eZaMWOpCB8ETcx9GwV002fSZzEGGeRzRiCATHSPVUEUIglZSc5LUw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	jn.avila@free.fr
Subject: [PATCH v3 3/3] grep docs: describe --no-index further and improve formatting a bit
Date: Mon, 25 Mar 2024 21:34:53 +0100
Message-Id: <41f0f16948b231316c0f23cc77747339450acb87.1711398665.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711398665.git.dsimic@manjaro.org>
References: <cover.1711398665.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Improve the description of --no-index, to make it more clear to the users
what this option actually does under the hood, and what's its purpose.
Describe the dependency between --no-index and either of the --cached and
--untracked options, which cannot be used together.

As part of that, shuffle a couple of the options, to make the documentation
flow a bit better, because it makes more sense to describe first the options
that have something in common, and to after that describe an option that does
something differently.  In more detail, --cached and --untracked both leave
git-grep(1) in the usual state, in which it treats the directory as a local
git repository, unlike --no-index that makes git-grep(1) treat the directory
not as a git repository.

While there, improve the descriptions of grep worker threads a bit, to give
them better context.  Adjust the language a bit, to avoid addressing the
reader directly, which is in general preferred in technical documentation,
because it eliminates the possible element of persuading the user to do
something.  In other words, we should be telling the user what our software
can do, instead of telling the user what to do.

Also perform some minor formatting improvements, to make it clear it's the
git commands, command parameters, and configuration option names.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v3:
        - Removed references to speedups caused by multi-threaded searches,
          as pointed out by Junio, [1] because it all depends on the actual
          workloads and the actual system I/O speed and CPU power
        - One of the removed references replaced with a reference to pathspec
          patterns, which is a more suitable example of the benefits
    
    Changes in v2:
        - Improved the patch description a bit, to make it more clear why
          this patch shuffles some of the options around, and why it changes
          some of the wording to passive voice
        - Reworded the description of --no-index a bit, to not mention the
          name of the utility we're describing, which avoids any possible
          confusion, as pointed out by Jean-Noel Avila [2]
    
    This patch is salvaged from my earlier series, [3] for which it has been
    concluded to be not acceptable for merging, because of possible issues
    with various git scripts. [4]
    
    Compared to the version in the earlier series, this version continues
    the effort to improve the description of --no-index, by also incorporating
    the possible improvements pointed out by Junio. [5]  This version also
    improves the wording of some related descriptions, mainly related to
    grep.threads, and performs some additional small formatting improvements.
    
    [1] https://lore.kernel.org/git/xmqqa5mmjf2f.fsf@gitster.g/
    [2] https://lore.kernel.org/git/ed050f2d496a6db07e698fd2f1094b81@manjaro.org/
    [3] https://lore.kernel.org/git/cover.1710781235.git.dsimic@manjaro.org/T/#u
    [4] https://lore.kernel.org/git/d8475579f014a90b27efaf6207bc6fb0@manjaro.org/
    [5] https://lore.kernel.org/git/xmqqwmpzrqfv.fsf@gitster.g/

 Documentation/git-grep.txt | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index f64f40e9775a..1e6d7b65c84e 100644
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
@@ -45,13 +45,21 @@ OPTIONS
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
+	is rather similar to running the regular `grep(1)` utility with its
+	`-r` option specified, but with some additional benefits, such as
+	using pathspec patterns to limit paths;  see the 'pathspec' entry
+	in linkgit:gitglossary[7] for more information.
++
+This option cannot be used together with `--cached` or `--untracked`.
+See also `grep.fallbackToNoIndex` in 'CONFIGURATION' below.
+
 --no-exclude-standard::
 	Also search in ignored files by not honoring the `.gitignore`
 	mechanism. Only useful with `--untracked`.
@@ -248,8 +256,8 @@ providing this option will cause it to die.
 	a non-zero status.
 
 --threads <num>::
-	Number of grep worker threads to use.
-	See `grep.threads` in 'CONFIGURATION' for more information.
+	Number of `grep` worker threads to use.  See 'NOTES ON THREADS'
+	and `grep.threads` in 'CONFIGURATION' for more information.
 
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
