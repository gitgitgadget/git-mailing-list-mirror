Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D9EC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKKCPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiKKCPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:15:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60B5F869
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOftddM8IvwCJfvKNaUb8o3eFqL+kYj3uqkg19BqNoKqNSfpejb71h/SzpJ61yIXi7cc0rt/JAM5a+5GLJI2zc0qCozVZL9vjYpOGWmqTCDai5YrI+Cr/VA2BEmYNYU9Wg6BSTyLCXzBhWlidVHTf/ZWILOnVJ5CkRe6p68xT6m0TjIiHUcag4RIEzcKxLn6wE0CqEWd/ArNe0IWOLETxoO42jW3xCY5xCfJz18UrgfGZ2P33mF28i2FICMeefXM/VlYbC29XtieJijr64Vl5oMURwZjcXYlx2IhYq5vVgU8XMETjLIaRZKF36kYA2cVZS/84PAYbA88cZI64694Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI0FO1/L39PWqzzT1BBO95AaKVqPo9Qjqq/y3pT6h9I=;
 b=SscAS45oXcANNo3dsD1BTcbpyE2XzYdHf8dTt5z4YxdFfIfiZg6wZEP1rQMTVvz1kWeExB0RY2phgjWXTlultP6YvxSpCT7sK2beztRfgsmdSa4RR67x/oCfIeKoHgtMi0Et/oJ2uyNIaBfNhQGyrCydS198ASrfTx2XM7zsGjnxM6G7ObE5K2L8zsIsvohmxbgEGq9dAgMreQu/twg5lKNnvQPS+onV6gFqOvGN+MObrRli98Sfpmr7z+orqr2mUxitXPACjLWkkfiUlJq2m+5yNZXQg1OMomthSvaHlw8KEbJHTfqJTBHhi+rNbIuEx8qMIAmx2lL6PaeiObuHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI0FO1/L39PWqzzT1BBO95AaKVqPo9Qjqq/y3pT6h9I=;
 b=Bf4vpgC7QGywPakPpzlxU5LsjDcujySxrzusE30m1qhUw6EKfVhF/f8m07fHtj2oYcekjwqCI8MlH2PsW9KryZknuNB/RE1epNd4DB3SQL435vyMT00TfKbSSMwDKF1XlQiY37H1pHi/4twG8mseo4+U6O82RPrX2HnWTLODajQ=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Fri, 11 Nov 2022 02:15:20 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 02:15:20 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH 0/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHY9XNzwF3XVwubHkGzusuLSrgFPw==
