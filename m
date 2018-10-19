Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB211F453
	for <e@80x24.org>; Fri, 19 Oct 2018 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJTDiq (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 23:38:46 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:33214 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727631AbeJTDiq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Oct 2018 23:38:46 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9JJNkqW028046;
        Fri, 19 Oct 2018 12:31:16 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2n6h853fnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 Oct 2018 12:31:16 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 19 Oct 2018 12:31:14 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 19 Oct 2018 12:31:14 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 19 Oct 2018 12:31:13 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 3CE5B2101E7B;  Fri, 19 Oct 2018 12:31:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/8] Improve path collision conflict resolutions
Date:   Fri, 19 Oct 2018 12:31:03 -0700
Message-ID: <20181019193111.12051-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.230.g45940724d5
In-Reply-To: <20181014020537.17991-1-newren@gmail.com>
References: <20181014020537.17991-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-cleanup-more and is built on that
series.  (It merges cleanly to master, next, and pu).

This series makes all the "file collision" conflict types be handled
consistently; making them all behave like add/add (as suggested by
Jonathan[1] and Junio[2]).  These types are:
  * add/add
  * rename/add
  * rename/rename(2to1)
  * each rename/add piece of a rename/rename(1to2)/add[/add] conflict

Changes since v2:
  * Removed RFC label (en/merge-cleanup-more is now pu -- in fact, v2
    of that series is in pu; also, I'm starting to build other series
    on this one which has increased my confidence in it)
  * patch for increasing marker length with depth of recursion has been
    pulled from the en/merge-cleanup-more series and added to this series
  * Fixed an incorrect sentence in a commit message that was leftover
    from v1.
  
[1] https://public-inbox.org/git/20180312213521.GB58506@aiede.svl.corp.google.com/
[2] https://public-inbox.org/git/CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com


Elijah Newren (8):
  Add testcases for consistency in file collision conflict handling
  t6036, t6042: testcases for rename collision of already conflicting
    files
  merge-recursive: increase marker length with depth of recursion
  merge-recursive: new function for better colliding conflict
    resolutions
  merge-recursive: fix rename/add conflict handling
  merge-recursive: improve handling for rename/rename(2to1) conflicts
  merge-recursive: use handle_file_collision for add/add conflicts
  merge-recursive: improve rename/rename(1to2)/add[/add] handling

 ll-merge.c                           |   4 +-
 ll-merge.h                           |   1 +
 merge-recursive.c                    | 528 ++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh    | 379 ++++++++++++++++++-
 t/t6042-merge-rename-corner-cases.sh | 333 ++++++++++++++++-
 t/t6043-merge-rename-directories.sh  | 107 +++---
 6 files changed, 1060 insertions(+), 292 deletions(-)

-- 
2.19.1.1036.gce51225f01.dirty

