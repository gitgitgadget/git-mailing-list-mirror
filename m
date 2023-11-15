Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302817989
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PsNo71aS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A25393
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 04:04:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFC3wDk013001
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=7ZXJXHQ1IZdSF6EaSEFaAp3lUuWGQoIAIlmykT4r9k0=;
 b=PsNo71aSd1U8tWmD+h+jzZQ3yapKHpdSok/iRbQxJ74GkrzT8N/YkDWBBxWUIUyqARd2
 6iu/nSft5bY2fS2bW5YkBFTFPwVsTaddkMrhoboKVtL8jf4RDTzFGBESSQ3KaE07/YMk
 dMoG0ecXpKaMAorXqR4IpSwJMBOER+O9NHt5mF+ABGgWBJzjHh/3PcgnbaVS0YVvjJJ8
 eMqvocfu0NHNl9TGedjSxR3l3ewRFv/iEfWJU4Bibn3ZzMnQRlCPL9HiCh+z61PYNETj
 24U72qeedLTj2WSWtJ+Xf9CqCV7/AJPja0pxch6aR0bwjVVaIB3i3S9YcYmMbVz05QFs og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd7udf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFAXEcR014858
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqt6rmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFC4Tk7036119
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:30 GMT
Received: from localhost.localdomain (dhcp-10-175-48-68.vpn.oracle.com [10.175.48.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxqt6rf1-1;
	Wed, 15 Nov 2023 12:04:29 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: git@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH 1/2] diff: add tests for git diff --merge/--ours/--theirs
Date: Wed, 15 Nov 2023 13:04:16 +0100
Message-Id: <20231115120417.1327259-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_10,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=956 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150093
X-Proofpoint-ORIG-GUID: nS6MMff7NLZwcd75XNWcnvgT-XewgayA
X-Proofpoint-GUID: nS6MMff7NLZwcd75XNWcnvgT-XewgayA

These options don't seem to have any tests currently and the next
patch in this series changes how these options are parsed. Add tests.

Based loosely on t/t6417-merge-ours-theirs.sh.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 t/t4070-diff-merge.sh | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 t/t4070-diff-merge.sh

diff --git a/t/t4070-diff-merge.sh b/t/t4070-diff-merge.sh
new file mode 100755
index 0000000000..01ac82f0c4
--- /dev/null
+++ b/t/t4070-diff-merge.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='git diff --merge/--ours/--theirs'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_write_lines initial >file &&
+	git add file &&
+	git commit -m initial &&
+
+	git checkout -b ours main &&
+	test_write_lines ours >file &&
+	git commit -a -m ours &&
+
+	git checkout -b theirs main &&
+	test_write_lines theirs >file &&
+	git commit -a -m theirs &&
+
+	git checkout ours^0 &&
+	test_must_fail git merge theirs &&
+
+	INITIAL=$(git rev-parse main) &&
+	OURS=$(git rev-parse ours) &&
+	THEIRS=$(git rev-parse theirs)
+'
+
+test_expect_success 'git diff --merge' '
+	git diff --merge | grep -v ^index >actual &&
+	cat >expect <<-\EOF &&
+	diff --cc file
+	--- a/file
+	+++ b/file
+	@@@ -1,1 -1,1 +1,1 @@@
+	- theirs
+	 -initial
+	++ours
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git diff --ours' '
+	git diff --ours | grep -v ^index >actual &&
+	cat >expect <<-\EOF &&
+	* Unmerged path file
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1 +1,5 @@
+	+<<<<<<< HEAD
+	 ours
+	+=======
+	+theirs
+	+>>>>>>> theirs
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git diff --theirs' '
+	git diff --theirs | grep -v ^index >actual &&
+	cat >expect <<-\EOF &&
+	* Unmerged path file
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1 +1,5 @@
+	+<<<<<<< HEAD
+	+ours
+	+=======
+	 theirs
+	+>>>>>>> theirs
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.34.1

