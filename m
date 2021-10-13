Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B32C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140926103C
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbhJMHxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:53:15 -0400
Received: from mail-am5eur03hn2215.outbound.protection.outlook.com ([52.100.11.215]:61924
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238694AbhJMHxP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 03:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY/5PHztLhEIbOXll4rauetUVLyy9jcoIXXz/AaErgyOkdYxEdpWT2pfzVyxBqC17K3x6Kq5JNCGC2sdjEK/p6V0akBtWta1DziWqSjDxrwxhjE+kXbF0mv+D448jpxe8OEd3KRDZw5By7LIreaJv2iGLV96V10gj3xDYr0g4o1i/bJQN22dmoW9ERWk7Y3m8wXr0kURiCnLlyoY0SrR1z83G6st+1mfORuTTyBTWF2RjegX7I8JBkKYSiuCjF3rUZZ+PfOplMQxvq7mncDwa5LY7ic9e6y5/F8aqeGxqsvBomoLYJALShvjkWGbCeoFCwPAYHfRaSpi3RwIFahBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tveX1HPji/MSCNv92VXNlmTBjXChsH82kN37zDJ4DbU=;
 b=aPY9nJmKe9TaFJLuWzXef9VgjKSyLx9IoX83Xsv3C2vxUcB+ioUqNGuz8FfIYObx6A+9wE2BomEakpN5EkurcrlgoI26UhbNMeDLO93naCz2NYAGaO+T6ykIb90YNB7ag1s8vEXvIS1wJMq0NihhVlfaaJ9IKzcU7LxUBDIQvlA3K7Q0hf75Cg6PohJdirkVbGZDe7piwbmEZkJsuqA1AJZA6Gra2X/clnmwFaCZxhdJejEJxfaVu0quA/Y2kqxGppJTQY8awTXChFdvCEpWfG9TROxWmGJbJ22jee+Y5adLaDb4f0a/JHoZ222OH84dTCUHgrldLUUxDuENOuIEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tveX1HPji/MSCNv92VXNlmTBjXChsH82kN37zDJ4DbU=;
 b=ic4L57XMF3SvwfwktLoFpK7LimkjieVAqtG4IYT0GnT7PX76BBDDlxlpF5g9G+HF4mmLXevF+JrZMfC230p7FxoMMW5HkEqGUgtH/JPUAJ0HX37ZpA0pl9F8ZCPwbU2hlhXUm+Q6MnfoGiAVcN1/+K2BoA8S+V8BGRAp3kvt0Rc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 07:51:10 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:51:10 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 0/2] ssh signing: fix merging signed tags & docs
