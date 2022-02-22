Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB6C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiBVLF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVLFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:05:55 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40046.outbound.protection.outlook.com [40.107.4.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC1B23A8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkiyKbn+5f+iDQ0MZOoldmBpn7AM+oGynjYj0bH5hnbHRa5a92/+kuxOW+c5ca0zGf6HqQuIiVWZbf5pv5WMKrOnx0A3sXQ6On8pv6hCt7oLSRNSSoMr/vwAGFmCqKkGWRmcOTyulDfTMpfYmZoT8FaEG9qsXB+BPI9Zkx4lUjTFSz72NBq7M78fV+H9N9xxT4LMXcuKtn/MMCiHGvdhaouRklikNJ+VEwpaN1vuB9EDTVHfBDPZZQtGTgLs+G6mVWBvpJadirMCHZCD0tuNe5Xai8CEeHC1wwBSeQsQlSfD2fo9JewvlgHLK3OGQ67crmknaVNLaLVDf+BMqPZudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqt/nRbORMf3jh8S/WOT0Sea81m+w7KtrL5/DewivQk=;
 b=k1jqdPlr3u7N+iwmsrr1bmDHMDFlwFg0f+BMDHdCk4qSejukprxQzCFvBvoUmVE5OPYMPkdpAfnypWZ0oNXYVoMycJ3p3VyVZSHuSWl++c1rCvWy0CUzXCxp3a/GCvhbFbwGN1SLk5Ylj9A6N1e72gWlIQchjkF5aFjNZcf53CY/DYTpJxLYmmH1/UHv7fjeMOfBOLj8OC5Iaw73uXQ02dYsDMqfNqaCw2OTUbej3DXHjoOFTU6I6F1rKOmRBO/DUtxWg3d9mbpwwFiN3kBDC/SKadfWW63oKAp7UuvBBm6wg+vz7m+FNJ1pJaozQgOzVOin4HuGjPK/NfzcBaiNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innova.no; dmarc=pass action=none header.from=innova.no;
 dkim=pass header.d=innova.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=InnovaAS.onmicrosoft.com; s=selector2-InnovaAS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqt/nRbORMf3jh8S/WOT0Sea81m+w7KtrL5/DewivQk=;
 b=UtCffE90wfOGZ9QyTuBYwTcrYlQFHDd4gixAH2Z8lafs+5Gnxtb5gt4k899M0bTZxrCJ/lEgJ2NoYFxZ504BtsZJfRqSwQfFVIdnkowor7jTK6EOgQ9eiaQ5lrDn10e6yfBEcWufMZ6zc1A6sxqlHhdQdNC4IXyrd/M/Em28FA0=
Received: from AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:107::17)
 by AM9PR10MB5008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 11:05:23 +0000
Received: from AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9821:50c1:5abc:d3b3]) by AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9821:50c1:5abc:d3b3%8]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 11:05:23 +0000
From:   Erlend Aasland <Erlend-A@innova.no>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
Thread-Topic: [PATCH] branch: delete now accepts '-' as branch name
Thread-Index: AQHYIz6lb43BUNQhr0qRZh8P6cZkA6yWZSwrgAAkJQCAAEPgAIABL5gAgAAY2paABiWJgIAACzGQgAAjSQCAAQgJgA==
Date:   Tue, 22 Feb 2022 11:05:23 +0000
Message-ID: <EA5CFD34-9BFF-4030-9188-37953D947437@innova.no>
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
 <xmqqbkz6vjkj.fsf@gitster.g>
 <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
 <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
 <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
 <xmqqiltd9vyg.fsf@gitster.g> <220221.86pmngb22e.gmgdl@evledraar.gmail.com>
 <xmqqwnhota5q.fsf@gitster.g> <220221.86zgmk9g68.gmgdl@evledraar.gmail.com>
