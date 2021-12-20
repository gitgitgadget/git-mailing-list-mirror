Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED44C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhLTOJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:09:43 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:26598
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230116AbhLTOJm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M22kbPVifcxlGqTGMXR/fTfJDsoj8x3bIZv1VZ1N5U6j28h/I4DRAW+0GYSMUP78Bn1GNpZ5I4odaqvZ4jQNzATaVw/Ua4ATmMzACR2aHaXSkQEbIa4tB/jP2AaTvLRduWPIDut+wV/rlpXMvxS4hZOBSpz5CoqIpeRCM58gcrQo91Vzy4ZhKmXu8qx59/CByObNVryKbLY3ILjsRDl30RL0uHQFYU3uHJTSlgZe6cctqriyst6tIq5xBkfnha7sIw9z8Jon4a10dg8GvsIMhtDfpn3kJyAIHX+sbgWk2c5Q1ulqT18h8tkM7pkk4H3/QAiNtAuPK5cv+ARLUZuBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGlogidtipOnAEmcI1MkIqvuFngh9I/Vmjzaj86l7HU=;
 b=c0GEQV2QRqOeMgtsBqoZ+OFn4+QBmiznaqO74QQRQCwttcSrTBcIc6YIfos9lzF/Q/Tx3GsSFj6xLxhYoYm67GZ4K/C9qMx5sEuZ8kJqI0fukk+3n5WghgYrXKZ4bBINtrNPUKYSYxXQ7rT9XmZ+PW2yxmdQjjpMdYxMRbnvWRFNeHWk0+4Cdl/40NwgZ6Lz1Q9Nb0vCTHei9j/FgyoI31q03dYUADB+3RNmEy3ys6SGft3JFnzhACXHrHU4SyRLStbr8veTIowXp/5X/eMR3yHYs4ZTKSLHQOoyqTTkY5PAZA/H+40+W6E2T1GVQJO5SsT/FLAtnhHNsWYfnHV4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGlogidtipOnAEmcI1MkIqvuFngh9I/Vmjzaj86l7HU=;
 b=rB0SlPIabbrDd3i7MAqXegRxwWb/3ouhXay6kMtN+AozZT1Sn5rJ9xZ0uC92m2GJY+hhcE+AA2mNm2bkE4zwpF0xtJB2hqRU4JxkfnkFZm3QWAn+0fEundx8QwiQ/tf3VWhpRrW2rPLP+UY0HIJ3EJi5QDUxvpTJudE90xWcbf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 14:09:40 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 14:09:40 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 0/2] cryptoSign flag & config
