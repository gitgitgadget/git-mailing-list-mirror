Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C5C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiBJQrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbiBJQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E98C51
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgSYjSueWKolplk07Srx+FuGF61obapjmaG/fEoB5XFw8IFj4XeO/o6oTueAs0IVkVG2cugvmdaD/jbjviU3SRPIRPqa2XdIqWkY2l42yFFnkKy8mZIxtwbQcT7zXs+BUgpZYtdIOrKTzpd+OqRIuBd4dC9+iOXVQ6J1glnpBS/KgcaiZtz/pOVJz3qTI2ikN6lrMZuLlR4tVCE/s+HtoamlEI6fBMb91hWeFdT3u3qv7DlXuEiYmeL2EQ3pFMXf/Q5spcAABY67BkgZsNvhjMeJ78U6YhCUzrgb5diFPwqsfk87WxyDNkN38fvVGKyJDSys2DXnLUHzRifNpdlfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QrHtf9NyeZorsyc381QMIO0gZGm4pHjaythU+VaN8A=;
 b=MfeBIE9ae49hIyEL7+Sc3BuRj3LlnQVGUWF38KvVfAIo4Oiw3gmF/37LS8d2e+zPZL9r5kCSZsTvu3PmAqCs6lHZse7qa6/SxoNjp+SVpXxrPLUap1eCgpn0ZWT2MsrGQP2GiNFJuTYBHR2kcy+RpekrF1xT90DfA9372neYEFXVQoSsWEo9tePMSIhZ83iHhAbG0AtkfxF0Su2EBW3mk8+ouJBTu6m+kZQNHXkH0XULhiK9AnPRNZFV+xNMM4RQsrIT7PCzZtttoT/O7zMAAEy29dLjHE3andCkWwRFnxrtKcBVaHa0pLPeAgXnSLr9v+6jUJ07sNwJ0NIUzFMG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QrHtf9NyeZorsyc381QMIO0gZGm4pHjaythU+VaN8A=;
 b=FWdeUog+0dFsBNMgWdGL0Kf28deQlLy+/pucCZ7xiXo+jwQO6h25nQ/iyTUXv9g6xyv3Y1EafNJ5jUiNIhfqv5047ATHUUDzstTUBsdYHPLkwOL0546LWeybnX0Fda3cY1j0ST+kInVghcH3zQkvPOOon7xaqF3wwjN54HjGQbOxejz6Y4L5aXWwyWwPK4fBlmCmKM2kIzAhFNC1AFQ3qzMsAWER+XudjW2EHB7YopSv425vhwrPeGad3ZohxTh6YqmU6seaLrZ89My1UMQ8uLxQZrO0Ga/YjFUeFdYZEQ3kvEYv/Z2Ijy1/o8/5exOoYhR9/BuCVpExI1Tz2IDnIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:08 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:08 +0000
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
Subject: [PATCH v4 07/22] git-p4: sort and de-duplcate pylint disable list
Date:   Thu, 10 Feb 2022 16:46:12 +0000
Message-Id: <20220210164627.279520-8-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 529dd792-78fb-437a-cf7b-08d9ecb4f9bc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24212383E58CCCCDE6F1AD7CC82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xQdHHLyB1iuqOQLUyZB1TBXGQK+rwzS58rIdk4TUQVS+iOZhlS/InNyK/d2lY8ABisUkR/TAVI67hMPba2paY1PKQJCB/Vum/Owz+ZR7Nm55zde8Y2PskrVgtgcTxrLQwHLZ+GbI8k4hBW0QGzzMkABU7lcFVvKilD9/pzhuXZoBWaH+p3aCkZpjyIlut/dGP5XTb7Fqq9V0aCB9nFJh59E8NHnq1Kjy6oj6XblGexk2MbqH4J9uDomCztXOYyZfFkdcujY+ZHoFTRWhUo2EWkSfLZviuAnAEFVmf2h7vvF6FsILGW34BNHrEx212Vs5Meap9Tvk7Tbf34O3JfX2RcaHo3UXIbk4rTT2LPMr7Ctkl2pavEgL2MgyEZNNb90OBGjfD40VDmwMPv+eJSdMf1ALODqHA8DEnElmX7ZRdyfaGOGNfgusPZqLmdPH2bYOa67Y4tEyMG98rNZ932wcxj+C/PaZsCLuBXnKKdpoK45HIH6kEkBT9yHJmUFu728fv25q+TIDinUVww7eRZf9/voovmZsBT8jMKu7OpMsEm39SkLMrXksJ5NctLKRCrLwTTFUTZ+Qt3OanScPpwc+Hcrc1Rp5WUIfxQGILcHz+LZpYjl/aim+y3ggpDPrbpfFRozNKiv4il0syeLqgLxj9UhuX6D7Mt7ycLnmR2nF4Ammx3mzxDJQn7/dBwF/AoNb0fhXbt/46klYFLyMSG08G/858SB08GJwSMAosMjWJ12mTGuBbGdgQHEt+DHLJDgEAUdPtWMl9FvCUSL/7peppDp9FD/xLLxLo0swN657yM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(15188155005)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(16799955002)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02WlJxucNt395moX8HqfVugmJnp7UbVPxoQLFN0c4duret8PDfobC/xvwaV6?=
 =?us-ascii?Q?QjwMgsbzd0p7ScG/QcAfPgQNZY0LofYrW90uRvDbRrOD4u+0TERL4YP930vW?=
 =?us-ascii?Q?ocTfKPPAnVuOLZkg6EHXwD1ZlBCvxpArR7cRZ6HQxh3aGBF12NiQ8aO/o9Wu?=
 =?us-ascii?Q?wNIVmuGjwaEq9pkHM9BIaQ1e30ncZmji5TPoysSqlc3ZseEoS3cc2aSL1j/a?=
 =?us-ascii?Q?c8EGFT/lPoMalfqUJAXrLR6OYNzaCKwxVyl0Fgav8mQDPhfTjkmmQZAapkE2?=
 =?us-ascii?Q?tv/VOw5KsonvLn+8qJffsWhq7vDZsKTCPfk5MJCM9YlK0DSkcnt9XPVlPoBN?=
 =?us-ascii?Q?dNa9gj7vPMgJn88C+v1OiDo+InpTtjX5gCDl5+fzswd4gYv8P2eGZ5qBokr8?=
 =?us-ascii?Q?pw6s4g24xvVclDG091tJOMMIvpvx2plbSJDAShhwMXuBksyEjxGgPAhZogWj?=
 =?us-ascii?Q?wlPP0IG/NedZEnyu9Yq5dQAOXsxwTW/ZR4c/K5jnOgdVsOriL+RKS28rY9rY?=
 =?us-ascii?Q?tERFk+L/NHRZgHpDoGRH60jyptQaaTq1WE0h4mDI1B6II90/vxMu+vbaF8sd?=
 =?us-ascii?Q?iL46VlXguCPrB9lZx5fpfP0A4Aha7hMBLS+M+V5y0fz8j9QJ3N/wC3l+Q1eS?=
 =?us-ascii?Q?xzxlIWdj2YXpwaLsgTtjwq41xrDygN7WMghS89JCIBncXXaOpJxIePjdRZtN?=
 =?us-ascii?Q?bLPPnkrw3ZO/geSUvS/CxOe/lE4mORGJkuIRnDNQfnW4xBNkk1KSBnSxRIMl?=
 =?us-ascii?Q?iV5BgMdvnR3GmhKvYUxNo/2fWvRm9gsLet8+NyA8iv5rHq+zk15m92EFhBMO?=
 =?us-ascii?Q?XP4sx7FvRKY0r+OLEPRZvMIjQ7C+FgD3QSyoaYV7sQT8ifXkYdDSour7/lzV?=
 =?us-ascii?Q?OWeTXC6eOCx0m5gVYO98QjDBJhLMLsTshuHyoyj8r1qaA0wWCTL0S12eSU82?=
 =?us-ascii?Q?1WTUvUbudTWF8OG1ZHHcj3Evrv2H9t3TdOcDYzarPgu2AoJ/Bxs8kxH5r6Da?=
 =?us-ascii?Q?XXihZnugQSN+AkgXkkV5cWYtLIPrDfSDJFlbpfCvDdF+aicPsuTP6E1AxYKv?=
 =?us-ascii?Q?JXQAToNAvkcUpgr8LrwxnvKSSPy3YPwcOcHYSjvT63RDp9EGZ765qeoiUvUP?=
 =?us-ascii?Q?EIH+dJLd+fgFZOSbAt081rAQwCNPaoO7i9zrunEeG5Jt3rgvpJyZXzBGvPDh?=
 =?us-ascii?Q?I0zY306yKWkTH8X9OPv6wblnGWWfJvyUrNF9It6G3tfBXbR1e/ynopVO6nIU?=
 =?us-ascii?Q?CcdVkB7GJ75cPrL3lC4weQ4zbVWXAabL4cuQalbLxqZ2MjiDvaOZ/Ca2TZmC?=
 =?us-ascii?Q?1zt1A1CKVsk+d/GLFYXGXtNiaHKKd2Z3eSr3Rn3sZ5uNvEHbDdCyimpKHZZu?=
 =?us-ascii?Q?lA/4viGHxvpbVlpNV3zQJ8ZR9X53lDLuzEVWXHDFBmPyH7nFJ7rAAITlj75B?=
 =?us-ascii?Q?0jk3u3/+J5kJo2NTBqTykvsQoysQmzAqfqR+SmuNj5NHbpuqG4BeFSLK5CQ8?=
 =?us-ascii?Q?D3zZ+begfyx+lvJtoLjXxUdcnBB1KRgkIfaScf4d6jU0syCIGJ4WBs/37rpQ?=
 =?us-ascii?Q?PzDEDGquTUz05q8Xpj9LZy/7QGe+OP74cHO8X4kk8amIDKrkDjnrKqpgdz55?=
 =?us-ascii?Q?MnLaZE2AP8XmUCvgT9ko8Zk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529dd792-78fb-437a-cf7b-08d9ecb4f9bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:07.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMMR9lJcXm4d1kVn2jYHVGlsm4kbXIL2Z6rQ1Rs1ocKmhzww76F+zP4IaEuHxcN2N3z9zwGRkJZxOAthnWyOCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
index 53e99f81b7..52c4cac683 100755
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
2.35.GIT

