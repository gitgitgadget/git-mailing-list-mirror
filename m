Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E14C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiAPQHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:17 -0500
Received: from mail-sn1anam02on2061.outbound.protection.outlook.com ([40.107.96.61]:49342
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229484AbiAPQHR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAcWfdSnMd/5weEcTq5HpT1JKX/Xs11C0Oy2pTvSRC/y19JAu6U2Q15Awgw7p8JZgRx8ajpESX8Fd6iSXSPa1ft5awrxxqbX7/K2zmFcGkPgbnM5PQ+1cvWlwD/4Yn6MaKAOq3tAYM/I5tdb6heGXuk9U0nCwGeN175sU7Y1njdjYNxa/BXqlmKWFZzTxmvoY4oEJP09FG4Qohr8G32FXZZwLo9fZMUy2JKq5XMJ88vAW+Om6y9XOQZDtm930c4k17gWspDT3/Dm7dWn0MzSefSgyWyfAy+XzGLt6q8TcpMa6UKoFbqhjEBUT1betm8jDpS/VoR2EkFKcaIvRy8rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTfM/Ye0LgX0C0kfkdRxcuUX2M3kZwXE64EuX9hv0eQ=;
 b=LW6CykmPN3NW9lYTOfPs3vEewt8XzEc+Q12d/6VzcKOswyaGh47YROqBS+iv4xIACHmCdpJOvagWCPE9tqsN64YRXkyIurlcs3RgPg/aHFID5ko2WLgw+iVm2uEac2SkQX+ot+Y5bC1RN9BKNTvwQ+hQui+JdsdAprlurgiYZf4wrkVDc1Xn4f5tWt5D9MeJVyC/R8JIPFh8htU7HJWgn0CDuVtFZdOIv/llmMqniR5k62zGWtw0KZ8a4rRQrYxRn3POrfEYMv7I9tkPKhg0K9PbS2PhWITNQNvDoKa7kSJ21we00tnYzBXdRRomE1AUU7Om/0+7O8Ben+6cbrEvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTfM/Ye0LgX0C0kfkdRxcuUX2M3kZwXE64EuX9hv0eQ=;
 b=f4KtFcp+95hpklY4JcIylfpxw+66WeT/UfCWqBkRVxROXvLxt+9R/UMHirMYBMnQ4/7wxBRBcxTUSpEI4nJr5KFgR7PpyO1R63Rsy+VBK1jQWVte7SeQzRX0v10LiipjDeSRBe0znN7wojq1kdJehEZtuWeRwxByUslj7h3LHjdL5d9ezx4MQvKRG/swAYtQbRiHmgjgvtV4jjQFpCeDaNWvZ95l3HzI8idqQnMdiDeCuKKoZaTXxrMI7PSOHtwuJvh6ShasFlbrGCpTIOfVcOaJGDNboXW51N2sqZ5u3C+3M8OQMC55yoxUVn7wr/oabHlx1vELVryomPEHHGH0wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MWHPR12MB1165.namprd12.prod.outlook.com (2603:10b6:300:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:14 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:13 +0000
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
Subject: [PATCH v3 00/21] git-p4: Various code tidy-ups
Date:   Sun, 16 Jan 2022 16:05:29 +0000
Message-Id: <20220116160550.514637-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210a9ef1-eb9f-47f7-08e2-08d9d90a424f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1165:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1165CEC1F5C9E8ECDAEC0F65C8569@MWHPR12MB1165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbmVmdydXaVM5+kUaptIUK2Qt95CQ4ZdfHTEq/vt5KMYTYEBLBAMv5bXpTkpD7FWz4lpe43w1i2qlqnhPOwHfixm2j1ik3szyzno9avpCu6AX3Ouw32OsjHAqtlc0buU0/TsO/sts77KNe/Hm+I5+1F5LyFWJqvd8pPBaAyVk5YEQIjwYhoPIjkRffLHxIkrx68I2zHlQNlCi4iE8hGT/wwS9DM2iUC6PcssDgipURNBoji8lzQRIZfDpCAlxQ6oEB1mgBg90H+Y1+fbeaaVdSG08CNCSA4mHn19VwRZOJBWBVgQ+8VrlyP8bgfirOBvZyb5gsFldz+tmRffi+zenp6V8iGMC55uDiQuBcsdIBLf2oZ3X2wcAYP7bwZFgNi5hcPrjvoobN1YQk89nFJZOt4zsHqfBMwGaYeLep51V46jzKD/8RbwwjOQSSbhj9OePFKZWKez3YsQlvOahC2H47/B1QKW5PyNn7l1GkjGTGAwaxTYaRTyvtPZYY10qA1A8D4585hb6fmPRvgzrzwZxt86u1VJqYpGjgY3ePhM6YHGfd2runoQ4gUKowytAPFju/OcaQvvLhRDPwf1WD5WD9ADqrDQmv5lgc1YpYqqGHupmZ21mLx10Lj5athosokT/xbuvucJIDpGOygo1G0VOooxOyY2sddwCyblE8aQPoCtNsoX6mb14BVal/olC23dB7ObSCmwUhZFgMUQI64h9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66946007)(2906002)(52116002)(8676002)(508600001)(186003)(83380400001)(26005)(8936002)(66476007)(107886003)(55236004)(6666004)(2616005)(1076003)(7416002)(6486002)(110136005)(86362001)(6512007)(316002)(36756003)(38100700002)(38350700002)(4326008)(54906003)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDYpDNRMjFyQ2ocvxjSrKe+kpLp7dDY7qFBwuSjYzTsmjSgN0VSKqoiajovP?=
 =?us-ascii?Q?BneNjnviH5RHzMD9TVPZKllvOUR4VvHeRz/Bwtr0BzyPDpDn55mZmA6jYmTL?=
 =?us-ascii?Q?BsEVwU/VKNhvAH5TV2EH5YnjJs792FuhJm2Rdhb1nYIBtcPHNvgdOZTtRV/V?=
 =?us-ascii?Q?Kvbg3mmISxyuQt+9vMjDQDP4BIb61IUWjJaNwRAUe93WGVHt371otI8hWSSk?=
 =?us-ascii?Q?5e5O+TmMzuSvD8EwOe8g8uPRrchHQh0kDlMMu9gcvC0jyEwCBy5sf+vajmZC?=
 =?us-ascii?Q?FMUdFobXzjpYpPV8s9fTR6aGyAVSaO2o+0MPWtk9VcPi1FuM16YzlBBa8rQ8?=
 =?us-ascii?Q?uoqC1zS/ZlhjXmcGdT5hEwUe/cBxC43J90PZjrg/3gqDVSVPqvVxnhaQL0TM?=
 =?us-ascii?Q?b/XUIRxxkn4c6t3lX8byv+8hToV/PxDL5ipP4Aoobx5O0bSudqLz5dXF7Ki1?=
 =?us-ascii?Q?/ecRbqdZ72OLt9uAxFHnEvUMyfgHYx9QeWFHqGGQ6BR8hBhAJgvsyI1Hhu40?=
 =?us-ascii?Q?u0blsDy6dOKEwqceZ3Y3Uh6zLnVj80T2cDnEN944A9rJ7yKW4zJFo7tw6lfh?=
 =?us-ascii?Q?O+db+5QrUejjwuMZ//E2Jy+/qZZ0ZntSikh5egD+PW2buwwtORrnHSrquCqo?=
 =?us-ascii?Q?0LImdPMnebz5sHmx0bkLc87P2kGL/PcgIwZ3M8yoBjn2D7guifYipufQuFBf?=
 =?us-ascii?Q?jjS0cR9La7iWEl0sZ15EtPZKBqIgdXQQ9sbCu8BBw/YIJePQHfpxiTAxC+Or?=
 =?us-ascii?Q?xa1AFc483mQ+5jd5LYDO0OQ14kZ3jrNmQPbeex56oXp75tQPk6KuaC3m7mXr?=
 =?us-ascii?Q?1OM28z7rDGNZJefAZZQMTzJ3q+HWyqyhGYY+o2OYkWbwnyyRYBbgWttBSwO/?=
 =?us-ascii?Q?uZn1ZTVRrW3cp7lPEVS8I2b7Tp4UnkiEMfLZ2EB6cFi4kbXz/hgmwky3CNjU?=
 =?us-ascii?Q?baS7uoXUhEXN3S3lWQhHswkmNm9vIccvKcQPc2fu3r2xijKyv1aTr4wahYCd?=
 =?us-ascii?Q?8X0w91VwGJL7HX8I55VlmPmMwKnWjczP7oZmcvCbeJKl/bHyf5vpW3GleERu?=
 =?us-ascii?Q?2RKW+BJ3INvFIoPoRu14NA1VAYuGWIhJ7pcHlhJomr9hJ6p+pjgZb9/LZYbU?=
 =?us-ascii?Q?ARELVKPG/gRF6lvzHkQbZxogkjSItDVcU1s5/Kah/yKBEROVickpk9QATW+9?=
 =?us-ascii?Q?5ClWSTx6TierOEavsU545r++bPriWZty2lsewHHrxf1V4pq/aZkWXeVZ/bl3?=
 =?us-ascii?Q?gFb0InikZOGYcM9X+7Jk2qZWm4/pGBJbJv5zSTYhoTppPTQlkZuZNwWiF6Vw?=
 =?us-ascii?Q?nzdBffQMZYkrJ/E1ArmsY6koCDROUT1sb3LNkvU1WPSnvP7JCh1xQAZfWtzC?=
 =?us-ascii?Q?yI2tACQdSkgepsNaVvcwoiEHS3YbasYXxSa46WtDVvhECqgt2i3F6IMkqD9A?=
 =?us-ascii?Q?jU14gNIMYewwFTbC9qKtnghy7YWb08XvkdIFJ2lJfO+AbDRFe3BLSN+S3R99?=
 =?us-ascii?Q?lTOMQYhUVKP1ptafYv4nPAxmX8EX73j1/52Yqd8tDytcRLHtBL5RDtQ2s0g3?=
 =?us-ascii?Q?E0S8B/+TCaNZ7HdgZi4irigTFI5Kdvy7gFt1Z1cU3eDiHba8U7xvcM+J89Qn?=
 =?us-ascii?Q?vT8XcMfztu754DqvKvyiIu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210a9ef1-eb9f-47f7-08e2-08d9d90a424f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:13.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj5oGi7dAHYe2H61jBwHEGnH41zR3fsU3aVzi6BTahovq8Od97cXxHdMU9T/p3Hkf8fw0YGpbXP1jorqfDjaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1165
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

This third version of the patch-set is rebased on top of the next
branch.

Joel Holdsworth (21):
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

 git-p4.py | 890 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 528 insertions(+), 362 deletions(-)

-- 
2.34.1

