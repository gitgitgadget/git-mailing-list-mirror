Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0B2C43217
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbiBJQsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:48:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbiBJQsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:48:03 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467EF10
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR7N82ZQZql3W1YUnGnEl2PrU5547DK5/47PZROD3os8udIXlJ7PJ+GAG9imuNd8LDoRzt86CB1TPJ0upZ4NrlftlNUuZuGvn+bodlxZqE9iNaPZX4BeZn2V5rRYjjb40Lp2QQUbpxO6xjhYwbO4yziozVOuW/nxAb8yzvndtJqxXuusX7K0+AfgejS2CMrPAh4ZEBUOHO7HLAHq6Z6K8udA/Gmq0TYpF2ZM7hoIAn6YndXItapOU/Daxijm7YM8U2lI8+1be5k3XBCeffbB9KlM0aWZbIPhqHCdAHThGngbMP7Qj6zRcy9VWV71YL2HZfWTrmBB5G9ip5nc9tQQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDamv7cBtJ60D/5e4ONdknCQXhp8NeCpZi5f0SRunkM=;
 b=IuvKtz/wMJbzpjV6SVt2HU6N5eE1gQhBIJrOYtzZRZmfAVBGLY8u8hpR3WjABWnh1oIRZdgkDQoEhdxrCxDQ0uG6Y9NYtpt3Hy8SCBvS8jEAxaHq2HKg3JVLvPQk7LVLpsPAjYhlF6Pplp9YtPrTln8NI9B+eOb7w1yw/ydlCHePB76noBqvi2Nhi6SQpJvsazzRbFpethW/PnK30rrJ8y5wDVcXth4/qjTTjt95Bo6diLxFUPkxFZIl+naVRa+uSoX3RGQtTVtYQ4u1CormRQ7m7yHWK9mJdeBEvFu9ECMic+61QXB9VHHxqGq39u3daU4jMLcj/kqKbB235KLCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDamv7cBtJ60D/5e4ONdknCQXhp8NeCpZi5f0SRunkM=;
 b=FlSVbScsbOVjx8t856mkSoHd5V5YNCNuPvHsIN0jOmZOBY6T5UcBXgRL/7CF7vvzkajFUclD4MgBWz6AX5+ipr8LWCcq1bYfakJqdE0oPhglPrUi8RjSt+0JW3aDW8p/euldRgwB5BVHOFQkJsScSLEtYNaZmC1usA5J6a6m5u5Ie6GzuqOHFCCCsnHslqzLuKHL/Mv6NyxQv5EPXujtJm0q3JWSrn7DlKxDoJM7IhNZYgBCPFduclMMd/Rwx/zB2yDYSS7iguUn+djporddz0XG4DxC/PvV/OCGd3TQzxbKiSnhU0p2y2/0zf6GJO/gNMokKiFjTq8Iizd03KUrjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:33 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:33 +0000
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
Subject: [PATCH v4 20/22] git-p4: move inline comments to line above
Date:   Thu, 10 Feb 2022 16:46:25 +0000
Message-Id: <20220210164627.279520-21-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 415775d3-2116-49b6-7b4f-08d9ecb50913
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41014FF8713C8AA02338E90FC82F9@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGR2fhABbEBg32rhClqDupPiIeYKFUsmD2zC0LXBXd/ZVSh7zrjLK1MVeluatgZhqtrZ0+LWuOqwrXwsRE+bwYCTdl7H4g+ZGFFsc+CcFzoiNqLXcRiyWtRwFvogK4G8aSuhU3z2GThHqYu6HbGheD/X0hON+e6+zAK7j+SKvfewX/eoI54DMzWiEwe9VEpCR4l1YYbntlS/naY2XPEvqm9+ISm7gt3iykeAVi6asXT9Llos/+Q7b+KtLpgRG1FWRaOXjaVKFKUe4636akxHyJweTjfHyy1GOwXpTgxiua6TO2FZ/2ZLyWcW+fmYBPrHxvyM1Cn2nWFY3IGtxl4g/5JlBaQSDh9+EOnpKQSiA1RwdnAdpparqpNBcn4k0HbjOry4z2r1oyAPgZ+4KBin4ic1B4zcX6YZeW5x3WKByWPT3C3872/bToOsiGVCS66lglPnW4YY9BpIcw+fJlFy70ajBODNTveOSa1Rh1LQVynyLXXEISrsxZoWgcz9bvd2EDYWRVCdyDV6Agwk44UU2FLGqoomD1M0rTeslrfpkmWby1ENT7apbo2DnQt9vwVU95al9JosSMYyvGMqc0ji2nm80UZKYYseuwlcxyJQCQpvCXP3xjDGUu8knKWrgoWHLJenvKbQdYBLu076ur93J3jDfddfPy/uS+oQuO5jj4LUKa81UD5UBfmVAqWFPOByHYOEscJd9Tb9GuwDlPhBezl6ASzbJZJOJ8G9CwQqk6Hf6X+Y/oQV0YqfhCm9eJb2rYevciNtTZDNT6xsA164qDsLrXPyNp0gqNrrjMnxD5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6512007)(83380400001)(66476007)(66556008)(6666004)(66946007)(8936002)(38100700002)(38350700002)(8676002)(6506007)(55236004)(52116002)(86362001)(4326008)(5660300002)(107886003)(7416002)(2906002)(1076003)(26005)(186003)(508600001)(6486002)(966005)(110136005)(54906003)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FB6YorZIHLJdx7HJ/vIahpKgr9I4krQhzI2PJYOlm/YJovVTkYWTn4D9OnGN?=
 =?us-ascii?Q?ZfngJMbZBKj8uKOxq7UfGKnI5b8RRKEv9Zz2WUg0izYc7KjbFRhyhfNwZdm4?=
 =?us-ascii?Q?nxmlc4RZvX2h/d9ycIPdUj1zFkUgUja6RCHWe6Pjm5KMbpB9ZatXO7W21qY1?=
 =?us-ascii?Q?yaWvzXQDVxVf/oKshjv2r407T8by2nk9OFVQm30T8cLvaSI3DveGBmpaizun?=
 =?us-ascii?Q?b08opmL0n3uwHaJGn3NJRrpHYO/NOi2QP1p2f2HpfyvDxogFXl+pN3H5wEwR?=
 =?us-ascii?Q?j/VC+Nf9CKGeYZjhlolrj9I2rR9SJPWFy1kOp440Um/nYbSqFl9hsn7prVuB?=
 =?us-ascii?Q?jKZGMebgsfb1DD47B2panvSvNuj5OIbj+5ZYBLr6WTOOKtCwMpOo96ncnh0k?=
 =?us-ascii?Q?s8LBstVRfg+ak5a09Q6PqbClh2Od0PMpV4pa6Gdhe4yuDlZFyLGh5CAm/YA2?=
 =?us-ascii?Q?54ba7ukk+WGMjIM8VPf7KuD5rH2XK/9Q7/PApZggLKNRq6djgx7MTZ5Mun2A?=
 =?us-ascii?Q?rVFMiNV9wzJoNuy3cj0AtpS6F3ib5Oasuy36c9E1PA6lEcs7PHp19JCKDmzv?=
 =?us-ascii?Q?OwVF8QkYiS3AlydgSRp7AGVOdxrdgnDTbQm4i8N7agQCiwVR4Zpaaf+ZShNg?=
 =?us-ascii?Q?tZ3JrXckAGNoWaxWAUZt7ee44jJS0rh3hUPO1r4dzdW0MiDydDZ9OLAg7Ha5?=
 =?us-ascii?Q?1OtBPHsJ2G/QosnnAegScfNZ/YCmjHGam+J3EB4brlfZqGUYgeIrjQqvUnwb?=
 =?us-ascii?Q?RKWUWsV5wiNsfIET6uYY51LmUEPNcEhAMK/KLB4o97oGPjk8RL+tJzTxQ6rk?=
 =?us-ascii?Q?+ooG0kWUqO1ocMRmLtRBwd9ZA3W/z0fwuqqIzC+8oSwnpDfPiIlxalbbshbV?=
 =?us-ascii?Q?rcf2VPTJAdzO/m05TdsVeqkGVEPkhypyn1XfjqEMHWEWe+FkH+afl15l1BO2?=
 =?us-ascii?Q?RU7/0I5cYf+IT9kyYeD6KyyFySyksIWYQEcQ5L7rX7iYsbp6CU6/psyN6981?=
 =?us-ascii?Q?kVqiBwS+Td7YP4aJPrQ5heFMgjONadGDkl3Ow9NPQJtY2rqDzsuewx7kdO8y?=
 =?us-ascii?Q?n6csecxWxfvSxUr4LcPAhUaSAba1H3w7BSB4nifI0kYnmEmw0DXdrQno0IHN?=
 =?us-ascii?Q?Js5la8W9H/KiqkIPZDJKtZbEWy5Nqk1VINLA1cPMXhWSeZjXjS/0vjgzR76L?=
 =?us-ascii?Q?Rhgt63ZhLC8fWbmpp2JXdttdIi0X4had4sity3xPpCAeQSf/6hFTzkLbByGC?=
 =?us-ascii?Q?bylYw2HpJQScyMKU9UOUlaxJDiZ9GoLLkXHVVNIROYZmqVlZGJLKtrSF3bLx?=
 =?us-ascii?Q?8Qqpr7N4QlKFJitflE+aM+1k3PVpcD29cgauN+IS1WOhfej7PoDxK/RuOOv2?=
 =?us-ascii?Q?b4br8wIRr24WurbGXAw2dcBVulCFt8ccprnw72GThvoDlF+rHnioPCd2qo4E?=
 =?us-ascii?Q?YaFNDfITS2kerPyk7WcWnJA7+YMXiUdZnhQFC8U0Bc3dgeTTWuNrkXNk/CEj?=
 =?us-ascii?Q?OLmCglposjOsWHc/gvDPpEm2XiU8wO7hzc9HNfcjbRZ7cOTIynI7YhRRhRkC?=
 =?us-ascii?Q?V99X+WDaYqyJWZiVcsvdJdIgh/ue+vJ6OXJ3YfPG39PEmcMf7QHM+1hzT3Rn?=
 =?us-ascii?Q?HglawzaLh75uPGixUNB0m/I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415775d3-2116-49b6-7b4f-08d9ecb50913
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:33.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5JyI6o9qNG/STlZomqHthNfucAfFTd9yhTKJ2gLEEMYgpV4QVdsxxlnOQJzrW9JgFTLoGdCtGIqVH2splNReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
index c003b6246d..524a7a5c99 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1979,7 +1979,9 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
                     for line in f.readlines():
                         newdiff += "+" + line
                 except UnicodeDecodeError:
-                    pass # Found non-text data and skip, since diff description should only include text
+                    # Found non-text data and skip, since diff description
+                    # should only include text
+                    pass
                 f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')
@@ -2975,7 +2977,8 @@ def streamOneP4File(self, file, contents):
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
-                size = 0 # deleted files don't get a fileSize apparently
+                # Deleted files don't get a fileSize apparently
+                size = 0
             sys.stdout.write('\r%s --> %s (%s)\n' % (
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
@@ -4233,7 +4236,8 @@ def renameBranch(self, branch_name):
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
2.35.GIT

