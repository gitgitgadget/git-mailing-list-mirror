Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C5C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B9464FF5
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhCLPxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:53:08 -0500
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:6021
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232057AbhCLPwu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 10:52:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWzkYfn098rLENxy1oKIlp0x1MRAHjhS9/kDraOpBq+gLeL4IlAsUUYFFiZDa7b3oRwg4NgSccOgs2areo3hVA+ttapxn5KgY/B2tEZj8Bmdfnw0BKUiBXaBuXEJTTMBaWxTdYeTY0bCJdZt/4tWofaiAV9FxQvMnvRbioQLMRD6OFg9N8khO77JSFB0GmIuiytCbsFO+Fr0MZfBTNOGi3LM3NKQ6sYiC5F2cU8JGe6XpiDL+hW3diUoUnREgHf1/oatXSEMJIzF9qnKsh4k0k9OELRGlAGZZC+ep43ISzVewjWTLXQYxcwzZtQIuYSEV6cKFCjBl/mGoNZlGR7ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzWOQdWJb5pCPHetEkjBLWYpuesqwFRd/3yN05LuCnQ=;
 b=fhOIEFfPIfHTPwpdC9fLPT2PAU0gqsxrVZpIeXdfBmOil4wuCF5GqBhp8qX3f5rzcMm/tWO0IeVZDQueJ5lPheOpeKc8HafKHCrLIscSR8bCEgrzZhV7U9TChWXQ9MrJMNzohtPV1cIk8GqcnnkqMKcpQ5TZY4bhQG671IXuYQLcgWFzsFscD7/VGpZran5JJWiLFzpzIov9F3EgmUt45rWQlS9UaNiD0K/bsreNAeR3dD7wcE1RUrW42e7V5E7m4VIQc+2su9uqeupJfLakpvD9vkeVv1cxhuRG9ZSyclojLpvwjIXmRWwNhEOa0oluT0BcjZdeAgvw0Vc0Onk3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metacase.com; dmarc=pass action=none header.from=metacase.com;
 dkim=pass header.d=metacase.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metacase.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzWOQdWJb5pCPHetEkjBLWYpuesqwFRd/3yN05LuCnQ=;
 b=C8c7R+BsflE1wNZUr2uygDtif51RcZEdGm78AxUBn36W+pFw6j4JSHkk1UKhU5sM7GRvTnOfE2rpFKTsLZVOYMvMcEQY63V5JkfHqmUtuStKOVfUE5nPboojxdlnv722wU5rqwgH31Kdzq0gGDP6WFED+nAl67MCXHsR4Sj+M4K+224emUtcBJvF1ARdaCSPkYwlp3tVvsInsnFbl4mzTQOMCzm/auFAb4JEVNowGdkvEoNvcw3fXbconwmM9BgNAlLvkPLtY2MgXbK/XgaXR1PXQF7NYi9p/CncvzgvMlj7l56VmQXEqNpiW4mnOL+qzEflnWzepfFMtFSA1FxNaA==
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:174::13)
 by AS8P194MB0981.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:2a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Fri, 12 Mar
 2021 15:52:44 +0000
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::38e0:3102:a7bc:6528]) by AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::38e0:3102:a7bc:6528%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 15:52:44 +0000
From:   Steven Kelly <stevek@metacase.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: [BUG] Error adding 2+ files after init --shared on Windows with
 fscache
Thread-Topic: [BUG] Error adding 2+ files after init --shared on Windows with
 fscache
