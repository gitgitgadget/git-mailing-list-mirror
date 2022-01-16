Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A2FC433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiAPQHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:32 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:11542
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235585AbiAPQH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCja1PmHaJiZhkjFaJFu2bQfky3bk5+Z58kVPm/bstwwRmxykwrmmG/V0005bF2HziEZ4cmJtrIOaWCGg0aD+s6ZHlEhSJ5Z7fRtWyr36DTUqJR+SpI+QDQ2UqcYNG6mh8FbQCEeaKTwUFmA7gjcSFKhH6H1SrIJ8/4l+2m2TMsat72cGCvUD734/KYLZhcRiKgYUq17yKlfhsERz0/gmD3pAmIeJRqy8gHOi0hiIKO0omxR5BptJS4CuNHOpmVoSM9vxToB5YGfzWDd3b/J5XSuil5ypQ7MG+E80aTz+qU60FSpQ3Bl5wWwX/QP0Cw7HZdBBqRUoUbq4RMZSHrECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw4gno84/uCTVqTdMb4AVoqPPb5ow0rltv2SKNRwdTs=;
 b=j5FFhqvjWkk9J0Vfyya606bVKQSE/u+kLDyI05Keb714rfbvu00sK3HpLwkqH2dS3FAaAOHGfoP7YWj7mtJ3mVyGIy1XVJvgWV6wPq9nVCaI9F32teMUWppe0tDOU7g+/ynmReUhXMCfLMShxWIYtqi4YG4HNAdRqDcNk/o/FHQ4c7G+FkoNqs6AChdQuqBddOtfkIEUuNT1hFUWIl+dusNv9q2uiV+gXIoif3C60TLb+pDEobsCy3WGI0sOOhf4J/vfxncRWwJjdSeNDYcUv3U5G3SYSVcOXNVtJLqKKA1jiSTvSfTCgrnlpgFA0YX8ri2bQb73I/NAZ8+klsIZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw4gno84/uCTVqTdMb4AVoqPPb5ow0rltv2SKNRwdTs=;
 b=c8mGAaFoHqu52IMx7Bix8RiJ3m2n2fVvyzOWfuj0SUHkxppbeQJCKD/thmWdTklDzXhGjSnucQIn08y+ryvGRAuRJx+HteGTzb6DGezIBgN+MIf2ja14q46Wn0lvTwB9t/5sFWVNVTHv80oFOZQEQyJOM2K0EbkaZcU/bdHg/ZV19VTGhrqrHc+ImxbC25LMWsotqQZQU3CXw8pQc0Wfs9kG/BWJw1RPsSAHlN5tBO5S6GMAW/U5aTQgDscwTvo9v02YtpWmdS+gi6IvbTlJvMmK2o5QJ79D9Wl4UN5xSAzNOyFBQ0l/mIgUhLiIDjBCoOB9SVA5q1TawiWKbRM+6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:27 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:27 +0000
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
Subject: [PATCH v3 07/21] git-p4: sort and de-duplcate pylint disable list
Date:   Sun, 16 Jan 2022 16:05:36 +0000
Message-Id: <20220116160550.514637-8-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff1e5769-32e0-4b28-a890-08d9d90a4aa5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259794CF8491E47D79985999C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjsNTwgjTS/ld5Mkw9bOBFv5KrwylH83GuXsdctjIGtUPnPs8Ys69VBIr8RT7KmHIM0Czh5K8BhdKf6rnLTZq0KHSLRnM7NNLlqJlA0+AjbhvJrJ9bXUUj0BPNTUVCzveYAnX6N303zbL9pan1Q/S1bMokyeeR5PV6a3jqzfqHdkutZPSUtf10z2+TXt6kstAdb9c6iCPIPtzEZ/g6FhD+lX51zFVx7rRQPLpB7X50x3yIwhWnlllcEgjKiWbAsDnlVL1BHF7iK40rrXhY0unqdODoMgBM8eygQSPJh5oKyKoTpvAEeVqCJeI0AS/76zjLUpqT5fGDx6sCj048KGVcjhYeBH7xu33KYJCNqEDaHxfM6xC3tsu/qpvWZau7dTpInC5DRCWGHo5TU2RegNnkFpHPLmDPPS/crUjQ6dnWvqGuBZtaxLPizsB5mWmFQlrdEUVo2FgqUDkKQi6uMoY/LZic++EX9OZgMMiV1QwBw81ksTT1MozjgFFL3EhNtV2U7AzXgj7sD1/4fAz0VksIgq5cPaMmYr7aw+JHYaHjfDmQ9G6CLJp3YO1cFo7CvSXdHE56//DDsd3q1d6D4/63t6ZEbq/5gTBLWRbaQPS8mFoStAZdbktbKZzmnNhNMJOo8ZY9k0CeJfxDllkaacTz0QEVIUueuPKgs4lNEBmb+mPRQaxhz+O/08gJ94aO6ekFUCU05iy9oSSVr8XopgFhrua8Y84bp34ZLI7kQyRE7kQ8N43AwUiTWprFakiXpzI6Ygp9/Tnmz5wpkNAvriswApquwXlNDbpF/AQpbndH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(16799955002)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(15188155005)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQzzBM5XnMRtj/iwzpwRYX4keABbN6Ee8O/MIz+RnjF2iDO8siuGkT2II7y+?=
 =?us-ascii?Q?ruwy/+gP71gVE2QJxiedQRHKMVoy2iStAnc+3kLthOB8LEj/8hEIgfCzESYv?=
 =?us-ascii?Q?zYhxwv5d3X1Mj0ciOEc3YAeaiEB0Yi0U9pYQi1AZC4fsXZiv+Ks5I8sAcFQJ?=
 =?us-ascii?Q?Ci0Lz3+Dzi0dcZ1aQjWBP7hxOmzmFD/1jMRKCfy1i7ZXYNi3O4PNI29h4wCU?=
 =?us-ascii?Q?h9ybtbJ4Ldg9e2CqjiPWn7Pj9md3MACllJe4DbqacTpHRuh2kBkEI5OUcvmQ?=
 =?us-ascii?Q?+wdpT0n8AtNn5UmyCFSREaNJBtNLShhnHOf4Jqe3NWTvrd/EnOpA39HG5X8S?=
 =?us-ascii?Q?y6zsF20cM8fEJb6//cP+Xz5Zj5TVA2ZaCyVsCxUoT0c3hayNevbH22V1WDeh?=
 =?us-ascii?Q?YPEZaRsDS1DNrN9UuGnik7LcAQQ75GZfoLAyRVel1lFatjkk1nv5cJmdajkA?=
 =?us-ascii?Q?HEIw3XVJHZ69uvrkTMuIHUg/m5LdohPaGeuNPW+dJTRUuoYw/UJ7JsZTZ9Yo?=
 =?us-ascii?Q?jzRKYu5TPo+W51Po0/qoG1QpdEMudIeZORmdLG+lQnjsZa7hO5KZZVp2C2Yx?=
 =?us-ascii?Q?vAYLL7yUbsNESDrV4EiYBS3RYcwvz6irZ7f1j6GURYlsMa1eq/GiHMizxM7d?=
 =?us-ascii?Q?yLFd9LKt5HQINs1+KKzPx2S3+r+04N5C9C3OkiA5X/kthAuTzJcIq8xFnDCz?=
 =?us-ascii?Q?sJsFNwW2AinhI+IXU4gyhsRQngX9gtcrQcZyXest1LhEf4nCiltWQaXvPR5d?=
 =?us-ascii?Q?rVUH8VWQXyIM0B1Zx4tH5TdI4qc3g+uub1wvlOs5WZTvPtDrVwLxbGW5OPH8?=
 =?us-ascii?Q?ESUuZey1/DrhyWQD0H2k7HWmzsuU0zrv6vAMfytItCqPBl/NWFs5g0aWslvv?=
 =?us-ascii?Q?n1N21m7YfM1s5SU2jefZPx+FPlbJJnvMWLLch9YQezTCG82+mHfQ9YGND83Q?=
 =?us-ascii?Q?3qHv8vuFsEi9Pwzd2MWaC4Ow5dq9X2hvE5sBZ18B6nyJnExEgj7IPyhg2R53?=
 =?us-ascii?Q?4bh3iPALRaNnT14uABYBWXU+vvSW6Ndc9i1f+01F6QkLNf+PdOT7fKB07b/O?=
 =?us-ascii?Q?CKm3HfuNZCkwgU3vS+Hlnff7yCJXj0taIrbySv8VOtBv8ggEXa+XrA2szfIN?=
 =?us-ascii?Q?5QFvGxMJgshZH/qATt5aJ/be92p/JVsZTK0B/RGiQKHnoFZlcrvh2CnyALGx?=
 =?us-ascii?Q?+2KJK44BIhsNomgwrDxoLPxRopF+vTnTHG7W7KUGWtcVMic1Rvoeyixb8Yx7?=
 =?us-ascii?Q?3BhyJ/AGhOUX5kaFZ0KoYdKq5gXOuLkUTDZbHUX1tN/r35MstGRRn1ePa0vd?=
 =?us-ascii?Q?bHH1V9N7IYbD8Qxi4RpVkOp+sGYBfaPcGZ+tpADvIRazkB7Rutss0CuKvuX6?=
 =?us-ascii?Q?ZT2gIO5yeZvvfwf69HtunySOVKh1gklq8gQ8+D+37tMjNnPLlIVTKAaR0K1X?=
 =?us-ascii?Q?X0hoaaY1xkryWpvlumgGZa0HmjsjJ8lAKpMxYxL9eCSLTg4KjmBEJkrlHXeN?=
 =?us-ascii?Q?Gm7Cm/CicZoiLUhYNRyaCduPx8V+POc5TCI8o7wvexVo8YPHmReaxyRVt9GZ?=
 =?us-ascii?Q?86F5IQbKaWThl1HYQydFn0u+HZzo/rx5RhdDQfIHRvHZUC2gHQcTnMKolNMO?=
 =?us-ascii?Q?VUt0ROjOCR70QRodKvvVp+k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1e5769-32e0-4b28-a890-08d9d90a4aa5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:27.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeaPVTSQFvaF647rkjQlr+2yVhIqDwCTMUHZW8lr/D8WqTDrquetGpZTsJBE+Vl+aHUZrUHpSpXmjb7Dxn4w+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains configuration commands for pylint embedded in the header
