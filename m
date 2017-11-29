Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADDCF20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbdK2Bnu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:50 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58474 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbdK2BnI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:08 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1c8YM003665;
        Tue, 28 Nov 2017 17:42:38 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef69q4mwy-1;
        Tue, 28 Nov 2017 17:42:37 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id CF37F22157C4;
        Tue, 28 Nov 2017 17:42:37 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id C40A02CDF15;
        Tue, 28 Nov 2017 17:42:37 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 00/34] Add directory rename detection to git
Date:   Tue, 28 Nov 2017 17:42:03 -0800
Message-Id: <20171129014237.32570-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g850bc54b15
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=77 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces directory rename detection to merge-recursive.  =
See
  https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
for the first series (including design considerations, etc.), and follow-=
up
series can be found at
  https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
  https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/

Changes since V3:
  * Rebased on latest master (no conflicts, but figured I might as well)
  * Addressed issues mentioned in reviews of V3:
    * Fixed style issues
    * Made use of strbuf (note: new function added to strbuf.[ch] that
      takes a string_list*; is that okay?)
    * Switched strndup to xstrndup for windows
  * Miscellaneous cleanups, perf, etc.:
    * Skip pair early in get_directory_renames() if pair is not a rename
    * Add helper cleanup functions to consolidate some code
    * Make it clear that directory rename detection only operates on
      add ('A') and rename ('R') filepairs

Full tbdiff against V3:
 1: a0abcb1378 =3D  1: d95d5fffea Tighten and correct a few testcases for=
 merging and cherry-picking
 2: e8745c4f1b =3D  2: b177dccc28 merge-recursive: fix logic ordering iss=
ue
 3: 0ae4156994 =3D  3: fe3de710e3 merge-recursive: add explanation for sr=
c_entry and dst_entry
 4: f13686ea6a =3D  4: 19b82b795a directory rename detection: basic testc=
ases
 5: 16e7dea569 =3D  5: 3d23af19e9 directory rename detection: directory s=
plitting testcases
 6: 51d9a5b059 =3D  6: d997681a4d directory rename detection: testcases t=
o avoid taking detection too far
 7: 4b39f6bea3 =3D  7: 152e3d5d81 directory rename detection: partially r=
enamed directory testcase/discussion
 8: 0668e65864 =3D  8: 441211c842 directory rename detection: files/direc=
tories in the way of some renames
 9: fcce655243 =3D  9: c66d3fb8b4 directory rename detection: testcases c=
hecking which side did the rename
10: 04213cc213 =3D 10: 4542c5fee4 directory rename detection: more involv=
ed edge/corner testcases
11: 21992300aa ! 11: 771b551982 directory rename detection: testcases exp=
loring possibly suboptimal merges
    @@ -36,7 +36,7 @@
     +#   Optimal:                  y/{a,b,e},   z/{c,d,f}
     +#
     +# Note: Both x and y got renamed and it'd be nice to detect both, a=
nd we do
    -+# better with directory rename detection than git did previously, b=
ut the
    ++# better with directory rename detection than git did without, but =
the
     +# simple rule from section 5 prevents me from handling this as opti=
mally as
     +# we potentially could.
     +
    @@ -321,9 +321,11 @@
     +#   Commit B: w/{b,c}, z/d
     +#
     +# Possible Resolutions:
    -+#   Previous git: z/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -=
> y/c vs. w/c)
    -+#   Expected:     y/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -=
> y/c vs. w/c)
    -+#   Preferred:    ??
    ++#   w/o dir-rename detection: z/d, CONFLICT(z/b -> y/b vs. w/b),
    ++#                                  CONFLICT(z/c -> y/c vs. w/c)
    ++#   Currently expected:       y/d, CONFLICT(z/b -> y/b vs. w/b),
    ++#                                  CONFLICT(z/c -> y/c vs. w/c)
    ++#   Optimal:                  ??
     +#
     +# Notes: In commit A, directory z got renamed to y.  In commit B, d=
irectory z
     +#        did NOT get renamed; the directory is still present; inste=
ad it is
12: 727238bf64 =3D 12: f1f8b2e0bc directory rename detection: miscellaneo=
us testcases to complete coverage
13: 44b25c31e2 =3D 13: 595905c828 directory rename detection: tests for h=
andling overwriting untracked files
14: fa05a0240c =3D 14: 71ae85d203 directory rename detection: tests for h=
andling overwriting dirty files
15: 131af0e3f2 =3D 15: e9ca40cf6a merge-recursive: move the get_renames()=
 function
