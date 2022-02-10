Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D091EC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbiBJQrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244677AbiBJQrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E913B
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxhUR4kdW+Pkt4XH+ilAwRv67LIq8y3FgR7J4re2d9eDqoz1MRfLEvBLC3L+lt4i17t2Ou/KPlx7h0/ydgwnn2UeEQ1JrYUScesbuGiW4bFntkJTITE2Mcyr6uZfrz2qHu0nKY/C6Kk+oaAlZY1DjveLS4gcDLyfGoKAaZHNqw5HR1C125TjTUZ/KHbbmwnQxeqgRxmXnP83oYm7PnuXUeaVEseoQJYPKMCvQjTs/1mBRHOOjKrJk2QEt3ljaqBgeivBOxf8aCQgZkq167LSj2QuIlQiLQfIPDEaFzgpQyGv2g/3Zpq1AwDFXoUvebvnZvoFCGrL20d8+exOCL0L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K95PKASvSmeqlJKEqAHOyvmXj6y2h+/wfdjSRX8Af1M=;
 b=k1uDKqVBcyyuQ/4iI5ty7tsNRiFi2j0/2rQX9r755s/2TynHRkVctkEhBh4+wwTMDBtTMznxQejL28mj2hHV6v+fRoMFD+nhTNNBmlqHwKJAMDoNqlZ8mfBqxQPrGbwKMlHuuKNy2pn3UUXOe56txYsFzwL7y8GPOxt5HXjw24Lcc7JF2qgBDxNDz12JTm+YNw7cllHQLGyyjvGzAyhVWaQ0iU6XAZAyfpkKg1wkD/IXqtO9O5v7O5OkOYnoWbHfrGYdcfIKOoC7cLJkkehUOtAm/IO6xEW6o8+Ej6YXgDlTS6mxZ3mhlCXHQun6Pwaoks8L8ryx/qonmPRuRb6TYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K95PKASvSmeqlJKEqAHOyvmXj6y2h+/wfdjSRX8Af1M=;
 b=Fw6zo40GEaiDX8QsWkkSOFMZMhpOpK7XyoR4LByKFNVK5syXOOOVdl53aYzfziM8eT0zjxAVOpt9IzpaoeUKDD2pKtDYoCaGRSerGW+/LWkweAHInAfUn5zHGfbxKm3ZRN4J/ZIZGPVIeefegHpKMQ00hc3SXd+tXL3IJhphAadyFGJvhjY27ZU81Vg7fm7PjXoCL6ZQL1E1bWfCCLIIb4NAd/NYNCOW7PyMOmkLYeoRPJT4KKMf2BXRN0IC8sR7hUUK2+jmDLe9kOz4MTXPMa9wTch+pZSlLsQ8CG/wAVm2smtSE+TA0HLkNIBwgqzvzUbxHPmDVUCHKnmLjxOCQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:00 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:00 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v4 03/22] git-p4: indent with 4-spaces