Date:   Wed, 13 Oct 2021 09:51:05 +0200
Message-Id: <20211013075107.8584-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM7PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM7PR02CA0022.eurprd02.prod.outlook.com (2603:10a6:20b:100::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 13 Oct 2021 07:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 450df94f-b38c-45fe-06fc-08d98e1e38a4
X-MS-TrafficTypeDiagnostic: PAXPR10MB4813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR10MB4813E54AEDEB336338F1D56EB6B79@PAXPR10MB4813.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N0geutrvCywMtGg6i5wtwJqLRYrJFlLtFF9fK9QDH05y9QT5UedWhWfYvwzn?=
 =?us-ascii?Q?vtR+JCeua/uee12/4tqAggTZ1znCnAmSExrZGa6zyiPLQ1kYeQwmXNWf8MOS?=
 =?us-ascii?Q?y06868qphLGr7lNtOcyGkbd4jekZANZGrU4mldrOnO63LH/cf4nSOY5MaXAX?=
 =?us-ascii?Q?y1QXGJXR6FCq8AZlFkBxzBaebLXrjlhugRu/tupcjX1Wx96hhBgbOefVC5V4?=
 =?us-ascii?Q?thrTb50bysg4goux4FfERUimnXSr3/61+43xliF6o0HJDFChDZ0DX2gGMpFB?=
 =?us-ascii?Q?+eJbQ2yRvBAALtGoR6AIIzRH4c00LXty1Tg4R7al/6hbic+yVGYT1l/l/4pE?=
 =?us-ascii?Q?DpewUPHLr00vAhGHvDcOUbyy/ssB8yBzzsaYrtudelWSXXD8i+QuBTU4YU3c?=
 =?us-ascii?Q?oOpBwEIY0sIT6pmv4NSn8xFHUBMt+vToXyh1HqoR6QcYg26OaID4GaMxVxot?=
 =?us-ascii?Q?ix0KMHFg+9kGRaF777J71ELkxF9deFmqrFP0ef50dj+klwx7N+aWBdTskaAk?=
 =?us-ascii?Q?r042giThpQOZElkTb5c8dc7DshaCKNpq/oA49Ncggu3ongGWQGLFdm8QIf2P?=
 =?us-ascii?Q?ujFUAc4zGHsjQm6JyJwDEpfSFp2jkRoyb0dujsvYd0nKcbbIx9WvJpmYLVVM?=
 =?us-ascii?Q?QMHSBs5crZJiHhdl1ObFbdgxqNoO7UeQXDM7LAJq0q5rFkgukLVyBWkg8xfV?=
 =?us-ascii?Q?Z3b3XNR1XICL/Aiw6XvSVNs4ejsS3m2NVJfDBrGq0Rn2Hjq82fYfTKlBBxtT?=
 =?us-ascii?Q?WL6HQBmbpDOMzlT/ZQwGySKVwyD3U/1Sjtex86THCzb/NqpT2z/2IBx9NYaZ?=
 =?us-ascii?Q?9fgcaP7wKQQDngUo1i3WJyDmp5pvaSg9pUq7fIRMl3HV7r5pM3K9NvBYumq8?=
 =?us-ascii?Q?f8oa7ug9s79DiibnW8locIM2aEWcmOBVotMYlUoGzFFLNG3sfcXFHfEl/gck?=
 =?us-ascii?Q?HNck7RXjjRwnDHz7AR72P370rvOeeOc6katjaI3rxvxAGGcJRufcdZJY5KgY?=
 =?us-ascii?Q?RU3AnONfg7txjKYinMzSZVE93g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(396003)(39840400004)(366004)(66556008)(5660300002)(66476007)(66946007)(8936002)(6486002)(8676002)(6666004)(316002)(508600001)(2906002)(6496006)(52116002)(1076003)(36756003)(107886003)(4744005)(38100700002)(83380400001)(186003)(6916009)(4326008)(2616005)(86362001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLJfxXM5xRcVyDNqKI95nJv3nHpIXeNXtFsH7xVoTnYvYN5UR1Y/pGwHpLx0?=
 =?us-ascii?Q?vyb2WGZBTuAFlBD4/ffvouy82YXXZOU6wPUW+SJs4tuxOa8mA2Gg5QQEZo6T?=
 =?us-ascii?Q?D3ki9HBSBkseUhRrp8gdG/dfXmquuAXvn2IRwIa3RXYM1ScNFd776LEK5AUJ?=
 =?us-ascii?Q?WQ6Pw+1kLjnoRUVVj3SN9egmpp3xZtz+niB3CoQqdJowgzTdrOM8n8+UEmBi?=
 =?us-ascii?Q?WwukUJsqX2USP8a1wPr3GgP9JlhxpC/mHf+Uvh54V8Ll1WxOR/v3uqQadroG?=
 =?us-ascii?Q?B7qqWjKgDzPmZEmF7z2IsjNcQEWihI0iyKYw4lWqrsP9tJiFvhTQPMnMVjmB?=
 =?us-ascii?Q?ZyNr71VQAqS/JZbQ5ON36R7hclA0iGlVRSY8pHPe8O3e6Gj9nqwc0tlurpk8?=
 =?us-ascii?Q?exeVgx30v7We3+9zPNh0DC0/xUxmnUrx3+7dc9Mj8Ocaq2z07pUcJLA7L/wG?=
 =?us-ascii?Q?7AMtflKom7k3SMom6bhsLwhE8tZAbofCXsQ0CKdELDa3Xni2iszxGLMdGuuW?=
 =?us-ascii?Q?GVF770I671X9el885CAXUAE6/OSEQtC5Hf2DMbDxa7i7y3EIUdXdLt4tnKEg?=
 =?us-ascii?Q?koIODHcONFwg+T7rX662sGjFIlnqQSMfelxrYMf55dfAk+TtIVh9S2lJIowA?=
 =?us-ascii?Q?1Y0Kj9fx/FKWCDoIS+pX3g066gcq1gi+CbmLqRfkC9U77zhCD6pl8GuSoevf?=
 =?us-ascii?Q?//lbaS0qXwweh36dbINRMoMpGDA3W52EpD43AMOTysSmeph9ouNMWhQ61t6D?=
 =?us-ascii?Q?G7nEYJk80+e5Q4222X3RHFt6mo6wVbroAdkRfQZlXonUvJ29QbtAFCsmtYZi?=
 =?us-ascii?Q?JagpKNgHJRw+18DOCWuPR7fLC/n1qLIytL1GGj3NypR8lWHOfGzAktr0CcXf?=
 =?us-ascii?Q?Oh6PakwBWXEsf+KxHZ5tUNWfHrtQPPxFtSmWAzXoe/tj5l7VK3zwWkxiJ1sT?=
 =?us-ascii?Q?U1smlxg2I//d5ORrCVldcaeqeKUiX8IntiQ3MGTbM0icMK2BLPUkpd5Qc29/?=
 =?us-ascii?Q?SrHN6T9D4TcoJnJ6Be3EREf2/Agrai+G544bnYPyCslENFOD3rF3RoNeMVq6?=
 =?us-ascii?Q?tsSBhCh3UOth2NdUiYsUnmAGkJodVs/gsePBvH9KR0gr56occxG3OwcIZqtO?=
 =?us-ascii?Q?XQgo7IZuL1b7GAgAzs2gJ/BVcAmfNK7n3HU8drpp2VrhUG0QvNeqtZtgO4NH?=
 =?us-ascii?Q?6kKUUMXS6Af4nUi24V1kPdqqQp9fXKtr6RHwmgeWYNSqVa2ho/KfPyDjHo+T?=
 =?us-ascii?Q?HmxqYmqWi9mzGHu42GUfd+lbsVI11EiCIkj2l8dFiqeZRmxuL+h3eZkEBpnb?=
 =?us-ascii?Q?wsQi1n6CUlX/26DKZCd3H8Vva1evV3wj+IJ/LF9sRDv9tS/NNhe6iSB/94/g?=
 =?us-ascii?Q?ryuFavkTDWpsaNJjrbUwG6BXbFaL?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 450df94f-b38c-45fe-06fc-08d98e1e38a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:51:10.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwBBGFLrjfBykguVdty41g9BSyggeEenrz6YiuO+Yk9sH7iTVk3nCg72qBRUbccGAsxTPWLwfD7zirUVjmJafD0mbWQaEN+ZCD/0jyiMV2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4813
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two small follow up patches on top of 1bfb57f642d. fmt-merge-msg needs
to load gpg config to be able to verify merged tags. load it and add
some tests. And i forgot to adjust the docs when we changed some
behaviour of the original patch during review.

Sorry for sending this after the merge to next. I didn't want to send a
full reroll of the big patch series for these small changes. Should i
do that next time or can/should i send these to the list as single
patches on top of my existing patch series? I used gitgitgadget for the
series and i'm not sure how sth like this would work with it (if it does
at all).

Fabian Stelzer (2):
  ssh signing: fmt-merge-msg tests & config parse
  ssh signing: clarify trustlevel usage in docs

 Documentation/config/gpg.txt |  4 +---
 fmt-merge-msg.c              |  6 ++++++
 t/t6200-fmt-merge-msg.sh     | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.31.1

