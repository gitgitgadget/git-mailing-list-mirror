Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D67AC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbiAFVlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:41:00 -0500
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:37473
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244184AbiAFVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:40:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekEYJcLVzQMFwrr/wXkeudLyBv2vAFWigQBHkEc5eSSFPUH366P4+tsHib+rGqYtEp/BHW49mmvEEJHuOp1d7HtsHujG2DlC+7qgb7lQVt5o/qO3E0V4dxGokWGCawChvh/DW7XeHFdA+UU0Wa1vNXqazaOFI+Vayf1TS/haYfEiQ9AMRz8dB2OiTfp3NG+sWildbzLdKW9glU8eGZcqISNDWL4Jr5ZuF/BGZZXHAtapRUJMfUqnTkQZGTrTynxG6kBV4t0OiO7jTlDPVoLrKB/kbosWM2kl+BAFDpOv4AKCuHXJdk6KDV2069dZ6hsHY1Kd2qphC+LDkHQym82Gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLRMYX2ht2F5Hv7IlehZBFjv0VYuDWT2+TMQLNyby1E=;
 b=mozOxDquYaUQToQDZV38OO2PbfjmgjOjxIxIrk1aHyEt6CxtAZuz89h9rLBJiMpaQ5JZdxZBp7XlJ++gS4mCBx79ozbxjCs0Y0WoFVp/HAo6MV8Tvp9E7cDnM6yutE8SByF9dFyHp4H4OhLo1K7v8s8BsMKF/xhJjeq5Hn8OFZE9n4ikMc6nHLRL+Wwm6Y0/GeSP6YzpmErv+5AiHggJjJ0k8SqFNE5OECFGHDEQ0FrC0NknZe/mNhgcVz/gNaDAdUysM0hyMHOhcNGXmAbD2PCHjlPNqjB5FadIu2hm33kruvEDpr7kkLxT5nJfTgNRInGrBpwQr+FqNn+qZqco+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLRMYX2ht2F5Hv7IlehZBFjv0VYuDWT2+TMQLNyby1E=;
 b=Ju4mCuk4jK4l7ocVwduwqY0svCZEk8vhJfKH4eJov9i7UD/nBIzTevCpiWT2OPtIIBcp5p2jfV60iGWeMKO7V0ILgzII39oiQJvn01OQDY2I50dW/OuhI/L3w1WohZtnT0wj1seOqNZ91XMH7vyMWxHjhBLv5EV6cfCnKgIkTG/0LUOfvfKdaqZrtXIT4eK8LwQdrF+be+iapNmRYF/SRsiaKAHAw6KZuLpGf/kR7MLUYbgpe/+5I95tjvup3febPtYTXxmiwaKKEchl9t/ix/CzUJfZXKZgM6gQ++kYAp2G+D8FOTaRq9euvizbUGTzeHpWNl2J1+ytijIKIFdtxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 6 Jan
 2022 21:40:57 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 21:40:57 +0000
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
Subject: [PATCH v2 0/3] git-p4: Rationalise command construction
Date:   Thu,  6 Jan 2022 21:40:32 +0000
Message-Id: <20220106214035.90725-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 306857f7-996f-46c5-b1f5-08d9d15d3972
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3854171F8A20B8A8B7AC8635C84C9@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eAn/eBZNILbiv/IRHeHSC4mDA0uY6cl1Kv+gmr2atmwwKjWGCysrz9K+emt9saxzR2Tm5/xnz2Yu73mJi31WM2YIiR+GGgYc2P98pgngXBTFzVTaCgUAi5DGM2ppV7aV4rU2u00YbWn3No7s3vCDZg+Lq1VW5T6RxsimNcFE63pfNaXj0Xc9yjyJ0HnwjYFFd9kBPPlSFYSKptjB9oeBglDt2cikwxiVnGtt3KW7TlCA+6Qc0rEQmarqKjtrnHT1zhX59myTipMGJjl2WAwF+otc3EAyDamp3X2XtTfUuDmduHiTGVLW+KpRQBWujajA6aeVCJIdiDcKKfjtsNjo5kCWr0ajcZ2bJDHJ01I1s7ogHzFAhqUyh/5Rfu4IC5g1g6gg3fyDujZbwl5+lAHryhUOCya3RVE/HxagI/hgE5bY1kYd0ju8HTseNwlFJXxhCUrnZ4EdNzDjPCcDzHmlqM0DvKsK9z0I0lH+GL/VF/iP44hNxcF/LvhLZeg86o0FrK52NLClVfCJ5E8CtvXbIWAi3ZDKV9gb0F9RWwybCo0PLvm8PpL9PZqPu/fZ2FJe6nI+WPn+6gcKfoEwF1XRYp3QFkofXHYUDT7KppE97hF6xcbCXSft4ZE89Qo1xROHm2++mRzbEArlXfKBS9TlIV8+ujWw2tOro78p6CNUPENt4lUy2stsu1rkZ7S4IQ696hqJhXGUSPucnkCDDaYJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(26005)(66556008)(66476007)(83380400001)(186003)(4326008)(38350700002)(8936002)(66946007)(8676002)(36756003)(2616005)(7416002)(54906003)(6512007)(6666004)(107886003)(52116002)(2906002)(4744005)(6486002)(316002)(5660300002)(6506007)(110136005)(1076003)(55236004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3UoPH+mirxtvjVk0K8QXb5Mafo5x7TB7gjBDDPAknKvhPqZnuatgxDr2YRi?=
 =?us-ascii?Q?QPYWor8EcJgKR4OAhEWZViBYUnHm7BBgI2TVl7lDZjGCYhZVm/9WObZVJiBT?=
 =?us-ascii?Q?0TFdrtQykKGRHbiO8tI0uNtpNwWs61hIIbfqXW/JPrgKTwgLXE/bEUHdpRHK?=
 =?us-ascii?Q?Xp7MmxgkR6z0yIUC2o1PxJj5nLDdQneTZfyGmeTU/TplLUtxOaCW8cVmezda?=
 =?us-ascii?Q?99OBcrwfcuxY3MtXcmpr0EekySKLN9NP3WuNvRNdHXJwQ21yJ73g/zenQ2Jo?=
 =?us-ascii?Q?6sTViu6L3KjGjtHbqyd31JpfREueTAZTdk0wyv/wgIQt4bgdVSMlWZL8HCJ0?=
 =?us-ascii?Q?t8EG0N9s3EiVfvRmzH+vP3h7piXMcbPVlV6WvicrWSWkGDA0WnnJq/VGi98Z?=
 =?us-ascii?Q?9ApcKQvk3S/JqUfIQ5I3Emaon3fFFgwrQQkujoWFHGRwZJD4BP/Hetvd7Weq?=
 =?us-ascii?Q?7wZFvlmBNClDTRPrddXgzdBekFry/K/M8KxDz554B8gnpoz3NJDaZEOT3Ci2?=
 =?us-ascii?Q?jXp0L5ZYvXGPNtIaGfIFexCc9/k4Bv0Nj5miwGviisE9K5+oaOsWcg17bk09?=
 =?us-ascii?Q?bN/ORuY+fhYKkPBlu82TY+awb7ZjvH6fZIl+sbZbI/N0xVX10hxOcC5diimQ?=
 =?us-ascii?Q?IxWS8Ki5IfssY+2R7ptkX/46PPzmBTNOrbonT/ZfRa8hLH47IZfY3mUQv6Ds?=
 =?us-ascii?Q?tSIGcboO5N5YBbqeXIsUrPRbeXdgYkFgj57wvB60pZCyeUSz/SSQivr3Kn7Q?=
 =?us-ascii?Q?vJwcxCt08H2j5e3/e0YmGauIF9ARR5Pi6tVNA3qi+F9APjXctOYdcvkSWQ2q?=
 =?us-ascii?Q?B/CAK+rCmHr8xN1R9fgb0MHjrh9HNWRgtjbTnXMOAqTq6OdD7q/7XzfLrz9H?=
 =?us-ascii?Q?jKQzvlWs5cpWcn/kBeG2ZK0DO84aHVrna5FkVU681nmuyfCT0En4qy9r1IXO?=
 =?us-ascii?Q?v64yoDgSBsU7CM5p2kyV60QPIfCeKP/FW+ImQorXZ/2PMdrjUTH8ylgYTYue?=
 =?us-ascii?Q?hYk1sxzZ4uCr5e68XlG+r6s6RK1MY/SCRdu98q2Ni8Mkc66j/w0i4rpxuVPk?=
 =?us-ascii?Q?M/vCBh6Nl7w+ozZxeXbWoiyVbFVwvsikXo9AzR/79RE85OCNKHU1b1x8Wvte?=
 =?us-ascii?Q?wV0f8AgCGrKsODwMuYab8yPJeOn4ov9JHNZmN6gObaZ++OtMT2goFP97gutI?=
 =?us-ascii?Q?t/ryfu0DG/IBPu7EicaSuYOw4xbRKQlAqdY6MpZr5oy3M95yuTjaG0c4PLjs?=
 =?us-ascii?Q?I9VkuPkGbKoshKyEeRO6Hti6hJ0bi0x+orFJT7NlBBU21F2DdGiLcTqqyZws?=
 =?us-ascii?Q?2OvVWpBBQ2XqXSTQXi87nQ6aMabiu2dZnXiFvQrLwPwKktrKzgigOD32F0UC?=
 =?us-ascii?Q?OIeCN3sq1dK4JXAK32SihRBDRiu/k/VXZnyne49HmrO3Top2n4TqoEabRAr8?=
 =?us-ascii?Q?P1ZZwsvQn3yjCadCjKen6cg6sf2/sUhfwS33g+SKLpAy3H5mkrEVaTy2KNY5?=
 =?us-ascii?Q?lI/f0fsqJX5SuTper8KajkIwlwgqZx50f7qQj2gP63TyoolUQu89ZrlA34Q1?=
 =?us-ascii?Q?/3K5tTQyJTtCZkayAce5FKIcvcVUdPi3kZMv2IsSajb/cTixubklavlCYHCd?=
 =?us-ascii?Q?QWKnrVpdh52Ca3Txfqbad6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306857f7-996f-46c5-b1f5-08d9d15d3972
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 21:40:57.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHyI8fB51L2BDtks+kZwkWV1GON6Lcza9TpT/xVgY+3PYw7kZyREI4OCagJGWDJCC2RN3aeCADaySz4D55fn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set removes the mixing of commands constructed using strings
with commands constructed using python lists. The goal being to simplify
the code by standardising on the usage of lists throughout the script.

It also attempts to make usage of shell execution clearer by changing
the code to require the caller to explicitly request execution-in-shell
if required.

With the script changed over to using lists every, there is also a patch
to improve the printing of log messages as command strings rather than
as stringified python lists

This version of the patch-set adds a missing signoff, and corrects a
typo in a commit message.

Joel Holdsworth (3):
  git-p4: don't select shell mode using the type of the command argument
  git-p4: pass command arguments as lists instead of using shell
  git-p4: don't print shell commands as python lists

 git-p4.py | 176 ++++++++++++++++++++++++------------------------------
 1 file changed, 79 insertions(+), 97 deletions(-)

-- 
2.34.1

