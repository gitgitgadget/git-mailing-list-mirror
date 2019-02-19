Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AA81F453
	for <e@80x24.org>; Tue, 19 Feb 2019 17:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfBSRHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 12:07:18 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:52758 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfBSRHS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Feb 2019 12:07:18 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JGvoB0020208;
        Tue, 19 Feb 2019 09:07:13 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qpg9rkw8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 19 Feb 2019 09:07:13 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Feb 2019 09:06:55 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Feb 2019 09:06:55 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id B187C2216320;
        Tue, 19 Feb 2019 09:07:11 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] merge-options.txt: correct wording of --no-commit option
Date:   Tue, 19 Feb 2019 09:07:09 -0800
Message-ID: <20190219170709.25463-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.264.g6c9e06a32d
In-Reply-To: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
References: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_11:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The former wording implied that --no-commit would always cause the
merge operation to "pause" and allow the user to make further changes
and/or provide a special commit message for the merge commit.  This
is not the case for fast-forward merges, as there is no merge commit
to create.  Without a merge commit, there is no place where it makes
sense to "stop the merge and allow the user to tweak changes"; doing
that would require a full rebase of some sort.

Since users may be unaware of whether their branches have diverged or
not, modify the wording to correctly address fast-forward cases as well
and suggest using --no-ff with --no-commit if the point is to ensure
that the merge stops before completing.

Reported-by: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1:
  - Tweaked commit message

 Documentation/merge-options.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index c2a263ba74..d1061b8cf7 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -3,9 +3,15 @@
 	Perform the merge and commit the result. This option can
 	be used to override --no-commit.
 +
-With --no-commit perform the merge but pretend the merge
-failed and do not autocommit, to give the user a chance to
-inspect and further tweak the merge result before committing.
+With --no-commit perform the merge and stop just before creating
+a merge commit, to give the user a chance to inspect and further
+tweak the merge result before committing.
++
+Note that fast-forward updates do not need to create a merge
+commit and therefore there is no way to stop those merges with
+--no-commit.  Thus, if you want to ensure your branch is not
+changed or updated by the merge command, use --no-ff with
+--no-commit.
 
 --edit::
 -e::
-- 
2.21.0.rc1.264.g6c9e06a32d

