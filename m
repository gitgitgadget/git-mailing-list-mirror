Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4E8836
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHpy1w++"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941918B
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 04:25:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso1150082f8f.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699010703; x=1699615503; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sNkPfK/JsDA3/aDQ9ymO6ifG4On1wgil2nae/Wb11qE=;
        b=NHpy1w++kMuCPGAddw922K3jvz7/DNB8MXTQhTz41XEQPGP/10ewvggmn6+0Bgr9kA
         XVLWdDw0f1faZ2GiQL1K7RLS2eb40sWwl9oei+5ODYuHJ/kOa9E0/y+8TcQj4ikbk2bi
         e/D24vgivinl7WEjl9VUdiEaIjJeqNdbqPq+j7tKXUMJnSP14DHzTxfL5E+f4FNAka5E
         nkoRfskaH1UKkidh7A0P5Q0BWBm8ovP19+2rOTrbMmWuWWR0LyPwEbW/hK+kqEUT8dx7
         6LX/RUTDfUkxO8Bi3Q5GuiWBMBj/ctc2OoZpcQBDNQaQ3hk9PQ0D8tslxicgZ7LJQtW4
         Zthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010703; x=1699615503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNkPfK/JsDA3/aDQ9ymO6ifG4On1wgil2nae/Wb11qE=;
        b=XDBrCXjIQGa9Mu2t1UBCz2PJNIrXVvTiD4UoVi1A8oZsacZ2B/vJZfS5MxU5pqTaa0
         7ZYtDNxK/27Nsc24XpyHraM9+U5zSlucnrbf17JuKUBk1aj+bMY/uAAQ4dNrK4Ogjilw
         RO7F/VKdhf0hv7S/GiSiCTLZT8OtexjJPqXp3skOJ/ydUfBqC4Mo+T+TFzlm1NIFXYN2
         jlDGu6T2G1itL7TV6DPY8+xjm6vPIAtje3PcSRwxIqrZ+dx+ho3U6vrpYdMfSgbKzErX
         ovHYLS58/o52FApO/ZNbUS6Q0GxNiO1BDXJDl3QoWqvpBe1BXOky7/Nz36yX2+6WTrDd
         JPVQ==
X-Gm-Message-State: AOJu0Yxjg7necRPpjldlNOyFpCSdJB2WH3k4pxk+LQPO/8Fd7eISRgx2
	EW3K0kftm9P4k8P4Ky+toQDupTN7e/c=
X-Google-Smtp-Source: AGHT+IEkSkB4GLiOxEcGIEryEEkVvU4Y5v5JNVV11V94KsWgYJShN4+SfBebncmczEFRNPnuxOVA2w==
X-Received: by 2002:adf:e48a:0:b0:32d:95ef:9281 with SMTP id i10-20020adfe48a000000b0032d95ef9281mr17815333wrm.4.1699010702759;
        Fri, 03 Nov 2023 04:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adffd88000000b0032fbe5b1e45sm55163wrr.61.2023.11.03.04.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:25:02 -0700 (PDT)
Message-ID: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
From: "Sam James via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Nov 2023 11:25:01 +0000
Subject: [PATCH] diff: implement config.diff.renames=copies-harder
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
    Sam James <sam@gentoo.org>

From: Sam James <sam@gentoo.org>

This patch adds a config value for 'diff.renames' called 'copies-harder'
which make it so '-C -C' is in effect always passed for 'git log -p',
'git diff', etc.

This allows specifying that 'git log -p', 'git diff', etc should always act
as if '-C --find-copies-harder' was passed.

I've found this especially useful for certain types of repository (like
Gentoo's ebuild repositories) because files are often copies of a previous
version.

Signed-off-by: Sam James <sam@gentoo.org>
---
    diff: implement config.diff.renames=copies-harder
    
    This patch adds a config value for 'diff.renames' called 'copies-harder'
    which make it so '-C -C' is in effect always passed for 'git log -p',
    'git diff', etc.
    
    This allows specifying that 'git log -p', 'git diff', etc should always
    act as if '-C --find-copies-harder' was passed.
    
    I've found this especially useful for certain types of repository (like
    Gentoo's ebuild repositories) because files are often copies of a
    previous version.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1606%2Fthesamesam%2Fconfig-copies-harder-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1606/thesamesam/config-copies-harder-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1606

 Documentation/config/diff.txt   |  3 ++-
 Documentation/config/status.txt |  3 ++-
 diff.c                          | 12 +++++++++---
 diff.h                          |  1 +
 diffcore-rename.c               |  4 ++--
 merge-ort.c                     |  2 +-
 merge-recursive.c               |  2 +-
 7 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index bd5ae0c3378..d2ff3c62d41 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -131,7 +131,8 @@ diff.renames::
 	Whether and how Git detects renames.  If set to "false",
 	rename detection is disabled. If set to "true", basic rename
 	detection is enabled.  If set to "copies" or "copy", Git will
