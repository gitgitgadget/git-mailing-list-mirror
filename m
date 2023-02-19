Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E476AC61DA4
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 14:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBSONN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 09:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBSONL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 09:13:11 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2039.outbound.protection.outlook.com [40.92.103.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18829026
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 06:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbENF+5K11B2IJlbo3wQbVIRT9o3a8oBzH5bvDEgWl0SYUvUzuG9VkNjGjahkFGdHKZvs2xKobK/7qhLwUurSJWUR18UvkMR0hHmPcOxblF5XlUHxRQqVm/zFkBJE8Mlwwkn8bEADruqydko2HFrkdt2CrzelwPPzdFtfEB6g5+UVDrmY18sum+fmkGW+w+433HCyas3No5oX4XP91z3b1/5JtWLdQT6BBPGfnDXGNg7DP6bzijXXdp9X2Zf2ko6mgrMFrxu6nEGzIOmYe33kjDjIR7ayieXtow3Sti3pBqRvQ5UP5LIltObTH96PwGn32l7duIZwNQbuU/QAsvPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOZ5w5qF+iPBgddsuj+QZBJkg6aySWwHeGi87vFW9JA=;
 b=XXwbx9/utbaFs85r/5Xm/o7WmWiP+MN5GbBxdPAw+0l9xoDHipu8nuNi76wlhSAtq5B5mWXDYHxP6P4U78Hm8eZMlJVYi64r8KDX7u0tblsWEA71T6IRvMkR6jxFwN9U97xnMaA0Ei6qHCykTRX44PoCpPR0XRDOxhI2Z8IINsv24Eor+5mVjRaZ8gDQvtn4irvbvqdAISD/jleAa0/2EG+PTdWa5hL5fjEBzZlyL6x2Fz3XaqlQH4ZWkrhF+/W+zNujrq+sF+ibARBbTFm2AjDIlv/8YBjFqaLHN2v15ok1j9OG5Kf1BPrrt5CgX8kAiQJDb9Y9WGmue7qqAxKqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOZ5w5qF+iPBgddsuj+QZBJkg6aySWwHeGi87vFW9JA=;
 b=syH3KrDjE4bm4RNNUBu5HUH8S845spE6Fv1s8WMgz6rx2OAbetxRjFV1y0zY1aKGZKzL221A24Qv9DD875a3zDuG6pgx7b7JcoXkl+dDdiVdAQnMlIuZy2V+TQeHftXYonHZ3r6iuuzGq+1yJdfURdo4bAZPKGj1wishqGmENFLBjBkVGU6G+fvGUxT6GBZaUrzbNK+h2xopkwR8BeSWGr+35GrGXyv3z0GJ+UR9cHldIc9l6xHimWOPp6d7t+5MSPwJLaphiz1vIRqQGWZPT48/GGKihq5TR4m0wQIEXMR0j8nlg7G86N2ozBRMDOBXC9PDebeZ3DRlhELce1Cm9Q==
Received: from BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:6a::13)
 by MA0PR01MB5895.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Sun, 19 Feb
 2023 14:13:06 +0000
Received: from BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e5e:d4d4:dc64:b9db]) by BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e5e:d4d4:dc64:b9db%7]) with mapi id 15.20.6134.015; Sun, 19 Feb 2023
 14:13:06 +0000
