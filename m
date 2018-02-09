Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E61A1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeBIXO4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:14:56 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47538 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753073AbeBIXOz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Feb 2018 18:14:55 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w19NDc4D002217;
        Fri, 9 Feb 2018 15:13:38 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2fwbtpshbg-1;
        Fri, 09 Feb 2018 15:13:37 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id AF6A62244D02;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id A61092CDEE8;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/3] Make fsck check other worktree HEADs
Date:   Fri,  9 Feb 2018 15:13:27 -0800
Message-Id: <20180209231330.4457-1-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.75.gc01c8fdd7d
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802090293
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset adds checking of other worktree HEADs to fsck.

The reason I've marked this RFC is that I'm worried my incidental
reliance on "worktrees/$WORKTREE/HEAD" resolving as a ref (in patch 3)
might raise some flags for others.  In particular, in [1] Peff said
that this refname resolves right now mostly by accident and will
probably stop working in the future.  However, I feel that since fsck
checks the storage format as well as contents, it seems natural that a
change of storage model would result in the fsck code changing and
thus that I'm not locking in any particular ref format long term with
these changes.  But I want to flag this issue for discussion.

[1] https://public-inbox.org/git/20180207181706.GA4227@sigill.intra.peff.=
net/

Elijah Newren (3):
  fsck: Move fsck_head_link() to get_default_heads() to avoid some
    globals
  t1450-fsck: Add tests for HEAD of other worktrees
  fsck: Check HEAD of other worktrees as well

 builtin/fsck.c  | 73 ++++++++++++++++++++++++++++++++++++++++++++-------=
------
 t/t1450-fsck.sh | 27 +++++++++++++++++++++
 2 files changed, 84 insertions(+), 16 deletions(-)

--=20
2.16.1.75.gc01c8fdd7d

