Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E867C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0164E57
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhCLWN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:13:58 -0500
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:26784
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235457AbhCLWN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:13:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P62XAZsg5oPxWKkHvi6TjkGyevKb7zafeBTOBzCMB08yWc4cGHDgnME72pfAFhl91K1V4cYuDR0IVG8jXRto5d4l+1txhpTnMsyNXuGN0YYjvMbYQiLRk2tyoB3IkbnhBAUraJiB1fGg8Xawc/VksswPqyq5Zo5P7qDh+ZfRZcEjjjDAjxqyyEeXOET65mR7QWOtShEMCoBmt8AvJ0IbHF2fOAlOQNM3nkwY9F9qHVU4WO0CQloCBg/K/ZjtpFEn1clWsyYsFgFYFL29+p+L81mAge5E0OPnhYzbdxSHRmcots9qoEQSrLjTd3PqFmuiszur0FkPVFQGhCtcu/Lv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8b79/EOsg+uG1TEPAjLWgWenE33fKnounPU7cSJe0w=;
 b=ZAG94CUu7RxJYmsAltT4qdos+YdQGfTGFPkhgnO8NkmxhtGq10kHZhqKPZEuHVpsaWJv8FffsULCBEqWFkKHyZMzwwyWTzJnk4Yji3vW6egipf64Y7tUFqt4KnUoSPtpNFe2egoMS9zf4pe3NBByOs3x2Bea68bovb8P2aDSHPGE15t4OIyZTdnX/ADOSzT2no4SC353jE/wDYR8dae5+1iolCI3WKeh7FR/cFmXEbNSXUvfBMQCHlxKcuWnI4KYaWSssNl3wFhNsV3IfqfKh8pShlokgHbf/WhqFEu3DT+PY6zGduFTEPJx6KJU0IKdBknjP3u3UvuV7qLcIFrWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metacase.com; dmarc=pass action=none header.from=metacase.com;
 dkim=pass header.d=metacase.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metacase.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8b79/EOsg+uG1TEPAjLWgWenE33fKnounPU7cSJe0w=;
 b=A4vldi8UlJWadjWfeVNStfc8/bfDfCEPpKaapVasbRCYYul3/PWHkCHEOjtdssqux0UNolVpCynwsdsB+NgqPxadGkqDshBYs6M2d0nRGa2Urot2fyW1lVUkqsGr8IJ+3UDTUg3eEc5NU8fdbGifv2uEqlwlXdvSCJc64VMCqKZElahW0D7PW+Dz0eKsbouPDKIQAUmEwOd+DaWYN7GN9WdZeqQ8JxeGNb3tpITtqbd8yKEZvh4bGglw/hArvD09S+Lyc66bvrSwxShYd5LjeGs6uDJYuF7nNGz8hD1LMRpjqY0RG1okHr+croJsQz1LzDsfEXzY7GybcfAP1tvHAQ==
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:174::13)
 by AS8P194MB1368.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Fri, 12 Mar
 2021 22:13:49 +0000
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::38e0:3102:a7bc:6528]) by AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::38e0:3102:a7bc:6528%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 22:13:49 +0000
From:   Steven Kelly <stevek@metacase.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
CC:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: [BUG] Error adding 2+ files after init --shared on Windows with
 fscache
Thread-Topic: [BUG] Error adding 2+ files after init --shared on Windows with
 fscache
Thread-Index: AQHXF4SiHrit0VJ9SwaVJXHYg1vuPKqA6bNA
Date:   Fri, 12 Mar 2021 22:13:49 +0000
Message-ID: <AM7P194MB0900EF9C0B19A1382652A669A66F9@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
References: <AM7P194MB0900C227791B8B7AA1D34DBEA66F9@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
 <YEvZnm1z7nm6ctHA@camp.crustytoothpaste.net>
