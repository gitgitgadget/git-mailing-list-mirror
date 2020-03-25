Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF644C2D0E9
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C9E20740
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFeC7SGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgCYTcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:32:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39562 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCYTcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:32:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so4061670edf.6
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sr3m8Pp/NkrxO1hh0nV2VGU1qCO/q0rrj0QkxcNQzfs=;
        b=aFeC7SGM1XoKV6P2LqFTh14VEvQHtE1j95LkZnOuAZz80eZeDRF/KrPEy7jXMNG5u7
         84SNPhK89VDEyj46NpnttJjhwZGHXMiRkBIxgOMthVzkNCu4ptN6DpKh73x6sjfonTRH
         iBpQVKPmuLp2G55spGkZ4e1swX4nnBOZ7/nowR8HBlA5LzVSwxgxJnhY35u0HmLL0BzA
         s1WgM3aNRTaa1wo8zDHPLvbtQAj4YdC+qHqC9i66WF+EhQ4k59qr+H5P5wOU5D/6Aby+
         s8GWc9ARXQJfKYOBV4gCgWyoGIf3sjU1CCFhaQg9RlaQYSVVihAJ7Ozz+9A3gocEb2NC
         8rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sr3m8Pp/NkrxO1hh0nV2VGU1qCO/q0rrj0QkxcNQzfs=;
        b=lE13WQ28pzs+6+GuPdZ3PpuP6wNIxLwpi+CAhHrO26M0kAQCWpFLhO6X3gS+tvDQl3
         Z+kmOJfXqk6Hd2OGM+F5GVQviyqFdXet9cCwJCx20+Pu8uRobJkDiFbCp45w6sDnpelV
         B7ZFUGMdtZJK2LkmhRT2OJCQjjYljgGeSIsfCpw8u5hN5FVEncrWu9F37ZVBXrYOBdc8
         aZJMiYoSQvCQ2yd4/R7yi4ih9ZnM7iWVeiBxPKAk4hMUqIMaP7WTw8SnMp5yYB2mfR6N
         yYg0N417F4Gfrb+MInJbwNX2VmjpobcHw7C2bmZptG4KZ7LDmkCiOI1U/xgeinGsQowT
         tcNw==
X-Gm-Message-State: ANhLgQ16khr2D8yPxmqZ50cpw+e1Lzjwdlf2dMTn6b3q4MG58T7pACtq
        Ycm+abAHwcq+j0SeJW6+MoITLUBf
X-Google-Smtp-Source: ADFU+vs84q3809nGToKUs37X0BNPLe0ooW2C3V80NvrUnu7gI55HdbYQKFRSa+RDHVDzEOK1F+p0Bg==
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr4528069ejb.63.1585164724979;
        Wed, 25 Mar 2020 12:32:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qx15sm181093ejb.11.2020.03.25.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:32:04 -0700 (PDT)
Message-Id: <6cfca619e2c5bc37d1847d49496d1be42f4061ce.1585164718.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
        <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 19:31:57 +0000
Subject: [PATCH v3 7/7] dir: replace exponential algorithm with a linear one,
 fix untracked cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

dir's read_directory_recursive() naturally operates recursively in order
to walk the directory tree.  Treating of directories is sometimes weird
because there are so many different permutations about how to handle
directories.  Some examples:

   * 'git ls-files -o --directory' only needs to know that a directory
     itself is untracked; it doesn't need to recurse into it to see what
     is underneath.

   * 'git status' needs to recurse into an untracked directory, but only
     to determine whether or not it is empty.  If there are no files
     underneath, the directory itself will be omitted from the output.
     If it is not empty, only the directory will be listed.

   * 'git status --ignored' needs to recurse into untracked directories
     and report all the ignored entries and then report the directory as
     untracked -- UNLESS all the entries under the directory are
     ignored, in which case we don't print any of the entries under the
     directory and just report the directory itself as ignored.  (Note
     that although this forces us to walk all untracked files underneath
     the directory as well, we strip them from the output, except for
     users like 'git clean' who also set DIR_KEEP_TRACKED_CONTENTS.)

   * For 'git clean', we may need to recurse into a directory that
     doesn't match any specified pathspecs, if it's possible that there
     is an entry underneath the directory that can match one of the
     pathspecs.  In such a case, we need to be careful to omit the
     directory itself from the list of paths (see commit 404ebceda01c
     ("dir: also check directories for matching pathspecs", 2019-09-17))

