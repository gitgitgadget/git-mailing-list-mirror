Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A43C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 15:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhLQPAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:00:16 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:5824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237716AbhLQPAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 10:00:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE64WjMDcIukOwt+ZuXtsAUyeG/bKG1LjwmgpVLnORzm6zua3LmcYsTr2Exfjqw1rQ7glLTTSm0Rd5oIKsS9ZB9gTghMuA2JR7SsL4INNeGLbXrxCJqmse5FYeVgL6ztHeqXgDk2bp3HBwkyEnsvmxmLYDTyomFPYPa7jzfhQLyQRDacrFG4JVD9OrPejg173xxkOlKZm2HXFfKJPVckI8upj14t2R+ZihTwpYzEnkd92Xhn01tt9X5jy62U+m32GIc/HPjiyKr6lRu8WGJI3r2FpGJy+qqmWndUKZ7rxNY0qp2vyEv1HcAxmQ8nmSQvlRryKQGIpxS1klHh+OZvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrJRBhyr3smdQ9I7WtaaJ6SzW0ORhl3PnIJiGFxI9Gk=;
 b=Z5Q5aOFBQgiHEPof1jJp6C4CA8MkCR+bTAtNTAFPbjtH6ybResx6nr0pVkoEUUHMQEv6M9W0Gs+rYIQuOw94JJzLdOztJojdswoSKI9Q6w06KllEvtoHPDcy5gJcBqzF4yevYGrlX3/HcO2M5r/IuigbRfoTBGdmhGo+6kt7P2H+TMXHYJw8J/7rlq7CcuPeZabB1mwkd6Mn8pOCCR3LSWThe7nlFuDt4lJ6UC6wUSdm8By3BG/pQG+t0GGRmSLCMPMMLOClxutCBkWUuvKVuBAgv9p8n3kY/txA7qjHyyrxIs8/EVbitkJ7etSCMyD5hqeZVq61h2/1D3rYqUcr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrJRBhyr3smdQ9I7WtaaJ6SzW0ORhl3PnIJiGFxI9Gk=;
 b=NFIWolx1Ek0cxm9s1G2iUr6D5IfakWsGz6rspuSt5aKec9dZoBbebppsHLHmEmFNA69QYxal3QOY4ncb7hWc/PY5XFL8rYp3KK4XmhuxYjaylzGZbz1oWnhInbPUggnj96jjYkyNjbHAc3H7Zq2+6TH6VnVeachqQCOgqPDLQ42N/jEFuyqF/8klaJU9b0TWQD77H62IKckj9AYYQuwvh0vRsIT7C3VRISJTgCAwE3VLv1RRswplvbGn4+dvOnP+iYqZtFBb2eYz1STpyDm6oCWFOzPIaV+ul0tZ0fwJhA4idQKx/EvdkEtQUTcK/VsHFmQVCgJJ4B+/yfWqnuMwBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Fri, 17 Dec
 2021 15:00:05 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 15:00:05 +0000
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
Subject: [PATCH 0/2] git-p4: improve formatting of numeric values
Date:   Fri, 17 Dec 2021 14:59:47 +0000
Message-Id: <20211217145949.2229886-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::27) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94e5f863-b885-41a6-253b-08d9c16de8ba
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02111AECC56E1E83778156BDC8789@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQSCuJ5AOYScET6VbIvIAdh+PbwYSzIyzyBVUXLZ/tMEKm3Z16oD7ra8q1dNJjdKVSz2qx8aywXIl5BPiA/hUz8Ccx0kQZmvkdX5odyhqXTKGDTUKdjuxv58aYdSaEr+vyewcEpugcKIz4BFGPdv4bIllsWEoMM03gjXNsq91vvMsU8rSy3nx7QjfykPUk9HzgzKECLO/paXsHgisJ4VdTJK50wAJnc+yXUEiZYnJZusjLzFWVHiM6N6p2PrS8rsTWK9n3mF+FixSrkKHXFS4DPsWcFuCN3xgtvENIi6qOuA9FluO4urO0kt7uoiOOdi13ho/WEx6JA4IeGcSHKjTAjpPxZsRfRR5a0iU6DwglpNf203bgOujwChjypsSIfstcTmU1PziXrP3flo+Z9JRnBlV3fPb/l7v2C3sYeQi4mzAIUQta1nNGYOfNaKTMpX/6RkmUSXdexbpkRGi9yOBEcRJLBcWJghfxGTZr0gxBHfICeMKccSXkRnSYAUgCKYX5NYTePValOtlrbWzS2ql9Ifb4dnXnnD9g310flptUQolqjUDWflfLI7ZhzzkPl1ygn4D+XbePpneu7HK6XG/3LuUbQXQPxXqbjqxeZyxyYhNSvYJ7wwiXqhXT4fApBhyJqtDMEKtBGCsSXpDSrgR6Gx+TwgiTCHbHSnUJeBNShFD4fk+HycEnseCJ9kfLBBD8D7bpouTfP6YEb0Q1V47g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(8936002)(107886003)(4326008)(54906003)(8676002)(4744005)(36756003)(2616005)(6512007)(5660300002)(83380400001)(186003)(6506007)(55236004)(86362001)(26005)(52116002)(66946007)(66556008)(2906002)(6666004)(66476007)(316002)(38100700002)(38350700002)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5E2qJkSnIdtvSvUw/DbqPYu2Gqn0je73vOXUB48JEhEvSCzWaepDqtc2wu2?=
 =?us-ascii?Q?RbXwTIDQrM9TOCmByxL8Y53vl+XQscoXL7JLQaG2ZagIWdxV1GwWHB3CR4Bt?=
 =?us-ascii?Q?+IybYvWgDhC/+yIL7CducmVAkHtw0lZ4RkKHu6KY71nx5ARHm14Gv7A06lJv?=
 =?us-ascii?Q?Y/Tn6t7wz4I5LjShBwYJFLkgkg1cwRomRjRpV1yMEx8JyJ/mngId6naViaQ6?=
 =?us-ascii?Q?r2P6AJxkCXqi8DO2r3mknpkGV9HEEWkniqnmGDvm4usjeVP+szfopQd9qNt0?=
 =?us-ascii?Q?ICkfvfOb77UC4fVMV/HQBJorIwFPQ1DRf1XvACx3f9WwOmYwQdT86JZgOCNw?=
 =?us-ascii?Q?6Pj+0Zb+DMp+DvyAGIXzpUS6HwycY11Qddkl6iGMG7z+4HPnEe9qHY8u3n5F?=
 =?us-ascii?Q?918H6d8xqOkYnGjyW1kwggSmp8L6KKTMtMD7y8XpFfI2c9IyiHwc86SpvWBz?=
 =?us-ascii?Q?vfjdMC7oS//bikxD18pND+Fnky3BzScLziiUSFzyjKd5ueBpxZ36s8qYuCWL?=
 =?us-ascii?Q?m6tCko3qMbATOhS5ZRGQEC3R/b4J57gSACYZNxoQ1IFg6TQe/N9RX/J0TeKZ?=
 =?us-ascii?Q?K4ZUVt9h7aNEsEpP6QsAejntlFc0HE4k7LmGHkR6NpQAiEFKXFM2k4bghQug?=
 =?us-ascii?Q?SpQ7r5MVLKONpWe0iLsl6LECqeGMH6u/1nEwO/UjluYt7otGnOPIPOPatLjR?=
 =?us-ascii?Q?pOz8vsaNOqCqOE2xcmXYtrMNaXJ2SrIySkp0Xn/Cv2V3reZwqDUv+Rlx2u4j?=
 =?us-ascii?Q?6dxL4JTeG9lJhy6MGJY8NN23eI7o1VSk6obG0zhM/h/YrfZ3xEYoa3secXwF?=
 =?us-ascii?Q?r4vzYNzR45lfWHi+xnFtNWJdF89rPHcNNsOpfStfZURxuxj2ur3QYZySkW1f?=
 =?us-ascii?Q?h1oE4Nsegdfgk994OyX/+9vyspLAXI6zXofo3TvLTabOqlRyG58F+axdMs7J?=
 =?us-ascii?Q?pU4rB7aIcm28PPCuJv/Ym9ag07u4PjekRi9avSC8hhsiGgDMmViCk12OS7Pe?=
 =?us-ascii?Q?4VsmSz7kB5LaYPe/6MnwaW98VV5qxydTLwjx0/7XonNLdVpubIUD11+qJSuT?=
 =?us-ascii?Q?z8Pyz4cS+DlnPWPSMD0rsjko0Z+yjx8s88/jKPWJ+vvJBoH5MUQnr9aMPHdE?=
 =?us-ascii?Q?CJxYqZ8+bk6z0RKsI4ISIR9r/fFjnU55/A8VpmLBouqRr7ZiJhn3koDocH8W?=
 =?us-ascii?Q?3g55rE8GfBXHbxmIwrm5YuhQNAwPqXS2Suw+npMWQeLhHw4AauwghhqFdqDr?=
 =?us-ascii?Q?CZzI0lpc65unvzUPXoOapkIY2vAD1kvN42vmfJEnzTJl9ixGm5Ou6ifGveL+?=
 =?us-ascii?Q?DEe7dtohp1BrNbjBY8MstfmOS/ii+tkaNGTTNWNMtkSShOvZMvZDzvah36IY?=
 =?us-ascii?Q?UlWo+pwPe68pjIZcNk/QZ0wtAz8wtJEfu6VuzoRT2qg5SZDmodeirdntkMUb?=
 =?us-ascii?Q?K2dUJZ/eEyiwpc9Z3DlfDgsQFGBtpGT8LX0rV5LkEi8QS8q3sx1JRJ8JNvax?=
 =?us-ascii?Q?WqKud2ns5TkbijUOP02pvYJGriq7fru9aSIhzLVw0zD/xxE01agVGry60bYh?=
 =?us-ascii?Q?FmHr4OxCy6rFqx2D1KSsUyhMeOzpokrnSEkjYE86QR1nRwVqPQp9wk4FgRuD?=
 =?us-ascii?Q?tukZ12B680yOn5gIY+77BXg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e5f863-b885-41a6-253b-08d9c16de8ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:00:05.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ2sWOjfbr8j7XWRl02HQsEDOGHoFu0hRs3QTm+eV0y7fxen20gxb+QEAH3He2nJ1PP8tLRwnEOg3jM3b27y9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set contains patches designed to improvement the way in which
the git-p4 script reports files sizes and percentage values in an effort
to improve the readability of the logged messages.

Joel Holdsworth (2):
  git-p4: print size values in appropriate units
  git-p4: show progress as an integer

 git-p4.py | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.34.1

