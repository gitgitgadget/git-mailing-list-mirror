Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D87C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhLPNr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:47:26 -0500
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:5128
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233979AbhLPNrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXDoKmzOnmCuv02kkpJnoWSO9ZjqKyL/NHEFU83wzWQad1642m6y4jMM/e5erWiGOz2VBzwwm5qr2h0gSSVYOp/6T5s1TO409ite8fbzLndL9wqIt79RKdHMpkeBpnxBuS4E6G0157qkKevF+ByB+L3QC0k7WPkjm3b5S7TsMfHEuvm56WlYp3FMA0+Y6Yz5BWbDt5G2qdMDFPdRSCfhBT91SYnM2KVI5KhTzkD/qP+07Q73UEey0aBKpnyypPDHDNXFj2dKh0BswwuXl7eKTXqxkraE4mVKUmY3Tx/WGPs1FRBmEy+al/tLfVRfns3HGFeGFICPBLMs3NaNlgjluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCu4H2g+2K0GGL5jT7uNdLR9FAT3fkq0Mid1ja+lPBc=;
 b=e+qC0EBrgEzhq2a24D+eJPpWgk1BqfQvkiyutxJfQh6BjXfCoRHXxXUz98G6L4kkeOcexHpCDKIrUc6twgHC66OxmRdbBPchVJugLNLpqS6PcNgMcbut28sWUb7aDu9nLslltwQQhBi5w/9zmdAT3iI3PnFD5uHR0J62t+um1hQqnki/1aKjXb1zh+j+GfVZbwpu00it/4UEtH/hRCxiXNp1Ahhg10g9TEXpJbKyR5qnvYIaowEtutD55uBM+Um7LRDlQ2J1CnhE13mWTBSawberDSwYUwQ+N9OhZ3AKJcL3WAaKpEG9fCGCkpvtdabDSwVCzB4JnNwVrU8DbRZ6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCu4H2g+2K0GGL5jT7uNdLR9FAT3fkq0Mid1ja+lPBc=;
 b=kuBWRVMAacZRK4TnqPneY303a0Ivy8vcLX1SrLUWeXUgP76QppxydWB6FLFAA7ViMLdNv7n8/vWJXi1SV4fRVg7YePOT2Yc55Csj7nXaNYWEH2eLGmyHX0bZaGcvaIdFgV4jjWk24wwuK3Wxp+ySEpxYb3SUjMmDjj75QAg7hCmjo+enwpbpn9ZRCZdO+f6lR6G+wr1a2TH9U08rKteGSFMladKRevuWI1ivBUgobEG6AnyuCPS3+J9wdeh8jFPcgMH7823UrjFO87LXH/byGIb9weYT69NXQa3MPmfN9tnydlSFCIGWm5JCKkkRdN1XH33YxM7DrmZ8UeJpu77j1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 13:47:23 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 13:47:23 +0000
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
Subject: [PATCH v2 3/5] git-p4: add raw option to read_pipelines
Date:   Thu, 16 Dec 2021 13:46:17 +0000
Message-Id: <20211216134619.2048348-4-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cdc11b3-ae21-4b92-d590-08d9c09a96b3
X-MS-TrafficTypeDiagnostic: BN8PR12MB2946:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2946D63FD6DB1F2A35E3051FC8779@BN8PR12MB2946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cYBTMLo0eFx2xz8Y3ZiBg/yi/x5VRuXhTL+XTZXxUya5YENTx2bBCGwgyrbUyhOSDRClctes/g7wuyZwESun/wjxNf7L+SM5+/JnMv38fXixb82tJQpC/p6qpbyO8tvQJGpewJT+RqwYI7sltrIzbjdY5VWbf8Gjkt11Y8exm5GHOwAOz+a7dD4Amay8jzTYsmKyRl3+sQUcRu5Hr7NeCSzVKGIgr0bXuekk0dPEUJF0Ne8EoHDVPLdeOnUe5rY01cL1MfUk5WJY0sRJ2zu5JahZHDrnzoX1aCYezhBQHIT0PjvEUs0mwlOZ5tXOH6Tk54t1QIkKaWwo0nkR72FAE1cf+S/5UufujRTrkTBTxpalzAPcygQUAaj7KtZ0B1kXaDGeudAEaw0vrlfOaXC6JVZL132uNcEVW1EBcSUH/yOWp+xCKZ2krkYCaPDKYKNM3PNHRXT011+Taf7ysxxuep1zGGtnh8nSb1rz2pKQXQeOYI+UEcfUwTH8bneUz40mEvXDhcX5PZGIpXjBGAuf4nAfaYxLn2TGR44rBhgj4frTA5NmwCKVRkU1uLbSHhUQ8rYXFYHis9BvLEKP6KMdExg1+6QwKfcgu2rLDkBffe2dTXORYnd9wp+6vg4cBVtwv5JhiZmXyHVsjB9iu/G0SF6hO2Gyg/mYafARV52aPT6UAMfUhKKSrkJ7zJmU6l0FmEDia7VrL3rhx0Wenwklw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(5660300002)(66946007)(508600001)(86362001)(55236004)(54906003)(66556008)(6506007)(6512007)(316002)(1076003)(6666004)(6486002)(66476007)(8936002)(26005)(6916009)(107886003)(4326008)(2906002)(2616005)(36756003)(186003)(83380400001)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGZEULKzg5aOZ/F8zwRi+d1MScqZWiWQvlJ6lsxFiS0fN4qeRbPOQTlrup3s?=
 =?us-ascii?Q?GmCioLoLPHYkS+trwZom5Ys+WddT5QcnsX1SBRUSsulzso74E9sQ48fs3VRP?=
 =?us-ascii?Q?nSBFNg+BFTARxqyT3iZF2r/N2Hbsobhkp80EQfdFvzAxqP0AJuFXudfjzh8g?=
 =?us-ascii?Q?eo83QIg1gxifEkKWBVMqR2/ujPKjIjdjlSjYppWDCT3uuY/sRau5ZmFKFY+V?=
 =?us-ascii?Q?l8ZKAhsWx8f30hM6ie6THADVt0vQgxOVRKh1NQ0gYW9NYqRRITPg328osnE6?=
 =?us-ascii?Q?eAa8/KHOcY3jmofcTxPKRYxLM5X3nAA15/HYHPuzSvF446BpIXyDFzAjAnos?=
 =?us-ascii?Q?sj7BI6d9pCky0ynCzmWR5dvYCxVxZ8no783XbeLr5+uDinNn41oLGA7P0tg8?=
 =?us-ascii?Q?vX8+t6MEPSXUG4ezckTGOLzib70IUrMdhCCeUM09skQYZ6bDDuoVg6oqhJfY?=
 =?us-ascii?Q?ixAnHjB0dUe/VtX1nZWCqfxk02p47h14n7LgCdQ0T69I49f5JdEnNMvl0nTb?=
 =?us-ascii?Q?wg2iqCukk30DoVPOQ8WIx8dqxYDA44F3JU+1CpT48PKW2Owvmr5j63httB7P?=
 =?us-ascii?Q?+c5v865MX+43h1zksUGQt7/PdfJs2Ql/nN0DAJs3JYDkjKwd8pgOUiLc2Vdx?=
 =?us-ascii?Q?EBI79qxLS8JNg2SOmPW4ni8atspW2eDUK9RC12byzuYRFtMs3FGk67z5RdF/?=
 =?us-ascii?Q?herxI32pFuq6M4fNKon7/DbCPZKazXU9fRZUwzJGIwgqcg5miZ3wCZKItgVE?=
 =?us-ascii?Q?yGXwvjR9aPzB9i9inRE8ptbeQqjTzAzese9KoUQNr/Zm0mSUjPuMKarpugFd?=
 =?us-ascii?Q?4vwSiiC+DOwIBko53TcL7A4tR5TsgQ3Oa5WAqaODffeTNOCgJMl1V1eRK7MS?=
 =?us-ascii?Q?Losi7ixdK54cycj10bOGmKu2hlJ98dlPbyci2Nfs077gDa/FDmgBY5/EAEAg?=
 =?us-ascii?Q?laD0iSg2f3WO0BS+myP2Gofu2oFAQMz8Yh7xXOWPqVOqcm9No9Gc0tU2AvIx?=
 =?us-ascii?Q?Idy27DNclMKlAY2ynXKmFQwdpkS8kpy0HeDloyS6LyzjyORULjsJIL4645MY?=
 =?us-ascii?Q?yr2Ip1CJkOTiFTcwB0xdpNOnuQJ3geqSukUYFW+xBImCT3wFXCKF5RvS9NG8?=
 =?us-ascii?Q?kijg38KqgLl5z7qmFT2MLD6ymk4BMhNrM6NMQfzB7wnzuutqb2D3ITWncCOR?=
 =?us-ascii?Q?wHhS0wT4YAmngC8c5hXn8gcIcGngcyTomOy7iqyKxwYytAKgzz8tXc7Um9yi?=
 =?us-ascii?Q?z/jcWDpoO2PbPYHGkHD/45PFrsWMJl96rc6mch6fdsw78V+ruZte6Tv6zQ3I?=
 =?us-ascii?Q?Uz+Qv2FuxaZMAhK6Dak8/DuLo/z80IIopkqvbM1ufkXuo+G8avDIuv7MnY93?=
 =?us-ascii?Q?wuXHaB7NSxa5Vc1D8kZ8WJpQHs1QOSWI6k5VMN1juFswkJyVLFllLEkbWG5N?=
 =?us-ascii?Q?U0Ut3Whm8dL1KqI8mIlE8Vsmrt7SIq8K4ebv3+U4tr6MraWxMgOcOSS2RU2C?=
 =?us-ascii?Q?ielp0eDya9LSBMbM0jJ820A0J+g60hFdz48eZMgdojjKdRyf/2JRdyZM1M0O?=
 =?us-ascii?Q?NIskQeq2NEd+AiYH2K0RWiIGJq4q0jD5KVJCNPYf6sxZ9nuSjM6Ieb/ch9G4?=
 =?us-ascii?Q?CqbbmGwiZ/wQUrVcyMiewS8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdc11b3-ae21-4b92-d590-08d9c09a96b3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:47:23.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czcjOrnjvABvXFyp3qm/YZ3Rkn/m9lSe6Zd1EN6EMy2zK5WAuCgQ43jlPHc7yeDtt0Ut0Cg9nlP5ypB2/kGQuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the read_lines function always decoded the result lines. In
order to improve support for non-decoded binary processing of data in
git-p4.py, this patch adds a raw option to the function that allows
decoding to be disabled.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0af83b9c72..509feac2d8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -340,17 +340,19 @@ def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw)
 
-def read_pipe_lines(c):
+def read_pipe_lines(c, raw=False):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
-    val = [decode_text_stream(line) for line in pipe.readlines()]
+    lines = pipe.readlines()
+    if not raw:
+        lines = [decode_text_stream(line) for line in lines]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
-    return val
+    return lines
 
 def p4_read_pipe_lines(c):
     """Specifically invoke p4 on the command supplied. """
-- 
2.34.1

