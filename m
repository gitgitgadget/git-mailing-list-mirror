Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC5C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhLMWzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:55:11 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:28160
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244088AbhLMWzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:55:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwNCD5XJMqQ8+7M89MOUu/aNFmWKbSOwBdLGHeV+vTOnYEma8Vqjf8b/gd+kFKCY3KjkjZE/YEtvH+xOvfXSM1RcU1S0nMtAARHNCGCiXqOm759rPUK1MSIIscDWq/gc942un4UTMV0O1mKul2MdbpF6+H5Q9AsMz+F8MoBjgpm3veuBI7OZC1Qo/mc2/XuF6GS+2GKj/YvGvAxwRtgVB//Rb560aH64JDM5nSw7BBWGmhG47/s1+p4Uy3TG6Vxp3T51R1e6RrD/bn4qk5h+br0T4YbD5w7Gudfw+kGbTI+YGSOhulV+Dhs0JUakmsylqyflV9UM7f5yjl4Xxr1sCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbnSzbAl7AU5GNh/c8bkQsK/TyLxnX/XmPiLnbwciN0=;
 b=oNOzcpQ14UTBz6IWX7vdwdjoLXyUNgI52URVhBc/qNekvHGjT7MGJC+A4NpNErCrPfYbffPH/OdnRSy+LbdmFCe4SjG1BHIzqQq4EuxtSXYizF/+Xu9mMKRPh0r7Ox4j+HI3l2LYyc7/YaPuTsQXldqGVnFNg2uZFaedwV9OMZoFkQtFJfaOmJx+6DpjxH8NCZeCONt5hb2+MhvO2RSyxlb6rbVglKfAoFcUf73znXxLP8HBOEB835nNkFyLnAHkV49krZ9aIqsbGz1HxqXiplo3yYPBo0KKzDCJBOeR8ZHgYiiNu+Tiyoek1BcDNUmjgQQrQ4MylF9TypCYCyWNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbnSzbAl7AU5GNh/c8bkQsK/TyLxnX/XmPiLnbwciN0=;
 b=RShLZyJ63X1hM9kdD2xg7S+YN7EpdhQByBu32xprG1ZmzwEKfb6Bc+Ooh+YToBA0eDJlKncIIhJ6GbHEwgGS+n/XfXyGf8/gtSp8VEXNEBiA0TTIlYG7wwsHluWTV/lz8htKGTWMkAhR395Dm9n5/IkUJkkDUtsMj/PcNNglFYLN87itzX34rV5yedqu+sdQrtP+3UirBoM8OIeZYLmy65E42Dn+cV2NRM1Vlp2V91sLnEut5x72itz+S3hu9NO23ZGi4PdD6M6vXHJy+NJz7YRtu9oNDGolBJgvbs7j6jkl9CM29+7Bb6EqeI6qzmGs07OMdqbhf60KnB5WUPc/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:55:01 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:55:01 +0000
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
Subject: [PATCH 0/4] git-p4: fix RCS keyword processing encoding errors
Date:   Mon, 13 Dec 2021 22:54:37 +0000
Message-Id: <20211213225441.1865782-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649b68bd-6cc3-4530-b151-08d9be8b9815
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1377493A78FC09CEC877CFE8C8749@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2Cc9f2pGVBcD4JB757xl4NRMyDNdUn5PAsO6klp4HC4e7cM+ZL8GxsMtpVHX6gGzPTrRV8WZAIgSFYO4/Z2vXMG3C1t0olbZJeSRGFqFMDacM17rBRrxpGt+o0d0FKmUbBAohcizzY/LV8HGMHjAEAkQUQkSgLIXgh33JAJZ7ROagaEJh1DKd48ESAz4kzKxSZuLFkmiujLpfuAZlP5DC22e9jHF5IOTU4oueP0sqKNomozU2Ka21L6Sury8n/GewsesI6OTRCoZ6My268iVd0szYicMYZbyAvy2xX4sfEX2Q4KOt6F1vA/TcQUqSxWIVlv1qVEAK6Zlh5quJ6N2a22wdqQc+TSKnbVqpIaOTM81ZZXvXckC+wd+rZHkIVGaIB1TgWYaQoF6h8qVSNsevT0C61/BJhpsV/F493+WPfNI94P88St4erRI/TFRE1oVwOB+7IYCtR1oUVmC7zz/AzwXIo+QFMIKZnbHB7DoVZ8pB1/e/63wr0Jno4fV3pRW0cT3jzFKr4UUZpg1XH1tIyyFw62MRRxIRkJcHSGvo55RtPvd7aVj1JvH6ZPub2Qo4vJ9FIkztWd4KflSlwuxVk8r0UD0Y1TGf6/1fnEGbah9DTe2QqBywDPZYh3dKzITY/bqdsc2YV1oL50ik1pab4z5WlAjm0omY611Rjb8pwIl7CLupUxpZ8NI/s7C5Ap7vF/xZdjq0NeLIvNqIBZ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(6486002)(2906002)(54906003)(8676002)(8936002)(6666004)(66476007)(1076003)(6512007)(316002)(66556008)(38350700002)(66946007)(107886003)(36756003)(4744005)(4326008)(38100700002)(86362001)(6916009)(52116002)(83380400001)(55236004)(6506007)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gmzyVha/vtd868Fj0ikj8Wem6TesUpimSdM4RFXvrfuX/TGPrdj+IzXNso8X?=
 =?us-ascii?Q?WeFuVkd30kP4hBEeRSWmNXLCFMMnZT/7Tw15UmZvfaSW3fEo6KskwZay7y8f?=
 =?us-ascii?Q?TRjn55SI53BB3K+AKrqODyqdAPkLJEkSEXBIBHTicgh0zIYtBJQsCgTWk2+J?=
 =?us-ascii?Q?Fsw2R6Y0DGOldyTtRcgHP6OhaGxI7H03dgHwV95vPNmBgMbGOTHz4lAxR3rC?=
 =?us-ascii?Q?GfEx267j65+t/PJjFR3Gm25tLH693dcANpf0YmUzvDwenSKx89t/BTARmOZ0?=
 =?us-ascii?Q?9uKtz8iG7/RdAdQ+Sm+j4ckrtTZcx9vyJ7GYY5KvSEzcZKwm1wEAl+ac/r+b?=
 =?us-ascii?Q?0pcQ+h9i9wxBtuUIMkKy/epbAXX2PDPTp9bBf8v3r9cK9fkP0I7s6hdy88s4?=
 =?us-ascii?Q?ApMox10vkWTiuRGxz7f4VhARZt7esk/8MuDjKG7AEvn0hqth/0J+TAg9K0Z0?=
 =?us-ascii?Q?Ej9Pe85lw+L1JOEPLpspZl1JTdQiRzgtqmNp8/CWp6FUXeDpQ/XSdKQ67Zlf?=
 =?us-ascii?Q?/ztKWzlKHWWTyhpfg8yKv3tYQ/Le0n39+XYGv13Hh6gbqqViafYHQtbIt6Nz?=
 =?us-ascii?Q?HzSBCX0vNk5NZUkqgL/ddz0+Y+nkUlPM/tT/AzrKeeAz1nDuDYU/9f4kyH7C?=
 =?us-ascii?Q?GIgZjpwZ4uATIMw6wDGarmmhC8DSX7aT2QAl5w7nrIO7s60hYMxR2U6h3/Nx?=
 =?us-ascii?Q?Q63EpFg7mktIF0G9HuQ0T0B99AiKbin520JO7j2QReeE24QJHTfgkFleyCMw?=
 =?us-ascii?Q?Yj6qKOuyuc0tVXHG0JG5caxMbZ0YultbfFnWhD/I74sdSPEJn4V/cR2nRp3I?=
 =?us-ascii?Q?6Ksvzw0c8yEvLbXtOf9Sm6i2W3xeWpL5F8ICTbERpIqqj+EO78OPvfHbxh5b?=
 =?us-ascii?Q?sOpkjQ/K31zuY+5QdQoOXsAVeegmokiZowT78Sv5ccLOrb/21SS5H6d+Edhp?=
 =?us-ascii?Q?AqyTS2q0SxfEwkCxd8FC8Pa/rfWAlKQaljpyiD46kw/UeEfYyz/w8XhMFYgb?=
 =?us-ascii?Q?I+RnNLvbpW4JharYfKmTGlQAnr5sE1coXMC4QG4COcS8S99stFVvMXHHauhC?=
 =?us-ascii?Q?Utdf2Zro3FPW2x/q071qhwz1hKqtkOHmLKzVVwRerGM0bmhqwWNl+klBTMee?=
 =?us-ascii?Q?KDEDRYHDcJbOuQhbl8g9HZHjhEA6HKEdLwzrFrpEJTx8Jk+L29aAmXsgWxCr?=
 =?us-ascii?Q?SEYIRh1FJVa3wrxh5xlnvPYRE345ysWHKYWVMxiO5M3nOYkviDbITrnS3+O2?=
 =?us-ascii?Q?/lDz+UNmtwNspMkiZ3erfa9+vhyAdKmT7vQ1tPF3Xlvlh9jLehVt4Js252EU?=
 =?us-ascii?Q?+q8vW8izYyrYviEJw4t9CXjz3LzxfZEg8SUtjraqRHSXwLvwfjGUeO2V1QHs?=
 =?us-ascii?Q?pYxetAWNPQLJ0qCpasxNg7x44zuj3/E8Kef0sxM4G9JHZ5jT8/7GqPZ/M4gH?=
 =?us-ascii?Q?tCNJjTZyt5t5luqcYohuVJt2aen0xrwTS68Pg1BySvA5l4gU5Kn9LC3Plid2?=
 =?us-ascii?Q?cwbj+RE0jH9qYAeS3GAmXvaCaVdrPQqWFsVRgrJgXRmc/UrNYn6GTfv6DPiJ?=
 =?us-ascii?Q?M4fZqGoE9sIdv0gtpDZ1Fga8ezbFekMPWM1hNIDbJxFE2Se0iA2y16h/k+Y/?=
 =?us-ascii?Q?Xc0pfX9CSC0ub4SuhWFnGws=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649b68bd-6cc3-4530-b151-08d9be8b9815
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:55:01.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdsCkp7+mhEeKtbVDMpmVJUckLcWOZseQTmNEG0QdYJbmO7F9Q9ZBQzTOSy0B2plpCzSJWhL8d71p4+XxLes1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set fixes a family of issues with git-p4's handling of
incoming text data that contains RCS keywords, when those files contain
bytes which are invalid UTF-8 codes.

Among the patches is a fix for the issue, as well as some peripheral
tidy-ups and improvements to the existing code.

This patch-set is compatible and has been tested with both Python 2 and
3, and includes a test.

Joel Holdsworth (4):
  git-p4: use with statements to close files after use in
    patchRCSKeywords
  git-p4: pre-compile RCS keyword regexes
  git-p4: add raw option to read_pipelines
  git-p4: resolve RCS keywords in binary

 git-p4.py             | 66 ++++++++++++++++++-------------------------
 t/t9810-git-p4-rcs.sh | 15 ++++++++++
 2 files changed, 42 insertions(+), 39 deletions(-)

-- 
2.33.0

