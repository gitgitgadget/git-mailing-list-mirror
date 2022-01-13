Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF8DC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiAMNsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:21 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235492AbiAMNsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch2m/YjGqNPHbp/xssnLmKz3VyZHcSChfRbwqSE/9kShbkG4lmbgSdaNlGDAGZih6gl5ifcJGJCY+lOieaCgX3rt6Oej7+UF9SONdrO2t+CsK29r2o/gI0RIXyWcXStpfaINzbscWpJFEVHvEBmwiz2bIKg/o4Wfu4CA7hbv4Nt83gXWuhJpMyIw3ya/dEuq2nxV8nEt3AYigDRnz+4/0qMAI2a6ZuYJuHbbP3LzsIk/vRmZe7dqPsnOowVsfNcQeFgYjuZ+2hax+xvRekS0chUQggfa59IiZes5Fgb0XwJ9mFkUzFFb6SlYVpJMKIln+L/Sc38t7gvwsyRl6Q/Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mZuGJGsCWEFbf5VUPvWwJLvLw/DEaGukrt2AeXZfFs=;
 b=Ffbs7mnHEYNxPVCxNjJ79HvhJVV9oYY3G5jq8gNao9zdztnUqds2kOBhmQU4MfGudFn+65QoVccPjT2ZfOHCQB1pQAU/X90lEMEDIyJb+FhPTNoSWGCBt0tQOpk89lHH0KO9XcF0wgsz9biYkx+z9y6OtJusQ58fu1+0+B4MzmPI0lk2uvjFmHelDlvRGZmCtGBtHo1B008GLPCtv4fHtZqCe8vXg8H7xOlQDQh+MABQsmV7sYQmDbmadpiEQR+/OKMBIVDVtC84JIg+Fs+56za4m9eYcL2LHE2s8lUkIf9HoOVj9jcblCerr4s4xqZE4zonr6LWCvCvAlCmV4WnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mZuGJGsCWEFbf5VUPvWwJLvLw/DEaGukrt2AeXZfFs=;
 b=tiBvypYWJ8beU+sBnAs+hrxtHobLVYPj1ZkNPobSK63jcFFISs+ivrNnPlnUTCMSi5G9Ye0rQbBpm92GMIfTjq0uYQGYCLe4qurh/eCKqr2Q0+rB2MkHebdyG/PtfP+EZPkZq+AdlhPHqE0HoCx6RT1gjD6LMqH9/519o8mw4ftW0wMQbyDstLgOBUfPcpcW+mn/u7fmOUQigOupOd7B5WBOWyvw1QoRlJyHW0ibJRHgbeSkgmvsbPX4LxfmKiOqOjOegnCEUSaS1t1vd/FF6mMcHLw7yFvOwk/k3MTtspVSia/MvjlhlNJfKPj+3gijC2gFuZayDREuXNug8DaYEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:10 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:10 +0000
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
Subject: [PATCH v2 06/21] git-p4: remove commented code
Date:   Thu, 13 Jan 2022 13:47:13 +0000
Message-Id: <20220113134728.23192-7-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b591c229-757a-42c0-c5cb-08d9d69b565b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447FCE576246ACDF7CFBF08C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AF+juRyVWLvMDQ8Y8UsHFub0lqXcLbLKa6yYN7l2JrgreVo1DJ6GxjEZma+q8SzxGpe1/sGTnjczQzWvwGtnUqEKQVReSPZKiE3/DE1o9fuRfuLoWn0STPwPKOua6UNOSftCA3c1HHtgKUV+y9PfWY1Jg+i4FMOHcKy7aHqyB7sGdhhr7Gx0HtSQAQYykRa9q6d2uOSeqOak7fiKl23zGYbv2sWQYEl3l2SnPOodsTZmre4+b7CpD4fDpaN+6oJzCfBC6Oq1UK2X5PJkOVXBEnGfvnYydk/oU0jrDKlW1wLrvX4+2nPYKS3dz2X2B9AluInBnbbLQKkxHSMbTzb9MSgMxM4ZgpIM/BJhwMzhWaG5i3brQGwRlZy6jx4ijsiN4MULYFq79S95Tyyopdq0HGgNbEqndbBEsjOIYi1E+c9Jo28rqkW4T7A4jaWWzT9V8p5d6YUxyjacOGGxLkoCNCvd9tWQGNlZVuzQSWYsaIB1OZWqUUq/esNUHjjntXRYQHguwCmHFTQ3gOSFDOpuwo/+WMrgwi78zpuKq+ZuwAyrgfmlrLeDQ6Wjs/Ns5/aeuTTBog5wrsLKVjsCJl2uuTTwpXocHyAGdczdSdmdbxCSsnUVmmIDVpa3uFufrA7pOvpl/UiTf2qRvekvv9LbJFwGT426zAS19D+iJ+P3/bK+d2qmITSpKFgnKSOzORKAMAEKTbuQo80cdatiqmPeEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(4326008)(107886003)(6512007)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b97J7P9HXQebszsgyUbPslI3KdU+2UN5jNztH1lekfrqvlb5hRD8sSoHFTDX?=
 =?us-ascii?Q?z9xua8qJH7LMklARrsz3ONrFCIeCK+Bmtyj7d3N3+6wP+gapQv3HnmS2iTMm?=
 =?us-ascii?Q?gcyiYxK/zpvV4wdUtLv4OTk3tSOZdKQg13OSdHa5mC5V3HeZuax1IW+6NSb+?=
 =?us-ascii?Q?FZj+LYkrC6Sgx5fZTiSiwQ2tDvuDueuM2uMQLFjLMPhGmSMraLt/OYK+Bps3?=
 =?us-ascii?Q?pxV3H8vvUsWSquxQLeIJ4dFpQeylhujk273ll7xsNqcOsO5bTd1hl3KVWv7N?=
 =?us-ascii?Q?N8QEEipDjz/2H1uNTGHSW4FguAQxNJ/OCag09mMI/zOB/ZdojDPE94FTEDaQ?=
 =?us-ascii?Q?cvc/+Ryh7ffz5gGQBIPmCG41gkrRxHprGoSZfXBtycU2xJdnI0BtZuPi3q4H?=
 =?us-ascii?Q?wlUUyx7DIcPSnBbdVqdpzYQ8VQUryFGEZ8bFCxwunsrO3WNh7KVKPAV45I4F?=
 =?us-ascii?Q?5FicJTQchkT1JMCKviLtZZCSjU6kSCz3ZjrcP6K2alNrrSqEbeP9Exxj9/MB?=
 =?us-ascii?Q?6B5A7c68R90FRBfrHOXNlW5VGlluCRlF82sqZYAQQeOwcHJo3B7TSO5rl2Un?=
 =?us-ascii?Q?rytbpuxWkrFmDpYHzexkflv2tVFVE32pdzN5lTzvcgIT1Tb2NFgIJ6BqNkdD?=
 =?us-ascii?Q?+2K8uILO33BPN42NzHkxYX5LVYN2KSTS87zEcPD2m+m2t8CZ4HUZbSTRSON6?=
 =?us-ascii?Q?COvJbmUDc3GqOwXIc44lZUD7xN/W+mtszYT1nNT8iMX8ZIjhV55Xejm43YR+?=
 =?us-ascii?Q?sWD7zhNajTK5ORCfNE12zQaGIJgoUzTfy8F0TgIvDRXq92BGWye53f7MZzbh?=
 =?us-ascii?Q?HAsDVeQr41bKieoN8kAQQeLTRP8JCAsBg3PNJBau7Egz7QI79CEVEw5IO6DD?=
 =?us-ascii?Q?IQBWu/VxlZH6UlH+VvARZmDiJ+vZZpoXdezpOzpPooHdQnvVOLqaz6w5Pugu?=
 =?us-ascii?Q?0o/WL6WSLxdPHx+14VsKe9Iqo9QHHql5WUZ8iROorEjzBZTkEQJgpwx9YtXv?=
 =?us-ascii?Q?koIh4fKtyrc+ofLuXo/X7Z0mPOwYG5BEIkOhBuNYxPOGSNAdwAJsBtMv1Giy?=
 =?us-ascii?Q?CjUj6EKBaSKTxhyYapCEEjzCkqUYc4tto6g7JjX48TxysRo64VuzvUe0Zrwq?=
 =?us-ascii?Q?jcgV14G5wOq72jZnViNj3ZAh0wyTOKftMkt6y3H6q/0Ex8y6ygkftSP0ViAN?=
 =?us-ascii?Q?2R5MXgoSc2UDqoSeV/4rwIK2d53fAjc8zJDRuumXMpN3jszfAWUQPBe+/ccC?=
 =?us-ascii?Q?6COjnl+xV+PL9fvXDuexyWcxxJ8HaMfRYuypMw4SxJ2XDZCM1T6ahd7V4OU5?=
 =?us-ascii?Q?eS7hVkdoLo/MXtEpuk2DIiTURyn3T4Rj17H4gUHvhV+VwCipZG1wiSUfb83L?=
 =?us-ascii?Q?s2U+IygDW9zC+tRfX2bBI9XeftA+BoMZY2F/iHpZsUQ4MJZQRw50AuvBU/am?=
 =?us-ascii?Q?kqlsmEqxnOmU+w+axH6ryNzNc9ZsIvY4t5va1HJIDhUencTGlB9DOY3GH5OL?=
 =?us-ascii?Q?tWwetKkqluTm9L+bWUFTRiutzTVkYbHtlc2cJjrzMxS5pS6jnkj+z7vW/KMX?=
 =?us-ascii?Q?fdRJYVitb5lEDb3B3JQy4UoLxExwtwGDpVBajcFbcHW+M7MQlm+auNEVjITZ?=
 =?us-ascii?Q?/L99r4dzYbTEhAlFVdL4kZI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b591c229-757a-42c0-c5cb-08d9d69b565b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:10.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhTeWznezadsDvpSCXbuohEoM2z6i3zSK2+zPA3esUCbkqvdINd1ORBr4dUGe4PGukQ+sgjFDMtK5tqdnaoIKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the script contained commented code including Python 2 print
