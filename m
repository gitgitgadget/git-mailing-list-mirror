Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5DDC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbhLMWzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:55:17 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:28160
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244017AbhLMWzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llluau0891owRQKDXd0oW5upE1o8yzpYQNSDdfmMBPa/IPvKM9p5ET3uXzr4KE12Y7IV+WPAnHeMq0dk8df0iYyNnZ8atk3q+4UdgihX/FoLbAI8UeWpuGGWhAa2CkN7WkEvF/kA22zzISACpRkIbIWXCXekPqOUuzX+qq/aHgtRoYcuSXOHDECuwtzWaNECJ7wve1/WP3FHs6vAaTRrAFDpvE34ihr1nbhzMnfFnTC4nN7rNjcgftgfFMbsmB77Eg352XRhxjockSEJuNKVI8Rlprf8k1bwjiJ5nHTL8gq3xnKOr2CNDzkhwOXbFT3l0YWAVQcdSZaD1vS2om0bkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHpeo7RglVVW8Q65y/TZB5lZBJAOg9LZoFd87gAJ6Wg=;
 b=k4L25U2+b+T2M4UXJr/3ti5Y2YdRuoUapw8tltefwG7LYrEiYyjYNUA2Fmdp+M/Bg04JLBa+nwf9Do535NEV5AK6r6VVeJKmoGem+/NlHqzldB6De0H5/H/V31JwAfmsBL1LQDXv+Ldj/GnYgx1lMBJccafq0mJ/QvVPrl0oF0PAhqEa8E62YyWtDBG7OtysWt9Rtqgi64bUptZs8OjSqbSkb+fGNnskvIspeRQJu1ukhAuLfgF4TOmrGaeI4oUkSaW9dyQDmq78sigfwe+7PvttX5jYy9pX+lNb+jRViHwRNabK6tAedUGywmRe4iLVs4Z+h5uYGLgKWh60L5kEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHpeo7RglVVW8Q65y/TZB5lZBJAOg9LZoFd87gAJ6Wg=;
 b=YkM23RU83MrliYGJjpl8xSzD+K1MRIdqwNv6O2A78+eIE6zT7ln3ONfPu7JPPtwNkNy9greqI4Q/1yie0dtoRA51mCxy2EfrxTLFFdQQDGSwsaLxvf3/4FmD0n1BuYCVcGczgt8MeXfhsUj2KBAgv2LY+97tzkdlwTa/41NYd8iS05zxPEYzqxaohm13cI+jkxQaBDAXuxx0y2EZLlyI/AUX52NbsfA93Qzo8Oyx5SoOchHzmHDgHeKFTfXO4ty2DmmOrGUDfgzmBoXvTj12iCJE2IdCbDaQbOsiA8KzSwxwpEMEklH3OcI4BbBLGcwcm6U98TEDXwWpPckm0U9WrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:55:03 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:55:03 +0000
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
Subject: [PATCH 1/4] git-p4: use with statements to close files after use in patchRCSKeywords
Date:   Mon, 13 Dec 2021 22:54:38 +0000
Message-Id: <20211213225441.1865782-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213225441.1865782-1-jholdsworth@nvidia.com>
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8362a441-4555-4b97-e5b0-08d9be8b998f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1377C295FDAE8EC9E60CEA10C8749@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBYl2r6AM3Nmgq6bC1e9BLV0dOtkl9Pc57Dtghx/WhLOLqBcbi/xWmULu8oS/nFTv/225R8fUwjzlB2zhrKdDbBiqtMjzGXVtHiMpoAlpqFHgkiUWYRpM+pw7T5blvKJFAVx0qE6BHrUhvTIeJxD4C/r4+Jr6HIA6mmVKvohIS11kxczZ+0tyAOiScLTaYJyv2MKV79XblNOhjHrMmoMHv9Q9wurRnlbiiJN7oKQtfzwMBBVL466j9ZH0cJaRSwFvevYoF1mjEbEKVmuHIUtTdml1GUOv+Atih+rC34aeKopBFVFjf4uNAx4O1OluvkZyg9cZUIFoH6oUA2HBRsM7/73HDRQ3n9+IwTNuKxpcEgMeMNVOFa4Q9f3rIey9wEtWX/X8ZY6zakKX5gUobPXkP6mbaJ7RPQTjFHpz02fFMm7Ji3oHTJRSB1KMcyEmLwaGG1pVpoeV6w1GUt/7iZ6M8P+JcqlTleRAgdoW//4PPYPqAvpiNgPvtzuw3W1EbPFQtJjSmgXxCr1EFh5kTV1By+XAgeNgsFBHQsZrAkJrkU9GxCyzFpPHVpDQ/8omzE26nxapySQTP9GqaWuNPLli1nOk6P7qpaeNqTNMVS5mMFMiPoVvzsEZe5ab2ctBF4TMeAbkWko9xEgpsl+pTGzw5GO3jK8jjAOh8tx/OsuVpBCjYP6K4cjFzQWklaI9rWrBWXn0+IbOkfGIBWKeu/1a63pruiNQGLDnoPxA75llY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(6486002)(2906002)(54906003)(8676002)(8936002)(6666004)(66476007)(1076003)(6512007)(316002)(66556008)(38350700002)(66946007)(107886003)(36756003)(4326008)(38100700002)(86362001)(6916009)(52116002)(83380400001)(55236004)(6506007)(186003)(2616005)(26005)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k4cGuyfdHFn+4wofEzZPLSZIZrA66n4pfvY0dqCfvFBt7x1Ag/8yO1b4s9y5?=
 =?us-ascii?Q?YVGwEdaeixZ9kj9Tqp6exvaxHsGJswah9x4iriWGS0P+ymywJyoyq9rSNaiR?=
 =?us-ascii?Q?3ELYdl9ju8v5vBJIPKaBau6ofwON9lOWISpgiSNTwPvLvZinS6NYP9DD4jW4?=
 =?us-ascii?Q?ZTgR7DRUEDcVJqe+fNQFyHFcOQYf1bxfaWtlN3IpY50qfVd4McpbGisp4cnB?=
 =?us-ascii?Q?0xB6DAANxHIRE3XtLs9sGUGGABNjFBQZRW84L5wPAoHP60lrkgn86k6q0xkb?=
 =?us-ascii?Q?1JPqfq3rR2n3riI9H/KLX/8GN5LJCDVEOdSwFPv4ZVJR1HNpjGiM/PKJ8hMi?=
 =?us-ascii?Q?0UcNpW7mpigsKPS8naJwaukzOhbIFPqLC2mHXKuGFVRE9mlLZn0zOj5thnaK?=
 =?us-ascii?Q?YXU7Cklw6EA9hVn94TStPsVuw2PPg/eIgXEcbGnYPfZOEVUfPiyB04/fUAtv?=
 =?us-ascii?Q?bM+L8zHYW3DPPKGRrnf39NM0BNRlzk14HntcgvrzBzgcwdA6b790F/0XRzq+?=
 =?us-ascii?Q?MYjlaBI7vpnlEnPqm9FiQd5a53KHWs0xqIKJ3rnlbzJ/7Sfw4iMbMkC5qDrC?=
 =?us-ascii?Q?SmK1DTa9dhoj1xcyoBKfO4rbMZWcuJZZs2HEGDGEZsjd1pJpvqz/E1vSIxGT?=
 =?us-ascii?Q?kldKra81NNaVQo2CBJiIKWMIt2CNZvpcXebJlvEy0ZknUQwxR9UfJ0Eo+Eka?=
 =?us-ascii?Q?TdVp8p8J48nBmSudni34O1ow3urmJ7i0woKpeynty2pYcFwnKBKDDKISnMB3?=
 =?us-ascii?Q?OtHTtdTYITaX9DiPv4SD7B2FpuCGOUv4kpSK9MEW8NhABkQpKS96jDi+uLZD?=
 =?us-ascii?Q?F5cyIEe5nJDA/04ZVAhyB38//flUz6+RnMZevkRa/txTci1C9yySHwH8dSzC?=
 =?us-ascii?Q?byw5J+3OCAFrKgVvtKb5qGOcxWx9aucMfxd5n30GGsZ5OOItKumqKlp9XuvP?=
 =?us-ascii?Q?07wwJfxET7NiJAWqNuYiof3C5Br7t4mV8/BwDeTPU0GgyTXZ2xRoroKcJvw5?=
 =?us-ascii?Q?a392endzJpeAPT4hVCUKancUPMQoQ3quz3wYWQkSuod1Y5WOi52zpSgLJ/Ow?=
 =?us-ascii?Q?xpiVc7IgTcWwBzux4DH08manxaMsSD1R8z5/XEcbtZHAXOhOhXwJM94JLEHu?=
 =?us-ascii?Q?q4PbUpJxRAGAZXNcPwCnEawkjn2BBgV6Ip2uGl9QA7mviREyJjRdBSX4qThB?=
 =?us-ascii?Q?+wx5TV8FP8k2hf0qaxpBlvocA++1nXQtZ20haYlkgtoyzQ3xekPHxnJ4XIyu?=
 =?us-ascii?Q?Xc9RUEmPO1cW93E8tigjGRSXYyESJbTYoi0xcnxa6lPuSMhgI+w5bJj0GdYC?=
 =?us-ascii?Q?hTmkIQBoSjFrQeOXDtUwSDaDZAMbRGBpouj2VMAUZR6YOODV9wjXrIGmljW3?=
 =?us-ascii?Q?dM/8tOt+icrh2jP9SCR7MfXE5W2zZtHK159/J5zyGFoNhGN0lZKRaOYGj+p6?=
 =?us-ascii?Q?NhJqsIzmFRxxAJfLzd6DLLhNPXlNpuXXIgrkFiywaCjCpLIRuFMT/G5Rkn7R?=
 =?us-ascii?Q?uDc3m8RNPNz3zQUuBaLOpDefdy1YWWOhPyBBEh8MDRg/j1kgrfCGlHB7ejMQ?=
 =?us-ascii?Q?MmvIpnR16JQEEZ9LOZkQSSgdmjZAKm+cjMrxdBWOLyMylv1/Z4csJU8axFU8?=
 =?us-ascii?Q?5Po6oMZek1Y43GqtApOZs5w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8362a441-4555-4b97-e5b0-08d9be8b998f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:55:03.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNhMhnjT5kDDk6WOY05cC+FajgJtlNX0DtVhHhoa94ryntUVtbHDYMJepiOG5gFeog2Srj9l1DL5dY7Q46cg+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python with statements are used to wrap the execution of a block of code
so that an object can be safely released when execution leaves the
scope.

They are desirable for improving code tidyness, and to ensure that
objects are properly destroyed even when exceptions are thrown.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..226cdef424 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1757,14 +1757,11 @@ def patchRCSKeywords(self, file, pattern):
         # Attempt to zap the RCS keywords in a p4 controlled file matching the given pattern
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
-            outFile = os.fdopen(handle, "w+")
-            inFile = open(file, "r")
-            regexp = re.compile(pattern, re.VERBOSE)
-            for line in inFile.readlines():
-                line = regexp.sub(r'$\1$', line)
-                outFile.write(line)
-            inFile.close()
-            outFile.close()
+            with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
+                regexp = re.compile(pattern, re.VERBOSE)
+                for line in inFile.readlines():
+                    line = regexp.sub(r'$\1$', line)
+                    outFile.write(line)
             # Forcibly overwrite the original file
             os.unlink(file)
             shutil.move(outFileName, file)
-- 
2.33.0

