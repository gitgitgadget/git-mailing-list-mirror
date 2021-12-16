Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E241CC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhLPNrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:47:23 -0500
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:63200
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233978AbhLPNrW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWICTmDbA2bCY0nql0o+ohltRWn0PylxPDLbnrB/ntAK70xbUpDgvK2/cOXQ8yUlRgJhVZOpFNouXozAhopuHIhY33aPc0bIkxlYb4VNgxXhWe3K3dbYjVHBc5ziJijO1SFbfeaxpaGCsZQgvP1HuoudLD+HnY5Dy41nBFh2lESqJnP20ccTCY7zxFU5tzG1u4SWDeusWC2pDFgQmOFf7c9fiF8bu4MRPYoBV1gYTiFw2D65hd0FG0NXTboJ3n3uuQJhGf6EJJYVmHRV6xNOn68Oj3NgBbo8SBOZWaBqt0his5tQyRzcBPMSvSTSQrPZi1StIJgkxBLNSzone2luuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCZSFVL/iEwwhUAbfeX0lfiW2N1XjCZXlIE3OhLttZA=;
 b=mXsiYSYEsj4r89t26tOUEJniuQJoQvZYoYvrC0pLj7AnplciMS2db1jlk3AuKMNQnEXK/DeqChGsMH2Gd1aXVW8QzgmOiewwWZ+HMIpQXVrcH2yuaCCZBQ+MfYB/xzLaKZmpqNCV7WWFCgfHmBWcoSLm5dQQ8bUoXAXslNvJdy7WPB2N6z6Q7bk+L+5wfko6ZwVWhvj8XjKkhlVPO+l/eGIR6uAb4lMykV9ZhlZNYPB9eZt46/bH2JA2fqtKw/rdRjW3ilcg1+BBCkdRxYiaQquwmNj+xdSn5qTmBYz+TYj5QML//Qz3eqfaoabTzjACCUTqHNEr7nTCHEDT48FddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCZSFVL/iEwwhUAbfeX0lfiW2N1XjCZXlIE3OhLttZA=;
 b=BCb2Dj4rnvm5ZHxgaAEbuwNYPGZn0gNT9nLW1HFey7I5ddu+90kEnuOL0TSmF6UgUpWVKJsMlS14cQvAAvr6vtOgiqHl+BjXqoeVTWL3yzTgPrRKAQxt44e/rfITj2jfgUVQR8Fy8GlNOA7n2n6GzXGB99np01MYcFuTRMVAm2gAsMKGPxY9xD8Dn4Y4VvI0i7clQIuBKndPw+wrOI9MPbL3xGshwv50F0BdhLKj6d6ibVhWka8v+083BRklCOYLBh32JiS4zfepzltfkJF+U1ith7RJN1ZEQUjHAg4ScwXrdCdeVuMcS4qx/tWkYnZ4Mcnqo2QXYcZSg5mwEkRZiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3443.namprd12.prod.outlook.com (2603:10b6:408:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 13:47:20 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 13:47:20 +0000
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
Subject: [PATCH v2 1/5] git-p4: use with statements to close files after use in patchRCSKeywords
Date:   Thu, 16 Dec 2021 13:46:15 +0000
Message-Id: <20211216134619.2048348-2-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0b00782-f9ef-4860-b28d-08d9c09a94b7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3443:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34438EC61C61004417931ECDC8779@BN8PR12MB3443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAEvQmZoODXERLyEwCicxljZ2t5m6cv2EvkGtlD9aIINMw6FHChZ94ca+txcEtqPer63TwbfLeJSEe1hFKjm7LFDmN2FuoaVpqdCJBmEVVY+nTdLiIxeAA6OpfeU9A4wu0Db0gQlv49UHroUDHEbVfUu9h3EPAaMAXKwm+a15orS9AkxQmaClmQ8um9jxUYa4T8MImD5biIxCcv8I5RCQQ33vdMEcKIYTKeujCMFFcC0auGZsH52rK3AS13SsrpZKWeXt+0dI905dZyFLPT+bj3C6trdhYzyCA2ft4zRFuACkYTLnJz7ZedOmUTa9FUkVgQZcrRQ/uufZA0BAgq2aTYgaS51F8W1i0iQSqCoUP7suTXZTDnP5Vq9xWqJQB79CB+J5Zjn7/cmq5K40/fpFi17TlZ5v8xPtjJc88m++rq/0dPlM4KlC2u0zoZIPfvDa/Dfvmk+eoHRhgg4zBDVuNttx3Jkl91JxHJAgIzNZvtmZHh1Ap0EVzAsISoTJV5ipH9Lmy+WVzWPrtTJcuGyt3UzPbZPRCPakaJeFJp45h4v2E/V5B9jF+VfgvnziZ6bDujE0JHpv/iSDQXD6KdLpmxUuzyIO3A6rkgLIiwpUm6hssWv4UNIuaqMKI35mFEhZ+Bx3nMGSJDlnOpcpxGWMoHgRDE9UEhQN7eWOWuVRWcFLw9wUaFc7AiRAS0LVe2WacaCm4lTk3c8vX8wQIuiHifmQkh78xUMN4mUDrZGnC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66476007)(66556008)(8936002)(6512007)(66946007)(36756003)(508600001)(38350700002)(26005)(1076003)(86362001)(6916009)(4326008)(55236004)(6666004)(83380400001)(316002)(107886003)(52116002)(8676002)(186003)(5660300002)(54906003)(6486002)(2906002)(2616005)(6506007)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AO3Se7lPlWAI/R+07O4GMcXwiPnb6kkavSeZktEcHAFI5BHODq73bNNeMyYh?=
 =?us-ascii?Q?U/VuizH16NDv86wcgaY0D3dXkfvFYFbIXZBM33Wjo8xUoFHXt25iZPYErf+4?=
 =?us-ascii?Q?LlUnQttMVP1X9PWIzaM6u+i5Jm8byiduOsnZuFr8XKHpLUWku9L8Ebf9Vn9N?=
 =?us-ascii?Q?xu4yQQlnVUvVPCKvG2DnMjkerYVrHrnkAU1haqH8BEhyTGU8rkkztjVQiNss?=
 =?us-ascii?Q?uYZgz28l2RxmTsD+iJGFrCVNjvJ2nL7KjvGOF5Kh6spHseSuybWXc6jp6zxx?=
 =?us-ascii?Q?e8jLSoH6Kl5+z7NCzSHtJUoiSlL+9qb3sXQsLKqkl3y5JCrlbn3e1LsRRuRO?=
 =?us-ascii?Q?Wmeu3W53fCLnwooLDzHa30Me41QTLxKmuk3WUBaOwKKxwJPB8szmRQ0tC5Tz?=
 =?us-ascii?Q?2xDBBTkaF+jvJS2UNttQ3cwmAbHlAZHUPEYpOxC3SwlFSuqgoCShL4E7OvKZ?=
 =?us-ascii?Q?a6aX4z4A3QFmpoeJ1PYX2+hvg5TgZXKbzd0pBBUYnCtm8EHl6jgZ3+4VRBLm?=
 =?us-ascii?Q?7/QlBC/KnjVJcPBW0i3KiPsodISF4AE44GkCNljTamlvGxsNePWlqHtIbCGp?=
 =?us-ascii?Q?Ehhcwvu0lcl5jj0BuuwImU1NhATfkkUaBNNSUX547NlXI4PXOzhebKXhmUd3?=
 =?us-ascii?Q?GsiL0ThtdIWeC5CVwgiTNUkkbQPAdAhUkk5OUmoMNJPzJNa8F5K62UwJwpyF?=
 =?us-ascii?Q?Pb1DRLV+d/PPAKUdELNyMHRJ3G5Fx1OxSCH+kVzB9DrPD6Yznas0sz1MtAXY?=
 =?us-ascii?Q?EvDZyz553GCuME9GtwhkBXkmbtzwj6f06gvjwZ0WAL5Rn3oo8oomAE0KRlKh?=
 =?us-ascii?Q?PB+PGOw8QGmuksgwD6d3htJ/CW2ZaRRX2cVH8/hTNug12wGNo788+yEGZyk9?=
 =?us-ascii?Q?TmPyngpPOv3hEaf7xoC4o7pyve69F3pe92wi6jjU2szzl20OrAeX+9t+w4Hp?=
 =?us-ascii?Q?/4frvDbJoE5mXHD8OCMJpeETSeRgZJUi7UD6JLp22GOmeABIJBE6+hJisyyD?=
 =?us-ascii?Q?6oORzyEsoxAxb/oK+r1ipugWw1T50RRCNqr4IJtmsNm1mC5eoyzxznYvOo7C?=
 =?us-ascii?Q?EJJd1aHdseWXjIzeluc/+KlTqnGd0/VvrYtWzIgaTkMITJRmTuSr8IQbv9Ms?=
 =?us-ascii?Q?n/WMKOmqf7Ih53WEqey4BldVI15qk6rHt8bgf6UfkQqAjFyE+qmXKcFM0Avq?=
 =?us-ascii?Q?D80jLdXN7eycmbFHj7mvl6z3D/FGPd7FEEuapwk4iYClZnMDc5b8qdPYE443?=
 =?us-ascii?Q?SVqaJDKvqqSfsOILf4P+nr6UofYUQy4thnyha21f4Ohb4PZEN3NZonvKojq5?=
 =?us-ascii?Q?Zfy+uNTIedi1E7Z6PkB4A+1aWqSZxBP03VCu5PZpxBzcOFEN5udF1YEnH9N3?=
 =?us-ascii?Q?PGs93zcUxKAFn0qiPDkrmEgNdK8Uv67SNyaV1Dat2SIXAtPnwlNuVMlkwW1y?=
 =?us-ascii?Q?J/SfkWvtZppI3JA4DlKoRAjfu/KUJcM3XPS/bAYIRUXvkYJRPJaKRC56ww2w?=
 =?us-ascii?Q?fOUqR+1pbMsCIl6zbAzzkDJ7Bj8W8x93iIlYuYSoxA48eynYFOSQo6aT9grm?=
 =?us-ascii?Q?6hkUGFkhD5pJEG08/51uy3fN7dZF5pbRBIEx8U0As1EFdUpqT0kZO10drmam?=
 =?us-ascii?Q?F4ioU/8wfUYjRpVjm98d0VQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b00782-f9ef-4860-b28d-08d9c09a94b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:47:20.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqTaTF7kynYx01m1rYRH2F4QrNRyHfNgXsOxrOmMueY66qknm94fTDQFbefB4gc/R0VnSlpjC1Xp18pZzlNreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3443
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
2.34.1