From:   Divyanshu Agrawal <agrawal-d@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: How to find places where I can contribute?
Thread-Topic: How to find places where I can contribute?
Thread-Index: AQHZRGspipq0JtEgf0aUQdsXKp9A+w==
Date:   Sun, 19 Feb 2023 14:13:06 +0000
Message-ID: <BM1PR01MB3139C97DD4B99D3024847874FEA79@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [aTSMIZCx2mBcqUCBkMtqUoU+6I7SEvF/bkOq1dNQupMz+F1y72a8tc4PoPVWZXc2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB3139:EE_|MA0PR01MB5895:EE_
x-ms-office365-filtering-correlation-id: b084277c-b2cc-4107-8a54-08db12836bc0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+Z2yWmIgOUlLvs+cDE9nuTkcPhzGAYK2dRC+i5WuTQyT6UF7xzz6S8L315Y8W8P4YXRiqCBM45d16eLI8U/n3eLygSmEtfLlIhr8Q0cwm66DXN2rrhE8Rid8UAIGUvtwdIobtGLdF17eJNyD1nhpSHmKGNQz3ASlnnd+d39KtwFRGnKRp0BWCtFewDilYNVUkdqWO8IzkHH+EOv5NmcjLCg4te8AJ/lCo5ZMr/gJFcdp9ryq2T9eWZv8R3jDF49pkRgRkKtRIMGiH65u7PlsAPupX2VK/Q7kDwwcoZItsQO0XniSPwssisJMbMihkomI2kLM5m1HV4gOaGwhxPt1BuDOmoPGwZ6aH8f6xxKIcj5VlThHPT0p+YvXrdVUtsRnQV2UuB2+7lvvtMyAFpLHUJwLvvY1gg2UcEgP19BEBnCJlkLEvR2jNOyQbhu0m72opANkn+79sKcum4jzd4CnWY87Xrag9t8oKCy5DdbkygsXtJ2Rf4hGWxIPlwx1L8U+TCFtdXD7pDY9TRVeCvzWbZdxL121xAIECHOZFUoqMM6uEiErlx0YPvNEeDRrC3hcbSOZI4JpyIkmLc1By5uwvtPRhWgNjUSAf6u6VRjoj0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CrEAktNcl+cacXQdEa5iZJY5P4G2UaqA0JncwHEzRQPERXVgxrphswWkpb?=
 =?iso-8859-1?Q?f4GtPkDA5EYtisbauDtT5RTtJKq4xpU3bNObJBUH9hqI9kREKu6Ty+G2G3?=
 =?iso-8859-1?Q?NWHb7tBKVS+xD61BAaGHOioMuRy46TW7fA2e9crFsT+wN/l8hgQNy3bkoh?=
 =?iso-8859-1?Q?3gr1uNjIeSAAzCfdUy+RRPs0YCdzWpMN5xLTvrMIfFFYUqIh9IHp1vzngC?=
 =?iso-8859-1?Q?7Ohv36E2qjKvcLiFs1qYJZMVAMyZdXhmrFVGvjIhHF3RCG7dxScbjGG24K?=
 =?iso-8859-1?Q?W8jrSBi3lWstVzQFTKk2BeZsvWvlSQO8dxe9y+FMWSwZKZjodFRRDpQHp+?=
 =?iso-8859-1?Q?5mIkGvRh/Z67zZNV2ZZ0rX/jnVpEYBgK/Qe29LViThh+ulwoEbn69/xi8K?=
 =?iso-8859-1?Q?5ovTgMym94VGCDjWRc8tFvMqBYtCTuh+ShVPIvdEMJKbIlWBcnYWaA7OsT?=
 =?iso-8859-1?Q?BkObX+YkGfBrG6bWlb4rUVDFrnLXUXfNaXKqS+i1h4D0igEDuaNQNLMZ4S?=
 =?iso-8859-1?Q?2Tgr4EI0bdGeKlicD0IwdrtMQuapgIXeEXnTBiVONE3/spKv16rfRYzPe1?=
 =?iso-8859-1?Q?NXvDRMyJIPPOHI1s6R6lGONvVsUdlO0N3lwY+wqAeinoy7nY+WCWfCpvAm?=
 =?iso-8859-1?Q?f2rb8j9wurOByM+wQO35WftMt/qaFPpH9g6Fuy8FiorAjHg+YAyz2h7LLM?=
 =?iso-8859-1?Q?MNSzaK0P1rg8QNy+F8cdTWVxuSTM1wqiWX7c+yle9d1tnG7/HDD+aDNS1i?=
 =?iso-8859-1?Q?Cqq4y07bPG7mBWjuhMZul95SDIIualGRIIj8p62UrAwQcC5RBGvw5gj9Z7?=
 =?iso-8859-1?Q?SID9sCulY6ro6uYq8zwuzkd/0guVkclQLZ2sf8xGMFCMqJ1jt4RwEe6Xqi?=
 =?iso-8859-1?Q?Qyj+BI9KXm80PKQdjCMGmGuboxl7J2BRikvPUTDmEyqslw07/g/ltTV2Yf?=
 =?iso-8859-1?Q?bPsstkiuDV3ZoTEopzrGdqOW6dBVHl6qKJUvp2OhMa5m3YKhoTlgl23dLJ?=
 =?iso-8859-1?Q?vFgZn/aasiN3sgprkOv4+xKmSWR9FZmPcrrkgH3fZKHKaTwKa7ZoLv6W/w?=
 =?iso-8859-1?Q?LTYVUlfu6i1AIa9az+xkYCexhlpQHDJ4HRAGm0RHgY/i41/A/MguKGI2bd?=
 =?iso-8859-1?Q?Hay0vSU7dC2BuE1r2WNP81NfGQp914hpgHaeOIzuMidWZoE3nDdxA6wlpz?=
 =?iso-8859-1?Q?op9HsqG3D0n5LZVQFk20KQurD1WyES8nbP8L7vPztzfe8MbB1EH+3b/5Vr?=
 =?iso-8859-1?Q?YCDcYITfBJi1ehtSSi9LEyjjMu80WVDVRrKsFvQwJU8BDVKqGTpYuSzOWe?=
 =?iso-8859-1?Q?KuwlfVAearWhf+vVG0Yfokuc8vDhdN1rDaoluSqAIDQxqBx8WxswdmCSYQ?=
 =?iso-8859-1?Q?IeQjqhJ/RMkgXqdTklbuAPRy5Pz7rmsA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b084277c-b2cc-4107-8a54-08db12836bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2023 14:13:06.0697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5895
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!=0A=
I want to contribute to the Git project. However, I'm not sure what I can=
=0A=
contribute to.=0A=
=0A=
I'm used to the GitHub workflow, where I would look at the "Issues" section=
 of=0A=
a GitHub repository, and try to tackle bugs / features I think I will be ab=
le=0A=
to work on.=0A=
=0A=
=0A=
1. What is the equivalent for the Git project? How can I find issues/featur=
es=0A=
that I can work on?=0A=
=0A=
2. Is there a way I can find bugs/issues that are likely easy for a new=0A=
contributor to pick up? Similar to a "good-first-issue" label on GitHub?=0A=
=0A=
Based on your responses, I can also update the documentation, so that other=
s=0A=
like me can get started quickly!=0A=
=0A=
Thanks!=0A=
=0A=
Divyanshu Agrawal=0A=
