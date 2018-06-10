Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AE91F403
	for <e@80x24.org>; Sun, 10 Jun 2018 04:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeFJEQb (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 00:16:31 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35422 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753704AbeFJEQ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 00:16:26 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5A4CnLY003759;
        Sat, 9 Jun 2018 21:16:19 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jgbsksa1p-1;
        Sat, 09 Jun 2018 21:16:18 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5C2F721021E1;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 517332CDE75;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/6] merge-recursive code cleanups
Date:   Sat,  9 Jun 2018 21:16:10 -0700
Message-Id: <20180610041616.4448-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.6.gffeb3ef585
In-Reply-To: <20180522004327.13085-1-newren@gmail.com>
References: <20180522004327.13085-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806100048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains several small code cleanups for
merge-recursive.

Changes since v2:
  * Now built on master (the topics this depended on have graduated);
    merges cleanly with next and pu.
  * Patch #2 has a few additional argument alignment fixes; some in
    code added by topics that have since graduated, and a couple that
    were overlooked previously.
  * Patch #3 is entirely new.
  * Re-wrapped the commit message of the final patch.
  (range-diff below)

Elijah Newren (6):
  merge-recursive: fix miscellaneous grammar error in comment
  merge-recursive: fix numerous argument alignment issues
  merge-recursive: align labels with their respective code blocks
  merge-recursive: clarify the rename_dir/RENAME_DIR meaning
  merge-recursive: rename conflict_rename_*() family of functions
  merge-recursive: add pointer about unduly complex looking code

 merge-recursive.c | 186 ++++++++++++++++++++++++++--------------------
 1 file changed, 104 insertions(+), 82 deletions(-)

range-diff against v2:

 1: 4222f174de =  1: 4222f174de merge-recursive: fix miscellaneous grammar error in comment
 2: 4ebf93822d !  2: 284a5fee3d merge-recursive: fix numerous argument alignment issues
    @@ -33,6 +33,76 @@
      {
      	struct path_hashmap_entry *entry;
      	int baselen = base->len;
    +@@
    + 	 */
    + 	if (would_lose_untracked(path))
    + 		return err(o, _("refusing to lose untracked file at '%s'"),
    +-			     path);
    ++			   path);
    + 
    + 	/* Successful unlink is good.. */
    + 	if (!unlink(path))
    +@@
    + 			unlink(path);
    + 			if (symlink(lnk, path))
    + 				ret = err(o, _("failed to symlink '%s': %s"),
    +-					path, strerror(errno));
    ++					  path, strerror(errno));
    + 			free(lnk);
    + 		} else
    + 			ret = err(o,
    +@@
    + }
    + 
    + static int find_first_merges(struct object_array *result, const char *path,
    +-		struct commit *a, struct commit *b)
    ++			     struct commit *a, struct commit *b)
    + {
    + 	int i, j;
    + 	struct object_array merges = OBJECT_ARRAY_INIT;
    +@@
    + 
    + 	/* get all revisions that merge commit a */
    + 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
    +-			oid_to_hex(&a->object.oid));
    ++		  oid_to_hex(&a->object.oid));
    + 	init_revisions(&revs, NULL);
    + 	rev_opts.submodule = path;
    + 	/* FIXME: can't handle linked worktrees in submodules yet */
    +@@
    + 		output(o, 2, _("Found a possible merge resolution for the submodule:\n"));
    + 		print_commit((struct commit *) merges.objects[0].item);
    + 		output(o, 2, _(
    +-			"If this is correct simply add it to the index "
    +-			"for example\n"
    +-			"by using:\n\n"
    +-			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
    +-			"which will accept this suggestion.\n"),
    +-			oid_to_hex(&merges.objects[0].item->oid), path);
    ++		       "If this is correct simply add it to the index "
    ++		       "for example\n"
    ++		       "by using:\n\n"
    ++		       "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
    ++		       "which will accept this suggestion.\n"),
    ++		       oid_to_hex(&merges.objects[0].item->oid), path);
    + 		break;
    + 
    + 	default:
    +@@
    + 			result->clean = (merge_status == 0);
    + 		} else if (S_ISGITLINK(a->mode)) {
    + 			result->clean = merge_submodule(o, &result->oid,
    +-						       one->path,
    +-						       &one->oid,
    +-						       &a->oid,
    +-						       &b->oid);
    ++							one->path,
    ++							&one->oid,
    ++							&a->oid,
    ++							&b->oid);
    + 		} else if (S_ISLNK(a->mode)) {
    + 			switch (o->recursive_variant) {
    + 			case MERGE_RECURSIVE_NORMAL:
     @@
      }
      
--: ---------- >  3: 6bae2a267f merge-recursive: align labels with their respective code blocks
 3: 585759f07a =  4: aecf1267d8 merge-recursive: clarify the rename_dir/RENAME_DIR meaning
 4: 3cfb8b01b8 =  5: f7637bef12 merge-recursive: rename conflict_rename_*() family of functions
 5: d2a24f5b38 !  6: ffeb3ef585 merge-recursive: add pointer about unduly complex looking code
    @@ -3,10 +3,11 @@
         merge-recursive: add pointer about unduly complex looking code
     
         handle_change_delete() has a block of code displaying one of four nearly
    -    identical messages.  Each contains about half a dozen variable interpolations,
    -    which use nearly identical variables as well.  Someone trying to parse this
    -    may be slowed down trying to parse the differences and why they are here; help
    -    them out by adding a comment explaining the differences.
    +    identical messages.  Each contains about half a dozen variable
    +    interpolations, which use nearly identical variables as well.  Someone
    +    trying to parse this may be slowed down trying to parse the differences
    +    and why they are here; help them out by adding a comment explaining the
    +    differences.
     
         Further, point out that this code structure isn't collapsed into something
         more concise and readable for the programmer, because we want to keep full


-- 
2.18.0.rc1.6.gffeb3ef585
