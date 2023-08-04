Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B9C001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjHDSXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjHDSW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 14:22:57 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2033.outbound.protection.outlook.com [40.92.46.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF44C3D
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 11:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8mhpNAmvLrnBNUUZLlC3VWeoH/mfjfogWZNDTaXT9eRZdlGl9ceoKia6UWWif4t5yvKyS7Wh2GuV4dN8G284x0KnJoPTMHR3R40wS9SbRYotWeP5uCBY6ivgRTwDkGTxKMB7uXeFEmaG2I5lfjyGpdvpdmbu5VmqwX50SHzf2dj2zW8XocUcVqyCi01RaTGafTJTBG1IJX+mLaawzYpevOnYaoHTjMJzQjt3QtmGE/fUTk3h0VRrohrFAdMsj8EGTq3uI7nGW1QrkZJscnu4gkx7AmlgTrQM8SD3YjJ5tnUwycNejVcxdBp44W8F9EyJx7dDFV1SGpaxPNg1Mo8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kzqBOqR8q7qLputTgNo1P4kcLnLTmUluyT95LANH6g=;
 b=e29OvORjT0A1+Nog28odU4bR4PVi0VPMw00Tj6azOB0gSxXGqgsn6TIXhN45q0qNkANpoNbeNXxb9bilpbaPki9jiRmmo3ZDvXbj4EY115u+F7d61LBY4KO2GW3zbPxK3NJljPfXAJO0evVgXJepJFYiXVTsp58hwtXGV96nMv3evyjwiFQ+QhOjP2G7Nb8AMl7Ef7sgtNF7+STR+2d0jJlseUoIoyBVw8nWjx3yKcqjYaiFD5PES1QCYrSvTXNbfnqem1f0UMHNS5C2Pzmzn0u1BTFdzYl0TgApz4CsyaeXDWCeztAWzz3WupzOVW1UqdXPj2UzB39DgaOpl2ss4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kzqBOqR8q7qLputTgNo1P4kcLnLTmUluyT95LANH6g=;
 b=mMTjntrxwm10GTRyJ6M2iajfVjZ5tDB7s1rM+0i7d1F+z9k8zpw7iXU5BMPI4Bebk1uvC9vUtDYrOvALlbhGTl4xy0kwE11vSgJeRjwfn44ZL2j1P1O3dfZkIN4OjHvxUvUXr9nKF1ZBM3DzZ156spn+7WVF3AymWKH18SvT6v9wb3Bzt2k5TiFNsObrGWqNlg6Zi8zJu6bjZuGYMpOT9rl/z34n5W24Q7WHGt9eVZa++9O3nDl87JN76bs+Hb4EgEx/k20+t4WtIrEWYFwcQRYqtizp9dlcQ3Cn/qxy0Pe+jqmj7dez7qBweJscDqd9HhYJPm+GkF17jHLH32Ae+w==
Received: from PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1ca::15)
 by SN7P223MB0669.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:267::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:22:49 +0000
