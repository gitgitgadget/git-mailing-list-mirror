Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0642C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiADMnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:43:35 -0500
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:60448
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231960AbiADMnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:43:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1BDvMmhI6ypOdywRU5lHQSBSMLLU4FSvg3s73HdzrTFzSrCLpw8urHiscpYkVo1rdL1nGwg49ANdFe9o4bOFU7pbnSMpM/2xAAP+3zoKjWE5nBX8IonqlB9ABOGaUx5O5V5KIvYm+e851NLwZD/IRH4tzYCY9PTOJIK/LtDzxYJKSZzQ+GqfPgILSd5dWf8gZcECBa6nvlV6JDZKQmxl0FI3A9u3JkhdymTaBKzMUCaAATujoXdBinq5JYINRz3hHyS94RJ0GbtFkw+5Oc3vi/Zdr625U00jE4uCYa8PnakrF8byAshV5eiiOaCV8fXSs0gq/YS6lGNnLfMUlLKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtP/dQzJbTjZXDdrovVLqRwvbTzR/cd1L7a/g4mW4Tw=;
 b=Q40BKscsc8iJMQzdXcNsExClALs9kRPNCQjdQXtClBOx0ny9otKLahwu7VEAihLEOu/J7AefmsMS7cQlCxOv7LNSCvKHmlHqdaj1K4iwzow+BIx22JpglbbDz7y10b7yHia3KMQXaE7cVlarlrOsdYUhnTXiLsosWLt2r5yr+XSMBt6ivjTVPcZQPTl6laAtb5sdvqgfkm6yu5NeWupfSTyZSSDJ+YedSgp7hFnIiE28DL9AMl2gldyZ7NYN+aqbFMWZcOW5gyiSSUHfi0j5PlJlndqJEsAP+ype1NgluTNjslvBLp6uZ/3pViFregu5IcD5b9XMolbpKJDgZF8YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtP/dQzJbTjZXDdrovVLqRwvbTzR/cd1L7a/g4mW4Tw=;
 b=GB1xi+j+sNsPkN/nc5D7faOABSnN5ecy1jhKpBsPEGoGT55wb/rLzWahjka0h0qQ94iJvLMH4mfgIuCNwQdFNlTE7Ln3YVjtMKnYy8MQRu1fvek4BUyW5bOfL2rFTwzBLEJYVbcX7SYp3J07Kt5vCU7inJeEJSriWubDymJh35JHwBqx9Syai4gl4oZ492O7DRVxZXWssx5AT/iHhncFfegScHPV8AitC2Eih9S8vu2ni+3aRhscME3LFh1tv4B92d9bP3aX8TjaRbpzvOdeKoe4ptQTdXIe2HA56HWMiYr2f81JH2vhhkno3rNNszFVnQUbieHsCkRuaZFOUCapZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 12:43:31 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:43:31 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 0/2] git-p4: improve formatting of numeric values
