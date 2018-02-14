Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D98F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162363AbeBNSwq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:52:46 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38942 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162296AbeBNSwe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:52:34 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EInDlg002755;
        Wed, 14 Feb 2018 10:52:07 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1yfs779n-1;
        Wed, 14 Feb 2018 10:52:06 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8C5CF2259614;
        Wed, 14 Feb 2018 10:52:06 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 7CA0B2CDEB7;
        Wed, 14 Feb 2018 10:52:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 00/29] Add directory rename detection to git
Date:   Wed, 14 Feb 2018 10:51:37 -0800
Message-Id: <20180214185206.15492-1-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=14 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces directory rename detection to merge-recursive.  =
See
  https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
for the first series (including design considerations, etc.)  This series
continues to depend on en/merge-recursive-fixes in next, at least
contextually.  For the curious, follow-up series and comments can also be
found at
  https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
  https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
  https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
  https://public-inbox.org/git/20171228041352.27880-1-newren@gmail.com/
  https://public-inbox.org/git/20180105202711.24311-1-newren@gmail.com/
  https://public-inbox.org/git/20180130232533.25846-1-newren@gmail.com/

Also, as a reminder, this series fixes a few bugs somewhat as a side effe=
ct:
  * a bug causing dirty files involved in a rename to be overwritten
  * a few memory leaks

Changes since v7 (full tbdiff follows below):
  * Added Stefan's Reviewed-by.
  * Squashed commits introducing new hash structs and associated function=
s
    into the commit that used them to avoid unused function
    warnings/errors.
  * Added or clarified a number of comments where things were unclear
  * Minor stuff:
    * Style (and typo) fixes for commit message and comments
    * Avoiding casting with hash initialization function
    * s/malloc/xmalloc/
    * struct assignment
    * s/20/GIT_MAX_RAWSZ/

Elijah Newren (29):
  directory rename detection: basic testcases
  directory rename detection: directory splitting testcases
  directory rename detection: testcases to avoid taking detection too
    far
  directory rename detection: partially renamed directory
    testcase/discussion
  directory rename detection: files/directories in the way of some
    renames
  directory rename detection: testcases checking which side did the
    rename
  directory rename detection: more involved edge/corner testcases
  directory rename detection: testcases exploring possibly suboptimal
    merges
  directory rename detection: miscellaneous testcases to complete
    coverage
  directory rename detection: tests for handling overwriting untracked
    files
  directory rename detection: tests for handling overwriting dirty files
  merge-recursive: move the get_renames() function
  merge-recursive: introduce new functions to handle rename logic
  merge-recursive: fix leaks of allocated renames and diff_filepairs
  merge-recursive: make !o->detect_rename codepath more obvious
  merge-recursive: split out code for determining diff_filepairs
  merge-recursive: make a helper function for cleanup for handle_renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
  merge-recursive: add computation of collisions due to dir rename &
    merging
  merge-recursive: check for file level conflicts then get new name
  merge-recursive: when comparing files, don't include trees
  merge-recursive: apply necessary modifications for directory renames
  merge-recursive: avoid clobbering untracked files with directory
    renames
  merge-recursive: fix overwriting dirty files involved in renames
  merge-recursive: fix remaining directory rename + dirty overwrite
    cases
  directory rename detection: new testcases showcasing a pair of bugs
  merge-recursive: avoid spurious rename/rename conflict from dir
    renames
  merge-recursive: ensure we write updates for directory-renamed file

 merge-recursive.c                   | 1243 ++++++++++-
 merge-recursive.h                   |   27 +
 strbuf.c                            |   16 +
 strbuf.h                            |   16 +
 t/t3501-revert-cherry-pick.sh       |    2 +-
 t/t6043-merge-rename-directories.sh | 3998 +++++++++++++++++++++++++++++=
++++++
 t/t7607-merge-overwrite.sh          |    2 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 9 files changed, 5197 insertions(+), 115 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