16: c7d1d15bec =3D 16: f4ff2a3c8b merge-recursive: introduce new function=
s to handle rename logic
17: 1ca5c22551 =3D 17: 84b57b2495 merge-recursive: fix leaks of allocated=
 renames and diff_filepairs
18: 57288cf7b1 =3D 18: 03c1d06592 merge-recursive: make !o->detect_rename=
 codepath more obvious
19: fd6602a327 =3D 19: cf9d708f1d merge-recursive: split out code for det=
ermining diff_filepairs
20: 8828dd4093 ! 20: ed33e1221f merge-recursive: add a new hashmap for st=
oring directory renames
    @@ -45,7 +45,7 @@
     +	hashmap_entry_init(entry, strhash(directory));
     +	entry->dir =3D directory;
     +	entry->non_unique_new_dir =3D 0;
    -+	entry->new_dir =3D NULL;
    ++	strbuf_init(&entry->new_dir, 0);
     +	string_list_init(&entry->possible_new_dirs, 0);
     +}
     +
    @@ -64,7 +64,7 @@
     +	struct hashmap_entry ent; /* must be the first member! */
     +	char *dir;
     +	unsigned non_unique_new_dir:1;
    -+	char *new_dir;
    ++	struct strbuf new_dir;
     +	struct string_list possible_new_dirs;
     +};
     +
--:  ------- > 21: 9b88f735c2 merge-recursive: make a helper function for=
 cleanup for handle_renames
21: f1d3b1f7ab ! 22: 20c94136af merge-recursive: add get_directory_rename=
s()
    @@ -63,8 +63,8 @@
     +	new_len =3D end_of_new - new_path;
     +
     +	if (old_len !=3D new_len || strncmp(old_path, new_path, old_len)) =
{
    -+		*old_dir =3D strndup(old_path, old_len);
    -+		*new_dir =3D strndup(new_path, new_len);
    ++		*old_dir =3D xstrndup(old_path, old_len);
    ++		*new_dir =3D xstrndup(new_path, new_len);
     +	}
     +}
     +
    @@ -84,6 +84,10 @@
     +		struct diff_filepair *pair =3D pairs->queue[i];
     +		char *old_dir, *new_dir;
     +
    ++		/* File not part of directory rename if it wasn't renamed */
    ++		if (pair->status !=3D 'R')
    ++			continue;
    ++
     +		get_renamed_dir_portion(pair->one->path, pair->two->path,
     +					&old_dir,        &new_dir);
     +		if (!old_dir)
    @@ -128,9 +132,11 @@
     +		}
     +		if (bad_max =3D=3D max)
     +			entry->non_unique_new_dir =3D 1;
    -+		else
    -+			entry->new_dir =3D strdup(best);
    -+		/* Strings were strndup'ed before inserting into string-list,
    ++		else {
    ++			assert(entry->new_dir.len =3D=3D 0);
    ++			strbuf_addstr(&entry->new_dir, best);
    ++		}
    ++		/* Strings were xstrndup'ed before inserting into string-list,
     +		 * so ask string_list to remove the entries for us.
     +		 */
     +		entry->possible_new_dirs.strdup_strings =3D 1;
    @@ -144,12 +150,33 @@
       * Get information of all renames which occurred in 'pairs', making=
 use of
       * any implicit directory renames inferred from the other side of h=
