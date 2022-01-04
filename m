Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC29C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiADMnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:43:37 -0500
Received: from mail-sn1anam02on2060.outbound.protection.outlook.com ([40.107.96.60]:49798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231960AbiADMng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:43:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElscqjqzhJ/hoArYrmYKiDMA8pduMrLnAjVmf5kYB3AKFripTbZ1cN0TAA0XtmLHIBzyGacV582ZmH5bUJt7UcKiKNtr+x3DCJ01zkyAKMqnPZ9vYAU1tnNWWxrsZ+Q1aZz8jVljvE/FjSoC7MrO1M4/la4pgUNCf7BTWIYQsZTGG0ynMI78bZBm9pDZaOoxx3/a32wvRi6FC73aIvbVyY8to4GPgRtIenrC+yHI8JEZbK9wYn9tJ45ysjuWHuCY4EThpfmpQNroHYgWXd/WalDbnvzCin1SSJk7Pzhq9aX1sNUPFbDVJgo2BStOwTbnkMwjNPLCHmEQGFmkaK5Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsjxWH7iFWQs0LJjhQr7BnM27pPks8p2lRbpoE4BnwI=;
 b=Gqj5l1eLMayMMYO6LiG/Qsuio0oK/Si1AA3uszEB0UO5t3oG/IJZu3gftUa6RohyhkFKxWjJEnMvyqMawh/U3wVFy/ylIdwAutOZpkP1K/CmIQuo3PFU8RVKPGnEvDdskraL2f6/VoV0BFbHjSD0W4Pw+f/sxv95rWF2WI1XdEQHtYOAIufsl47IHF02h+lwUc8roKShxEEBDNM5FbtCCxdwkzTD1UKk79enKpC3iJngHcxFMTBPkYThrXDjZpohw65tWAqR6CdpOGw+4EuBmVXpK7/ncu2RCLyHLKiYjYaHYB+tWLsCZzFiZwywkjcVr+k/KpVCfL2lLWb/fGWmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsjxWH7iFWQs0LJjhQr7BnM27pPks8p2lRbpoE4BnwI=;
 b=dZd+veQ2NPARXQUZfAcpx0unxNnYBH1MrC+Fl2F3RvpMBlU7J0qFV0RMz3z2s31VFcz7N9M8OgEUnETWSmv6WoEf3vSsyLV+aL+bGxYIwb+7ovTzo9bDb1UOX04Oed2L9rOpGEaR/MRxOf5Zlpw3f5QxS3rJ/IhXVF0hocxFMZGXoYnw3/gKTeOKp2WqfWLIWDAzonp8+njfoel9N1PdI3KktObns4hCOe4ouKoOnTnsn+uVcgBYjAksvS1QGanTgKN6wjqDPiX2z8n6OlG8sG1mWGXx4aPQduOx8Yx+VXEnzUh628pL1euVG9CIp005SEYNHVzS+ujK5ObkbdrfVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 12:43:35 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:43:35 +0000
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
Subject: [PATCH v3 2/2] git-p4: show progress as an integer
Date:   Tue,  4 Jan 2022 12:43:07 +0000
Message-Id: <20220104124307.2524-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104124307.2524-1-jholdsworth@nvidia.com>
References: <20220104124307.2524-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::9) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e422f9d-14fe-4aa7-05d9-08d9cf7fd2a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43443EE0EF5A8FAFBF8DA206C84A9@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cecmJR5rcfPiasmsILBH5FLNFPXphwparxolJh8th3s7Pg/LoKZypRb82YjZPi089bdH/ehfGMcmUEM1RFaJvLVSRNiSClrbU6/BmX2jmFLu0OxFOL03x0v1cT/out9UlMpakT2ebwaAo4U3Mrnhrfo4Oimb/oDcyt23NedGR00f6JxNWChF46Fefdp18rBozPM2A1bCFjcMVHBw+NDKbuOFQjQa5Dl6IFvA3/wdD/cVai/nBTdJVdKUonedZ0mAkPxkiys5Lcl9BNUrgqsfwUTVb5Z/yq9XMbMOtfwcxGnqZt5g1nCoxsYji9ozgGMyH6rMxJWCzBxt9eMgEdQizaRshgQ2BKNgoz3RKuSsa8C7Y4/W29p9fmbtOHpm4vhh/brQkVjiK7hFYZ1fu9C803mB5hVz0Kph60vtQDrBx3v0ctbRQr4FINhtegfoZlhhlINiS6bgzoUwX6MfadiLJ+ERmPJAmsKipnr2nAVK/c6hTnMv+lpztszLwxiV5WJeytxlrZvuycanTXCeJQ6UlX6y69b8OYzTUC/+io9OtzyaEijI8KlXtbBZIrtQnRPBlYzm46nCsdb+MEBqu9YQdbFeufdHyrlvoxNkrKztScClLNRnum0HpiHraLlx+ELn1tzcYz/94fk1bt/L7jvv4JZL1GecrUgLIyP1DgnwsJwd0Txk9IyV1GFZhldFAy/etsNlRQC80gXL7dV66h9WAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(66476007)(110136005)(36756003)(508600001)(2616005)(8936002)(8676002)(66946007)(66556008)(7416002)(2906002)(38100700002)(83380400001)(6486002)(316002)(186003)(55236004)(52116002)(6666004)(6506007)(6512007)(5660300002)(38350700002)(4326008)(86362001)(54906003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1jfJv5oCEW2IlDr6gskr7bvezF6d0OCsYje4ri5cN29jv3dteas+RGv0ywF?=
 =?us-ascii?Q?shvJZwas2/mLLSRnMOj0wRhlZWIpVLa5Qfktu0frKHoXSnYYBHtrtsonacbz?=
 =?us-ascii?Q?UUJ+yVQaYrRKw2mQsjwXH/FpbxHMp67+Zrg1fNa3zL3RrhzoQ/wyR/e+Ip50?=
 =?us-ascii?Q?bEHCgijMKeHG0Uw3pI0I4vIYJXFblxPpzp+JJx34xu2D/BeN4dLbxuE1hnpe?=
 =?us-ascii?Q?cJeriRFKogdEhhT1nvT1v2GHBu9mKNRkvUZFup2bbNyazM3+tTXrvu76PZDg?=
 =?us-ascii?Q?+2hkVhnuhimrQeaATVaQu0x/GRbXUoKm02yVtWDikSdaZl4f3h6hQNb7982l?=
 =?us-ascii?Q?X/xlRjaVxJKEy4oKlHV661fnfovDL8GNvu8+qRm9x3EBODXiF0qBVvMQm1YZ?=
 =?us-ascii?Q?KxqQU1ZyHREgq4fKBtBekDHVsGkYZHEO6tk2ULssRZxO8+3uCwFAaAiWESZ1?=
 =?us-ascii?Q?KcGVr6Rtuw5ydRsBPFztk9fmGXBt6FzmokRdCcNHIegqPeYQlP10uW66XjwG?=
 =?us-ascii?Q?K/ihHCPurvm2yEy0LDoRbiO2eeGaRoYKSo9CI+uoTidLs1DR9TCVUdGbXzsd?=
 =?us-ascii?Q?c83dN0BJ8jPYnqLEQxUPPB1yXm9kFdH4PkZmTfTCZn8hj6Fkh576qS2q4Um2?=
 =?us-ascii?Q?tIrUmJh+2SonmUaOBpHowJCyofAXgnFRBUnfRdA+n33aG5BHMLP0+gpmy3la?=
 =?us-ascii?Q?CL1G0SJqrSN0rw9PEm3AEYsOF5rKRhJUD/9teZEXRB12QsMMwyLQVvTPFsjF?=
 =?us-ascii?Q?q9inw/ep+HFvmhai+lLwsEfDs9sw4W/QGC5jCpIj4kGQj64jjaFB9uHMNqlE?=
 =?us-ascii?Q?nqPNqNL7RLH5I5XSV1cbiAyCYn3I1TvPKM9YrdpcEmUM1MPm4JQadWWlUT4i?=
 =?us-ascii?Q?/wHsVTWbfnNBLQFuJkkTIXhKTTJwcuBw1Odrb1v3ahRglOPYJA5x8QTgBqGd?=
 =?us-ascii?Q?T/MjGAeLO/MoBi0nUW1VbzOUqcUnVbS4mrgXLeqjS/1EEjZfY+z32ccudiZR?=
 =?us-ascii?Q?D3n34WnqnxcFDHPoHp4lcBKXW6F1yGO3qv02bZflUAK/U0wiY1YXyKYYHlM8?=
 =?us-ascii?Q?MI8VTrq+w05OeUFP7gWOBkiFMcPvwabD7pEYTkUzJ7GI7S+v6tk9BmmsePd/?=
 =?us-ascii?Q?KrEoKgnaj2LsPe877Mwu6+bZfUovFzbBmYwf9Eek1xA9Si8MyP4ZO2/Ia5eZ?=
 =?us-ascii?Q?SBRCc+AGmjqd/14ZHOk9wCVlYnzti9Ct2ugP2DhjK4I0E88+El0HMfo7/jAd?=
 =?us-ascii?Q?gPqNIbyM5jFJJcgwkwjWFz9HWegx0laF7p0WbAFtbr84XrUAOGi7moH8BxYg?=
 =?us-ascii?Q?5TzvN8VWyrMhWUR2HcAweL/sqEhPvyjcQxZ2Xc9iNHdxMuV2E2cLCVreQ5Y7?=
 =?us-ascii?Q?Z/gXFfMn+s3hvUrog+37ZGCtODdG7pE0SZMNv6Z69TZGfBHxhP4HHGYkDyOA?=
 =?us-ascii?Q?GY0qfsrBM+MtdMBwtkxtUwev3wvZnIP8yZoGA+seTxjRDOukrabyX+0fzwHG?=
 =?us-ascii?Q?tQ1GZxG/mTiCmuXoCwMcV7xYprwUfgWuxrQhuy5CLcVu95SERAhGeyAd8F56?=
 =?us-ascii?Q?OZ4zZn4ADMhqygUe1mLQpRRNI/Nr+zKRAXWPyc/vX6qInhVNsjl42OM2Kxwi?=
 =?us-ascii?Q?dkNlVNH23Hig/FEvKsN8/3I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e422f9d-14fe-4aa7-05d9-08d9cf7fd2a6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:43:35.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SHVfxriv170XwskyHt3mw7mxUerirn+eldaLAUoXbKkr7QXEOcz8gEJnKiNJbGvbGifv+VaaAJmg12mL9XBVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Acked-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 74834736fa..a625077b83 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3637,7 +3637,8 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)
 
             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision %s (%d%%)" % (
+                    change, (cnt * 100) // len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
 
-- 
2.34.1

