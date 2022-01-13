Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53678C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiAMNtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:49:32 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:50574
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235626AbiAMNtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:49:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5auuGQZeOGTjUyoxz4FDS6jrcWlD8RKy0GmHX3ZgXAmjVbupn67VUuP3ZWP9wBQTgGMhcvy8kLNTk3o35TK6gXy+RPMe6NWclJ4sF3Bb0tYMfd4oQLoBFcDraeRsdX0ULzfX6nnrxnRd/ZrBq8EQY4ecnGBImf2Cl1xiNFUI/T/ymRB5J/J9hugZ3dQ5kzzE2g7FkLDTMpzktRf2dVC4PVCYKyOPMYK36e+kQALVIDotrjc1Vaub0YYg9isAj2xj92HnBsoleUVEs1eEtGFV5LSA0IdhbhynJ6Ix0NeiSM5pND/LOue2mvCs/3S8NIiq1RzkVSL9ul0A4KpDVqRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rkhyerFA2O6bvORi+5E0v9JnTv1Im3S5SSqrRXqeg8=;
 b=CfZ6ZPS53g2ZKqvBUBmr7njToKpteBC8rOzi2Giigd9K6uv2fGBO2YcdowECgWjvtsihZfInBZti5mceNn/Ke3sR2BfsHGqlIC+YbEbGCeby2cDX/bfiilnhzck+ofc03svcFjQSaVNN5/UHUOlB/Rx1SpJfSpNIhEFD5+vAWfVr1Mb7r1nezyYgcqQTPhJ07nf4sR/ur+zkH4n7aMnLgVzsNIcA+NYqKT+JhXAsHWDdbWo6Oe5nqd+C9I5Z1zr+RBjSCxzqnCQtf8ufz6+EdzLNVvJr8WTKuieic8JMR7Q9SxIbgrMhpXn5a4VvEMPIfzKxoSZhnIqfu8RV/bnmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rkhyerFA2O6bvORi+5E0v9JnTv1Im3S5SSqrRXqeg8=;
 b=UIPhcLNIpQ0yvLXq9QTmhSRTDAPjNCHd1gX9w1hO2To8+7+z3prDfvsnu9edTm/XXzEJO7zMWiexXaVeIKjPef+KJixdSTbphK5TRcpgSlLfzeNU0sTP09IzYuPKEACdejTm7/c17Koq189un7ilJNfiLQ8IRWB+vv5A3oguForQWBvPlIy7RHqk0QXQ+gB512z7vZPpI/NPJS5s/oq2gE3M0VHBEiAsFKkjze7iIXwyJuf2GUfE6so0pHINGuMwvRiVz1FSVEWa0lRjKh3xcEz6VqFDeagjRoEUZvP9Tcu0+O35yDv3QupOMvGFeXGtnpsNM+hSrihLTH+DERW61w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:36 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:36 +0000
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
Subject: [PATCH v2 20/21] git-p4: move inline comments to line above
Date:   Thu, 13 Jan 2022 13:47:27 +0000
Message-Id: <20220113134728.23192-21-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9182c6df-2bfb-4ab0-c96e-08d9d69b6591
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3944A808F4E6D3C8F3966299C8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qq+x2IesgbLNgU8IvXG8VldnU//i2CfFAneuB/R2GsQg3DeMmG5Fxay3WkpYcTShXK8v734i6dSUh2KqQNXyYEdYRmnKqt3PaJaTRrKLaPvCZstRwTKAyWwcrQztPVZyG6dP2xk47yezlGeBPo3QA1IslrR3alvDso7Gqv3gLq0LNvT8A4R7/GxVolFCMYvEBHYXiUWjHckcburmu9swGSHe0C3uERCxqfBzL9I5DpZYgy5vDtv6aOonZm8qulFwd6K4wlxQnvjoZXnooGlzmYqFDq64x7hpmBiLj6VVLpbEZBLVpSplYz69RbSVc3akTZwLsipiTqcYT8U4JjV4o8WOyEu3kPlDIjIEhiB0C+36WzXP5Umyrp8vRvLfC+hefKURbGHTiDsy3g3PtdUwVsdGgZ91KlepThB4JwdXfOmAWspItQksWtAxa8EAM8S0bzdsCeb0kEC/ydiTv4+WwoT0/diUs0eJ5YFrEHvHyCt5lu7hvYoruSZj5GXKwotO9VOQnJbRU9K2/cJXD7ThPDwZosLl2qIxlq9BbRKeSd2CC6qPI8L+sTsfsWGxvDv2JynPia7uTWTCjAPfcflhGR7i98150Kwz1F82mbgNlEO4VIlZBgYxhJ+z4f9LBlD3S7Enh2xOfrOiVGLK8MHKci+4/k05P+wa4hkCA+82Abl/vZ+kc1gPGAnpNU6UiKaplBsSTcmcG/bK1+5L6SZXoAWbmRcC5zW3JlCoDUbHKblOO9s0lV/TzadyXKGQqHRLYv54NyTay399KmBy28p11poQkyZuJo2hOXVaWgt+u60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(66556008)(54906003)(38100700002)(6666004)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ar8iXAkBOW3k5+WoPHZzE8T+hcT6XrTN3hp6MLcrqjYZ+1xwXqPBU3mGCDBM?=
 =?us-ascii?Q?kyGjtKaPDsxdwDzyKyFkgGPavB+OJP7DgTvIFVbxRS7Z38TNsOo37iaU9ZxP?=
 =?us-ascii?Q?RPXO+U88EiZb/7y0wZs9EpxYj5rxqFgbgSeq1D9VgcfaUlJJerBgf+m+X8pL?=
 =?us-ascii?Q?kzlzch0/idDW7sO/8QsdNcbx2xVavvDf4lHAWeHJ82CxyOT2JwSs7NYJK7Gt?=
 =?us-ascii?Q?m8v/S1OyUCd51L2vuxYjx/z5cQC5aXdK7AvnTzuja909Es7EzULU/4YKLOc0?=
 =?us-ascii?Q?/Y86MDTbiDTCaaaowdChk2JIntZDton0ckJEPEAMDSIvxVrxWm0hftkFcRck?=
 =?us-ascii?Q?RWQDgbr4AV2er1EvmqxjH5OE5C9MQShgeIe92SEmjx8/prVmIZ23pJQ6ED7L?=
 =?us-ascii?Q?vkuhu3gDvIpKtRKbTvNXHYof1wG6+3IGiRqZqDkIgiUdPUTPEhZof4FC112g?=
 =?us-ascii?Q?nUlCTwARdtt+QVBX6rPLCLI0Qc7Q6m40Ztur47XYSh+OU56+JQpun/y1LUbw?=
 =?us-ascii?Q?twKMsLvPV9C28nWHxKXOdtQfHt8h4V0yzZGmIEBWb84xtSfUtkxkOzkafwhz?=
 =?us-ascii?Q?fPtsS5bbKL+J2XQzzTk1W9TOH8eZvE+85CKvROW7zc1eFjq/vHdfUXjgapDN?=
 =?us-ascii?Q?qpyPr6jcepD6HuNjVU6uDr4IG7mNZjlUT9RzC+Xt6Gc5jo3SUNvdHaoBqIcZ?=
 =?us-ascii?Q?kUuJWFN3/UlD0JCcBmAavxqDMC1syWmR2aj1M2/bdCJ8bqhVcSFbaJCuViVX?=
 =?us-ascii?Q?faRq2EgTWn4Y9we3GOOxXetVyybheMAYSSD29PX4IB5gDzwavFyAmGRm/XOy?=
 =?us-ascii?Q?OwnaEgnfd23+Gii1RaAm0G5bsIbw1Xvft3+naCnSWAQu+E7lZg6gNlA+SWJ+?=
 =?us-ascii?Q?vkkFtczY33HtrdAmIjqcqSrS8u+jjRNy+fNdTkTeE49DttaAgFYQcOIfVw2x?=
 =?us-ascii?Q?hQPdjli86FJFgluzYWMawQLjhUfA6onPrp2ZA48z2Vq9rQmEKsOOzzCu/5It?=
 =?us-ascii?Q?MYHCXlf1pDhOVttje4dVOUs0uU2YpVf9GUmRo9fFfBLiNkrWTv8P6S0Jia63?=
 =?us-ascii?Q?3FeL3+SlFn4tfr9QqsGNDWYBPdrrjjqFSpM/0nMfmvsdlAw2kVTfnTRphkT/?=
 =?us-ascii?Q?Y7PD5peZ57nxtHbiOGQ6nYG7/GjSCN2UwUD2TDkgrdpoz2rtJ7bVvU/p4xpB?=
 =?us-ascii?Q?EnpXwZn1xhNytqqoYL4ALS9bVrdRCB6zWKGNkPO6SN9VtGvmS5ocS7Rv+mSo?=
 =?us-ascii?Q?TZG1y5dfLn2DqXgFIsEPKMgumNvF7vvtE8S2ZIZNcjsZHLIdr5kjZ3rkmZDX?=
 =?us-ascii?Q?vkdv6AZIXfEIQO1VJp/zVGJ5IenaCE0LR/Otrnqe6Nc3LC73kHcfJq2aa8Ay?=
 =?us-ascii?Q?siQ+S/1crsUeAduzilEOMVUmKvRR04JJ4PMWKOW6JiN7X/S+HpYQRooJCgSZ?=
 =?us-ascii?Q?jAVnLcCM9QBz3t8gHNDzD64HRGU1HRUCStro5+wxST1o0TkCiIzl0Ma0+gSW?=
 =?us-ascii?Q?QP8cxD8mIqOuscbwygrtKr0KFrOZ8i4obX5mJ4cz0bmAJ8WSMoU8CR3l834n?=
 =?us-ascii?Q?lz66Xbp8lESA5X8tYKDrlo0E0N8EspCiJVLp+e2UZcAWvtwgaUxbUwqNwGBY?=
 =?us-ascii?Q?x576rO63puq8lpB3PL7UV+c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9182c6df-2bfb-4ab0-c96e-08d9d69b6591
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:36.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJsPap6Gp6B9EEJSyR/JlNaSp9wdVilnOKD5XHDftoua2il1b/ZB8Xr/DE4qUzCkCuFqWGcBKa0XFJVe15Yd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
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
index 34c8696145..7789989ec7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2052,7 +2052,9 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
                     for line in f.readlines():
                         newdiff += "+" + line
                 except UnicodeDecodeError:
-                    pass # Found non-text data and skip, since diff description should only include text
+                    # Found non-text data and skip, since diff description
+                    # should only include text
+                    pass
                 f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')
@@ -3047,7 +3049,8 @@ def streamOneP4File(self, file, contents):
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
-                size = 0 # deleted files don't get a fileSize apparently
+                # Deleted files don't get a fileSize apparently
+                size = 0
             sys.stdout.write('\r%s --> %s (%s)\n' % (
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
@@ -4306,7 +4309,8 @@ def renameBranch(self, branch_name):
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

