Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991BEC49ED6
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9806198B
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFYPGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:06:18 -0400
Received: from smtppost.atos.net ([193.56.114.177]:14850 "EHLO
        smarthost2.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231781AbhFYPGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 11:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1624633438; x=1656169438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/XilL5cIqZ6R9q7g4JYnT8AhHMtjq24ZA52M0lXcFr8=;
  b=3wg4zMdJ+xVmZSNyaGHuElK6zpFZVJdbRZNgwBu2vayWfv+1QhR3nH8h
   9mbLVbYwxXF8eQe7HM8YFau7921ENh7IznH3UoV2nr4Tx2xtXxXLPd8xl
   gMvY7uQsdYnVIWF1Sr4OEJIXX/pSdl5f07WGUcdNtrhJ2754D0cRdPVZW
   M=;
X-IronPort-AV: E=Sophos;i="5.83,299,1616454000"; 
   d="scan'208";a="223735563"
X-MGA-submission: =?us-ascii?q?MDEVUOfkwDaDx3ndkI0SnHpPVnE0nuopYKP45J?=
 =?us-ascii?q?+zlAA5VoaFxqljez8L15Mk3Zusc3oDdi3cS33MgECVR9KnpIIMd6j+28?=
 =?us-ascii?q?fd9gzsMqNa1hMdIiTGXYLIyXHAgf0UbuMJN0mekSTNBz3p567+Hmz2lA?=
 =?us-ascii?q?g9?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB23.ww931.my-it-solutions.net) ([10.89.29.133])
  by smarthost2.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2021 17:03:55 +0200
Received: from GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) by
 GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 25 Jun 2021 17:03:52 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (172.16.214.169)
 by GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 25 Jun 2021 17:03:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5RrriQ84TEsTh6xhMblDiQYzGaNECvXjN28S40kD0ZCmSljUKoGyzkbslCa2jW6d1b52fjOWBCq2E0q/yBAjY0HC1VTxa9Cn5MGDHP77iHDti//W/kXIiu5M6pjnGPT968GgO9HsYBx7so5KPdk2mtEtB4UFjWjYUP1ynni0FX51slsl5ujgWyW8Hznrx28+9e6q+Js/nW/qLVDpaC1zhu0tOIe5s2I/FFI7LkTvkrKwD3At3NzWiFVS/vJ/44tlXJ2H5LnY7K4ndQYeW4OOHL17RlQUZe7vHLt+klQX63osw2eW9lt48Rd9p6MtOwFaeAulaXwDOu+dCgFdsItAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XilL5cIqZ6R9q7g4JYnT8AhHMtjq24ZA52M0lXcFr8=;
 b=grQTl0dZoMryHej6b0Wx6ODm7sWc4em97dLhEWd7KyJzU8lgx8+5s64XchzIeYWSh2jtcfW72WEDuhvpUXV/iJUH2BQ1g2vPVeSFpYVJm75a4Y1rLUOkC+UTZhIU5J25weD/CFfDiT9mEFEdaTc/LtDZs7Ay/afB2aSj8RK+UR1rQDiSFMjuu/itlgoFc6LTM+TxtExs/YOkXnGjnDpQ0cV9FFrO+lmBMnZIb6XIT37LSBs/WK1BFHuxelvGg1+LWnvV9EP5/Lx0tV1jzTBTNpmwhScPsCV+6HCC3gJC4McIjVFfon9QedP1WOakkYhUXwsLv37wWZfvoGUXaT2ANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AS8PR02MB7031.eurprd02.prod.outlook.com (2603:10a6:20b:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 25 Jun
 2021 15:03:52 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 15:03:52 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH] branch: make -v useful
Thread-Topic: [PATCH] branch: make -v useful
Thread-Index: AQHXWag/WYe07QB2/0W9Ak5Qtje+gasF3IIAgAAmXoCAArWBAIAA7xwAgAAR8YCAAB1uAIAABZAAgAAhDMCAAp/tgIAYPBNw
Date:   Fri, 25 Jun 2021 15:03:51 +0000
Message-ID: <AS8PR02MB7302119463FF6E69A58E82799C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
 <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60bf36f24d2e2_1a848720836@natae.notmuch>
 <AS8PR02MB7302955796AAEF8B9063505E9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60c18651e2e78_af4cf2086a@natae.notmuch>
