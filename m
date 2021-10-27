Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CBC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC78610E6
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhJ0IIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:08:46 -0400
Received: from mail-ve1eur01hn2244.outbound.protection.outlook.com ([52.100.7.244]:31484
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239150AbhJ0IIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKTBEDMiHT3fmF8hEV5vCjt3xqLUpEAsblnbln3ze2Ww2RpubSpLa3+SSa1w38rN8bTMaXlGuZrNSp1d7ShaVmT1QbMW25OlooXy1+311fvqokcoNLFUcU/OvxWXBTMOfut+/MRKzwj5izg6YvNAcQSkGNnBMRBrfrTFiySEnXTrff88IAx9Pa4jv9fXyrcChVUuuy85Pm41T0DHCJzWOyha3lyoEzd/iul9pOdXLaYSsUuRZzcKN6mI/PV0Gjm8o9twodm4wpXYH/qLdNVZIQOvaYqOi5c1hzA7XmumOTIQvaqL8+kMAx2/6aRej4BFnZ+yaP7K6nt8gnKKq4SMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IyYjc49hHwYKpSnN3JD1lCdGqNp+hFcmWMGybkBqDE=;
 b=ShHc5Qd4zb/ljUpTfjEJy5Mxz4oYHQn2Nx755Yxoeo/S4tZhCARlugGFePY9YKvzxpSAsVCrYmEGqcpcG8Anl1sOxa9dsWtdG1nx65Rk1HqHIV7MefG+dbXNLAnPvnUQxL4QQAe23K8L1Y+PS8ob6/xVwGPQsgau9RaLOgrjkHfCU6+fT2fHQJ4ga6JepJJMERYE0csbKR9LxSf2c+jCd0AQX2Ha36X1ijRaMx4YDA6fgsBWCBrPBu++hG3JfzJi9GZ8gXhZB+BJR7K1Lw+yXWel1NNpXTZbgrfnm7heDGpLRtaHiiLhStj3KCfWH4+d7jBPUaD/xDkIEYM4ntx9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IyYjc49hHwYKpSnN3JD1lCdGqNp+hFcmWMGybkBqDE=;
 b=VarsYGxAyKSkSt2L0NuvUMs5tWFugnQZpvIJPBhBsvvo4/Kv8aTvKtVA5Euf0wxaK5Xg8zpJ5h+aseTrnFYOa5LCw8+pXr8GrIu2LXok5AD56/8Kbluv67cJ5wmfcVQJLXTXOEX3tL3/RGgbyceaHJb4R9Mkeu2JpDyd+B8Skeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 08:06:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:06:18 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] ssh signing: verify key lifetime
