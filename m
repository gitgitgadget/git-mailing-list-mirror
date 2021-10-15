Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32DCC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C285A61151
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJONRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:18 -0400
Received: from mail-cy1gcc01bn2023.outbound.protection.outlook.com ([52.100.19.23]:25729
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229546AbhJONRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv3pniSuEh/1rxx40HwNiF/ef6jXDENOt35j9Ca6vurej8ykMJO31J+1KaxE88SJBqYnSjMweXj8Y+58i5MwzXayeo/rhGH41+KQWyeLuxKvhRGJTjbOmswJu8jYBaBi69wJT5fGBNOVZePUQ1Bus65Yqc3pjWoXAqem4cbgT9RY1f0ZKHlCCUPAZFPMM61GcozMC4zuezSHYhL8YwJYiln/jqxIdyNRH8lUOw3pWa04aLs9LpeN3c+d+8qnR2ePcU5ZqwCYEBOS2x56+LWPtKfposJ9gE6hA86YgISyR7RAMrgVJGe1A7DVGU2mqvjhWEYNGn3ejrjKTcfnuh6AyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgPHtMJC8YGRHw8mOOlv8nb0vkTt2s2B0zYG2wIEKR8=;
 b=lvGLNhMcOnz1QqMrlwjZ/gWv25A1bynVvYST+K/lvZ2cyve1PvKTD5iHzX2BuXE+t6TQ2I0GW1hf3zAzGfoCv8DpmgPZVqWq+/gFIQ+DjeCysytPmZzPrcTpHgaBKS67WnpWKOHafR9qIsMIFy9NTyHRJ7FMW0OjqHyrkHk/NyBAvd6ofMnbC9QDqkf4KDPkDbNMn3VFNVWjC51FAnsjG2MX+kqgaxa5Ngs9OjS156yh9C5EL8TnHh4mK/XPI9WPQpu4IvpCfVySjMKhGdQ6Vce8g49qJiFNf0umUgjX0GCR0ZKc2qlVgRqQXDh5IULbxPW/ZNE9hpYH2Tnbzsa+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgPHtMJC8YGRHw8mOOlv8nb0vkTt2s2B0zYG2wIEKR8=;
 b=AQjCmTs6umCuS5KPVsib+z9cnmVIAz7/dcHMHVPEbjiW1McIjQiNZNShASA5gJvqOiSk4vEJlSXAXeo8MnVFJ9trvfoGd35tUi7U3Yw4aeEOr0wfxcdNybhqsTpot7huFtRD9+6gR+tSy3BczRvLyffhNTxWd1OiGCh7pLdel8E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:08 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:09 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 0/6] ssh signing: verify key lifetime
