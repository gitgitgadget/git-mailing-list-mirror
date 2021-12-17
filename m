Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E56C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhLQPAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:00:18 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:5824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237733AbhLQPAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 10:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DupfOaQUhgdjkyhksMg7XHCd8Em2Yl3uDWKF5tYQy4HyDpCaCM0YQhOlE9dyQuzoBAOl3362h6FucBH4Ko4RQI/zxsKmFtW/QKaWndEYUkf3/dz65aNabQVnzl6Z/lBFNGqXJoc/GQjhUMDhijsTdHu9vXFFPMb+h1ljXlA8sXBFwfEphAWD8odd0RXCZu+PZRATB9JAo1L+4ZIfCZ3zUrdhKNumVNuWyv+sIiZraJfadr6HsC87n4LQqjuwFWNG8iktr5DWEB3BG4l0xkZ6sFVTCFswMG9AxgUciz7LLUXUdzNsHLxn/JLU2B2gYVh64ZqrCzVPvaAnZghENO0UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhluKwVgBO8e9z3EeoijE+aaaccKeDNKEI6JR99imCw=;
 b=BPtuu+mQPKKzA5cVvKSfFx/1ls4bSUFP4wJ0LZqVNxd0PS15tOsCRwf7Qr0EMz+Cpldbnq+O5EMxAlCZmCSENzqRz0PVuSX6nPu816K2i+v8MNKgIFDtt+3gv50E+5iY5kKiUlleJf7HLp2YFgo1shZ5d61q1Wa34SmSd4lo2qYIOGpzOxQztlQxyChAyUuMPyLrWXzS3ofSos8NeKRN/2TduJBtNZG9oiWJz557ycsP0OImropw6U3d7jwTlQoX/+wn3UGO80xXUAp5t0clx2+EhZVAkuQrNcxl8o8gWf9i7F5h4WUaSznq58J9QDIN1gVKQjt+W0bSHwv8HK8Teg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhluKwVgBO8e9z3EeoijE+aaaccKeDNKEI6JR99imCw=;
 b=gQFTmv+4jFc5ykZMmKTcBjK8i+ziLE7KR7qwLqFxFxpnerkbRc8S72BJSl1Xzcv4jKf9juAp9TVNSKhEXOFAi0NHqPaMeD3imEp3gvrNSQPz9RUux0i4TqMXFDn3RhG2pNqQRFRJH5V3S5Un4JH4fdM1HP99S7ShwwQ4+Sg63hp2oxiHnUriM0MWvh0+bj1DsozoqS079oYIuJRhVdzOgpY8u+YEg2/tsrH2T6jDnKo89M841n9Gw0ac8R3DvbQuo/l6JBxoL5U8pq9Vo/5opFFyVZvHZFsiLzHMflxoFQ6d9ecK8Vx8sxJLX7t9iVzBTw4nA7ZC0QrnGc5rTnfP2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Fri, 17 Dec
 2021 15:00:09 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 15:00:09 +0000
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
Subject: [PATCH 2/2] git-p4: show progress as an integer
Date:   Fri, 17 Dec 2021 14:59:49 +0000
Message-Id: <20211217145949.2229886-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217145949.2229886-1-jholdsworth@nvidia.com>
References: <20211217145949.2229886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::27) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f255f1c-00bc-428b-c5c9-08d9c16deaf8
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02110DBE94C94CB868D108EDC8789@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPW329HcN1AnFMbr0GHABr/YYnIP5dIIm3LW8my2fEWO3H/t+i+btCMbU1m1X2Q8g6hDm9KcGKzLCDqW94iElG/lneeoZp82y75hQ8aWaKzXrjWsXcQ0AkS5wWj1HSDt23yFdC4R7Ie4nhaovAz86tO2dM3Fg9uev/JkpKHrh89X8iC4NlAbh8zLunTVoOhMm1kj4ND0wJWw/gMM5zCnNN7hjRyU0zi7GK9JabokOW28Vk1fxeYBEvQE1+a0VvIk4+lglIUhZHyidqyCVU0w1hwD/UL4IN5Q6Pq7PO5aH8F9RFDA9s6HtLkH82dRAiUlLl5cVvi7pOhqwMWszimPB1UbUK839oRvYuH7/I8TsWotjbrZWixJ66m7l8nBTusrdxuEJg1knJfAWQD2+G3cCpGhEpgB4iCFDFyUmJZxOn8k554V1ri+ABrZKu1JuOB4ySiGRiUhjebYjYwp76pUiESjL4k9pyiYhl+IbYFT/PS4gry10gE2DeQvu/CMCSzqTfeXlSrxMAD3ItzESK7kEydc8QmvS0MtazEIRd9h4RapG13wZsoEmOweKeVY1/CHBJ8800/Zb5GhWyjUx4Rlj3jxXJUOLwntNFOPlKa4WKKwfoUu27oAKht8xLhqg2yrdySzBWuvL90Dh1xWzqzdhE1wKbDvoZyD2ksI3G+T2nKxSdz2gvI2o1nejlmOBxcIG+YOX3fEBWEY2a7SYlAlIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(8936002)(107886003)(4326008)(54906003)(8676002)(36756003)(2616005)(6512007)(5660300002)(83380400001)(186003)(6506007)(55236004)(86362001)(26005)(52116002)(66946007)(66556008)(2906002)(6666004)(66476007)(316002)(38100700002)(38350700002)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybWoG/PVIyGu64u07VjX3ADz6JLmTl/JsrM5wXWMcwNhNIjoPtuQkSkckg5u?=
 =?us-ascii?Q?exKucTcpuHCnN3VMGf9YpAmMBUM+JogLBZltXqwUz9aOCPMnJAeFuBYX1IFc?=
 =?us-ascii?Q?gaDH50Cu5oACAxL/aSqTwOf61Pp9MPRWVPqznOrImcllCiiI13rMQIO1sFOO?=
 =?us-ascii?Q?3F3/J8d1ekOdsbYc2jw1ulgrDXTnBySlv1g6v5ixC9AboorDJgYPhZq5XFcS?=
 =?us-ascii?Q?aVw7E1xv+jpSOxGK8bzrfHiDWUECOKhxhnvtB3rDN5SwX0PnIwBKoKJ8GJI8?=
 =?us-ascii?Q?MHpSj+xh6pVCMDSnnhExDV721dn4ITwl3gfagjeXYvb0i5WyX4/nFN02c0w5?=
 =?us-ascii?Q?XZPy5smicNUjjgpvKh/sBdPnzl1H4Sr7CoRIzrLl+V5b0oDhmdaCMZEAF4wj?=
 =?us-ascii?Q?xQJ/2d1LzRpEGt+Z3AwQPijFSCn8B21HlkC1yG1XTPu8W5bDP3TpTn/hEhB8?=
 =?us-ascii?Q?0+ZVkk8dE3P3c99XAlMTypBUh2yNIw/vzA2WlOdt1DsnCax++rUL9CHKlWAy?=
 =?us-ascii?Q?W74H4YyWmdgISSW+0zWKmLPyRhzSCL6VlomY7sYZVhKCWRd0nubBMyB2y+qQ?=
 =?us-ascii?Q?Lsy/gTOyiU0l7Wt7uGFmWrq3CA+xgaIREZSCa7/gIOop5s/UnI8WwLltR+kg?=
 =?us-ascii?Q?DYstwoXxGdt0bQ80GWHYnNDqOkuut/40ftC/kAmSAwXUM1+Dq6Flij34d6L4?=
 =?us-ascii?Q?3CihJjJ3eSt15aBw/jx6NFLSzFgARkk3NgQQczAzX9T5MIBeFA0YRcxk7ect?=
 =?us-ascii?Q?xVwFBj0cK1BfQ8HCY8+GaNSzZeOm4AYKyR7lELXqKn49Xrj9PivLWSWdmcVm?=
 =?us-ascii?Q?MrO8DPdGk2X6sBYOZSeHU9IsMC/5aF0UQ2R/6HkRlKuoO8W4aig9on1aOnge?=
 =?us-ascii?Q?ZnoIR5L5VaiFn1Cjowv+d+wxZTNNNvkhTVyxIUBV77uZY642RQu64spTmyYQ?=
 =?us-ascii?Q?uDko4pcuomIownYVI8FWyNV3Zq2n1MSAm9zIjIPdCAL96HC02memwG3tT5Re?=
 =?us-ascii?Q?4uqImqXQ31UIGPNFShpew98bx6RxQv2ukoyPdH5dEEMYiYhMtMRKiQd8khDl?=
 =?us-ascii?Q?5W1BAoh7kWZLanIJdnJLjydD80ekMVE8H59KqjGmM4f36tJtwrBLbdObuVbO?=
 =?us-ascii?Q?2FWEk2XTAG8h6pO5i/Rki4MjVEWHqTAXIplF5y896CHVxA9uz3vMsKq6gxJa?=
 =?us-ascii?Q?u8R07OZlLEojlb+ejrVGfImioqt/c6s7KYFQ0oPFRUkgWaIh5rqaJr0+ubvS?=
 =?us-ascii?Q?z2eSo7o3XJ6CYAA3WzET/YU+ft0gTSBd8TrZmTIIjXj7777mnoXjSHxVnMlA?=
 =?us-ascii?Q?DyYId7IjgwpugJP1ZkKlWBeXnA76RecJiurzbZ433oOaacHJfAOdbYVq9JH9?=
 =?us-ascii?Q?JreNUQn2rOI/QyYgEjM1CzkwK6uSEblUCdCRQUdg16uq3z2NCCwSzjbntt0z?=
 =?us-ascii?Q?dCiMk1WLgoh5sM11NNIwXqMZ/xUtyuK3MmzxRz+hkho3wDpYvpl+Yk1AFpHA?=
 =?us-ascii?Q?VqADkSn3Vg71z4Hc8RLK0mEZtl81A9cfOqluLl+mqU42icZgpbLSCNgfabQb?=
 =?us-ascii?Q?S3Woa4Lpb42cepCxBTFKzyCnxD6TmK/7ODm0oErgkY3aWEMypzg78AKlCSa/?=
 =?us-ascii?Q?0rTk+YWKUQzmols6eLWx6no=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f255f1c-00bc-428b-c5c9-08d9c16deaf8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:00:09.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH5w+b/TD42O1es4sWsmk/M+0CFpriEZGx7VbyMC0665flg2SjC0DCrO4HayEOxmyURk3dANC0vggx/olccj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When importing files from Perforce, git-p4 periodically logs the
progress of file transfers as a percentage. However, the value is
printed as a float with an excessive number of decimal places.

For example a typical update might contain the following message:

Importing revision 12345 (26.199617677553135%)

This patch simply rounds the value down to the nearest integer
percentage value, greatly improving readability.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 8c1130cb8f..d1919c4e12 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3635,7 +3635,8 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)
 
             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision %s (%d%%)" % (
+                    change, (cnt * 100) // len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
 
-- 
2.34.1

