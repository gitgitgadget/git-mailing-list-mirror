Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B5C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 16:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJOQH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJOQH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 12:07:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-oln040092073071.outbound.protection.outlook.com [40.92.73.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B64F52447
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 09:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz2jYXLfebClO9HChknDwA1O4gk/73bg4jUZBr/Fru0l/1cwGTQxRjxTnfMHjDuM7n54+6ATyZ2jsvRNzONUIjtBjHUAAF4bpNMdMEXK+SU46RMgYcB/tv/YR1/S352vcReoBMJ6T/+OaTipFCxR+2iHe3lzmn32ysM4U8Rx/rUWMi+QKrdsA0OkKmCz7bjd3BFkJobT7pre9lffULm005Id30cZr5dH7ZPnEIFNWOJMIiOOE4v/il2POqa4ZRGxP+6RVKkC5RbfnLI/JK1Y9b16dbxcSr2AFoDQL2bDs2iifbQ8ESZVXcUA4QdtoqaXfGCjRZbqyBWJeyBq5ew6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPgA9n2GkCyNWjGiD90H+oM3pRMN2AhMOjcm3f3j1vc=;
 b=HOTl7+QmKXINt8YVmL7tAmfbHvh75inCz8Ta6gyrYsl0WXZQ/ImnTWjQ9218LZprSvFkWwHWCd/qCYSeJIMZLT/aGrW+Q9YtZrZpBYu97p9VQijps3yh0hW64L+LZGOHnMpi3Swy8B3M4AgmGoNP9njkK8yUpzQoiTrORuOGgdamFh0ESIfJfmfY266riPXZPbAyFy59JbhMzxiAWvu8Ljk0p69086Y4nIGrv+5vBOF7txh281BCkYkw0kMrNRu4NCqtYD6/vvCKdYQHh0fyWqIaVcEE01R89Blajqbvb0lZAkcHD8W3R2WuEE8wkEAasd01uecBvAfX5GzoSlH2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPgA9n2GkCyNWjGiD90H+oM3pRMN2AhMOjcm3f3j1vc=;
 b=h8zBGL+1TjHv9qHzlLJLPj1QuDkTewp7iS3t9elGb08xn7OCQoVA/KpqQKp53kQJMShVByzlIZIFrPijuWmE/0jWrxlQC+fUorMqdb5LLeSfDQWZMckwBOgpsNwmVEfnS5Qr4Pi2YYZO7uuMUnGrEfAnjNT6mVxS5LzMcqTH7f/VkDzux9+ZdgbPrSG24L0nqfz9pNIdLOpvamTUkXKHGc/D6Yyd+pTSRXFAtP791n//23p0SBFJg69oOkXpt549sL2d4RwQbhd2vLcoIXsKtGCY0BmwDr+hihvVpT/HgrbKurosUesYG3REBe08qJ9DCCvQ0D20kI5VLVXa/VttGw==
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::20)
 by DB8P195MB0613.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sat, 15 Oct
 2022 16:07:53 +0000
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::ad6f:9a23:571f:a69d]) by AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::ad6f:9a23:571f:a69d%8]) with mapi id 15.20.5723.030; Sat, 15 Oct 2022
 16:07:53 +0000
From:   Hans Meiser <brille1@hotmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Dead-end Situation created by amending a merge commit in a topic
 branch
Thread-Topic: Dead-end Situation created by amending a merge commit in a topic
 branch
