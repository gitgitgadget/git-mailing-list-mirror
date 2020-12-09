Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D5C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 18:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085EA23C8E
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 18:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgLISCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 13:02:38 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:55392
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730749AbgLISCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 13:02:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL6qk5Wk7aCnxA8bH+ictE7176ie1wdKVzRd6SqStXYKwIvWz1abdYOzfI2uO17BysTXsvm7jcT+fpTxHNkwTESsemuCQVLeO1OMapvOge3jN+j8oVucEvIwnc3300s3G3C/jPU/pVufw/rZHZVqhkR4M2J4GGGegyJahVJB46gg1rNzmTwGgR/umsBoUpKpBKE4OF10yrvjYs3D0tdkfE4gSN7muy/fU4Eu1sTAKGBZgh3oE+cmvM/yJMYUD7TUuEfFGdLUE5NllWTfN7riyfMBwlQ9Vz5jixPXzv9Hwa1EX37o8eTvtHq8NxBAUmWUjuYRN0/YXTt08Md2fAO7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHDQ35PURESWJql2uAmQci+uXLYCJYU1oP8Ihbsv72w=;
 b=VhccrtVq1GX2bar0/LqKq780Fr7xGPgEj306J9gUGM5/7JBQII0Ul12KKAelkTR6WhM1oO/FGrdqXxwaLSygmkaFbInsqBPtYq5bLVLKjoWBDRotH4S2junJxu2PtCDu9NYdifISBk+oeb3QtIQ/eyOJhLrm+yE04jkyHc7oULOj88nYydOyE7LR0XWA+G3JvkLiSxvaARtO6obQkk+f8bKNmR+C1z8Pd6WEDtcQTqKQcEjOLPLbfSWfGVRZ1dzObPSV60ufiuJL8xx51BK7DTauz/hKVfqlwzB9D1VjO8ZcNZrg+ZyAelfWXtQHXm9ZZsbEZWtW9sjgy5qrk0YJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ubisoft.com; dmarc=pass action=none header.from=ubisoft.com;
 dkim=pass header.d=ubisoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubisoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHDQ35PURESWJql2uAmQci+uXLYCJYU1oP8Ihbsv72w=;
 b=FT+C18V0AGCDorl1oUtmwYyuki9fhvYEKFzgofUX4COG92CrK9UUT3TQMK4dbwjRzNDw2BZirwCBJbO2YZBxi5B3P76K9kyu8oqN8IlXK1ODCNHEzF6A4I6+iSoVuVQ8Y/PM7AGfW6yDE7ZjlBdd2Rl9HY2c290tQlDl6M8uhecKYvrHaDbvKU8lT4a+IwDnIN/6L9NRtcJX9FTzTWCxZJSCTjuSWUmSSaXhhfADeqFbVEkTwPe5v3zcLTvtzMmOU3H7kSzCfBZ9Or2ZlNrLdQwDQ2ocRxHogj9Y1CxlzvubVSO62Oe947TwwYTEgbMDgz5nZ6y8j+0dTwsjEru0PQ==
