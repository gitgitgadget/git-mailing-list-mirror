Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97B3C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiAMNsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:38 -0500
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:7808
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235528AbiAMNs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMsfl59GafsGFiHan22ozABCsjRBcbK3vd9AkUwqmIfuMtzA6wquwj8ls2VdNOT/ND896GCm+1gHwQvhzZCKyHqxvpo6U4KJPogxR77SIGXnD8Nigkykix1TdWYh5DTCb9DFNy95XHTtQeySL9tQ/yDjJCqUB7XlRiulHv7dkM6QKrBoDr/efDWP6HIuAH0oNDx+kCIdexwVkCTbDahFNLKj6FUSlkQnLGG+SGATi7v5T9NR97TqiX0deSJhFmXoNm64H6Z7aF+rNBMl/AkljBFR+2XqnAFMy1RdYQw31ddCgEXP6yWQiVHzEDRo9a4Eod4/MlfJyrj+KLjJRnj2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYwv0+IHudTewr9+LYlwNkcMaPoMrtJ7q0UfsY3yyh0=;
 b=KyzbwxiNbKW/gJUdMDJ1WvwuHnvESov2Pf8NCiiRuxHajff2RVOTLO2kt1tPL2ivrPMSp20R2UYTnQ/hmmbNP2TJP6yuqSQG8VHZr4c27jBpN017BjZsAD2WvFI+pWqK/24poXnqIz/zOREyiOV/PYzamcq92MRYuT8NFIQDvH5v0cS3RO9n6yvt8AaLd/psm7SGB1eiCX3rFRejokGcBvZvfCkSz33c2PpzLBZxBhnh/jwYbHpHsHW3KFZ47FoqE5zj9mBB9mXx492FvPHjok3rvSF2xX9ypSLHXL7IfCXDKyuSEcgTlyx8Hc1gsZuwM05AYfFmRmxiyOvUdba/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYwv0+IHudTewr9+LYlwNkcMaPoMrtJ7q0UfsY3yyh0=;
 b=TjIEnF2QaG8wjqErdsixHrGEh6bwe6F63ImqsY52n4soE9z2RNzluYWqFh8Nr1nRFaHo6QrvLpbhre8vRbMEy6Evtx9gXJH7rtGPfyCv+PAROxRYxc70sL3XicpeMUAgxwFwYO2HgM2F3MSuCztFKmParySgz6PZK0tVe1+Ata3u7D1RLHuX4ix/quO9a016t2wqwr6bgQ1m0RF3mYM239LW0qfOyZTf0dMxJnPyCOv4v14ZqSWWJbDaRPy4vZbqZp0hLpVXiwEvf/iTGsDy5ehpVCUuvIb4gLlYj8rqImAk5FvuydrNit+XUFdsuwhwUEA2PqB409cEKndCxZLZHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 13:48:25 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:25 +0000
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
Subject: [PATCH v2 14/21] git-p4: remove spaces between dictionary keys and colons
Date:   Thu, 13 Jan 2022 13:47:21 +0000
Message-Id: <20220113134728.23192-15-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4b245a1-1c96-40a2-ac22-08d9d69b5f1a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3791742DF7C587109AD4B6F9C8539@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n6XqYVSGAy/zXJeWzqrx3S8d09WLOrRlnqeSkLROehG2NhKYAxVC/RWI7S1MhT2Ac1FaK6zWEJdZnj8/aQ2eKCLk8WAImmOf2/jbEvq44T7KIeVnqLBqRPFQ+u+tqhxY0e/CoxbQ+h3gzTJxgkImvZ3Wp0xxbDxYMWdyid4b9M8q1ThJRUq5Ar6wV9gTf4bK2aLBdGUvHHmk7l4XR+pmDa8VQ0+5OB7YnJ/OAwi7UVTzqTkBgRMA/Tx7f7KvjERCY3LFRw/0TPNpI1XWyQpT2ERhRdIVKDLqJqdcHPnxjGxxKBFO5eLqHc4jF5tjEdQSIQ93WYQZjex60D5UcUZZ4iLFE0vjyndqM966eYIFqJoxGhKk8wdaGjfr2FLt3tUPCyMCSLRSgOXkvDsvKA86doVVhsGvCqhlOm2oFbwO8h7CZr/g1HcF/hTmoR91O9VmsPalZKVmrSZIw84EIfJbtVhxYQUbI/zif8JBTmNU8U5nqoL6B9leeGfr/hAW1VM5pb8g+ZgH5Gf8ZWrk7gpgZIEod1Sag0I4PmH2pKJZS7raEFLooeiyDkk+jS/Wblsqh9isy4o8xH2Iw4O7TpGabhju8VbttNzDJ5IU27QqPZdpTZnjWJQm0zqvQ2DybL2Hq7zmneKtQjfVuIB845CEJeGkb+CTs35prmKMWvo0qVWCX/omQ6xoOlwWxzu0gpIeBBotbt0ifUDv3ORRM880g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(316002)(6666004)(5660300002)(2906002)(8676002)(186003)(66946007)(66476007)(6486002)(66556008)(7416002)(52116002)(38350700002)(110136005)(508600001)(36756003)(8936002)(83380400001)(1076003)(4326008)(86362001)(6512007)(2616005)(107886003)(6506007)(54906003)(38100700002)(55236004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtnflZECrrCNVew2ra3lhg1eYI+ILp8ka9ZG8GeKLvGX61mxTECkB0J3EuPc?=
 =?us-ascii?Q?u6nfqeSjtrPY8L/EECedLD8sJAZGhN0C/lFkA7PpPpUnJ7ld3XQzaqKuJ9+B?=
 =?us-ascii?Q?mtdoV5nuOYS+nvhDhoBDLXyca34MON0fLYyUy2DtMpmOWZy7R+qWDozvUVN8?=
 =?us-ascii?Q?9W2bXJn7e2hjczsspnNYysJmMvMYb0Dg+uuyBtwjmm+vhQntJzwjQmC45/Qi?=
 =?us-ascii?Q?S7y0bxxQEptiyb4xXxUeedZJ58M7OWyI4WKgTfms+eu/iHzg9nmMe6JN9PvF?=
 =?us-ascii?Q?AfbN1p44A1M5NvGkN5jNBUNc7YGDo0WKuKY9cboKVwcEeLJdZ5nqlK6AR9hS?=
 =?us-ascii?Q?LCa3xuf8R09402/ivFphzObP6QO6HjfkpvJ2Ck3ZUrR4AX6pkV4IxQKG51Ea?=
 =?us-ascii?Q?C/6pPPoLdfF5o7i+OluOONRu5fbAJWC0ud1ED/V24eDY/FUCAVlxiiduq48z?=
 =?us-ascii?Q?3Xa+VFMX5tUtBoYWNPcATBAuIzf2EsIDKswdKUPs8v7VKGcsaEU5D7vjlb85?=
 =?us-ascii?Q?6GKsBNhYXiiOqu1Lja6/dpgIG/ZdbyIYSx2RSwz6C2I7ljMP4n7RgEpPtDlL?=
 =?us-ascii?Q?FoOyko+mGBFq414SmBAO2j5eru7OAfROufJiNZOSh86e9zXQe3/qpaH2xKwN?=
 =?us-ascii?Q?FF30oLTEQzPD06PP6mkjdmNxzdaO4olBNJpA6TyRp+hhvyCG65rDOLj6AvIi?=
 =?us-ascii?Q?MgcS6267lBb4Y7fVW9GfzS92zWlBJNTKWc91vfH7U7AKjacAqnqBHWYDbn/0?=
 =?us-ascii?Q?bj8y0uh11/XNMy8/Y+t6Qc1BBiYYXo4lIptCFdY+RXG8a24t2ch77o7PXcnS?=
 =?us-ascii?Q?epD4uC+8aIMST83zFOoeSJS7JcL+9k1atRrdWXO6s4/8eqi76TnW/5M52Vve?=
 =?us-ascii?Q?T2TrRp0PdHyWrfLxkK00uIz4lgz1txGm6SDc2cir//Oi9CAXx3DkDWl4Cht4?=
 =?us-ascii?Q?pYhaEJe8jBKN7RBf8Ac5anY4jbi6AqgI9hj8xYzBd1MQe/NTdnd+uhTD8wLu?=
 =?us-ascii?Q?kAe+FtELV2cPIJtJx/dnCiYIHaeJTGiBuPditayql4nTcOcUXg442DGqtFc/?=
 =?us-ascii?Q?Kw/SQjN3M79Nt5n2zs4e8T7sF6U7fx8WdIN9TlXJHYVcyVc5pBkLZEMqLBW8?=
 =?us-ascii?Q?SMN6MibvRzTHbHL4uMmTbKJ0z8G0MrWsQUhyrUAZzWMDeyxBzd/AJ8RNpsBX?=
 =?us-ascii?Q?5K0Mpyy6TABPgrVzs0klWP9UiWHo1NQiGDM9maG2UzvcwKzeM9Kas0UlSy9F?=
 =?us-ascii?Q?WRQMNF4V1ir4WHHYdmkH+QMGh7QVxWyHEGpUwP5rJI6g3Oa03JzPO0ZBZoDV?=
 =?us-ascii?Q?1JcGYrTBIdsshe8GeWWFKhhw8/tpQV31mQBvTBWti1sd9kq7BK4zRjK+PPiz?=
 =?us-ascii?Q?nj/fBinvQgpmXH6UFI9P6Z/8lWyWHffjbrPD7sAtZf+xZtiLQEcg4rcrrEdt?=
 =?us-ascii?Q?mAYZTnTBIcLQLK1Q+Z1HURC8pIz/F7GOrihH1bCjzxHwgU83ikDnJsgVYlus?=
 =?us-ascii?Q?Up0OQZpbW4Q7BwpEdy2SHDQMyNEXpZ016djxFgHqPQAxsbKmfg0dTC0HOt/u?=
 =?us-ascii?Q?xIcSDIOgPrWI5uHElqvnC7YJGzP7vXFuCwM8ByZkAq6nyHrfWLdKyygdzSKH?=
 =?us-ascii?Q?ipZROdv1TNV7/j6+MZL/uNk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b245a1-1c96-40a2-ac22-08d9d69b5f1a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:25.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXuo5RUkTDjbuxeXkJxksPrdaAceQDcAETe3RMqNjwAaTrQLq0ZMlOIdwK1hcWnp1XM65+yi1J2E18gCCpw9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 makes no specific recommendation about spaces preceding colons in
dictionary declarations, but all the code examples contained with it
declare dictionaries with a single space after the colon, and none
before.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index df9fd2195d..f77a5ac000 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4454,13 +4454,13 @@ def printUsage(commands):
 
 
 commands = {
-    "submit" : P4Submit,
-    "commit" : P4Submit,
-    "sync" : P4Sync,
-    "rebase" : P4Rebase,
-    "clone" : P4Clone,
-    "branches" : P4Branches,
-    "unshelve" : P4Unshelve,
+    "submit": P4Submit,
+    "commit": P4Submit,
+    "sync": P4Sync,
+    "rebase": P4Rebase,
+    "clone": P4Clone,
+    "branches": P4Branches,
+    "unshelve": P4Unshelve,
 }
 
 
-- 
2.34.1

