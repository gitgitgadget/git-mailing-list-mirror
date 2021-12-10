Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31CC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbhLJPfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:35:15 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:39137
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242886AbhLJPfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:35:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE8SLzUu22UoQznBaOdTegukCVsmGWDh7acS+S24rRPOKzKdBgmSFM4H4LWFBx4w66Td4eR6fNtRxo+Vu400ig1v0fjAOXYLvfJwB1aMbzxF8gzC91OR4CuGLsFc3R+ta04U6HkD6i0pP2EneZPiV5B1BEhxF7+ctb8FYktEfClWsSjVPz6loK02S9nn3t+QAoN366+7hxrmtzhDehWwLV2S+gVACLM2wtDKfZoTaAd0nG3Xpy0guJ0p42ge3AYOU5gWtz/SNOXhhBONVLLL73sKi6OCyfzrTyuulUEca5wGDQ+qWuqyR/Ox3LF7LivW69r7uGR6GTAaYsrshvcL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuUnD1wuU9VNPL2bm7azMXsvQ0s5u3n1uNRerL3iK7M=;
 b=Fp1kVQWIRK0+a2z4sVUbgobfuRHNoGgUcr+D4Fwh3hzQvvEOI7492oCjUe3OhZ6izm5sZEB4gk4syhXNHf5/+egH6DNreTUpJWh6/YlN1BVAah6iYPuBPII0Wnn87WL4E1jvQ3M/pkoaoAwo0Mozdqg/ZVl+qtG01Fxsacz35ztVAdKmiUoje1tVIeylYyYCpRtmHh+3Rf16yZ6SlR6GOdyxhZ2lgHVAUarjvz4ZZDHPmQ0AEYH0st7Oe1dPq9neoayXD+B+SkDgye/ldfyYxMxVMGiAXPV/Gp0Cu0/Z5DRpV07TSbxiVeAACaLzqjQ8squPe1PQG8btwpoTY5nP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuUnD1wuU9VNPL2bm7azMXsvQ0s5u3n1uNRerL3iK7M=;
 b=qZjAjqxUr0kyl5l9j3+9CrAU7IaWV5RtDe1uJp5+xam7UQSs+qRYjEDMghiDKLDojD7/QtO9wdniEKEss2IJYcrZZcbQ5/LIHKWLYN22XodYHr1Nu1QFoFRCws3oCnEyQTpMqds4pqSGGQNuHSZhYmYAZhYo8G6tvq5ruaGUk5bCLkXUpqkb2T5m1pSTh98q8hIrvUDD/riTKL2Awd2MdaxqHBmGzXUGT+T0XbwP5fFnsB4xaYmSw+NNtGdIskc/2EIjZ07BuGbbCMmLJQQt9xi7MXeMIgYJo/MDUXktQD9neiP42yF8uigkNb5zdcNrnFxMXI77oCV2KkuSpM/Q4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 15:31:38 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 15:31:37 +0000
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
Subject: [PATCH v2 3/3] git-p4: add "Nvidia Corporation" to copyright header
Date:   Fri, 10 Dec 2021 15:31:01 +0000
Message-Id: <20211210153101.35433-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211210153101.35433-1-jholdsworth@nvidia.com>
References: <20211210153101.35433-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:193::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 15:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5003cc7-a632-4006-b393-08d9bbf227ee
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00194A0D6DC8750A4470C853C8719@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pb/sXI5jAPNqSVxKCk+Ensnocz29lUAtMftUFneLMlvJWEDmtTJiN5mfMelljTCK/10W72E/oGzY0sG8QGgMT+QqipPNWqSVhIbFS7J+ayIjG9nqsSh59vghgNxyNUfzJCJrd1DewAtq+nCdp8I4ZQOZq/r67OSdXs2KF3S1gTaEjBimETBNeEpnnDrqWhUa3hik7iAVI1yU5TgtJLyMG3UTTvpjqAV5OFE7CcsY38jvqD/fRSK0ga6qluZfZ6c+E3QH+K3Cvv+nm8rAD0E+FUvy1Xj9ANFTxYX8gJ0IkdYUIbrnOFXsQbU7AQ6/+JOAAoAbzALA0oKgLOKtsQZ+0mD4Jxx5MgS5tFxpjVetNPjKW5dnvJH6TDRyEzRNKL6jmMubYbAxTJzJLr8yycC+e4d0EGr3z6U9q5bqyrI4SlGiA1uOl3208fwq6S3CS1ju42IiXo+2QlrMPji5I51F3WXhrbrxga422K6j6NVzD+5urFkdZGgw6Vr8h+P2P9ku6gxZL5JMvapYHzBWhCS0f+bPo3UxlkCnBVDE3cuC38Ul4RvRKGzrpbxqR2R74Aa3fXtxNd8Tk9q6z3EY+lVpNHXB8X4xqLwqkCekdgquRp4XAA8vphA+13VPSIOFPf8Eia9j3XaOQ9N271jdgUzXZvzGaCk/wzWYXKBrR/GmBg5xSaLKf5C2GQtPPLBQEBxfhxziHqGE7mG2orTtH3OH5CPQ4IP1pvyO5y1+Bc9GP9yB0qR4pcAxIprS45SR3uDIS/dKG/Si9OE/GqQTcsGvaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(15188155005)(2616005)(66556008)(1076003)(956004)(86362001)(54906003)(8676002)(5660300002)(26005)(6666004)(55236004)(508600001)(6486002)(2906002)(52116002)(7696005)(6916009)(316002)(36756003)(16799955002)(4326008)(8936002)(38100700002)(38350700002)(186003)(66946007)(107886003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8Q418gSHra9aLXCOsUQcwgMV3axOiK88t8DJXGxWtD9hv+0R0crMS7aCbbw?=
 =?us-ascii?Q?JRNdZWWnbqSSJQ27Oy0mudNfLjQQtlYrNX1WUrPiKN21okOFVwZ5NOEChmDZ?=
 =?us-ascii?Q?gp9lQNVvRx3bueN1Tj4cnSXY3cMw2G7Qjhn/nCTea9acRLgpmkL1dUlUv7aH?=
 =?us-ascii?Q?vv0zUHe93gn/f6vQGn0LnP11c8Rp3uIeLxujszXyJRG/hwNbbD7GNgtwOCV9?=
 =?us-ascii?Q?qWf56DL4uDHnZ7EZEL74Jd6JoYSCKg79qadoX9FvAQvLEh3WH0kMJs36a56H?=
 =?us-ascii?Q?SYC0jLV2l2oQnCeV6WB9kkFF7u6FeeFFbL+R4MxEJyNeLUuqZ0lN0fJh36mz?=
 =?us-ascii?Q?OUVfSGHj7ZtREBNMHGwkzc6dBa4tedrIAsT6pabggbXbu3HiYlwBPKm+ItXg?=
 =?us-ascii?Q?ThnW63W/y8TK1zo7ccfnAul0sPS31b5Ci9NXYH00lUlybVHrQi1qUPR10yTW?=
 =?us-ascii?Q?2zvOulKmPmv1ehTGQ7a1xiofFH6J/hsrg6469kJxWNBC2J3x2GVSvDIQVBlQ?=
 =?us-ascii?Q?5QtVzC9EBQ9jts7X8I/0OiclUuVxu5sxxRjJwE7NYaWRI2scwtVRPzoe/wSb?=
 =?us-ascii?Q?qtnGogsZmtOp7b1ymjwf9Z54JqqE06BxdWHKp0a5Vzmc+S8HgMlGF9BIGVjo?=
 =?us-ascii?Q?D1wqQ4o+yLBP605CtqaJbUPTws8jnLLeHXPK0gBYpA/OB+0SDFlFguXvN+D4?=
 =?us-ascii?Q?nTeZYJ6mkUcAW+cOPtGMZ52W+Fl9+i9b+5wQg661v/GDGdHHe/97/zSs7wme?=
 =?us-ascii?Q?mZw6JGLucfrsBrU83hgZjrAriIvVNvVGf7IT2D/l5D4gCEugQf+YlzSAV8Z4?=
 =?us-ascii?Q?BPecHppPNQrPynzHkSRFqH6AzK1TTbdGgjs2m35LhcNcGa35tqKFL5Cwajt4?=
 =?us-ascii?Q?VlL+cz8MKI4GYSXZ34BMKe89TmNeQAvBBSdrFDpnm5x48E6g7410oJV0OBv9?=
 =?us-ascii?Q?hOsPk5T+fEyWT+1HHxEkgj5May+LplvReiJzO5hSo+BtDeaClZCBUuDb88kX?=
 =?us-ascii?Q?lT3QqXPRNjLSEQRZD+Yi1k+jqJXKNiG6xU+ErBdoUQFL2zm5L+x7tk99nSUg?=
 =?us-ascii?Q?LIuEM9RSgcZxUkcjB285/jlXTzSb3VnLNoxLcE7j2bZ6OsGlo/qjJYXwRYVb?=
 =?us-ascii?Q?DOSXevOSMqWtjJDZBtKa3HrVxh7F3p04y3pGpnfJ1CTLwHHMNHvM5ZfGv7U3?=
 =?us-ascii?Q?/mSHRNwQ2o3JT93KJOo64k8f9JaGU4Lt33dwlQocGOsv7XD1eeyQO4/m4zLr?=
 =?us-ascii?Q?LVPquSeeIo1G2NVUcWzMNb7L6eQ64tk+fpi+uBHeMTOQ5n6WC9Ks+n+kbAS5?=
 =?us-ascii?Q?pexEFiIA3H+tdo+oJfTgfiX4gmt9xUoQKEVwg0C+6C8lIRlr3tEfJ4k8Az7A?=
 =?us-ascii?Q?tyz/8tGGzs1uQArJ/h+Xi2vfBp+SpRcGLrmDS3i1d5r3t0SCCjpGYQxw0que?=
 =?us-ascii?Q?f5NTnyLgHBO8TyFECyP5VfJYs+/h4fuRcbVvoUM9ezabQ4+RSQOmMmdzWS3Q?=
 =?us-ascii?Q?4bMNV/YJd0TtZOJGeysMn7uoew31bFfXXz8m6RzBhYU2B3ljR8Jxpub8MvMu?=
 =?us-ascii?Q?vscHzuNYIWjVQEbDCbLudw39Fw8huSTLyw0hoOl4pOgrHwYJW5WWLucWPg70?=
 =?us-ascii?Q?XcdO5jOIbSA5a8vG1oAqfeM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5003cc7-a632-4006-b393-08d9bbf227ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:31:37.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRrVemPnWbLErvqBu61G7mFtuGL0G2ALa/perhfUsbfUPH1tKqUuMKYQgGWOToQZ9t+Q1+JRKgzNRUAgAh/4OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The inclusion of the coorporate copyright is a stipulation of the
company code release process.
---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-p4.py b/git-p4.py
index 5568d44c72..17e18265dc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -5,6 +5,7 @@
 # Author: Simon Hausmann <simon@lst.de>
 # Copyright: 2007 Simon Hausmann <simon@lst.de>
 #            2007 Trolltech ASA
+#            2021 Nvidia Corporation
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
 # pylint: disable=invalid-name,missing-docstring,too-many-arguments,broad-except
-- 
2.33.0