statements. Presumably, these were used as a developer aid at some point
in history. However, the commented code is generally undesirable, and
this commented code serves no useful purpose. Therefore this patch
removes it.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
Corrected typos in the commit message at Eric Sunshine's prompting.

 git-p4.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 186ac36300..b598144fad 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3657,23 +3657,18 @@ def importNewBranch(self, branch, maxChange):
         self.gitStream.flush()
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
-        #print "prefix" + branchPrefix
         changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
         if len(changes) <= 0:
             return False
         firstChange = changes[0]
-        #print "first change in branch: %s" % firstChange
         sourceBranch = self.knownBranches[branch]
         sourceDepotPath = self.depotPaths[0] + sourceBranch
         sourceRef = self.gitRefForBranch(sourceBranch)
-        #print "source " + sourceBranch
 
         branchParentChange = int(p4Cmd(["changes", "-m", "1", "%s...@1,%s" % (sourceDepotPath, firstChange)])["change"])
-        #print "branch parent: %s" % branchParentChange
         gitParent = self.gitCommitByP4Change(sourceRef, branchParentChange)
         if len(gitParent) > 0:
             self.initialParents[self.gitRefForBranch(branch)] = gitParent
-            #print "parent git commit: %s" % gitParent
 
         self.importChanges(changes)
         return True
@@ -3816,8 +3811,6 @@ def importHeadRevision(self, revision):
                 newestRevision = change
 
             if info["action"] in self.delete_actions:
-                # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
-                #fileCnt = fileCnt + 1
                 continue
 
             for prop in ["depotFile", "rev", "action", "type" ]:
-- 
2.34.1