In-Reply-To: <60c18651e2e78_af4cf2086a@natae.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-25T13:31:24Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=f4a16082-bb69-4c7b-9e5b-774433b407b4;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79d47092-a3a2-4208-caf8-08d937ea71ce
x-ms-traffictypediagnostic: AS8PR02MB7031:
x-microsoft-antispam-prvs: <AS8PR02MB703121856EE399F79A94678A9C069@AS8PR02MB7031.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Of8F2OhV2S1eg3TDQqQU0c/YauQld07Hy9OdV/PYIHOymnMuMN/fXasp7Wz7gsS8Rnd+kp2N/hF3KLUdjYkif36AamaCsdyrtl/F+3vtrrUy6UI99EutzTF+ZXb65Y15XwSHjemAjrr8Qz4tck30udQPOteZQ6FoW5zfZAHknCZ9Q60ynaOdVC/pQeBhWojBOXBQo5UfETulQhckJIUh5qOdB9aYTMfhO+wNVTFSfh9QoY6JSVzEugFbOUdUWXyh+nJ2UjqBJ6fd/nn1NpBLy1plj8NSxRymTGloumsSbVOZwj+ba9+kWNyZYRak6+k1u4hsvzqB7MTvMHMWR+PhLYPA6/27I9DxkDfwOl4L+RHrzVATeNyOOSEdugK4FQAIlAuSU4mlaIFQdr2bvuxOuGbJVtVUgMss8urwLauIjFVuqdVweciO5FtRLxfCkrICSc2aP29uo095ocmboXo14FPTPPB3PlGyh6hnjvFtTOLFwYn7mxj3lrSVUuS3rbkD0dhBYCxIztHSnT5Xtt+yYAWM4w0DvH0zrksEhpQlqocxecV4n/F0qmbFY0jLMQImPAPCbJx1hNCT58VbPT/mxnkTOIL6FvcWMwG+s0rFBTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(66946007)(4326008)(55016002)(76116006)(83380400001)(52536014)(64756008)(66476007)(66556008)(2906002)(9686003)(5660300002)(66446008)(122000001)(186003)(316002)(54906003)(110136005)(6506007)(478600001)(55236004)(8936002)(86362001)(26005)(38100700002)(71200400001)(8676002)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkt4bFE5eTVrSGNpSXE5VTFCZVI2ZnowQVFMcFFCQTlNc2pwYllvbTQ2N1lC?=
 =?utf-8?B?MnZqcm81UzZYaWRocFRwSHgzdFJ2Ky9xU2Z6RWo2Y2JmSkZOMllRdkVhY0NG?=
 =?utf-8?B?WkpaMTFWNTA2TnNBVGZ2V3J4SjZXZWUrT0NWbmRWTlhrSThhNUI2alpHYUZu?=
 =?utf-8?B?UGMrbzlQNjdPNWladEJRQ3VyQ1pzelI4dVRoNTN3bFd0UGxPUVhlTEUwZllp?=
 =?utf-8?B?bFdlcnNsYW1aVTNaeGttZmc0TVRCZjN6bnBsRFBhdEV2WTRCeFBDTmxLOGZm?=
 =?utf-8?B?UFJDSVdxYWxXZUJlOU5mM0NHaDJTbUx3UXhPWkZMM1dKNFBrUkN4RnJMTkR5?=
 =?utf-8?B?NmhFRTZnejRjZTkvZ29jdng2WjdDRGh2dy8xWThKbm9YRGROZURsUU1OaVZz?=
 =?utf-8?B?dk04dnZManpxQXpuRTJOZm54ZVR4bmw5QzQrSnpBLzNxYXVIQWlFa2phM1RU?=
 =?utf-8?B?Qk5mNXJpZ3RmcCt1MSsrc3ZMQTRIZnBzbjJ2d3pWNmZCM1Y1cE5YbVErQk1I?=
 =?utf-8?B?c3JrTDEwQXNFN3VMQ3JZMkw5dHNyOHcvbTM1cGJwS1M3Y00zVTRiVkdTV1VC?=
 =?utf-8?B?d1M0K1FGOWlVR3FkR0hNNms0ZHp5ZU9ZT2RvbzEyTTZIbEdyeXY0N0VYUkxw?=
 =?utf-8?B?Rk5keGFHMFh3UW5vSjFYUDhub0NVRG5QTWtpZk5ydFVHMGZ2eS9NOGlraEx0?=
 =?utf-8?B?RU42SEtkZ1VvNHFLKzZqTmdxZGY0N0RkSmJLazFraytRVUxBQ3ZkSHFHR1ds?=
 =?utf-8?B?SHlkcDNKY04xZm1IWldmMURrYVpYL25Cek93LzY3elQxbFlKMjE5Sk82Wkg4?=
 =?utf-8?B?NCtUZUMzaXAvc01HUFZOZElWSGdtRWxObTJaQnJJa1kwYkZJUm1BUW9ScDVI?=
 =?utf-8?B?eUVCQSsvUDJrTkFLNkEwM0d0cDJzYW1BWENaQ3NmQlJpSzU5c010U0txYWdB?=
 =?utf-8?B?ZU9VdVlTY3pvZDJWOUJPdEdRSE1oMWxleWZFeHZHSG9HZTFzeDBBT2Rod3B5?=
 =?utf-8?B?TXBwNitLSnRJNDcwZW1rQ1FrSFV0dTdHejNlVTI3MEJienhjRjJoYklCZUVT?=
 =?utf-8?B?NUhzSjJ0MVpTcDI5WFFQbDl1bnE5YStBbTFKMjNyUnBJZkg4QkNvbDllOWpl?=
 =?utf-8?B?S3ZzVlkrUUtNaFB6Tnl0WTUyczd2KzNta1lpYjN6ZXFYU2x2b0lMRWhqcHd4?=
 =?utf-8?B?SnJvaGhseU9oNnNDU0RJQnVpOGo3UXNHdEMwSmxPSUhpOC9KWUhyL1RQZW9Y?=
 =?utf-8?B?UVVoSm9ha1ovWk1OV29oUDJGODNVVFc0STJHZVdWQXhERWFxQUEyWkdOcUF5?=
 =?utf-8?B?MDVvN1RsNUd4ekd1YllWTWFBOCsvc2dmbEJvQUFvWGhGbFZqdnJ3N3R1d2dr?=
 =?utf-8?B?MlI0OHF4N3VIei9NMGVLVlZ3L2pubU1zY0R2YWZLMFdYeW5KeFZxMFpodW94?=
 =?utf-8?B?WUkzSDl1eDBNZzFUNCt3cTZPQ2xtOEFpaStpVHVQa3FiTlQrelI1dDQ4NW1N?=
 =?utf-8?B?c1pKMkxPVktJVXQ5ZUtLbjNLN0REbE9WYndGYjVPQ3Jod0RDaTMwY1R2Wkcw?=
 =?utf-8?B?NkdsaURlWlNtbnQzNGI4aW9GMTJKNVh2VlNEK0gvaGhMZkFWbCt0SG9uWllQ?=
 =?utf-8?B?WWJTZWVXOHFubGFnYytDWGswdWhuSERXV1lHZE5BTkFWNTVhaHNXTDBueit4?=
 =?utf-8?B?Um1KZzJxV0hLRmFtZVYwVUpsSStnU0xsYTRhZFc0dis3Ti9acTY5YWNuc1Vr?=
 =?utf-8?Q?wlqGQHTdknIAUv9Op0QP8gy23i35OICYbEsDgFW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d47092-a3a2-4208-caf8-08d937ea71ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 15:03:51.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oi4RwYpFA9R1NH7bgNOSndFI+vLhYna+yljC8i32/cVLqVe4LzNsMvcDF0tHuL1MqQV5EDzfr/QEhiewjoGc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7031
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IEZyb206IEZlbGlwZSBDb250cmVyYXMgPGZlbGlwZS5jb250cmVyYXNAZ21haWwuY29tPg0K
PiBTZW50OiAxMCBKdW5lIDIwMjEgMDQ6MjYNCj4gDQo+IEtlcnJ5LCBSaWNoYXJkIHdyb3RlOg0K
PiA+ID4gRG8geW91IGFsd2F5cyBwdXNoIHRvIHRoZSBzYW1lIHJlbW90ZSBicmFuY2ggeW91IHB1
bGwgZnJvbT8NCj4gDQo+ID4gW1JLXSBZZXMuICBUaGVyZSBhcmUgdHdvIHBlb3BsZSBkb2luZyBt
b3N0IG9mIHRoZSB3b3JrICwgbWUgYW5kIG9uZQ0KPiBvdGhlci4gIFdlIGVhY2ggbW9zdGx5Og0K
PiA+IFtSS10gIDEuICBBcmUgbm90IHdvcmtpbmcgb24gdGhlIHNhbWUgdGhpbmdzLiAgSWUgd2Ug
ZG9uJ3QgZ2VuZXJhdGUNCj4gPiBtYW55IGNvbmZsaWN0cyBbUktdICAyLiAgUHVsbCBhbmQgcHVz
aCB0byB0aGUgc2FtZSBicmFuY2guICBJZSBlYWNoIG9mDQo+ID4gdXMgaGFzIGEgYnJhbmNoIHRo
YXQgd2Ugd29yayBvbi4gIEhlIHVzZXMgIm1hc3RlciIsIEkgaGF2ZSBteSBvd24gKEl0DQo+ID4g
aXMgYSBzaW5nbGUgdmVyeSBsb25nLWxpdmVkIGJyYW5jaCAtIEkga25vdyB0aGF0IGlzbid0IGEg
cmVjb21tZW5kZWQNCj4gPiB3b3JrZmxvdyBidXQgdGhhdCdzIHdoZXJlIHdlIGFyZSBmb3IgdGhl
IG1vbWVudCkNCj4gDQo+IEkgY2FsbCB0aGlzIGEgdHdvLXdheSB3b3JrZmxvdy4NCiANCk9rLCBJ
J20gIG5vdCBzdXJlIEkndmUgaGVhcmQgb2YgdGhhdC4NCkJ1dCB0aGVuIEkndmUgbm90IGxvb2tl
ZCBpbnRvIG9wdGlvbnMgZm9yIHdvcmtmbG93LiAgSSd2ZSBqdXN0IGFkYXB0ZWQgYW4gZXhpc3Rp
bmcgb25lIGZvciBHaXQuDQoNCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSBlYWNoIG9mIHlv
dSBoYXZlIHlvdXIgb3duIGJyYW5jaCwgYnV0IHlvdSBib3RoIHB1bGwNCj4gYW5kIHB1c2ggdG8g
eW91ciBjb3JyZXNwb25kaW5nIGJyYW5jaCAoaGUgdG8gaGlzIGJyYW5jaCwgeW91IHRvIHlvdXIN
Cj4gYnJhbmNoKS4NCg0KWWVzLg0KDQo+ID4gPiBIb3cgYWJvdXQgcmViYXNpbmcgb3IgbWVyZ2lu
Zz8gRG8geW91IHVzZSB0aGUgc2FtZSByZW1vdGUgYnJhbmNoPw0KDQpTZWUgYmVsb3cuLi4uDQoN
Cj4gPiBbUktdIE1lcmdlcyBhcmUgaW5mcmVxdWVudCwgYnV0IGJlY2F1c2Ugd2UgYXJlIHdvcmtp
bmcgaW4gZGlmZmVyZW50IGFyZWFzLA0KPiB3ZSBtZXJnZSB0byAib3VyIG93biIgYnJhbmNoIChm
ZXcgY29uZmxpY3RzLCB1c3VhbGx5KSBhbmQgcHVzaCB0byBpdHMNCj4gcmVtb3RlLg0KPiANCj4g
VGhpcyBpcyBjcnVjaWFsLiANCg0KSXMgaXQgPw0KDQo+IElzIHRoZSBsb2NhbCBhbmQgcmVtb3Rl
IGJyYW5jaCBhbHdheXMgdGhlIHNhbWU/DQoNClllcy4NCg0KPiBJbiBvdGhlciB3b3JkczogZG8g
eW91IGFsd2F5cyBwdWxsIGZyb20gIm9yaWdpbi90b3BpYyIsIGFuZCBwdXNoIHRvICJ0b3BpYyI/
DQoNClllcy4NCg0KPiBPciBkbyB5b3Ugc29tZXRpbWVzIHB1bGwgZnJvbSBhbm90aGVyIGJyYW5j
aD8NCg0KTm8uICBKdXN0IHRoZSBzYW1lIG9uZSBlYWNoIHRpbWUuDQpUaGVuIG9jY2FzaW9uYWxs
eSBtZXJnaW5nIHRvIHJlY29uY2lsZSBhbnkgYXJlYXMgd2hlcmUgd2UgaGF2ZSB0b3VjaGVkIHRo
ZSBzYW1lIGZpbGVzLg0KDQo+ID4gW1JLXSBJIGhhdmUgbmV2ZXIgeWV0IGRvbmUgYSByZWJhc2Us
IGJ1dCBuZWVkIHRvIGRvIHNvIHNvb24gYXMgdGhlcmUgaXMNCj4gd29yayBpbiBhbiBhcmVhIHRo
YXQgd2UgaGF2ZSBib3RoIHdvcmtlZCBvbi4gIFRoZW4gaXQgd2lsbCBiZSBwdXNoZWQgdG8gdGhl
DQo+IHVzdWFsIHBsYWNlIC0gaWUgdGhlIHR3byBicmFuY2hlcyBtZW50aW9uZWQgYWJvdmUuDQo+
IA0KPiBXaGVuIHlvdSBpbnZvbHZlIGFub3RoZXIgYnJhbmNoIGlzIHNvdW5kcyBsaWtlIHlvdSB3
aWxsIGJlIGluIGEgdHJpYW5ndWxhcg0KPiB3b3JrZmxvdy4NCj4gDQo+IFlvdSB3b3VsZCBiZSBm
ZXRjaGluZyBmcm9tIHJlbW90ZSBicmFuY2ggQiwgbWVyZ2luZyB0byBsb2NhbCBicmFuY2ggQSwg
YW5kDQo+IHB1c2hpbmcgdG8gYSByZW1vdGUgYnJhbmNoIEEuDQo+IA0KPiA+IFtSS10gU28gYmFz
aWNhbGx5LCBubywgbm90IHRyaWFuZ3VsYXIgYXQgYWxsLCBpZiBJIHVuZGVyc3RhbmQgdGhlIG1l
YW5pbmcgb2YNCj4gdHJpYW5ndWxhciAocHVsbCBhbmQgcHVzaCB0byBkaWZmZXJlbnQgcmVtb3Rl
cykuDQo+IA0KPiBObywgb25jZSBhZ2FpbjogdHJpYW5ndWxhciB3b3JrZmxvdyBkb2Vzbid0IG5l
Y2Vzc2FyaWx5IGludm9sdmUgYSBkaWZmZXJlbnQNCj4gcmVtb3RlIChhbHRob3VnaCBpdCB1c3Vh
bGx5IGRvZXMpLg0KPiANCj4gWW91IGNhbiBwdWxsIGZyb20gYnJhbmNoIEIgZnJvbSBhIGNlbnRy
YWwgcmVwb3NpdG9yeSwgYW5kIHB1c2ggdG8gYnJhbmNoIEENCj4gZnJvbSB0aGUgc2FtZSByZXBv
c2l0b3J5LCBhbmQgdGhhdCB3b3VsZCBiZSB0cmlhbmd1bGFyLCBub3QgdHdvLXdheS4NCj4gDQo+
IA0KPiBJdCdzIHVuZGVyc3RhbmRhYmxlIHRoYXQgdXNlcnMgYXJlIGNvbmZ1c2VkIGFib3V0IHRo
aXMtLXNpbmNlIGluIGZhY3QgbWFueQ0KPiBkZXZlbG9wZXJzIGFyZSBjb25mdXNlZCB0b28uIEl0
IHdvdWxkIGJlIG5pY2UgaWYgZ2l0IGhhZCBzb21lIGRvY3VtZW50YXRpb24NCj4gYWJvdXQgdGhl
IGRpZmZlcmVudCB3b3JrZmxvd3MsIGFsYXMgaXQgZG9lc24ndCBhdCB0aGUgbW9tZW50Lg0KPiAN
Cj4gQmFzaWNhbGx5IGluIG15IHZpZXcgdGhlcmUgYXJlIGZvdXIgd29ya2Zsb3dzOg0KPiANCj4g
ICAxLiBDZW50cmFsIC0gdHdvLXdheTogcHVzaCBhbmQgcHVsbCB0aGUgc2FtZSBicmFuY2hlcyBm
cm9tIHRoZSBzYW1lDQo+ICAgICAgcmVwby4NCj4gICAyLiBEaXN0cmlidXRlZCAtIHR3by13YXk6
IHB1c2ggYW5kIHB1bGwgdGhlIHNhbWUgYnJhbmNoZXMsIGJ1dCBmcm9tDQo+ICAgICAgZGlmZmVy
ZW50IHJlcG9zaXRvcmllcyAobWFzdGVyIDwtPiBvcmlnaW4vbWFzdGVyLA0KPiAgICAgIHRvcGlj
IDwtPiBnaXRodWIvdG9waWMpDQo+ICAgMy4gQ2VudHJhbCAtIHRyaWFuZ3VsYXI6IHB1c2ggYW5k
IHB1bGwgZGlmZmVyZW50IGJyYW5jaGVzIGZyb20gdGhlDQo+ICAgICAgc2FtZSByZXBvLg0KPiAg
IDQuIERpc3RyaWJ1dGVkIC0gdHJpYW5ndWxhcjogcHVzaCBhbmQgcHVsbCBkaWZmZXJlbnQgYnJh
bmNoZXMgZnJvbQ0KPiAgICAgIGRpZmZlcmVudCByZXBvc2l0b3JpZXMuDQo+IA0KPiBJdCBzb3Vu
ZHMgdG8gbWUgeW91IGFyZSBtb3N0bHkgaW4gIzEsIGJ1dCBzb29uIGRhYmJsaW5nIGludG8gIzMu
DQogDQpJIHRoaW5rIHdlIGFyZSBqdXN0IGRvaW5nICMxLg0KV2UgbW92ZWQgYSBmZXcgeWVhcnMg
YWdvIGZyb20gU3VidmVyc2lvbiB0byBHaXQuICBCZWZvcmUgdGhhdCB3ZSB3ZXJlIG9uIENWUyAo
YWN0dWFsbHkgQ1ZTTlQpLiAgVGhvc2UgYXJlIGNlbnRyYWxpemVkLCB3aXRoIG1lcmdpbmcgYW5k
IGJyYW5jaGVzIGFsbG93ZWQsIGJ1dCBub3QgZGlmZmVyZW50IHJlcG9zLg0KT3JpZ2luYWxseSBh
bGwgdGhlIHdvcmsgcHJvZHVjZWQgYSBzaW5nbGUgZmluYWwgcHJvZHVjdCBpbnN0YWxsZXIuICBT
aW5jZSBteSB3b3JrIGFuZCBoaXMgdHVybmVkIG91dCB0byBiZSBvbiBkaWZmZXJlbnQgcmVsZWFz
ZSBjeWNsZXMgaXQgd2FzIGNoYW5nZWQgc28gbm93IHRoZXJlIGFyZSB0d28gc2VwYXJhdGUgcHJv
ZHVjdHMuDQpNeSBwYXJ0IGhhcyBzb21lIGRlcGVuZGVuY2llcyBvbiBoaXMsIHNvIEkgbmVlZCBv
Y2Nhc2lvbmFsbHkgdG8gaW5jb3Jwb3JhdGUgaGlzIGNoYW5nZXMgaW50byBteSBicmFuY2guDQpJ
IG9jY2FzaW9uYWxseSBjaGFuZ2VzIGZpbGVzIHRoYXQgd2lsbCBnbyBpbnRvIGhpcyBmaW5hbCBw
cm9kdWN0LCBzbyB0aGVyZSBpcyB0aGVuIHRoZSBvY2Nhc2lvbmFsIG1lcmdlIGZyb20gbXkgYnJh
bmNoIHRvIGhpcy4NCg0KQWN0dWFsbHkgbWF5YmUgdGhlcmUgaXMgc29tZSAjMy4NCkFmdGVyIG1l
cmdpbmcgaGlzIHRvIG1pbmUsIHRoZW4gbWluZSBiYWNrIHRvIGhpcywgSSB3aWxsIHB1c2ggYm90
aC4gIERvZXMgdGhhdCBtYWtlIGl0ICMzPw0KDQo+IENoZWVycy4NCj4gDQo+IEZlbGlwZSBDb250
cmVyYXMNCg0KUmVnYXJkcywNClJpY2hhcmQuDQoNCg==
