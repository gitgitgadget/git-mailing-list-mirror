Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9EC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbiBJQr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbiBJQrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C975E9A
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTgNRZtMKb+GpABbnNYlZ90rtE3CBUBEy4HlUeotm6LJ8sNnwcBDtwxXj0QjKE7rTW8HxJMz2rkW+69ELJidC57XvxuMjl03fLudO7TXH4oJLZfyvSnk1pfMk4ygBBgyVPA3irEKb/vxBwAZ4Ni4jSgghpJDQ+9rcX4ntBdlaIuKKaIP+wWWWqbqQUeFPXuXGrj2dv7Xzz+9rb33qbzgoIWua3fQZR1nzIU1NcLWVO0hBbe2K/oY9ByTB2p4229XWEzwDZHFZFHZAOTVrKlEcXMBbiMrxOWMlOFkz8SGl1sQX9AQOANeZVKyIyp2lqgZLQYG2uib5TgctkUU09AkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+rg5RLz5bUn6qjy5mptT1Pe3NBOyqVw5KJqdmUPPXk=;
 b=oP6bmUoaNFu11XjpH5x/oASfFiok+bWssKVzRPfHgi7tYeGNCl1o0bmILvNk5pcfCiStwtcVLU1ifaA3Jj/ktP3yrJ8rRH3mciABQ+D7sQgtCpty12kRHzZU+bvfT3qNw/N/FF/R8uL4krgd1+QrrikbTwXgx7gbMBVzjosKTa+EojlqdrgydctdUi/i5TsYLgsp7lhzGcAyo0wBm3RH6+u3FfdbXrnR/Epb+YSmxNwEWp6sq8OGCL35P2LfIhAp6aaUAsRbwTPgosbr+tO4ZSW+3U2Yei4J5lNg/Csf0Hup+wmi3DUP7m5KJQNSKMGbJ69AjXRxoAlrAeutOC/k6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+rg5RLz5bUn6qjy5mptT1Pe3NBOyqVw5KJqdmUPPXk=;
 b=VtiYMZ59X7ScnAyGm5Qy/YgWM2CzJTDjMLYtJX5MurSjYmZBQvbmYv8fK5x/HIRDzU79zGXHNY14KdgTz8ohLfAorIEJ2/uP4hHpnMRw682RDuhP5JV+3Biu0BS8GPIedBHd1CYEE7fVQmaPLDxftT6e35kjtPV5m6H0MEHhhq3jqYRUTLqR3LoO1QUnBe+j61P/4hnW51WYx/ymw4KO7YuYeynfv4iOHfN0e4glcUaKrXDwYj09svaTzeUVvjK6xLMTMMz6fDtX48pj29oCr6RWQAhxrWauGn+PCdsEv/QnEJMxuETwY5cVXSoL4Za61gZ3Or5MgnbTiq3ItCSJ0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:22 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:22 +0000
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
Subject: [PATCH v4 14/22] git-p4: remove spaces between dictionary keys and colons
Date:   Thu, 10 Feb 2022 16:46:19 +0000
Message-Id: <20220210164627.279520-15-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d5fc3c-b6e9-4426-d096-08d9ecb50205
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB136285E27A35A645DAA9CDB5C82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmBrsPCNCcXRiMsztWPH4dEgFxGQ6SgD/hvuJUPcFrqmG9UZPRwtFF/tnmt9zbSRMWj7jHKHC0SUklRz43MEaza1aFOd7qbfIF4LQXTguN3CJd2EEv5k5tWPPZZSOG577lrBdT73IO5dCJbLcGYVFXR0CacgFE+/m56Nfhf8TCPPO4gspXDK5BBYNKOx724eblpeargDWzlpf1ypwZUFNoAQwg4nj+x1Y7TC0QtqV0iCXWVmpW0Cfta2WzwQVifl4ZtaMSkLAsfFMAnxi6yqEY9qPUh4ylrnqP42ar61bO7KuDYp5V6bPYXgR70qo5OW0Zk15OwjsNAWKJmgq//Ef4K/wfTyXlvKOvzSMI/RyzfOT6Dx9p9JWYf3FVJA41uCGkYYgGo6eaapqtXiDT4C684YRVb51bRdTCQeu0L4ZzSG+m/Sf5HRje5binfBfSHPhUPQh5mnIxuoFESqv9qLqgA4hZ1X4tT08qIZkpyq/Jxc/FbUMSUX4VKkfRY1C984nDGKJXWcolW0AhmH3w4aLVqQ8pdQTWJODLM/6nQttJ8dfuLFhWOomC8jMiGXZy5jDxO0AVAoZUjqawnWKeg69gQ7ZDyH3SzcDnEZwYy2iavCTyg0yxjdOw3j7coZvoifBDn/9W6VU29fI4bBuruWJnn/9TyUjt9xIKAv3TthLbJeyI4ez0fy6w2pCmv11xIyGmpqdB6N3M/5EnjxgJeYRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(4744005)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(6666004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qBT006r+AJSdu86MByQOHLmpw01eus5+FpYDpZNs5C14S8zVloI7piUMKV5e?=
 =?us-ascii?Q?B096X0+0WJQlrcd+f0Wv3E5T2yexrxHCKPNUtCJkAdZ9cKHVoPlngXnKkIPS?=
 =?us-ascii?Q?Qg8GDifRufOE6LnGTzAHYz2qSpIJOQ0aV/JHXE4z6sZQ95FlZbZ6EHvGBNXV?=
 =?us-ascii?Q?2UtuWN6ht9VK3MFNoKXg6GakswqNrGEcTGP8g0bcs1J/CRsCAGBi3XvM1Vuk?=
 =?us-ascii?Q?66x50EvoywssPujF6bQHx9BwaFWVjDh68Y0mC6Ed/MO99XmTEetJ5aF6QeDN?=
 =?us-ascii?Q?lBsL+xTrV8aGM28Omky0JT93H1zZFHVsAWCocs3mHukiPMEFCr8QtfA+YJhW?=
 =?us-ascii?Q?eGiQGJIL5o1xDoL/KotPCoA0mHnuPO8Oa1ziMtb0HAdG4r6ucUdn+X1ck+Yo?=
 =?us-ascii?Q?jHC4ixeRDIVr+8iBtXNASB2YO5MnNR4uULfho34S2h+TdIUac34CtIy0AmJp?=
 =?us-ascii?Q?OYMLTP6N7Z1FtE8Dy5T9Wv+syb4yK2tn2zQN9yGGyUSHJ+Pyp9L8hLNfmFUO?=
 =?us-ascii?Q?Sm1Cus7QtX/ud83OdeFXo60Q13z9RyDu+sastDNiDPgeeqFPY9kfbOnDhSLk?=
 =?us-ascii?Q?63+eTuHDm1Ajp6PzWO743hYrdRIERupS6T2AFjv2a96kaK1DDpel0rxXqYAX?=
 =?us-ascii?Q?BZkS/E+6RsYhr6T5v2sanuE5uQHFGPtFHsCw9+pcO+6oySUaswMHGn0VAsUk?=
 =?us-ascii?Q?gBxKHzC0H+keI5wUGkfe/CXv94rWZ3YzKmOW+gjUjhTAxi9JyDBVSEKKywxc?=
 =?us-ascii?Q?1NIjg3C4ILFjNk1OFACQ++mtYnywHsK2K6rpdONMljnfPeEPxCmToabJWc+n?=
 =?us-ascii?Q?u8C7IvfR+jXBlhnQmU4m7QvMEkjHdDGHh9Jo9ezsCvOUj9IzgO+njRZcD+AM?=
 =?us-ascii?Q?2JRAHktcatuhGDCAdSt/qBGXbod13rDNGJKEQ/BMIwKWALa1v5ZzdhaubdlC?=
 =?us-ascii?Q?XLTOUVllCoBS7ufq5SJpwMMvXw49EwPCa9g+5Br+GcmwFry23kiJcgkVuWGE?=
 =?us-ascii?Q?t6r74kIVTMfMjrfn7TB1vRZvAYN8kA5I90dBXy61qRas5rDsxBe0YYLen5qX?=
 =?us-ascii?Q?vQbIKxjzwIBtO6u+mEvZWVlx+AHiOeOClg++cwwsL2DeeS0hf2Qxr6DGRr0O?=
 =?us-ascii?Q?mdB1C/G01x88D7+7JWsq/B+jIBn/+HFH3JgrhF0Nc/uy4Rt2J1iKVA/69S61?=
 =?us-ascii?Q?oUigwd4vmWdo+ibMziySGTh7hAg94ylBSWDC8m86Wdpjr2WhcrPTDdAAZvzU?=
 =?us-ascii?Q?4gjs1yUD7p8vdg80GcDEheaHC3SJxd4OiB3REYG+EetdyVxY9S/HU2Uwu83K?=
 =?us-ascii?Q?gRNmz6stVxELOe3dplKA43ziWqjT+pakQdyOwbp5nVU5MbJu4VA89F8hEc2e?=
 =?us-ascii?Q?Vz2wsroja6lhCCb2coM2i9Aw2wUZYYMSQDLgT+4YRcO5XgzYoUvP2Eos8sb4?=
 =?us-ascii?Q?41gCO8a3mGSriFxPGEC75H0tn6R7ehc5qXYkG83tTNhuKegKh4nj5dwrcxBi?=
 =?us-ascii?Q?xE9aNI97LSckar1HERX40wMrgWaXL3a7f+H/Nl5RK218IYd5c9fPv29DeKGm?=
 =?us-ascii?Q?5baBb4P/RdE6eNq9FfWk3yO6BEHpkBBPLoEgoAdjjxvr2jk1PJD4VvUPeHMU?=
 =?us-ascii?Q?qbeNkMs7JFPJ27r4V8pHJeQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d5fc3c-b6e9-4426-d096-08d9ecb50205
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:21.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnRzg+MKjWDSS2EgaPUr1pt3IPHuGoawifSGCydr7N0YWSVmRBDQq7yRn/g7EM/OfrxHuk/1MB3Q0Pu/jM5wcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
index 471a26744a..167bc19775 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4379,13 +4379,13 @@ def printUsage(commands):
 
 
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
2.35.GIT

