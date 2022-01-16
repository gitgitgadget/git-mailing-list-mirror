Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B9C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiAPQIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:12 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235618AbiAPQII (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaKGIaWs8+uT8cfZrTHxkoVsZJCCZAyYR2Fw+OsBZf/9UjWC9EIz++q0yWJBvJJU5dolYXtc0J0Pe5TilJVNs3MXwcCbGw5Wj08FfHLQ1yTZ5nDr11mRX50/8YbuM2nNzq0FTCiOkbO9D8HP8OAXLQ8QZrfsRfs8XWDGiV5zHiAs0iWWHkq8WvpPNP/3kDNH+111H/4HCuqrirIIXtwoXMLkuXM3A6IYV7zMCKzwpuOo5S4yyFidUlUMfnqjbb75sN0FTN4DsQEdg2uQRpSF87YftJ8DvxsksambahApPrNq+6XP1azOjOQFm3FHwn7JG+pG1RiCh+tqQxFSdVRRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epiKkGCXuhMo4dg2OZm3ssrYw+81eMgMWFNhFgG2VGY=;
 b=aQI33P8zmCIrEyY47dc/Zb2RxD3NAig22gQe6QS2I6niRiaer9VWPfxEb7EHkACZXj+hs4S7KIj4xLXpKrIMa+W0gQs+lzIk/YQbhrw29V/zozT03eocNjdS2S5NML2yie43EzZR/KrLejNll+9JmF11QoQq4gMBWwgaufLSuwaspvZ33EQO/AEqBvQ29j8mbiYWOBn3/+S+zznmgZSwBMntRyLrt6tlzom0W642i0pb5BEWj92/ZMwk2O0oMDFjzD/Nt+M/a0L8mTMUiXewd0z2gMjXbeILUTZoLfJl30k9kGPK/5iOPU7cFcfm6Nii8v5gV4WvcqQHORJ3lYrlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epiKkGCXuhMo4dg2OZm3ssrYw+81eMgMWFNhFgG2VGY=;
 b=HcfJzyMnisb7WUwlDgdjx0Jzc5HI1M4bycc8Ob0Z0nmnHPt5lbXyJylRUPEpBKTZ85ay6slWLkHw6BnmCdGdM/+XTiFZM15G/EDLl0pPJJtPsgVgoGfCoEH3n7rvS2Zgn6PSwwcd4yesUFrCVm358BIpYq34IHPPgbR6//b/ufZdQLtDMO2j/GT/lOEDTU5lrJJSP8E8/lgTPtzNJtmIJlFfi+V5UgvzNyuQlB0ctbzg3CuPKxPp/Uc6DNwaUYGwwZnW9qibbiI5/TMKuwgU8yJoCiz4D+XbYPHoLaVExobNZgP8a/5FUZHKicDbSCVGDfahuJu+l1NTWq86ZDCWWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:51 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:51 +0000
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
Subject: [PATCH v3 20/21] git-p4: move inline comments to line above
Date:   Sun, 16 Jan 2022 16:05:49 +0000
Message-Id: <20220116160550.514637-21-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc33a54e-6503-4808-e64c-08d9d90a5903
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB25975FC8B2C8EBE9D5BC7C58C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTV3Y8Y03ytovvwMcuRqBHrLe7nlQ3EOCYvJrmvp2u35AKVxW4LaSNz+ITI6XrlaFCUeAZAPxIkWjP1OPlwgYPPKL+z+MgOw7gH67olvRO5aZITOGOMmKs4mEXVGGUCvwJgPSzPmNfITDi0souRYurTYLkZrR2qO4fA29Eoem14pQUXkwTWhfWm15EKE4ijfl9DXfsOlHM/CpI7O7gbaqvMI1AAxhbYCyR0FS3AKh9APXl56l8q0RQ/G3fh7RyB2LXWt4dhVnYUElO8d3hp9SHwAhxJhQLyVr2idW4H6ZrDdxUz43v94wzbnQyE3yDYiA0KOXwihMkxufCJWpYozkmLn8GkZEAbB0jjyVPqH7c6DSxbIt68ZYmeP80dxOkwN+dSkAlQ9rJwusLQ8OPeEGIwK7nm3FeBLKI/QWXD+HKZFaWwwuDIGZMMa5a6LvjzPSyDO/60x0jz9GbCSRHpH40prRz8PlzDCWyGsjhRanw0sFv1EIRWVKSqaxvmMq4RGb/rjZoW2ztiQbhIlHUbWWZj7xReGJOEWByc+XDsRmwt2ZsAMUPgmlfPb35kGo3s3fhA4FDYVf0YMgE0g53Ppfwn54Reun8iGjIttx3SS8IQt4TjSKNaC/ofBqvSPG26XOqlWAYlUnjl7wFQY4ZnztVdxr/ZiBXl60HLJZsVT/nQdNoPuwLoTwBNoiZC72oV5cwpH9WMSv5oZ5TcLPmU6nLB1YIjRTg3HjXydEbDxFelQ4lCt74VKwNnmxbqK8lfa9ALIZwtTjVaTvi5VtGHOg6xSWh2GT5fBipgnIU9znFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0nQre7qeMwILZkeX3PrpCR1hznapVaslo+J0RCWKar6WXDEqP92iLej4G9X?=
 =?us-ascii?Q?DNV6lnW8hzBtj7A+hsWOd+kc3jma/hziNmlUMAjEHX/q6Z9P1S8Hr6FWam4j?=
 =?us-ascii?Q?NAsuOXyaUBQp7e//Im9eWJp/CTimi43eALFFX9kNMr/Ww5YqWf8nLDARpCi5?=
 =?us-ascii?Q?dAOy1pMuybi2CjmXJZ6urBOJcrTvl+G0HagG4hy9eHJgz0TpSc27VPKzP7Rz?=
 =?us-ascii?Q?/Vi4t8lN7QTZZJd4cfnuvI3aXKsgOr6sFF34kziFoc1XgqtyVTxzjbOUtpBH?=
 =?us-ascii?Q?15+burW1UcQiElIKgwl8zTvrfHtSwzmxk87JzktIRipXOGiRKP8FHoM0+neN?=
 =?us-ascii?Q?+Rj1l6LO7hhvlOILA/mASYbzgblHhOWwYKx5NeIpMRiIptp7V8dC60Re8C3t?=
 =?us-ascii?Q?IUGM6ZEG3nWvvFNVZknA8Bzq6Ge2PzRUjcOS+KU49RT4WQcofFV0FJKmxbFJ?=
 =?us-ascii?Q?5ixoA1Vm7PHtBL8gO39qqTNSmoGiRYux0QfM98niipFSlF5D8HFEbNEL1Rp0?=
 =?us-ascii?Q?vO18Zi4sUl871WUz+16T44NHLWrof7NMML6YJ90lfjE9rgwKH+k4HI0bjxH9?=
 =?us-ascii?Q?rrVctPiHD7pnbOZUHyvqE1P4TFCTIPCO9isKLMxpD8Hr4kZmr8tkiB1NPic1?=
 =?us-ascii?Q?bXKxulaVZq3kOq8OVc99nHCy9PRuwOF7m9jJ2BNnjPv0oiXfk7XQ0vt4sgG2?=
 =?us-ascii?Q?7dlQ+/+QUOzBQmOz6KdX9AvE7t9AHclkC3uVkwXzr9CoK7KyIJMW/mHR7Fsn?=
 =?us-ascii?Q?bRzx2xkC1Xrkb9zVs+kUdWA16ynXUg0g/EkOcu3DdS94IiV/5XSVxSg8kouQ?=
 =?us-ascii?Q?+GsDXFO7i/KVqK3aliqv72b7ltmj5kZnjFqa1onjzO21mRCmJx+PYPHSW04k?=
 =?us-ascii?Q?Ug6OYNyUyH3eMioqIjfwTGBfZ0JY8RB6XgHFBnyM8QAh/CE/gKD1HiB41FFk?=
 =?us-ascii?Q?JizORfDmcUtbNyHiZb0bJriwMY++NZq+HTXxGKUPpT1VOzr+rs5snrmdrAHl?=
 =?us-ascii?Q?XD1L+ZxD/dqzW/vl4XLYHD3JY1BRiAsA4+Kh3g38uSBJSCcGS/wjzaL3mdit?=
 =?us-ascii?Q?WxaFJEBrZKJ0ETZ7XKu1hkoGrsHvJKrleANDiy/7e7b+uns74IO5fiSqKU76?=
 =?us-ascii?Q?TlYQWVgPmE0+JL28wUrdreLcaQMc8433VLHMzmpupweBfSU4K3yAnFKv6TXl?=
 =?us-ascii?Q?NxyeJX38KekYKGgSyEHSWywBzMQ37bgX4+qTfNG+/MujZR9igRIfGZYywGLg?=
 =?us-ascii?Q?gYdB7YQuIukTrjvXGoA2UsQE3P89N4VB3+heh9tH4LLl7+fTJZsVuv++yN/5?=
 =?us-ascii?Q?RuRqvYOnH+dyVBpFhE+RYoZm+qzBAlyk7mGtMJgEsgmFAjr6SN7Mv7+GO2LK?=
 =?us-ascii?Q?o1ENkbAr+QOpo3RgMdW1Uyd9NQw0aUsG19TcgK0SihTqQBZqP4OtZQZSfvHz?=
 =?us-ascii?Q?L0CQTto2jdFXntkCpSZGqhtEvcEfY0twKeVy33wmesmczpIyRZzL2jgOtBTB?=
 =?us-ascii?Q?IGkyv08Y9vXoXDStnfFiIyb65xTNtvcFYDfHg2xBPAvwwKMpAhR43g3wh0XN?=
 =?us-ascii?Q?6uLocXEGyOYBjVbyg0VVCHsowl1RWmor5dZfHWUY3yyohIqdNzqc+ZATn8c5?=
 =?us-ascii?Q?SyuCHFbyOt8rdgzGpGUqGSk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc33a54e-6503-4808-e64c-08d9d90a5903
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:51.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNbCQ02iYvWaLdUZUgny6uQSVGXvFitIhsgANzpgnNqvVN9C8HMXwpOdO/mHr+/u8GOZ+A44UgUaPVwP+s5MEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that all inline comments should be separated from code
by two spaces, in the "Inline Comments" section:

https://www.python.org/dev/peps/pep-0008/#inline-comments

However, because all instances of these inline comments extended to an
excessive line length, they have been moved onto a seprate line.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index accb1b0f1d..4d291d0870 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2037,7 +2037,9 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
                     for line in f.readlines():
                         newdiff += "+" + line
                 except UnicodeDecodeError:
-                    pass # Found non-text data and skip, since diff description should only include text
+                    # Found non-text data and skip, since diff description
+                    # should only include text
+                    pass
                 f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')
@@ -3033,7 +3035,8 @@ def streamOneP4File(self, file, contents):
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
-                size = 0 # deleted files don't get a fileSize apparently
+                # Deleted files don't get a fileSize apparently
+                size = 0
             sys.stdout.write('\r%s --> %s (%s)\n' % (
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
@@ -4291,7 +4294,8 @@ def renameBranch(self, branch_name):
         for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
-                gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
+                # Copy ref to backup
+                gitUpdateRef(backup_branch_name, branch_name)
                 gitDeleteRef(branch_name)
                 found = True
                 print("renamed old unshelve branch to {0}".format(backup_branch_name))
-- 
2.34.1