istory.
     @@
    + 	struct string_list *merge_renames;
    + };
    +=20
    +-static void initial_cleanup_rename(struct diff_queue_struct *pairs)
    ++static void initial_cleanup_rename(struct diff_queue_struct *pairs,
    ++				   struct hashmap *dir_renames)
    + {
    ++	struct hashmap_iter iter;
    ++	struct dir_rename_entry *e;
    ++
    ++	hashmap_iter_init(dir_renames, &iter);
    ++	while ((e =3D hashmap_iter_next(&iter))) {
    ++		free(e->dir);
    ++		strbuf_release(&e->new_dir);
    ++		/* possible_new_dirs already cleared in get_directory_renames */
    ++	}
    ++	hashmap_free(dir_renames, 1);
    ++	free(dir_renames);
    ++
    + 	free(pairs->queue);
    + 	free(pairs);
    + }
    +@@
      			  struct rename_info *ri)
      {
      	struct diff_queue_struct *head_pairs, *merge_pairs;
     +	struct hashmap *dir_re_head, *dir_re_merge;
    -+	struct hashmap_iter iter;
    -+	struct dir_rename_entry *e;
      	int clean;
     =20
      	ri->head_renames =3D NULL;
    @@ -164,29 +191,13 @@
      					 common, head, merge, entries);
      	ri->merge_renames =3D get_renames(o, merge_pairs, merge,
     @@
    + 	 * data structures are still needed and referenced in
      	 * process_entry().  But there are a few things we can free now.
      	 */
    -=20
    -+	hashmap_iter_init(dir_re_head, &iter);
    -+	while ((e =3D hashmap_iter_next(&iter))) {
    -+		free(e->dir);
    -+		if (e->new_dir)
    -+			free(e->new_dir);
    -+		/* possible_new_dirs already cleared in get_directory_renames */
    -+	}
    -+	hashmap_free(dir_re_head, 1);
    -+	free(dir_re_head);
    -+
    -+	hashmap_iter_init(dir_re_merge, &iter);
    -+	while ((e =3D hashmap_iter_next(&iter))) {
    -+		free(e->dir);
    -+		if (e->new_dir)
    -+			free(e->new_dir);
    -+		/* possible_new_dirs already cleared in get_directory_renames */
    -+	}
    -+	hashmap_free(dir_re_merge, 1);
    -+	free(dir_re_merge);
    -+
    - 	free(head_pairs->queue);
    - 	free(head_pairs);
    - 	free(merge_pairs->queue);
    +-	initial_cleanup_rename(head_pairs);
    +-	initial_cleanup_rename(merge_pairs);
    ++	initial_cleanup_rename(head_pairs, dir_re_head);
    ++	initial_cleanup_rename(merge_pairs, dir_re_merge);
    +=20
    + 	return clean;
    + }