Part of the tension noted above is that the treatment of a directory can
change based on the files within it, and based on the various settings
in dir->flags.  Trying to keep this in mind while reading over the code,
it is easy to think in terms of "treat_directory() tells us what to do
with a directory, and read_directory_recursive() is the thing that
recurses".  Since we need to look into a directory to know how to treat
it, though, it is quite easy to decide to (also) recurse into the
directory from treat_directory() by adding a read_directory_recursive()
call.  Adding such a call is actually fine, IF we make sure that
read_directory_recursive() does not also recurse into that same
directory.

Unfortunately, commit df5bcdf83aeb ("dir: recurse into untracked dirs
for ignored files", 2017-05-18), added exactly such a case to the code,
meaning we'd have two calls to read_directory_recursive() for an
untracked directory.  So, if we had a file named
   one/two/three/four/five/somefile.txt
and nothing in one/ was tracked, then 'git status --ignored' would
call read_directory_recursive() twice on the directory 'one/', and
each of those would call read_directory_recursive() twice on the
directory 'one/two/', and so on until read_directory_recursive() was
called 2^5 times for 'one/two/three/four/five/'.

Avoid calling read_directory_recursive() twice per level by moving a
lot of the special logic into treat_directory().

Since dir.c is somewhat complex, extra cruft built up around this over
time.  While trying to unravel it, I noticed several instances where the
first call to read_directory_recursive() would return e.g.
path_untracked for some directory and a later one would return e.g.
path_none, despite the fact that the directory clearly should have been
considered untracked.  The code happened to work due to the side-effect
from the first invocation of adding untracked entries to dir->entries;
this allowed it to get the correct output despite the supposed override
in return value by the later call.

I am somewhat concerned that there are still bugs and maybe even
testcases with the wrong expectation.  I have tried to carefully
document treat_directory() since it becomes more complex after this
change (though much of this complexity came from elsewhere that probably
deserved better comments to begin with).  However, much of my work felt
more like a game of whackamole while attempting to make the code match
the existing regression tests than an attempt to create an
implementation that matched some clear design.  That seems wrong to me,
but the rules of existing behavior had so many special cases that I had
a hard time coming up with some overarching rules about what correct
behavior is for all cases, forcing me to hope that the regression tests
are correct and sufficient.  Such a hope seems likely to be ill-founded,
given my experience with dir.c-related testcases in the last few months:

  Examples where the documentation was hard to parse or even just wrong:
   * 3aca58045f4f (git-clean.txt: do not claim we will delete files with
                   -n/--dry-run, 2019-09-17)
   * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
                   repository, 2019-09-17)
   * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
  Examples where testcases were declared wrong and changed:
   * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
                   repository, 2019-09-17)
   * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
   * a2b13367fe55 (Revert "dir.c: make 'git-status --ignored' work within
                   leading directories", 2019-12-10)
  Examples where testcases were clearly inadequate:
   * 502c386ff944 (t7300-clean: demonstrate deleting nested repo with an
                   ignored file breakage, 2019-08-25)
   * 7541cc530239 (t7300: add testcases showing failure to clean specified
                   pathspecs, 2019-09-17)
   * a5e916c7453b (dir: fix off-by-one error in match_pathspec_item,
                   2019-09-17)
   * 404ebceda01c (dir: also check directories for matching pathspecs,
                   2019-09-17)
   * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
                   repository, 2019-09-17)
   * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
   * 452efd11fbf6 (t3011: demonstrate directory traversal failures,
                   2019-12-10)
   * b9670c1f5e6b (dir: fix checks on common prefix directory, 2019-12-19)
  Examples where "correct behavior" was unclear to everyone:
    https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
  Other commits of note:
   * 902b90cf42bc (clean: fix theoretical path corruption, 2019-09-17)

