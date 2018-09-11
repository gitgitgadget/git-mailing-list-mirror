Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326791F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeIKX4a (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:56:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59728 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbeIKX4a (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Sep 2018 19:56:30 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BIrg0i019670;
        Tue, 11 Sep 2018 11:55:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mcc9gn1g2-1;
        Tue, 11 Sep 2018 11:55:49 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 371A72101CD6;
        Tue, 11 Sep 2018 11:55:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 2D8B02CDE80;
        Tue, 11 Sep 2018 11:55:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/2] Fix rerere segfault with specially crafted merge
Date:   Tue, 11 Sep 2018 11:55:44 -0700
Message-Id: <20180911185546.10449-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.2.gdbd064c81f
In-Reply-To: <20180905175605.12341-1-newren@gmail.com>
References: <20180905175605.12341-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series documents and fixes a rerere segfault (dating back to
git-2.7.0) when a merge strategy makes the last entry in the index be
at stage 1.

Changes since last version:
  - In my last submission I only had the code fix and no testcase; I
    even commented in the commit message that the bug "cannot be
    triggered in the current codebase" and mentioned that I was fixing
    it just because an exotic external merge strategy could trigger
    the bug.  I realized later that it is triggerable without any
    exotic external merge strategies; built-in ones can do it.

Elijah Newren (2):
  t4200: demonstrate rerere segfault on specially crafted merge
  rerere: avoid buffer overrun

 rerere.c          |  2 +-
 t/t4200-rerere.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

--=20
2.19.0.2.gdbd064c81f

