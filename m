Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6BFC38142
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjAQWSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjAQWRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:17:34 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97845BE6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxsFCGBXcvht7xGkd86FO5XJUtpLD9KUp8OhtM1KMCrlWKluM4jYUBY0b6bnqQhj+wIfWZkYM6HvJFF/QNb26he1xv25A9yOrpAZjEZLiBC2kJpkTE8B3L5NEYThktsxMhWhea2n92PwlMMwYQxvwsF+d3rD85SnultuZv/Kel0fMzKy8Fj/HdTFLwkgXow4hmA3W/gSIpDdIOFptw863oSSUf3SKawIeZaWzqIEowmkJ1FvTa02LJC+zHddSNzUfYLc0m1X04H40l/g6V7Maur5MGzn+IMGS1ExbfZEZjuC3FAYG4cqbhntRIva9pw2zKfoDCE7ITvh/PoipmmnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+Fa8WlWbxqHfLUtcRjl0yvg8uvdifm8Pzzms3pr928=;
 b=edZMEHXW715CZcHJHnGnYDNiuuKnZvPEjvAcYym19G5MHZoJ5+iv0KofozByHbyVyQz8LhOKxzqRcmE5LFiiDn+Ldn5yaNyV1nRKBohdPgBNE5DlSJ91NbKuS5kOoPMP1HEziQ7lGbEUaVlWtrxIvCUPXsKbPmN86fFXtTlVL3Y0oTAkxTEOjr4oJzUxHSf3LHH41xnCzXmHcK+okFXSIiDfSYwWcyB4SLTeH5pVGH4wT8G8C4TWzhADnmW3vfVHO32UdVT13gJAAz/QqlI1nOLy8jWmBWjVrat20czzJz5XISMIsRwbdxrvLEmkejTFCTbcAJwcsNXbukSEuQ/+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+Fa8WlWbxqHfLUtcRjl0yvg8uvdifm8Pzzms3pr928=;
 b=AF6gg0MMqUaxEoiCEvaCDXS/uJaDSrhBpAO5GR6hrRZ/fo9LGXdlmil8SAqvXFF37JRxTnyMG1EZTTGgXYw26oYP7he6+lYz8dINHaLaJLCMG1cS7cNH6DumGsqe6TnkuZIp6vom4VmVNCvuFPayI2JVaOuOYeuHZ+Tj6EQ904U=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 21:58:31 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 21:58:31 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "avarab@gmail.com" <avarab@gmail.com>