Date:   Tue,  4 Jan 2022 12:43:05 +0000
Message-Id: <20220104124307.2524-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::9) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9c95ba-665b-41e0-e4ba-08d9cf7fd067
X-MS-TrafficTypeDiagnostic: BL0PR12MB2402:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2402FC8DD1A0D8F89435DA8CC84A9@BL0PR12MB2402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXqvPr5P81bmj3BiMDknXfA3cFcSwSB5d8UCHN4yw8VchDcPvD0BBeiX6gUzdUOZS620osHGI5G1rXMcFVFLoKmrfsCNg9JsQAznEMv9EuLMqJvlCyLOC0lybfC40Mexs440MiNBSVENFIGJ8nyYeSNwWgsSBJmJN5ixqhCCEE+DrOjnMEGw/wLyZ6LsERUnPHQiYHlbAH5PvhxREgaInb82bfYuDAjRFSX9ZGbSZtPA6VliIl5iPZSrFmwKKfTk55LLGdC0kKQcQu84Sh+B8t/Ru+Biyhej5gy+OpNx/s7eHjxOIt/PV47VWYia6q9dR8otzPcvQA6nBXh4WsCE1R++qNdC0LwWbPhKO/xwMt5+n0ZeknsE1CCtCH/+YTHcBdLD/RR8Z9//Gj+tuW/baVtH6NusJd7HDxTQ90GKEQKl5RUnQ+oJDEJcXs71kTzOY/0AzV+Cus4B+HHQBxFNipEcOqTtFcTIhFOKd6TqXAIcI25epA1IjRNre4USFSeuy9ELVsEaHgYjQhoAHQ0Disx3au5hDH1mZ4UaW0bvpLysgRXdajtyllo5quvGrTe5JUuhA0oXUdNG8SFOi0oNI6KnINML0stjKrAHAKprr2dm21P6KGpxS+lmKH1ufOEUPvWzVFJD/IksgBtlTYQcl2Is+GLTygnDX+zn6Ix9vYOkX6BY44RHJPbtmwXrJc/ytIlspMeDDV9dCjGfhy96KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(107886003)(4744005)(2906002)(8676002)(2616005)(66476007)(66556008)(66946007)(110136005)(7416002)(36756003)(26005)(316002)(52116002)(186003)(86362001)(6666004)(55236004)(83380400001)(5660300002)(4326008)(6512007)(6506007)(38100700002)(54906003)(508600001)(6486002)(38350700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pslENt1BW5f7TtkWU1HL6jHmw30+VDWmfC4uSr11njJqnlaihECis+Nrfbkj?=
 =?us-ascii?Q?Y1akgKeR0xXih8WGYdR0fXickABdiC0gNXzAAz0DPS44X/CWKlmpWqgPEegl?=
 =?us-ascii?Q?ywuH/urTtWdaUjFOrITm3ycGo8alBP8/Ae//OROQPHRjrKAueaPj+nXySU27?=
 =?us-ascii?Q?GIe7n9CE8NpCZgSzrolgaoHxSBbmPV4OFISvhbkLacxJuwY7IUeB8C406Vg4?=
 =?us-ascii?Q?Npcke9iqpK1MbPqT8LWwJoccx7OhaB0FumIHt1NE/oYEEWwb84mg7g5wq98p?=
 =?us-ascii?Q?HJFhxOsxTeNV42MpSFZl82YnqOeRWzqJdk5j7c/d/vh/VFm/OAzUMTuCskkn?=
 =?us-ascii?Q?4SqmjWyIRYFu46O+Ln9nV6YZJB+h8LM82zyvpmfbT2t6cD83GCMKcUsfHagZ?=
 =?us-ascii?Q?yhRCOeb+gtUO/LVyRve84AUPC8LaqyQLKvT1jhmqjG/5FmMd4jGYJfus9gmc?=
 =?us-ascii?Q?tB+Y+fpM8f6PoSr1gOCyKSjW0iXmA0zF+UMWQrNzESL85Avv5GApHvL6auP7?=
 =?us-ascii?Q?gcMu4XBlAEHCn9/EwvD6p0NsSvUIGbWy9ibIOPFL8CsnL175KSVA2lcyc4lL?=
 =?us-ascii?Q?g+oDUUHOHHHsupOSwvu5q6al4xpPX3EHI8XtNPB3XWAOcZzYZ/SW85gYQ6h3?=
 =?us-ascii?Q?2MuMrZ9zmIZjQS4+ysIkfWp/ZtmTqkfD0Wp9ubvteSEpc3dnob+6ZOdlJfnL?=
 =?us-ascii?Q?sLA4ebpQ1wY6PRlLbUniz9VmICCXwIP4dYbtD2ZrQJ/oWsgIbweboVgmhsR9?=
 =?us-ascii?Q?YNxEkwxJYArM8nQaPMITGFGs/ngvM4PSeXulo6Vg1o9S8xRhfMtyh6iZiuHv?=
 =?us-ascii?Q?6lhUoriZh+eUHfMgQUg+GKxLOBuL1AD7c+o4TrxAd6Ns7j+jx2XgnRrxosWG?=
 =?us-ascii?Q?jjku0PxMtXPAHoYPZVHLCH+pbjoUYwaG0k/2lPUfVmnoC5egSvGPZR6GF6gW?=
 =?us-ascii?Q?i0ltegLFUSJeDpwCgy0iC/zKa5SlInQo5matfrtNII297/gUFG7SEHHxFHRZ?=
 =?us-ascii?Q?6qSj+jQlHhbodcexGqMCFI1oBVhKQ7PnmChZbaowtBEsWP06wzovSLiHqigv?=
 =?us-ascii?Q?vjwAZHv2nZECM3QEeslsB1FIja3HWQNjewIOJgCJFCx4bSGBf93IZdhgjwFM?=
 =?us-ascii?Q?EnixwvyZ2TITz7T44ohmdDNdnTQ072hOvDuisidrat872KFlusH2xRj7Fviz?=
 =?us-ascii?Q?2KoQHOvyyO3SWJyomFbmh96HWy9tS4dRYOVYwqjudtjYWeXJCm5Jac6MvNqb?=
 =?us-ascii?Q?CvxDpVqeEm7+jIMDulE7nwSOyyM/26NKfeH0mbbTV2mpIqe10/u3j9n2nuzf?=
 =?us-ascii?Q?4qXn5XQ3wLdgOkX8sLa4Uhp0UTlHmTT9tYWmNhV/vu5XksRvUzp0JhRV5Lh2?=
 =?us-ascii?Q?25CasqROPzyktlA2bWRM3Ej7AV4cLdpKd+jq31aJCYZBqDZK/vexn7+OJIcp?=
 =?us-ascii?Q?EMDRA24TGpPXmQFuUw45tzXDpsxZ22vq6VbQzE5MZtWmdY7I7qyfSS+B5zb1?=
 =?us-ascii?Q?6hgE655XDVcOWeLpb0euomVaypYEv8y8X0TIDj9GKKYEFOc1LrW5Vzgd8U+c?=
 =?us-ascii?Q?gvGi0Vo5c03b8XI+zMYOmeXguYJk1ayriliYO0klgF9p/Xgk1gPk1BjVmJul?=
 =?us-ascii?Q?dcgvxBffCuG021B57yAObUM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9c95ba-665b-41e0-e4ba-08d9cf7fd067
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:43:31.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSiGKaXHWE+UVs5yzPRK35/oI+jmHFrQJM31fWDaJShik7+vBbAFPuszAJq0ckLJM7oLGSlyMp+gjBFFTsHidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set contains patches designed to improve the way in which the git-p4
script reports files sizes and percentage values in an effort to improve the
readability of the logged messages.

This third version of the patch-set adds an ack from Luke Diamand to
patch 2/2.

Joel Holdsworth (2):
  git-p4: print size values in appropriate units
  git-p4: show progress as an integer

 git-p4.py | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1

