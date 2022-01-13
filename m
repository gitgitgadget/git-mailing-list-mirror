Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68627C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiAMNtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:49:22 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:50574
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235569AbiAMNtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:49:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeTzIBJsggPF2UWpUMHucQ/5bXpuLwa9RILFv3w/+0MQ2TLQt4An/AagtGOlcx2dqpAWBBhcv4jtdfGCCTirYrNQxR/xKufCnyrRQeqVjfMkYH4kbz54PoTMIZTpKKRi4+OcvLg7dlfod3NqllZ4uZ9XwLAOBFdd6gMv5qE/N9uCA7/YiqP9zdnZlp7BGHOS19Y76Tr1ZIY0EISsgDmRAStPa2YKxiTi0YeOcDbTOLQ493Qxl++mpO3I9M7hD4dgoZOLm3VoTeCUO7P7cN3ZW2NXTpcsWNRWTREqKNGmH9A0EvJCggP3FJgbzZaG99g7946M1imjxmIoQcEu+OFwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWf9syPiQrFVyh6oMHSBVvgeoY28SQvNw432taoXJrA=;
 b=WWFADA14IEHxwdlqkSnM7Ealt2Pe5N0GEnEJLBchp/iqMFwhzUCwK3HFEnR/LGcvHjIyCj1bkKyq5Ql7PMwJNYqHFospSHaHIG6/XDMeBAaxoqx/xNHHCPMIbCUXQvQivThDdh8sCHmdY2RU7GecfYMXm16F9Xqq3mw5mgB563gN7JdyDovr/PliaaTwkRS+mNav3389u8FMQdcXcGa2mJwHGJkHjEbAiD9KilP7X3w36cwuyz1riCmuIYDq1rNgz/uFJPbUNqitgMs21vkWi7BJsLdYjyGktFL7oPt/lglpFiAyixLLqxrU7VawVek3aknJgmlP2802ZbR2zGXf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWf9syPiQrFVyh6oMHSBVvgeoY28SQvNw432taoXJrA=;
 b=Uht5XHRo3m59lUjfr3SbIwvxbGxuI9+N4+cdvE0XD5BHyZK7+Iwiymd/gMHWtODCBrtuiAKBDuIJbfJhX+PJPYupMjZDsB7hCm4Z2GoO8gjwiQ8lfS1uteQGzKN7x7RP9aScQvBM7q46tMqQ9imZqM83131Kn3GrxCIjsOfYTaMWzYtCXepApqWk4xqxZAl7EPY1gV/RM6s3ZBly+5lBnwEtkTLqxbwQoHMVD4WHasiqJFy5sugCYsMaUBshpTXtcEM6tqQUeAhC3ahB5N8uAx/H8P+Kz4s4j8hdoG40WAyifJusbAdI69fjNnn3fG/iYU/BQM4Pe2twFA42ezqRSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:34 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:34 +0000
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
Subject: [PATCH v2 19/21] git-p4: only seperate code blocks by a single empty line
Date:   Thu, 13 Jan 2022 13:47:26 +0000
Message-Id: <20220113134728.23192-20-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 121cba3a-4554-4ca6-80c6-08d9d69b6478
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39441D9C62D5B0CE05123F6BC8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIz0sATvknJ8YZSel2XNYxiAGjOmk3+Ne8Qs5bKFMpxwwJswyZNDMyC+DOTLGsrYLAErAQcQdrIeniVEsqWX/m3eThSPRsyy1lJTLELdAxTA4rLdbH2LusCPCG6qwY+XTFnLr0J541+DrHqM2NAyzD7pMXCvmsS1cRPlrD/U+1AMfEmnZ7XvL0XiIQX2q9+c4jlhAfiJdbgAQznBXzbIhawSxzVOXfU3oZKFyejRP1NTFkuglAfPpd/uoXrzgD15Xf7xYtK8D8Mfjtrh1cugYiqMDvsMTLOpUQ9p+3Ug7UPKbEivOqeCfmPF+0AeDrrYjLZADH96aNjIt9DKtn2oeOu0CBOG4oMjSd3+TarP5SlpRSaLWmXs11pG9YXVRWFSFd7+Z7x+hjfRKcd9jlL1lljMIiJQWoAYOVK2qdb6FeH6RU5XECjDws2PvurHkE7ggu0BzcvHch/wH1v9RrqsP6h5qBZ9Wz6xgSk9ajQ3jzB9f9QCJ2V9QibZ+k4q+h83S4uiaLsWYf/BLi/HaOTLNTAJ0uFG+kITNvY5ZeMtDd969X2mtK0cypbLvsqgmQkxsaP34+k2G+9Hb9GQZw83S4zEt+xcMiM4METfbAjXbexQTg4eRHyePUPMw6O473CM0P6KDBKaJpWvqNCK7M2eS+ovetk6fULsmmpn81Zx676R7U2UXAv2rVSP0vTjUklmdZ3ebJZcD2YVxCR8V6qdXpHomQFEOUrhFa00V/H7NUN0QX7YIcx2BbdMiI4qfyxs0KrxE96dMw/j7UXVIJH5wvOlBnhz0+tuMxEY59eSq2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(4744005)(66556008)(54906003)(38100700002)(6666004)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prY9HKrvYEGim1HGxfasVZoNxoh/WLatd0na4VSyBOvGLW2kcCpCLj9d0c9S?=
 =?us-ascii?Q?UDGT33Sww/FyVWVSiSwxFUL6n0FGLagyK9CTAcVaAy4cHPQUJ+T0qDDOrd+I?=
 =?us-ascii?Q?rRYmU1+vnivnOke0vbXzFCbI2YCI6OBnMuwveRIae7upB0n7EP8a0xOjXg3d?=
 =?us-ascii?Q?81FHSdVfpmIzwgyePXqe8z/HPlXDANKpfxEXEna2J9aMtK9Av4wCbrGlOU06?=
 =?us-ascii?Q?1uWc8AOLR874yXJoFBUupTvcMENlTYvi21Pp9J9krjrokReBIl8fXWE12asb?=
 =?us-ascii?Q?IwkVopzHGaTBVOavHI8h9igEh2Z9HzCuh1x3qL7lRRdWFYGjAvWc15S6u7QX?=
 =?us-ascii?Q?ZcYEwckF+Zk3a7jx9FCrfFwzz4RavlSCaKfmZL7CeqkBDr/hYx/abEo1y16K?=
 =?us-ascii?Q?t/pzPywTfyR1QH44HBZbn3hlmXLaA7AkB9Cz59pMnliV935QHpjzl8tkifDZ?=
 =?us-ascii?Q?9xfRX46KNqXISTPNhKOI/8mXmAVsttggr30c16Gz/zIUtS1Az+eRtLyZd9qu?=
 =?us-ascii?Q?RDDzcIQe9ZLiXvfictr6FP7vxBvP/wSR7/Af8Y/Q9AZV36iLWamZwgsfk0Ul?=
 =?us-ascii?Q?AU4/y+RmV0S25dE6s9lJk3pw7AXOG76KzWTSxpUnb7O+ua3uNWcne5uhaEEa?=
 =?us-ascii?Q?CXNgoCglnojLV5yctD3FY3lXtpNuv0ryuHUt+7Xj7AQuz96aHP/el6D8HXp/?=
 =?us-ascii?Q?2uaNVIU4e6aoOjBdIPNXKBMnAi/ELKaXMy/xDJNAzuLiAJStac+FL0TxVoYn?=
 =?us-ascii?Q?VHzc4hrtCtSPVK+bp19o23TvD8RUEWDyazGXV5OmfMzaZ2E0oBCkKC/fBRLK?=
 =?us-ascii?Q?UNrYsWYaD+3xslLRem4bKyCdUFaarPlxVfJFTUWcLmML/WjW+smifaz/UcHQ?=
 =?us-ascii?Q?P37SnT8CBTwFxaKPDMEbnMBQLLGQvr3GexM1qRUGzU+GBOroGAqWBuORxlM5?=
 =?us-ascii?Q?dDf18JtkGhYnB2Q2OGfaEPfEPPraU/CL64b/doehJ+zZrYlREYVg9toCmeTG?=
 =?us-ascii?Q?y0Si2Zz9ui35rPxMIAjt0vEL12zJ9JmY19TI4ENGGltCvLm1CeUfpKoUWW7n?=
 =?us-ascii?Q?FPuc8jr4MWB8cA+/EvepK3riQYD0RkNzIryj160mD9XMYKdxD3LJr7kUCyv0?=
 =?us-ascii?Q?5WFpC8iJao5XnMGS800dM7D9mK9B3WbSzrviHJAMiQm6DQ8hf/MbX1GKet5E?=
 =?us-ascii?Q?iaWmxSlwkrnBTRjyBAQI1du8ZlOi4g6JUYvpe+dI7a4ID/0PmYF2ouzNVp2v?=
 =?us-ascii?Q?rFM7piWEMEHzH0ZTM6JNmJkq73qfLkJJVkyDjKpmCtnvvYZSsvbmOqZQRfOg?=
 =?us-ascii?Q?p8YFyGXrsLubuZ4VD8GjHhcM76/Y/eXRRRIRh2ypqDqK73BPaz1MvnDjw6q5?=
 =?us-ascii?Q?kmIp0740MJ/6Q7uBVtrQNzppm0SCBommkLJYZ4COM+h/hIdOwxmLjfvewM/2?=
 =?us-ascii?Q?T/9Y6sFmp/+elN1LrTjfXpOyikbeleIt5VrpUeEMmBix3Eso1iYBGFdfa/9s?=
 =?us-ascii?Q?qn67E8uaJ4vtSq+kXCOQuCJwg6HQH9/sVQgTZ2+ItqUbsoHYdN5g2UIKzS8E?=
 =?us-ascii?Q?sSCRdXrR0rv2TlsqhnTdj/c6mUhRRmd0gjTeN69gpAod6sDxapRkuOhZ1cKv?=
 =?us-ascii?Q?2MbZtgJciFcTnYKBCMg6OKQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121cba3a-4554-4ca6-80c6-08d9d69b6478
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:34.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7xanKh4p9YVZy4DmCcRIVSl8Zv/o20KKrv9BuABtyeckOcdz0TLjdF657S0Cl7/RzouToda5z4DIjjOn+L2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that blank lines should be used sparingly to separate
sections in the "Blank Lines" section:

https://www.python.org/dev/peps/pep-0008/#blank-lines

This patch replaces all double blank-line separations with a single
blank line.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a42010fbdd..34c8696145 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3596,7 +3596,6 @@ def getBranchMapping(self):
                 if source not in self.knownBranches:
                     lostAndFoundBranches.add(source)
 
-
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
 
@@ -3819,7 +3818,6 @@ def importHeadRevision(self, revision):
                 sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
                 sys.exit(1)
 
-
             change = int(info["change"])
             if change > newestRevision:
                 newestRevision = change
-- 
2.34.1

