Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCAFC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 22:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJRWfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJRWfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 18:35:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2021.outbound.protection.outlook.com [40.92.89.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8141D26
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 15:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKLChHdugHVY7OvZ6tjuHplVFBSFpmgDJqbcYHhMna2W0sAjzqU34CSPXO2qkUDqB4k/Ttz9js2wuhQywzctrWY9Fq6LyRijaIg4b6lXrMJ8FFPYK7/mU9oLtp50KAxa5ojRh1IW3caUpzD7Ac1A32l7EKA9wXgxUYOy8YGZt8sVtdSDu/PKNYxXck7Op/TKXowcNTn6VdoEkLo396mv6OUVqvTkRhdG+Vi7iXtq2oNN5xyXO5x1bh1PBZ/A4oiyPlUkIzRTtBbBlJ6bPR5rK7Nc2pqqns37MMbQNWOOnrXmdb+MbVY/JHdgLoDDhf8ZtTBqMmScfpFRiMn96Ze/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ0tcDQbR/uarvSoJunpXavyXIEhdiiKxNoaLXsmNVg=;
 b=XFYelQAYUgUyPtf8nU3QbLmwUdGx1dhYHe3q1pXGs2TZeWtYK/XZlP1/wInNNCc26okLPGTYUNh6Zz+Xsy7cKZJo3Ixxmi3UzprjQfk6fbq00LnsjjTW+Xwj+DI0909eQt/HSGT792gURa3d+eQkut0f835jjoJ/KlUIb9lFZ2KR+IcTAoOq8aIBD7YNQEsxFgxwSMH8SbdaOfdXgshWXhJ09l6BqMwYEmtjp26S1lSIoEpV1zejSoJ//jOA5vbSgY8rvh65DVMlDXQrQsS74g3baeZEp8lLpT5102WpJ5yNk/C65oBRz7/5ksV3Xlkl7FbRaY8Ub/IH22fIWeEibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ0tcDQbR/uarvSoJunpXavyXIEhdiiKxNoaLXsmNVg=;
 b=suoN8c5B1jtWOo/FpJmwzIr4FVLkdnM8vP/1XO12hqKmqca34p6Se9eAXlGuZfJLJ1mzvaygeVlKiWESrnjXjmSNkRw2AexojN8YB3lMY8PfRQP82oST7//ip2cXnttXkSJKqO1WNdkYi4XgaZv+qjwBEg3taWRw+JsFOLrH/Vk83mKOKLjH1IcTyEmRBYRy5SwRxpf8A9tqX+Why0RG8ee3I1gMGR4txf/yOxCjGKjyYtUZq83WF3z1+HT4J+wLgS1NBcIl2GcSNUO0P7MLrrFNRQbO62iTViNj2/xooUaSyadHUR7FMQrFgW5PiF5cSS3fsSXh6I0AAGwNOUrAvw==
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::20)
 by PR3P195MB0730.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 22:35:09 +0000
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::ad6f:9a23:571f:a69d]) by AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::ad6f:9a23:571f:a69d%7]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 22:35:09 +0000
From:   Hans Meiser <brille1@hotmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Erik Cervin Edin <erik@cervined.in>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Dead-end Situation created by amending a merge commit in a topic
 branch
Thread-Topic: Dead-end Situation created by amending a merge commit in a topic
 branch
Thread-Index: AQHY4LBHTi3HldWbcU227A8GfFOHaq4UOtYAgACGY/aAAADp2A==
Date:   Tue, 18 Oct 2022 22:35:09 +0000
Message-ID: <AS4P195MB15271C837469DEDB33FB0545E2289@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
References: <AS4P195MB1527E825B28B3C17F39D0AB7E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <AS4P195MB1527C07F4E985018B6BD12C3E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <CA+JQ7M8Bcr9czyBNg-+sFpqGSy=3QJfps8vGPa=82QGAvqpUSw@mail.gmail.com>
 <AS4P195MB1527956C72FD0407FF4C488EE2279@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <n7599nnr-qps4-oo46-93o9-8310q0r44714@tzk.qr>
 <AS4P195MB152726A49510B13043F1DAFEE2289@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <AS4P195MB152726A49510B13043F1DAFEE2289@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [f/Y3HjRIUUz7NaqUly8/thcNUnAFfeVG]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB1527:EE_|PR3P195MB0730:EE_
