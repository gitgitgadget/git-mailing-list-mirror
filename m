Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C901F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeF0HYL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:24:11 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:49704 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932506AbeF0HXi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:23:38 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7JIY7013156;
        Wed, 27 Jun 2018 00:23:23 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju8sxtfmy-1;
        Wed, 27 Jun 2018 00:23:22 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7C03122FD102;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 701B02CDE65;
        Wed, 27 Jun 2018 00:23:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 0/9] Document/fix/warn about rebase incompatibilities and inconsistencies
Date:   Wed, 27 Jun 2018 00:23:10 -0700
Message-Id: <20180627072319.31356-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180625161300.26060-1-newren@gmail.com>
References: <20180625161300.26060-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270086
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rebase has lots of options that are mutually incompatible.  Even among
aspects of its behavior that is common to all rebase types, it has a number
of inconsistencies.  This series tries to document, fix, and/or warn users
about many of these.

Changes since v4 (short branch-diff at the end):
  - Fixed --strategy vs. --strategy-option (in patch 3, carries over to
    context region in later commit)

v4 didn't get a lot of feedback (though it was picked up by Junio), so I'll
repeat the areas that would be of most note for reviewers since v3:

  * I have left patch 9 in RFC state; since v3 it has an expanded the
    commit message with an in-depth usability rationale for the
    change.
  * It sounded like Junio was slightly unclear about the intent of the
    wording in Patch 1.  Not sure if my answer (in email) was sufficient or
    if there are wording improvements others might suggest.
  * I'm assuming the --keep-empty and/or --empty={drop,halt,keep} (see
    comments on patch 5 of v3) can be resolved in a later series.

Elijah Newren (9):
  git-rebase.txt: document incompatible options
  git-rebase.sh: update help messages a bit
  t3422: new testcases for checking when incompatible options passed
  git-rebase: error out when incompatible options passed
  git-rebase.txt: address confusion between --no-ff vs --force-rebase
  directory-rename-detection.txt: technical docs on abilities and
    limitations
  git-rebase.txt: document behavioral differences between modes
  t3401: add directory rename testcases for rebase and am
  git-rebase: make --allow-empty-message the default

 Documentation/git-rebase.txt                  | 135 ++++++++++++++----
 .../technical/directory-rename-detection.txt  | 115 +++++++++++++++
 git-rebase.sh                                 |  43 +++++-
 t/t3401-rebase-and-am-rename.sh               | 105 ++++++++++++++
 t/t3404-rebase-interactive.sh                 |   7 +-
 t/t3405-rebase-malformed.sh                   |  11 +-
 t/t3422-rebase-incompatible-options.sh        |  88 ++++++++++++
 7 files changed, 462 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/technical/directory-rename-detection.txt
 create mode 100755 t/t3401-rebase-and-am-rename.sh
 create mode 100755 t/t3422-rebase-incompatible-options.sh

 1: 3f454ebc5e =  1: 3f454ebc5e git-rebase.txt: document incompatible options
 2: 31a5a071a6 =  2: 31a5a071a6 git-rebase.sh: update help messages a bit
 3: 5a2b5eec79 !  3: bc3a5a3f95 t3422: new testcases for checking when incompatible options passed
    @@ -62,7 +62,7 @@
     +
     +	test_expect_failure "$opt incompatible with --strategy-option=ours" "
     +		git checkout B^0 &&
    -+		test_must_fail git rebase $opt --strategy=ours A
    ++		test_must_fail git rebase $opt --strategy-option=ours A
     +	"
     +
     +	test_expect_failure "$opt incompatible with --interactive" "
 4: 1e1c83724a !  4: ca3b8327f7 git-rebase: error out when incompatible options passed
    @@ -104,7 +104,7 @@
     -	test_expect_failure "$opt incompatible with --strategy-option=ours" "
     +	test_expect_success "$opt incompatible with --strategy-option=ours" "
      		git checkout B^0 &&
    - 		test_must_fail git rebase $opt --strategy=ours A
    + 		test_must_fail git rebase $opt --strategy-option=ours A
      	"
      
     -	test_expect_failure "$opt incompatible with --interactive" "
 5: 51023269d3 =  5: 6ac359359e git-rebase.txt: address confusion between --no-ff vs --force-rebase
 6: f017d45dd9 =  6: e5c5db9110 directory-rename-detection.txt: technical docs on abilities and limitations
 7: 0a359df404 =  7: e330437305 git-rebase.txt: document behavioral differences between modes
 8: beaadceaef =  8: f704f7eee8 t3401: add directory rename testcases for rebase and am
 9: 431b2c36d5 =  9: 436f597487 git-rebase: make --allow-empty-message the default

-- 
2.18.0.9.g431b2c36d5
