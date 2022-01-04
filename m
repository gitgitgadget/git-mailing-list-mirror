Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347DC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiADMtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:49:43 -0500
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:21462
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233160AbiADMtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:49:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifeWvqzsdQ9sA3P8bNiq+ox09tGBwevmmCP49KVFMfukIiVQjKaMjmAFn9mTnLKIFStPacbFmCiIQFmfe3kAJiKi/Nwoi0XQ2OAVQ6GRqlnrHXnXojagO5MEwOsLeK8qBDsF5Msk6Dp7L4FqVDq3j9cxN3U5yx4D3z/FWAxmt02vVl3ZQ9yMAjASjdCpwfWVJzOdEE3L/fx3mQT0ad657KqVRRX/gZD2+Lt8e6kWdQ4g/EovwxxykGYdlK33aYQ7hlQjCAE8/PAhGPJ/3Ug3tlm35JJ3VP2OSimZsHe4y59abD+1eD0FNF+TVIyDY6YOkl/UJGBEpZQ+S8kjYCGnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnWs/DoFjkwU7fMlfgYt0Z/TrrkGdvPSkOgyur/7H5g=;
 b=BS7bWJ8LXQRgrLIwi5Zh+aGa/a4KjpJLuB8uI28/Dx18KYxuvJTt21KOfIxk4mavU9XAH1zF18NSDPtjangmUeEWnIMzOaTbmkZxIzCBmfR/ZadQIr3w5ujY07LZbfktZaWrbg5ULVe+XgTvli7FUf6vRaEVXqe7zfLX53aozBM1J0G3Gro9KW+b0WUYw2BHFnEj/HBKd/Ch0TS2DHIyysc9jOIxEVi/rTJ5IZnBxn86+wNGvcTaUs36Iv4KuctcPrM2kiso4xM/DshaAHPx5roShgoZoAQHVh9WeI6VLeo2x+CN4H/m+B1ZRjro1hBJVcTtHscZ8UxX+AKUTBiL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnWs/DoFjkwU7fMlfgYt0Z/TrrkGdvPSkOgyur/7H5g=;
 b=Va/nCpXgyoVkwd5jwZxCHdnQjxSbhdaEXahvdGhiUdN0kV7aV6nAtgmWwhUBHUcLZ6Zc3vuW0tTPii3swHvqyNUk144KJXV+CdQNIjK2mOwPfz80wTQoW/0d4x+vhDGQy/I9mjqxKOM0d5iX5onFMVlKwevsRAd09Hxx/s2EMuF26YZRoAte4Ga5/dY3ICY1Tpkaz3dJkCn5kYjfYtgkMqQj3361DEhDWjPeEMTQIropymboISJiLfeGQKlNgMa62YlNUaYQ2QR5JtKh1681NBdKugk0GaIWr+otfCOYi1IyDN/zpJoRjWqR7PHG1xZkpoK47nzXvgGqHsP4WT8Mow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:49:38 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:49:38 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 RESEND 4/5] git-p4: open temporary patch file for write only