x-ms-office365-filtering-correlation-id: f4c0e4ef-f735-4290-e1bf-08dab15903a4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vl75N78FJaO8aydTcJLSydX9ekl2jdQAlAfjSlRj7px7+5E+rbTebTL9bwujRs5egZ87Tki7qR41kBCdkSyTvF6p6R8IXiPgZm6Ft4vcHaL+ptKjkfC6LuwRUTckc36Vj5pOGSQzPzL3Z2TF2APqKVlZNTA/5ySnQOmuhw+Jb5idFs0vSLVti52xXPfeNQpDQn2NThcQszaqWDG0MHr5+nRXd/8Sg3q3BcEF8LZJ2z1utl1CXCoBWQvf7R5vPNxV3z2Rwef6fQGyPSn92hAg2VQPYLiWzXhYM4WHbi64jWoILOLUQh6PzvBSOwfo1HbFSLlwEk570DtMrlO0K17Cqwej3rI1Wk1gM8YupfvPONYVTssZoAefnYyKQp6m2vPoGksrdFbJSBirOLW6UtKMaChlvY1chJhOwHh1idvGM9Br8y9qfrKbZY8tDvcP105uTDG9T5YH2Gb+dVt8Qa0AhnYUzm7GJAawAg6JGi9uytUKMUjfAaY1K8Q7CrBjFqeraGxDeUAYLatHuXNoerr+zkY6Qx2wxmd+xrKIcwQ4+0AXgiPqd5CLTajLMSfevmdJxXI5DLcCd6vhHebQ4WY8xzgIxXFJQpBTgCluOMaI5P3uTVEkaHgBsfBF6cV0aM0Jb1bouKb4GuchU1z4262pYG/LUqlVHgyeY6cELK7Z74zA3hBLji0SV0/S1WatRVj5
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6WzIQJsgoZXLA2dWXC6opWpYYTQNaXQQtMlO6o0sdAzFPFcDCBoXom4h+2?=
 =?iso-8859-1?Q?0Pdd6oDxiEZTElE/0Yiz5Ngal25J38AJuoeaI7D7Sd4O0GfREKAYpKpMmu?=
 =?iso-8859-1?Q?dxUWW/jPOIxeg1oWVEkpl8WCaRkfsQSqDVKCvQBlcOFxFbzWav4jYMtGcj?=
 =?iso-8859-1?Q?pyj9udAb4R5EtJvcDAtsVHHOhvduoy1JxR90WvWysGdlbbivZ+2AnENi/u?=
 =?iso-8859-1?Q?xFFHfwTqRsXt6m5x1D+E7gKR9OxF9fThGnJFQRLqQPZsCEc201v2iy8PjA?=
 =?iso-8859-1?Q?n8cHh3pVuS0fQOURuG5ip+ht8TFo87q8vp0+7uLYhuSozotHWgPRYYU0vD?=
 =?iso-8859-1?Q?WESZ7+F2993sypkH016X7vbT3vaQqjg2iGi/I1KLCg3VMwWM98O5ygVNOE?=
 =?iso-8859-1?Q?FfpQpic3o30A0a0eCZn3X8BabCfDHHI65PE8O+d3YNGsN2CTEOxDp8bRzX?=
 =?iso-8859-1?Q?Xfzk0zt6uTVZ4XuloLSfbXQpoot205YUX7H7fwLkMsSa/Ss0zOblv5RKIo?=
 =?iso-8859-1?Q?VlmAYQyB2LW5e49Opf4S2+xB/7ofVgy6pyXkbEatntEOlvREBzoytDOgAg?=
 =?iso-8859-1?Q?qRu2gCMjKQaaEUfZfbvIqevL59oI1R0x09mWq7gqDxXUrPO1Iz/lX/FJGT?=
 =?iso-8859-1?Q?IWDgJCE2c5I0hEnZGasZpi1GSY7uHvSazUimUQM42j89XJWQ8bAR7bU5lA?=
 =?iso-8859-1?Q?acG92/f0Z5s0iG2Z/9hLkLaJ/mjRtkyzLKVUc1PIyrAcBjwBcK2NJXVaxv?=
 =?iso-8859-1?Q?Eorn6yVfiFF2oQYPFVqy49CEQcfsvxjbsc48d5c0oNi5m67oXbRHUBnNKT?=
 =?iso-8859-1?Q?CwpuBF2Dv0RvF5ybG0j3JOAInNtkJz4Y54BfW9v3cMxeX0S2zYUWwdj0AR?=
 =?iso-8859-1?Q?w4MVKjDNozEPVQq0kmQklc8XUTPe4SMnhah64ZErg4v8Y5Uj4SDNofDtlN?=
 =?iso-8859-1?Q?ZsQOsSZcbqeoNqzdKsqu3Z9IFcd4ppwoHKI5ghv8Qq1QR+vTo8QFBJ5Kim?=
 =?iso-8859-1?Q?c9HPnHItRJf8NS2mqKaNstWTQ7/kS0PkKmGuxreERPUSHZ3ikxlhzFwq4f?=
 =?iso-8859-1?Q?LjToQlqMThsXD9kflYafSRcozA8PBxxmPHvhftff1tzRSLfdv0BfsFJCKQ?=
 =?iso-8859-1?Q?FMLGgG6s2yXK15egf+5T6S6IsNMvLUjpMO9fX5xr4uj9dNp7/zcLwnMZd7?=
 =?iso-8859-1?Q?cHu8Nm+etKzneoCtsPv4x+On2ew17hwXmpaGxAQmFvf9OelIJriMTk6t/9?=
 =?iso-8859-1?Q?IIic80NTNdeOSXCYU7E+RNebnt65Lh+G0LWxZ0u8+u/XLd3el4pzUW8a5X?=
 =?iso-8859-1?Q?CrAh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c0e4ef-f735-4290-e1bf-08dab15903a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 22:35:09.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0730
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Johannes,=0A=
=0A=
that's in fact exactly what the Stack Overflow issue does.=0A=
=0A=
I wouldn't want to end up with two distinct lines of discussion on the same=
 purpose. The Stack Overflow line should be sufficient and convenient for e=