CC:     "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKr7WFeSbV0omr0KXx6cop4T2ng==
Date:   Tue, 17 Jan 2023 21:58:31 +0000
Message-ID: <20230117215811.78313-1-michael.strawbridge@amd.com>
References: <230117.86sfg9xp98.gmgdl@evledraar.gmail.com>
In-Reply-To: <230117.86sfg9xp98.gmgdl@evledraar.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|IA0PR12MB7555:EE_
x-ms-office365-filtering-correlation-id: 21253451-756b-4863-9b2c-08daf8d5f919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L8DvWqBQkLp1yhFj3h4gn6kYyPgiyUq/Xtsk+PhlbDCm1+yKqSIiPm93O0lk3WwwaydxQt96+sBrAr39fYRb0YwYf/You0Qr5ckhpzD2r3yn6UfibNu4MIYcEnbf1dOgxCMXT/BMd5YUImJi+gYx1SXGDQpKBqojkycv7015GFhyfWNq84p1jzUbTIoD3b1QWN0lex6lk69ASbhj+zx5aD1+x6M6z9lakz+EHW8STHeIWBCyXa3mNXgCEx0gnEynU5KG/oK0GdwYxfX6gAPy/WV8rq2INkP0D+VxvFKOLZsbVY/U/1KbX7RoO1PdCavnS+1Tcy6AORx2YTzBnx8Fb5gj8f9TB9qj98OfBiTkoIJ2c1L2OhDDgsBejDqIukL9OHjJ+r+T0Se5jVArp9vCYHHLc61aIvwf7FFXCVEwWn3bdlS650Tbh6EN7AQdmqHlwKrM96OD9r4NZEwEF2lnMg2L6HCzy+eNKk9Ef6xkrDh21z4jCIdpH0VlkzjFqqT3LGedOUgV+IIGTAwmGt3jcIzGbLt/XKT35nglK8HV0e97H4puO2zNygNOYAKqLnPyQZBA2Rs68+GO5NQRgB0qKZHNLznMqn12jhk3aWulfEtcMecTNG0URdLlK7TZDUiDVWiiWMw1Blj/OeCzZbGgkbMqu9kUd5iE9tv1Y06wzISNLvGymJtNAIWC55SIz+4nPv555sd9jQEDPGKl9RM8Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(38100700002)(38070700005)(36756003)(6486002)(86362001)(66446008)(6512007)(66476007)(76116006)(6916009)(64756008)(8676002)(4326008)(26005)(66556008)(478600001)(66946007)(71200400001)(1076003)(54906003)(91956017)(2616005)(186003)(66574015)(122000001)(6506007)(316002)(8936002)(15650500001)(2906002)(5660300002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlhCTHdoVVFKSGhOdis2blBHNmpZcE4xSktJWFYzcjNwRnNBUHF5cEpTYUxF?=
 =?utf-8?B?c1drSGtCK3lISnRicTR0cWRNTUpyQnpyMkRnd0ZGc29wbEhmMkkra3BQcStB?=
 =?utf-8?B?MUJQekNUb0dnWW4vTjhXWHZmNGlPdmp0TU5hZm5zTzFEMVhTVURiSVZ0RHd0?=
 =?utf-8?B?eVVjN0xCam9PMG1BMTR6UnJWU0VGeFhnZjlyMCtqL3VjUFAxNkJiMG96dVA0?=
 =?utf-8?B?bmk2UFVWRXg3L1RpSkVzZVNxQWtkb1AvSmlGSDUveU1mSWN3dmRsMTRsV0oz?=
 =?utf-8?B?d0hONWp2ZzFlVFpTOG1pVTRBUEhoYy9MdTdJUE1IVVk3S2dlOGl6UE5IMG1Z?=
 =?utf-8?B?SWxOTGlxbHI3Rk1IcTRLZ3pSbnpQSSt0eW9QK3QxcUxkUTFScDdzalprVUQ1?=
 =?utf-8?B?VlA0VmlSUkZUdWZ1ckwrUmwxTi81NVJHVzdWeHVVRksvc0loUjVsNzJUSHFz?=
 =?utf-8?B?dEsxU2VQM2g4UWwxUzFCUzZNTCtvY3hHaGRLd055OEViVjFWYVRlajV2OFBt?=
 =?utf-8?B?aGk5eE1WVFpSNklaWkFqZ2xBT0VKMXBSQXMxd0t4YjVBVjJFSEM1VGVPWU4r?=
 =?utf-8?B?NmI1YklFOUJVUE9LZEt2NHVXeTRlM0ZyQThTN2xuL2pXbldILzVKdW5ZUWp5?=
 =?utf-8?B?REs5M1NQSjY1VkZDcmZBV1JaVndHOWl5WDNjaU0zVlNibGpYVHVZU0VER0p2?=
 =?utf-8?B?eHVsbHZybWxUb05ia2lLdzRRdVRiRkFCQThmSU1HeTI4SnJ0RXVxaEZoYkNB?=
 =?utf-8?B?dEpxaGZYWVE2eUFYNE1HakdXUUNDVTJLMDJnNjBYNUd3cyt4YTU5cmZsTlFn?=
 =?utf-8?B?TGRTRHJFZHBBYVhzZmh4M2RnSnoxQ1pHSCtQQlE5bmw1ZU1NV0dPckRMK25C?=
 =?utf-8?B?T21RMEpwSFExOWV6YURqaEREWkpVb2kxSGVuLzlmZjVudk5JcjlQbEJTdHFs?=
 =?utf-8?B?T0gyRUh5RnQ3RU5CQTZwVXFXUno5SWxZajBCMzc5MTVPZXNLUWNoSHU4ZHIv?=
 =?utf-8?B?T0Q3RHB5bVJybmovbmY1LzJLRldILzY3MWYzZE1NbHRHeVJqN0QvTXoyQ1A0?=
 =?utf-8?B?ZHF2TVJ2Y1JWWmNLNXE0ZkhDY04yVFh5OEtDRXVrWERBRHNVODQ4UzJTWnpY?=
 =?utf-8?B?L0dYemdOamxjeTdOVFI1MlNtZHNhRDRXMFVXbHMwUVhzYVU0eEZ3OTFGRkM1?=
 =?utf-8?B?U2hsSHkxRjE2bE1pcHlOVUIzL29zMjNFZWlkdTJoNHNWVWdhMUNnVnlvWTdZ?=
 =?utf-8?B?SmNEREFMVjdCeEwvbFRFYVJTeDE3MnZxcGloa1F5Z0dDK3kvbnFTLysvVnhD?=
 =?utf-8?B?S3RKMnkyTjNBWjJFNVlaYTc2ZS9Hem5Ob2FGYVZDTUJVbFRZYisvWDRJMDdP?=
 =?utf-8?B?WnBzUHYyK20ySWFUNkxoYUVNQy9XQW5QYTdsWHY4VDEzblZTUStFV2VhN1Er?=
 =?utf-8?B?dy9Cbm5zYWFzK0Q4Z2hwRUhpLzFJbWN0NSswYWRqc0lNYUhUYmlVblZCN2lD?=
 =?utf-8?B?dmdIRWJsaFhLVGJxK1RLTzRBdHBXS1hpK3dONjUvTENkSEV4bG5reXBrWStq?=
 =?utf-8?B?QVp6SmhNa2tnTFdKNHZmcGQ5OFU0dUtXUWp1eVFuRXVmenJYWENBT0RBeHFH?=
 =?utf-8?B?R0lJbDllZUtMOGVtdEdOcGQwNG1pR0U3WWhRR3pxRHg4SXExcGhJTXFHOEp1?=
 =?utf-8?B?bkdoeVhQaUROeVNjMVd4U2w3ZUZPSHNCNzFYSzQrSzVlUUZpOVN2a215eTBt?=
 =?utf-8?B?MGk0cGk5MGU1YXJ2ZGE1dzBvTWxJOUFmMjduNlZKTld0RVNyZkRwZm44Szhx?=
 =?utf-8?B?eUM1S0tpcVFCU2l4Nm1iWXVhcElNRnRuV2hhb0xtLzVyQm9vWTFRYjRlT1BR?=
 =?utf-8?B?ZXNhWjJWSjRvcytSbitTZjI2R0RQYWdNaG1IYVdyeCtobTdXUlRHU1pQdTkz?=
 =?utf-8?B?TFZpVlJPUll1NTV2bXZxSWJaWC8vdnlWWlFQT3I0K3Z5ZWJCREd4Wm5YczJy?=
 =?utf-8?B?cGRtOEliQzhGRnJZU05PSUU1YnQrT0hTN1o5d1ZzREc3amVCSmlXU2IzZnA5?=
 =?utf-8?B?bnRNTTVWcGZqS2tvbmw4WVF4YVNHVkpDcHRYWUZUV3IyWlEyaU1qbnEyUzZE?=
 =?utf-8?Q?8ZvENUtAti0WfRJhBDZQnuQ6x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE7375D73E13294997D25327616DED1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21253451-756b-4863-9b2c-08daf8d5f919
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 21:58:31.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /K4DRAh6663swhViMvihjlywVEoQTwiqkS4U7MT9ClfzNKZdj+vnIFGsStso1/GF5LkgoQlybs8TSFLILKby7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gVHVlLCBKYW4gMTcgMjAyMywgw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gd3JvdGU6DQo+
T24gVHVlLCBKYW4gMTAgMjAyMywgU3RyYXdicmlkZ2UsIE1pY2hhZWwgd3JvdGU6DQo+DQo+PiBU
byBhbGxvdyBmdXJ0aGVyIGZsZXhpYmlsaXR5IGluIHRoZSBnaXQgaG9vaywgdGhlIFNNVFAgaGVh
ZGVyDQo+PiBpbmZvcm1hdGlvbiBvZiB0aGUgZW1haWwgdGhhdCBnaXQtc2VuZC1lbWFpbCBpbnRl
bmRzIHRvIHNlbmQsIGlzIG5vdw0KPj4gcGFzc2VkIGFzIGEgMm5kIGFyZ3VtZW50IHRvIHRoZSBz
ZW5kZW1haWwtdmFsaWRhdGUgaG9vay4NCj4+DQo+PiBBcyBhbiBleGFtcGxlLCB0aGlzIGNhbiBi
ZSB1c2VmdWwgZm9yIGFjdGluZyB1cG9uIGtleXdvcmRzIGluIHRoZQ0KPj4gc3ViamVjdCBvciBz
cGVjaWZpYyBlbWFpbCBhZGRyZXNzZXMuDQo+DQo+T2tleSwgYnV0Li4uDQo+DQo+PiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9naXRob29rcy50eHQgYi9Eb2N1bWVudGF0aW9uL2dpdGhvb2tz
LnR4dA0KPj4gaW5kZXggYTE2ZTYyYmM4Yy4uMmI1YzY2NDBjYyAxMDA2NDQNCj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZ2l0aG9va3MudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2dpdGhvb2tz
LnR4dA0KPj4gQEAgLTU4MywxMCArNTgzLDE5IEBAIHByb2Nlc3NlZCBieSByZWJhc2UuDQo+PiAg
c2VuZGVtYWlsLXZhbGlkYXRlDQo+PiAgfn5+fn5+fn5+fn5+fn5+fn5+DQo+PiAgDQo+PiAtVGhp
cyBob29rIGlzIGludm9rZWQgYnkgbGlua2dpdDpnaXQtc2VuZC1lbWFpbFsxXS4gIEl0IHRha2Vz
IGEgc2luZ2xlIHBhcmFtZXRlciwNCj4+IC10aGUgbmFtZSBvZiB0aGUgZmlsZSB0aGF0IGhvbGRz
IHRoZSBlLW1haWwgdG8gYmUgc2VudC4gIEV4aXRpbmcgd2l0aCBhDQo+PiAtbm9uLXplcm8gc3Rh
dHVzIGNhdXNlcyBgZ2l0IHNlbmQtZW1haWxgIHRvIGFib3J0IGJlZm9yZSBzZW5kaW5nIGFueQ0K
Pj4gLWUtbWFpbHMuDQo+PiArVGhpcyBob29rIGlzIGludm9rZWQgYnkgbGlua2dpdDpnaXQtc2Vu
ZC1lbWFpbFsxXS4NCj4+ICsNCj4+ICtJdCB0YWtlcyB0aGVzZSBjb21tYW5kIGxpbmUgYXJndW1l
bnRzOg0KPj4gKzEuIHRoZSBuYW1lIG9mIHRoZSBmaWxlIHRoYXQgaG9sZHMgdGhlIGUtbWFpbCB0
byBiZSBzZW50Lg0KPj4gKzIuIHRoZSBuYW1lIG9mIHRoZSBmaWxlIHRoYXQgaG9sZHMgdGhlIFNN
VFAgaGVhZGVycyB0byBiZSB1c2VkLg0KPj4gKw0KPj4gK1RoZSBob29rIGRvZXNuJ3QgbmVlZCB0
byBzdXBwb3J0IG11bHRpcGxlIGhlYWRlciBuYW1lcyAoZm9yIGV4YW1wbGUgb25seSBDYw0KPj4g
K2lzIHBhc3NlZCkuIEhvd2V2ZXIsIGl0IGRvZXMgbmVlZCB0byB1bmRlcnN0YW5kIHRoYXQgbGlu
ZXMgYmVnaW5uaW5nIHdpdGgNCj4+ICt3aGl0ZXNwYWNlIGJlbG9uZyB0byB0aGUgcHJldmlvdXMg
aGVhZGVyLiAgVGhlIGhlYWRlciBpbmZvcm1hdGlvbiBmb2xsb3dzDQo+PiArdGhlIHNhbWUgZm9y
bWF0IGFzIHRoZSBjb25maXJtYXRpb24gZ2l2ZW4gYXQgdGhlIGVuZCBvZiBzZW5kLWVtYWlsLg0K
Pj4gKw0KPj4gK0V4aXRpbmcgd2l0aCBhIG5vbi16ZXJvIHN0YXR1cyBjYXVzZXMgYGdpdCBzZW5k
LWVtYWlsYCB0byBhYm9ydA0KPj4gK2JlZm9yZSBzZW5kaW5nIGFueSBlLW1haWxzLg0KPj4gIA0K
Pj4gIGZzbW9uaXRvci13YXRjaG1hbg0KPj4gIH5+fn5+fn5+fn5+fn5+fn5+fg0KPj4gZGlmZiAt
LWdpdCBhL2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9naXQtc2VuZC1lbWFpbC5wZXJsDQo+PiBpbmRl
eCA4MTBkZDFmMWNlLi5iMmFkY2E1MTVlIDEwMDc1NQ0KPj4gLS0tIGEvZ2l0LXNlbmQtZW1haWwu
cGVybA0KPj4gKysrIGIvZ2l0LXNlbmQtZW1haWwucGVybA0KPj4gQEAgLTc4NywxNCArNzg3LDYg
QEAgc3ViIGlzX2Zvcm1hdF9wYXRjaF9hcmcgew0KPj4gIA0KPj4gIEBmaWxlcyA9IGhhbmRsZV9i
YWNrdXBfZmlsZXMoQGZpbGVzKTsNCj4+ICANCj4+IC1pZiAoJHZhbGlkYXRlKSB7DQo+PiAtCWZv
cmVhY2ggbXkgJGYgKEBmaWxlcykgew0KPj4gLQkJdW5sZXNzICgtcCAkZikgew0KPj4gLQkJCXZh
bGlkYXRlX3BhdGNoKCRmLCAkdGFyZ2V0X3hmZXJfZW5jb2RpbmcpOw0KPj4gLQkJfQ0KPj4gLQl9
DQo+PiAtfQ0KPj4gLQ0KPj4gIGlmIChAZmlsZXMpIHsNCj4+ICAJdW5sZXNzICgkcXVpZXQpIHsN
Cj4+ICAJCXByaW50ICRfLCJcbiIgZm9yIChAZmlsZXMpOw0KPj4gQEAgLTE3MzgsNiArMTczMCwx
NiBAQCBzdWIgc2VuZF9tZXNzYWdlIHsNCj4+ICAJcmV0dXJuIDE7DQo+PiAgfQ0KPj4gIA0KPj4g
K2lmICgkdmFsaWRhdGUpIHsNCj4+ICsJZm9yZWFjaCBteSAkZiAoQGZpbGVzKSB7DQo+PiArCQl1
bmxlc3MgKC1wICRmKSB7DQo+PiArCQkgICAgICAgIHByZV9wcm9jZXNzX2ZpbGUoJGYsIDEpOw0K
Pj4gKw0KPj4gKwkJCXZhbGlkYXRlX3BhdGNoKCRmLCAkdGFyZ2V0X3hmZXJfZW5jb2RpbmcpOw0K
Pj4gKwkJfQ0KPj4gKwl9DQo+PiArfQ0KPg0KPi4uLmhlcmUgd2UgaGF2ZSB0aGUgc2VlbWluZ2x5
IHVucmVsYXRlZCBjaGFuZ2Ugb2YgZmlyc3QgZG9pbmcgdGhlDQo+dmFsaWRhdGlvbiBiZWZvcmUg
dGhpcywgYW5kIGlmIHdlIHBhc3MgaXQgd2UnbGwgcHJpbnQgdGhlIG5hbWVzIG9mIHRoZQ0KPmZp
bGVzIHdlJ3JlIHNlbmRpbmcgdW5sZXNzIC0tcXVpZXQuDQo+DQo+Tm93IHdlJ2xsIGRvIGl0IHRo
ZSBvdGhlciB3YXkgYXJvdW5kLCBtYXliZSB0aGF0J3MgZ29vZCwgb3IgbWF5YmUgbm90LA0KPmJ1
dCB5b3VyIHVwZGF0ZWQgZG9jcyBkb24ndCBzYXkuDQo+DQo+QWxzbyAoYW5kIEkgZGlkbid0IGxv
b2sgYXQgdGhpcyBhbGwgdGhhdCBjYXJlZnVsbHkpLCB3aHkgYXJlIHlvdSBtb3ZpbmcNCj50aGUg
Y29udHJvbCBsb2dpYyB0byBiZXR3ZWVuIHRoZSBsYXRlciBmdW5jdGlvbiBkZWNsYXJhdGlvbnM/
DQo+DQo+UGVybCBpc24ndCBhIGxhbmd1YWdlIHdoZXJlIHlvdSBuZWVkIHRvIGFycmFuZ2UgeW91
ciBzb3VyY2UgaW4gdGhhdCB3YXkNCj4odW5sZXNzIGEgYmFyZXdvcmQgaXMgaW52b2x2ZWQsIG9y
IGlmIHRoaXMgaGFwcGVucyBhdCBCRUdJTiB0aW1lIG9yDQo+d2hhdGV2ZXIpLiBUaGUgY3VycmVu
dCBzdHJ1Y3R1cmUgaXM6DQo+DQo+CTx1c2UgJiBpbXBvcnRzPg0KPgk8YmFzaWMgc2V0dXAgKGdl
dG9wdHMgZXRjKT4NCj4JPG1haW4gbG9naWM+DQo+CTxoZWxwZXIgZnVuY3Rpb24+DQo+DQo+SGVy
ZSB5b3UncmUgbW92aW5nIHBhcnQgb2YgdGhlIG1haW4gbG9naWMgdG8gaW4tYmV0d2VlbiB0d28g
aGVscGVyDQo+ZnVuY3Rpb24sIHdoeT8NCj4NCg0KSW4gZ2VuZXJhbCBJIHVuZGVyc3RhbmQgeW91
ciBwb2ludC4gIEhvd2V2ZXIsIEkgZm91bmQgaW4NCmdpdC1zZW5kLWVtYWlsIHRoYXQgY29kZSBv
dXRzaWRlIG9mIGZ1bmN0aW9ucyBpcyBzcHJpbmtsZWQgaW4gYmV0d2Vlbg0KZnVuY3Rpb24gZGVj
bGFyYXRpb25zIGluIHNldmVyYWwgYXJlYXMuICBMaW5lcyA3OTAtNzk3IGFuZCAxMDExLTEwNTgg
YXJlDQpleGFtcGxlcyBvZiBzb21lIG9mIHdoYXQgSSBtZWFuLiAgQWxzbywgdGhlIG9yaWdpbmFs
IHByb2Nlc3NfZmlsZSBjYWxsIGlzDQphY3R1YWxseSBvdXQgb2YgcGxhY2UgKHJvdWdobHkgbGlu
ZSAyMDExLTIwMTUpLiBVbmZvcnR1bmF0ZWx5IHNvbWUgb2YgdGhpcw0Kc3ByaW5rbGVkIGNvZGUg
aGFzIGFuIGltcGFjdCBvbiB0aGUgaGVhZGVyIHZhcmlhYmxlcyBhbmQgc28gSSBuZWVkZWQgdG8N
Cm1vdmUgdGhlIHZhbGlkYXRpb24gY29kZSBsb3dlciwgY2xvc2VyIHRvIHRoZSBwcm9jZXNzX2Zp
bGUgc2VjdGlvbiBidXQNCmJlZm9yZSB0aGUgaW50aWFsaXphdGlvbiBvZiBpbl9yZXBseV90bywg
cmVmZXJlbmNlcywgYW5kIG1lc3NhZ2VfbnVtLg0KSSB3YXMgYXR0ZW1wdGluZyB0byByZWR1Y2Ug
dGhlIG51bWJlciBvZiBjb2RlIGNoYW5nZXMuDQoNCllvdSBkbyBicmluZyB1cCBhIGdvb2QgcG9p
bnQgYWJvdXQgcHJpbnRpbmcgb2YgdGhlIG5hbWVzIG9mIGZpbGVzDQpiZWZvcmUgdmFsaWRhdGlv
biBjYXVzaW5nIGEgZGlmZmVyZW5jZSBpbiBvdXRwdXQuIEkgY2FuIGF0dGVtcHQgdG8gbW92ZQ0K
c29tZSBtb3JlIG9mIHRoaXMgY29kZSBhcyB3ZWxsLCBpZiB0aGUgY2hhbmdlIG9mIG91dHB1dCBp
cyBkZWVtZWQNCmltcG9ydGFudCBlbm91Z2guDQogDQo+PiAgJGluX3JlcGx5X3RvID0gJGluaXRp
YWxfaW5fcmVwbHlfdG87DQo+PiAgJHJlZmVyZW5jZXMgPSAkaW5pdGlhbF9pbl9yZXBseV90byB8
fCAnJzsNCj4+ICAkbWVzc2FnZV9udW0gPSAwOw0KPj4gQEAgLTIxMDEsMTEgKzIxMDMsMjAgQEAg
c3ViIHZhbGlkYXRlX3BhdGNoIHsNCj4+ICAJCQljaGRpcigkcmVwby0+d2NfcGF0aCgpIG9yICRy
ZXBvLT5yZXBvX3BhdGgoKSkNCj4+ICAJCQkJb3IgZGllKCJjaGRpcjogJCEiKTsNCj4+ICAJCQls
b2NhbCAkRU5WeyJHSVRfRElSIn0gPSAkcmVwby0+cmVwb19wYXRoKCk7DQo+PiArDQo+PiArCQkJ
bXkgKCRyZWNpcGllbnRzX3JlZiwgJHRvLCAkZGF0ZSwgJGdpdHZlcnNpb24sICRjYywgJGNjbGlu
ZSwgJGhlYWRlcikgPSBnZW5faGVhZGVyKCk7DQo+PiArDQo+PiArCQkJcmVxdWlyZSBGaWxlOjpU
ZW1wOw0KPj4gKwkJCW15ICgkaGVhZGVyX2ZpbGVoYW5kbGUsICRoZWFkZXJfZmlsZW5hbWUpID0g
RmlsZTo6VGVtcDo6dGVtcGZpbGUoDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICIu
Z2l0c2VuZGVtYWlsLmhlYWRlci5YWFhYWFgiLCBESVIgPT4gJHJlcG8tPnJlcG9fcGF0aCgpKTsN
Cj4+ICsJCQlwcmludCAkaGVhZGVyX2ZpbGVoYW5kbGUgJGhlYWRlcjsNCj4+ICsNCj4+ICAJCQlt
eSBAY21kID0gKCJnaXQiLCAiaG9vayIsICJydW4iLCAiLS1pZ25vcmUtbWlzc2luZyIsDQo+PiAg
CQkJCSAgICAkaG9va19uYW1lLCAiLS0iKTsNCj4+IC0JCQlteSBAY21kX21zZyA9IChAY21kLCAi
PHBhdGNoPiIpOw0KPj4gLQkJCW15IEBjbWRfcnVuID0gKEBjbWQsICR0YXJnZXQpOw0KPj4gKwkJ
CW15IEBjbWRfbXNnID0gKEBjbWQsICI8cGF0Y2g+IiwgIjxoZWFkZXI+Iik7DQo+PiArCQkJbXkg
QGNtZF9ydW4gPSAoQGNtZCwgJHRhcmdldCwgJGhlYWRlcl9maWxlbmFtZSk7DQo+PiAgCQkJJGhv
b2tfZXJyb3IgPSBzeXN0ZW1fb3JfbXNnKFxAY21kX3J1biwgdW5kZWYsICJAY21kX21zZyIpOw0K
Pj4gKwkJCXVubGluaygkaGVhZGVyX2ZpbGVoYW5kbGUpOw0KPj4gIAkJCWNoZGlyKCRjd2Rfc2F2
ZSkgb3IgZGllKCJjaGRpcjogJCEiKTsNCj4NCj5JIGtub3cgImdpdCBob29rIHJ1biIgZG9lc24n
dCBzdXBwb3J0IGlucHV0IG9uIHN0ZGluIHlldCwgYnV0IGlzbid0IHRoaXMNCj5qdXN0IHdvcmtp
bmcgYXJvdW5kIGl0IG5vdCBzdXBwb3J0aW5nIHRoYXQ/IFRoYXQgc2VlbXMgbGlrZSBhIG11Y2gN
Cj5iZXR0ZXIgJiBuYXR1cmFsIGludGVyZmFjZSB0aGFuIHdoYXQgd2UncmUgZG9pbmcgaGVyZS4N
Cj4NCj5JIGhhdmUgb3V0LW9mLXRyZWUgcGF0Y2hlcyBmb3IgdGhhdCAob3IgcmF0aGVyLCBhIHJl
LXJvbGwgb2YgRW1pbHkncw0KPnBhdGNoZXMgdG8gZG8gdGhhdCksIGlmIHRoYXQgbGFuZGVkIGlu
LXRyZWUgY291bGQgdGhpcyB1c2UgdGhhdA0KPmludGVyZmFjZSwgZG8geW91IHRoaW5rPw0KPg0K
PkknZCByYXRoZXIgdGhhdCB3ZSBkaWRuJ3QgZm9yZXZlciBjb2RpZnkgYSBzdHJhbmdlIGludGVy
ZmFjZSBoZXJlIGR1ZSB0bw0KPmEgdGVtcG9yYXJ5IGxpbWl0YXRpb24gaW4gImdpdCBob29rIiBh
bmQgdGhlIGhvb2sgQVBJLi4uDQoNCkkgd2FzIHRyeWluZyB0byBmb2xsb3cgdGhlIGNvbnZlbnRp
b24gdGhhdCB0aGUgb3JpZ2luYWwgaG9vayB3YXMgdXNpbmcuDQpJJ20gbm90IGFnYWluc3QgY2hh
bmdpbmcgdGhpcyBpZiB0aGUgb3V0IG9mIHRyZWUgcGF0Y2hlcyB5b3Ugc3BlYWsgb2YNCmFyZSBn
b2luZyB0byBiZSByb2xsZWQgaW4gc29vbi4gIEhvd2V2ZXIsIEknZCBwcmVmZXIgbm90IHRvIGRl
bGF5IHRoaXMNCnBhdGNoIGlmIHRoZXNlIG90aGVyIHBhdGNoZXMgYXJlIGZhciBvZmYuIFRoYW5r
cy4NCg0KLS0gDQoyLjM0LjENCg==
