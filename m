Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8214C433FE
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiALNtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:47 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:40385
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353718AbiALNt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtu0xKGeXDIBrcCxdrX875rVxeFVokISD5hQbBCbNUuVs29Q8UNQISfW64OE5XaubnJKsYQxIaxMLXgnWap0tHzTZHXJvh7pXOVDMQencoJVU7c4SA0OFPS1jQJlrglHspM5CuQ09v/jzQmVE9UmdmzAMvgIMm+vAZqAz8ueqFdNG2GfQG28oRShrDt0+KNf44uR1ppoRyoJisaY7707MDYbeQmSxFyU7plPaXnjMfPpF0QxWnHQ+LLfd6S3mlgsdOcIERhsuLtpDhpR/kmzH3yECIj+bLYpAxyXtvFhUatPlZjAncrUohAREJEHEZ9YCYcqone3/6uNeA66EYhQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8THQx7vUhHUkQHXXrq+Fqy1HPrS47oxZYaXKIpXX/8=;
 b=FgVXhWORjC/zIA3mMgshrQhz/Hx7B9muXwnpiPi1e38o45GACrVaLv0lhAio0SQM61oZez0JmQw56L8okTCXRErEXurlLwSJc+oLi5t2ZKxBunkv5uMJVh021ZR+K2lJyBWpxWhbCl+xbPZt4aDLzXgyIWs9jFNXpm1jFxOtoTSkf5sfpwY3fnUHErtZ1f8BVr3mI4pYZ6cXFPACy0ELX4jBwPIU2GNI34I/ewA+muIS5KROI7QqeHqdDJuwHReb3+Anj71id83A0VOStL+mF+pmxbILw++94VdpIL8Cw64XLqDJgu5ay0wlOCBkAkv4MD9cQIoiiJhbAMkQGOvPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8THQx7vUhHUkQHXXrq+Fqy1HPrS47oxZYaXKIpXX/8=;
 b=VwCSC2PtSJV6W3IzuNvEH9USs08ebuaIOLvfEiAcOoAZNJYN5ZkiOD8s9mvkOqHG9vJG9M3y+vccau+V/4JRIPTRIrGKryySQZ/strAuMNIQs2OLKzFsf4KN+zgmUyR0yGAT5WQYHT2ohurbWXPc0KbeLvg298KWfDadx529RAWOC+ZYblf6a+ul5O83m6BmgTs3yhVYVet6JOzoqXHl0Jsb08Sx7OzSw15s+cybdNh2cOMqM3+XoIyLI4ybh6v052s73NHeZbfyQvpPoIM8dmDYczeJTWPOvskDlTqQU7illtdRuPJpgXXwm7/wewhOV02Guuo/9kSqEOosvm8kcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:47 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:46 +0000
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
Subject: [PATCH 19/20] git-p4: move inline comments to line above
Date:   Wed, 12 Jan 2022 13:46:34 +0000
Message-Id: <20220112134635.177877-20-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f2ba8c-9929-4dd2-69f6-08d9d5d21dab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594A12FAA4A123BA6C8872BC8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFv5HTaUNGoF03PJxFblh0dF3NsvNOZ+Qqu8sTfk97GPi0OdznAe+lXi68XcmiEwbVOWaVFtdsY/UJMx6xLu/B+1JUQ5HH7xaHfDke9rejGACzlRuR39YBJjcibD6zYF2+/eNojKzfZXeyxEPvdt9InIN9F9AhAdcWkP+l7sziZwc72tpmpXQTCKjy30QuoETvuSJQShc8HrviF9zwhjych8alvlG0gzr6gvyGmiaPEJ4PXYlcQF74mXYXTrRtyZe0tmJQ/IYxvgmYruRZt0h5V9G0+Fr5vKS19TJs7E88YY3Cvy3eEVDqf6ooyKn/Fp8Pl2xW8TTkjivx02LgZbjMsIcm/70tRRJhujTemjIvsNt7Vl+YeanFlgqtB5CnExpoi3blCz2wNAeXdMkpUdKPxN7K35rHzAk2j/R5Yj/rquSt9ZxwP9y6CL48evZETx7e34Zi50B0hNC3filZJegewZuzEDd/1m5D/ijP1KmVIs1zkKPVhgS8D45UsK+tNQIxShKjNXGu4/M/lAkb+5n3TbVRcsMsnToTow2mlMFvWCoeNdKwxsJZETo95OqIZMMNrz6A4LDwVfeDA2jQxa5cTZP6Xq3u36ExD7rWLo0HNUUuRG5iVRXVGlZPOirij6enTJLFD2mrdUdF3mQVuQ3l8rEVcZm5U5mRd6J8ep7KidwjTrQolzmcZv0/vu2ajcpQctBMU8THpNvRcuo26ddWjNZQBV9G6hdoy+qcZS0GWLEOfqQSjwtykDhLE7PGe414hk48H2bdoX9iH7Uo1R+iLgf78V/VsLpGg0WcKJchY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kexRXGLkl9BNVw936H716qbfkNuLdV8f6KFSzDq2+Uyo2OuQDBrTPo6csLHU?=
 =?us-ascii?Q?5CqK+UKAKU1TX0mA+3k3wMmNfdZ/notpiimbI88AHbTRrWHkWXJ3RgYnsX5s?=
 =?us-ascii?Q?rM4W/z5XFxSfhRZpIpr4dVDjKNN7bxdcvjTqNiv0FhomLvgc+aRKEweGTNE1?=
 =?us-ascii?Q?afubf22HhvMq0v1OGHxxciUe26VYXfbgEnJ5ZKmRWRZNe77auZefx+01ah6R?=
 =?us-ascii?Q?SankAQcge0ulFFylBRFsZWksY0j/+wjqosImJmfR5kVR65KVuQIut34huWjs?=
 =?us-ascii?Q?9QqsQwlwucYn0v4eWYFVG3FjTJpQcQHSV2rkipnzbh2kXCNIlL8i1MJjODj8?=
 =?us-ascii?Q?SMO5HDHEIYDkReNFU/JILSwOGdM2eNe9HdiLPBVeY7K+NogL4ZNkVLZRF3x+?=
 =?us-ascii?Q?PFiZzZQip1zhNd5nvzshpamctsNKk7V9++1lEaGVB1J99SdRoEBhFHkCQy5q?=
 =?us-ascii?Q?PNfc4LrT4reUXhB4SnRzZiuK7S1lWgtgpoPeGHlCsQNwC/yNyVYOqFVNsR5E?=
 =?us-ascii?Q?ElAMr8su91pnEItlgDA+qywELVT+tK6+bL8VH2kS7hc1y+8rb6A2pNUtHBsq?=
 =?us-ascii?Q?NVwDeMc+HHyKYvznAC62EVsNYiWr6mXnzB9vZMZKRYIrEpj0dntyXHIQ5VmG?=
 =?us-ascii?Q?PP60jkNk2TV7RLvELkSjA04V5Or7ljg5+A7vTsnYtujPNWiQPBtOM7PneMte?=
 =?us-ascii?Q?qmgNELZ3Ll6Yz6G+z1ampa8rGSfyRdo6bd047wel/goamEoJHom4Sb2rL3QI?=
 =?us-ascii?Q?UJTZdL0skEgZPewYK7xblkQl5go3/rvgv0V6NAvmG9zyMKHKc0lgv2y/P6su?=
 =?us-ascii?Q?hdxFV4UhqiPgGTPo3JUz74POXBd3WCN6RbDPtP0fHC18WI6EvEdajEbpZatA?=
 =?us-ascii?Q?oIItyvOmNYVQUcvgZjaXy2PjBYqvvP9Aynnm/mpfU6fosNh5BgVFPWxCbLHg?=
 =?us-ascii?Q?sHTe7mQS+o80P2sBurZWRa+grWukFynIsc4bHzjmX1PZBq9rEqtSEF6yO88Y?=
 =?us-ascii?Q?6Kbthtx5yDXyLcEbhddrJOrRZJ7CtKEmSau1m4LGRHnqb1lQXg1FxhjIyzNR?=
 =?us-ascii?Q?30G1bw/U8YXUFSieAmIxGPMwRm80WfEdGsUQZb4g9/KbtvOQN0l3BLEEe5UW?=
 =?us-ascii?Q?iLPL7OeqJi1/Nes7RS5Xagvidl8+aCcbnFbD6G5QdgmEZK8QXoyeWTxMSXNH?=
 =?us-ascii?Q?KDOaIjnRqfMD20LhUJOuDtXBXJ3IhVxlFJfsBkop5xiF0lEAk8d0oDpdXJ6M?=
 =?us-ascii?Q?Ee3XUagxg10EknI78U0tHzEivV9yazV5wH2+K8Jx61KBjoWLStsQ1sZ9pUG/?=
 =?us-ascii?Q?WyjvEXPaYeCPQxXuU7MFfiyTKJHUQLnjrx9SR/SHvd4Ym+LOmAILS+ukn6wY?=
 =?us-ascii?Q?JmfVv+8Aoh8pPFkxfjHBlIz1D9KLLfHuQzc2ZcaWkgNwYHrpiVaiTX8EQWsq?=
 =?us-ascii?Q?ngqkTLP13fTV/8TOqUbHbVmnMITFzBUs6uR0hkaRLVVRZxAvAuAcctaN1+1Y?=
 =?us-ascii?Q?gqy4bBKpDsgSafKJPlUCjooPWIk6RyYwDm3AyldqSZfpHl0JRILu7WqDPv1X?=
 =?us-ascii?Q?jK/pGTXXqZ18cZwj+ibzxDDeX2rv0NTzZ2eI3v8mZnGO/LvFXpoF9Wz+JLWz?=
 =?us-ascii?Q?YB+jaX9yG0kwJcn6g/TiNz0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f2ba8c-9929-4dd2-69f6-08d9d5d21dab
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:46.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC4xt1Dc/jh/RrKUg5wKfc51GJulm4ejeYwvv+lNsY16Yq9Whhkyxr915kyPJy/q48m6Mrk/razr8avvko8/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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
index 58f11ee41c..679667611c 100755
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
@@ -3044,7 +3046,8 @@ def streamOneP4File(self, file, contents):
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
-                size = 0 # deleted files don't get a fileSize apparently
+                # Deleted files don't get a fileSize apparently
+                size = 0
             sys.stdout.write('\r%s --> %s (%s)\n' % (
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
@@ -4303,7 +4306,8 @@ def renameBranch(self, branch_name):
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

