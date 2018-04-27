Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD221F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757960AbeD0Seq (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:34:46 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35366 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757568AbeD0Sep (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Apr 2018 14:34:45 -0400
X-Greylist: delayed 877 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Apr 2018 14:34:45 EDT
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3RII72D028862;
        Fri, 27 Apr 2018 11:19:39 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@palantir.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg4b816e9-1;
        Fri, 27 Apr 2018 11:19:39 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7AB462216081;
        Fri, 27 Apr 2018 11:19:39 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6FC492CDE7C;
        Fri, 27 Apr 2018 11:19:39 -0700 (PDT)
From:   Elijah Newren <newren@palantir.com>
To:     peartben@gmail.com
Cc:     Ben.Peart@microsoft.com, Johannes.Schindelin@gmx.de,
        eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, kewillf@microsoft.com, pclouds@gmail.com,
        peff@peff.net, vmiklos@frugalware.org,
        Elijah Newren <newren@gmail.com>
Subject: 
Date:   Fri, 27 Apr 2018 11:19:37 -0700
Message-Id: <20180427181937.7607-1-newren@palantir.com>
X-Mailer: git-send-email 2.17.0.294.g8e3b83c0e3
In-Reply-To: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
References: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 include:spf-00153501.pphosted.com include:fspf0.palantir.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

On Thu, Apr 26, 2018 at 5:54 PM, Ben Peart <peartben@gmail.com> wrote:

> Can you write the documentation that clearly explains the exact behavior you
> want?  That would kill two birds with one stone... :)

Sure, something like the following is what I envision, and I've tried to
include the suggestion from Junio to document the copy behavior in the
merge-recursive documentation.

-- 8< --
Subject: [PATCH] fixup! merge: Add merge.renames config setting

---
 Documentation/merge-config.txt     | 3 +--
 Documentation/merge-strategies.txt | 5 +++--
 merge-recursive.c                  | 8 ++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 59848e5634..662c2713ca 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -41,8 +41,7 @@ merge.renameLimit::
 merge.renames::
 	Whether and how Git detects renames.  If set to "false",
 	rename detection is disabled. If set to "true", basic rename
-	detection is enabled.  If set to "copies" or "copy", Git will
-	detect copies, as well.  Defaults to the value of diff.renames.
+	detection is enabled.  Defaults to the value of diff.renames.
 
 merge.renormalize::
 	Tell Git that canonical representation of files in the
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 1e0728aa12..aa66cbe41e 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -23,8 +23,9 @@ recursive::
 	causing mismerges by tests done on actual merge commits
 	taken from Linux 2.6 kernel development history.
 	Additionally this can detect and handle merges involving
-	renames.  This is the default merge strategy when
-	pulling or merging one branch.
+	renames, but currently cannot make use of detected
+	copies.  This is the default merge strategy when pulling
+	or merging one branch.
 +
 The 'recursive' strategy can take the following options:
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 6cc4404144..b618f134d2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -564,6 +564,14 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
+	/*
+	 * We do not have logic to handle the detection of copies.  In
+	 * fact, it may not even make sense to add such logic: would we
+	 * really want a change to a base file to be propagated through
+	 * multiple other files by a merge?
+	 */
+	if (opts.detect_rename > DIFF_DETECT_RENAME)
+		opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    1000;
-- 
2.17.0.294.g8e3b83c0e3