Date:   Tue,  4 Jan 2022 12:49:12 +0000
Message-Id: <20220104124913.2894-5-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104124913.2894-1-jholdsworth@nvidia.com>
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::19) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9724726d-c73e-4105-858e-08d9cf80ab32
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500BBC6A772789DF5D4741CC84A9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wzuj70hmjmkh9Gyml4hz51xsv3JmqVKcKqXRVi8ILqwsCGfH2s6e6wUFXmSGVWnLmxOgvsHyXf+M7OxmH9ZW2ZRqy8rBbriV5en9WfI+mno++exwyinPHOru9yhZRpAva8LsQ5Gb5H2HkHFOW+tXRuNxqkF5LHZlrcCxCL5et1fntE1lfPfAvBTGBjaX/aE3g7imWiI/yr+prOUQkStigP+Jz3zzmtRno3DfO8Q0UYXDDJnNq5utTFfEkaAMhyoj9Daa4R6i/Jl76Po7yyQ7H279Jbs4w2MCX/M/dwDSvZQOMfSWZ0vvElkNkD23dHOgEbQVaBfIShA4SoYjPuYSFFWVVaAVyRpN97ggxrgUOgZrIpeUe38ZWolIRvEzYALmZhGVyAJIKp26dYHCsBqSv55HGf7pzMVsX7MopGaBApvbIBdSBxvqg+qtSzq1Ow4NY6JRuYMV7fe4wa+jakLto9ksep5XWufolkCsxZMSMIosQOSGu6bIRTasgD8WTtF4yebHw9Z9a3vSS/Lu8oCBcqkr8ClM5JSRNg6bQaSsUyXPa+pwsijxY32HHV9UgEnw4uavjb5vXma+DJZP2swcRc/MbhqW7E6cT+xcPo8BaX+hi89A4bpUCZkvoRjpz9ifrgxViPzzwAcuma1gb4+7NKSAry9iohPnIM68CZpwLZMCQMSSji+nUHIVEVonNVY9lb4jrUfGQ4Ebpg1nFu/qMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(6666004)(508600001)(55236004)(7416002)(316002)(107886003)(52116002)(38350700002)(26005)(66556008)(2906002)(83380400001)(4326008)(54906003)(66476007)(2616005)(66946007)(38100700002)(6486002)(110136005)(36756003)(186003)(5660300002)(4744005)(8676002)(6512007)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4l0TJ0lDGQZbbOa6pQ+i3z2bgs1REjDFY8gH1Tw7riz37YnvPCRjSYyhabm?=
 =?us-ascii?Q?ofKt3nEE3Dz+udKelbSXSnr8539odiAjdh90lvv6gmgeOst3cDjJ9RPXI3C4?=
 =?us-ascii?Q?ItilpS9N3BhBb4i3SZm2jh+Eja7QocejBa3zgmqRe4X32+lKJgdirMEZRMgV?=
 =?us-ascii?Q?jdoWRf2fz72H2Ej0in1WIA0EaT9LsJFDSPQqzdD9GN8ZjZB1t1EcRfy6VfYh?=
 =?us-ascii?Q?xzeSgfLxS+AUtbsKtIygCm1I8z6Ac1yznzW6QeMUmN0ZprC2ulGH2koHXJpU?=
 =?us-ascii?Q?/E7idYgQQY1rXZR77rwHAB7Sko0c3DdPQJ/YihAFLE4FORFBNRcI6jkb4d7N?=
 =?us-ascii?Q?32e1JNKDID8mCVEbAVw0AFdaaQ/NZrNzc54MOihIJ4l+4i4h4tcAHXPw8jcc?=
 =?us-ascii?Q?91ulYQaDgpwrwASZp57EEOmKsvqTPS4GrQO4XHvUc8bvUsb3vqchvHDT7oGH?=
 =?us-ascii?Q?A1ROpJJCX1S/xb8HcgJhgwWJHCXLi8Vwr9n9NYvI5Ulh7KI5nluu6soVb1WO?=
 =?us-ascii?Q?oBPVmcvQKBQwFRWhWVRvsFjrdnwFL8xp7efPM8TpQl8q72m0YPAwHOq3BPP8?=
 =?us-ascii?Q?NW6J0Wh78iGiS3d1GxuVQYclAmM4pPP74PBtWNmLYB0uavnrL52Yu+EVBeSM?=
 =?us-ascii?Q?7id2vE1WY5I7MNkcd+2ZiTteIAqjrZ3wnVnK5j+6phhWGv4bGS+3fr+UNb/C?=
 =?us-ascii?Q?6+BEkNqEiWHHbYYHY2Kztec2aSq1bGvTV7P9dFbtwg8XQqKKZViO/FW2BI+u?=
 =?us-ascii?Q?euxiDqZqKpU44Xw68mvXf3ZIZWn+XsTcZ9MJY3x/nOqkkrqUTHGRernWt/0h?=
 =?us-ascii?Q?qd0yX/55T/YGM+AcBLhs65vNDirVtQu7XCeEm536A4bz1/k2MszbUAIqMS3t?=
 =?us-ascii?Q?idXLbXBQIig5bRnUong3TQ7p89O5LgB+XNAoa8XbtNpMB1YMO4JjmJOlW3hf?=
 =?us-ascii?Q?urdM7Iqu3Jkq8wc95xQjQGJeoBCXZM+UUDFk7K1AzVhYun1xqo2Z5TkdJ2fg?=
 =?us-ascii?Q?OHib/7ld6ax7eILYkojZ7vGfcwi9P6NFsKiliueiVKGYnNUQ/EKn3s2XOPpc?=
 =?us-ascii?Q?8xeWP9mCPkrCzdS/mX7iCevFQuuPvsJE6fYT5aJm7LbfAecNGuy37oWc0Aep?=
 =?us-ascii?Q?E6hbbqUb65uC7lW0+5+Ysm2BLB3a4ACPNDbROKVRqYQVI9RuIJRhYRwHUU8A?=
 =?us-ascii?Q?Rp/LPWQwq5fjZJeeg2Q4Y04T0wb/pXbvLIIlm3ylkY6o7tRju15DPwyIBlgO?=
 =?us-ascii?Q?8vyy6nkhyhWlv4xKtrYwdSgZ2sRd4Xt8jWdNiBxihO1f/DXPAvOcu2Tx9YCU?=
 =?us-ascii?Q?6p6y705JouaWn4Rrhnrna2ClU+EGOnsj6erEDZjcP6o7s/PmXjBuaAh7uQw9?=
 =?us-ascii?Q?YMScEtFW0DH6Ts9K4Em2SBJNMshXBhl0ZWvkN9OueL81yQ5hFrWnCDYEv9u/?=
 =?us-ascii?Q?+1nLep5tXEQ09uDWkjMVueX8zkcSWdUcGQ7Hs/IW5BrK3eem0aHwIt9KZfQh?=
 =?us-ascii?Q?eq+CHnd6EQFcZ5ksabU4uDQHbgrICcI+ajc2by+XUdVKLOGqzSO7+MCiiuBi?=
 =?us-ascii?Q?z0+ef5w4RjPqqJpF47vFTcKUc6jkdIxRmliXVxG1uDv/ND5xzf8SfWPv32UC?=
 =?us-ascii?Q?IDhGfhH4kxLHIkgQzjhByVg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9724726d-c73e-4105-858e-08d9cf80ab32
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:49:38.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KyVOfEEEAXxSFy/hrclCScUi7/KYPnDou1XQiU0KkOozZPL4mlBjJ48aCyJ8nsabF/YufWSblvaigtLwencYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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