Full tbdiff (the biggest code changes come from commit squashing):

 1: 5ba69c9c7b !  1: 9f1d894d89 directory rename detection: basic testcas=
es
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: basic testcases
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 2: e1d23f7f95 !  2: 36a4b05757 directory rename detection: directory spl=
itting testcases
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: directory splitting testcases
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 3: b10cb49cf9 !  3: 031a835801 directory rename detection: testcases to =
avoid taking detection too far
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: testcases to avoid taking detection =
too far
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 4: ec3ccf0a95 !  4: 5a09b80671 directory rename detection: partially ren=
amed directory testcase/discussion
    @@ -2,6 +2,10 @@
    =20
         directory rename detection: partially renamed directory testcase=
/discussion
        =20
    +    Add a long note about why we are not considering "partial direct=
ory
    +    renames" for the current directory rename detection implementati=
on.
    +   =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
    @@ -40,7 +44,15 @@
     +# path towards crazy corner cases that are far more complex than wh=
at we're
     +# already dealing with.
     +#
    -+# This section contains a test for this partially-renamed-directory=
 case.
    ++# Note that the wording of the rule ("We don't do directory rename
    ++# detection if the directory still exists on both sides of the merg=
e.")
    ++# also excludes "renaming" of a directory into a subdirectory of it=
self
    ++# (e.g. /some/dir/* -> /some/dir/subdir/*).  It may be possible to =
carve
    ++# out an exception for "renaming"-beneath-itself cases without open=
ing
    ++# weird edge/corner cases for other partial directory renames, but =
for now
    ++# we are keeping the rule simple.
    ++#
    ++# This section contains a test for a partially-renamed-directory ca=
se.
     +###################################################################=
########
     +
     +# Testcase 4a, Directory split, with original directory still prese=
nt
 5: da018f1adb !  5: f6f7fe21b4 directory rename detection: files/directo=
ries in the way of some renames
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: files/directories in the way of some=
 renames
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 6: f7ca54e7f2 !  6: f34670c87a directory rename detection: testcases che=
cking which side did the rename
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: testcases checking which side did th=
e rename
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 7: 8ae28f45fe !  7: 0bb552373e directory rename detection: more involved=
 edge/corner testcases
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: more involved edge/corner testcases
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 8: 8d05b8dc10 !  8: e9c6bcb5bf directory rename detection: testcases exp=
loring possibly suboptimal merges
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: testcases exploring possibly subopti=
mal merges
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
 9: 47ffccc86d !  9: 80d1c2807f directory rename detection: miscellaneous=
 testcases to complete coverage
    @@ -8,6 +8,7 @@
         into the previous sections because I didn't want to re-label wit=
h all the
         testcase references.  :-)
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
10: db7d9850c2 ! 10: 90257851c2 directory rename detection: tests for han=
dling overwriting untracked files
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: tests for handling overwriting untra=
cked files
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
11: 0de0a9dfa0 ! 11: e558395fe2 directory rename detection: tests for han=
dling overwriting dirty files
    @@ -2,6 +2,7 @@
    =20
         directory rename detection: tests for handling overwriting dirty=
 files
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
12: 9a6777f577 ! 12: f7ce963690 merge-recursive: move the get_renames() f=
unction
    @@ -2,10 +2,12 @@
    =20
         merge-recursive: move the get_renames() function
        =20
    -    I want to re-use some other functions in the file without moving=
 those
    -    other functions or dealing with a handful of annoying split func=
tion
    -    declarations and definitions.
    +    Move this function so it can re-use some others (without either
    +    moving all of them or adding an annoying split between function
    +    declarations and definitions).  Cheat slightly by adding a blank=
 line
    +    for readability, and in order to silence checkpatch.pl.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
13: ac6a95c7b8 ! 13: 467827818c merge-recursive: introduce new functions =
to handle rename logic
    @@ -16,6 +16,7 @@
         which is used later in process_entry().  Thus the reason for a s=