Received: from BYAPR17MB2646.namprd17.prod.outlook.com (2603:10b6:a03:8a::22)
 by BYAPR17MB2824.namprd17.prod.outlook.com (2603:10b6:a03:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 18:01:37 +0000
Received: from BYAPR17MB2646.namprd17.prod.outlook.com
 ([fe80::9cf7:d8e5:d393:debe]) by BYAPR17MB2646.namprd17.prod.outlook.com
 ([fe80::9cf7:d8e5:d393:debe%6]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 18:01:37 +0000
From:   Julien Richard <julien.richard@ubisoft.com>
To:     Jeff King <peff@peff.net>,
        Julien Richard via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Julien Richard <jairbubbles@hotmail.com>
Subject: RE: [PATCH] doc: 'T' status code for git status
Thread-Topic: [PATCH] doc: 'T' status code for git status
Thread-Index: AQHWzgM0m6dCtOtQ3U2GJdYa7cI3FKnvB9CAgAAFM/A=
Date:   Wed, 9 Dec 2020 18:01:36 +0000
Message-ID: <BYAPR17MB26461C4578004C8C223249DB9DCC0@BYAPR17MB2646.namprd17.prod.outlook.com>
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
 <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
In-Reply-To: <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=ubisoft.com;
x-originating-ip: [90.113.108.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79556f22-4e74-4c7a-65be-08d89c6c78cd
x-ms-traffictypediagnostic: BYAPR17MB2824:
x-microsoft-antispam-prvs: <BYAPR17MB28240C810119E00EE0E0F1239DCC0@BYAPR17MB2824.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAgZymG1Pm7b8vSRklKUY7rxyHswdMBpIWd2QwmCNuZotEqBQPiSRVdnoHNhceB2S5dnWIwFCKJwBuShzqdiODuOntlboFd0ASvVNDo3wAFsoMHsIM5u4UQPRw8QvQ1teHrpArU2ZOL0+hk8VXkUzw+tIeMw7Y1+l2cvEOzu1DaAdsX8l1e+zKSFhmzYuh+tKksbHNxNWyH0WoeaDLcjvU3g1lwCloJuFXcyNuSy3SIi94HFhdPK1oDib53iDnlFuko9pXSFwy21g+u75Rva+ncoS0EEpUwQPbYPk+p7YysYtE9lH6G2pWYT5L6LFpVIAH+msjliUg2z8pckNsUGTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR17MB2646.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(76116006)(66476007)(54906003)(26005)(86362001)(52536014)(8676002)(66574015)(33656002)(508600001)(5660300002)(44832011)(66946007)(2906002)(66446008)(83380400001)(6506007)(8936002)(186003)(71200400001)(110136005)(4326008)(9686003)(55016002)(64756008)(66556008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y2ZJcVlEVjM3aEthQ2RhWmFNZFEyT21Ba3BST0xMbzkyVHZVUkRDeXMzSTVV?=
 =?utf-8?B?YjJHanJJcWN4MURXYmlma3lBaTU4aUNOZ1lvRTNDUWIzR1htTlM3QS93eWFB?=
 =?utf-8?B?UDE3dW1ERWNGN1pVNjFUMUdnWUtPczFKT05GWDd2OWUxU21nVDBOaEZHay9H?=
 =?utf-8?B?Q2NTejBRMm92MmZhV2k4WkxkaTdKVHA5NCtYQ2M3K3o1TDJIWGRTcmZZOUd2?=
 =?utf-8?B?K1lmVFV4SkdPQm9hZlRqZjhBbi91Vy9CWVFoVzRHTmJuQlFid0tTOGlKajFo?=
 =?utf-8?B?N25FZjFDb2c1VUI3T0pReFgzNGpYUm1lbzFQZjFwY0JNeDJBekRYakFYQVlk?=
 =?utf-8?B?U0Nicjk5ZlRqY3lMczljZnN5Nk80QXBjZ2d6QVJQaGI2TmZlOUdkUUtHeGFL?=
 =?utf-8?B?c2x2Y2xIdENzZkxjcEdJdzJYNlpSa1hLMUtUR0g3SUdtRWtPV3c0dEtYTjB4?=
 =?utf-8?B?VEhtVW52UjZ5Nm0ycnZoVmNuN0VWM2NqZjV1WVRqcXphUzAzcUQwejhHRHlw?=
 =?utf-8?B?RjNoNEVqeU9UMHVsdWNwSmc2dkE1OWRsbDdaVm50a2toR1RLSVBHblB5RVow?=
 =?utf-8?B?WlZPdk01dWE0aTVwZEVwalBYOXBacHdoZk5YK21EYm5TVnB0a2daRk9vR1RT?=
 =?utf-8?B?UlVLYVBvWE15aXhrQ3hnVXZQMzZYZUlOV3pNd1ZVTHM3azZQcE5KRkVyVVpY?=
 =?utf-8?B?MThneFhCdXM4T1NWWG5iOUQxdm8rVjM0OHVoYUw4VHJoOGZyS3FLdGFoL2Fz?=
 =?utf-8?B?U1krY3ZodGpOVGVjRDVkTWJ0VVFKaUp6elNmaEJ0ZnVxTWMyYzZLSHdheFls?=
 =?utf-8?B?MUs1R2pqZExldGtJdCtmalp1aXR5ZGM4ODg0YWt5QmkrVGNnL2R6ZGFMOCtK?=
 =?utf-8?B?RDVTNXJabGFCNFJ0UDkySXlVdjA4RURXVGtQTHd3VzlzWnpiZnFaUmpXOVp2?=
 =?utf-8?B?RDVtQVFpK3pHK3dqSGxXYVhoeWlTdDFHempJYWpHeENDSHRHZ0l2ZkllOWZt?=
 =?utf-8?B?bzRPWU05c0hReXBPTzdFUWpvVGJTTzNDYUVkV0xFZGR4eS9YbDhsMzQrVmRw?=
 =?utf-8?B?QzlIcHdIdlB3SnBiRFZGSnJ6ZGpRekpIKzI3UWVtQkdpRlYvVTVvVmxQSk5V?=
 =?utf-8?B?bFZqdGJMMzB0ZUl6TTM3T3VaTVJkZW14Z1A5N2pVdmhuOWorbXd3VzdnRHhD?=
 =?utf-8?B?aHZjK1JyelVlYkNidkdUaVJPRHp5eE00Z3dWbWJXS0tMSk5IQXdOeEFYcUdk?=
 =?utf-8?B?N0JCaXY3Wmp2TFlZbzIweWlTMVRuUFowRjNPb05KL205V0VadnUxNmxiNGlW?=
 =?utf-8?Q?pkwdoa1UKa2/g=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ubisoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR17MB2646.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79556f22-4e74-4c7a-65be-08d89c6c78cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 18:01:36.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e01bd386-fa51-4210-a2a4-29e5ab6f7ab1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25Q/WVk/6dU5EsPya+HZXH3QJso+zUh0sD+qUuUOGV04LwvYOMXih9e7FR8wKyw4Po/b7CgNL3Y5kUr9FZHb5IB2c2zv8i6NvUo4cRVmqPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR17MB2824
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBpcyBmb2xsb3dlZCBieSBhIHRhYmxlIHNob3dpbmcgdGhlIG1lYW5pbmcgb2YgdGhvc2UgZW50
cmllcyBpbiBlYWNoIHNsb3QuIFNob3VsZCB0aGVyZSBiZSBzb21lICJUIiBlbnRyaWVzIHRoZXJl
LCB0b28/DQoNCkFib3V0IHRoZSB0YWJsZSwgSSB3YXNuJ3Qgc3VyZSBob3cgdG8gZmlsbCBpdCBz
byBJIGZlbHQgaXQgd2FzIHNhZmVyIG5vdCB0byB0b3VjaCBpdCDwn5iJDQoNCiA+IFBlcmhhcHMg
InR5cGUgY2hhbmdlZCAoZS5nLiwgYSBzeW1ib2xpYyBsaW5rIGJlY29taW5nIGEgZmlsZSkiIHdv
dWxkIGJlIG1vcmUgZGVzY3JpcHRpdmUNCg0KSW4gZmFjdCBJJ20gbm90IHN1cmUgaG93IGdldCB0
aGUgdHlwZWNoYW5nZSwgSSBhbHdheXMgc2VlIHRoZSBzeW1ib2xpYyBsaW5rIGV4YW1wbGUgYnV0
IGluIG15IGNhc2UgIEkgaGF2ZSBhIDEwMCUgcmVwcm8gb24gYSByZXBvc2l0b3J5IGJ1dCBaSSBo
YXZlIG5vIGNsdWUgd2h5IGl0cyBkb2VzIHNvLg0KVGhlIGZpbGUgaXMganVzdCBtb2RpZmllZCBi
dXQgYXBwZWFycyBhcyBhIHR5cGUgY2hhbmdlIDotUw0KDQpDb3VsZCBpdCBiZSBhIGJ1Zz8NCg0K
QWJvdXQgdGhlIGNoYW5nZXMgeW91IG1lbnRpb25lZCBzaG91bGQgSSBtYWtlIHRoZSBhZGp1c3Rl
bWVudHMgbXlzZWxmPw0KDQpDaGVlcnMsDQpKdWxpZW4NCg0KLS0tLS1NZXNzYWdlIGQnb3JpZ2lu
ZS0tLS0tDQpEZcKgOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+IA0KRW52b3nDqcKgOiBtZXJj
cmVkaSA5IGTDqWNlbWJyZSAyMDIwIDE4OjM3DQrDgMKgOiBKdWxpZW4gUmljaGFyZCB2aWEgR2l0
R2l0R2FkZ2V0IDxnaXRnaXRnYWRnZXRAZ21haWwuY29tPg0KQ2PCoDogZ2l0QHZnZXIua2VybmVs
Lm9yZzsgSnVsaWVuIFJpY2hhcmQgPGphaXJidWJibGVzQGhvdG1haWwuY29tPjsgSnVsaWVuIFJp
Y2hhcmQgPGp1bGllbi5yaWNoYXJkQHViaXNvZnQuY29tPg0KT2JqZXTCoDogUmU6IFtQQVRDSF0g
ZG9jOiAnVCcgc3RhdHVzIGNvZGUgZm9yIGdpdCBzdGF0dXMNCg0KT24gV2VkLCBEZWMgMDksIDIw
MjAgYXQgMDg6MTM6MzZBTSArMDAwMCwgSnVsaWVuIFJpY2hhcmQgdmlhIEdpdEdpdEdhZGdldCB3
cm90ZToNCg0KPiBGcm9tOiBKdWxpZW4gUmljaGFyZCA8anVsaWVuLnJpY2hhcmRAdWJpc29mdC5j
b20+DQo+IA0KPiBHaXQgc3RhdHVzIGNhbiByZXR1cm4gJ1QnIHN0YXR1cyBjb2RlIHdoaWNoIHN0
YW5kcyBmb3IgInR5cGVjaGFuZ2UiLCBmaXhpbmcgdGhlIGRvY3VtZW50YXRpb24gYWNjb3JkaW5n
bHkuDQoNClRoYW5rcywgdGhpcyBpcyBkZWZpbml0ZWx5IGFuIG9taXNzaW9uIGluIHRoZSBkb2N1
bWVudGF0aW9uLg0KDQpJIHdvbmRlciBpZiB3ZSBuZWVkIGEgbGl0dGxlIG1vcmUsIHRob3VnaC4g
VGhlIGxpc3QgaGVyZToNCg0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1zdGF0dXMudHh0DQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vZ2l0LXN0YXR1cy50eHQNCj4gQEAgLTE5Nyw2ICsxOTcsNyBA
QCBjb2RlcyBjYW4gYmUgaW50ZXJwcmV0ZWQgYXMgZm9sbG93czoNCj4gICogJ1InID0gcmVuYW1l
ZA0KPiAgKiAnQycgPSBjb3BpZWQNCj4gICogJ1UnID0gdXBkYXRlZCBidXQgdW5tZXJnZWQNCj4g
KyogJ1QnID0gdHlwZSBjaGFuZ2VkDQo+ICANCj4gIElnbm9yZWQgZmlsZXMgYXJlIG5vdCBsaXN0
ZWQsIHVubGVzcyBgLS1pZ25vcmVkYCBvcHRpb24gaXMgaW4gZWZmZWN0LCAgDQo+IGluIHdoaWNo
IGNhc2UgYFhZYCBhcmUgYCEhYC4NCg0KaXMgZm9sbG93ZWQgYnkgYSB0YWJsZSBzaG93aW5nIHRo
ZSBtZWFuaW5nIG9mIHRob3NlIGVudHJpZXMgaW4gZWFjaCBzbG90LiBTaG91bGQgdGhlcmUgYmUg
c29tZSAiVCIgZW50cmllcyB0aGVyZSwgdG9vPw0KDQpJIHRoaW5rIGl0IGNvdWxkIGJhc2ljYWxs
eSBzaG93IHVwIGFueXdoZXJlIHRoYXQgIk0iIGNvdWxkLg0KDQo+ICAgICBHaXQgc3RhdHVzIGNh
biByZXR1cm4gJ1QnIHN0YXR1cyBjb2RlIHdoaWNoIHN0YW5kcyBmb3IgInR5cGVjaGFuZ2UiLiBJ
DQo+ICAgICBjYW4ndCBkb2N1bWVudCBtb3JlIHRoZSBiZWhhdmlvciBidXQgaXQgd291bGQgaGF2
ZSBoZWxwZWQgbWUgYSBsb3QgdG8NCj4gICAgIHNlZSB0aGF0IGxpbmUgaW4gdGhlIGRvY3VtZW50
YXRpb24gc28gSSBndWVzcyBpdCBjYW4gaGVscCBvdGhlcnMgdG9vLg0KDQpJdCBpcyBjb3JyZWN0
bHkgZG9jdW1lbnRlZCBpbiB0aGUgZGlmZiBtYW5wYWdlLiBUaGVyZSB3ZSBkZWZpbmUgaXQgYXMg
ImNoYW5nZSBpbiB0aGUgdHlwZSBvZiB0aGUgZmlsZSIuIEknbSBub3Qgc3VyZSBpZiB0aGF0J3Mg
cmVhbGx5IG1ha2luZyBhbnl0aGluZyBjbGVhcmVyIHRoYW4gInR5cGUgY2hhbmdlZCIuIDspDQoN
ClBlcmhhcHMgInR5cGUgY2hhbmdlZCAoZS5nLiwgYSBzeW1ib2xpYyBsaW5rIGJlY29taW5nIGEg
ZmlsZSkiIHdvdWxkIGJlIG1vcmUgZGVzY3JpcHRpdmUsIGJ1dCBJJ20gbm90IHN1cmUgaXQncyBu
ZWNlc3NhcnkuIChBbmQgaWYgc28sIGl0IHByb2JhYmx5IHdvdWxkIGJlIGJldHRlciBwbGFjZWQg
aW4gdGhlIGRpZmYgZG9jdW1lbnRhdGlvbikuDQoNCi1QZWZmDQo=