Thread-Index: AQHY4LBHTi3HldWbcU227A8GfFOHag==
Date:   Sat, 15 Oct 2022 16:07:53 +0000
Message-ID: <AS4P195MB1527956C72FD0407FF4C488EE2279@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
References: <AS4P195MB1527E825B28B3C17F39D0AB7E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <AS4P195MB1527C07F4E985018B6BD12C3E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <CA+JQ7M8Bcr9czyBNg-+sFpqGSy=3QJfps8vGPa=82QGAvqpUSw@mail.gmail.com>
In-Reply-To: <CA+JQ7M8Bcr9czyBNg-+sFpqGSy=3QJfps8vGPa=82QGAvqpUSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dc6SdgR44xu12xFpiAjtA8HyzRU4E14Q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB1527:EE_|DB8P195MB0613:EE_
x-ms-office365-filtering-correlation-id: ffc01def-76f2-4ba3-52f3-08daaec76a44
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auct3lH+UR6VTACTuo2JENRhSoGPI51yKl4Tht08sgatg9/Palv2kSY2zq0udLAf47Jr3H835YPSkXJ1qOpFDRld8XfTUwdYQazMdTsn4+lQscPIem7Pni0XIzzFFrpHD5ghkzuNXYK2XDujtcgLd+VhbPKC7LeyTMRxrAhn8CkRK+9Y/GoFbt/d73CYwZelwVVxpxRLWnWVfczbiQ6tuYsmxkeh1Cz2lxEkxeOjzDe5J3elqA7fPAfkDnBitbVOYe/nzKTihAuB5208Iirzxafcv2QWmDpjeSTtRRMCJP8FawtrSYJjSB3wy1XOT4dcOy/ep5I3lzSX7frX+Tl8rZLEhEQ4QtUEO3aEa5zKu9r8JCvWQLtiYqtJOZ+gxfADULMQjtMC7ZuySrQLw2WDxVcfRodyewBHtF6auaDGJ0ym5R5SoMTrF/RqAsVgr5eVKZrIUTKRNYvAjwAWf2vaWfgXf9OC+CG4dneAPgVlD/6rxRKye8NOtuCvpvhVl1mqW0lMKSakGFD79vgRiTMNiRxliulfM+4ITwxxOBd7Ddwk0gWhIQkSb+ODE7m9R5c/eohLIk09ExgdRV49JhN/QGkgghzlmEUAi177qPkheH9HES/XMS9UTBXLw4Pvdhcy
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aIrMu9Bl/4qzYHMvL17ChAy1FH6KbJlAXusXNgmfdHDLrJs/KBHkzmH/sR?=
 =?iso-8859-1?Q?VRN8ld6WL4N3KNoKCp3b+f3G/ntJhXb6IWXVOBZZTorJKxgMW/DviI/L5M?=
 =?iso-8859-1?Q?BL4uy8oZj0rwHrLhbMMw4iq7/pWOqqNsEsCCSAxFWEdPdewB0PJNrAp0XS?=
 =?iso-8859-1?Q?4C/ede6hrwYvtsLGm5G0nmbFx5lEIhomqV6QlYEflhC3fvvbp1hAX3Dl0E?=
 =?iso-8859-1?Q?dBwhvxHm0+CKFEdzpOlgN2UtX5WawD4OKgDLXzVJHECGDqJQWzpx79W0IA?=
 =?iso-8859-1?Q?TR/P9Ogz/eytA0SQ++RKlGop75Wj5/maqcmQonAOqgwHhiV2lCDiv1KlJ+?=
 =?iso-8859-1?Q?FXzTliAVxj5OjuL+PLGneXXR0hpE0oCr5PdOfesLzK0jJbxUEFrW5b11pI?=
 =?iso-8859-1?Q?4nsyZjdsPP6g2Vgal+o5E3urVPmbHPgGxA4gfYLXSukLudgTsdHGfpMxZB?=
 =?iso-8859-1?Q?rnjfbKN/XoyLtPCHeNtilqBowL2eZKsDFk+vVFC854Gu9ftxeVda0HhWeE?=
 =?iso-8859-1?Q?JaNXED/x9/5oE7IEpjgxyJy8/5Dc5xR0PS2/KM5+kTAbu14W0s9j3+NTyN?=
 =?iso-8859-1?Q?oOW9lEOQvzGEI9exAiIrMOKHVeflsZbbs3bFkWXwFJrfflGWqDMsOqAHgm?=
 =?iso-8859-1?Q?C7pGD9lGlJwjmz6VzRc1IAOEKfX9Z4lWJlQJSxWrBGpi7x49MW/gvUiyIB?=
 =?iso-8859-1?Q?KW6c3rGTKyE8Ini+z0KeCuV2RKXjjlAcvCGF1o8vAps2rR+Ja8fLE56L/b?=
 =?iso-8859-1?Q?eGqUAjslttGX9Yy4hq2W28pO3fX7bW2h/A+my73BljEV6mdqb/Q4PEsUBF?=
 =?iso-8859-1?Q?kt38zS/Nwi+3nvfMQ04dBzDpQFBSjgCFj8S+Aw7iJeMFcIG6Wg205v78At?=
 =?iso-8859-1?Q?0+gTqd2lp2VSOXaNrbGymBePblTm8PTFgqOo9teSMPcNbl+Jh8F3R7nV2g?=
 =?iso-8859-1?Q?506cpoX334aiRa+8mjCHqnrqRjYdNcc5mBJ6NiI/6q0R9ceMK9k/XHZNNY?=
 =?iso-8859-1?Q?nW2LH3xVyU/Hqw+KrdOje98jlWgIpc7GCPS7Ivh5WtkAYytCFSK8FMp76p?=
 =?iso-8859-1?Q?J1A+YDoba04FVs15zS+BtuAC76H0X7p8axGpC99iubxKrqzLBXJTW+dMOA?=
 =?iso-8859-1?Q?d07iIs8DQRP+CN7EQX4VoSiw0LhmjTOvFhqEFiXhHPIdtOOBuRhSmu+LRc?=
 =?iso-8859-1?Q?vIvAXluc0Kozfyyx+3NlEM6tHq18yZdfKQfCvk6A88X+Xn91HeoR2vNuaI?=
 =?iso-8859-1?Q?SFlfze58xByQvvIJoufuBUo2NpLDLdIJf8qgIi648P7E05N+uMColmW2zX?=
 =?iso-8859-1?Q?Lmyo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc01def-76f2-4ba3-52f3-08daaec76a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 16:07:53.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0613
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like it's possible to reach an unresolvable dead-end situation by =
amending a merge commit.=0A=
=0A=
For a use-case see this issue at Stack Overflow:=0A=
https://stackoverflow.com/questions/74032523/how-can-i-rebase-this-git-bran=
ch-on-master/74064773=0A=
=0A=
Is this situation desired?=0A=
=0A=
Shouldn't git rather emit an error message when trying to amend a merge com=
mit?=
