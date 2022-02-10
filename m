Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DD9C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbiBJQqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:46:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbiBJQqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:46:53 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDBE122
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru+yg86/sA5oeB5e7Apf9o4smDCCVgr7QjeOM5NYA0yGMaRDBeE+UVbhBkAKhQtrE8FKHuNGdCofocXRKJOk3QmAvOPJgHR9w+KKwLwH1xCPssOgrfR3n6gCmLzV5ydfTihgApSiRJTwzv+whwdaaQbolrOqmYUXmBctysANZkz+u5fvjMLj1MaHE36J/1TIwB580EnbOkWx6xVQKjtcSHDGHBvc0uzIg7YyAPAxKiwSIUO2GlL3K63czFrGpV8aHeaQvjHJ/GIIp9TxV5k87TvurXIQWepk6TjxdEmx74Gm3QLuuK/4vNJZYGN5NBpp5C+GdMmSYJ0zj/1QAAgc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcRZAtCHY5rDL43l5ipg7hP7yZBQHnLY9n3O0TXEIjI=;
 b=NHC6b6lYri9S6fs5lkaHHko4ISbsFD1vndpVP5KzPflqs+BHIrAWtBP3KuD3r726HFcggicezasmvR21zbPY1K8KaryS8Rq7FFc/0m9sDOXRffG/IjMO0dgZ9D06WRl0Bq0NKoxekZY6HubZCGusltlWLJ7VVS3tudgzOBrRoeUComUxRmomMxTJVnQGi5IZZKzefgQ/MEqa3YmqvlOFTxJZoyUfbfqpUOSsGxMtGAmJUO1GRMwtirzXfLBKLF6AqyjuYlErSBDjsgfPvQXIPuWOS9nvFCSw+Pj/fcDpx7VxtOUm7upFVtCY2j8gOBD5QHjAgUAVmVOJxB7mM+QdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcRZAtCHY5rDL43l5ipg7hP7yZBQHnLY9n3O0TXEIjI=;
 b=XFQbF0tRxtZDx1aDWh4LbYOwvzoxGgkqcv1fcjUaOpAlHPsKncKySDAY3/GOIdeqPD7ZyAnQIl5OWhN3A5kCTd20dEQhH/4UHv+Pc5NWGEmni69RyBJAEixxs3rYJ8gSAm3jsyiWKGQbtAOqIkiD0kUgDbEInoblaDVQVKJrpm/oWELfpYFoLzPP6FV1xHCQJ4cbZOFO3jmGthnQeqbgTUgjCFcfPNTwLE9jiQcArhGAM7U5R+oJ3QOCyRxy5J3uBVCEfWtJ90t+Qr75roE4Of1VdlBUFHuDGgMHydpOMcQg70vWcegVW4au0kBPPwiXWFFp2uRt+rVAqrBMEhFuKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:46:52 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:46:52 +0000
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
Subject: [PATCH v4 00/22] git-p4: Various code tidy-ups
Date:   Thu, 10 Feb 2022 16:46:05 +0000
Message-Id: <20220210164627.279520-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57245949-cbbc-4e4c-c4d7-08d9ecb4f023
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362C1ACE0B57AF5F891DE8CC82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTp1jR97Y6bnG6bosnwvugSnv15yftSHjOUOgXaRGAinDg2Akmsgv+tmwq1V2VH7G5eHSsZ14eGxC1C55J9PlffDjnS927F2Lg5Lp5VuT8WAtKtVgYGzd75ZAYrCpRKMNyq/UlIjx/8Kr3BHrgjo+gWNJzp2hlef13+K0CArZ2Jo96O316enV8C6mzsRtNdjaDIogjSdXBFkO83PFCDlYJYHqRSe26Ox8qerH+b2LeHYtVimhO+gVwpfTV5iskj1cF4jrA28/CWO61gMOsuj5y/8TZVlG/pZVoSai1sqbScSpLzY/rpbNmFFW5HJWFqPoiA8wOKAcWoImRLBtGKMkgJ0Q+C8KnnK1XIzJTkDUzTaXlY1kZRQK1SXnRai8OkOgCiXf17cxzvDFif3mZJ2WV0vG2QrxJZWcX39tgYoaMXXcsToE9fjdFoBuA68QTcNV6ZEj43Cg/gTPtnONDw5DXN8wLuFeWy82cJQjKrE82qxuYltWP70Ir7Mzf5D1pCQ3q3j5uTskySEsPAeoEDMYDl8+VkkPRLUO1A3bL+LLcZ8sIOLO8mwPNe6vmwWpRU1dQQXeqgOar/9OBl0kVTFgSTSDlsJByP/79yuIYTGnf6QAJP8+g/9f8U/Ji/omBsIvl2dvPmr1HvIzATP1CUZ2nTjiLXo+NZR5PcZT66cM2Dru3jCBT84xj9idDJ0ue3kJ80ehR0ZkCPfXQ+9OYjSwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(6666004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XoUyiaSlIePD6laYkPaiptO5EkDLIwqoSJsw/KBiIyfSwH0uBTxAQwujLagU?=
 =?us-ascii?Q?A40B+yk/Y+ErRenhC6oVi5jGOU+b6jbrFH7BWQs2y/Rmw0WO+xm9AEj1tHjf?=
 =?us-ascii?Q?QcG6DEy4q6GoyvzDiSJ6wgcViPyqFMEYh1k+0YPdsw4jPydrHBJIXgY1tYRN?=
 =?us-ascii?Q?rWOswf993CgX2va+cObaJdsJs/EKyg5YcyN5dS8DVd6bSW9uJihvFI1pLEjX?=
 =?us-ascii?Q?rTa2ebUKv8F5UUtt4tk3DzIancfSTJaC4/Nx65JeT35eQ85QiYlns1N9EjrV?=
 =?us-ascii?Q?A5XDiDU/U20TKSlY9rKYwWe6/wrqBeMLA1MI75iIwQ05vyYgi+Q+Lj5cHEeO?=
 =?us-ascii?Q?3UJ+hviY6/AxhU2wTzLr4BJYdo8/Pe0tC1xAfpLZdjo6w+KPYOkLx6pvJRS5?=
 =?us-ascii?Q?SSAXlEr3bbJ/PkLWXh8hnf6JMMGdjLNNC2AMxajq8GoyHmVkEWfwcwToQ/fu?=
 =?us-ascii?Q?ICvI33QvyUU03VJ2GHJTs/fBvXSQdNRNpDv+Z8r5mDqqd49FVYI09TsqxNzT?=
 =?us-ascii?Q?ZIIrVw6p7g9t0ciQDlbyUMLkmQ8l5Rl8gVQqPqIKJp4JK6M8I8nFXmov53Mt?=
 =?us-ascii?Q?Ii+Uvsw1kX0lU0Hy4Wcvw87s/8pAZD+znI9dKopcehvtpTjOGOIhEsGcxf+U?=
 =?us-ascii?Q?rBSRK1n6x0cgSFe/Iv5cQAiiij7jBmAdP29vyz8VG+tPfFugiSA77Y06aC5b?=
 =?us-ascii?Q?tpA1jBNoaL2tjQkzP/NL3dBvgNa8D4KZA7itEsKF2qz+XdivF+sDYmtoKjeZ?=
 =?us-ascii?Q?qr7PGIuN03TelZcg9PTLu4wvtpx2OXJBdwFRiEcRCepfh1sgSRKdFDGU2ErS?=
 =?us-ascii?Q?/qv4m4u1jle8ON742vYw4QKjWSlGeDYIyxsMLIPV7/9d7KN07n8biNatPISt?=
 =?us-ascii?Q?ivPSaWQsLKpfeo5OWEvm9n9PYch93wkMTpBLTopAif9aJhShOz8DAvFYIE6v?=
 =?us-ascii?Q?uH/0Yh73sqID9YpV1zi/XbwZzERnJ1FvVfS4yDYUbaTZQw7g+Ddq8ZQeBo3n?=
 =?us-ascii?Q?a5unSmP5qnwoTQZZxjuDmUjrhAYvt3JkLwgZeP7YkDa6R59dovYSqYb5XNuu?=
 =?us-ascii?Q?JmFsckR2sbQk6J/UKkd6KP/Rv73gxm2KRqfph/S104Ikc9O+sPVr4XQDQkrS?=
 =?us-ascii?Q?OeMmIVG4gigEoBVpRrqcS5CmG6l3JSzuL/BAIGCc+Rt3ah0yVxEoI4BKJqSh?=
 =?us-ascii?Q?gVRRTSvP1ylnVnVBvLm8zMobymA+STekG2zOWhsC05TzFFz+79XwDEpN7toF?=
 =?us-ascii?Q?HFNshjqcdiWCzRTskSfOBK6kpXx/BLZqhyU4fCL+72qei4wOtA2ww9R+xO+V?=
 =?us-ascii?Q?FdJ1PGKBkfgHG0b1w4lV9cPvfBxWNv2mJvVYWi8gayvdLiS0wwCoWcW3Ab1E?=
 =?us-ascii?Q?hlRcIw/xdrvo2D2ueWYRTldyLmITrtztLknJE++7zHfEe+dIUpAlLtcUYl5l?=
 =?us-ascii?Q?dtMPuTuJ34AkSoFyd2o6MV5aE4/bz1CVWTV371icREgG8Mh39vASp4R6pJz7?=
 =?us-ascii?Q?XN47DxnnBPQny0ce68axB3o4J6ZdtuSLpJY9+w2iCUrUcVm4/EOvJgLCU+ox?=
 =?us-ascii?Q?n5hxjywcrDCthRUt9tP/Ub+J39F1oKs+FRYSIXNXHipUsxzXdwDhA9fcvqvH?=
 =?us-ascii?Q?BuI8b86fdBcGMOPwQP2awcg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57245949-cbbc-4e4c-c4d7-08d9ecb4f023
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:46:51.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh2SfK+iWKa5deWF1ELzmpn1oc49IqjFpii6TmZGhmpn9pyAjBn2VgFJQI2H398YJVJBEJyaWVRLG8cgaMw6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set contains multiple patches to improve consistency and
tidyness of the git-p4 script's code style.

Many of these patches have been driven by the guidlines contained in the
Python PEP8 "Style Guide for Python Code" and were applied using a
mixture of human intervention, and tools including autopep8 and
pycodestyle.

This patch-set stops short of bringing git-p4 into full PEP8 compliance,
most notably in regard to the following items:

  - There is no patch to apply the recommended column limit of
    79-characters,
  - There is no patch to correct hanging indents of multi-line
    declarations such as multi-line function delcarations, function
    invocations, etc.

Patches to correct these items may be provided later.

This fourth version of the patch-set corrects the rebasing errors that
were submitted in the previous version.

Joel Holdsworth (22):
  git-p4: add blank lines between functions and class definitions
  git-p4: remove unneeded semicolons from statements
  git-p4: indent with 4-spaces
  git-p4: improve consistency of docstring formatting
  git-p4: convert descriptive class and function comments into
    docstrings
  git-p4: remove commented code
  git-p4: sort and de-duplcate pylint disable list
  git-p4: remove padding from lists, tuples and function arguments
  git-p4: remove spaces around default arguments
  git-p4: removed brackets when assigning multiple return values
  git-p4: place a single space after every comma
  git-p4: remove extraneous spaces before function arguments
  git-p4: remove redundant backslash-continuations inside brackets
  git-p4: remove spaces between dictionary keys and colons
  git-p4: ensure every comment has a single #
  git-p4: ensure there is a single space around all operators
  git-p4: normalize indentation of lines in conditionals
  git-p4: compare to singletons with "is" and "is not"
  git-p4: only seperate code blocks by a single empty line
  git-p4: move inline comments to line above
  git-p4: seperate multiple statements onto seperate lines
  git-p4: sort imports

 git-p4.py | 882 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 525 insertions(+), 357 deletions(-)

-- 
2.35.GIT