Date:   Fri, 15 Oct 2021 15:15:01 +0200
Message-Id: <20211015131507.1773153-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0064.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::41) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0064.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 13:15:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be143d15-856b-40af-8e68-08d98fddcffa
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB4046AF1707DFCC8CC5E243E1B6B99@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ckNt8PZql2fFgjxa0lYAX+H8GSJTwY7igxdb+0t8GoM3uftiOKceQB4imgI4?=
 =?us-ascii?Q?qdkXZHvFzLCF9Xf4rtYW1Zmc/Cj213p4sB+CGXjyYtJGm/Hc5xhnG/NSxWb1?=
 =?us-ascii?Q?cc/b3pc4m50CXmUewF5LasZve7fA+9G8X3TsNpFab2f+zDVt8fSH7TyhKwPz?=
 =?us-ascii?Q?2ULjoKhLRsY7JjW35K4+eim0t0At8hLRp19ynSuY3Rc+NLm8s7AjwZ9b3/Qp?=
 =?us-ascii?Q?eECNW+vJDIKNM/76c4vsRFDu0wm+ivFxjTk9p8t0SZkvfr9CyTCpp16zu9Yd?=
 =?us-ascii?Q?MmdFtZPgW+JDryUGv7yQ+u5XiEDaUMGMpYW227fga6VEkY+uXjgDTDdZX9vt?=
 =?us-ascii?Q?coQmS8kfMyG5tII3Hugrj5AoKnFjwapBYH+t8X0Mqhj487QgrpXZC9LYpD1a?=
 =?us-ascii?Q?VAR6PXGYhu6GQv6xvNFE6WRvnwekFd5PJHEfiuzjWn9UdfUYM/p26ha+Qseq?=
 =?us-ascii?Q?o/dPCqqpCz1Zuc0SUM1TLyDpEq5gOC5BsTb93bBP6x1IQqckqTJiO6OBO7YX?=
 =?us-ascii?Q?Mgy1tkHNsBFQddvn6Ab5Sy7/hDy26s2fvdR64jbJkMAMQYzCjqHp9UStzoWD?=
 =?us-ascii?Q?sqPOBoc3Fj6BOnW1cgRkJMocThWsPC6urvSTmHWF8VKSTTcL2QvmUVsGsXMI?=
 =?us-ascii?Q?m7OdYN8b6OVicGkXC/nW9np7AJCnqIQrIBJojFEmobMsvhIRcuW3ky5HfZ6F?=
 =?us-ascii?Q?DRr9bP6E/h28TEDbDE/+LO2KOBoVQiSF5sUZHW81iOJOHO1Vguc/liKCdfgt?=
 =?us-ascii?Q?agVKUWtlsZDVmN6GoZREgAJjJQB9pgL4prF0VUKg7M+OwxUOq/DhEJkxGsEf?=
 =?us-ascii?Q?EWljB6t90DBVCKtjArvIfT6hA/MRxFncnagjj/8iSUOQawrI2Iup83CbPYj6?=
 =?us-ascii?Q?XpFCUIapQdP6q1foEmszNxvTEGKp8mfVuAgJtcYYyICG8/AEz+/B/Qrqj1o/?=
 =?us-ascii?Q?+KKaA8tMAiSRFfeA+AqWj2G/3lWWnpNlCf7/ZWEK7UNJYat9C2jSkSVBUCnL?=
 =?us-ascii?Q?7c9vKVcgq/vK0bN+f3WVMsaxzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(107886003)(36756003)(2906002)(1076003)(83380400001)(6916009)(316002)(4326008)(38100700002)(6496006)(8676002)(2616005)(5660300002)(66556008)(66476007)(66946007)(15650500001)(86362001)(8936002)(186003)(52116002)(6666004)(508600001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zy5i3noPF8EyrOum5/1+VthsFA1zNkFCg/gpwX0kXCJngmMrYdkbP7MkHRUX?=
 =?us-ascii?Q?iyPlGFXUpD3kaWesfJXuIj/dtmXtHqwpLPx4O+rI8IW6t9kBIm+FKWjex9uS?=
 =?us-ascii?Q?p9Sq/F8ad54mM91+2YvQHzYCkFCDEoNm63n8fTAfikkJADsKKmJILEDEyGTM?=
 =?us-ascii?Q?Kunh9IDuLCGFnZTCIh3Th+xf10z4DOmJruv15Flydidb9PfklXX4C4Js8U3G?=
 =?us-ascii?Q?uzAFRiQAZ7Z/DT4SDfS4rTkVZ6dDVwBTlppVG0gk179U2ntLmHv7B95RhWK4?=
 =?us-ascii?Q?V+b1OA6TVEp7GAV+UPESouJd8d6NQtsc9h8AN7xRtYQUPkZun0EuU9Sv4Fb3?=
 =?us-ascii?Q?eOEvTqOe4RYoCe0OjiUWIrcuW4zTLnAaFiLqlHpUtzREU67+08x+TGM7ug/W?=
 =?us-ascii?Q?9mInePO/j/eRfFUsR3JYFXauUWnElHJYFkx70Bq0m2jc2ssv57XLVmigM0nx?=
 =?us-ascii?Q?x3f50PLwviLn+HifDLgIfVBnCZrwGMCPznQn5KGImhzTcwZSZGpl1Gf112yu?=
 =?us-ascii?Q?xz3B4cK21cRDGHzvbdbK4rHynOWTAvNiD9Lt4w6DB9bJ5Zk+tPhPLoT56TbB?=
 =?us-ascii?Q?2VU6G7ZYqRC+/eJpYCyOxhM4RkOnWdi7uErhyk401OCQjQ9Rdh+YxDde+sTq?=
 =?us-ascii?Q?UIY/TOrQt2LE97hKODoiVA8IXPkur++mPwRBKnpX2tpG1P1Wq8jsAmji/loB?=
 =?us-ascii?Q?xqfzWMLyhoLA8Dh24u9Mkx/THslufFVZnmT9CQ3B0oyEfDbRMgh4SuoARhYQ?=
 =?us-ascii?Q?iG4lB40RzQRP10vr7pUO88XPeQT5iYFqw1rHEaCvlzwzD94nowpD3nae02aj?=
 =?us-ascii?Q?0VytbppNIIDLPVEvGTu/FdLMOxK4D6tTtaaURN47VTplo4YezOe5G5eA2EBZ?=
 =?us-ascii?Q?hhgHojA+UkBJ0yL17SfxJ0OQtHSbHbeWmWULL/nVjUAzerm1RosHCM1Sjbsq?=
 =?us-ascii?Q?A7mNvMuVkycBgBKEXceglCAXxHK/fHd4ejSdjG9CjBF5MPlvAQCltLCiS89q?=
 =?us-ascii?Q?W0ME4jzA7jA5Ga0+CZVYqMOljHOyUBOfSaOF5z3h1IbANM8QiuxPUCxHcIWN?=
 =?us-ascii?Q?FJmw8Hj70QUOJQHYz2nbuPwClitSoX1tbOBudfvdzZyGRWDIQn/dr8sUvSun?=
 =?us-ascii?Q?/g7wOj6fg7Ob+SZld3JaS9NjgqAJdJ9MugBsW4bB+oNYxK8F7rluZup8vGjW?=
 =?us-ascii?Q?Sc0vrihSMzjUpqD/zWU2FLhIse5k1J0z0be4pI8T4o5GZKGQ2S1PSFlHqZXg?=
 =?us-ascii?Q?HWZKJl8P6g7/BTFQW6Yw882HRoGYJDbCZ5fXIdeJ+vTmzFIKCsWmvozEKqt+?=
 =?us-ascii?Q?sXPxDJkZtv1Fp96WClI8OHyDtgXc2O+NCeFpDvTt6y2/SaEw7SH5i+BVr6XE?=
 =?us-ascii?Q?kPu60SUH3FvsvpTNP3vq904FRYz/?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be143d15-856b-40af-8e68-08d98fddcffa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:09.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXnlZREaIc/DLrjVQ/5BX17PsqxUpcwG/NmpF9RjM4VRgB7GJSNZwTsp6VwRkpWYgVQgLDTyBHFggQaKCKHR2f6NHZYASDuyvkxQ8m/xhWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds key lifetime validity checks by passing commit/tag
dates to the check operaion. The whole series is functional and has
tests. I'm sending this as an RFC since i'm unsure about the way i'm
parsing payload info via parse_signed_buffer_metadata().
payload was just an opaque buffer before. Now gpg-interface actually
looks at it (thats wy i used a seperate api function for it and did not
hide it in check_signature).

A cleaner approach would maybe be introducing a check_object_signature
which takes a struct object instead of the payload directly to avoid the
parse function altogether. However only some call sites already have
this struct. Tags & fmt-merge-msg use different ways to produce the
payload and i'm not sure how involved its creation would be or what
side-effects this could have(performance?). Since the push-certs use case
will never produce a object struct we would still have to keep the
existing check_signature function anyway.
The now used parse function also opens the usage up to sites already having
both infos (date & ident), although there is currently none.

Fabian Stelzer (6):
  ssh signing: extend check_signature to accept payload metadata
  ssh signing: add key lifetime test prereqs
  ssh signing: verify-commit/check_signature with commit date
  ssh signing: git log/check_signature with commit date
  ssh signing: verify-tag/check_signature with tag date
  ssh signing: fmt-merge-msg/check_signature with tag date

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  5 +-
 commit.c                         | 12 ++++-
 fmt-merge-msg.c                  | 16 +++++--
 gpg-interface.c                  | 80 ++++++++++++++++++++++++++------
 gpg-interface.h                  |  9 ++++
 log-tree.c                       | 23 +++++++--
 t/lib-gpg.sh                     | 19 +++++++-
 t/t4202-log.sh                   | 43 +++++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 54 +++++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++++
 tag.c                            | 12 ++++-
 13 files changed, 334 insertions(+), 28 deletions(-)


base-commit: 33379063c9546476a80d42c704efc4ea5d0d95e5
-- 
2.31.1