Date:   Thu, 10 Feb 2022 16:46:08 +0000
Message-Id: <20220210164627.279520-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d84f4579-a959-4f36-1252-08d9ecb4f52c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362CD952DD8592002F1AB7DC82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wADan0v34tu5vkfEDF+hSiQwYGK1e8fah/LGxKq9HC17OD8FUmR2zsjUZPlxTA6h5VZdKKX8LAQ3ZYeK6jlUG0sg4OhNKRmYF9KLi59SEL7tsahv24gdYyhmHkl+Oqeqjtx5vmUoKxAv3AOI/2ZmnOMDEDNCtbFb1Rrdnkh+iB1f2oerX7FiVxGDwTThLK7EW90GOkzrgNtcqDp0UZVG4MhuChIzUNY5nLnLTKcpUP9dy6txd2So7ad4ZHSQM+sA6zFZ2j69pFClcGn1GRSF6Fy5E4K3jbULlEhDNgY6xbYPQlvepiwVFjxjXeXEDrc1wP6xqf56rG7rYfcpO/mjGyIL89qxrA3VnpGxGu6GzBZ4O5gpCdX9aS6kkrY+xj70GwOPapUTdetYC/1PpE1Wx2+SuS2w++Y7pT++65P1fvmVYrhYU2TrZYqVMwIUOvfQznwyUyhBrGagG2sZVy1bs4oblUeixLWb2lY5/kpbPUWyumUcTS1a1opLAd81xypTmfo3N3Ow/ZsqnVBcrJPdKaK1pyg9cNrSa9oLYB4sTdDWONXj82O900X5TCrmGgMsN81+v0kQZXVgiMeoDFzUhhjyFOtIjWJCKNkfjOUvEQw9GPebStZQLo6l/JyNLC6oIv1hnFXNmvpLqaCNFK8WsKtMKIbSQhUd8xbPXpBAOywaegzWHxkU6A7dJHM0lp9q4CRcSiKhWz6e2HI3HscF+tFGeu98sbBuKj4JelacMdDyhZbmLCQrPPqv4dYpRDyOwW/gljZRdSrXiXU65Nc2cWqbT0wvtJAt0Lg8r6qd1ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(966005)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?505LMgYWtxI2IcKx12CrWNuRdOS2s99weRWqjHVbTHTlFPbk6v0lBGyiGDTZ?=
 =?us-ascii?Q?sXf1Xeh3A5EVLvOP9/fmdZlJvMHOw7ZYnTCfZqeRaKFzp3GvSnSzXb74P39s?=
 =?us-ascii?Q?wtFXIFDPxUzMRSQJiau99tHb/SeDxo/VU8gDgUl0o3qsmIXVfsbI2yevdq3K?=
 =?us-ascii?Q?ZnyMfUMqgMkq2RZE1ooqS8RJsB3bZFF1TLTuegw+jsm3x6zk/LfEGTJgD912?=
 =?us-ascii?Q?CBVpXkJHPsXcbF7oiT3b/QFnC47lywF5xRKzo5ujE3N8M+CbrHD3Z1vLaNJJ?=
 =?us-ascii?Q?GMxGGlvT918KN4SXi3nS3D2kjbC4JNIcZr3r1gSdMxz5vVgWW2Ar/yBGmVvf?=
 =?us-ascii?Q?2yp3tjz7n1UfoAba4+mAqUfGSvDh8qQ87yIOLlfeyfdp1nH6koetiXHCEXCT?=
 =?us-ascii?Q?RrDjUXc0c3y7F9SzW2F3TOpgIQSQ52ZterHf4Z6WAIAHrRq3lYCRFDxeQspF?=
 =?us-ascii?Q?fDi8CgeQ4I12l+klnmRMimslt1c2bvjtewBrgLJ+eHg3bPI59gyUnz7tviPI?=
 =?us-ascii?Q?zIK0GTc51O72D+pfj1VagYQvzXH2ojk5FNOOXDFp3xbRWAg05upso6iEmwTF?=
 =?us-ascii?Q?c7VgqX3bYFIKRN/aCDvBE+GSxZd8lCfDCNsTjd9oaSOYInKa352Y8/xKGwmW?=
 =?us-ascii?Q?02qny8xX2/NEvuLCXS02MmVD0IYecrBf3AU+wga+oksO0JeA9XMda1baONfD?=
 =?us-ascii?Q?YukZdLZlA9qza9gf8sWTe3W3ZDJRQWRorKjgC/KwpUdl5epF3DbQcKKeJfzs?=
 =?us-ascii?Q?H8JvwshYp0UhKxc8Ba8dDxoiNkaz/o1gy8trMrDdfxYdAPLrPtI/ISzkedS9?=
 =?us-ascii?Q?CFcVAFPIADVozVYaMrWoyXAyQeHqk9SS+MXK5PcghhZOlb2q8nhKGnKo9TLN?=
 =?us-ascii?Q?XheH+RG+cyCzY4n/Aram7ZXiyQ6A3N2z4qdAnkIyfJfBZg5nKTlGwi4u4twQ?=
 =?us-ascii?Q?AkaX/62ztp6ybxxM/VsLqqwBkjS/ktn6IJZ6FmlZNGa2rfmlcDu9NANX67F0?=
 =?us-ascii?Q?LtJDqbPkskBBhQ5Ilx1ec6PyIFK+eQfYwJIotgjzPfAiM74YFBuv+p5xd5qm?=
 =?us-ascii?Q?65WU/FBmvxmbpD+cMKZdd72xSi7faSKT9i7dARYgP09uoahbDu/eqNLIO6qq?=
 =?us-ascii?Q?LjG6JexEwrfdc8UfircZYAMvy0Ed+8A/Tj1QRNdOdLUroMw0r6BZz7h5z4l3?=
 =?us-ascii?Q?9txn8AE0tXOLeFbMJ0S0wo/FTb6QD9SIPZ1ZsxC2syMa8hSJwY2RpRvVxRig?=
 =?us-ascii?Q?ckN2VbbOXj0IA//ZBW7m39VLgNq7kwZJEWJWcE00JsxvBvHpaEtmMveOcUtA?=
 =?us-ascii?Q?Q4wf/RjEuUtTLKq5MQUQu0valJDy834Cv07D67FoFeG2StmSJJfIqLMHfqR+?=
 =?us-ascii?Q?gyNx5eIerJXwMuyljatstSgMCouJIleh+pmZJJHyOcACKRtnkn1njKQXyN9x?=
 =?us-ascii?Q?90Kfcfx3uueux8AQdgprBrsQdovXKO/BHbijSs/ahFrqgryCiCWxN8anvjHM?=
 =?us-ascii?Q?Romxur6MMN2AmCSVakXwdk8Xb7hdSO+17zjVpqQyNt8s3Ti2tQhr+X0Y4RMG?=
 =?us-ascii?Q?1mQKuVxEdTqGtUIpJFsAp3DrZRKBqxWqwPPw50CyfzJaxK/zQlTKLpW5bi2y?=
 =?us-ascii?Q?qLBVBTHn3MX0J/Q0O/8LHgs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84f4579-a959-4f36-1252-08d9ecb4f52c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:00.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/auCKAs3MGD2z2yC6y03w5LngPwe7ntQHcJEY9gVoA2ML+PZz5Y6EXHT4IZX52Be919FRtvH6nA+4XS2JTf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that all code should be indented in 4-space units. This