Received: from PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
 ([fe80::c1f9:1f72:b986:1c2]) by PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
 ([fe80::c1f9:1f72:b986:1c2%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 18:22:49 +0000
From:   Benjamin Stein <benji_stein@hotmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Bug: fetch with deepen shortens history
Thread-Topic: Bug: fetch with deepen shortens history
Thread-Index: AQHZxbiegEPB3kJWDESCNi/6fd3+Lg==
Date:   Fri, 4 Aug 2023 18:22:49 +0000
Message-ID: <MW4P223MB07081836921092F561B2DA709F08A@MW4P223MB0708.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [7CxbCZGX23oDhgyFGdyeaWv9Ck0XdRfR]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8P223MB0699:EE_|SN7P223MB0669:EE_
x-ms-office365-filtering-correlation-id: c8370117-f3eb-4d4d-3c50-08db9517cf59
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hx+2mbalvdkojCbMVMMk9w1hGz46grZAMBkT4CYUfy1V0vp8S+LuJfVM7vkIlCCT1gN7Pzz5GBvSQBk33Zxh8o7ZmBpxfdgf0mrZ8LuZXDqxSkIKK4JbB/8JqJvg0Z+LkuBo3om1MyO/Upf/kBair8hOorejNNk43+xRiCXHai7yHqgoTwkQWG5Tl/FvVdEZ9d4BrtMqhaAY8VWhAtahwLVjuJt19+OdNjDVjG3BoJOXX+xGExPIO9h6o7Wd9KbpzaOZYAMab19lY0ppxnid0zh0BaDmbWx15zxdGmksP93gihNppqZCEwQgEVczZA4s4jNJmbIN5+pyZPhqO0RKvbvMmvf09Y0MOUKbvDozDJsEcP8zw5e/yN915vMZmAT0xlHHz4np9bpLNgcXYTJcbGqoLky4JLrDSnzEQShKnNYNoSfLH+9O2jAtulPRXRiqDMtXpcs5WtE5c6/91Uau0nTilPNbjle1q/6cT5poXPb2+lCdorPg8bQ9JDWbEFSMW6mqQPTwaBb7u3C09q47iw2bLAmmDspuQ7YfTX3R17NP7/xjfHzX+q64X/tNe0xP
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ENBuMn0/rRiV62Ud6fhMCnh5z+rym/pVBChaJwHK6sr7hOtdGwX9O5V3jb?=
 =?iso-8859-1?Q?CDlX/HGEbvS5zS3MeWXn4TxfNj74bnnttkmjQ/RgpqwZeG8xf7VkTxXDln?=
 =?iso-8859-1?Q?sVdzTKD1B1e+KO7CNq0j/Y/fw6GDBLueb880ngZJ9vO6Tt3Xpfm+DWV0pJ?=
 =?iso-8859-1?Q?/Cqfdz2qtxIaXc+cBQ5rM18PPShIfK0uwdpLPEPRJJCaDBHqXl6P9MIgZH?=
 =?iso-8859-1?Q?azBklFUcX0lW5P/akLkZHPqHPyCanZz5kt2pufDfnD5/luwRr4y8G3QYo0?=
 =?iso-8859-1?Q?2bQ980KiT0/je3/CYabAaW+NIe20uKXW7py9j7NBBakB/fnztISRpH/hm6?=
 =?iso-8859-1?Q?ll1o3yRi6UMM5t2QyxfSNIpYXjdKMSX6JsH0x6OQmVz/uPr0tydQp46ods?=
 =?iso-8859-1?Q?tosNvgDyJKRCwZITsO0e5ktFt0sw1R70/7CFwMScPs8OQPSrNu9AloTruJ?=
 =?iso-8859-1?Q?XEuYwqOnOrVTYCLNu0ey/TUAMGSSx+BdgVC3AMqRm+k+Wa5wqpvCHjv5Gx?=
 =?iso-8859-1?Q?xWFWDFpDPB48LA3ggASgD2s96S0/QOp+I0dEI9qQ5n5k0vL+LwJUHESzlc?=
 =?iso-8859-1?Q?WAz1FOPROhIylOMAhmocwjizlkljCITjH6+62YImoLkRsIN3o8ybi0uKiW?=
 =?iso-8859-1?Q?DShWs5RhWrnXKiICIUaOeKQ5GsAwolQnSGoibSzIGfVyl9Qlb5pdUsNN+D?=
 =?iso-8859-1?Q?7i1SHYAndCWQNvxRUooNmQ8T1xRtAG7D14/VYE2skHxuylg4+V2IkZa/W8?=
 =?iso-8859-1?Q?MOVd+GNkcJv0DNeGut/gI+Qyh6gdt6NGKKar9NPYZxeZ6I7dVa3IHsyEws?=
 =?iso-8859-1?Q?ao8ZlcoDEKPax7bjt1gZXoQ7PZpW2A5PhObeNAgmWvUA1BII5aB3kxkq9k?=
 =?iso-8859-1?Q?Gc+SThuPVtCArk5ghf+auP67lMcYF7w3KiwTJEFJMNT9unlvct0o/i4vGy?=
 =?iso-8859-1?Q?sb+lSOZLwjN8QtP9/c479cBAKjYZqg4HRZVFNLoUx0ctcBuJteoNIDo0yd?=
 =?iso-8859-1?Q?wpM0EXlwy9QCDyuq415Wgv0+zxqXdZ5mcuxkA3zANBJyE3PICqdlF24bSk?=
 =?iso-8859-1?Q?gC/KKeRlmLpmCCjdoRzAi45K538sQOtLsvV6j8BTjatpD9yJCb28k74BmW?=
 =?iso-8859-1?Q?YA0NWq/ASGAJtxTo7dUbPHdj4i6nr2r23XEzOp/AxgIzoucdPVyUxA4XM3?=
 =?iso-8859-1?Q?iFJVoC7yUJ/jKDZOS6aMWVeZ2sJXhjA54hIK7o4hbzC70pKRIXuEuR7IIg?=
 =?iso-8859-1?Q?PsCAKnO/l79/DN3iiWUw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-1ff67.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c8370117-f3eb-4d4d-3c50-08db9517cf59
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 18:22:49.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7P223MB0669
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think in most cases, people doing shallow clones for testing mainline=
=0A=
> branch of whatever project they're hacking. If at some later date they=0A=
> wish to deepen their clones, they can do that up to specified date:=0A=
=0A=
Yup, that makes sense to me. And it would make sense if it was up to a spec=
ified date, but I specifically want to reference a branch (which could move=
 forward) so we can generate commits since then. =0A=
You could imagine it being useful as "docs since last released version" whe=
re you don't need a tag for it, you can reference the release branch.=0A=
=0A=
It's nice to be ably to rely on the fact that git refs can change, and so m=
y script can continue to work without needing an update every time.=0A=
I guess I could pull the ref and then use the date, but that (a) relies on =
nothing else happening around then, and (b) seems to be exactly what --shal=
low-exclude wants to do.=0A=
=0A=
> Thanks for the script that you provided.=0A=
=0A=
You bet. As a fellow engineer, I know how helpful perfectly reproducible st=
eps can be. :)=0A=
=0A=
-Benji=0A=
=0A=
