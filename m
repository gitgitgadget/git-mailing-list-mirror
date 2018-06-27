Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4871F516
	for <e@80x24.org>; Wed, 27 Jun 2018 15:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965527AbeF0PsY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 11:48:24 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43884 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965335AbeF0PsW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 11:48:22 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RFhCck023591;
        Wed, 27 Jun 2018 08:48:07 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mu3w2-1;
        Wed, 27 Jun 2018 08:48:07 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 621D522378E0;
        Wed, 27 Jun 2018 08:48:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 573282CDE86;
        Wed, 27 Jun 2018 08:48:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/2] Fix use of strategy options with interactive rebases
Date:   Wed, 27 Jun 2018 08:48:02 -0700
Message-Id: <20180627154804.3743-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627073623.31725-1-newren@gmail.com>
References: <20180627073623.31725-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270170
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive machinery for git rebase can accept special merge
strategies or strategy options, but has a bug in its handling of
strategy options.  This short series patches that.

Changes since v2:
  - Fix broken &&-chaining (Thanks to Eric for spotting)

Elijah Newren (2):
  t3418: add testcase showing problems with rebase -i and strategy
    options
  Fix use of strategy options with interactive rebases

 git-rebase.sh              |  2 +-
 sequencer.c                |  7 ++++++-
 t/t3418-rebase-continue.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

 1: 43b9ac5a63 !  1: f8a5df9ef1 t3418: add testcase showing problems with rebase -i and strategy options
    @@ -34,7 +34,7 @@
     +	EOF
     +	chmod +x test-bin/git-merge-funny &&
     +	(
    -+		PATH=./test-bin:$PATH
    ++		PATH=./test-bin:$PATH &&
     +		test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
     +	) &&
     +	test -f funny.was.run &&
    @@ -42,7 +42,7 @@
     +	echo "Resolved" >F2 &&
     +	git add F2 &&
     +	(
    -+		PATH=./test-bin:$PATH
    ++		PATH=./test-bin:$PATH &&
     +		git rebase --continue
     +	) &&
     +	test -f funny.was.run
 2: d345eb96d5 =  2: b7e4971e66 Fix use of strategy options with interactive rebases

-- 
2.18.0.9.g431b2c36d5
