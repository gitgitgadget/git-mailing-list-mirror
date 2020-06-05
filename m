Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C55C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52DD207F7
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDxmsfnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFESXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgFESXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:23:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CEC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:23:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so10717185wrp.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dKc7kMh9KgB5wvMPhCAHezMoVmPXW+4e3Lq/p6PTjKU=;
        b=lDxmsfnHldAlGbpaRCmMgyxQGqepGaM/fO1KpKU0MwMtuq5slFrwO9ENzdafkl7BFX
         e2SVw8XO8E4finXCG6gAXDf/07mYcO89oZIhpyKQX/N+4+PW53+2Vol3z0h3dDwt8GLc
         GpbGjBYwfDKLejUeOhO/KTdEwETeXzLljOtlp09SlZ5v+8Nwnccxaksq9e8MyOZffWd9
         dvJntisjGeWgEe8zEoDodDzv0gnXiBd7jbbBpPG11J6zkct6YhJYFvEWVatzITE1ew9X
         U/XZyhzqwR/u0o5KKD5I52/43VLPVspNJrnMASuSJssaZzhU9uSexwlKD21W2pSA6s7F
         hMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dKc7kMh9KgB5wvMPhCAHezMoVmPXW+4e3Lq/p6PTjKU=;
        b=fE2cwfXbNoMvlH95Nx40MLdItruYMe1Aw+JiZRV9lOWhSYgBvIIbK/rjf6xUR/42mf
         D4KEi+gLmRDRCZmSRYJ5JFqUGyld7qSMfOn3iCdJEr2GQQ9eHaIKR95RQlS1DXawAQE3
         FuVlBi/PNyEuXqbI+zR+cNhUKdEZ4XoCFMA4BubvFRMqIwVYWdNddaVtnCtym9fjgKH0
         lgSJstOqgAHqUMw2BtEhWkMLSKNNSCbGgUTR/jjAUsMEvRrw6gYLqO2cp8Ahek3fWCp3
         DRT97FzI/0EpMkuHhcdmZhj9KWUe/XYKl9+NuZVtP9GOorLWQRiqoGLXlOPk6KYAnyKe
         5+2w==
X-Gm-Message-State: AOAM530arbbQuNra9AvOyLum6DBMmvjK75TuIquFWNPtiaocCc8UL0GG
        WXoBM8q1P77FHgU3m28LK7YN/jLy
X-Google-Smtp-Source: ABdhPJwynB1JoqGmA3agI+PIjrnnzcBaD1W4acXYNKQkSYDwC1WoQWjbOlkuYW8tlR3c+i+omCGHlQ==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr10684090wrp.354.1591381429303;
        Fri, 05 Jun 2020 11:23:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k21sm13538901wrd.24.2020.06.05.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:23:48 -0700 (PDT)
Message-Id: <pull.803.git.git.1591381428302.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:23:48 +0000
Subject: [PATCH] dir: fix treatment of negated pathspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jmillikin@stripe.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

do_match_pathspec() started life as match_pathspec_depth_1() and for
correctness was only supposed to be called from match_pathspec_depth().
match_pathspec_depth() was later renamed to match_pathspec(), so the
invariant we expect today is that do_match_pathspec() has no direct
callers outside of match_pathspec().