Date:   Fri, 11 Nov 2022 02:15:20 +0000
Message-ID: <20221111021502.449662-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 446962cd-1840-4183-2040-08dac38a9589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5T88X32D/GnNKYCGovty8ukOGZpriT/cjoyoocl7R9GEQ4+DqP8GSjEqjFLGoK0E+tGvPOGFKtOXBWMT72FU1Uss1ghALDpUcDKM3eKoVR72MX/zVQElGuWau9FrvkpbxX57Z79SwQO/FuSSBj0SLXPyHe0AO8qfUgfCPROGV8XSwPZD1sGgVQHMKT/Oluu6n/HCtDu3cyGb+4vuUzZ+voxIeOfQv8RfTJuf6r1QaauweLOX8nmZEwffuqRJf0k32STRqZir8xs/pBmcad9qCcvJuUKjMEUwqp2g3U57KjnegRcKs7QpHGPApM3SkEMF+XCa5nNjv4OmKngMZ0yX5K5d8ZNw5PSdRVPcDQ/P2M+ko5dI3iBmC8F2hpk47KJ1/EjgXyUhIASFSOpp2asW2CAcyuxvRjoZfL2Paii+Ou4gtvj8yBwcQVrm8YTfnW4QeT9uqug6aoY6iXXCyzJYfLpnACuUPnLjhQnWa+fo9qdVlbJPmU8ViIStOaNmvDfASDd1kX0jkzJvhDOMI/GvejGs9/EBRBIwQHqxaIlZZb8YaAp363VinbnhFt9sd2qFGD8XJnLVKdXehF9gPT6ttbzryFaw5eKCnNGGMyvt1hVnTS56xBBJe0ispda/cjcnDaMTP2VylPnkR9X0u/gwX+WcUET3pxAUiJ2LGikMVXuv9A9GWj2S8bvLAVdA8nIhFhuKSW7CutskOBqQAHVMW72PCnguzypXbQuO0YvUOTf8KeY/uHO7L3OqdWR/CWrOT3Y95YIg3xPv4scdkQc0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(38100700002)(122000001)(15650500001)(86362001)(38070700005)(4326008)(6506007)(2906002)(26005)(66556008)(6512007)(66446008)(66476007)(2616005)(64756008)(76116006)(91956017)(66946007)(6486002)(71200400001)(8676002)(316002)(83380400001)(8936002)(5660300002)(1076003)(66574015)(6916009)(41300700001)(36756003)(478600001)(186003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0U4NEpaWHlyRk5UMlNESGVBMEt1bjlsSEZZTCtwV3U4dmhzT2VLVlYxUUIx?=
 =?utf-8?B?T2h3Mm0xUVRhVWhlVVBQMjRxS2xidnpNRkpEbEhSSFZYTFBMaXlZS3kvNjM3?=
 =?utf-8?B?cGdIZmdlOC9qOHFCcUZkRmdZcGg0VmJ5RjBBalF6YXloSVpnakc4NlZkRGhP?=
 =?utf-8?B?Z243eU9iSHFEZmJMYXFNRkJwNURMOWQzRVk4Q290enJCbUt0cE5vTTN4SUti?=
 =?utf-8?B?dFMvZkVTQzcwSnNUN25kdjhSVTl1aVZYRnVQNDNWak9BZmhyWWJXL3Z4c3lO?=
 =?utf-8?B?WXc5d2txSllKL0V1ZzBCSSsvWGljWUs5YlEwY1VhY0NwOHRKa0t5UndEelM3?=
 =?utf-8?B?MGNEN29NaUQrTW11NkcxbEY4TW01aUdZQzZZaGVTS3B1aGVmVEQxSTgwOUlU?=
 =?utf-8?B?aTM0T09aelN3Y1NYYXRmcEJkczQ3UHE0cXZycndubHJCTEN4dnRybWZRbFc4?=
 =?utf-8?B?V3lKdER1VFpEK0JzL1hPSnBnc3FJNUNHMlFudGlkY203M3ZjTFJqeXFPcmtL?=
 =?utf-8?B?VnFCcTh5enBpYmdIelFBSVd5TDR0U3UzR3ZobXNTaUxTeEJKTEVyWnR4TFFD?=
 =?utf-8?B?ZDNUMWEzTGNEb1IzT0dMVnpFanZGV0VNY1l1SUtzaS9QdjdOcUNnT1FQZVlm?=
 =?utf-8?B?WmJycWcvRUhVSUZnbmVheEZQRWFzMVFCbHRQVUdzejFEWTdzWCswRzZ5UGh2?=
 =?utf-8?B?QytncVVpbUtTb256UitqY2c1RlU3RHgyNExpRVZZV1VQZkhpMzNKRkRrMXZD?=
 =?utf-8?B?Uzg2VW1zU3FIeWRNdkhTT3dsY1hhUEZNNUc3U1VmaXNjVzNHR2U2UHB0UjlU?=
 =?utf-8?B?eGRabkxHZys2dzVaNXhtUjM0OU9UY3NTaXpFUkFaRktjeFA2djVKc09lMzNp?=
 =?utf-8?B?TFlpMWhMb0VYWUh2dEVrYTAyU3lDWjBUQVVhanlGN2tiWXlES010Q1Q3cjVF?=
 =?utf-8?B?MmZyMGJsYTZuNEl2MEZFVndhUDgzWlV5U2FTa3VCOC9TN0NqR3ZLREdTOWFm?=
 =?utf-8?B?ZEo4cDJJRVVHS0FCVHZEdXRPcjhlVlZBRzNmaGJDUDBaWEUwb2ZIcEJrMnBU?=
 =?utf-8?B?ZHBDOTM0Q3ZPbVpHai9McXBOTFVIYkhQdkU5TXRSSlBBak9tSzhsWUdJVGRU?=
 =?utf-8?B?UnFsV0NjVDBnSWJrSDlZWWNQbCtCQ0c4T201WXBxZkdIWjdlTVFNTVhLNVJS?=
 =?utf-8?B?ZkVmS3JMT0psNTZMZlNrVUorQVNwSU1CY2xyM2hpK3BnV2VQQk1KYktYWGd6?=
 =?utf-8?B?Q0llYWhDdjFhWThUK3dMa2hzKy9CU2JjRm1QL1JzZGMzMlBGUzQ1cmtLMDJS?=
 =?utf-8?B?UlJveUs3eGV5QU1CY1NYRUplMG52RVJmb3U4cEpiRU5UdDFwQzFuMWZ6eVJT?=
 =?utf-8?B?SVZ3T2R0OUE5V0ZaWHgxbnV2U0JhWkR5cjBBbXRhQWRNVXpNL21uOFR0Vk5U?=
 =?utf-8?B?dlZFb1hMS3BpcitZQytJREZubWJmUk8vRWtUakNuRE10RExCc0dZamRtbVh5?=
 =?utf-8?B?OUVKUFh4OGoxT1pYMzBOZGY0OUFDbUNPTDhnUVdQT25uMDdGb2ZqaEhIdHFh?=
 =?utf-8?B?amI5aXhjUjVhbWwrT2RNR2thQWhNOStQSEVjSDZhNWxPWnNUdWo2SmV0M3hh?=
 =?utf-8?B?bEdESjY5QUtEV3BpMFdsM2MvRERoWG9jRFhWdFN2L1lnamVtTGxLT0tncktz?=
 =?utf-8?B?b3BRTEc5cTh4QTRmWEI4NE5jWW14RGJWdWZTazdrNVU1U1dWSFFJdjJrRTZw?=
 =?utf-8?B?Tml4eWZodjgyUHErTmhNQUZWdzQwMklhWGZwcnNTWUVXbE8zZXQ4VUdjaFFF?=
 =?utf-8?B?dUlMTGFrWEVWQ2wxc2tzazhDS2xEWENacU00YUFQbHNrcFZjVWtwZVJMZktP?=
 =?utf-8?B?ekVKMFAyb2E0aWlCZlpMTCs0TE45RjY3bExoRzd6OUtzbnY4OWkvbVV6SUtm?=
 =?utf-8?B?QXc3czNkOTNQbFUxYkZxUVlxWVNKQ1dLVERpRTRmS3RKeEtkSGN6RlF0alkr?=
 =?utf-8?B?am1zMThhZ2tyYW1FU3NhNHR5eGZmK1hGbUtaTzBwTWpmMmQyZklNZVhSazBW?=
 =?utf-8?B?NEw5OWNYK0xRL1Y5R0FXTWRsa1d1MVdwZXBxRll4d01IbWxORy95bjE2RzlS?=
 =?utf-8?Q?irfc1HQHcqzcTQvtL6glpLsDz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64FF89E3B7E4FD4D87AC6FFF9C57A211@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446962cd-1840-4183-2040-08dac38a9589
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 02:15:20.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +P2QhXKwJU79W+zOc/ctdewsjCyUiWKNT4VdrUmdUFuqBrkHJ5RxRIrFzfCzvsrW3f070yPqH70qJhh2m22eKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3VyZS4gIFRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIGZlZWRiYWNrLiAgTGV0IG1lIHNlZSBpZiBJ
IGNhbiBleHBsYWluIHRoZSBpZGVhLg0KDQpTb21ldGltZXMgaXQgY2FuIGJlIGhlbHBmdWwgdG8g
cmVhY3QgdG8gc3BlY2lhbCBrZXl3b3JkcyBpbiBhIGdpdCBzZW5kLWVtYWlsIHN1YmplY3QgbGlu
ZSBvciBzcGVjaWZpYyBlbWFpbCBhZGRyZXNzLiAgTGlrZSBwZXJoYXBzIG9uZSB3YW50cyB0byBk
byBzb21lIGtpbmQgb2Ygc29ydGluZyBvZiBwYXRjaGVzIGJ5IG1haWxpbmcgbGlzdCBvciAidG8i
IGVtYWlsIGFkZHJlc3MuICBZb3UgY291bGQgdXNlIHRoZSBzZW5kZW1haWwtdmFsaWRhdGUgaG9v
ayBhcyBhIHdheSB0byBjb3B5IHRoZSBwYXRjaCB0byBhIHNwZWNpZmljIGxvY2F0aW9uIGxvY2Fs
bHkgYmFzZWQgb24gd2hvIHlvdSBhcmUgZW1haWxpbmcuICBJJ20gc3VyZSB0aGVyZSBjb3VsZCBi
ZSBvdGhlciB1c2VzIGZvciB0aGUgc210cCBoZWFkZXIgaW5mb3JtYXRpb24gYXMgd2VsbC4gIFBy
ZXN1bWFibHkgdGhlIGhlYWRlciBpbmZvcm1hdGlvbiBpcyBwcmludGVkIHRvIHN0ZG91dCBiZWZv
cmUgc2VuZGluZyBhbiBlbWFpbCwgZm9yIG90aGVyIHJlYXNvbnMgdG9vICh0aGlzIGhhcHBlbnMg
YWxyZWFkeSkuICBNeSBwYXRjaCBtYWtlcyBpdCBwb3NzaWJsZSB0byBub3cgYXV0b21hdGUgYW55
IGNoZWNrcyBvbmUgbWlnaHQgYmUgZG9pbmcgbWFudWFsbHkgd2l0aCB0aGVzZSBoZWFkZXJzLg0K
DQpXaXRoIHNvbWUgdGVzdGluZyBJIGNhbiBjb25maXJtIHRoYXQgZW5jb2RlZCBoZWFkZXJzIChs
aWtlIGEgdXRmOCBzdHJpbmcpIGdldCBwYXNzZWQgaW4gZW5jb2RlZCBmb3JtLiAgVGhlIHJhbmRv
bSBleGFtcGxlIEkgdHJpZWQgd2FzIHdpdGggdGhlIHN1YmplY3QgIlJoeWRkaGV3Y2ggeSByYWPF
tW4iIGFuZCBpdCBpcyBzaG93bnMgYXMgIlN1YmplY3Q6IFtQQVRDSF0gPT9VVEYtOD9xP1JoeWRk
aGV3Y2g9MjB5PTIwcmFjPUM1PUI1bj89Ii4gIEhvd2V2ZXIsIHRoZSBvcmlnaW5hbCBwcmludCBv
ZiB0aGUgc210cCBoZWFkZXJzIGRvZXNuJ3QgaGFuZGxlIGVuY29kZWQgdGV4dCBlaXRoZXIsIHNv
IGl0IGlzIG5vIHdvcnNlIHRoYW4gY3VycmVudC4NCg0KTGFzdGx5LCB3aXRoIHRoZSB2YWxpZGF0
ZSBjb2RlIG1vdmluZyBsYXRlciB0aGVyZSBhcmUgc29tZSBjaGFuZ2VzIGluIG91dHB1dC4gIEFm
dGVyIG15IGNoYW5nZSwgdGhlIHVzZXIgd2lsbCBnZXQgYXNrZWQgYWJvdXQ6IGNvbXBvc2VkIGVt
YWlsIChjb21wb3NlIGFyZ3VtZW50IGNvZGUpLCA4IGJpdCBlbmNvZGluZywgd2hvIHRvIHNlbmQg
dG8sIGFuZCB3aGljaCBtZXNzYWdlLUlEIHRvIHJlcGx5IHRvIGJlZm9yZSB2YWxpZGF0aW9uLiAg
U2luY2UgdGhlc2UgY2hhbmdlIHRoZSBoZWFkZXIgaW5mb3JtYXRpb24sIHZhbGlkYXRpb24gbmVl
ZHMgdG8gaGFwcGVuIGFmdGVyLg0KDQpNaWNoYWVsDQpQUy0gSSBmaXhlZCB0aGUgU2lnbmVkLW9m
Zi1ieSBhcyB3ZWxsLg0KDQoNCk1pY2hhZWwgU3RyYXdicmlkZ2UgKDIpOg0KICBFeHBvc2UgaGVh
ZGVyIGluZm9ybWF0aW9uIHRvIGdpdC1zZW5kLWVtYWlsJ3Mgc2VuZGVtYWlsLXZhbGlkYXRlIGhv
b2sNCiAgVXBkYXRlIHNlbmRlbWFpbC12YWxpZGF0ZSBob29rIGRvY3MgdG8gYWRkIGhlYWRlciBm
aWxlIHBhcmFtZXRlcg0KDQogRG9jdW1lbnRhdGlvbi9naXRob29rcy50eHQgfCAgOCArKystLS0N
CiBnaXQtc2VuZC1lbWFpbC5wZXJsICAgICAgICB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyNCBk
ZWxldGlvbnMoLSkNCg0KQ2M6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+DQpD
YzogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4NCg0KLS0g
DQoyLjM0LjENCg==