Date:   Wed, 27 Oct 2021 10:06:10 +0200
Message-Id: <20211027080616.619956-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR0502CA0050.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6PR0502CA0050.eurprd05.prod.outlook.com (2603:10a6:20b:56::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 08:06:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a07d20b4-b2ec-421a-e1d1-08d99920a7ca
X-MS-TrafficTypeDiagnostic: PR3PR10MB4158:
X-Microsoft-Antispam-PRVS: <PR3PR10MB41586455AD18B5582B1C6FA6B6859@PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q2bsoIdbU2FuuzwGEUqxdh2HV9+PFuIYnOPaGDJ0490SAOo0huKYryzELsD0?=
 =?us-ascii?Q?2umJDEwtocfXrzLovWOwgP1kztRbL9fr5Mxd5PvUsYs5HgNXkDh8CgjcBG1q?=
 =?us-ascii?Q?RZDBAVWBNJWZAN+k0Vmyi90gIi6bVyZBPJQKXN47mRSO52mMANZsQG+EOfVs?=
 =?us-ascii?Q?dLGX6NhtghWmDXlcuuHB/Z5/igtdJ5iMqkgo8MFN7hrQPjJJk3+wl7LNYcjw?=
 =?us-ascii?Q?FCirlAU7F8175f+/S4mHlhkX1XhzSpqx4ODXEguMJ71Mf4A7urgxmXfKrJZB?=
 =?us-ascii?Q?+UrCQV4KNW5q6oGzSGSVJc0XpQ0jBxgaB6RMIGCIa5Nvk3cacgQ6TNNf7p+f?=
 =?us-ascii?Q?ytDYJZ4NRXrGyIhopHk8yQYojgKod9r+bY3uRoD8WD3cfEVu0VAk8yXYBMp+?=
 =?us-ascii?Q?zSSx1D3kyrrFnu4/+3FNsdl78MeNT6Dtdt4qYqXcREHMTSIpWz9sc2vlmqGW?=
 =?us-ascii?Q?VQQeq4pjMlwcaouv36SVnSGWh7yQm5W8HhI2+Lb5Xhvbp+wTtHY2d89b80TO?=
 =?us-ascii?Q?6N1DX8pVQBhj6eLjYiZvf0EoGpF8jSrvnXCOmpbXYYGXz0xYBicIAha9z7P9?=
 =?us-ascii?Q?4mY+ei9/qfuWwKVJeN9nLW0oERC07i+bF8GupUbw8z2xafUOWotAhfZtVWqG?=
 =?us-ascii?Q?uEZWJr/Bt0lzMDTiEx6RIwMWbt1Z3RPalZJhfwR8kt3HDMMAtplwTvTXJsxZ?=
 =?us-ascii?Q?UT2nC7ommb7ExYwJ75qucWI8S4Soe7iAhtKDlpUEsTMjv5DHBEqyOEsRGHGT?=
 =?us-ascii?Q?fTAXV67cbwkZuDMgTIBhm2lsjvdA4HSyQsxBL1eI/kSB+/PNlvQzTEGuDQpJ?=
 =?us-ascii?Q?LRhl2/0llJWs/knLDjuWbiMBfHt/TlSrolSZsIyty59M94m1P1vCHnJP5ksw?=
 =?us-ascii?Q?QvJ41rdZ2pF0znmJbhUarIq0p07FebLCHzzM3jxWZvjFmeJyycL1cluX+2o8?=
 =?us-ascii?Q?oSSPRMvQ4eP8796Hd5RDhAAzUn6sn6v1Ejre+/wBNgFmcHhgyT95AzChiGd2?=
 =?us-ascii?Q?P6iwNKAZEEvsiA7lkrdI2flKfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(66476007)(66946007)(2616005)(52116002)(6496006)(66556008)(186003)(8676002)(8936002)(316002)(6486002)(4326008)(38100700002)(1076003)(54906003)(6916009)(36756003)(508600001)(2906002)(83380400001)(6666004)(5660300002)(15650500001)(86362001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MmluvvMGuq5eK8V6vxQXi7A5XrlovirVOOAO6YB+YmFBoAEGXwp8OV7r+9M?=
 =?us-ascii?Q?ht4vRorEDIrUOeFTAdSJ3a6fezik+QhWJHEuz9xDtjyr9iIjl2lBT7lapTPn?=
 =?us-ascii?Q?HPHBLSesTKuDbpJkVhVSIehEwlDXSY0twW7SeejjSMoDP7BjlBruzsvsF+tM?=
 =?us-ascii?Q?Alq0Z15SRfZUhuLUEOhFOG+911vxhjVmEiFPPsVxZx8aiegL8Up9D4zqbzmM?=
 =?us-ascii?Q?H9bk8x5wouZCqCZAA3xJjK3mCRCRRDmqirAaiFojC0qC9Qq3aWVTAMmUW9I4?=
 =?us-ascii?Q?X8IrJO+70X+hUcDGnQuIBwcRCHDgXCwaf5RMH97B2Km3cWdrWCrmyShivAc6?=
 =?us-ascii?Q?QsdSghavbRne3AnAC94BUNVr5zxH7jGQBTK2ete7yY+DCLlihLEZa+ulkKoW?=
 =?us-ascii?Q?fdOyjavGBn41Zil9cSBOOouPG6/xbeZZCFaNNL8dqzP8gDUA6jKV05bMxmm6?=
 =?us-ascii?Q?qrodF25j3NfX29lgXKyAyBMckYi+aMX5j5At0evmhhpLpDmoYlp0/Fp5kWMg?=
 =?us-ascii?Q?ncddoq7rfS8PszQHQOWTSK6WtEBi/lop5L1P3HyJ/hR5p0yugoZBFjfCHKEI?=
 =?us-ascii?Q?RCvy6t6/veXGOI61TLFktjOVMUfPOG+ucvi5u+luBuenWwC8ga2P9yzehWAl?=
 =?us-ascii?Q?5o0ZGGhDn8fBWMWoqR+BSXEowAuTO0HQSVTivdOCUeEaTiwKdNA2Vl6oaL1V?=
 =?us-ascii?Q?rSoAsR171MCc5TQSPdZDSf1s90ZzWQtALE1eFa3TfLE6YITUQ0QXyhCJlE30?=
 =?us-ascii?Q?xFh3dhA7ZmCy9qWgSRf+1dO9VkfV+joYLou35UxUktiGn5pN0b9vkoOZpObP?=
 =?us-ascii?Q?EW/03ePu2bbjTA9q84OhAwdIyZek6syFLA2DR48p2R20acstLEZFjR5yg3PR?=
 =?us-ascii?Q?RVkuPPJLAfCNq1qt8MrFVYmS5yKZxxhf51LkOPhbwftZ0xr04jJ5Ku8jHlo0?=
 =?us-ascii?Q?jyhqpD6FRM+F6om8SBB5/0yfmXzL96oo48x+qm510KcQOAOcKk/YluEg1mOM?=
 =?us-ascii?Q?4pjaAZ2VfcgGpYalPxEYWhG/RPMQDUj/GMW7hBDP+af3JjSrzw9aPlzhP3n/?=
 =?us-ascii?Q?RrGow/mIPS1lJqhCjiwLXBicT4Gb8kdNaeUGC3RFY86FGOzjrcjSXXgHbW7q?=
 =?us-ascii?Q?Hu6r9nYJ2tuR90qex5dolWpcsABnbOHiKeM/X+iu6iaSNQ3vL9e73qapud4W?=
 =?us-ascii?Q?dYPFwAjTg6r8pGp9FWTKx6HqPqRRvxiPhXyh9bqvUbAuYLiqf0Ce//jGI668?=
 =?us-ascii?Q?BFv+8p7a7OCD1Bu9h2CznidZ3Ujz+yUA+AHws//2GxriirJEsbwzh7ZFcPPC?=
 =?us-ascii?Q?9qZ5Jy/32eq0Xe0QLkpDSVifqN/nymoXXpGzs35sWfL7RqoyWVKZa+XvfnmF?=
 =?us-ascii?Q?V7FaUxItjeYGMt5e/kD8JxB+YIYW9GToYY4LFOMB4yXUL3Y+G6aJq+v7doRY?=
 =?us-ascii?Q?ymSsjRXsUX+gBl8FSd00iR9xTqqTWBxvEFOdyw57uWpjx6AjmR+PJCgxzJLz?=
 =?us-ascii?Q?hll3WDFphqj3rWhB+LqJEKriHxOiQIshl/uORmdzkdrXfMtOWA3eR5KUszr9?=
 =?us-ascii?Q?CijyqZWhqA9GHw8k13S5iG9LwEmnVvfw4aiu/lh2YjMOYsiKof6ae4IUGCTu?=
 =?us-ascii?Q?8GLgAnLP4Zj+V0gEiAUm4xSN7+NB444bFPPwyKXcokS5gff7VRamwxfECVNf?=
 =?us-ascii?Q?1kj9avvioJrF94TXgl46jJa3Spe7eQR5/cg0CcPAnP/Q3P7otZ2OPPrNmobr?=
 =?us-ascii?Q?V8PMuAPmfA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d20b4-b2ec-421a-e1d1-08d99920a7ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:18.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3ihRpMwUvRrvBd0Kd9yZu5dJtFCmXL2mn28ghudOiHAGlkEgPdTEp9Z7ebnN5pd/Pw6hl5cWzvF8LTsJQ5L48Q7N9CNRETp3F0bivbRyYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4158
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds key lifetime validity checks by parsing commit/tag
dates from the paylod and passing them to the ssh-keygen operations.

changes since v1:
 - struct signature_check is now used to input payload data into
   check_function
 - payload metadata parsing is completely internal to check_signature.
   the caller only need to set the payload type in the sigc struct
 - small nits and readability fixes
 - removed payload_signer parameter. since we now use the struct we can extend
   this later.

Since the last 3 patches now only contain a minimal code change and the
tests for the seperate callers we could merge them together. I don't
mind either way.

Fabian Stelzer (6):
  ssh signing: use sigc struct to pass payload
  ssh signing: add key lifetime test prereqs
  ssh signing: make verify-commit consider key lifetime
  ssh signing: make git log verify key lifetime
  ssh signing: make verify-tag consider key lifetime
  ssh signing: make fmt-merge-msg consider key lifetime

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  6 ++-
 commit.c                         |  6 ++-
 fmt-merge-msg.c                  |  5 +-
 gpg-interface.c                  | 87 ++++++++++++++++++++++++--------
 gpg-interface.h                  | 15 ++++--
 log-tree.c                       | 10 ++--
 t/lib-gpg.sh                     | 19 ++++++-
 t/t4202-log.sh                   | 43 ++++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 54 ++++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
 tag.c                            |  5 +-
 13 files changed, 303 insertions(+), 36 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
-- 
2.31.1

