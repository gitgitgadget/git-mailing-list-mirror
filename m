Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A943208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 16:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbeHGTE2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:04:28 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56736 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389017AbeHGTE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Aug 2018 15:04:27 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77GlXNo009947;
        Tue, 7 Aug 2018 09:49:07 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kn91kdgh8-1;
        Tue, 07 Aug 2018 09:49:07 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 2F51222FCFB5;
        Tue,  7 Aug 2018 09:49:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 25BE22CDEB1;
        Tue,  7 Aug 2018 09:49:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com, martin.agren@gmail.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 0/5] Simple fixes to t7406
Date:   Tue,  7 Aug 2018 09:49:00 -0700
Message-Id: <20180807164905.3859-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.geb414df874.dirty
In-Reply-To: <20180806152524.27516-1-newren@gmail.com>
References: <20180806152524.27516-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series started as a simple single-line fix, but folks keep
noticing other problems with t7406 while reading my patches.  So, changes
noted below and I have a challenge at the end.

Changes since v2:
  - Two new patches inserted into this series (3/5 and 4/5):
    - Prefer test_* helper functions to 'test -[feds]' (see patch 3; this
      is my attempt to remove easy answers from the challenge below)
    - Fix other places in the testfile using test_must_fail for non-git
      commands (see patch 4; suggested by SZEDER)
  - Avoid losing the check of git's exit status in a command substituion,
    improve potential error message for a test while at it (part of patch=
 2;
    suggested by SZEDER)
  - Update the commit message for the final commit to match the updated
    code (Pointed out by Martin)

Since folks like to notice other problems with t7406 while reading my
patches, here's a challenge:

  Find something *else* wrong with t7406 that neither I nor any of the
  reviewers so far have caught that could be fixed.

    - You get bonus points if that thing is in the context region for
      one of my five patches.
    - Extra bonus points if the thing needing fixing was on a line I
      changed.
    - You win outright if it's something big enough that I give up and
      request to just have my series merged as-is and punt your
      suggested fixes down the road to someone else.

  (Note: If I flubbed something in v3, pointing it out doesn't count
   as finding "something else", but do please still point it out.)

:-)


Elijah Newren (5):
  t7406: simplify by using diff --name-only instead of diff --raw
  t7406: avoid having git commands upstream of a pipe
  t7406: prefer test_* helper functions to test -[feds]
  t7406: avoid using test_must_fail for commands other than git
  t7406: fix call that was failing for the wrong reason

 t/t7406-submodule-update.sh | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--=20
2.18.0.550.geb414df874.dirty