22: ba1aa81d38 ! 23: da6b0646d1 merge-recursive: check for directory leve=
l conflicts
    @@ -32,6 +32,19 @@
      	}
      }
     =20
    ++static void remove_hashmap_entries(struct hashmap *dir_renames,
    ++				   struct string_list *items_to_remove)
    ++{
    ++	int i;
    ++	struct dir_rename_entry *entry;
    ++
    ++	for (i =3D 0; i < items_to_remove->nr; i++) {
    ++		entry =3D items_to_remove->items[i].util;
    ++		hashmap_remove(dir_renames, entry, NULL);
    ++	}
    ++	string_list_clear(items_to_remove, 0);
    ++}
    ++
     +/*
     + * There are a couple things we want to do at the directory level:
     + *   1. Check for both sides renaming to the same thing, in order t=
o avoid
    @@ -61,7 +74,6 @@
     +	struct hashmap_iter iter;
     +	struct dir_rename_entry *head_ent;
     +	struct dir_rename_entry *merge_ent;
    -+	int i;
     +
     +	struct string_list remove_from_head =3D STRING_LIST_INIT_NODUP;
     +	struct string_list remove_from_merge =3D STRING_LIST_INIT_NODUP;
    @@ -72,21 +84,24 @@
     +		if (merge_ent &&
     +		    !head_ent->non_unique_new_dir &&
     +		    !merge_ent->non_unique_new_dir &&
    -+		    !strcmp(head_ent->new_dir, merge_ent->new_dir)) {
    ++		    !strbuf_cmp(&head_ent->new_dir, &merge_ent->new_dir)) {
     +			/* 1. Renamed identically; remove it from both sides */
     +			string_list_append(&remove_from_head,
     +					   head_ent->dir)->util =3D head_ent;
    -+			free(head_ent->new_dir);
    ++			strbuf_release(&head_ent->new_dir);
     +			string_list_append(&remove_from_merge,
     +					   merge_ent->dir)->util =3D merge_ent;
    -+			free(merge_ent->new_dir);
    ++			strbuf_release(&merge_ent->new_dir);
     +		} else if (tree_has_path(head, head_ent->dir)) {
     +			/* 2. This wasn't a directory rename after all */
     +			string_list_append(&remove_from_head,
     +					   head_ent->dir)->util =3D head_ent;
    -+			free(head_ent->new_dir);
    ++			strbuf_release(&head_ent->new_dir);
     +		}
     +	}
    ++
    ++	remove_hashmap_entries(dir_re_head, &remove_from_head);
    ++	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
     +
     +	hashmap_iter_init(dir_re_merge, &iter);
     +	while ((merge_ent =3D hashmap_iter_next(&iter))) {
    @@ -99,7 +114,8 @@
     +			   !head_ent->non_unique_new_dir &&
     +			   !merge_ent->non_unique_new_dir) {
     +			/* 3. rename/rename(1to2) */
    -+			/* We can assume it's not rename/rename(1to1) because
    ++			/*
    ++			 * We can assume it's not rename/rename(1to1) because
     +			 * that was case (1), already checked above.  So we
     +			 * know that head_ent->new_dir and merge_ent->new_dir
     +			 * are different strings.
    @@ -107,28 +123,19 @@
     +			output(o, 1, _("CONFLICT (rename/rename): "
     +				       "Rename directory %s->%s in %s. "
     +				       "Rename directory %s->%s in %s"),
    -+			       head_ent->dir, head_ent->new_dir, o->branch1,
    -+			       head_ent->dir, merge_ent->new_dir, o->branch2);
    ++			       head_ent->dir, head_ent->new_dir.buf, o->branch1,
    ++			       head_ent->dir, merge_ent->new_dir.buf, o->branch2);
     +			string_list_append(&remove_from_head,
     +					   head_ent->dir)->util =3D head_ent;
    -+			free(head_ent->new_dir);
    ++			strbuf_release(&head_ent->new_dir);
     +			string_list_append(&remove_from_merge,
     +					   merge_ent->dir)->util =3D merge_ent;
    -+			free(merge_ent->new_dir);
    ++			strbuf_release(&merge_ent->new_dir);
     +		}
     +	}
     +
    -+	for (i =3D 0; i < remove_from_head.nr; i++) {
    -+		head_ent =3D remove_from_head.items[i].util;
    -+		hashmap_remove(dir_re_head, head_ent, NULL);
    -+	}
    -+	for (i =3D 0; i < remove_from_merge.nr; i++) {
    -+		merge_ent =3D remove_from_merge.items[i].util;
    -+		hashmap_remove(dir_re_merge, merge_ent, NULL);
    -+	}
    -+
    -+	string_list_clear(&remove_from_head, 0);
    -+	string_list_clear(&remove_from_merge, 0);
    ++	remove_hashmap_entries(dir_re_head, &remove_from_head);
    ++	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
     +}
     +
      static struct hashmap *get_directory_renames(struct diff_queue_stru=
ct *pairs,
23: 96534fe595 =3D 24: 93162a9b56 merge-recursive: add a new hashmap for =
storing file collisions
24: 66ada0e7c0 ! 25: 53b26a0d61 merge-recursive: add computation of colli=
sions due to dir rename & merging
    @@ -26,20 +26,19 @@
     +static char *apply_dir_rename(struct dir_rename_entry *entry,
     +			      const char *old_path)
     +{
    -+	char *new_path;
    -+	int entrylen, oldlen, newlen;
    ++	struct strbuf new_path =3D STRBUF_INIT;
    ++	int oldlen, newlen;
     +
     +	if (entry->non_unique_new_dir)
     +		return NULL;
     +
    -+	entrylen =3D strlen(entry->new_dir);
     +	oldlen =3D strlen(entry->dir);
    -+	newlen =3D entrylen + (strlen(old_path) - oldlen) + 1;
    -+	new_path =3D malloc(newlen);
    -+	strcpy(new_path, entry->new_dir);
    -+	strcpy(&new_path[entrylen], &old_path[oldlen]);
    ++	newlen =3D entry->new_dir.len + (strlen(old_path) - oldlen) + 1;
    ++	strbuf_grow(&new_path, newlen);
    ++	strbuf_addbuf(&new_path, &entry->new_dir);
    ++	strbuf_addstr(&new_path, &old_path[oldlen]);
     +
    -+	return new_path;
    ++	return strbuf_detach(&new_path, NULL);
     +}
     +
      static void get_renamed_dir_portion(const char *old_path, const cha=
r *new_path,
25: 0f49ea9449 ! 26: 26d4c78d67 merge-recursive: check for file level con=
flicts then get new name
    @@ -13,25 +13,9 @@
     --- a/merge-recursive.c
     +++ b/merge-recursive.c
     @@
    - 	}
    + 	string_list_clear(items_to_remove, 0);
      }
     =20
    -+/*
    -+ * Write:
    -+ *   element1, element2, element3, ..., elementN
    -+ * to str.  If only one element, just write "element1" to str.
    -+ */
    -+static void comma_separated_list(char *str, struct string_list *sli=
st)
    -+{
    -+	int i;
    -+
    -+	for (i =3D 0; i < slist->nr; i++) {
    -+		str +=3D sprintf(str, "%s", slist->items[i].string);
    -+		if (i < slist->nr-1)
    -+			str +=3D sprintf(str, ", ");
    -+	}
    -+}
    -+
     +/*
     + * See if there is a directory rename for path, and if there are an=
y file
     + * level conflicts for the renamed location.  If there is a rename =
and
    @@ -46,7 +30,7 @@
     +	char *new_path =3D NULL;
     +	struct collision_entry *collision_ent;
     +	int clean =3D 1;
    -+	char *collision_paths;
    ++	struct strbuf collision_paths =3D STRBUF_INIT;
     +
     +	/*
     +	 * entry has the mapping of old directory name to new directory na=
me
    @@ -84,33 +68,31 @@
     +	 * to put multiple paths into the same location.  Warn
     +	 * and bail on directory renames for such paths.
     +	 */
    -+	collision_paths =3D malloc((PATH_MAX+2) * collision_ent->source_fi=
les.nr);
    -+
     +	if (collision_ent->reported_already) {
     +		clean =3D 0;
     +	} else if (tree_has_path(tree, new_path)) {
     +		collision_ent->reported_already =3D 1;
    -+		comma_separated_list(collision_paths,
    -+				     &collision_ent->source_files);
    ++		strbuf_add_separated_string_list(&collision_paths, ", ",
    ++						 &collision_ent->source_files);
     +		output(o, 1, _("CONFLICT (implicit dir rename): Existing "
     +			       "file/dir at %s in the way of implicit "
     +			       "directory rename(s) putting the following "
     +			       "path(s) there: %s."),
    -+		       new_path, collision_paths);
    ++		       new_path, collision_paths.buf);
     +		clean =3D 0;
     +	} else if (collision_ent->source_files.nr > 1) {
     +		collision_ent->reported_already =3D 1;
    -+		comma_separated_list(collision_paths,
    -+				     &collision_ent->source_files);
    ++		strbuf_add_separated_string_list(&collision_paths, ", ",
    ++						 &collision_ent->source_files);
     +		output(o, 1, _("CONFLICT (implicit dir rename): Cannot map "
     +			       "more than one path to %s; implicit directory "
     +			       "renames tried to put these paths there: %s"),
    -+		       new_path, collision_paths);
    ++		       new_path, collision_paths.buf);
     +		clean =3D 0;
     +	}
     +
     +	/* Free memory we no longer need */
    -+	free(collision_paths);
    ++	strbuf_release(&collision_paths);
     +	if (!clean && new_path) {
     +		free(new_path);
     +		return NULL;
    @@ -165,11 +147,11 @@
     +	 * As it turns out, this also prevents N-way transient rename
     +	 * confusion; See testcases 9c and 9d of t6043.
     +	 */
    -+	oentry =3D dir_rename_find_entry(dir_rename_exclusions, entry->new=
_dir);
    ++	oentry =3D dir_rename_find_entry(dir_rename_exclusions, entry->new=
_dir.buf);
     +	if (oentry) {
     +		output(o, 1, _("WARNING: Avoiding applying %s -> %s rename "
     +			       "to %s, because %s itself was renamed."),
    -+		       entry->dir, entry->new_dir, path, entry->new_dir);
    ++		       entry->dir, entry->new_dir.buf, path, entry->new_dir.buf);
     +	} else {
     +		new_path =3D handle_path_level_conflicts(o, path, entry,
     +						       collisions, tree);
    @@ -222,9 +204,9 @@
      		re->processed =3D 0;
      		re->pair =3D pair;
     @@
    + {
    + 	struct diff_queue_struct *head_pairs, *merge_pairs;
      	struct hashmap *dir_re_head, *dir_re_merge;
    - 	struct hashmap_iter iter;
    - 	struct dir_rename_entry *e;
     -	int clean;
     +	int clean =3D 1;
     =20
    @@ -257,6 +239,73 @@
      	 * Some cleanup is deferred until cleanup_renames() because the
      	 * data structures are still needed and referenced in
    =20
    +diff --git a/strbuf.c b/strbuf.c
    +--- a/strbuf.c
    ++++ b/strbuf.c
    +@@
    + #include "cache.h"
    + #include "refs.h"
    ++#include "string-list.h"
    + #include "utf8.h"
    +=20
    + int starts_with(const char *str, const char *prefix)
    +@@
    + 	return ret;
    + }
    +=20
    ++void strbuf_add_separated_string_list(struct strbuf *str,
    ++				      const char *sep,
    ++				      struct string_list *slist)
    ++{
    ++	struct string_list_item *item;
    ++	int sep_needed =3D 0;
    ++
    ++	for_each_string_list_item(item, slist) {
    ++		if (sep_needed)
    ++			strbuf_addstr(str, sep);
    ++		strbuf_addstr(str, item->string);
    ++		sep_needed =3D 1;
    ++	}
    ++}
    ++
    + void strbuf_list_free(struct strbuf **sbs)
    + {
    + 	struct strbuf **s =3D sbs;
    +
    +diff --git a/strbuf.h b/strbuf.h
    +--- a/strbuf.h
    ++++ b/strbuf.h
    +@@
    + #ifndef STRBUF_H
    + #define STRBUF_H
    +=20
    ++struct string_list;
    ++
    + /**
    +  * strbuf's are meant to be used with all the usual C string and me=
mory
    +  * APIs. Given that the length of the buffer is known, it's often b=
etter to
    +@@
    + 	return strbuf_split_max(sb, terminator, 0);
    + }
    +=20
    ++/*
    ++ * Adds all strings of a string list to the strbuf, separated by th=
e given
    ++ * separator.  For example, if sep is
    ++ *   ', '
    ++ * and slist contains
    ++ *   ['element1', 'element2', ..., 'elementN'],
    ++ * then write:
    ++ *   'element1, element2, ..., elementN'
    ++ * to str.  If only one element, just write "element1" to str.
    ++ */
    ++extern void strbuf_add_separated_string_list(struct strbuf *str,
    ++					     const char *sep,
    ++					     struct string_list *slist);
    ++
    + /**
    +  * Free a NULL-terminated list of strbufs (for example, the return
    +  * values of the strbuf_split*() functions).
    +
     diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-ren=
ame-directories.sh
     --- a/t/t6043-merge-rename-directories.sh
     +++ b/t/t6043-merge-rename-directories.sh
26: 996de01e67 =3D 27: 0bbb741e1d merge-recursive: when comparing files, =
don't include trees
27: 07401ad0ff =3D 28: 6c398f0278 merge-recursive: apply necessary modifi=
cations for directory renames
28: fafa66de08 =3D 29: 4de6b08124 merge-recursive: avoid clobbering untra=
cked files with directory renames
29: 9ab0339ebb =3D 30: b710627ca6 merge-recursive: fix overwriting dirty =
files involved in renames
30: feb4781c7a =3D 31: 7f56715998 merge-recursive: fix remaining director=
y rename + dirty overwrite cases
31: 29975384e0 =3D 32: a51698e630 directory rename detection: new testcas=
es showcasing a pair of bugs
32: b084ea16ac ! 33: c27b89922e merge-recursive: avoid spurious rename/re=
name conflict from dir renames
    @@ -21,7 +21,7 @@
      		struct diff_filepair *pair =3D pairs->queue[i];
     =20
     -		if (pair->status =3D=3D 'D')
    -+		if (pair->status =3D=3D 'D' || pair->status =3D=3D 'M')
    ++		if (pair->status !=3D 'A' && pair->status !=3D 'R')
      			continue;
      		dir_rename_ent =3D check_dir_renamed(pair->two->path,
      						   dir_renames);
    @@ -30,7 +30,7 @@
      		char *new_path; /* non-NULL only with directory renames */
     =20
     -		if (pair->status =3D=3D 'D') {
    -+		if (pair->status =3D=3D 'D' || pair->status =3D=3D 'M') {
    ++		if (pair->status !=3D 'A' && pair->status !=3D 'R') {
      			diff_free_filepair(pair);
      			continue;
      		}
33: 62ce55426d =3D 34: 850bc54b15 merge-recursive: ensure we write update=
s for directory-renamed file

Elijah Newren (34):
  Tighten and correct a few testcases for merging and cherry-picking
  merge-recursive: fix logic ordering issue
  merge-recursive: add explanation for src_entry and dst_entry
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
  merge-recursive: add a new hashmap for storing directory renames
  merge-recursive: make a helper function for cleanup for handle_renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
  merge-recursive: add a new hashmap for storing file collisions
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

 merge-recursive.c                   | 1231 ++++++++++-
 merge-recursive.h                   |   17 +
 strbuf.c                            |   16 +
 strbuf.h                            |   16 +
 t/t3501-revert-cherry-pick.sh       |    5 +-
 t/t6043-merge-rename-directories.sh | 3823 +++++++++++++++++++++++++++++=
++++++
 t/t7607-merge-overwrite.sh          |    7 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 9 files changed, 5007 insertions(+), 116 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

--=20
2.15.0.408.g850bc54b15