Thread-Index: AdcXVz4yHrit0VJ9SwaVJXHYg1vuPA==
Date:   Fri, 12 Mar 2021 15:52:43 +0000
Message-ID: <AM7P194MB0900C227791B8B7AA1D34DBEA66F9@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=metacase.com;
x-originating-ip: [91.157.220.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35fa64ca-8221-49ad-8af3-08d8e56ee019
x-ms-traffictypediagnostic: AS8P194MB0981:
x-microsoft-antispam-prvs: <AS8P194MB09810922022551605F05368EA66F9@AS8P194MB0981.EURP194.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyb0q2JNNRUKDS9+113P9rnWGfZpv7AY3YjoWg+DtkIOvKX9fhTO9Y+fu5jxVad6xC3uD7uSRG9dFM3z4PNrHurDU7rwVdm0JVC0YYHHbFHcvhLosknzV3FPvmdJSJN1nId691a/b/t6p4c63iCQVjHZzdawnvXyF41JzUrY8r+NgiS58JwakNhdZm/AZwLmBDMfHQzWaj6qs9CSmIYiCIVRo52q5GoTsY4OnW/8C+58M4zGnb2AJZ6I3C0gFrbE5hxykuGTwFFCYgcGahFdPLFdbN65b3jHX+UDEyE8BkwDG+3xFe6C2hbNbNJS/LebY8S5OIS4jE/bZcpJOWiyxfTa/GwDRr3OPcFkLFtoQuA8+tQRe/+YGobIPC7TkG9J26QwRFGUaBq8CpgfgTDNiOlfSTz2Sfl40kEV2LJC+3XdWxCboFZPzx8iUcyEd1J5h+anDWqpKbh3ks3Ozu29PCLPC9FLhfdUXOQKMmt6m8iH/Z4wtOtFBq/tWReB0B/AbgnWme/7yXm16B8Bizg691RsxmqWWuoJi2/FvZ9OSN+tt/2HNWNOZfYUMhe6mJoY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P194MB0900.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(39830400003)(376002)(34036004)(6506007)(5660300002)(71200400001)(66556008)(7696005)(186003)(8676002)(52536014)(76116006)(508600001)(66446008)(66476007)(64756008)(86362001)(9686003)(26005)(2906002)(55016002)(6916009)(83380400001)(316002)(33656002)(66946007)(8936002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d01CeUk4bHo1R2xUTEhVVDh0QmFZaTM2VnBjcWRwVTN2SDkyMlFzRUFsSFpT?=
 =?utf-8?B?Yzd4NnFRUUx3cTlNdGFkeEpmbzRhcFUxek1HOTZVWU5oMk5qMWVLeUNVQnRr?=
 =?utf-8?B?M09PLzFnNG84ZURrWXJ3eFhCQTAzbVV0bHZ4eG84aWhPVWFSeXpNOHdGUWlh?=
 =?utf-8?B?YldaQmFFTlhnUEh4WE9jd0htYXhJck9MM01mU2pUM09YUXpmSTdZYnV1RDZB?=
 =?utf-8?B?RnNqa3doaGlOMlhJUUVYenBka3ZrM2hoZWF4YWJHZ09nV1JGbURyQldZQ1pr?=
 =?utf-8?B?VTl6OWRMVFJ1elpiNE9nRlpmNG5UYzdFSFBEMXFtZVBmVFF2T1RJdFVKTFpW?=
 =?utf-8?B?ZE5RN3JKY2h0ODVyaUg3b3IyMWFZSWFsMlY5MFU3NTBkS2xESCtSNGxFTnhM?=
 =?utf-8?B?dHQ5UkZXZFl1NzBqOTg2endDV2FMQ1RzSkFoQW4wcXpHd0ZuWHIzSVNRT2tD?=
 =?utf-8?B?blUwOW9TNmFJWmR4b2U3UVZmcFdWT2FlSUFaNG9wcmhVNlI2Z0pLOG1kSmwv?=
 =?utf-8?B?MisrZnhqSHA1blJNSTFxVHNSOCtVK3RySHZDRkJPVi9nWU9kQzNwZlVpMjkz?=
 =?utf-8?B?VWNzQnF5Slk0SzF1dE9veFVkTSt0b3piYm1RTXdabzFteVdyb0hMVW1aS1dX?=
 =?utf-8?B?RnQzbUxiRTU0ZnFjcy9kUHJ5MFJDeG9INHN5NENGOG8xRkxkT3N0WEYrWGRm?=
 =?utf-8?B?ajdXanBkdXM1UGo3VzhNODMxdVpKT2JBLzBMZnFteFNmajNOM2l2eTVQb0pH?=
 =?utf-8?B?bEcyck1pMlJwd1p5MUh1ZFBzOXFpb0ZkbDA1Sy85OXVpVVdDellrYWlGbmJx?=
 =?utf-8?B?YnZ5YkVndktNdzJFTVhEc1dtdGJVRTdWa1NWSXBDYkU2OWtaUU9aS1R2aDMz?=
 =?utf-8?B?c0tyWDA5eXpVT3NLV1d4Rk1CNHU4bURmSDdFeXFERWQ5ZFFZTzFiRDUvWWtK?=
 =?utf-8?B?OENweGJ3aU84YUFJazByWlZndnRvRTVoZytYTWdqTktiRGk0RE95ajh6eFM4?=
 =?utf-8?B?ZUcxUjB3WXRGcDBjOEgxQ0NxZnhzbzF6QzJVeHV1b2VkQUUyaFBUTTBDcTg0?=
 =?utf-8?B?emNiT3dYcHM0bWJqdFZWbnlEU2RXZkx6a2ZrK1U3YkpjbEhyMER0REVlYkRo?=
 =?utf-8?B?eE1xZ3pNTy9vcUJzanc2VHJ6b1U5WS85d3hJamZ3a0c1cUpqdUlubndUZmNn?=
 =?utf-8?B?REtWOHBpWkNFdHJrTHQ5c0R2UWZIRGlUNHB1V01LOURkdDZhSWZCRm5QZ0lQ?=
 =?utf-8?B?WSt4dU5vTWVoZHRTVENoeXBVSHZDZkZWQWdXQUxuWW5PekxJTEY5dEpDZlQ4?=
 =?utf-8?B?Sy9ia3k5amJncFppd1JycXpCT3JmNzUvSGovakwvclorSnR3QVpRb1hFWHVr?=
 =?utf-8?B?cDZGR000KzBPbG9sU2tSd3ZoaGZoeTVpMUIyVWhtTVRTWDVFSjY4V01zZ2Rm?=
 =?utf-8?B?T2w3Y3pKdnUzdjNzU1ZIZkxobDhrdjNsNTVuaXJmOURicUMvVmJMbXI3aS9I?=
 =?utf-8?B?WS9ZUW1LRmd1cExhNU1GZDhBUHNvTXpSZEZ2cy85VWZkMHc3Yi9JdWQ0OW53?=
 =?utf-8?B?R045SnUwUit4UHIyZUYwNW42K0pYY01EUlhvYjNkY0hFWXFDWjBFQkkvdWdx?=
 =?utf-8?B?VVgyMnFiUkRhRFZVd1VtdHhyaG1zMktoSnVkai9aWHhTQzQ3ZGpZVlZvL2JE?=
 =?utf-8?B?TDdOL2ZTcG5KbENTYWNxdFErbW1FUjVMY2NnNHdmWVMzWEZ3c0NGZWhDS3lJ?=
 =?utf-8?Q?aZEUsIj6iRcQzi14M+g09DRqQ5KEG09GTaNveHT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: metacase.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fa64ca-8221-49ad-8af3-08d8e56ee019
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 15:52:43.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: df11bd32-ec93-4612-a601-51081dffef74
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XfECwIIOq1by2zl+9BwKvNPXJ71ub5iKmDgZX47+iY5OmjqWjFa5BuEuMi1WcEiMPcPEgYX6tpf5aA9TSNtshR+4Yh024+MeNfv9rlcuV5mTckTnIrvkxP5Sb5Ptyde0vfggj+T8TMKIfoivBdoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB0981
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVwcm9k
dWNlIHlvdXIgaXNzdWUpDQpDbGVhbiBpbnN0YWxsIG9mIEdpdCBvbiBXaW5kb3dzIDEwIHVzaW5n
IGRlZmF1bHQgb3B0aW9ucw0KZ2l0IGluaXQgLS1zaGFyZWQNCmVjaG8geD54DQplY2hvIHk+eQ0K
Z2l0IGFkZCAtQQ0KDQpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJl
aGF2aW9yKQ0KVGhlIHR3byBmaWxlcyBhcmUgYWRkZWQgd2l0aCBubyBlcnJvcnMNCg0KV2hhdCBo
YXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KZXJyb3I6IHVuYWJsZSB0byBjcmVh
dGUgdGVtcG9yYXJ5IGZpbGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCmVycm9yOiB5OiBm
YWlsZWQgdG8gaW5zZXJ0IGludG8gZGF0YWJhc2UNCmVycm9yOiB1bmFibGUgdG8gaW5kZXggZmls
ZSAneScNCmZhdGFsOiBhZGRpbmcgZmlsZXMgZmFpbGVkDQoNCldoYXQncyBkaWZmZXJlbnQgYmV0
d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8NClRoZSBh
ZGQgY29tbWFuZCBmYWlscyB3aXRoIGFuIGVycm9yICd1bmFibGUgdG8gY3JlYXRlIHRlbXBvcmFy
eSBmaWxlJw0KDQpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoNCklmIEkgb21pdCAtLXNo
YXJlZCwgdGhlcmUgaXMgbm8gZXJyb3INCklmIHRoZXJlIGlzIG9ubHkgb25lIGZpbGUsIHRoZXJl
IGlzIG5vIGVycm9yDQpJZiB0aGUgZWNobyBjb21tYW5kcyBkbyBub3QgaGF2ZSBjaGFyYWN0ZXJz
LCBqdXN0IGFkZGluZyBhIGJsYW5rIGxpbmUsIHRoZXJlIGlzIG5vIGVycm9yDQpJZiBJIHR1cm4g
b2ZmIGZzY2FjaGUsIHRoZXJlIGlzIG5vIGVycm9yIChnaXQgY29uZmlnIC0tZ2xvYmFsIGNvcmUu
ZnNjYWNoZSBmYWxzZSkNCkFsbCBvdGhlciBmaWxlbmFtZXMgYW5kIGNvbnRlbnRzIGFsc28gc2hv
dyB0aGUgcHJvYmxlbSwgZm9yIDIrIGZpbGVzDQpFLmcuIHdpdGggZmlsZXMgeCx5LHosYSxiLCBl
cnJvciBoYXBwZW5zIG9uIGIgLSBzZWVtcyB0byBiZSAybmQgZmlsZSBpbiBhbHBoYWJldGljYWwg
b3JkZXINClRoZSB2YXJpb3VzIEdJVF9UUkFDRV8qIG9wdGlvbnMgZG8gbm90IHJldmVhbCBhbnl0
aGluZyB1c2VmdWwsIGp1c3Qgbm9ybWFsIHNldHVwIHVwIHRvIHRyYWNlOiBidWlsdC1pbjogZ2l0
IGFkZCAtQQ0KUHJvYmxlbSBoYXMgZXhpc3RlZCBmb3Igb3ZlciBhIHllYXIgKEdvb2dsZSB0aGUg
J3VuYWJsZSB0byBjcmVhdGUuLi5vciBkaXJlY3RvcnknIGVycm9yIGFuZCBnaXQpDQpDb25maXJt
ZWQgaW4gZ2l0IHZlcnNpb24gMi4yNi4yLndpbmRvd3MuMQ0KDQoNClBsZWFzZSByZXZpZXcgdGhl
IHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cuDQpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMg
eW91IGRvbid0IHdpc2ggdG8gc2hhcmUuDQoNCg0KW1N5c3RlbSBJbmZvXQ0KZ2l0IHZlcnNpb246
DQpnaXQgdmVyc2lvbiAyLjMwLjIud2luZG93cy4xDQpjcHU6IHg4Nl82NA0KYnVpbHQgZnJvbSBj
b21taXQ6IDM3ZjBhNGFmYWQwMjdjZjAzMDc0N2ExZWY0NTUzN2JhODYxNjI5NjANCnNpemVvZi1s
b25nOiA0DQpzaXplb2Ytc2l6ZV90OiA4DQpzaGVsbC1wYXRoOiAvYmluL3NoDQp1bmFtZTogV2lu
ZG93cyAxMC4wIDE5MDQxIA0KY29tcGlsZXIgaW5mbzogZ251YzogMTAuMg0KbGliYyBpbmZvOiBu
byBsaWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQ0KJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0
aXZlIHNoZWxsKTogPHVuc2V0Pg0KDQoNCltFbmFibGVkIEhvb2tzXQ0Kbm90IHJ1biBmcm9tIGEg
Z2l0IHJlcG9zaXRvcnkgLSBubyBob29rcyB0byBzaG93DQo=