In-Reply-To: <220221.86zgmk9g68.gmgdl@evledraar.gmail.com>
Accept-Language: nn-NO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=innova.no;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2db7c77-7f60-4849-9234-08d9f5f33935
x-ms-traffictypediagnostic: AM9PR10MB5008:EE_
x-microsoft-antispam-prvs: <AM9PR10MB5008A835ADFFC1189A038C469C3B9@AM9PR10MB5008.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3q/r3AEPKCOzsi6FP1vEyE4fyv5TCBSy4QwbO/SUvGnX9DgUVw+9HI4iQSyRketlmoCo7fPY7pOOHVXzy1WFPVMvLUskWjtnML4ZmYV3zgIKZwZyz0BpvxX33ebQ0pAi+gInjUwK9Rt8YITnPFz4XHgPTIGW5qoBbcqssj77syoSHKCGxz04zF2Qixs7GGQ5o7/bS2yB+sYWd9bhuOEY+7MG3b44jgMReXVDT/zaB0fRPfdDQ7BvTFM/2aojIRPIraMTSSnBNFUMNnJ/gPnay4IjRFaUCJGmm99lx+OFnUDTtvxK457zDpw71Mvqzqdi9fpeDKyppQF7cnqOnVFnT42aEKlk2jj+yRYBvsUlkIxbKE4T26iPfdhpBUCFx8qxm/MvujjBymDAtPM/d5UtYdM3Adn9yXk4K3k9WDd9u8RZV5HndwlxGrNwBjAE2vcPjlfIDZfdPCJ3pLTVX75avAQ8p4QgrNRMOC+wgyPqlhQotNdldNMi/jhOL7CHAoVkT527+Pb/pEd5GULsMQgeL3suikSTGc8QaswXULCu5t1K748srmRM7PSYvMHQiR0SECpqW5NHqIvPDtODiCEMwUCtv8AJ4oh+Irefq5ff4VE1DNGoeOjmWwtEBr0FPLDJrT6ArEKvvnVI/dcictnHpNGoPCKzyDJ2Y/MoojuBca1gmRC+8rb6IVu3ZbO2u22mz3lJ3S4feAXYv/ser9gihrb2EqlZSwBgN8dfoYuqvE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(396003)(366004)(346002)(376002)(39840400004)(6506007)(71200400001)(66946007)(8676002)(53546011)(186003)(76116006)(91956017)(36756003)(66556008)(38100700002)(122000001)(64756008)(26005)(66476007)(66446008)(38070700005)(508600001)(6486002)(33656002)(6512007)(8936002)(86362001)(5660300002)(316002)(2616005)(2906002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bENVNDkrUGNYSW02bUZBUk5wRXV6bTlSaEkzYVU2SjRMZXFqN0p3eXdFcnls?=
 =?utf-8?B?NXBHZis2K2RSa1U2Mmgzb0RaK1BKYjc3bWMzdno3dnJ6T3ZrTWtjMzhjeDRU?=
 =?utf-8?B?K0p4VW9za1BIVnh1ay9nZitWdkVwem9zd2pMeDBvK3VadU9SU2RNUktVTUpU?=
 =?utf-8?B?NHFTZkdUeXpRZUhPWWJuVk11M0l5OFE0dnZ1b2xCU1FUbTd4RFJrZ01KR2NT?=
 =?utf-8?B?WDVlTW5paCt1eStNMnZKb0NGa3VkRDh2SVU2ZytNR0tsR29tRUhjcElBWnR5?=
 =?utf-8?B?cnZZTlh3dTdUYU1rcnhnbEVjeGlRdSsyRS9QVldVNVZJTFBGSXNKN2NvOWZk?=
 =?utf-8?B?ZERMaWRnM0xCczFrNXI3elBhcDNZbldIWXhZbjJUQ2ViT1hpVGJCbEdvVjY3?=
 =?utf-8?B?ZjVzTjlqa1ppUngrTGpiQVJIRUpDM05xWmZBSE0rejFqQmU5RHR6VUJHemNt?=
 =?utf-8?B?dHFxWklUbGo3VEMxMnlkeENVSGRUeDRyalc5VklsdlZXZjNwSUlQQ1pRTmpU?=
 =?utf-8?B?MzIyYTYvOHk4Y0tYRlZvMExMc25CZ3g1eFk4MzM2RmtIRHhiN0hPZ1R4djV6?=
 =?utf-8?B?WmtiVkpQQWYzYUh4QXpyV2pXSGRHZ05MKzdBTEorZmVHcnVaK2FISkhUTlEz?=
 =?utf-8?B?YVBmbGhhSTExODNjTEpYcHdCallhSVJobE4vbnZkQ2xnS3phOGZVek83bUdO?=
 =?utf-8?B?L2RXdUJrQjhwdDVzb2lZVGZEa2JnM2UrQ1VJSHZXWWxOM0RGaTJzZnRlMFM5?=
 =?utf-8?B?QmR1WkhxUmJ5blJ3cDQ5MVR3akMxeGxSWktIbERRTlQzSndoWmZwWHlYMHdI?=
 =?utf-8?B?dzk4S3NsSWFFeHZXQUtoUWFJZ0xCZmVEWGppVS80RW9XbUE2aFJub2k4TXR5?=
 =?utf-8?B?S3BmVUZlQUkwZm51NDNVQ3JpUGFOUWxMUzl0V0c3SmViMkxmaEF2WnZoVzYz?=
 =?utf-8?B?cDBQbTZZbUhzYkNRalVzTzRGbVRjb3lPQkpYZnRaTHBaUlZ2MTRVWDlOWlJv?=
 =?utf-8?B?YzNjK213RVJSTnhVd0RTTDJ2aFl6Uy9EVTJwdUoxU1lkK2cwQlluZERuRHdF?=
 =?utf-8?B?TUJtbHZsMExvL1V4WlNXQklhMFpxZHhjYVAyN0t0WHRGcitIWDlOTmxYRzdK?=
 =?utf-8?B?Lzg3Qk5hbmdSUU5ZbUFlRzMvVEd1Ym9RbWxHQWdJLzZkK2phZGpaNlp1Nngx?=
 =?utf-8?B?dDZSK3Zqb3FiK2ZVSGdzUElvS1Y4eTJZdnYrcWpWU3FqTm1wTGlrTzlYUEVG?=
 =?utf-8?B?NnZvNXZqSDB3MVJhc1EwbkZCVDRKbmFhWGlBamNZaFRlQnYwbVdBNG9uWm81?=
 =?utf-8?B?QkNvZzNrN0JGSzhKTkR6dmluRTExNDBoYnlaS2Q3YUU4cWtBaUl4NkMzWVF4?=
 =?utf-8?B?R280U3lmWVpMejgzVmNuRUgwU0xiNVQ0Mnl3Y2JyTGxoOWMrNmFWclYwKzBL?=
 =?utf-8?B?djhoN25FcnNLTm5vdk9nNXNTdUs5QnpPMkV5ZElZMFdzSGdpdUNSR2g5d0wx?=
 =?utf-8?B?dkdGc1dvQUd0Slh4anZYdDZHM0hBemorRTdBNUt2YjhQWnpKWFVCaVNmTG1N?=
 =?utf-8?B?MkN3TjFwK216OWtHMUdQUlFWUVNyWklZenhTR21oSXZJK3NVVnl2K21acFRi?=
 =?utf-8?B?SFh4bGJOOTA2OGthdytza0pwZ1FtRlNrYjE1dDlyZmdCNktRTTNuSFVnUE9x?=
 =?utf-8?B?S09md0pmSmFZcWxheCtqUk5ZWFQyeExmWFBVNXdSSFZ1SVlFNUd1MnZXeVdn?=
 =?utf-8?B?VGdYK0NZbnZkc3JKTDF2bVQvT1lZc3dDY0FDaUIrY3RkSzd3T1ZoL3Z1Q2pn?=
 =?utf-8?B?bEFidW1rNTc5b3B4Q3ZWOE9vUXhIVUlIbzBhNytTZkxXRUQ2eXpNd0orVDJU?=
 =?utf-8?B?MjVWNnR2b3pMQmRMRHBnV283VUlmOEdQemlQSENXWTh5WXgxenRTeUxwck8r?=
 =?utf-8?B?aDNjMUZSSWVzZXFoOUg4bzlGN2VSVzQ4K2hOeE1UZTRsS1htU0NYbFVvc29V?=
 =?utf-8?B?UmtNUWRzeVFOLzVhWkFIMVM4N3FCZTg0andYM1NXaVhmVDZoYjJad05ab3Zu?=
 =?utf-8?B?SkJhRHErQjQzdG5CRnk5WExhVUszZzZDang4ZUc3VE5EeDBlOS9ybXhkbklO?=
 =?utf-8?B?SlFQU3ZLK3JMUTdZRnd4U0MwZDVIWjQ2K1k4MS9RSnNJbFV0dzRJWHN6aERB?=
 =?utf-8?Q?68Bs/OFqbR+bsspR+XixL8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C49C4491B8EE6547AA0FD230A0E0C09E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: innova.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2db7c77-7f60-4849-9234-08d9f5f33935
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 11:05:23.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b7619df-4c48-4446-b5bc-62bc2f3cd746
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TfNv0/RpEbJlWFaqHDwsaBa/iQ8CJ6FkyfYF1qfIGXytUGyWUscxxFuOzYZpwxE68q0vNdhqHFg4nuqfVhRdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB5008
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IE9uIDIxIEZlYiAyMDIyLCBhdCAyMDoyMCwgw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24g
PGF2YXJhYkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBGZWIgMjEgMjAyMiwgSnVu
aW8gQyBIYW1hbm8gd3JvdGU6DQo+IA0KPj4gw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gPGF2
YXJhYkBnbWFpbC5jb20+IHdyaXRlczoNCj4+IA0KPj4+PiBDb250aW51aW5nIHRoZSAidGhpbmtp
bmcgYWxvdWQiIGEgYml0LCBJIF90aGlua18gdGhpcyB0ZWxscyB1cyB0aGVzZQ0KPj4+PiB0aGlu
Z3M6DQo+Pj4+IA0KPj4+PiAqIEB7LTF9IGhhcyB3YXkgdG9vIG1hbnkgbGV0dGVycyB0byB0eXBl
IHRvIGJlIGxpa2VkIGJ5IHVzZXJzLCB3aG8NCj4+Pj4gICB3b24ndCBsZWFybiBvciByZW1lbWJl
ciB3aGF0IHRoZXkgZG8gbm90IGFwcHJlY2lhdGUgKGFuZCBkbyBub3QNCj4+Pj4gICBibGFtZSB0
aGVtLS0taXQgaXMgYSBiYWQgbm90YXRpb24pLg0KDQorMQ0KDQo+Pj4+ICogQHstPG4+fSBtYXkg
aGF2ZSBiZWVuIGEgZ2VuZXJhbGl6ZWQgd2F5IHRoYXQgc2F0aXNmaWVkIGdlZWt5IG1pbmQNCj4+
Pj4gICB3aGlsZSBiZWluZyBpbXBsZW1lbnRlZCwgYnV0IHRoZSB1c2VycyBvbmx5IG5lZWQgdGhl
ICJsYXN0IG9uZSINCj4+Pj4gICBhbmQgbm8gc3VjaCBnZW5lcmFsaXphdGlvbi4NCg0KVGhhdCBo
YXJtb25pc2VzIHdpdGggbXkgdXNhZ2UuDQoNCj4gRldJVyBJIG9mdGVuIHVzZSBAey0yfSwgQHst
M30gb3IgZXF1aXZhbGVudCwgYnV0IG5ldmVyIEB7LTI4fSBvcg0KPiB3aGF0ZXZlci4NCg0KRGl0
dG87IEkgbW9zdGx5IChhdCBsZWFzdCA5NSUgb2YgdGhlIHRpbWUpIG9ubHkgdXNlIEB7LTF9LiBJ
J3ZlIHVzZWQgb3RoZXINCnNtYWxsIGluZGljZXMgc3BvcmFkaWNhbGx5LCBidXQgbmV2ZXIgYSB0
d28tZGlnaXQgaW5kZXguDQoNCj4gSSB0aGluayB3ZSBzaG91bGQgYmUgY2FyZWZ1bCB0byBzcXVh
dCBvbiBuYW1lc3BhY2VzIG5lZWRsZXNzbHksIGJ1dCBpZg0KPiB3ZSBjYW4ndCB0aGluayBvZiBh
IHJlYXNvbiBmb3Igd2h5IHdlIHdvdWxkbid0IG1ha2UgdHlwaW5nIHNvbWUgb2YgdGhlc2UNCj4g
c2hvcnRjdXRzIGVhc2llci4uLg0KDQpJTU8sIGl0J3Mgbm90IGEgc2hvcnRjdXQgaWYgaXQncyBh
IGhhc3NsZSB0byB0eXBlIDspDQoNCg0KSUlSQywgdGhlIEdpdEh1YiAiR2l0IEhpZ2hsaWdodHMi
IEJsb2cgaGFzIHByb21vdGVkIHRoZSAnLScgdHJpY2sgZXZlcnkgbm93IGFuZCB0aGVuLg0KDQoN
Cj4gSSBoYXZlbid0IGhhY2tlZCBpdCB1cCAoYW5kIHdvbid0IGFueSB0aW1lIHNvb24pLCBFcmxl
bmQ6IGFyZSB5b3UgaW50ZXJlc3RlZD8gOikNCg0KVGhlcmUncyBhIGxvdCBvZiBzdWdnZXN0aW9u
cyBmbG9hdGluZyBhcm91bmQgbm93LCBidXQgc3VyZSwgSSdkIGJlIGhhcHB5IHRvIGdpdmUgb25l
IG9mDQp0aGVtIGEgZ287IGF0IGxlYXN0IGFzIGEgcHJvb2Ytb2YtY29uY2VwdCA6KQ0KDQoNCg0K
RXJsZW5k
