Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9269DC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhLPNra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:47:30 -0500
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com ([40.107.236.75]:16001
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234161AbhLPNr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdE6WRQ9IsPPXtXByMtEiihyHr7NOO2iY4nZIjoGaXUIVv6Gemyc1QkKkmHhuDd/3tCtz/lAA47b5BIpPvezQRrF+kjFXufB342EZxVhOMSZCF8wCNsJ/kygwo9ywAWvtaLei3kBX4trO3RDlMnwjR9GUawUsGWM9NCBzJWxvMXUp6FQkdfiw0/IwWnAQljA+jYUBPv8rnLNxSKDbo7mQDy8bAZrD2ni402r8FCCJw8aEu9/hTv83hovvCSByGvsRw0ErGzT8VlIA4NkxzWQTSNPIh4ewHA3wlGgCgFxbfCLa277pjyV6lV1HrnaOb+1Z0k/BQBsaKio//K7NH9kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnWs/DoFjkwU7fMlfgYt0Z/TrrkGdvPSkOgyur/7H5g=;
 b=eDwESMmtmZN82Gc+oDOfzI0ZqnQERTdqdj9HZX2Yg4ExUlQZh0AUMvQYjEnq7QQyvR9hw62fVRjo7s2QgE/upvpfc/ZmS9M8pSxqoulX1L3TmiiDqt9u/vFapE0QAtemH1QCfvS7UWZROeu3ltv7AcFHBVSFtup5LuIOAYinXMmeS6XlhWK2yDpNm24mMALC6aCnQRucFuQOVgFyprhDb/hE6Jf79bBzNlI+vUCIP5hf3MIgxPEQZo50c+o4JUbkmJR340op8Cr9xq2/qG9OecbNG9UMpZx6gWfK7+p3wLdO7wj1N/LwJmdT21F7qsIfHOfvJuR9nYUGBRekvBbfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnWs/DoFjkwU7fMlfgYt0Z/TrrkGdvPSkOgyur/7H5g=;
 b=AWo/2RiCYeDDF2K2Ab0UAnpBlndvO2wQaF754LHqDHdIzwPXnbZZvuYU/qOVnbs5cH7IumlIqJEBey/R9tcUySZrdHL1LWhxTQoZtDVglK+4XeZOF38fXV0dqxtxStpewB85sJoJRpCMgzKXzkz4F92YpyX0ihPC9+XHr9AwdNS2bfhmFxZRHI4x7knxm6sEv1XyTkbCK9AuqKtqeHRp+0bi0QX7XydZY+ACftJqbYiygo/hY4lP4Kkt9S+uxRuqemv0XcDzAoOoFsl3wcpjl9wzMegU/YN9Tgo5QGAwKa0NcrJhOJKvhWVYm9a2ERp7s9RfQUzqLLgxWjTgh1MTVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 13:47:25 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 13:47:25 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 4/5] git-p4: open temporary patch file for write only
