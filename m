Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50254C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhLQUjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:39:23 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:19150
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237008AbhLQUjV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 15:39:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF/YqKwQOxCHuszlx0VkpD4taRiXGReBH5dsd37FT5l+zUnVheR8KsLbiSlZPz7p4Ahu1Dmo93okwPWq+RZM/f/27H7oYgSGtTTy5CVF5uQUt4aJ5qabxcF6kxSraYCuYtsCDdQng8s+p7LJRCpPi725Qb+S/D46+NquOi1NHE0RJBR2irg3vaDVk+QNYaUgTctEuLeR/3Xtv0Z618gNH1ZO5pSv7eKSsj8+3GbimzCwOWpokkWaZDDOPsfnJdCY2XFjvbscz6fQcUb90baW2ETVcwQ6oR+vEj5Koc0NRr+B5VH9bEdHEAMu9pMPyzHbz5KnSdhz0EJu4jCMrGOAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYf39NgNGt3/MevIpw9yFKdfXKNWT9WADCXGQXSe4iQ=;
 b=RPLsZJgFItsXK2BYWZTInJ2JjvrKZ0W0NkPNFODoXxWeZDc/w8scaYHJ+sDjnrtpwksVMnSTPiU0ibjTU+PVbEvIAXul1yBPJfDg7aTCdOfVxrwqvGwuCDrBaRjTt50LznktAKJjhaa681l6rBpBLjtV7eGjz7Div1ApuQOaukLtprEiF4lDkrbbtnYyAyUeyNNhfKDIJ0ATvhTCRgO9guVjSFepJNfEoev2CX0vbw5eXa12vnDCOnT02gB9xZnpsZJJEMGP0bWX6qPLGMPJQo0pLXbfnzTeomia4nBF2o/oQN2q7TdaZzymbQ5SHGkW0qNqav1Vs71Y3G/n8Wzrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYf39NgNGt3/MevIpw9yFKdfXKNWT9WADCXGQXSe4iQ=;
 b=P4W+YQQCsQurLh0LEJ4oYU+lWSf+rmxL/fbvM6l2qizOmWTAIK0ACOVZg6rc7WxfFcNrLUi1uVt1BBiZqSmDOj4+O6kaKUeN1aTv8x9f04OUNL9cG+FtcRc+yEwXAz+H9CmNvPS8as2yA+5robyXlGdH0km6IavTdsh7HN9NKN+Fhqnb6BoKWqK5/AVmWtJThXudrrPUXngkS+E35upi5K8uXxvv3TH1UBCshCyEsMG8kFkiymf1iIf0uvJ4xFQDxBU7nYPTir8DgbILKEWvJcy4Lk+tMy5emtOeEIPKATgPKX7Qnu8/3CWeF/DyrX19dENKCYzEuXU/MBerHgPnYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 20:39:19 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 20:39:19 +0000
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
Subject: [PATCH v2 2/2] git-p4: show progress as an integer
Date:   Fri, 17 Dec 2021 20:38:56 +0000
Message-Id: <20211217203856.2339161-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217203856.2339161-1-jholdsworth@nvidia.com>
References: <20211217203856.2339161-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7fc5a9e-f394-4892-d7cc-08d9c19d4cbe
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1652892AC2F851F4FFD3C73FC8789@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIFD23Vvr+itQzOFkTx1VsikG6KGDVUIVz0hfP4dtIKThB5mKBJKq7Um/Ynpd/Vip6uXfj1grjohNpAzgELFBD2j+QP/4NVFnyOwbbVjJ7EpsdJ1qBdG6vA+U0wK4kMxoCbR3+b+HGVI4zbGFJQAN2LL7ORiwdFY3KDxweCuGdnKkYXddfDOTrj6ylVT6z+Sf+eNlhaEP47dJdU11OrRix2+DCH8FbOa2a/wVAYRs2XAMYMAdqOiMxRsa19YIxK6ej7chvkA/4k1r/rePLlkKtPeHYyLrEpbUj0b+6r4RgFbzK/nJKWzLCDJ+pQsAPKaFEYPJ+1e8ky8xfJwrr/MtLstk0eOtBAUIr+5VNgGrVeoUx+xxgEE0NlnySeDxjlcyxAFJPBZ4sBBobzuk26cTkEklGgJOlgq8g7x04trZ1DSTMaTtdr3zq/QUwPv+WHSzXyNd4FT4n64L1B6OMzNDAFxQwU1b1gzWpZqjO+PH16KsZEoP3wZpIZ3a2NB+zWhdJcfrna8MLZyHx4UZ4MgvsxxXaZLjT55n5Xpt4Fk7UZZkuZTqDweARZYsJhuyL8ZFxi5QxEEShsQ7RkgbMNliCLqlewZYkw9qv5M+tL7ZUWnh9Kju5c8IN4H2FRonxpqgfsPZFp+YpyesWdskD4uYNieFWhEootXDwEEWA91CdgCB2n6IB6euVsNnYhgWCqhNkmAyoXtMp4rBxOoeWTZTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(8936002)(66946007)(8676002)(316002)(83380400001)(52116002)(1076003)(186003)(36756003)(54906003)(38350700002)(508600001)(5660300002)(26005)(38100700002)(4326008)(66476007)(2616005)(6916009)(86362001)(6512007)(6506007)(6486002)(107886003)(55236004)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ah0YwB+j7Hsg36ssw0cQJTye57+/C9YqlWzq/RtGQcjZScwNn/ajlLmtCNH?=
 =?us-ascii?Q?asnQH9iHRVcTEUTE+DnTU4n2O69Si8xj4YwB8Vnir5GjboHHySEb14ctSBKW?=
 =?us-ascii?Q?1NDzgc9tukK4Z7y7L93spNwXA7CdcPcYN1GHJwbk5hJ3sK8CzFQeQ9XZZLJH?=
 =?us-ascii?Q?2x1mU/rGfT80o9ljJ/S9KC7Qfn6N0qQiIYy4uqEJdYgC11P5pGWzzT9Qwm0E?=
 =?us-ascii?Q?OeVO0z8cY35US19X6xF/Qs819sbi06Bidsxt1OEgVcmhRbbITLaQM6zQs2jN?=
 =?us-ascii?Q?9A5/1A7V7lre0k4PZ9JuJCfZVJk0yqgWija1tcxovoXnwA6kUQ2sl5hdgsk8?=
 =?us-ascii?Q?kY6XnZO9P7lK8RO1EdseBWm2P1W1zZs5tz2yZSOSq3KugnY9YQids0x2Sn4D?=
 =?us-ascii?Q?2C4W15Hg3w4MAQnPSOYBK67FGJ9GSous7pdL8Cfw94xFNg+vFZEd8xKrJMv4?=
 =?us-ascii?Q?6oDZiqkOjTz/c3QlO7+1oudENAuDS+HsdwkTVISUJniEkGfKoUZf61HlvDeM?=
 =?us-ascii?Q?Y5i53EAZPXwb3f/BUkFT6jOR3wJEVsMcniu+WVTESIhUx5J7LjZO4qdrRX54?=
 =?us-ascii?Q?2H20csEpJEZU6dfrV+SxisdwdZfSDvwsLSyCYVe4QIms641FjoxV7b8b2Q05?=
 =?us-ascii?Q?qeYwoa9P/gF2YnYpGiIz2XiH6UfKk2FI627BCm+IzA9xR/K45IlpI3nuBbTo?=
 =?us-ascii?Q?rAbmFoQ+n2SeLFZ5M0bjgqJ7XdAAdJ3dYvaNseY2pmP0p+uCZkiC3k/Pbid6?=
 =?us-ascii?Q?PXjY8+1qV6BgaXkFJ15gO0qEdLP7P2TAdEYvhWUrW57EK/Fv7Ql3x9nngjVJ?=
 =?us-ascii?Q?c0NxwLb88gyjjHzevkDFJAuHjvyeWYU/wYsXNBYyjPqbjQUruLEFEMWzN9ER?=
 =?us-ascii?Q?8Uik2wxhj5Uh3JK77OvyykPF7G/gU3CMz1+wegHabSzWb4P1BFT8kOs2dkJB?=
 =?us-ascii?Q?A2QxdJ6UefUmQvdX2nPpenjrAmGGFFPf7ei204SMYFTTbjheWWoGtN67xVT4?=
 =?us-ascii?Q?nZUl8M6zc/JBE3GKtS4z+gaWF99ehhTpbaMljZ1A5mmtAi5PD/RU/nI0tMq3?=
 =?us-ascii?Q?8K4h3+YWQRbcKrj+0WlA9G09HHJEzv7NKElFpzKWjr4W4zmBCRikcyOVmq8W?=
 =?us-ascii?Q?WIjdApqR/ztiA5LN42IRwk9zu4DEq1aODx5r30o+gZ2zfPKOCz17JRdOVjoy?=
 =?us-ascii?Q?WBP3O6EbaywWNtjQ0Y7CA8DFG7Y8DIIc5RFVWsduVXLgCcK+qX5tfT3VqK6Z?=
 =?us-ascii?Q?17cnDjoCS14PfmvofRyYiK54PTEl4VnA4MovVreybbmK87h1WBpEfSsUJ49+?=
 =?us-ascii?Q?Q4vAcolqWeLxVUUs9cXhTVD8La6Be0djnggSrVHFOu2BMaeqXqMraqojpnnR?=
 =?us-ascii?Q?bAXB0GgjEff0bKEmLB7KIE7PJi5iO5zIin78z/BqjKc9DLhAtKogMD/ncEqV?=
 =?us-ascii?Q?pHVsr+Xznw2ihVHHWbb25Gy5yKd+WrFICVqTSlPpXTOu6Y1ngGYotO4ik26Z?=
 =?us-ascii?Q?dN5Pn2uZ5a4SUdTiigmCjTOWESyIX0+fISZrOFOX7AlArm7yZ8/IBR7qEFzy?=
 =?us-ascii?Q?mJL/qctwS7wEyYZXPWh19R3EHjlbOFvRv0OaXN7fOeJIMmIB2xn0iWIXeuxV?=
 =?us-ascii?Q?0RrzjUTTNwjFPYw0CtNbQUk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fc5a9e-f394-4892-d7cc-08d9c19d4cbe
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:39:19.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXVTd7uu9xk0zzNu8ZCy/WZEi35F8qAOZqRMNlYSHrbWRkfsj+ozUOaLoxu5BvA55hJ4aj2cFHNn3oXQ6H9oWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
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
index 4d8a249b85..3c621a6efd 100755
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