eparate
         cleanup_renames().
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
14: 76b09d49cd ! 14: 2079029a75 merge-recursive: fix leaks of allocated r=
enames and diff_filepairs
    @@ -8,6 +8,7 @@
         return string_list.  Make sure all of these are deallocated when=
 we
         are done with them.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
15: e4189f3da2 ! 15: 6b5b10e76f merge-recursive: make !o->detect_rename c=
odepath more obvious
    @@ -7,6 +7,7 @@
         iterate over.  It seems more straightforward to simply avoid cal=
ling
         either function in that case.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
16: 6bc800e369 ! 16: 02cf55e49e merge-recursive: split out code for deter=
mining diff_filepairs
    @@ -7,6 +7,7 @@
         get_renames(), I want them to be available to some new functions=
.  No
         actual logic changes yet.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
    @@ -48,10 +49,8 @@
      		o->needed_rename_limit =3D opts.needed_rename_limit;
     -	for (i =3D 0; i < diff_queued_diff.nr; ++i) {
     +
    -+	ret =3D malloc(sizeof(struct diff_queue_struct));
    -+	ret->queue =3D diff_queued_diff.queue;
    -+	ret->nr =3D diff_queued_diff.nr;
    -+	/* Ignore diff_queued_diff.alloc; we won't be changing size at all=
 */
    ++	ret =3D xmalloc(sizeof(*ret));
    ++	*ret =3D diff_queued_diff;
     +
     +	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
     +	diff_queued_diff.nr =3D 0;
17: 0757c92ca1 < --:  ------- merge-recursive: add a new hashmap for stor=
ing directory renames
18: f17343fc2c ! 17: 24f31fa43a merge-recursive: make a helper function f=
or cleanup for handle_renames
    @@ -8,6 +8,7 @@
         helper initial_cleanup_rename(), and leave the big comment in th=
e code
         about why we can't do all the cleanup at once.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
19: 9b63e257c8 ! 18: ae89010bec merge-recursive: add get_directory_rename=
s()
    @@ -2,15 +2,68 @@
    =20
         merge-recursive: add get_directory_renames()
        =20
    -    This populates a list of directory renames for us.  The list of
    -    directory renames is not yet used, but will be in subsequent com=
mits.
    +    This populates a set of directory renames for us.  The set of di=
rectory
    +    renames is not yet used, but will be in subsequent commits.
        =20
    +    Note that the use of a string_list for possible_new_dirs in the =
new
    +    dir_rename_entry struct implies an O(n^2) algorithm; however, in=
 practice
    +    I expect the number of distinct directories that files were rena=
med into
    +    from a single original directory to be O(1).  My guess is that n=
 has a
    +    mode of 1 and a mean of less than 2, so, for now, string_list se=
ems good
    +    enough for possible_new_dirs.
    +   =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
     --- a/merge-recursive.c
     +++ b/merge-recursive.c
     @@
    + 	return ignore_case ? strihash(path) : strhash(path);
    + }
    +=20
    ++static struct dir_rename_entry *dir_rename_find_entry(struct hashma=
p *hashmap,
    ++						      char *dir)
    ++{
    ++	struct dir_rename_entry key;
    ++
    ++	if (dir =3D=3D NULL)
    ++		return NULL;
    ++	hashmap_entry_init(&key, strhash(dir));
    ++	key.dir =3D dir;
    ++	return hashmap_get(hashmap, &key, NULL);
    ++}
    ++
    ++static int dir_rename_cmp(const void *unused_cmp_data,
    ++			  const void *entry,
    ++			  const void *entry_or_key,
    ++			  const void *unused_keydata)
    ++{
    ++	const struct dir_rename_entry *e1 =3D entry;
    ++	const struct dir_rename_entry *e2 =3D entry_or_key;
    ++
    ++	return strcmp(e1->dir, e2->dir);
    ++}
    ++
    ++static void dir_rename_init(struct hashmap *map)
    ++{
    ++	hashmap_init(map, dir_rename_cmp, NULL, 0);
    ++}
    ++
    ++static void dir_rename_entry_init(struct dir_rename_entry *entry,
    ++				  char *directory)
    ++{
    ++	hashmap_entry_init(entry, strhash(directory));
    ++	entry->dir =3D directory;
    ++	entry->non_unique_new_dir =3D 0;
    ++	strbuf_init(&entry->new_dir, 0);
    ++	string_list_init(&entry->possible_new_dirs, 0);
    ++}
    ++
    + static void flush_output(struct merge_options *o)
    + {
    + 	if (o->buffer_output < 2 && o->obuf.len) {
    +@@
      	return ret;
      }
     =20
    @@ -23,12 +76,13 @@
     +	*old_dir =3D NULL;
     +	*new_dir =3D NULL;
     +
    -+	/* For
    -+	 *    "a/b/c/d/foo.c" -> "a/b/something-else/d/foo.c"
    -+	 * the "d/foo.c" part is the same, we just want to know that
    -+	 *    "a/b/c" was renamed to "a/b/something-else"
    -+	 * so, for this example, this function returns "a/b/c" in
    -+	 * *old_dir and "a/b/something-else" in *new_dir.
    ++	/*
    ++	 * For
    ++	 *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
    ++	 * the "e/foo.c" part is the same, we just want to know that
    ++	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
    ++	 * so, for this example, this function returns "a/b/c/d" in
    ++	 * *old_dir and "a/b/some/thing/else" in *new_dir.
     +	 *
     +	 * Also, if the basename of the file changed, we don't care.  We
     +	 * want to know which portion of the directory, if any, changed.
    @@ -76,7 +130,23 @@
     +	struct dir_rename_entry *entry;
     +	int i;
     +
    -+	dir_renames =3D malloc(sizeof(struct hashmap));
    ++	/*
    ++	 * Typically, we think of a directory rename as all files from a
    ++	 * certain directory being moved to a target directory.  However,
    ++	 * what if someone first moved two files from the original
    ++	 * directory in one commit, and then renamed the directory
    ++	 * somewhere else in a later commit?  At merge time, we just know
    ++	 * that files from the original directory went to two different
    ++	 * places, and that the bulk of them ended up in the same place.
    ++	 * We want each directory rename to represent where the bulk of th=
e
    ++	 * files from that directory end up; this function exists to find
    ++	 * where the bulk of the files went.
    ++	 *
    ++	 * The first loop below simply iterates through the list of file
    ++	 * renames, finding out how often each directory rename pair
    ++	 * possibility occurs.
    ++	 */
    ++	dir_renames =3D xmalloc(sizeof(struct hashmap));
     +	dir_rename_init(dir_renames);
     +	for (i =3D 0; i < pairs->nr; ++i) {
     +		struct string_list_item *item;
    @@ -114,6 +184,15 @@
     +		*count +=3D 1;
     +	}
     +
    ++	/*
    ++	 * For each directory with files moved out of it, we find out whic=
h
    ++	 * target directory received the most files so we can declare it t=
o
    ++	 * be the "winning" target location for the directory rename.  Thi=
s
    ++	 * winner gets recorded in new_dir.  If there is no winner
    ++	 * (multiple target directories received the same number of files)=
,
    ++	 * we set non_unique_new_dir.  Once we've determined the winner (o=
r
    ++	 * that there is no winner), we no longer need possible_new_dirs.
    ++	 */
     +	hashmap_iter_init(dir_renames, &iter);
     +	while ((entry =3D hashmap_iter_next(&iter))) {
     +		int max =3D 0;
    @@ -136,8 +215,13 @@
     +			assert(entry->new_dir.len =3D=3D 0);
     +			strbuf_addstr(&entry->new_dir, best);
     +		}
    -+		/* Strings were xstrndup'ed before inserting into string-list,
    -+		 * so ask string_list to remove the entries for us.
    ++		/*
    ++		 * The relevant directory sub-portion of the original full
    ++		 * filepaths were xstrndup'ed before inserting into
    ++		 * possible_new_dirs, and instead of manually iterating the
    ++		 * list and free'ing each, just lie and tell
    ++		 * possible_new_dirs that it did the strdup'ing so that it
    ++		 * will free them for us.
     +		 */
     +		entry->possible_new_dirs.strdup_strings =3D 1;
     +		string_list_clear(&entry->possible_new_dirs, 1);
    @@ -201,3 +285,32 @@
     =20
      	return clean;
      }
    +
    +diff --git a/merge-recursive.h b/merge-recursive.h
    +--- a/merge-recursive.h
    ++++ b/merge-recursive.h
    +@@
    + 	struct string_list df_conflict_file_set;
    + };
    +=20
    ++/*
    ++ * For dir_rename_entry, directory names are stored as a full path =
from the
    ++ * toplevel of the repository and do not include a trailing '/'.  A=
lso:
    ++ *
    ++ *   dir:                original name of directory being renamed
    ++ *   non_unique_new_dir: if true, could not determine new_dir
    ++ *   new_dir:            final name of directory being renamed
    ++ *   possible_new_dirs:  temporary used to help determine new_dir; =
see comments
    ++ *                       in get_directory_renames() for details
    ++ */
    ++struct dir_rename_entry {
    ++	struct hashmap_entry ent; /* must be the first member! */
    ++	char *dir;
    ++	unsigned non_unique_new_dir:1;
    ++	struct strbuf new_dir;
    ++	struct string_list possible_new_dirs;
    ++};
    ++
    + /* merge_trees() but with recursive ancestor consolidation */
    + int merge_recursive(struct merge_options *o,
    + 		    struct commit *h1,
20: 6730d8e7b7 ! 19: 4f36512a02 merge-recursive: check for directory leve=
l conflicts
    @@ -7,6 +7,7 @@
         directory level.  There will be additional checks at the individ=
ual
         file level too, which will be added later.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
    @@ -18,7 +19,7 @@
     =20
     +static int tree_has_path(struct tree *tree, const char *path)
     +{
    -+	unsigned char hashy[20];
    ++	unsigned char hashy[GIT_MAX_RAWSZ];
     +	unsigned int mode_o;
     +
     +	return !get_tree_entry(tree->object.oid.hash, path,
21: 178ec9e079 < --:  ------- merge-recursive: add a new hashmap for stor=
ing file collisions
22: 1f3ff65e82 ! 20: 4a9098fba5 merge-recursive: add computation of colli=
sions due to dir rename & merging
    @@ -7,11 +7,42 @@
         the same (otherwise vacant) location.  Add checking and reportin=
g for such
         cases, falling back to no-directory-rename handling for such pat=
hs.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
     --- a/merge-recursive.c
     +++ b/merge-recursive.c
    +@@
    + 	string_list_init(&entry->possible_new_dirs, 0);
    + }
    +=20
    ++static struct collision_entry *collision_find_entry(struct hashmap =
*hashmap,
    ++						    char *target_file)
    ++{
    ++	struct collision_entry key;
    ++
    ++	hashmap_entry_init(&key, strhash(target_file));
    ++	key.target_file =3D target_file;
    ++	return hashmap_get(hashmap, &key, NULL);
    ++}
    ++
    ++static int collision_cmp(void *unused_cmp_data,
    ++			 const struct collision_entry *e1,
    ++			 const struct collision_entry *e2,
    ++			 const void *unused_keydata)
    ++{
    ++	return strcmp(e1->target_file, e2->target_file);
    ++}
    ++
    ++static void collision_init(struct hashmap *map)
    ++{
    ++	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
    ++}
    ++
    + static void flush_output(struct merge_options *o)
    + {
    + 	if (o->buffer_output < 2 && o->obuf.len) {
     @@
      			       hashy, &mode_o);
      }
    @@ -179,3 +210,21 @@
      					 common, head, merge, entries);
      	clean =3D process_renames(o, ri->head_renames, ri->merge_renames);
     =20
    +
    +diff --git a/merge-recursive.h b/merge-recursive.h
    +--- a/merge-recursive.h
    ++++ b/merge-recursive.h
    +@@
    + 	struct string_list possible_new_dirs;
    + };
    +=20
    ++struct collision_entry {
    ++	struct hashmap_entry ent; /* must be the first member! */
    ++	char *target_file;
    ++	struct string_list source_files;
    ++	unsigned reported_already:1;
    ++};
    ++
    + /* merge_trees() but with recursive ancestor consolidation */
    + int merge_recursive(struct merge_options *o,
    + 		    struct commit *h1,
23: d28651aeb0 ! 21: fd9129379f merge-recursive: check for file level con=
flicts then get new name
    @@ -7,6 +7,7 @@
         file level either.  If there aren't any, then get the new name f=
rom
         any directory renames.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
24: d6f3d47304 ! 22: 94eaf30851 merge-recursive: when comparing files, do=
n't include trees
    @@ -15,6 +15,7 @@
         for a given path on the different sides of the merge, so create =
a
         get_tree_entry_if_blob() helper function and use it.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
25: f91509f9df ! 23: 389b0d6bda merge-recursive: apply necessary modifica=
tions for directory renames
    @@ -6,6 +6,7 @@
         necessary changes to the rename struct, it's dst_entry, and the
         diff_filepair under consideration.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
26: 9d903c98de ! 24: 5a5f25c6e0 merge-recursive: avoid clobbering untrack=
ed files with directory renames
    @@ -2,6 +2,7 @@
    =20
         merge-recursive: avoid clobbering untracked files with directory=
 renames
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
27: 2ab61d26a3 ! 25: 45819be1f8 merge-recursive: fix overwriting dirty fi=
les involved in renames
    @@ -5,9 +5,10 @@
         This fixes an issue that existed before my directory rename dete=
ction
         patches that affects both normal renames and renames implied by
         directory rename detection.  Additional codepaths that only affe=
ct
    -    overwriting of directy files that are involved in directory rena=
me
    +    overwriting of dirty files that are involved in directory rename
         detection will be added in a subsequent commit.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
    @@ -186,7 +187,7 @@
     +	struct unpack_trees_options unpack_opts;
      };
     =20
    - struct dir_rename_entry {
    + /*
    =20
     diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-p=
ick.sh
     --- a/t/t3501-revert-cherry-pick.sh
28: d510c260b7 ! 26: b840086726 merge-recursive: fix remaining directory =
rename + dirty overwrite cases
    @@ -2,6 +2,7 @@
    =20
         merge-recursive: fix remaining directory rename + dirty overwrit=
e cases
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
    @@ -22,8 +23,7 @@
     +			       rename->path);
     +		}
     +		/*
    -+		 * Stupid double negatives in remove_file; it somehow manages
    -+		 * to repeatedly mess me up.  So, just for myself:
    ++		 * Because the double negatives somehow keep confusing me...
     +		 *    1) update_wd iff !ren_src_was_dirty.
     +		 *    2) no_wd iff !update_wd
     +		 *    3) so, no_wd =3D=3D !!ren_src_was_dirty =3D=3D ren_src_was_=
dirty
29: b59a612e68 ! 27: d320f88ef3 directory rename detection: new testcases=
 showcasing a pair of bugs
    @@ -12,6 +12,7 @@
         testcases that showed existing bugs in order to make sure we are=
n't
         merely addressing problems in isolation but in general.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
30: d20b759b63 ! 28: e6574d990c merge-recursive: avoid spurious rename/re=
name conflict from dir renames
    @@ -11,6 +11,7 @@
         previously reported as a rename/delete conflict will now be repo=
rted as a
         modify/delete conflict.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c
31: f69932adfe ! 29: 32446f2578 merge-recursive: ensure we write updates =
for directory-renamed file
    @@ -10,6 +10,7 @@
         Update the code that checks whether we can skip the update to al=
so work in
         the presence of directory renames.
        =20
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/merge-recursive.c b/merge-recursive.c

--=20
2.16.1.232.g28d5be9217
