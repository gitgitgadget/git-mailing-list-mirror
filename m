Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC4EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiCDK0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiCDK0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:26:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A05194ABC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:25:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGX8r7Fmypc7zy7lJwFcZg/gK7LOlBmVd4POi+dHAS/A2DLeyhhF7j34XnbY03qZ2TO/9TnGLO7ENusN35yHQwqbs3jtyCrWRyVDNyw7QDoP8i5DVeUjkBi1zTHO67eToy+NwmHvVsxaeEZtUmEtwnPzCzi8IAxWRDvRVtZoIkVcCM1B9YaoDgj2n/B6PjySG3f462AyXBTubPQAKF4ePmW8vHc6sJVGf2E2aIg+SnMBmSrIOxA5/o8nIHjx0nsA6hVkiPQgNSYljaeUxRMBVpYDOUPaQ83hWTNJzFIVKYQEr5cGfruwPgwDiguDpvCvx+QpH1mBBZZHVt9icOwM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVSdiDXFIjMdIFa7p7N/jLr0vnjb76Jgq9wuTkoF8yI=;
 b=OcyFT/vbkwIcJvc1Lm8SbgBUNWP9VShOJ8Wxlci6xvrPQO8jmViCC04JwNz7XGMBGixtFpDeBzk5UKRkb2mFXz4dcW3y4qf+rXjV4/Kf/aQltqPxWhXhAohZJE8ycZC9jpQ+FivRe6P2iVX0r9hRlyjVi7DDHWvY42EPTGjJPope8ch40AvDP77lY+OiuDfFZ8HpWDtefFnTpX2fIUW3A0DWivfjqrfepxUA+nSB4yYDUR68r8lMabjaz/XEckMT6eqaT46eVPYhtRgvpSCmMKwDloW9nTyPlwGl3vbax2FUX2XT0Hmr0SAXABBU99pykmrbhB8Rzy+df9HSuiPEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVSdiDXFIjMdIFa7p7N/jLr0vnjb76Jgq9wuTkoF8yI=;
 b=u53JnH30Vnr3OCJGB03lvzdW5zHBoKhDZFwWnYRtsaeM84yrB1Ozy1J1YUhvGKHp8HInyqGWmrsrFXDK0BiaXYMgmmPncKnrCr9lSXN3xcrjyCfZqDSPun5jIODf2/4r92/dq0eHD0e5c45wqvJT8L64rclb/jkY0gUmBzrCj9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB8PR10MB2572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 10:25:24 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 10:25:24 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/3] t/lib-gpg: kill all gpg components, not just gpg-agent