In-Reply-To: <YEvZnm1z7nm6ctHA@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=metacase.com;
x-originating-ip: [91.157.220.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f869cb74-de4a-432f-a1b7-08d8e5a41d07
x-ms-traffictypediagnostic: AS8P194MB1368:
x-microsoft-antispam-prvs: <AS8P194MB13688165D550CF8AE09C166FA66F9@AS8P194MB1368.EURP194.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFS+e21kz+Wepqa3Oo1kxNVcyMPK2GupP5uyfSR66Fte2+qxlTirA0yhCsOu2k4nh/eMliB5FT8x8s7sUEq3NqY1RoQuQNPh/XYoVAtpIOwIGGTWM7hJIW/UdmgNQBp4FxS1CwkhVuZg7PIkMbV4uJsrb0tAan80IeVkt+c/iNibKbecLrrrcHs3wwFhKlJUj4lxI95lvZ9IyvZx+RGT8G0Xbcpgke7OjWa2Sr9MYcc/JV+Uh6jsRBP7nteqO37ASHwQisAJ7BjgzAFm/l1uk92DHEUiVI4x9+116Hn9/7rU7BmwrVS/YufMPGgO0rEwkTaCuzd75043qc9ooT1aT6JnYcwwgca4cnmDJ2qjLQYNE/OrOak/RArTbLEenM9q5xstbDUjtdXF7INZYeI7U/bjvsRv8wyBVKZTeXb/IW84hOF0WVtd1D/+tEqXmhiITQVVFNlpG3N/Qv9/kJ+CKmArTBi97Nz2lHZn/rOp3VnV7xYurmDhKFcL9+gAEETmApMUOpDK/+tC2m1j0LSpT7AqQc92GmEa5/n5rzO889H+a0fEo6rHmeHLqhhMv7a71IBxZrDgJAgtBoBIMng/ejS3+l0Pm8xIHE2h0s1wvj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P194MB0900.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(34036004)(376002)(136003)(366004)(396003)(39830400003)(6506007)(5660300002)(52536014)(66476007)(64756008)(66446008)(66556008)(6916009)(316002)(55016002)(53546011)(86362001)(2906002)(26005)(8676002)(4326008)(8936002)(33656002)(186003)(76116006)(9686003)(71200400001)(966005)(7696005)(66946007)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SE5KMG5YYXBrdGVpZHdaUGdicGR4b0c4cmlyRXBPZXNKZ0R0TWVVUTA2Tk90?=
 =?utf-8?B?ZkR0YmROWExRU3R6MHlSNGRjVFQ3N0g4RGRBSUFDcEpMOWx1eWdGWFMrRzVI?=
 =?utf-8?B?NFZCQjhMWG1ISXRROGg0eHhDK3NjU0U4Z2h0YU5kdVliN29iK1BCY1hmeUZu?=
 =?utf-8?B?Rmx3RmdQT0xXb3F4VEJDL2VCUXVBM1N4RTdWNnh3K01xbWVhNkZEb2Q2T1E3?=
 =?utf-8?B?UzV0YmpoOHR0bzNpd0ZDZlZKVHEzWm9MWnIzQmdGeTNEVkcyd1gzZTRuZHFa?=
 =?utf-8?B?VG84d1VFNkxCaWhVZkV3MU9kbUZJQUxJdDlsQlgveE45ZS85NDk3cFlud2x4?=
 =?utf-8?B?THVRVlB5RFpKQzlwb25CVm41M04zSEgyTzdHQUxRVklqRTJVb1d6VTZKVmxX?=
 =?utf-8?B?cXFwVGEwZE83blBuaFBESHZZOVQyamZUS2k3ZUh6aDc2cjJiUWhRTDRIdnpv?=
 =?utf-8?B?ZGlDcHQ0cXoxbVFCOWp5VEF2cVROYWg2SFdUU013dVJMbGhDUDh0ZEJKOVA3?=
 =?utf-8?B?U1VIaEhPdk1odmw2R3JLZFA2aWIySlNDK3JINTBQUUZKN083c3JaK0Y5aml2?=
 =?utf-8?B?SS81cC9Gd3pXK09TNkV0eTgyVCsxcEtJWlZYcm5FdEdKQWpSY2QzOTBZYUgx?=
 =?utf-8?B?N1V1MWxlN1RDNmNnbjBRZjVPTXhsQXBBNTdmSCtnZUpSOXJlanlFa3c4TC92?=
 =?utf-8?B?bE1jZnZuUXN0UVB0N09sRjAwRGJrTjFFZEc3UTExZXlJTzNvd3RwcDd6QkYx?=
 =?utf-8?B?czdoU1JqVlMvQkIxSUVFcUNDb0Q3Rmp5NXFibXFBTmtiWjNMUzdweWdLRmY5?=
 =?utf-8?B?ZWF4L2pUMlZDOHlMWUxDQjhEbWNuNXdGS0Fnc0hhbkdHV2s3a2VlNFQ2a2pH?=
 =?utf-8?B?ZEZJS3Zxa2VnRXdpdFpsdkhmWlFGM21FWUdoS0gzdWVmQjVDNlpSOVY5UG5M?=
 =?utf-8?B?UzFNZFRnSGF0TjJZb2V1ZzNET3BQb3V0bWNxeWZ1V2FHNkZ4T1psbzROa1E0?=
 =?utf-8?B?WDNiK3JGVnJiTGhubGJBMlVjODF5K2hrMk9iY1NMRVhYZnRzY1p5Z0lvODBj?=
 =?utf-8?B?RDVYOUlNZHlxMlVuUjNpSnNBKzVvWWtRRGlTaFNJcFF6MGxwZjRRZk93Lytx?=
 =?utf-8?B?MDlDbDVjL2libUppcHdYV2hQSE5wUHNWakJneHlvczB2ZG9aTHZxSUl3b29m?=
 =?utf-8?B?TzJDVTU3Qmt3YkRmRGwzZzVkQ2ZWZVkyRGNEbHFqMG0zNjZXMVRCRzFNZ1dH?=
 =?utf-8?B?aUMwelIwQ2w4Y2IyNFEvWUlaUk9zYUVJMlpJbTF1V00wUG1LT2g3WFd1ekp1?=
 =?utf-8?B?czdLNExtQU1Sb0Qvdk5wemRwVGNaNE9KY2t1YllabmErdy9WSTdxcndkaDV1?=
 =?utf-8?B?cHB5d3VuY2R5ajRrSVMyanowWituUzhYKzl0SThGc0N5SEs5czREbmx2YWNC?=
 =?utf-8?B?a0Z1SU9GQVQvbDZhOW4zTUFRcmVLTmt3T2FHUHkvTmdIYXBPT0FOVU5IS2tL?=
 =?utf-8?B?NHZsTXF0ZUZBdlp4VzAwVGd1R1YyTlM0dUFXcmZZcHdJb2ZBOXVxRlNBTkZQ?=
 =?utf-8?B?bzdISDk2UzJjYVpqbzN5d241ZUlMeWJoK1RQaG9HMkwxRXdJaERKcnNwNitv?=
 =?utf-8?B?a1pubWx1bnhxMkJiTFhnOWFwYkZaaDRDU1FxOGpwOEVGQ1FlS2hYa3NGd2xO?=
 =?utf-8?B?cGN1bEtUZWt0eGNNck5CcjVLNnFHWDQ1RnQ1ck5vUXVNSlYrSEdZcXMzZmhE?=
 =?utf-8?Q?4EbZfvJvLG6p/6scgfNnTI5Msvb2HxX42DnWKbw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: metacase.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f869cb74-de4a-432f-a1b7-08d8e5a41d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 22:13:49.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: df11bd32-ec93-4612-a601-51081dffef74
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LMGx2aDTiOS/hAeldqBgMtG24eY68LJWjsBZkAXB9Re/9wUMHkiW7n4aQ3MXQ2+Z7PAjJL6h+zT7agQxlNVaxTjdbaQhM2SBUDcQTRD9WrttowYX47eSctejjGPWwhR/lZn4dWXxuDMCFHvyne9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB1368
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMjAyMS0wMy0xMiBhdCAyMToxNDowMCwgYnJpYW4gbS5jYXJsc29uIHdyb3RlOg0KPiBPbiAy
MDIxLTAzLTEyIGF0IDE1OjUyOjQzLCBTdGV2ZW4gS2VsbHkgd3JvdGU6DQo+ID4gV2hhdCBkaWQg
eW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVwcm9kdWNlIHlvdXIN
Cj4gaXNzdWUpDQo+ID4gQ2xlYW4gaW5zdGFsbCBvZiBHaXQgb24gV2luZG93cyAxMCB1c2luZyBk
ZWZhdWx0IG9wdGlvbnMNCj4gPiBnaXQgaW5pdCAtLXNoYXJlZA0KPiA+IGVjaG8geD54DQo+ID4g
ZWNobyB5PnkNCj4gPiBnaXQgYWRkIC1BDQo+ID4NCj4gPiBXaGF0IGRpZCB5b3UgZXhwZWN0IHRv
IGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQ0KPiA+IFRoZSB0d28gZmlsZXMgYXJlIGFkZGVk
IHdpdGggbm8gZXJyb3JzDQo+ID4NCj4gPiBXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwg
YmVoYXZpb3IpDQo+ID4gZXJyb3I6IHVuYWJsZSB0byBjcmVhdGUgdGVtcG9yYXJ5IGZpbGU6IE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gPiBlcnJvcjogeTogZmFpbGVkIHRvIGluc2VydCBp
bnRvIGRhdGFiYXNlDQo+ID4gZXJyb3I6IHVuYWJsZSB0byBpbmRleCBmaWxlICd5Jw0KPiA+IGZh
dGFsOiBhZGRpbmcgZmlsZXMgZmFpbGVkDQo+ID4NCj4gPiBXaGF0J3MgZGlmZmVyZW50IGJldHdl
ZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkNCj4gaGFwcGVuZWQ/DQo+ID4g
VGhlIGFkZCBjb21tYW5kIGZhaWxzIHdpdGggYW4gZXJyb3IgJ3VuYWJsZSB0byBjcmVhdGUgdGVt
cG9yYXJ5IGZpbGUnDQo+ID4NCj4gPiBBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoNCj4g
PiBJZiBJIG9taXQgLS1zaGFyZWQsIHRoZXJlIGlzIG5vIGVycm9yDQo+ID4gSWYgdGhlcmUgaXMg
b25seSBvbmUgZmlsZSwgdGhlcmUgaXMgbm8gZXJyb3INCj4gPiBJZiB0aGUgZWNobyBjb21tYW5k
cyBkbyBub3QgaGF2ZSBjaGFyYWN0ZXJzLCBqdXN0IGFkZGluZyBhIGJsYW5rIGxpbmUsDQo+IHRo
ZXJlIGlzIG5vIGVycm9yDQo+ID4gSWYgSSB0dXJuIG9mZiBmc2NhY2hlLCB0aGVyZSBpcyBubyBl
cnJvciAoZ2l0IGNvbmZpZyAtLWdsb2JhbCBjb3JlLmZzY2FjaGUgZmFsc2UpDQo+IA0KPiBTZWVp
bmcgdGhpcyBkZWZpbml0ZWx5IG1ha2VzIG1lIHRoaW5rIHRoaXMgc2hvdWxkIGJlIHJlcG9ydGVk
IHRvIHRoZSBHaXQNCj4gZm9yIFdpbmRvd3MgcHJvamVjdCAoaHR0cHM6Ly9naXRodWIuY29tL2dp
dC1mb3Itd2luZG93cy9naXQpIGJlY2F1c2UNCj4gdGhhdCdzIGEgbm9uc3RhbmRhcmQgb3B0aW9u
IHRoYXQncyBzcGVjaWZpYyB0byBXaW5kb3dzLiAgSSBkb24ndCB0aGluaw0KPiBhbnlvbmUgaGVy
ZSAob3RoZXIsIG9mIGNvdXJzZSwgdGhhbiB0aGUgR2l0IGZvciBXaW5kb3dzIGZvbGtzKSBpcw0K
PiBmYW1pbGlhciB3aXRoIGhvdyB0aGF0IG9wdGlvbiB3b3JrcyBhbmQgc2luY2UgaXQgaXNuJ3Qg
cGFydCBvZiBjb3JlIEdpdA0KPiB3ZSB3b3VsZG4ndCBiZSBhYmxlIHRvIGZpeCBpdC4NCg0KVGhh
bmtzLCBkdWx5IHJlcG9ydGVkOiBodHRwczovL2dpdGh1Yi5jb20vZ2l0LWZvci13aW5kb3dzL2dp
dC9pc3N1ZXMvMzExMCNpc3N1ZS04MzA1NTE5MTUNCkkgbm90ZSB0aGlzIGJ1ZyBkb2VzIG5vdCBv
Y2N1ciBpbiBnaXQgdmVyc2lvbiAyLjkuMy53aW5kb3dzLjIgKDIwMTYpIG9uIFdpbmRvd3MgMTAu
MC4xODM2My4xMzE2IHdpdGggZnNjYWNoZQ0KSXQgc2VlbXMgdG8gaGF2ZSBleGlzdGVkIHNpbmNl
IGF0IGxlYXN0IDIwMTc6IGh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vYS80NDA0MDg5Mw0K