Date:   Mon, 20 Dec 2021 15:09:26 +0100
Message-Id: <20211220140928.1205586-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0379.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c65dbc-ccee-4827-9e71-08d9c3c25cc8
X-MS-TrafficTypeDiagnostic: PR3PR10MB4238:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4238495EADD65839CDD14774B67B9@PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaPFeymHJp9LejJ3jreCL1nhVlDv0JsYqI+ynruEy/OtcVie77VfGO7hz8PkHHjlTCOEQ/nBy7NTFcvKHz9NvTu4+t4XWg+YJlbcCX+B2/8DTzWG6A5k2ibzCL1yXhQjUgRRUX38aMz/P3Hiq091iSUMndXRZvKnLJUJHn+bD/kh1v6grep7jFLJm0uy5Mh/MSwmDyL6ixnL17c4Yebtlgf9icGFkNBPC2tD74C1vWukEOybM38n4KyRuew9RgLdNXVeDHcuFbtaqf1svJ9DjuZ8vYLcjtBB8B9eG8OVDD0jrnrlggwviPc8HtBdQAscRax8thK4hCr5quP+YYcZTb2N/wAI2v+2ZdZqlyT7UkIXV6C8Y/VvHh6m1eBtXC9P2s1bR9Yu+KkWPODMBjzDFEgA1YrEvWOpEkSEKXRZqTO8ar10954r57AIHpHzcS7byoFgHH5re3VX8vKuhdYi5YC0sHb2VuSLlP4U8YAIlGSjsUtMTlTXPZdNgaJ3CKeP14g65Pn0KWQZE+ljjWtPsfSK4s+qCxKMGq4W8uiEkw2V30sArPN0AxBjDUC418ZmftS5kX/RYL5iXlUfM+F1RrurElPLwqANmSRBQoWS/hcQOwep6u3qctcyE/2PqNx8wN5mnVPUDWfLpQx5g2pvpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(136003)(346002)(376002)(396003)(8936002)(508600001)(6666004)(83380400001)(107886003)(8676002)(2616005)(86362001)(316002)(1076003)(54906003)(186003)(6506007)(36756003)(6916009)(6512007)(38100700002)(5660300002)(66476007)(66556008)(6486002)(66946007)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vmy8lB0E79joKnUywWQTuGr+iUhxvlj8V6d7PWYT0JmEbzCMJSJEFWhXeTK+?=
 =?us-ascii?Q?BbQYstEJh8Nl1Etk3otZxdSiEpwYb1vm8VnTmoQnwfp7gShq8326Nnxlg+kv?=
 =?us-ascii?Q?qh0W5kA9e59hgUhoA6i7e51N1/bWmSVRY6cdqbVtuc4Lm0hPQ0Fx5C5i+KQg?=
 =?us-ascii?Q?OnjqN6sByyfdPvaiNcwbpo5S4fe06OxHx91pBibIDMYPo95+ueYvH/LPeoBv?=
 =?us-ascii?Q?VMrekgpjpMk3JT/BzRXh/vOHbeMCDJpogtLPs+EIEi/jI8Svyn1RpoJfiMne?=
 =?us-ascii?Q?tPNNsJxYf/ZdceRJlzGPp9My2pzreES7hcrW1cILnUvXRGdWTEuzQO3pyz1E?=
 =?us-ascii?Q?Pu7RTh9HoqPyrbPvEiFJT3EHf5noR2vlfCoeUQ6XLYxV7+eGtK5oCbFExKBw?=
 =?us-ascii?Q?p8ENshQBue9FR3JlKwWiHbUcuosEcMzjDRdVxPm8/l3vmJS4JfwJ0j87aH0V?=
 =?us-ascii?Q?RUjm+yfJG9+5fM8mYI7TIrpEetC7DRvGz+6BUy61sN75Euc7xp6eJHQBcGG0?=
 =?us-ascii?Q?0ySY00WODyXXzZwlZOx85e6Zhqzh9XgkT2Q/pnX+GMS2i7TfbK8VdBNvfvaK?=
 =?us-ascii?Q?dg2AYrMnFqekuKtfmplUX0481HS7I857WBN3pWap1vodqGyN+lyIa7mUupEw?=
 =?us-ascii?Q?cIzWwqytRnU2KDJnmVfoaM0F9UO2aburn+svZEyMdVexH7igSA61z3PkOOkX?=
 =?us-ascii?Q?80BokHShuaqNJQqO1i7mFjgsLqgK9ornuPFhdgRrtQqPDR9OWSOiYgPMINEd?=
 =?us-ascii?Q?caOxk4Lwe5cAdmpl/wELf851SOx1/qbH5ohDoCUkOQqYW80IZ6lG/RnSnYuI?=
 =?us-ascii?Q?ha1Q4RuvZvroDyG2ZRs9qAFQg1E6ZIknG+Z0LRviz3i8gMG35jp6gE2cB4zK?=
 =?us-ascii?Q?C2W+XK9quOaW1RXcXJEidq0o/G6/Qo0DcKK1ZNIESA++IWmRjB0MJN4qHGSf?=
 =?us-ascii?Q?KUwLduGXMYFdAT3sgllVY/fA07hespkocAivXHvYHQUizRawV7E9/c1zUX5p?=
 =?us-ascii?Q?e5w34jTn8A4Bq9fx5jk1DpeTxsA/y2mbikLrZAYCUm5fPqctg9EyFYQ4SOSU?=
 =?us-ascii?Q?18ql/c9OxzqQ7cS2gjUFX0kk4avY5AXCNUk8M1915SVmqPGRJQhktzs5mhjK?=
 =?us-ascii?Q?t+EwuumtHQ3RzHNyRut9Sqyar9MR7XRB5fu8TGRhRuUzWszYZo+v2lPBdT9T?=
 =?us-ascii?Q?B/fx4XEMT/dBQ+rp8DWJsOQVYglS8hi+rgh5dyfKfwoLIOfNtQamNaNP9oyJ?=
 =?us-ascii?Q?tV4+eCDZfzN8ZZTCX3zWIyNJsA1iUuIsLOv+oK3cWH8op+jAF7fahwFjei0F?=
 =?us-ascii?Q?jCb946jqU4XV2FUtIlQk5RqIL35RNrzvrTJLeke5epANaHV5YDu0whSFKBqu?=
 =?us-ascii?Q?VMcidOeSkljOjj2U9BOsRFNga7zSiNi27z5Ar8wnQHkvfgz9etNcDN5mRhFa?=
 =?us-ascii?Q?PAsHC17CcQS6DEm6UAl3xnVusDwd392Zlqzagwf6Tiiu6GrdqzeTj8O9xh0+?=
 =?us-ascii?Q?uOVJeigCHm3ui9JwPZm3FDRuCve1lO33YFTmqTxkxnOAfc1Zhl/OHPlLUrff?=
 =?us-ascii?Q?FoU67lxotpcgpreRuLjJ/6ODwIG+vgC6FRnhOC577dz0uuXN20Da2IeoiPs/?=
 =?us-ascii?Q?yX7yF5x3MU3dABdFrdwdOZ1ADzY5w9KAlu8xShTcDHAqMwwO8Rc/rQ8gaErb?=
 =?us-ascii?Q?o/gXGBmpl+2zV5LKMNZnkuVCduWkd/YTCT/ZhQmTSJ7V3JPKd9UYHtj0KC28?=
 =?us-ascii?Q?bImrVNQSmg=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c65dbc-ccee-4827-9e71-08d9c3c25cc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 14:09:39.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndq9xRH85VU3soXqEQSap0fidb0TaOT/gXnFLYrH14V+OMsIqpg5JkIIOUSEVpl7u5ivOUfxWoC5C7Ty4AtCEglWNWaJ7MpZQU+lD7a8cvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4238
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git now supports multiple methods for signing objects some of the 
existing flags and configuration variables can be misleading. Especially the 
flags could be understood as selecting a format (--gpg-sign), which they do 
not.

This series introduces the more generic name "cryptoSign". Using just "sign" 
could otherwise be too easily confused with "sign-off".

For now I have only adjusted the gpg-sign flag to a single command and added 
the new configuration prefix and would like to hear some feedback. If we can 
agree on the naming and implementation I will of course adjust all the other 
commands likewise and add some tests for the compatibility layer.
The `(commit|tag|push).gpgsign` var is still on my todo list as well. 

My earlier question to the list (<xmqqzgpn50l6.fsf@gitster.g>) did not 
receive much feedback so i'm sending this rfc patch.

Fabian Stelzer (2):
  crypto sign: add crypto-sign alias flag
  crypto sign: add cryptoSign.* config

 Documentation/config/gpg.txt | 31 ++++++++++++++++++++-----------
 Documentation/git-commit.txt | 15 ++++++++++-----
 builtin/commit.c             |  5 ++++-
 gpg-interface.c              | 30 ++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.33.1