comment.

Previously, these were combined onto single lines and not alphabetically
sorted. This patch breaks each disable command onto a separate line to
give cleaner diffs, removed duplicate entries, and sorts the list
alphabetically.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index bfd39b430f..814a92c5fb 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -7,13 +7,28 @@
 #            2007 Trolltech ASA
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
-# pylint: disable=invalid-name,missing-docstring,too-many-arguments,broad-except
-# pylint: disable=no-self-use,wrong-import-position,consider-iterating-dictionary
-# pylint: disable=wrong-import-order,unused-import,too-few-public-methods
-# pylint: disable=too-many-lines,ungrouped-imports,fixme,too-many-locals
-# pylint: disable=line-too-long,bad-whitespace,superfluous-parens
-# pylint: disable=too-many-statements,too-many-instance-attributes
-# pylint: disable=too-many-branches,too-many-nested-blocks
+# pylint: disable=bad-whitespace
+# pylint: disable=broad-except
+# pylint: disable=consider-iterating-dictionary
+# pylint: disable=disable
+# pylint: disable=fixme
+# pylint: disable=invalid-name
+# pylint: disable=line-too-long
+# pylint: disable=missing-docstring
+# pylint: disable=no-self-use
+# pylint: disable=superfluous-parens
+# pylint: disable=too-few-public-methods
+# pylint: disable=too-many-arguments
+# pylint: disable=too-many-branches
+# pylint: disable=too-many-instance-attributes
+# pylint: disable=too-many-lines
+# pylint: disable=too-many-locals
+# pylint: disable=too-many-nested-blocks
+# pylint: disable=too-many-statements
+# pylint: disable=ungrouped-imports
+# pylint: disable=unused-import
+# pylint: disable=wrong-import-order
+# pylint: disable=wrong-import-position
 #
 import sys
 if sys.version_info.major < 3 and sys.version_info.minor < 7:
-- 
2.34.1