Unfortunately, this intention was lost with the renames of the two
functions, and additional calls to do_match_pathspec() were added in
commits 75a6315f74 ("ls-files: add pathspec matching for submodules",
2016-10-07) and 89a1f4aaf7 ("dir: if our pathspec might match files
under a dir, recurse into it", 2019-09-17).  Of course,
do_match_pathspec() had an important advantge over match_pathspec() --
match_pathspec() would hardcode flags to one of two values, and these
new callers needed to pass some other value for flags.  Also, although
calling do_match_pathspec() directly was incorrect, there likely wasn't
any difference in the observable end output, because the bug just meant
that fill_diretory() would recurse into unneeded directories.  Since
subsequent does-this-path-match checks on individual paths under the
directory would cause those extra paths to be filtered out, the only
difference from using the wrong function was unnecessary computation.

The second of those bad calls to do_match_pathspec() was involved -- via
either direct movement or via copying+editing -- into a number of later
refactors.  See commits 777b420347 ("dir: synchronize
treat_leading_path() and read_directory_recursive()", 2019-12-19),
8d92fb2927 ("dir: replace exponential algorithm with a linear one",
2020-04-01), and 95c11ecc73 ("Fix error-prone fill_directory() API; make
it only return matches", 2020-04-01).  The last of those introduced the
usage of do_match_pathspec() on an individual file, and thus resulted in
individual paths being returned that shouldn't be.

The problem with calling do_match_pathspec() instead of match_pathspec()
is that any negated patterns such as ':!unwanted_path` will be ignored.
Add a new match_pathspec_with_flags() function to fulfill the needs of
specifying special flags while still correctly checking negated
patterns, add a big comment above do_match_pathspec() to prevent others
from misusing it, and correct current callers of do_match_pathspec() to
instead use either match_pathspec() or match_pathspec_with_flags().

One final note is that DO_MATCH_LEADING_PATHSPEC needs special
consideration when working with DO_MATCH_EXCLUDE.  The point of
DO_MATCH_LEADING_PATHSPEC is that if we have a pathspec like
   */Makefile
and we are checking a directory path like
   src/module/component
that we want to consider it a match so that we recurse into the
directory because it _might_ have a file named Makefile somewhere below.
However, when we are using an exclusion pattern, i.e. we have a pathspec
like
   :(exclude)*/Makefile
we do NOT want to say that a directory path like
   src/module/component
is a (negative) match.  While there *might* be a file named 'Makefile'
somewhere below that directory, there could also be other files and we
cannot pre-emptively rule all the files under that directory out; we
need to recurse and then check individual files.  Adjust the
DO_MATCH_LEADING_PATHSPEC logic to only get activated for positive
pathspecs.

Reported-by: John Millikin <jmillikin@stripe.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    dir: fix treatment of negated pathspecs
    
    The issue reported by John is fixed by just changing treat_path()'s
    do_match_pathspec() call to match_pathspec(), but the report caused me
    to dig up some history and audit all the other do_match_pathspec() calls
    once I found that out. This patch tries to carefully explain the
    problems, fixes all the loose ends I found, and also tries to prevent
    similar mistakes from being made in the future.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-803%2Fnewren%2Fnegated-pathspecs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-803/newren/negated-pathspecs-v1
Pull-Request: https://github.com/git/git/pull/803

 dir.c                       | 50 ++++++++++++++++++++++++-------------
 t/t6132-pathspec-exclude.sh | 33 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index d97e9558489..9ecd349e27d 100644
--- a/dir.c
+++ b/dir.c
@@ -364,7 +364,8 @@ static int match_pathspec_item(const struct index_state *istate,
 		return MATCHED_FNMATCH;
 
 	/* Perform checks to see if "name" is a leading string of the pathspec */
-	if (flags & DO_MATCH_LEADING_PATHSPEC) {
+	if ( (flags & DO_MATCH_LEADING_PATHSPEC) &&
+	    !(flags & DO_MATCH_EXCLUDE)) {
 		/* name is a literal prefix of the pathspec */
 		int offset = name[namelen-1] == '/' ? 1 : 0;
 		if ((namelen < matchlen) &&
@@ -401,6 +402,10 @@ static int match_pathspec_item(const struct index_state *istate,
 }
 
 /*
+ * do_match_pathspec() is meant to ONLY be called by
+ * match_pathspec_with_flags(); calling it directly risks pathspecs
+ * like ':!unwanted_path' being ignored.
+ *
  * Given a name and a list of pathspecs, returns the nature of the
  * closest (i.e. most specific) match of the name to any of the
  * pathspecs.
@@ -486,13 +491,12 @@ static int do_match_pathspec(const struct index_state *istate,
 	return retval;
 }
 
-int match_pathspec(const struct index_state *istate,
-		   const struct pathspec *ps,
-		   const char *name, int namelen,
-		   int prefix, char *seen, int is_dir)
+static int match_pathspec_with_flags(const struct index_state *istate,
+				     const struct pathspec *ps,
+				     const char *name, int namelen,
+				     int prefix, char *seen, unsigned flags)
 {
 	int positive, negative;
-	unsigned flags = is_dir ? DO_MATCH_DIRECTORY : 0;
 	positive = do_match_pathspec(istate, ps, name, namelen,
 				     prefix, seen, flags);
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
@@ -503,6 +507,16 @@ int match_pathspec(const struct index_state *istate,
 	return negative ? 0 : positive;
 }
 
+int match_pathspec(const struct index_state *istate,
+		   const struct pathspec *ps,
+		   const char *name, int namelen,
+		   int prefix, char *seen, int is_dir)
+{
+	unsigned flags = is_dir ? DO_MATCH_DIRECTORY : 0;
+	return match_pathspec_with_flags(istate, ps, name, namelen,
+					 prefix, seen, flags);
+}
+
 /**
  * Check if a submodule is a superset of the pathspec
  */
@@ -511,11 +525,11 @@ int submodule_path_match(const struct index_state *istate,
 			 const char *submodule_name,
 			 char *seen)
 {
-	int matched = do_match_pathspec(istate, ps, submodule_name,
-					strlen(submodule_name),
-					0, seen,
-					DO_MATCH_DIRECTORY |
-					DO_MATCH_LEADING_PATHSPEC);
+	int matched = match_pathspec_with_flags(istate, ps, submodule_name,
+						strlen(submodule_name),
+						0, seen,
+						DO_MATCH_DIRECTORY |
+						DO_MATCH_LEADING_PATHSPEC);
 	return matched;
 }
 
@@ -1757,9 +1771,11 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 * for matching patterns.
 	 */
 	if (pathspec && !excluded) {
-		matches_how = do_match_pathspec(istate, pathspec, dirname, len,
-						0 /* prefix */, NULL /* seen */,
-						DO_MATCH_LEADING_PATHSPEC);
+		matches_how = match_pathspec_with_flags(istate, pathspec,
+							dirname, len,
+							0 /* prefix */,
+							NULL /* seen */,
+							DO_MATCH_LEADING_PATHSPEC);
 		if (!matches_how)
 			return path_none;
 	}
@@ -2191,9 +2207,9 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		if (excluded)
 			return path_excluded;
 		if (pathspec &&
-		    !do_match_pathspec(istate, pathspec, path->buf, path->len,
-				       0 /* prefix */, NULL /* seen */,
-				       0 /* flags */))
+		    !match_pathspec(istate, pathspec, path->buf, path->len,
+				    0 /* prefix */, NULL /* seen */,
+				    0 /* is_dir */))
 			return path_none;
 		return path_untracked;
 	}
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 2462b19ddd3..30328b87f07 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -211,4 +211,37 @@ test_expect_success 't_e_i() exclude case #8' '
 	)
 '
 
+test_expect_success 'grep --untracked PATTERN' '
+	# This test is not an actual test of exclude patterns, rather it
+	# is here solely to ensure that if any tests are inserted, deleted, or
+	# changed above, that we still have untracked files with the expected
+	# contents for the NEXT two tests.
+	cat <<-\EOF >expect-grep &&
+	actual
+	expect
+	sub/actual
+	sub/expect
+	EOF
+	git grep -l --untracked file -- >actual-grep &&
+	test_cmp expect-grep actual-grep
+'
+
+test_expect_success 'grep --untracked PATTERN :(exclude)DIR' '
+	cat <<-\EOF >expect-grep &&
+	actual
+	expect
+	EOF
+	git grep -l --untracked file -- ":(exclude)sub" >actual-grep &&
+	test_cmp expect-grep actual-grep
+'
+
+test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
+	cat <<-\EOF >expect-grep &&
+	actual
+	sub/actual
+	EOF
+	git grep -l --untracked file -- ":(exclude)*expect" >actual-grep &&
+	test_cmp expect-grep actual-grep
+'
+
 test_done

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
