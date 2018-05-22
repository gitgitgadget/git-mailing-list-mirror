Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361651F51C
	for <e@80x24.org>; Tue, 22 May 2018 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeEVAno (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 20:43:44 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53500 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751152AbeEVAng (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 May 2018 20:43:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4M0hOh2027579;
        Mon, 21 May 2018 17:43:29 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j2gtkjv5s-1;
        Mon, 21 May 2018 17:43:28 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DF6E52000DC8;
        Mon, 21 May 2018 17:43:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D67342CDE66;
        Mon, 21 May 2018 17:43:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/5] merge-recursive code cleanups
Date:   Mon, 21 May 2018 17:43:22 -0700
Message-Id: <20180522004327.13085-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
In-Reply-To: <20180519020700.2241-1-newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805220005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains several small code cleanups for merge-recursive.
I have removed a couple small cleanup chunks in order to avoid conflicts
with any other in-flight topics in pu (namely, nd/commit-util-to-slab and
sb/submodule-merge-in-merge-recursive).  I may resend those later
separately.

The series was made on top of next (specifically commit 4fb28f7b1639
("Merge branch 'sb/object-store-replace' into next")); it will not
apply to master.


Changes since v1:
  * As suggested by Dscho, replaced patch 5 with a pointer about the
    fact that the code is that way to help translators
  * Small rewordings or paragraph splittings suggested by Dscho
  * Added Dscho's Acked-by on relevant patches (2-4)


Elijah Newren (5):
  merge-recursive: fix miscellaneous grammar error in comment
  merge-recursive: fix numerous argument alignment issues
  merge-recursive: clarify the rename_dir/RENAME_DIR meaning
  merge-recursive: rename conflict_rename_*() family of functions
  merge-recursive: add pointer about unduly complex looking code

 merge-recursive.c | 152 ++++++++++++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 65 deletions(-)


branch-diff:
 1: 1af1c7df17 =  1: 96225eddbb merge-recursive: fix miscellaneous grammar error in comment
 2: 8ed7c8b588 !  2: c63f72e96d merge-recursive: fix numerous argument alignment issues
    @@ -5,6 +5,7 @@
         Various refactorings throughout the code have left lots of alignment
         issues that were driving me crazy; fix them.
     
    +    Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
     diff --git a/merge-recursive.c b/merge-recursive.c
 3: e96b2cd9ae !  3: 3d95e8b756 merge-recursive: clarify the rename_dir/RENAME_DIR meaning
    @@ -4,14 +4,17 @@
     
         We had an enum of rename types which included RENAME_DIR; this name felt
         misleading since it was not about an entire directory but was a status for
    -    each individual file add that occurred within a renamed directory.  Since
    -    this type is for signifying that the files in question were being renamed
    -    due to directory rename detection, rename this enum value to
    -    RENAME_VIA_DIR.  Make a similar change to the conflict_rename_dir()
    -    function, and add a comment to the top of that function explaining its
    -    purpose (it may not be quite as obvious as for the other
    -    conflict_rename_*() functions).
    +    each individual file add that occurred within a renamed directory.
     
    +    Since this type is for signifying that the files in question were being
    +    renamed due to directory rename detection, rename this enum value to
    +    RENAME_VIA_DIR.
    +
    +    Make a similar change to the conflict_rename_dir() function, and add a
    +    comment to the top of that function explaining its purpose (it may not be
    +    quite as obvious as for the other conflict_rename_*() functions).
    +
    +    Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
     diff --git a/merge-recursive.c b/merge-recursive.c
    @@ -42,7 +45,7 @@
     +	/*
     +	 * Handle file adds that need to be renamed due to directory rename
     +	 * detection.  This differs from handle_rename_normal, because
    -+	 * there is no content merge to do; just move the path into the
    ++	 * there is no content merge to do; just move the file into the
     +	 * desired final location.
     +	 */
      	const struct diff_filespec *dest = pair->two;
 4: 4155613a6b !  4: dfd6ab22db merge-recursive: rename conflict_rename_*() family of functions
    @@ -24,6 +24,7 @@
         from all the handle_rename_*() functions which are called from
         process_entry().
     
    +    Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
     diff --git a/merge-recursive.c b/merge-recursive.c
 5: 20b8963732 < --: ---------- merge-recursive: simplify handle_change_delete
--: ---------- >  5: 122629ef7a merge-recursive: add pointer about unduly complex looking code

-- 
2.17.0.847.g20b8963732

