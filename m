Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7ACC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 12:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjDEMPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjDEMPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 08:15:19 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2081.outbound.protection.outlook.com [40.107.116.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87B3C22
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 05:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEVd7MWLAPDFIKOcxi4PSw5HxhmbmCYxUcd8bJaOjOhuGVT+UhgTzkkruKs2NkOYcR+9Jx9B6WUtgEjVvQmz+q2TQZ/msXfKV9gTbNLF+1zOsvhdyZkS09cx1lelHkPWk/ntQB3uaLoArRrX4OqxuDdwjvyI5QqzJLVor1s2uaRaXBcoR70MbOUV9lFQgElTLE7B444YUGdRel7HGH9XF+KDCnkDJZju5uCXXsUERUOKbMdeUptKMaWZA3mItoB2p4kjQIQ8tsMogtMthFZACX+CGIh6upXPWcDNERm+jScsHWT9SP+sIb+8nFcUnUGttfQXOlxP6PmIAVrbSDizwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTJNF/D4UB6bxVPB4dybBvBYbm2dlw4az3fciSXBDLc=;
 b=PlgEj/OR3FuwVDvGuCjXYV8DWzDZ+/r+gJ1m8VhD0hPCQ2ro1DL7BwY/PnLTjQH5Tt6lYls3jjGK32hneZTSFg3BeDR+nB9X15VUJ/CauOYznj0uFD7BWgMZi96xaLbrb+PcJ/t3trg5XHSllkTcFWxYZ5qMU3QWWuBKzwtz/HS3wjOz8QfdN4Z6Jjy1yCeyfwMvOLA+9b77REmOfhsbJCDu4sl+JZBtfjpYcnCIg7F6we3Hmdx0p4sr2D+JwTvkWjddlbqtG1JKfToKbeZg8WrxNv5Yo2Hs7RlMXx3zZ3/WPmDBi0iaMcIm77y8syY08pmy3teOVAHwPFNwHhnOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pqm.net; dmarc=pass action=none header.from=pqm.net; dkim=pass
 header.d=pqm.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqm.net; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTJNF/D4UB6bxVPB4dybBvBYbm2dlw4az3fciSXBDLc=;
 b=sDo/dIBh6nc6sX6SE7C4uDuRCZFkaEkbVdIvXgbLdabzE78jICDeTTdrHHWv8AQpVZKaG3TNqmdJuLY+IqAxbIGF4H2oKGI0inTwQ0UOd/9AFsO4V34oob0nmHcMyDlLZYVvYa+I0L/cI2+dBpEhyNdUHOIhIsrJHJAalET4CPk=
Received: from YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:da::5)
 by YQBPR0101MB8973.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Wed, 5 Apr
 2023 12:15:15 +0000
Received: from YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd3:5a92:347f:73c0]) by YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd3:5a92:347f:73c0%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 12:15:15 +0000
From:   =?utf-8?B?RnLDqWTDqXJpYyBMYW5kcnk=?= <fred.landry@pqm.net>
To:     Christian Couder <christian.couder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git fsmonitor
Thread-Topic: Git fsmonitor
Thread-Index: Adlm/sv4v3lJVuUFTSS72doHUgizPgAAFr5gAA0AUgAAITV+AA==
Date:   Wed, 5 Apr 2023 12:15:15 +0000
Message-ID: <YT2PR01MB9874CFFE2EA5F9E635D59993F0909@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
References: <YT2PR01MB98744AB0A168B729E89D57AFF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB98749C01D9FE7D040F80A51DF0939@YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM>
 <CAP8UFD1KCCqOFQ86Q4Sg4x0KYrO4B1dRyJKih74S61JsTGim7Q@mail.gmail.com>