However, on the positive side, it does make the code much faster.  For
the following simple shell loop in an empty repository:

  for depth in $(seq 10 25)
  do
    dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
    rm -rf dir
    mkdir -p $dirs
    >$dirs/untracked-file
    /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
  done

I saw the following timings, in seconds (note that the numbers are a
little noisy from run-to-run, but the trend is very clear with every
run):

    10: 0.03
    11: 0.05
    12: 0.08
    13: 0.19
    14: 0.29
    15: 0.50
    16: 1.05
    17: 2.11
    18: 4.11
    19: 8.60
    20: 17.55
    21: 33.87
    22: 68.71
    23: 140.05
    24: 274.45
    25: 551.15

For the above run, using strace I can look for the number of untracked
directories opened and can verify that it matches the expected
2^($depth+1)-2 (the sum of 2^1 + 2^2 + 2^3 + ... + 2^$depth).

After this fix, with strace I can verify that the number of untracked
directories that are opened drops to just $depth, and the timings all
drop to 0.00.  In fact, it isn't until a depth of 190 nested directories
that it sometimes starts reporting a time of 0.01 seconds and doesn't
consistently report 0.01 seconds until there are 240 nested directories.
The previous code would have taken
  17.55 * 2^220 / (60*60*24*365) = 9.4 * 10^59 YEARS
to have completed the 240 nested directories case.  It's not often
that you get to speed something up by a factor of 3*10^69.

Finally, this also fixes the untracked cache, as noted by the test fixes
in t7063.  Unfortunately, it does so by passing stop_at_first_file to
close_cached_dir() in order to disable the caching of whether
directories were empty (this caching was only relevant for directories
that we knew we didn't need to walk all the entries under but just
needed to know whether the directory had any entries within it in order
to know if the directory itself should be marked as path_none or
path_untracked).  I'm not convinced that disabling the is-the-dir-empty
check is necessary; there is probably some way to still cache that and
not get erroneous results.  However, I have not figured out how to do
so.  If I revert the change to close_cached_dir() in this patch (thus
continuing to cache cases where stop_at_first_file is true meaning we
continue to cache whether directories are empty), then the untracked
cache breakage in t7063 becomes more prevalant.  With my change to
close_cached_dir() and the other changes to avoid traversing directories
2^n times in this patch, I not only avoid making the untracked_cache
breakage in t7063 worse but actually fix the existing breakage.  Update
the test results in t7063 to no longer expect check_only cache entries,
to reflect that we have to do a bit more work in terms of how many
directories we have to open, and to reflect that we fixed the 1/3 of
tests that were broken in that testsuite.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                             | 157 ++++++++++++++++++++----------
 t/t7063-status-untracked-cache.sh | 100 ++++++-------------
 2 files changed, 138 insertions(+), 119 deletions(-)

