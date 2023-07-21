Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27570EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGUQjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGUQig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:38:36 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn20822.outbound.protection.outlook.com [IPv6:2a01:111:f403:7004::822])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372449C0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8GpaK85ZlY1sltygO484ePYgbtCBgfC9fO8aikb5av/tH/XWyM+Eb6PylXyD4kKusiYzAtopoP7G0qe9d7MhRhcEPa/tA3nZGP0kQSy7blAZbkbEEgnoZiqzCMdLvQgTzKhKyB3ZFgUCiLk0gQVdOf2WRoz9Y2nOyXxf50EMitmYJzBZedICp2eTgfIlIMuoOMHLbmrwCHGKhNe0EjAarhPOgZtmRZiahrw7TjlX677Ba+NPYmnuP7q8JaOOE54txlBktXosYYgT4uXBrfiHhjT7aY3i8BhcJL5AP8qSq9vpZlB5grNFQFhLzoOfr6yZm7+0ipflDgl6EDbcW5BNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f37/7vrHVNSuYO6R9ZnQT/OQtus5vhEwln5RJJhDLc=;
 b=NXCsigcomz3x/WCMntpN2V5M04tWiSgW395BIrBNtL1pEUURhspo4A9D5uCeF6FpH5rc3+ncL1ZryzhMPvA4lfeLy3cE/LkaSn9NSn9kU0mw2UdVJ9YVmbVnveaxwhkvCavblYvxepsFIsRnBlzEt7twvKacPa2F9lmRuOvt7WiEEYjizVRVxesGoIJGU4BD4yNrux3iDuMFLORAFXRQUzLGEYhYL9CrDkeEfCvQgvJ9JEX64/vMQxU0eMjXEKc1Sy/y45dot7oc7t4U65l7dA/mmXM7lNa1WnZR2AYk7Ny/2R8mVeMCgnYjvd/btAwVFUkAmNDRZPdGrejnOpz+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f37/7vrHVNSuYO6R9ZnQT/OQtus5vhEwln5RJJhDLc=;
 b=fEEN1hU1I5UPhEUj54YAN77PZAVQmRJTkpsFKtyzgo2Q9yVBQZSrVtc7Shjbf0BZ5d7g9+nkBa/PjmsdDilhn/VAXtY4eBOBM7+09hGAI/w7a3qEWI7ATTugloqrulGqvyflExwGZgvUyraz+4f3wd+VArKqHODPoI6TSNBcr9lb79C8oVZrqfBMJ2sATk5S4owXOcDx5lSg8Fk8cn/VXPgFOp8KydX/sI6PZYPIstFhzxfpzaWqfGbjyJvqGh0biuoLpJjQgfDZXHlJOG7Ox+RBYl5rfGuqFHsMmDDHA6qK3a1UgE4rSF3/8fLlbUGjXHZw3kxNC5MT9EC9AWcEDA==
Received: from ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:eb::14)
 by MEYP282MB1704.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 16:36:43 +0000
Received: from ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 ([fe80::569a:9ef7:3338:79c1]) by ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 ([fe80::569a:9ef7:3338:79c1%2]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:36:42 +0000
From:   Qixing ksyx Xue <qixingxue@outlook.com>
To:     qixingxue@outlook.com, git-git@nodmarc.danielabrecht.ch
Cc:     git@vger.kernel.org
Subject: [PATCH] gitweb: wrong capture group used for grep search
Date:   Fri, 21 Jul 2023 12:36:04 -0400
Message-ID: <ME2P282MB2242E63AC1A1AC91E29BF935B43FA@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <ME2P282MB224200468AFBBBD4534ED1F7B453A@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
References: <ME2P282MB224200468AFBBBD4534ED1F7B453A@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wEwGaKzfOTn/8HeeYc+5vczf4RkL7BXSU38KIlk4T4iqVPQAf/X0ZdvOTpTQblcV]
X-ClientProxiedBy: BN9PR03CA0399.namprd03.prod.outlook.com
 (2603:10b6:408:111::14) To ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:eb::14)
