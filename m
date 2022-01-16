Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1206AC433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiAPQHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:55 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:56160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235625AbiAPQHo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VixnmVDgQANrGHl6L6ry5FDCnagZmO877TCdNA3/C5N8WmE12R0s/9akkN8ZftTJAAWM6Gt4WJohaiSuS4iXhJ0+7kKPagUR3CCx2EgJDeP67hFoqDBZy4eiikdwkG6Yvv9M3eVBDzdSM/ctVR87ECqGYTl9tizuZd/ymClNP0KRR1PQUzp305Ou5fQOKH8Rv7xBbRhoddrF2neQqDJdOeB9ipuAKfZFxS2oLk7i8r8DNyO+xoBPrRDbomQkC+KFSVCwN5YOSVvs94cF8pZg56iNadVv0vsO7YxZiYfE/mw39cBLBWfpU2+kjYBXw+fFzE0moVZrSSgu17sc0+ujow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhuCVQFkY9nvDxZ1mq8sas7mK9d7DsPBYLjh33oLPBg=;
 b=lkhqHviJ+94pYGepCgwVwW1Mrh0ir49gFUm+5GMjg6e0km3vURMpIAiQYpEYx9yWaujISKsbWB7rZFQrY9K/PPJpo5epMdnkLeJe5wpDJIvoPVeiTnzE9KOfiooOFV0r4bklDJikSEfyDidKjBoxuBu5QXUcwP2iZtoNY3OXgXQu4BEwG++J1KeTRfzyLUD5bESp386zylxKn3UFf2Ie4xODTuLgeMishvsvQoTodMyLPiqgKv4tVvPBAgKbDmhibwXQOV/9TBJJJZlLX2d+xp3USXUo3I1nVtPgNSvekz8KShDXHMpgLpW4hODpdV77Vq4wQvQ+ocqUyHZref4lCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhuCVQFkY9nvDxZ1mq8sas7mK9d7DsPBYLjh33oLPBg=;
 b=dd3CEHf+oqNGzLsMNyg7K2uQy/NHs+bVzPTkKH+59haZ6+arpJ9kjhq4sFJu3FW3H9jZoQwFMZqa8GvyNh/WV9vrWX3a5wFcfd4AfAQZoFlrzQwp/YVJIT0TmT0IPfGIUDOKVHXlGLLkV6euWX4TWHsKZ9hfZF7Z6H0LNDF4oaNRmSeUj2+xZQY0N666N2xduVjsoGedvadfAhhY8tK7KctRTq4HMHVq7M5mV+ubwHLqTZiHaeA2QuDOidVfnpoPK0RYNOH7JBqJm310JyKUFTzYN++XzJtX91bLzMUnW1weJIHX9mKvQPpSNyhQbW7YoQx96oNXyjdILBHCW6XIZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:35 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:35 +0000
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
Subject: [PATCH v3 11/21] git-p4: place a single space after every comma
Date:   Sun, 16 Jan 2022 16:05:40 +0000
Message-Id: <20220116160550.514637-12-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e5bcb15-64d3-4be2-c952-08d9d90a4f0b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259736F2D1B340CBE244BBC0C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd8UQKLnqUZwVVRPaOPvOp9To/TRLnQaC0wfSpFUOWKivhduVJPUNkXv2LNjBbNTaa1dizinCPEbQ+SEB7wxlNA9GZYrBAg20/K7eTMz3lJpi9n0ltWot3gEknFQw4K+yiiNLoY3m3/NwUnznDeTlWwNx6hE4RNg2nUizK11ooNjJ8SegZ/DyBEyLrGedBqxKFf9POnPTQtzGg6utoBntax2m21oXDPSzKdl2PCdzSAF2AsGcL4vfegrWPEKr9rrJI3XCcUThJkNwObtmKQhbEJt8likp7hrFm2wnsXfyEBC7GlAmRGXDpoCVmRsaCHWmKdpxjX8SORUWRcQx32p9xv2xY7FS6X/78MYMGsak7ItgN4Jopx+eLy/9EB8ALzBaCcQSdnbQUxV0gSO4mVhAwW+/6IbR/tjI7pU2zNs+hT/Ri9upJL6Bn4bCNObHcchSNtkcq5hKlu2e3H7VlJq9Ydt55bts4X5F5BpcECGptnPGoGEOG3Xey08XcR4ml6CA/WbfkJWhgXlihyueUlgLL58oQhvJz3DM7d20sdgwaC/CfH1pe4bZwGPeVLx1zIg517wSFidnbscC9OBwPd7UaD1VK/KlJLzsaA2h8qHt1e7OyCLdEw17t9wtzZ2e1EuUaULFFTSOFk0cVxvZlwVX+3X4bqi50q64q12cHgsPcFg3qOtdiUFdc1tu/QOlYfQgfPU5sgENfi/7p4wujfKyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VimVV3qEKcgYVebJhKZj52jHqp39zrfZlEML2cxcWFdaNmTYW+rx6QU66ipc?=
 =?us-ascii?Q?L+TNRTrivSwOePnf6bG6nVe6pZ6ixDExBUDpOnRHJuNSqsC7LbMHfn7HDSsw?=
 =?us-ascii?Q?2mvNY3idvNocmkafoMJ+hJZYvtlPmuvl/cnrWmSKFYkYZj6map5jDdynu1XD?=
 =?us-ascii?Q?TE9bqsscUDKeh2pg8HWyLwiT0UPEu41ZsQjxYBYxZp+aONEHVI+cU14ghi3J?=
 =?us-ascii?Q?R7UY3abVwSIZ+pqZ6f0m+sBwj7FkOjPkxrpMGWkTczeFFN2Vw3xm3ajgHLbz?=
 =?us-ascii?Q?1lc7Uf9BtJIo63194Q6jlkGJT/rAXe4VEle5gKS8ujrjBoNtpCOUEPS5wDUU?=
 =?us-ascii?Q?OLJf0cJMS0IskovxkDRqwwc0m2huBl/XeRkWNvMQV6XbQohEK0dgpEI7sjwJ?=
 =?us-ascii?Q?vV3Gx46+co1CGhn/vTYltctqmTEDh5xRzBiMSizntx25qNTsRT3lnlb8oK3e?=
 =?us-ascii?Q?7jI9D7tCFIEYdHter3B35fh2gfnn5k+W31t6Yg7CKYAe7lzPcnKBRf9vbV3U?=
 =?us-ascii?Q?FAtdJ4N/Oc6xI81QOVn5nvZ7S8oXBiXrQyKMr3x3xiKBGfleoD39aguQoBBs?=
 =?us-ascii?Q?coLhbH44YxeYr3r/QxXwG+N22fTM4lNZARKzf3DCtR1IpKKCxocE0A2tPyIZ?=
 =?us-ascii?Q?GRFOgE20XGdJvDjz7FnrBUlOlQR/CLrGay0M+8Hp1LLkeHtP2Gz0WBbyMtN2?=
 =?us-ascii?Q?mjgqXyr8ne6GBVpErNKh+Pxw0XNDoW79F15pfxdYUCFyt2N174znkwluWeK+?=
 =?us-ascii?Q?dnAnwQ6ehFoRss/Meibl+vRrFx1x8k2bFD9OMqAJ6QgCDrCdpn+KJwx7yYc3?=
 =?us-ascii?Q?Aj6A0RTVZqLBoLOzynrTVD+8f1kvE+q8xtqIHJiWHNEtURiCCg3LEd0/zxdu?=
 =?us-ascii?Q?GT4ASkvFAKEHmrT4a5MXtn2PQ3wiKupwxj85+cjF7oHIjuMtKAtVJ9R6ijPo?=
 =?us-ascii?Q?AqzIxh/Idwr3atPJ0ZcEHsUATzFaFwhr0va86goXkF/8GjT8RDO2fQlAZo5N?=
 =?us-ascii?Q?/kviCCsp+h0CoFyUrU5sdM3o0sBXGaVLHFYpWH8/eh57eQ2Hy8tjKyCLOH0q?=
 =?us-ascii?Q?5LTLwv8kXlzWt3Ldhj2VBgOzFHqdIR2zXxTXVLdB6h/D+dBRkO1xaKVzgaO/?=
 =?us-ascii?Q?pYfKIUlv6y3fNhooLzk1jPyw4cZXU+QRLFMVWMdshggA+D9RzJfhH1W/9NxP?=
 =?us-ascii?Q?v9qoVXnsP1aUqggfk532sK5+GgWuJpez1Ft9US9uNdtkej9lBWNmkqlDzkML?=
 =?us-ascii?Q?HbMO8X/chcdod5CIlbpHq3C5iNeQ/jySylXhGo/5filEna9etrdi3jmW/5//?=
 =?us-ascii?Q?cLwU+1MjBApspCQJzj+zIXl9jAtlNy8HMdrbrLm5niLsc1b2SBbAQOgOtX+r?=
 =?us-ascii?Q?P2PugJOU5F1+2iyN12BiR3P4oaBZE54DkZbipdpsbueDY0TkyRqDIAfFpAuf?=
 =?us-ascii?Q?wBzKr4MuPV0AZ2CKmvsGyTCBDDHic/PGbNziJyyL4tfN5TeTwsqLpQvEC1dj?=
 =?us-ascii?Q?Qi4niUYOsO+c5J0aL57bVRTD/TBpujcTdnr4IPPuNYn++vYiygB4b1exfB1g?=
 =?us-ascii?Q?oFdx9ox8AqGqQ6nNtk4+1Mr0vie5gNA/NwZbaKhgJODr/aznpJuao4g2Ya3F?=
 =?us-ascii?Q?PO8MH76DlYB6ujBqT75Hchs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5bcb15-64d3-4be2-c952-08d9d90a4f0b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:35.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OMDCUKlcR8s2Cwu6aN+alMveq8MtZpUql0femGlAWrjYVq6hwQJVv2eUwM9BGGwtLJD3Nruwg6/I8aKTDvKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch improves consistency across git-p4 by ensuring all command