diff --git a/dir.c b/dir.c
index d9bcb7e19b6..803e2851964 100644
--- a/dir.c
+++ b/dir.c
@@ -1659,7 +1659,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int baselen, int excluded,
 	const struct pathspec *pathspec)
 {
-	int nested_repo = 0;
+	/*
+	 * WARNING: From this function, you can return path_recurse or you
+	 *          can call read_directory_recursive() (or neither), but
+	 *          you CAN'T DO BOTH.
+	 */
+	enum path_treatment state;
+	int nested_repo = 0, old_ignored_nr, stop_early;
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
 
@@ -1711,18 +1717,101 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	/* This is the "show_other_directories" case */
 
-	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+	/*
+	 * We only need to recurse into untracked/ignored directories if
+	 * either of the following bits is set:
+	 *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
+	 *                           there are ignored directories below)
+	 *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
+	 *                                 the directory is empty)
+	 */
+	if (!(dir->flags & (DIR_SHOW_IGNORED_TOO | DIR_HIDE_EMPTY_DIRECTORIES)))
 		return excluded ? path_excluded : path_untracked;
 
+	/*
+	 * If we only want to determine if dirname is empty, then we can
+	 * stop at the first file we find underneath that directory rather
+	 * than continuing to recurse beyond it.  If DIR_SHOW_IGNORED_TOO
+	 * is set, then we want MORE than just determining if dirname is
+	 * empty.
+	 */
+	stop_early = ((dir->flags & DIR_HIDE_EMPTY_DIRECTORIES) &&
+		      !(dir->flags & DIR_SHOW_IGNORED_TOO));
+
+	/*
+	 * If /every/ file within an untracked directory is ignored, then
+	 * we want to treat the directory as ignored (for e.g. status
+	 * --porcelain), without listing the individual ignored files
+	 * underneath.  To do so, we'll save the current ignored_nr, and
+	 * pop all the ones added after it if it turns out the entire
+	 * directory is ignored.
+	 */
+	old_ignored_nr = dir->ignored_nr;
+
+	/* Actually recurse into dirname now, we'll fixup the state later. */
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
+	state = read_directory_recursive(dir, istate, dirname, len, untracked,
+					 stop_early, stop_early, pathspec);
+
+	/* There are a variety of reasons we may need to fixup the state... */
+	if (state == path_excluded) {
+		int i;
+
+		/*
+		 * When stop_early is set, read_directory_recursive() will
+		 * never return path_untracked regardless of whether
+		 * underlying paths were untracked or ignored (because
+		 * returning early means it excluded some paths, or
+		 * something like that -- see commit 5aaa7fd39aaf ("Improve
+		 * performance of git status --ignored", 2017-09-18)).
+		 * However, we're not really concerned with the status of
+		 * files under the directory, we just wanted to know
+		 * whether the directory was empty (state == path_none) or
+		 * not (state == path_excluded), and if not, we'd return
+		 * our original status based on whether the untracked
+		 * directory matched an exclusion pattern.
+		 */
+		if (stop_early)
+			state = excluded ? path_excluded : path_untracked;
+
+		else {
+			/*
+			 * When
+			 *     !stop_early && state == path_excluded
+			 * then all paths under dirname were ignored.  For
+			 * this case, git status --porcelain wants to just
+			 * list the directory itself as ignored and not
+			 * list the individual paths underneath.  Remove
+			 * the individual paths underneath.
+			 */
+			for (i = old_ignored_nr + 1; i<dir->ignored_nr; ++i)
+				free(dir->ignored[i]);
+			dir->ignored_nr = old_ignored_nr;
+		}
+	}
 
 	/*
-	 * If this is an excluded directory, then we only need to check if
-	 * the directory contains any files.
+	 * If there is nothing under the current directory and we are not
+	 * hiding empty directories, then we need to report on the
+	 * untracked or ignored status of the directory itself.
 	 */
-	return read_directory_recursive(dir, istate, dirname, len,
-					untracked, 1, excluded, pathspec);
+	if (state == path_none && !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+		state = excluded ? path_excluded : path_untracked;
+
+	/*
+	 * We can recurse into untracked directories that don't match any
+	 * of the given pathspecs when some file underneath the directory
+	 * might match one of the pathspecs.  If so, we should make sure
+	 * to note that the directory itself did not match.
+	 */
+	if (pathspec &&
+	    !match_pathspec(istate, pathspec, dirname, len,
+			    0 /* prefix */, NULL,
+			    0 /* do NOT special case dirs */))
+		state = path_none;
+
+	return state;
 }
 
 /*
@@ -1870,6 +1959,11 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   int baselen,
 					   const struct pathspec *pathspec)
 {
+	/*
+	 * WARNING: From this function, you can return path_recurse or you
+	 *          can call read_directory_recursive() (or neither), but
+	 *          you CAN'T DO BOTH.
+	 */
 	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
 		strbuf_addstr(path, cdir->file);
@@ -2102,7 +2196,7 @@ static int read_cached_dir(struct cached_dir *cdir)
 	return -1;
 }
 