-	detect copies, as well.  Defaults to true.  Note that this
+	detect copies, as well.  If set to "copies-harder", Git will try harder
+	to detect copies.  Defaults to true.  Note that this
 	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
 	linkgit:git-log[1], and not lower level commands such as
 	linkgit:git-diff-files[1].
diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index 2ff8237f8fc..7ca7a4becd7 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -33,7 +33,8 @@ status.renames::
 	Whether and how Git detects renames in linkgit:git-status[1] and
 	linkgit:git-commit[1] .  If set to "false", rename detection is
 	disabled. If set to "true", basic rename detection is enabled.
-	If set to "copies" or "copy", Git will detect copies, as well.
+	If set to "copies" or "copy", Git will detect copies, as well.  If
+	set to "copies-harder", Git will try harder to detect copies.
 	Defaults to the value of diff.renames.
 
 status.showStash::
diff --git a/diff.c b/diff.c
index 2c602df10a3..0ca906611f5 100644
--- a/diff.c
+++ b/diff.c
@@ -206,8 +206,11 @@ int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
 		return DIFF_DETECT_RENAME;
+	if (!strcasecmp(value, "copies-harder"))
+		return DIFF_DETECT_COPY_HARDER;
 	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
-		return  DIFF_DETECT_COPY;
+		return DIFF_DETECT_COPY;
+
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
@@ -4832,8 +4835,11 @@ void diff_setup_done(struct diff_options *options)
 	else
 		options->flags.diff_from_contents = 0;
 
-	if (options->flags.find_copies_harder)
+	/* Just fold this in as it makes the patch-to-git smaller */
+	if (options->flags.find_copies_harder || options->detect_rename == DIFF_DETECT_COPY_HARDER) {
+		options->flags.find_copies_harder = 1;
 		options->detect_rename = DIFF_DETECT_COPY;
+	}
 
 	if (!options->flags.relative_name)
 		options->prefix = NULL;
@@ -5264,7 +5270,7 @@ static int diff_opt_find_copies(const struct option *opt,
 	if (*arg != 0)
 		return error(_("invalid argument to %s"), opt->long_name);
 
-	if (options->detect_rename == DIFF_DETECT_COPY)
+	if (options->detect_rename == DIFF_DETECT_COPY || options->detect_rename == DIFF_DETECT_COPY_HARDER)
 		options->flags.find_copies_harder = 1;
 	else
 		options->detect_rename = DIFF_DETECT_COPY;
diff --git a/diff.h b/diff.h
index 66bd8aeb293..b29e5b777f8 100644
--- a/diff.h
+++ b/diff.h
@@ -555,6 +555,7 @@ int git_config_rename(const char *var, const char *value);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
+#define DIFF_DETECT_COPY_HARDER 3
 
 #define DIFF_PICKAXE_ALL	1
 #define DIFF_PICKAXE_REGEX	2
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac71..856291d66f2 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -299,7 +299,7 @@ static int find_identical_files(struct hashmap *srcs,
 		}
 		/* Give higher scores to sources that haven't been used already */
 		score = !source->rename_used;
-		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
+		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY && options->detect_rename != DIFF_DETECT_COPY_HARDER)
 			continue;
 		score += basename_same(source, target);
 		if (score > best_score) {
@@ -1405,7 +1405,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
-	want_copies = (detect_rename == DIFF_DETECT_COPY);
+	want_copies = (detect_rename == DIFF_DETECT_COPY || detect_rename == DIFF_DETECT_COPY_HARDER);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
 	if (break_idx && relevant_sources)
diff --git a/merge-ort.c b/merge-ort.c
index 6491070d965..77498354652 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4782,7 +4782,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * sanity check them anyway.
 	 */
 	assert(opt->detect_renames >= -1 &&
-	       opt->detect_renames <= DIFF_DETECT_COPY);
+	       opt->detect_renames <= DIFF_DETECT_COPY_HARDER);
 	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
 	assert(opt->buffer_output <= 2);
 	assert(opt->obuf.len == 0);
diff --git a/merge-recursive.c b/merge-recursive.c
index e3beb0801b1..d52dd536606 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3708,7 +3708,7 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 	assert(opt->branch1 && opt->branch2);
 
 	assert(opt->detect_renames >= -1 &&
-	       opt->detect_renames <= DIFF_DETECT_COPY);
+	       opt->detect_renames <= DIFF_DETECT_COPY_HARDER);
 	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
 	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
 	assert(opt->rename_limit >= -1);

base-commit: 692be87cbba55e8488f805d236f2ad50483bd7d5
-- 
gitgitgadget