Date:   Fri,  4 Mar 2022 11:25:19 +0100
Message-Id: <20220304102519.623896-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302090250.590450-1-fs@gigacodes.de>
References: <20220302090250.590450-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:203:2::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05246ad2-e341-4105-bdf9-08d9fdc94b20
X-MS-TrafficTypeDiagnostic: DB8PR10MB2572:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB2572AB3F1F20C5898857169FB6059@DB8PR10MB2572.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdmEe0YIGQM3fmXffoTw3Y2oWc0MmnNTPYRYE+vI3rgjGZUsLnPu7UbK41/VCeCD1qgSCpC1frsmL52xkBUABa4mq0JMpKVOwGPCRfm9RNtOJjZCRv3xUkjFykeLPSBPpJfaduTmr+oA3wIU4BPZT/Mw8EzdReDV0Zk1pMvEnsxOZCBMzcovpBOS8D6mNhgO5pzHQJBmr5+HelcRMn0fuvSAH4bZZolUXnoTCFmrCvWAje95/12P4jrhY0/XFMvj837DDk2Ej7AliYgER/EAMEfDMWGmFsSGr7yegMxZZ3WzVHAs8aqk96ipQXcaGQcbCPB7iJJxMDlC5G6cFli02uyoYQaGZLbIg3lu7798Ss6Rx9z8kQuMUSyZpfd41FvF9mXkmxsuu2C2kjaXDQO2lc/iR6LmpjNAnsQiiC7jB/rwkpZLJMvuzdhGqg9Zrk1UYHvIrWZhn9V+cJ12QNlooNWfoVnDstw7d4m5WaN1O+82iE79VP2kNBqNr1tBLGUK2dOZon14cBSUb8NLfyL0y+A6stjggDJPyNaGGNtwMsB+3CKzG6K3vX68zvqLBeJ1W54daggA5bc1XK1f5ZoB3gJhCc47GfdKD20ws/SF41sOyse6Jg68MV+rMcyOggPyLvuvNzvpT5KU4ctbeTwJvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(376002)(366004)(39830400003)(346002)(396003)(2616005)(1076003)(86362001)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(8676002)(36756003)(186003)(26005)(38100700002)(83380400001)(54906003)(508600001)(5660300002)(6506007)(6486002)(6512007)(6666004)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjMa1wRzrOlqccyvMScbRtFm0WZxBqFB92K9EIa0N4xNvsp29fDIh9ByyOX8?=
 =?us-ascii?Q?x7hud2/BKjgGCMBCgS/2kzTNYdWLr8mKm8mIqKt3vBQAEeXMbX9WHoDvZCPs?=
 =?us-ascii?Q?ckeX7i9AJhU4qWre3QvozF6NS4eU9/2PweY4RoMBG9hPUI45vh5kDQuXWEF5?=
 =?us-ascii?Q?tsFP/zo73/C9ZYGfDfVAbFg2gd5iaNzKCcvXTB/XoADIfmW5cpG7C486ajuB?=
 =?us-ascii?Q?bt16uuo01lq5eSw7RfXRzWNDjegYjSL8RdMNwcqrk9/qWnIw0F6yqfcaUOf5?=
 =?us-ascii?Q?btOjbRdQxHhPi80CA7kTdALO4Z4cXn1RNPhQcrcPe4CO1z/8Xt3NqQtExBxs?=
 =?us-ascii?Q?QFOIf1sAHCk62MSqk5KG76d6pIUKTNsM9PdvCske7YVqwK7AzSt6ZEfT1Y+R?=
 =?us-ascii?Q?I+bK/mYE2wkwNDEl92wgMINa2r+GxMXz7PC5hZ5zXdLfyryjXclv4IYVaVZn?=
 =?us-ascii?Q?J7DP8/dyLWO/sLI2KXqWjS+CsRv2YTWi/P8vPlINbA7+/cKcjOYTjK8S+IiK?=
 =?us-ascii?Q?9/2wEjqawyLnC1xFrxtfXRdheGfYPk2VHHlOU3LbTnPlrqvoG+j56eeb9Cd0?=
 =?us-ascii?Q?PqKPbylDVP4HUGXeZSjjMLviYGBzzsqXqwS4JysXaVEIyGhqgJQ3BPCvonFF?=
 =?us-ascii?Q?gORkKlpiQ6ZAgTKpWJmXnhWi0mOE4mQJLOmvmhdjS8W7CuFI9/jVOHdRAQST?=
 =?us-ascii?Q?hIkXqK2ub7bMImc9WSHrbSlsDfv0hJ71UEmbTbv9aB5308dSf/oIQrewAp7Z?=
 =?us-ascii?Q?RDVxoP5xsV/ZDzzXgbbWvFFWGCZJw5WxgjRieYv+1VOj/mAT2HzsTJim7/Wp?=
 =?us-ascii?Q?geNu1rULTm46ugCsaB6V2FiMK1XmJbhgd1FjpIdg7w2aaTOp01Ihz5EpmWQu?=
 =?us-ascii?Q?8cPyJ97HlhG5yOQD2yGuAzj9GRzCrvsZLhB1yM+4YkHdczmJCUWM7WuoikKu?=
 =?us-ascii?Q?xOza1D7jlZSTlrSZbCUUPQmqF6Qh8EMtPBAtdrEzhqDYx8arho2sf2ld3NV1?=
 =?us-ascii?Q?NQeSClJiQKv/T5aFbl1Afl7R190+WL36JDu8aUiNZaTDIz9RUCHomKshfwLA?=
 =?us-ascii?Q?JeuSWMUaGtUmQZi6jAINTfYPrOQxFCEi2j4Jzih/OS4kkPoQWV51/j46cpd1?=
 =?us-ascii?Q?vAupDsKJYS/UeKTzl+Bq6OpG6jtDqQb6f4W0OzBZ1FkyJ3cWD1zVxLixTToA?=
 =?us-ascii?Q?19lEF3ykxzqDAeTIRnSc1VvBiuUHrmtPxAVJ+F+OXrnlmsLmZro37aBsCbMn?=
 =?us-ascii?Q?xpG69PxfdqVebVHE1LIiTGOflaQvS3Eurtntu95Sz+DBKgyK1CqUVQk58LI5?=
 =?us-ascii?Q?5mZ2lwVYCRiw6z0/QLoUUnSLhKJEnQSrMDjMMV5UgoxWTxWeLGij/o85VlvD?=
 =?us-ascii?Q?NbVlCeBUXt359G2//RTL9O9Uf6JzABWTgxGbeHcqS0fmyfyqFKBisWPcN0Wt?=
 =?us-ascii?Q?94mRvPSXWSnm1YCW/NwixkwXfUhVq1EOkLzxRZoRR8UUz0hFrvVY6RVnPQG9?=
 =?us-ascii?Q?RadODjy/3qrwJRoOYqkbM8Lwwcd9+B+Rgu9NQIAJ7dzjfrPJg9aJ3r8Wb6FX?=
 =?us-ascii?Q?vkSWYQuFd4ZB3KGXdv+FwK9MUDKXrdtz/nmuYupx/rGdxiM2VAAkL7DFAu/P?=
 =?us-ascii?Q?JivlCo+HA91ZjtbvVRcL5/auPJIVW1kRIgpGiwkJPSPsymC6/qj2WnG4WWRA?=
 =?us-ascii?Q?rTHFckNfdeEgJeGipHuCAtJQcLY=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 05246ad2-e341-4105-bdf9-08d9fdc94b20
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:25:24.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLqg/DhclFlXiXwQaV6Tg26rD6h9gvrw9vT6AMRWRpbgVtCt6/LOL9//9l99THa+oTJ3+ssN1UB9+R/LhelWRJ5tkJxDR85EHoMSHufBM3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2572
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Todd Zullinger <tmz@pobox.com>

The gpg-agent is one of several processes that newer releases of GnuPG
start automatically.  Issue a kill to each of them to ensure they do not
affect separate tests.  (Yes, the separate GNUPGHOME should do that
already. If we find that is case, we could drop the --kill entirely.)

In terms of compatibility, the 'all' keyword was added to the --kill &
--reload options in GnuPG 2.1.18.  Debian and RHEL are often used as
indicators of how a change might affect older systems we often try to
support.

    - Debian Strech (old old stable), which has limited security support
      until June 2022, has GnuPG 2.1.18 (or 2.2.x in backports).

    - CentOS/RHEL 7, which is supported until June 2024, has GnuPG
      2.0.22, which lacks the --kill option, so the change won't have
      any impact.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 38e2c0f4fb..114785586a 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -40,7 +40,7 @@ test_lazy_prereq GPG '
 		#		> lib-gpg/ownertrust
 		mkdir "$GNUPGHOME" &&
 		chmod 0700 "$GNUPGHOME" &&
-		(gpgconf --kill gpg-agent || : ) &&
+		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
-- 
2.35.1

