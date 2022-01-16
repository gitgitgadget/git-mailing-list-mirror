Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A39C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiAPQIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:22 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235634AbiAPQIK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liVvIgWODNZiTcRuI+IlkcZz5btWP8l2YA4GRWLfOGVuyWDrGLsoOQBtjmFO24w6HybK7DaDsHHAiR3P0wpM2Cg6PKSq5Bh9mLvE30A90zviVtpSz3GdU9MCuRP8zr2M35sTydC3rHJgE/vS9vGetTShw3C+RdCIVDgt1GBlYSfmAlwyk1fmx9saPHlIRMl4Snk7kv2bmXDDTQpKBQz2HNiwe3jPMrBOFzPCin6kkubXF9afcTmuvfVdNAed2aanmr61pmKOh9zOKfYiguH6jsl2nBjCyXOJkVhkij6vzmT2SMFlR7wqdFkmjtrpqi3Nc2EvMfHkSzDlba2Ko8igeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSyFACnyAb37pU98kYRave56KqVBfRia7ssFWk0FknA=;
 b=ZnuO1uAmhwULCFghblRvW/SeucJdTQu0jUx5rjOIHvlo8KITsam4HwtlrNDneEIufrLKJe7oTy4YEJ4duIFOzvlYdyoAgJ7KjJoIrUcSFK5gnZYO7lQtTZNVguLExxgM9hD8t0CbnPwzrrERm1SLnKgKdcLfG4QyI2OjmmgbNDqGJhxOnfGtdCudXe3PrYebvx/XXG7Q6HIMXC2qg4+7LQ0zvJK2KDdY0ituptQknjFtlADjm46andNnp67TRxYTCENCfMs4q+bX9l8P6Gzn1jmn7FMkOEIiDrCPXYp7/hs1T5ueD3rjUb55SKXFCEOaALliwngdNmswA7Mj4lJfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSyFACnyAb37pU98kYRave56KqVBfRia7ssFWk0FknA=;
 b=s+TvN9JUBqKyp8CCCkcTu9zzdFDBDAA6xwwgNHcVGH7PB9OyEEBVmnP8+6DrwszU4fhLdM6Zx7YgzNYdm10ZhCtQKZHrKmKO5jUp0CqcBwHzRIT4klnzCDYO+662GhzO74+jQ/FHkbi6X8Sf7bpRaBjuwgS5WSVKvfes6zMfCLIcnc/sqyZp7pxD23hQpWDNKwzqSrow7HrToG2cwVH+X3ZCADmiwnUdhNrQ+sygvip2a6zuJOCPym1JotIeHvXd49/yLzRzMpOizi0fb9YB2wPZDdqnNz/rW4dIeBk9YxLET+xbDRWJVJ0TRC89ZW6E6us9dJ8Z2z0hh7WHU62jRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:53 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:53 +0000
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
Subject: [PATCH v3 21/21] git-p4: seperate multiple statements onto seperate lines
Date:   Sun, 16 Jan 2022 16:05:50 +0000
Message-Id: <20220116160550.514637-22-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10d36e17-e292-45a4-d98a-08d9d90a5a13
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259757DAB742A8CA7B17E264C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Nz7tWXBG+P5Bc83BtJkeu1dPiG/LaC4Ml1WCAXxH3xjfycPdOg7yuf1VW42gvId432+R3mb1HOunrlPR8ErXkpEMvCyyT1n+htFHkNg/+2QS57sVSjSVPUbdm2H009sOVhWUYxGHwppIjElFchfKexmpAeMeMz88vAuUxnMGbxlXU7VhXERi5sSSzOyW5lxBSmx+MW3n69f4ikSdFtB1U9o8i2QOO0bnTCl65i9iAlcVCG/2hYZ6B8/sCtgfqfRQhn+bzURyuHGT6tAmb/OIPejjdKNX3tByApVI4o7G+mrGk1qjuXHEizq64b6uo9UCYbzMHmPLucP//CsaMhjGh/0gBDpXqOzSOPNB/ekr9IDenLN0Rzo1SHNish699J1J0FZqlY7kfgzTPfgOctyxye50n7BoXgD6sc1cUFQcNB+YGGmqeV36SjCwvQ3TabBrEPtZBWei9qVQ3EPyXASEFfwLVPMPdjTtn9OJy23/v62ngJxi8iesJFw/xAkS+W0Wudxk5HLdq362jiq7rrO7RBJgJ6Qk3PMkJklcmwypzHR0HbA2ynmVWUHMmSp29D6I3RJkhXWJ2QY+2yaArWnZZL784SE1L7xkQyEOik6Lmt/t74bVaCCZ5NOGun2KshgLVdjW7hQMOBbdmBLc+7oLL+ujZ/9k2Jptsu+0r853vwhabm7vgZWMeobZfDhk03kkgJ2U9h6pXTi/Xi3vVqht73WIsDL0HLJPU79GNiHIpBKJkAe9NaYsj0sW4GsBIwdhrZGeIQD1uhJGp9reXGm+I78xCNkiqN+MAu0ADuFn6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFIShoBV9hLGiPhEMbt05mdncang9OFopg3jrhprRcGkNZ9dyBOHk5WBzUDf?=
 =?us-ascii?Q?z7aWNvA/D1JqWycv2N6/kDV9UeabfKavQjAv1AceHr7RpmCXkBEXbJd1hFdT?=
 =?us-ascii?Q?VVSDRy9jglRiGkTY4zu8TGbkY5y5iLbLIT30SyfspKhYt3ixkxVkbwA8XvpQ?=
 =?us-ascii?Q?22MnJ1kZZoojhVSWEfLN4QKVrYpHfiFAZOAUghnTFKmYCrGoA/ye0MU8uwR1?=
 =?us-ascii?Q?rcgN3LIwvlCptC5DpfSmP0Qzwo7P+rCABwzI9sKRDqtadgghEfpjDh5Y5VSo?=
 =?us-ascii?Q?/Xe91XHxb8XNJVbsKouPqfFGDrK2ceUWTZ1T4qj3CyLCEPG43b8vTgGlGDWn?=
 =?us-ascii?Q?6KxJz5ie/iyOm4eHt3FglVB5cu0hBzxCACcF/mYBRkAU8Ur2yc7TmDn+C4GL?=
 =?us-ascii?Q?gldQxRy+H3+mU3Sk7iXhAV7Ozyz7KDCfeU3sfm4P/BRYQkZSOob0eyRmJkOD?=
 =?us-ascii?Q?EaFPsMbjnblB1MA1efuZo0+lEmIwPCfH4qS2cwaG2w0nRDNDzN9RpgrAcSV2?=
 =?us-ascii?Q?ur5o8DMltC63XJi23OHnzPDEvdZ0wJ/c/Lg4DCQX7VSyA41PfE20X6Cqi8Br?=
 =?us-ascii?Q?B5srKLY1GLh0PfNngVP7mI77I/n7FOI4FCcJUQeNWBEWaDFkcn5RE2025480?=
 =?us-ascii?Q?fAhxHkUjy6IGzN/IO+Jz/5s9XL9N/IauAAZiI70ITx22j3N8OHdZjap5xSOb?=
 =?us-ascii?Q?FZ4l1usrWxiqV9/P2WVkvaBfYJRY7RgNvJWnXn+hAD6hq0K8hot6vEBdAw9f?=
 =?us-ascii?Q?VMKiuGGZollm7A4ly20iIFNeABn2yQHBg4QFCliViBMbT9AiMwkuCqHrNjnr?=
 =?us-ascii?Q?yLILPSZ8whrJgtMf5bOys3Xcr67ma9rOOXMrKleZ5eRmyXFle5g20Zczj9Fk?=
 =?us-ascii?Q?EuwtdznX+VAvMNeL4R2464LISyGJ2rZftTwHhA98k3yJrdjOFbIxGxltewa/?=
 =?us-ascii?Q?wdHve9Taa6711O1kdnokRuCxjtVT0at3n0/p9V2E8Tf/NPEdQ6EwN2wL4kzk?=
 =?us-ascii?Q?NE40jJ+jbj7Jv4uZQb5w5qunONGqnpHSo14eIDRdVTP42xUNTgbP0c1tVMU4?=
 =?us-ascii?Q?Nm3PUKv81yu2S7urwgQLeUCGhZHGrm/2c/owPOXxYCQVv/f729V6gSq3VG/G?=
 =?us-ascii?Q?bbkIxvi+68veThJskgUM+Uzaf7muOqaF4xzut2Z2Rc2gnu1hMbTcKyT1DnWk?=
 =?us-ascii?Q?dnW+xEALU9QBBgBr8XxHDFIKnZzETUyCUhRiHPj2/yl1gT9H99OieTATBDfO?=
 =?us-ascii?Q?Gt2zwyk9MBTqs2pW+P0Mf1nEbQekD9fp1EjztiEV8hucrX1UNcHWByTG9Mtq?=
 =?us-ascii?Q?okf1L3vVrR82U+sXkFNw3LVPilQuTpOQe3AqCLUvakr9wlM2imSzVkkBvLlA?=
 =?us-ascii?Q?O86vUToBGF0wH8K9JYpsFPNgvBhb+sE2unkqTeuTTMo5pk6gbaDzCo1UFYW5?=
 =?us-ascii?Q?Xt3YVm5zCYKpsnzbFkVKQjpPnLbWH2afi5hXFXmY2kWjAq+TZCwudrgRDstk?=
 =?us-ascii?Q?ij25Nc2Z0Nz0zK1kOTZOlsQ6rXJ4taGVLzKlmekchhOkl/Eti44S8hhf2wLW?=
 =?us-ascii?Q?YwAILPB6hYQCVkXEQRN0ThS9Vq18SRsMPW+plKl+UNK43coo/7advvcD/2sd?=
 =?us-ascii?Q?Cm/mueR5V5wHUIXeq8Xxh3g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d36e17-e292-45a4-d98a-08d9d90a5a13
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:53.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQc9iVMC/VhKDHhA+cbSobmdIRrk6CSfMiZaoeKsl5cR8/M/XUMxKlkA0/bFJU/6bOq++rKlWgr8oTdsR6Rjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 discourages the use of compound statements where there are multiple
statements on a single line in the "Other Recommendations" section:

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 4d291d0870..4d2f2f54c7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1249,7 +1249,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             else:
                 block_size = max(2, block_size // 2)
 
-            if verbose: print("block size error, retrying with block size {0}".format(block_size))
+            if verbose:
+                print("block size error, retrying with block size {0}".format(block_size))
             continue
         except P4Exception as e:
             die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
@@ -1876,7 +1877,9 @@ def modifyChangelistUser(self, changelist, newUser):
                 (changelist, newUser))
 
         c = changes[0]
-        if c['User'] == newUser: return   # nothing to do
+        if c['User'] == newUser:
+            # Nothing to do
+            return
         c['User'] = newUser
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
-- 
2.34.1

