Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707B31F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKHPgE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:36:04 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54788 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725724AbeKHPgD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 10:36:03 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA85riVx017898;
        Wed, 7 Nov 2018 22:02:10 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm96drg6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 22:02:10 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 22:02:03 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 22:02:03 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 677882101E7E;
        Wed,  7 Nov 2018 22:02:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] Reimplement rebase --merge via interactive machinery
Date:   Wed, 7 Nov 2018 22:01:56 -0800
Message-ID: <20181108060158.27145-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080050
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the rewrite-interactive-rebases-in-C series have finally
merged to master, this series deletes git-rebase--merge.sh and
reimplements the --merge behavior on top of the interactive machinery.

Differences since v1:
  - Updated code to hook into builtin/rebase.C instead of git-rebase.sh

(No range-diff provided, because it has been months since v1, and v1
was only RFC and was only discussed at a high level.)

Elijah Newren (2):
  git-rebase, sequencer: extend --quiet option for the interactive
    machinery
  rebase: Implement --merge via git-rebase--interactive

 .gitignore                        |   1 -
 Documentation/git-rebase.txt      |  17 +---
 Makefile                          |   1 -
 builtin/rebase.c                  |  15 ++-
 git-legacy-rebase.sh              |  57 +++++------
 git-rebase--common.sh             |   2 +-
 git-rebase--merge.sh              | 164 ------------------------------
 sequencer.c                       |  23 +++--
 sequencer.h                       |   1 +
 t/t3406-rebase-message.sh         |   7 +-
 t/t3420-rebase-autostash.sh       |  78 ++------------
 t/t3421-rebase-topology-linear.sh |  10 +-
 t/t3425-rebase-topology-merges.sh |   6 +-
 t/t5407-post-rewrite-hook.sh      |   1 +
 t/t9903-bash-prompt.sh            |   2 +-
 15 files changed, 67 insertions(+), 318 deletions(-)
 delete mode 100644 git-rebase--merge.sh

-- 
2.19.1.858.g526e8fe740.dirty