guideline is described here:

https://www.python.org/dev/peps/pep-0008/#indentation

Previously git-p4 had multiple cases where code was indented with a
non-multiple of 4-spaces. This patch fixes each of these.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index aabf657a57..a9be9ab13c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -877,12 +877,12 @@ def extractLogMessageFromGitCommit(commit):
     ## fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
-       if not foundTitle:
-           if len(log) == 1:
-               foundTitle = True
-           continue
+        if not foundTitle:
+            if len(log) == 1:
+                foundTitle = True
+            continue
 
-       logMessage += log
+        logMessage += log
     return logMessage
 
 
@@ -1094,7 +1094,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
 
 def originP4BranchesExist():
-        return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+    return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
 
 def p4ParseNumericChangeRange(parts):
@@ -2116,7 +2116,7 @@ def applyCommit(self, id):
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
-           submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
+            submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
 
         if self.checkAuthorship and not self.p4UserIsMe(p4User):
             submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
@@ -2565,7 +2565,7 @@ def run(self, args):
 
         # exit with error unless everything applied perfectly
         if len(commits) != len(applied):
-                sys.exit(1)
+            sys.exit(1)
 
         return True
 
@@ -3401,7 +3401,7 @@ def guessProjectName(self):
                 p = p[:-1]
             p = p[p.strip().rfind("/") + 1:]
             if not p.endswith("/"):
-               p += "/"
+                p += "/"
             return p
 
     def getBranchMapping(self):
-- 
2.35.GIT

