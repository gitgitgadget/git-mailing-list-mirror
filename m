Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA4C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiAEQP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:15:28 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:56289
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbiAEQP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:15:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpNT6nQ4KXXvCmSUAsHFmF8pdpRCP/qbaoX9ZXWWBiZ64q5WMuPBJIY6jNbcfpakGVR1ZHpBzH3yYanMPWldJPoG56+DCI1v0pgp01ii4jHIi0P37oSqdRL/4ZMJa6gG3FsyW5n9FLFZBIsPyvIg5kz2utxbhsx6gCDv6kvUx5qLuSkmM1ZluqT0+JD5pvHmqbky1xEb20ZO8IXQnuYz0UESV4oMu7/94MgOXwQwSTSijrnGOVGign6c1h7sCI1eFClI+g/+A6hVKGoROkDTekVZ8ekG9tdPFdyR5VBrRiwCq8N47tgoy/vUOX5eM0J7UbKwFCqVb+8GQaGNCiGk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38fn3GIlZ2lNRMK2i5uZ1hh8CgP0TerjJTW8CfHYwOo=;
 b=OYohFVDBrbKCVgwgHXACGLB4N7EwcswLNoiEVEZ5SZ0X/v49Mc5Y8ByUCwq1zxu5C43jgjc2B+ugkNobjQtmcVBba99WPW7OSOCRLyIfCBObpKMf3sVItdJLGjbpBASoSqA+FM7HjY3WOviaX/M6ZtnBnEmlhEfrckG7aDw5XDzZ5JEy06t7vE+GNd/Pmyiqzwd8gQ3n2rNrFR4QAG7Cu2HgbMKeOW0OnnNFdw1hcjJocnwhdjrtMXsaqWDCQcepcZ41DEKrcVEM6DFCIsc4Yo+C3qHxBm3bYtjncMuzmfZIVTDL+PuAnrEOUUBwKcgiCsBfLBsELkceUXGWTYLjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38fn3GIlZ2lNRMK2i5uZ1hh8CgP0TerjJTW8CfHYwOo=;
 b=JVDWhJ9T68ohAH4G1jofStkkXfn6ay12iKPsH1l10nEktFkLBP7EpOR24qSZ4TdUyZm9YdW3z3e0qHyNA3+4I2584rL9PdpVysHqiGPOJ/fGT3y+hWj0l1kMuqqxaBJxWmm3ZFJ68UOxqnGk28b9tsg3oL1w+3vv/fkDTtYAmyYLqLrnyqnGH/xxglrB5Y3E15mJhosisyvOOw1XqTIZFqRR0VZqmX8z4DDEp8zDPD+Ml6QRAhVqEsyB9fYmm4HS0lIhdsjfT5PvHR8JBjH42DHz/8I2S0MyoibkdNXdmgo3lDOFmzaS6uwUy94oLY5/C9blnyLhw0rf1ZDSRSn27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 16:15:24 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 16:15:24 +0000
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
Subject: [PATCH 0/3] git-p4: Rationalise command construction
Date:   Wed,  5 Jan 2022 16:14:48 +0000
Message-Id: <20220105161451.56378-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::38) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c61eb850-0b49-43eb-3344-08d9d0669456
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4423BE50680086760F8E13A9C84B9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHiHcm+iZlNWFCLRoJJ/MRay5ATRk/hTY71mFptDBRPlh8G2G+SVZ1ZGnUu5IZn9kLsHLILFYYyfrCRTdL8WN2yKrGh7pLNtyk9uiHlu+49JVHBUjEo7XgSdhY13/GRrrZ2JJ7EMk6EmC1g1uiZGVXkJ3hG000YhSzUuEGdJUOG/WF5V+YKVu69D63L1RoIp+3y+g6qcQ8MKPnMeYaaUcI59FL00eyItCf6KAlvX3m1Z2oRQpSPEILHa/T4whFLW4OOc7DduXZAN5/pZLF0UsSA0i97/EsGzrl1HomKo6ycR0QQlreQv64aww9SUtbIzXRGrukVrY/nX6uy+FP4ziTvayvups1AWEa1dkyieU6y4sW5rE6o9738NJXDac7Wld71TKTcFjhsDPrnSZXnrEa+6X1slHk1+V7Kubs17NBD01UeNomRkkPtoLVn6cslAfriRHnk4UUU1fxUrB+ZVZJNYU+RMI43RwQeJH5FvOQ5dAYAFnj32lcXSZ2Ee+y1gTS3AYbpaJl0M+nG6+lBUXDipPFDHxkO4UibvH6x3M4eyqhlLx6jrYwrJlh85MO6t+p3BDU7afKydmVSHVfFn7JH+gDogdhbRqXkKWQakNWmFXkG2ZSsv1emPq+RkRMu8mPWi/5elVHHkNjlAqnhWOu19M3BtBKN9SevQBUzpBn44cTYGXKyp3xc810EoHpNXTeIH1R1Vgl4eKQrF2ojM2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6666004)(66556008)(2616005)(4744005)(1076003)(38100700002)(54906003)(4326008)(316002)(66946007)(110136005)(6486002)(186003)(66476007)(36756003)(38350700002)(7416002)(55236004)(6506007)(86362001)(52116002)(107886003)(8676002)(83380400001)(508600001)(26005)(2906002)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VqkS7IGoSpq3qE7Q2ImySTbSp5slC8yvE70Ux74fVknT8P2tLkxt0HBG8XCK?=
 =?us-ascii?Q?LAOtGRxwTOdlVVpdTvUjURGThC60z1Au48vJ7DUyA9MZ6xtcIAK32Oz/bqnb?=
 =?us-ascii?Q?Q+USdQq4h87waF4UG3XeaAev36RACZS/2j7WP6Wyy5aYLUgZjtfjgJT0doPW?=
 =?us-ascii?Q?CDr72EMtnG975Lrq94uBDfV2NZQF1r7q6xR+3WgPaxbI6kjsFP4e7FvwG1AO?=
 =?us-ascii?Q?LXIVllXLWLIxjnWwW7nfdjXPu1wacZV5HmPn/156Y3/qnGLh/mO8JdgQEVmJ?=
 =?us-ascii?Q?Ohw2qEOl3iFXCySf1d8Hs6PG0OaVFv2tVpMo8jfwuKO8WSoOqBG11P4cD2ey?=
 =?us-ascii?Q?hLIIM8h7xehCZLPf7t26qzhDy8ilKdCQnWLiffF7Xjuuicms4b2yXWpMTRgA?=
 =?us-ascii?Q?3dnhkUkECDLGiUZbpeP/vnydrhilurQtElr/twCddifjEH6b6geT9XnBB5JP?=
 =?us-ascii?Q?R6aZCXSQcyBtft2Mct7sCO8CJTd/Cm59Ue7KOYOG1T6D4c9r9Wpzb2mXX1Ob?=
 =?us-ascii?Q?wvVjmtdOlkJ1fxkBHnQeG7vVnChwv8jFX3SaCzXq4RUEGNYDkY9jNmSeKhiM?=
 =?us-ascii?Q?jcRzyBnwJ6oXk4WbatNUQ/KiZgnhSYsaCp5eTXEnko2CcGDu+Hu30R8lWaYV?=
 =?us-ascii?Q?Ue36Fay3MnIPIXmtRWNiZXXhNbejzMeWcyu05E7ZsE5fXGbZPNKmOFsDQA0v?=
 =?us-ascii?Q?k7ZPhkibyg7XWRT3bmucuUwxQHjWqKDKD6B60FpZuUcPBnC+RyaV1SGwZ5+0?=
 =?us-ascii?Q?rc+Mrm35ZermCWkeYBhfDKMWOP4WSpzBarAP2rUL2GsEakFcOwVdUr8jzeKV?=
 =?us-ascii?Q?YwTNUfCtIGdBECio8t2zPnYCpVtNvTf7+5EoiVjWokuzLdchQmDA9uBH7uqO?=
 =?us-ascii?Q?APHD5kDlhp7EMedFNhi5shCEQht+mBL3rlUJbu3ExhWNUMpsylFYbG0JcZYa?=
 =?us-ascii?Q?i8MHbRotWXM3HJEVFmMKCanat6elItGwmSji7OpKPpl7lT5BBehuS8aF8GWA?=
 =?us-ascii?Q?um+9g2uZCb22SWB0RLjfbtH7V7/uOmG+xn6+Vy4Q3kb3hi0QXzHsQbO35Ikh?=
 =?us-ascii?Q?JKaD94LWd6tYZon5xcOlGONwvMevAi/2zcoKAk2fpkcrcWwl5LUsfIVRaxZB?=
 =?us-ascii?Q?CVScEJ1OpRsTsJATUKPmH9mdl2KlRrpmF7zTqHQ6dwHKkpCvC5gp07QLJdsm?=
 =?us-ascii?Q?NMwG/bByMANJFrMYP1TDur+3rxyXgTaiMHPLZc3pVNajIIVrtaMT5dsKGMM4?=
 =?us-ascii?Q?goHhWzQV4OrZhz9QX9/FIGe3bjTQjDIPDek0NnopCpDzyRDTWvaql31hIrgk?=
 =?us-ascii?Q?1QcgN1jyn0LCdkft1ab4/TkZZwruqxWAdLOBDWgFqY7A67tToA0su1lI90pN?=
 =?us-ascii?Q?of80zkLpOmVDjoiWeSJLbXVl1iyrWMjA6CC7Y48R+xVpEhPl6j7RtFvC4DOg?=
 =?us-ascii?Q?OE8Vcbx43VCcCphtphOdEE2aDB0Q2imLs9ZVcZ8H6FLEYVdXrbuof7EQ8/hl?=
 =?us-ascii?Q?6BnGZ56zKARZjCDaoeAXcLoAi+z4IIctLsat9c4v2uMxQpVgVbEV1sv9qcMC?=
 =?us-ascii?Q?16QWadkygqErLrUr1cfGhlYivLtTGIWEGzBwX0jqf9mYMooKqiICrA24L48Z?=
 =?us-ascii?Q?W7yKQBgN4M3vSw1tHcG6JCM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61eb850-0b49-43eb-3344-08d9d0669456
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:15:24.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ewy8dHicuAmgOlMAizjp/uUCn9WRERADnQsqffQhmcVtbz/f2s4YwUqnRIWyY8HKPTCeOWuCCYRIXRxB75/jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

Joel Holdsworth (3):
  git-p4: don't select shell mode using the type of the command argument
  git-p4: pass command arguments as lists instead of using shell
  git-p4: don't print shell commands as python lists

 git-p4.py | 176 ++++++++++++++++++++++++------------------------------
 1 file changed, 79 insertions(+), 97 deletions(-)

-- 
2.34.1