veryone. It's succinct yet comprehensive.=0A=
=0A=
Just wanted to put your awareness to an issue in git. It's up to you to mak=
e the best of it.=0A=
=0A=
Best regards,=0A=
Axel=0A=
=0A=
=0A=
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=0A=
Sent: Tuesday, October 18, 2022 16:30=0A=
To: Hans Meiser <brille1@hotmail.com>=0A=
Cc: Erik Cervin Edin <erik@cervined.in>; git@vger.kernel.org <git@vger.kern=
el.org>=0A=
Subject: Re: Dead-end Situation created by amending a merge commit in a top=
ic branch =0A=
=A0=0A=
Hi Hans,=0A=
=0A=
On Sat, 15 Oct 2022, Hans Meiser wrote:=0A=
=0A=
> It looks like it's possible to reach an unresolvable dead-end situation b=
y amending a merge commit.=0A=
>=0A=
> For a use-case see this issue at Stack Overflow:=0A=
> https://stackoverflow.com/questions/74032523/how-can-i-rebase-this-git-br=
anch-on-master/74064773=0A=
=0A=
Please note that readers such as myself make a habit of not following=0A=
links thrown into a mail on the Git mailing list.=0A=
=0A=
If you can summarize the problem succinctly and comprehensively, please do=
=0A=
so, without sending readers to read through threads elsewhere and weeding=
=0A=
out the relevant information for themselves. It's a better use of=0A=
everybody's time if _one_ person distills the information into a=0A=
well-written bug report, instead of forcing every reader to do that.=0A=
=0A=
Ciao,=0A=
Johannes=0A=
=0A=
>=0A=
> Is this situation desired?=0A=
>=0A=
> Shouldn't git rather emit an error message when trying to amend a merge c=
ommit?=0A=
=0A=
=0A=
From: Hans Meiser <brille1@hotmail.com>=0A=
Sent: Wednesday, October 19, 2022 00:34=0A=
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>=0A=
Cc: Erik Cervin Edin <erik@cervined.in>; git@vger.kernel.org <git@vger.kern=
el.org>=0A=
Subject: Re: Dead-end Situation created by amending a merge commit in a top=
ic branch =0A=
=A0=0A=
Hello, Johannes,=0A=
=0A=
that's in fact exactly what the Stack Overflow issue does.=0A=
=0A=
I wouldn't want to end up with two distinct lines of discussion on the same=
 purpose. The Stack Overflow line should be sufficient for everyone. It's s=
uccinct yet comprehensive.=0A=
=0A=
Just wanted to put your awareness to an issue in git. It's up to you to mak=
e the best of it.=0A=
=0A=
Best regards,=0A=
Axel=0A=
=0A=
=0A=
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=0A=
Sent: Tuesday, October 18, 2022 16:30=0A=
To: Hans Meiser <brille1@hotmail.com>=0A=
Cc: Erik Cervin Edin <erik@cervined.in>; git@vger.kernel.org <git@vger.kern=
el.org>=0A=
Subject: Re: Dead-end Situation created by amending a merge commit in a top=
ic branch =0A=
=A0=0A=
Hi Hans,=0A=
=0A=
On Sat, 15 Oct 2022, Hans Meiser wrote:=0A=
=0A=
> It looks like it's possible to reach an unresolvable dead-end situation b=
y amending a merge commit.=0A=
>=0A=
> For a use-case see this issue at Stack Overflow:=0A=
> https://stackoverflow.com/questions/74032523/how-can-i-rebase-this-git-br=
anch-on-master/74064773=0A=
=0A=
Please note that readers such as myself make a habit of not following=0A=
links thrown into a mail on the Git mailing list.=0A=
=0A=
If you can summarize the problem succinctly and comprehensively, please do=
=0A=
so, without sending readers to read through threads elsewhere and weeding=
=0A=
out the relevant information for themselves. It's a better use of=0A=
everybody's time if _one_ person distills the information into a=0A=
well-written bug report, instead of forcing every reader to do that.=0A=
=0A=
Ciao,=0A=
Johannes=0A=
=0A=
>=0A=
> Is this situation desired?=0A=
>=0A=
> Shouldn't git rather emit an error message when trying to amend a merge c=
ommit?=
