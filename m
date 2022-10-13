Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95DAC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMLgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJMLfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 07:35:54 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn0820.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::820])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77435D038D
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq5eBbHeTnwwkbxxYpXY0weNcnVMXIabeR1UmnKS60VKwS4VOc3fpnc+NuoA0IfPxjImchkZNDEcSuwTnMvwWBvQkSviSfth5OCbm0pku6fkMlKV0esTRJx7rVms9qlRbBbXEn/g3mh0F9hzYuTBNvl2N6BGg9oiLVmk6LoMsCouba6YakmG//RAHaI5eOVfqzt7qSYMOdQzOwtyc4V+yBr/kbStGT251z6ISewaGV92LqXYwX304fYZtHG9zYFPAu5NG16pTYdrC1GTFY3jOWQdxr/UT81L9g4nsTzfT3EFXA4OxonZao5PN8SbfKX28u7kD4QXAbqVE5vKe2XtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZHVsRFCFaeKQxWXyZSbGUIdDjiJewmmdHUNiQMGZWw=;
 b=GR/N2nk2JqsBsbMQKYyvt9x23BhJ86xJxAJ5I+8Vn8LnYa+8ZEIEYaU1kMXEIBo+1uGK5a/1Rs/r0I50ZA0xVQNcI5kn/yIoFcmXGL9q1LKE71kA5314cPXfKUg9GfBNcHbvx+dN2oewn2wxZJQwJmg0wy+3AXnQzA6HFnUsCmZfHIYn0ra2nWJuRdf65C6DRwQTJ3VHu9MPXKezp5/diH6E/yHEFS0P9E5iO+R2lAVIo8xgiVtcr0zI1I7i5pwadrs9115f5jSuAFiwsTAMexxx3qvrPKPuqe2xzZ3IyimG5Ay0HKeq3LooNVGD446vKoHxk9ytTNBL5OnRIYkz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZHVsRFCFaeKQxWXyZSbGUIdDjiJewmmdHUNiQMGZWw=;
 b=TXb1fmFjGgndxzQBUAFlJe0TUHo6Uaw9QcBf70rexjuH01E6QhyN+500C9WfRzKN/Iy++0iLRzVtumSkFAFtx/HaSSO2IrHaL681FxSDY/LvoIDzuYVfkoFg4LklXZrUC2WjmQlqntZ2E1J++HNlcEmhgVJ8qkcgL/7viCD0v3NXdNNTx/ycfuTKzwK1vCoVgXPQKTQO0D42Wk6B5/rxXEC9Yum2a7NIj8jpWndgDmM2VBCBhMTEpaUV4oG0mRPtCDPSHhPnn+4w8HqSGpbqTJ4M4mjKlTZZvAx7bVgezHWyaa+3PUO2ZoVMx/RxA56yYvx3Wh0z9PKmcoyryb3Uxg==
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::20)
 by PAXP195MB1534.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 11:35:48 +0000
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::ad6f:9a23:571f:a69d]) by AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::ad6f:9a23:571f:a69d%8]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 11:35:48 +0000
From:   Hans Meiser <brille1@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?Windows-1252?Q?Cannot_rebase_=96_possible_Git_for_Windows_bug=3F?=
Thread-Topic: =?Windows-1252?Q?Cannot_rebase_=96_possible_Git_for_Windows_bug=3F?=
Thread-Index: AQHY3vdmXkd9xgwMjEmvfJ0iuBPz264MMdMz
Date:   Thu, 13 Oct 2022 11:35:47 +0000
Message-ID: <AS4P195MB1527C07F4E985018B6BD12C3E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
References: <AS4P195MB1527E825B28B3C17F39D0AB7E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <AS4P195MB1527E825B28B3C17F39D0AB7E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [V17Ygdn5xZUt9WiZ1gqm1LwvWB1w3P0q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB1527:EE_|PAXP195MB1534:EE_
x-ms-office365-filtering-correlation-id: 37ac8764-7a08-4dfc-50cf-08daad0f12f1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8M54z5u+E2QjUzEzNCk7Rbo6Q8nFEh0KPzqb9U5/OmVQmbqz1Dh9I3iCbIyY7wBnP+eFxnBUhLYU/KzpEEQA2E5a/u1dLxwArZ15nf3GvtUK6iwQ+JsNMax/mK2BQM0HghWk443SYDPky7BU+Aj7diU6oLvGr8LbuLnVxm6PZIJak+D7YbymzDqTxQ5QbZeGpasf4yXxnZ+bPmlZNPwhLyzvtLkaxkK/VXvw+tA7ZycGK2t7a19U5VDYH8aFXdzd0U4BRQebyu15jBzaboA0ZDYIGhvG0cnJjO6I9xjRm1ZMWpP6gAc2wohPZrJ5quDyJ6mpQeWL+X3L+YPHNQyrdceH7fV1eZnFvKX9oRKOg2theAS3kqAnuQUsNG4Q56kL9woOdUqytUCR+nyeRzXkmUSle95yaI1xZtjILjRNV/XVtFcuqsULTJvjKCBW6rDxEY3Rk13FCirJcb4FINGPitU4STKW+xswLNw1lQgPgi6kpZL7PHzAyL4EPo9p9HyU7IA+n/7bL1rkELtMbLjZBxfXKUbpvcrJ9MeXax+c6G3GlfQdaHNs29CQfeXFcqSm/q+DGAtjuXzWLbgC2CPrs4WTyKvtEA0w5UFAOzsuUx7zbeqw+DiZ/cUJTr7UJ+L
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Xl/D9AIyoJXOru08v1gINitxwLB254FG0uqtsfHmPbAUVPzs8q4saiRa?=
 =?Windows-1252?Q?2ygKofVWlOZQVd5/GxAdfWdlzd8wxxZmi/DE73vx3vpozajixn9DRegP?=
 =?Windows-1252?Q?74UFwr9gf6x0R5KkdCSGsCHMLmiLp5evM2Ja1AkoFIoBJG65gG8GQUGh?=
 =?Windows-1252?Q?lnc2EZxvdQCqV8rSR0AnwNYYRqd9VbShY4j+hTz2RGgvv0nZBNC2bjb/?=
 =?Windows-1252?Q?araQ6q3rGhIurUs8Glzqi7sDjCfuyRMEFL1UmNttcwd6l3cFksLqKtCC?=
 =?Windows-1252?Q?f/OtDbZgIejGcs5e0WniE/0XqIRxPXxWnFfhwgSc8k8QmE00eOJuq3r0?=
 =?Windows-1252?Q?pQWscovLtOJ5zUcVYiXRC+t6r9A++nUFOGNYiak6o0APFJrCVz4fNFFy?=
 =?Windows-1252?Q?IgW/6S40b8QcCyD4bBnPlyXQB9u+bkM2qURj18hTksF8wrgIs6Upvys5?=
 =?Windows-1252?Q?/0438Z8XKxd5vECqH/BizcJO6uqqcEbpELJRi9R4040L1b8WQsNgRN64?=
 =?Windows-1252?Q?xoW81noB/jXBeu1fRv2PHnWW/5vO5bfUS8WGgfpUUb5MgLWZ60yADPkj?=
 =?Windows-1252?Q?S6/q4R4SLBcE7ffnQeLpT2YwZY9dggxbLo6ehMVSM9Hnl9YcWgqIreRD?=
 =?Windows-1252?Q?HljrhaEa45fMCEbNv80jyQasFr856pyWJP4WAxuohkdptdKPQuUW7nmE?=
 =?Windows-1252?Q?Sk575gtMCPxA/Vc5JSGhirg1JxxlhvI7A5FbpGV0SyMxtPlAxnkv+HCc?=
 =?Windows-1252?Q?vCvZEGoR2Zm3IEjin0LVRYupOhqMq9dOGfJl8SlaGVLjUkl8l5A0Ug+f?=
 =?Windows-1252?Q?kJ0MtobJBJ5JQnKIHw5uFll5K+rkEWxgkh02kyoXOo1aaZxsZQfZ18fz?=
 =?Windows-1252?Q?dJdUk6jdCK5LqQ4la2GHx2HkATcY4FST8/5tfN1A2u170BNK/pa7IRxn?=
 =?Windows-1252?Q?wXhiaj+PB3ZR1dHJJPUSTF23FyBqnYkft0L0Jbb8Ed126lNEYVM1YLev?=
 =?Windows-1252?Q?YZ1aLA7bSgp3Kj9gFFwfDSohuC7OAEtD4iNNSYL98N8ziX78sJx4PSI3?=
 =?Windows-1252?Q?KnlEO4/Slq5R6yl3MgC+mgICvQUgYtBrr6YcJZNwpbYQ5kJnV43w4uVd?=
 =?Windows-1252?Q?7YFbV0AjwgP+indzSPRKZ2to2qofB9HrBOjEpQcrJ8ln8fThNipcC74T?=
 =?Windows-1252?Q?zX+5exOJUfPVL6cSh7ViXO1585c76AJu8v9j6SP1CKdUSFYZhsYAOI0F?=
 =?Windows-1252?Q?CM8vsFoGcpoViKBvRyBW9obeWfIiR5qXl19ygT3ZHbnUE41KoxTWu2Vn?=
 =?Windows-1252?Q?P0GbxP0tu4thdwpyBtkixtXVwWMlKBGrX/VBh8DAfjZdMmCJ?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ac8764-7a08-4dfc-50cf-08daad0f12f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 11:35:47.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1534
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
I'm not able to rebase my branch "axel" onto "master". Whenever I do, it's =
just like I performed a "git reset master --hard", although my branch conta=
ins loads of changes to the code.=0A=
=0A=
Here's the full description of the issue at Stack Overflow:=0A=
=0A=
https://stackoverflow.com/questions/74032523/how-can-i-rebase-this-git-bran=
ch-on-master=0A=
=0A=
Perhaps this is a bug in git version 2.38.0.windows.1?=0A=
=0A=
Your answer is appreciated=0A=
Axel=