separated arguments to function invocations, tuples and lists are
separated by commas with a single space following.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 385ad98384..6a676cb415 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -99,7 +99,7 @@ def p4_build_cmd(cmd):
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-        real_cmd += ["-u",user]
+        real_cmd += ["-u", user]
 
     password = gitConfig("git-p4.password")
     if len(password) > 0:
@@ -1824,7 +1824,7 @@ def patchRCSKeywords(self, file, regexp):
 
         print("Patched up RCS keywords in %s" % file)
 
-    def p4UserForCommit(self,id):
+    def p4UserForCommit(self, id):
         """Return the tuple (perforce user,git email) for a given git commit
            id.
            """
@@ -1833,11 +1833,11 @@ def p4UserForCommit(self,id):
                               "--format=%ae", id])
         gitEmail = gitEmail.strip()
         if gitEmail not in self.emails:
-            return (None,gitEmail)
+            return (None, gitEmail)
         else:
-            return (self.emails[gitEmail],gitEmail)
+            return (self.emails[gitEmail], gitEmail)
 
-    def checkValidP4Users(self,commits):
+    def checkValidP4Users(self, commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             user, email = self.p4UserForCommit(id)
@@ -3261,7 +3261,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print("labelDetails=", labelDetails)
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3467,7 +3467,7 @@ def importP4Labels(self, stream, p4Labels):
 
             if not m.match(name):
                 if verbose:
-                    print("label %s does not match regexp %s" % (name,validLabelRegexp))
+                    print("label %s does not match regexp %s" % (name, validLabelRegexp))
                 continue
 
             if name in ignoredP4Labels:
@@ -3788,7 +3788,7 @@ def importHeadRevision(self, revision):
         newestRevision = 0
 
         fileCnt = 0
-        fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
+        fileArgs = ["%s...%s" % (p, revision) for p in self.depotPaths]
 
         for info in p4CmdList(["files"] + fileArgs):
 
@@ -4293,7 +4293,7 @@ def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
         found = True
-        for i in range(0,1000):
+        for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
-- 
2.34.1