-static void close_cached_dir(struct cached_dir *cdir)
+static void close_cached_dir(struct cached_dir *cdir, int stop_at_first_file)
 {
 	if (cdir->fdir)
 		closedir(cdir->fdir);
@@ -2110,7 +2204,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 	 * We have gone through this directory and found no untracked
 	 * entries. Mark it valid.
 	 */
-	if (cdir->untracked) {
+	if (!stop_at_first_file && cdir->untracked) {
 		cdir->untracked->valid = 1;
 		cdir->untracked->recurse = 1;
 	}
@@ -2175,14 +2269,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	int stop_at_first_file, const struct pathspec *pathspec)
 {
 	/*
-	 * WARNING WARNING WARNING:
-	 *
-	 * Any updates to the traversal logic here may need corresponding
-	 * updates in treat_leading_path().  See the commit message for the
-	 * commit adding this warning as well as the commit preceding it
-	 * for details.
+	 * WARNING: Do NOT recurse unless path_recurse is returned from
+	 *          treat_path().  Recursing on any other return value
+	 *          can result in exponential slowdown.
 	 */
-
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
 	struct strbuf path = STRBUF_INIT;
@@ -2204,13 +2294,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if ((state == path_recurse) ||
-			((state == path_untracked) &&
-			 (resolve_dtype(cdir.d_type, istate, path.buf, path.len) == DT_DIR) &&
-			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
-			  (pathspec &&
-			   do_match_pathspec(istate, pathspec, path.buf, path.len,
-					     baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)))) {
+		if (state == path_recurse) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
@@ -2266,7 +2350,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 						    istate, &path, baselen,
 						    pathspec, state);
 	}
-	close_cached_dir(&cdir);
+	close_cached_dir(&cdir, stop_at_first_file);
  out:
 	strbuf_release(&path);
 
@@ -2294,15 +2378,6 @@ static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
 {
-	/*
-	 * WARNING WARNING WARNING:
-	 *
-	 * Any updates to the traversal logic here may need corresponding
-	 * updates in read_directory_recursive().  See 777b420347 (dir:
-	 * synchronize treat_leading_path() and read_directory_recursive(),
-	 * 2019-12-19) and its parent commit for details.
-	 */
-
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf subdir = STRBUF_INIT;
 	int prevlen, baselen;
@@ -2353,23 +2428,7 @@ static int treat_leading_path(struct dir_struct *dir,
 		strbuf_reset(&subdir);
 		strbuf_add(&subdir, path+prevlen, baselen-prevlen);
 		cdir.d_name = subdir.buf;
-		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
-				    pathspec);
-		if (state == path_untracked &&
-		    resolve_dtype(cdir.d_type, istate, sb.buf, sb.len) == DT_DIR &&
-		    (dir->flags & DIR_SHOW_IGNORED_TOO ||
-		     do_match_pathspec(istate, pathspec, sb.buf, sb.len,
-				       baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)) {
-			if (!match_pathspec(istate, pathspec, sb.buf, sb.len,
-					    0 /* prefix */, NULL,
-					    0 /* do NOT special case dirs */))
-				state = path_none;
-			add_path_to_appropriate_result_list(dir, NULL, &cdir,
-							    istate,
-							    &sb, baselen,
-							    pathspec, state);
-			state = path_recurse;
-		}
+		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen, pathspec);
 
 		if (state != path_recurse)
 			break; /* do not recurse into it */
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 41705ec1526..72b6877837b 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -84,10 +84,6 @@ dthree/
 dtwo/
 three
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-three
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 
 test_expect_success 'status first time (empty cache)' '
@@ -147,10 +143,10 @@ A  two
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 0
 directory invalidation: 1
-opendir: 1
+opendir: 3
 EOF
 	test_cmp ../trace.expect ../trace
 
@@ -169,10 +165,6 @@ dtwo/
 four
 three
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-three
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -194,7 +186,7 @@ A  two
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 1
 directory invalidation: 1
 opendir: 4
@@ -216,15 +208,11 @@ dthree/
 dtwo/
 three
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-three
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_failure 'new info/exclude invalidates everything' '
+test_expect_success 'new info/exclude invalidates everything' '
 	avoid_racy &&
 	echo three >>.git/info/exclude &&
 	: >../trace &&
@@ -240,7 +228,7 @@ A  two
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 1
 directory invalidation: 0
 opendir: 4
@@ -248,7 +236,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'verify untracked cache dump' '
+test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -260,9 +248,6 @@ flags 00000006
 dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -277,14 +262,11 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_failure 'status after the move' '
+test_expect_success 'status after the move' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
@@ -298,15 +280,15 @@ A  one
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 0
 directory invalidation: 0
-opendir: 1
+opendir: 3
 EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'verify untracked cache dump' '
+test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -319,9 +301,6 @@ dthree/
 dtwo/
 two
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -336,14 +315,11 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_failure 'status after the move' '
+test_expect_success 'status after the move' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
@@ -357,15 +333,15 @@ A  two
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 0
 directory invalidation: 0
-opendir: 1
+opendir: 3
 EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'verify untracked cache dump' '
+test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -377,9 +353,6 @@ flags 00000006
 dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -392,7 +365,7 @@ test_expect_success 'set up for sparse checkout testing' '
 	git commit -m "first commit"
 '
 
-test_expect_failure 'status after commit' '
+test_expect_success 'status after commit' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
@@ -403,15 +376,15 @@ test_expect_failure 'status after commit' '
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 0
 directory invalidation: 0
-opendir: 2
+opendir: 4
 EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'untracked cache correct after commit' '
+test_expect_success 'untracked cache correct after commit' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -423,9 +396,6 @@ flags 00000006
 dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -450,7 +420,7 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	sync_mtime
 '
 
-test_expect_failure 'test sparse status with untracked cache' '
+test_expect_success 'test sparse status with untracked cache' '
 	: >../trace &&
 	avoid_racy &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -464,15 +434,15 @@ test_expect_failure 'test sparse status with untracked cache' '
 EOF
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
+node creation: 2
 gitignore invalidation: 1
 directory invalidation: 2
-opendir: 2
+opendir: 4
 EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'untracked cache correct after status' '
+test_expect_success 'untracked cache correct after status' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -485,14 +455,11 @@ dthree/
 dtwo/
 /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
 five
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_failure 'test sparse status again with untracked cache' '
+test_expect_success 'test sparse status again with untracked cache' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -520,7 +487,7 @@ test_expect_success 'set up for test of subdir and sparse checkouts' '
 	echo "sub" > done/sub/sub/file
 '
 
-test_expect_failure 'test sparse status with untracked cache and subdir' '
+test_expect_success 'test sparse status with untracked cache and subdir' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -543,7 +510,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'verify untracked cache dump (sparse/subdirs)' '
+test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -557,18 +524,11 @@ dtwo/
 /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
 five
 sub/
-/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
-sub/
-/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
-file
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect-from-test-dump ../actual
 '
 
-test_expect_failure 'test sparse status again with untracked cache and subdir' '
+test_expect_success 'test sparse status again with untracked cache and subdir' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -583,7 +543,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_failure 'move entry in subdir from untracked to cached' '
+test_expect_success 'move entry in subdir from untracked to cached' '
 	git add dtwo/two &&
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
@@ -597,7 +557,7 @@ EOF
 	test_cmp ../status.expect ../status.actual
 '
 
-test_expect_failure 'move entry in subdir from cached to untracked' '
+test_expect_success 'move entry in subdir from cached to untracked' '
 	git rm --cached dtwo/two &&
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
@@ -624,7 +584,7 @@ test_expect_success 'git status does not change anything' '
 	test_cmp ../expect-no-uc ../actual
 '
 
-test_expect_failure 'setting core.untrackedCache to true and using git status creates the cache' '
+test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
 	git config core.untrackedCache true &&
 	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual &&
@@ -657,7 +617,7 @@ test_expect_success 'using --untracked-cache does not fail when core.untrackedCa
 	test_cmp ../expect-empty ../actual
 '
 
-test_expect_failure 'setting core.untrackedCache to keep' '
+test_expect_success 'setting core.untrackedCache to keep' '
 	git config core.untrackedCache keep &&
 	git update-index --untracked-cache &&
 	test-tool dump-untracked-cache >../actual &&
-- 
gitgitgadget
