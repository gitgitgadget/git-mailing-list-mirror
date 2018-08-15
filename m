Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A31E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeHOUrd (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:47:33 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53342 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730218AbeHOUrc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Aug 2018 16:47:32 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FHs23p018508;
        Wed, 15 Aug 2018 10:54:12 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kswngy8jf-1;
        Wed, 15 Aug 2018 10:54:11 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8F3A4228A052;
        Wed, 15 Aug 2018 10:54:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 86BF12CDF0D;
        Wed, 15 Aug 2018 10:54:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, ramsay@ramsayjones.plus.com,
        jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 3/6] Move definition of enum branch_track from cache.h to branch.h
Date:   Wed, 15 Aug 2018 10:54:07 -0700
Message-Id: <20180815175410.5726-4-newren@gmail.com>
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'branch_track' feels more closely related to branching, and it is
needed later in branch.h; rather than #include'ing cache.h in branch.h
for this small enum, just move the enum and the external declaration
for git_branch_track to branch.h.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 branch.h      | 11 +++++++++++
 cache.h       | 10 ----------
 config.c      |  1 +
 environment.c |  1 +
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/branch.h b/branch.h
index 7d9b330eba..5cace4581f 100644
--- a/branch.h
+++ b/branch.h
@@ -3,6 +3,17 @@
=20
 struct strbuf;
=20
+enum branch_track {
+	BRANCH_TRACK_UNSPECIFIED =3D -1,
+	BRANCH_TRACK_NEVER =3D 0,
+	BRANCH_TRACK_REMOTE,
+	BRANCH_TRACK_ALWAYS,
+	BRANCH_TRACK_EXPLICIT,
+	BRANCH_TRACK_OVERRIDE
+};
+
+extern enum branch_track git_branch_track;
+
 /* Functions for acting on the information about branches. */
=20
 /*
diff --git a/cache.h b/cache.h
index 8dc7134f00..a1c0c594fb 100644
--- a/cache.h
+++ b/cache.h
@@ -919,15 +919,6 @@ enum log_refs_config {
 };
 extern enum log_refs_config log_all_ref_updates;
=20
-enum branch_track {
-	BRANCH_TRACK_UNSPECIFIED =3D -1,
-	BRANCH_TRACK_NEVER =3D 0,
-	BRANCH_TRACK_REMOTE,
-	BRANCH_TRACK_ALWAYS,
-	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE
-};
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER =3D 0,
 	AUTOREBASE_LOCAL,
@@ -944,7 +935,6 @@ enum push_default_type {
 	PUSH_DEFAULT_UNSPECIFIED
 };
=20
-extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
=20
diff --git a/config.c b/config.c
index 66645047eb..66dca7978a 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,7 @@
  *
  */
 #include "cache.h"
+#include "branch.h"
 #include "config.h"
 #include "repository.h"
 #include "lockfile.h"
diff --git a/environment.c b/environment.c
index 6cf0079389..0c04a6da7a 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "branch.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
--=20
2.18.0.553.g74975b7909