In-Reply-To: <CAP8UFD1KCCqOFQ86Q4Sg4x0KYrO4B1dRyJKih74S61JsTGim7Q@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pqm.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB9874:EE_|YQBPR0101MB8973:EE_
x-ms-office365-filtering-correlation-id: e369aa60-8de1-4ca5-d340-08db35cf6a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+5i7zqMt6CCP+2tDN2yhmaX8G8LZ3PWPmkUI8ERx1pWBf82PPMJ36bClQopgxEHti6I8LoaP0oks62OKt5/X1xas++dLeTmjGdCTlWtO/zgx6eLfkEspmpaPEEwQgKvG1v+i7QmZb0NGxuSfKQH5Tepv/B/dbky3F9q4i6tPgLawItoDHFR6BdUUUiuXxoBGGJ3reO4lT70a1P7OSASnGjstEJxFEWpJP4q2R2vUezki0Hqko21wwV8Q8wATNCtuQa8A/JKsqvEwJVxPa18g6D7Wg13ksxAn3nwDebpBpsFi8sQUASzEH9Fl22t+kkSrbuZXW8rLBhDuFK73wEBjGNaXSw2qYmkp31wzksEVTHPOVTUjcLkjw4giQPBDjRxBwNb69uidqu7uN3dHkyjEYlH7fFA2ij5n/XpafrtB7kkeLhgBMBHrMBsxj7CR2A5o/erpALni3HNJBT7AoEbfjq21MA8voMqRRmPm9DgOuePNRCinyYxDSEQBxhBopzYKzttuKkYbjcLPjvxgvuc3GTPxzo8zwLfK4p+YRid4RqicWv8q/QhmYIBz4NzPuFUlrnyMX9bSQYAP4GO3odWf4AeBKpuq5s+N0GAN27+7b4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39850400004)(366004)(136003)(346002)(451199021)(26005)(5660300002)(52536014)(8936002)(7116003)(55016003)(33656002)(53546011)(9686003)(6506007)(3480700007)(122000001)(186003)(41300700001)(38070700005)(71200400001)(85182001)(66574015)(86362001)(83380400001)(66946007)(76116006)(66446008)(66556008)(85202003)(64756008)(7696005)(66476007)(966005)(4326008)(8676002)(6916009)(316002)(2906002)(478600001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clJiNnF5RGpVc0J2NlJBblpCYWFpQTh6a0FkQ1ExL0tWYkZBSi9EYVdUenls?=
 =?utf-8?B?SzFtbDVCRFJYZTFHSjlhNDdZN1ZwQ3VzRjhyVjdpME1DaUpVUkVmTlF0M3k4?=
 =?utf-8?B?L2k4bGtYUVBvbTZEK0kxRXNSc3RHYWwvQjRtU2RwVDdsNU5IUkJvVW5RL0Zn?=
 =?utf-8?B?YWVyK3MrcUJoUUUyUzY2MVRFbUJQTXJEUVV6K2MvZTdINW92eSs5MmtQQnFa?=
 =?utf-8?B?R3FTVFhBWSs0aDNpNDFrSHV5cHlFT2NNanlFRVZtNUc2ZjE3S29lTm5mdHNL?=
 =?utf-8?B?OG9DMG9qc09XcElRZ0pyNzNaYjFEdE1jcEs4ZVZ3QjNmNERIeDExTDdqT0pT?=
 =?utf-8?B?cjFKWjZUNFRHMUk0blNrMXhweXE0Q1UwdGFyVzBpTXI3WUFtckFPYngxYUIw?=
 =?utf-8?B?NHJTK0dWZC9uTDdyK2pxeVF2MWxFTkc0NUtoMlpvQ3lPYm9XVEh0ZnRUbU8y?=
 =?utf-8?B?azB4YUt0bzBNMURhYkFGSThFQ0MwdXBwRmhRSHpQekdzRkxkbkxTNng1VmdE?=
 =?utf-8?B?bXJCNUplTkEzNmJUbzFhZEl3dlczdTk4Zk9yM04zbGR5eVFSK2FZNnMwR2Fs?=
 =?utf-8?B?eFFFNHlLZVc1VkhTU1F1Y0RyS2pkRWdnM0IrM0UrYkphdnZSbnY2a08vUXAz?=
 =?utf-8?B?UDhGdW1OK1A5N3ZlZjFPRk5vdDU3NkpNeUk3WUduRFJFMjVEcVhzcGRiTmNt?=
 =?utf-8?B?eCtvUE1hV3BkTTM5UVgxS1hzSU9VSlZzcXl1dWw2T0YzTzFmekRLVDRJOXRX?=
 =?utf-8?B?UFErSjFxSmhPUms4cWkwazZPN3diWnIxMFYrRlBZV0haQ1hIMUc2aE1TcmxL?=
 =?utf-8?B?L3hlTklHbnJhY2M5YWJJM2pWS3A1QlVZODhPUkEzQ1VBd04wQ1J3NVZNZm4y?=
 =?utf-8?B?SXR6bWxIc2o2bnI2aFhQQ3lyUXBHR3lIQkJSYnhwWWFYZ0dvQzJmK1N1NFMw?=
 =?utf-8?B?LzRDTUREWG9EUnR6cG04YWZvWXA3RkNTZHBPZEpQMkxNenJKTjVHdHJjYTN5?=
 =?utf-8?B?R2wwRk9UL3N4a05LWFMxKytSa2t1UDgyemthRzM2Q3FZTXlzbGhhOVFvSks3?=
 =?utf-8?B?SHQwSFZORTl6K0Q3WEF0NDlDcXVYcU5FalQ2cXJ2Rm5tTisrWVhHTjNIamsz?=
 =?utf-8?B?NTFsNnRlbVNlaWd5M1BrdzFvWDJxbjB6NFZuU1gwVVBRLzB2Zjlaa3g2ZGJP?=
 =?utf-8?B?aWwzS0svZnIwMDFuaHZsZVFPQ0NGT0IrcG9NUjlweXNQK1N5S0dSbWFWVzNO?=
 =?utf-8?B?S2NyMUt4M1pQMjNJMXJ2VVNNOFhQZUtPSlZROTlZNXVGdnN4Wm9yQVZLMWhp?=
 =?utf-8?B?dFlDdTVEL3J2TUt3ZVZWZjV2WXd5VGpuUk9RejA5UDZHc1RFeENPUmlsOEtR?=
 =?utf-8?B?c3N6cUM3am9BZnJrNVU4VzQycTYybjNaNGQ5em1qa2ZZOWhMWFlrWThZdWh5?=
 =?utf-8?B?cUlVSG1JaWh5NUxPOWhsWmdYem5ETDVvT2l1NkNOUjEyZXcrS0NSMm4rcjYv?=
 =?utf-8?B?REdRamVLSytMRTJuR0pZMlNXdXR1THhSQlhhd1BpTVIva08xYVRpN0NtUG5k?=
 =?utf-8?B?RkwrWWsyUGJHcjAyblBJbHJrZ1hjUVlWQW50K3pnUDBNSURPbE5uRU1aUjg4?=
 =?utf-8?B?Wk83OENGcDNXaG45L0NQeHd4N1kwOUhHOXlEOExiR3p4RkVkcXRTcnFWdG9R?=
 =?utf-8?B?YTdoQ2ZhUDVscDZWMFRoNGk4ZU5LMkQ1YXdHS0NENG5zSVZNTEpPT3JHcHZ1?=
 =?utf-8?B?bVlCWW14R3ZDNExuUDBHWndTd1ExQkxJcjFDd2hLUEZkbm1oSDRQOTdxR1V4?=
 =?utf-8?B?RFYrRElSd2ZRdGlIN0RaVW5zOVVUbnV3eXJUZ2tBTlNFdHB5MldRS2xXamt4?=
 =?utf-8?B?VkZDNkNsZk85ZXFNRXRrbDhRZnJjdjBsSkhoSDR0VVFKYW9aeGh0c3gzNG0y?=
 =?utf-8?B?eVY1NFZ2V3lLT1ExMFY5QzZsZlZLdytSdTF2VEhlRWovWXN2dElPeURWTnk0?=
 =?utf-8?B?OFQzTU0zc2pwamJJMDFOT1l6NVhPOEVqY0NrMXFId0Z0TmtJRTh3VVIrVTdY?=
 =?utf-8?B?MVRJSHVSYXJBMlNlWWpTbVFISFFyQlpJaStEMlduLzlJYjlFdUJiZXBRbERl?=
 =?utf-8?Q?DOiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pqm.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9874.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e369aa60-8de1-4ca5-d340-08db35cf6a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 12:15:15.8135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e3b41ca-ca79-421e-8e11-8dba90c2f296
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tx7q5T5smMf3Tb/jMILZKCyZ5wYiQqSBQ/qjhlfwWf2eOt1t/6L/D1KcCA7lY6pQ6ru9I+t3vh3HZwMqzjoOYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8973
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSEgSSBkaWQgbm90IGJ1aWxkIHRoZSBkb2MsIEkg
c2hvdWxkIGhhdmUgISBzb3JyeSBhYm91dCB0aGF0Lg0KDQpXYXRjaG1hbiBsb29rcyBwZXJmZWN0
ISBJIHdpbGwgdHJ5IHRoYXQuDQoNCk9oIGFuZCB5ZXMsIEkgbWVhbnQgMi40MC4NCg0KSGF2ZSBh
IGdyZWF0IGRheQ0KDQrCoA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hy
aXN0aWFuIENvdWRlciA8Y2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb20+IA0KU2VudDogQXByaWwg
NCwgMjAyMyA0OjIyIFBNDQpUbzogRnLDqWTDqXJpYyBMYW5kcnkgPGZyZWQubGFuZHJ5QHBxbS5u
ZXQ+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IEdpdCBmc21vbml0b3IN
Cg0KSGksDQoNCk9uIFR1ZSwgQXByIDQsIDIwMjMgYXQgNTo1N+KAr1BNIEZyw6lkw6lyaWMgTGFu
ZHJ5IDxmcmVkLmxhbmRyeUBwcW0ubmV0PiB3cm90ZToNCj4NCj4gSGksDQo+DQo+IEkgY291bGQg
bm90IGZpbmQgZGV0YWlscyBhYm91dCB3aGljaCBwbGF0Zm9ybXMgYXJlIHN1cHBvcnRlZCBmb3Ig
dGhlIGZzbW9uaXRvciBmZWF0dXJlLg0KDQpUaGUgZG9jIGFib3V0IGNvcmUuZnNtb25pdG9yIHNh
eXM6DQoNCiJUaGUgYnVpbHQtaW4gZmlsZSBzeXN0ZW0gbW9uaXRvciBpcyBjdXJyZW50bHkgYXZh
aWxhYmxlIG9ubHkgb24gYSBsaW1pdGVkIHNldCBvZiBzdXBwb3J0ZWQgcGxhdGZvcm1zLiBDdXJy
ZW50bHksIHRoaXMgaW5jbHVkZXMgV2luZG93cyBhbmQgTWFjT1MuIg0KDQpZb3UgY2FuIHN0aWxs
IGNvbmZpZ3VyZSBhIGhvb2sgaW5zdGVhZCBvZiB0aGUgYnVpbHQtaW4gc3lzdGVtIG1vbml0b3Ig
dG8gZ2V0IGEgc2ltaWxhciBmZWF0dXJlIG9uIExpbnV4LiBGb3IgZXhhbXBsZSB0aGUgZ2l0aG9v
a3MgZG9jIGhhcyBhICJmc21vbml0b3Itd2F0Y2htYW4iIHNlY3Rpb24gdG8gdXNlIGh0dHBzOi8v
ZmFjZWJvb2suZ2l0aHViLmlvL3dhdGNobWFuLyB3aGljaCB3b3JrcyBvbiBMaW51eCB1c2luZyBp
bm90aWZ5Lg0KDQo+IEkgYW0gcnVubmluZyBkZWJpYW4gMTAgc2VydmVycyBhbmQgZ2l0LTIuNC4w
IGFuZCBJIGFtIGdldHRpbmc6DQoNCkdpdCAyLjQuMCBmcm9tIDIwMTUgb3IgR2l0IDIuNDAuMCBm
cm9tIDIwMjM/DQoNCkJlc3QsDQpDaHJpc3RpYW4uDQo=