X-Microsoft-Original-Message-ID: <20230721163604.992-1-qixingxue@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME2P282MB2242:EE_|MEYP282MB1704:EE_
X-MS-Office365-Filtering-Correlation-Id: da420f8a-b360-4286-9c45-08db8a08aa31
X-MS-Exchange-SLBlob-MailProps: PHS9e/w+tWJZbMcpFft5pHT6emI0pGMtWQ14tPB2D23woJerU9oQxt8GnKFw+RnyxJHIA5LXs7fF5Bw6VwIBFDMIYz+do7Ty6zAGH9E1Z+KjI88QEBUmHLAwWIGlTkVnFvhBmohZUbzMiAf/eLizoYXVgGbBzxGvBgii9AyAGpxZlJYTcCBYFEeOkBEouIpbyPNYjTgnObzvHNZr53uwgrBbtkwPoLSJDXbQcKJIESGkNCwXVcF4Exfv22I4RcFjid2hhoPTOEn4kyNzkbCsfaDmM1MH94/c+CFk4TXdn+0TSks9sCuED67jFHcEzRAilpHvBWpuR57zK+JrCjJOFIg82D4Yi/qgnYz3I4OFGiggQyAO0MhRv1MAME/P7pqkFBn3wjjl1/gWy51KVKFwtQVqOSohN2W7/TfoBN01CfWfGFbUP6Nzcybxozif4KUYg8nxHE2uyXMWmT5k0CBaPz+GIAeaMcYffPx52rh6xV623vtCuowfzsZVbL7TBkrlFQ+grnnSX1k31/3zFb3fKN/1Fk5oTJDtni313tPjkqUa+JNKRSzxW2eiVj8eejFdZkolGsB/qFoOXZxzRzZa4C+QPuTHHT9p2b6MV3ygdeM5daL/NAy5nH5rj6OqXyeaNA/K4SZuXhDGcBOS+5gKPJTkSALqfL8/f2XmnrySlMeACIoltOuKatsAKaRDj+HJQtyLFyw04zLumiQHuARFJw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lpkAW9D0P4JusNaKPML1L0yyXgdGuArdMuh1eb6jsIFDMaf6qqLjKeatGLCXC6ExDU2mCsb5DeQiZ4unwTKWSurLMO877mjThe/VzkH0uZ5ygM6YGOQEx5htBhOFoJZQZALw2l1myHd2zopwTUkbUc4sLFZaX4E+tkRUOO8lrHr71zLY0mkrBsBXsC/Q46+wOEXhgT35WeUKu3qrV9h15JTmrU0smgLk+627Z7MywuxRcYsfig4IxUUg2dUqscLUomNplCAlcCS8TjoATOwS3XMudG99rafz4DYhZV6LQAz0XV7wnhQTVWDfP7n1/uljX0G0wWYpyIbbJYyczEGNEoa8gH+/XtmuIfZoEXJR7RN2ydaExvIp9NKWEGWrXoTinqYvUaPA643Kir/DGYwSlalYpg0ueZkr/RagY5GEYScz1qDIyZqSbnzV+i8A+D+QK++8dE2Dto0PLDO6zPfN3V5NJLx/LrYnkwFf6dAygevLQjICEqognw5dq8cfSOcdrq5R1n7VZ8QnIfTQzjGZW2VzkJihd0+aA6sBEtyfnWmwOh8Bx42VK0TI7Xr0hmKlzZ0xNYeuGufQMr7FswpMUCPGtHwRd0MPssBRlcct3qJNVo7WqgKSCJG5+YH53/3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VJHOJWTtGUl3Q08d7H20rviksKhL2QXZ7/zQZBuqOtq8dRyHfpw4K3wfQiz6?=
 =?us-ascii?Q?zxWrBFyQ4uNPVWZGd7h6fj0SOGNOkovez6NH3JHG6HUSVfd87OgiBkomtYXm?=
 =?us-ascii?Q?doYVg2Z6BjV75ZY0B2WBml6iOgPJnDpTEyjhr1DGwa2fINn1tyPTQLAE/czH?=
 =?us-ascii?Q?atyzzcBucFp8vDww/D/2tmXqiLsIXZRnMMMBQW0/aOlGhiDPW+B3Qx7latfF?=
 =?us-ascii?Q?dOrXFtQv9y7MXoklTuSYND/1IzDDMiyHIWc9EgNBt7jxKAfUFBKlob+Djs+4?=
 =?us-ascii?Q?/Pf5azEwTr2wpIlZNha3LwdWTeIEpR9RdIMU057W1EKxXJPdViwaDM/sdSAE?=
 =?us-ascii?Q?p5v9uQ7ajNcEnJDnhk3xruZoHnrlrDlbBCaPcZOjbzcTc3uC/X/e0ev1NQU5?=
 =?us-ascii?Q?3m+DzSCGSziTS4FfvvdMasxd5loyXd5GQfV0ooCeqyvqAdi+RAT5+uIH6x9s?=
 =?us-ascii?Q?gKkmfMTNdN1rllvtALo7cunQ/RV9nHcm1tYDjZfVkVor9RpOo+2lVMVKiPGB?=
 =?us-ascii?Q?6sfiHBny9mMw6rT428H8bU3TgXKut+UviO0D+uHyEEaGkqCJ98IhiPRvfjH1?=
 =?us-ascii?Q?7FOjqEDzBrkXzHtBSb4eqwcFNctoHA5sICb1Ev2cS12DV5awxbzyczipVxyj?=
 =?us-ascii?Q?oSiGnK0ivTOxDSkWgRmYQ0QoLgXXBTXFVk2vH5JGbZverZ5dOj0N9fqRkzkv?=
 =?us-ascii?Q?aFP7tNjK7Dpu7xy6tMAFbGzaLf3EqRrIirfw+SCw2/NkKyQOt70LKj1EWLBO?=
 =?us-ascii?Q?1mkgtqe+5BQIPD1JLvaF5NxhdBOdBPCB2VLA/x0qoA74RE5AxsFAGT3mbxIa?=
 =?us-ascii?Q?SwLth8KCAfGgHBZLqErkMVug2DlpP+tZ7fwsxI6AGhpMeAB0c5YXfYR/klsm?=
 =?us-ascii?Q?zMsV/U6iOxQDFTPueH2Iq7cUnA9l/v/nMlmgSfXtOWYsHBEy1TrzMopu3TsZ?=
 =?us-ascii?Q?xZ9jQ633DR1+xnhXd9/SUXSsf83+krUS+UBKBXR2aYEqFss9l/a+qu2EEzqN?=
 =?us-ascii?Q?ZDYN++TqJVJ/e+rtyKLgH7DUnwzdQGMdbrjhgZeAdk9WpjHWepy7uC5pM2J3?=
 =?us-ascii?Q?J2TutSRj8h/cf1pJgSupO61MPD0Lw+yAcL7qCPlQS3EqWYgl4Usv0std5wJk?=
 =?us-ascii?Q?rFE9mPCF4SwMRJDIY65piARtZXBMcASJlvT0+8zjyHRR8YGU5y3QKJNMEAJW?=
 =?us-ascii?Q?YRX0kZuTARKPUyOTDjD06KBKasi7vpT/1vZl61YbsmI6gWqTDb11+EP2Miui?=
 =?us-ascii?Q?8cJ+SyssWF8JOi3J332UX7uYfLdte7zQ/YkhNfWvO0jcp/lDcaGd5Oa3FlTr?=
 =?us-ascii?Q?n6k=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da420f8a-b360-4286-9c45-08db8a08aa31
X-MS-Exchange-CrossTenant-AuthSource: ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:36:42.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1704
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebased to master and a polite ping :)

Best,
Qixing


