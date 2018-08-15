Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EFC1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeHOUr0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:47:26 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42340 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727604AbeHOUr0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Aug 2018 16:47:26 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FHqXxa019716;
        Wed, 15 Aug 2018 10:54:12 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ksvpj7b8g-1;
        Wed, 15 Aug 2018 10:54:12 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B9012228A054;
        Wed, 15 Aug 2018 10:54:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id AEEDF2CDE73;
        Wed, 15 Aug 2018 10:54:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, ramsay@ramsayjones.plus.com,
        jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 6/6] Remove forward declaration of an enum
Date:   Wed, 15 Aug 2018 10:54:10 -0700
Message-Id: <20180815175410.5726-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.553.g74975b7909
In-Reply-To: <20180815175410.5726-1-newren@gmail.com>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=339 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to http://c-faq.com/null/machexamp.html, sizeof(char*) !=3D
sizeof(int*) on some platforms.  Since an enum could be a char or int
(or long or...), knowing the size of the enum thus is important to
knowing the size of a pointer to an enum, so we cannot just forward
declare an enum the way we can a struct.  (Also, modern C++ compilers
apparently define forward declarations of an enum to either be useless
because the enum was defined, or require an explicit size specifier, or
be a compilation error.)

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 packfile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.h b/packfile.h
index cc7eaffe1b..fa36c473ad 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,12 +1,12 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
=20
+#include "cache.h"
 #include "oidset.h"
=20
 /* in object-store.h */
 struct packed_git;
 struct object_info;
-enum object_type;
=20
 /*
  * Generate the filename to be used for a pack file with checksum "sha1"=
 and
--=20
2.18.0.553.g74975b7909