Date:   Thu, 16 Dec 2021 13:46:18 +0000
Message-Id: <20211216134619.2048348-5-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216134619.2048348-1-jholdsworth@nvidia.com>
References: <20211216134619.2048348-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ac8f88-290d-4dfa-9c26-08d9c09a97c1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2946:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29469AA3EFCB6C3E9A12942FC8779@BN8PR12MB2946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VEpYYG2tv9r783io6OS+U+KQt1cqZdFqxIiHaCvBTjlvWgBqLkie5OIWI5wpj4NKJXBiWg7wCwgSl742dvWhRu5XzJH59adWKGdnJuFdl7iyPYTjsAfNXujtNYZV5PI+85DwESoUfAvJ8EWzi/dge6qdwGE/aKP5Qz2jbevzF6fx9HhEsRaZylsPnu+BYxOuTPglIsZ5CZE5/2dQoJzkMEi1BlEcXqjwtKoeDgjD/IDb3p8xTX4EmbQzSgkVEhiRivuTh3rzO27sWvoO9A221RW0TU12t9jaYWvJMhclmE0jufK6Kzc/X1MfMddOhfQV55MEV0LHzaw0HhhIfTbGta6rlvrE8qq9v3YnZ0BQIy6NtME2AHPdUAn4bZ2X6P06N9udnt1hvh1cewZQZjRzSYjwjBYrwxTDkq0Uyo74MDTuM47XklmUbAC4gC1PvlS0DSdBOUF8bpNCRWbzrNestbjijDJg/t4gbU8QAkM0E4jGwpnurIQcrN+Y++UshZg2BFz9K6dkYbSsSgK15en05xvPUbBTiVwd7MaK8l7maRi+PoYp/f5QycgRsETozPE2zZJanZ3zLTjRM8NEbVafz5c8sOuyiZaYLbmLZDeLBr2XUS+0NYFDaBDIh4+1w3EtVAUtRwfmnnvQBvYllRsL9J7mIt3bcMxNULB6KRDpxJcHuPUTWUlmk8TkVv+6XQQDN64zQnCktJdX7aKZyvmJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(5660300002)(66946007)(508600001)(86362001)(55236004)(54906003)(66556008)(6506007)(6512007)(316002)(1076003)(6666004)(6486002)(66476007)(8936002)(26005)(4744005)(6916009)(107886003)(4326008)(2906002)(2616005)(36756003)(186003)(83380400001)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJyQkZ6Fdr+MvT9Zx+Xcy2oOUY5QNNL0HIRO9cDzg4j66zpTYxOOvoXgEypE?=
 =?us-ascii?Q?I+bwoeHg5rOk5+ddKWMqwYRdEkQ3LLFbToK5MfBGIrVYg+DWYiaZyedce0rT?=
 =?us-ascii?Q?yl+voxQ6/ZHH6s6SVbZr9rOXPfT9oSR7lB/d5HDIWOlbcUr1zfbuXPhAqLSp?=
 =?us-ascii?Q?tn16L+gaPuXQHmEysZrYGWAQ/O5ZHrzbCJMKjCYVnqGkErLju/W2hv/SPT3U?=
 =?us-ascii?Q?QU/plTPS/5C365geVlM8OCLIpk0mrl1fI23OANw8cg/xPPg+KXojr8USyIp+?=
 =?us-ascii?Q?WYMfLh/jisDS0IMc1K+1oSQMer1Oyl5RG5bEEsSDdKKQzkQXMl20g0P2u6aK?=
 =?us-ascii?Q?yoUlolIedMmdiwgrirTCCIN3MuG+oFoV0zUftxwM+wU9J+xGnEK+r7mj+Ueu?=
 =?us-ascii?Q?1pOeFsHmI2dWil+3QI87r06UfEquCEMNTYa+Hz8kCWYywuQRsxfBa9rQ/z3s?=
 =?us-ascii?Q?d1vQ3mvIy5AhJq1+Y6aJO/fN7e7fn5gGQuczbMF9eLLruMXAmGhJzeaaQP77?=
 =?us-ascii?Q?x59otps3SFau57gDkAKKlccYIVvmbVmbPNHpe9dkHOaQDQEXWzBuO//eDsvv?=
 =?us-ascii?Q?6hrNcLI58N2cI23nBxXxkeOaPXSs7C5hKnH1OOQgmqsXW69S2Piendp/wRPW?=
 =?us-ascii?Q?sdON8JBqbMMtV3gmE6ulp/DW+PFPvXFWeM7s8l2ZCTQcal0DpAcaxnss0tgy?=
 =?us-ascii?Q?cj1qzxD26lNiMM/rzmFdXEH7rQ+JORyLBYfpCS4Xzszbctfj1//+3mM0Ky6o?=
 =?us-ascii?Q?Ua3o5zqCeHHiF6U17YtzsIkegbg5/iPYVeL7XYOuWYur+NNyNjy5WTH4qIY+?=
 =?us-ascii?Q?wfGzeQ2rGJSH8dV/6oKUA2cM22xRu2a1JlIKufwJgtMYn28hVjN6fTBYpO69?=
 =?us-ascii?Q?71EZM4CKY473Iz9Nv2U8mUJYhAG+VYjE0pCzdWttseat38p2Pu62uvUKvxOz?=
 =?us-ascii?Q?5aUJw7BJzlRRZwE8Z2HsQhsrw+OjfRSBI0RwgDHnme0tUmAKQMJGZJdS593P?=
 =?us-ascii?Q?0hdxNtfPCglNvOwMxQPoy5j40uTlI+8UAnFX7rhIyMMZn9zguwimcpSfFrqE?=
 =?us-ascii?Q?ZXEfxhvdzd5OX45SaG6ZHNTgghxHBNVrfidlAIfpEiKM2MW7kcm4rGgVPNUF?=
 =?us-ascii?Q?orV/linH64qbV58jlgLlCYRfpmsIc3TZH2uZs4kwOexcUdOO5EFSPpgIucqs?=
 =?us-ascii?Q?dbqD/1zqcbiobQPClUUTKFCWRui18+uQv44ztOufWqTo2mHsJGyQUc3Gto9c?=
 =?us-ascii?Q?Th/dPrrkiTcHCYmoPZEB08nULYzgWOYIIUn8wPMsi7J4++I9SXxxAZbrYnmJ?=
 =?us-ascii?Q?Cgh2FgQfvOs0pCtjMp6m8q8hsQXznXtR2/i26gcNmZs3nTvK43NfagPAtcFv?=
 =?us-ascii?Q?q4qNAbkl0OYSYt6fHMNGg0n7tTA/AKi/Hri9JEq0e5we4Qa3rSI+ou1XsE1k?=
 =?us-ascii?Q?5B3UXl/qZbuV6fS6itSyYaJrgN1hnW3yNy5sPH9mFv9tBUiFv31Te44wxZuC?=
 =?us-ascii?Q?yOxRB1QzRl7ec2zHYHYO41QleAtdfaV7/to8PlRm9Bu83PNllRyH39yTUi6k?=
 =?us-ascii?Q?0C03p73Fil34mDR3Q70CmgF3fyQL/d98RoMf3cN/IW9TV2FrkNb7XdnkEpag?=
 =?us-ascii?Q?Ig+YLmmg28bf3Why7CAitSE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ac8f88-290d-4dfa-9c26-08d9c09a97c1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:47:25.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc9/eIeMK7IbEtZtTvfimDkB2zP6Cp+AUBwjCwOOJo8XuIBpWZ8oe5MqZILl/IS4+SRhlp/gbDj5fY5iOLiMxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patchRCSKeywords method creates a temporary file in which to store
the patched output data. Previously this file was opened in "w+" mode
(write and read), but the code never reads the contents of the file
while open, so it only needs to be opened in "w" mode (write-only).

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 509feac2d8..7845210e69 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1754,7 +1754,7 @@ def patchRCSKeywords(self, file, regexp):
         # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
-            with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
+            with os.fdopen(handle, "w") as outFile, open(file, "r") as inFile:
                 for line in inFile.readlines():
                     outFile.write(regexp.sub(r'$\1$', line))
             # Forcibly overwrite the original file
-- 
2.34.1

