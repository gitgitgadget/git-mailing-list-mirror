Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC1BECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIVUfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIVUfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 16:35:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA58C95687
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 13:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SShr6OeVSKHLP7fhSbWKmoybsr+BadGbula0NxzsLa+FsVIpHdjHRIY8aaqI5CH7ijd2d+JYrwwzLHDgluqNgoCgE5NAPA3wUtkFczjuzJVFrxf1FVqZJ0Yykb2vHrplsZsvuXswBr0mzX2gtXjd9yUfq4sDqAVMdENdq3ZyxLumKe96ao5FPhW6/fW5BAFA5gu8EAtgUhUwqQ9wMl+WnqPEmGCQTcQkheqfgGH+XizC8jxhO1jqyqwhZSFGYDmmLxvFRHIAavHw2mda+5Ef5JzqVn7EcR0ZClUTBxVU6OfjBTpXoumn07Jg7jhW+foV0DhhBaLG7+Smn1wvGDUcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWLGEX+CWJWePR81/KCWjIPSHza2+/KdSpHhQIr2xuU=;
 b=JHr+WvDL5ewDNbDzsvLnBuEaOgO8ClSDvyZaYZD/BFwCgvbdrgGXaw+lt10Awg10iMrt219DKJY7Zm4CrpZUs5JbyhUUvfy4FUTN2KBEUl6zjRZvynPK7EF7/ptmc/uiyCnQ9yUwXJboXfL9kiSCI1tmwu006udjjdlg5grFI/8g/xKI8fr7fol8YfOHyGhlQWn71lih6Pdae3qvWvmBcZo2IsmyRNolatfKbFrVOHf+ZecXz0/cHX+AwOXCiOv1J9NDa0Wx56ZZyDREmP+iJko1FApMZ/R5Yj2Y8HxLJEpTTxAiGe2eHIPCuxnhklrxmnR609WoQAX+fQ3ROqSiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWLGEX+CWJWePR81/KCWjIPSHza2+/KdSpHhQIr2xuU=;
 b=r+8+Bvs5ar98d+7GkLZc7WPp5yeiCockA3wa/8f1kre+PKCVaLCb/VC8xAn63XvK7omgfJ3NwI3q6KwhKCPNKZ1OtVnYe9XxYtYKfUg2IGhTgpmez3SexpmQzIW+OlJ69I6EtvwpslUsztA2bxo5PuJ0tq2X5A00jYYYqyfU5IYLdazArjcsqdN+3h6e2/15jCMu+JaDzl5LaogurNAuSIKfhSBS0pXfBObZWwzPtK7PZkFn3svC4RZswFVlctzjBXQ7hAyqkExIkvneBRldN9OgMH6SfLznWMSa9dLpxWQ/USkkegTXfb73tGhESyyHQRKkTjmwCwHcGbDi/l8tzA==
Received: from PH0PR06MB7639.namprd06.prod.outlook.com (2603:10b6:510:4e::18)
 by SN7PR06MB7135.namprd06.prod.outlook.com (2603:10b6:806:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 20:35:09 +0000
Received: from PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18]) by PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18%8]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 20:35:08 +0000
From:   "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git --archive
Thread-Topic: git --archive
Thread-Index: AdjOYUggigRgkiEITWKCyoo+Qa1cmQAXoZumAAAHifA=
Date:   Thu, 22 Sep 2022 20:35:08 +0000
Message-ID: <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
In-Reply-To: <xmqqleqbxj4h.fsf@gitster.g>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.600.2
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR06MB7639:EE_|SN7PR06MB7135:EE_
x-ms-office365-filtering-correlation-id: c3fc6a1b-5e1d-41da-f622-08da9cd9f0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92pUKSkch0NbiV5muK3RDlG/mU+XXZKHvvkzDYepvhtIHuLHWcMWYECoBDAsMyJluu5HL/bDs7JWIMI1E/ts2/IQls9IFij3HF6uLGspm3qRaw7cRCn/fx0Hx4CeRSJJ1wWTWJ8d00xjJy1c7dOcjt78bXKyjvflniLmoIEIj0aetgGByGar3lnm3R6F8uqRb89A4MVBcAoIG1U2fK4rBcgE9H9Y/XNRxq8RNvXJjfJzu6Ol1X3lavWv9Y6dTzctB7fqzUPHk4QNHkz+tFo1NrFs2nRqhW+8adEMUDN/4LQ85h32+tlI2Kc6aRjcx3m/6Bv9CrbXrRp+To8zr2Q3WIZ/8mhq9j2YNySXuVfS0dvw7LLbcct8mEfZA329MlF58E06LU19c9StTaem8AVXtj1+5Lb+sTsRJarpEEJLjynEcDY6jN3RYEnhTtIx152KCwGsfhHS6f4E4MLkHyuzCwiC8s/NhMhsI+DlsR3gNGZPAhYYz2ygij3/C0nevJzGB9K2FaGVOckk63aj1hhi5PlaBbNJqPJx9aGsfS4EEG07PJXhGCehORzH03h+cK0AOdZLJcI2IWmfgxQ/gIHH2qUfNemwH9kOCyiInUENBVZN4yt4u9Uy9mcLntrcHK9gOMg+sFzETFY/Ss7rwOXWYI5ytp7T4tAC6p/zhln6MVsEXrngbdbVm/SbV38cDurDbySbmx7BvQl0ALJ3Ya0B8rCyHNvqqWwRqdi/LykmGFbS2aUOZlXrIju+7J96I1FdJ4J8mO85jHQ+9kLLi+d90A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR06MB7639.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(7696005)(6506007)(41300700001)(83380400001)(186003)(9686003)(26005)(55016003)(86362001)(66899012)(38100700002)(38070700005)(122000001)(66946007)(66446008)(4326008)(66476007)(33656002)(8936002)(66556008)(316002)(6916009)(76116006)(52536014)(5660300002)(64756008)(8676002)(478600001)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU9sUHpTVUtwNUduMUhDV3JUNFhpZ1NCTWhZSHhLTlFHSVJOVnJPcTJpbDFw?=
 =?utf-8?B?OHZ2bXBYMmsxWkVxV2ZJTzB5c0NJRFY4K3VRQ0h0d1R1a3UwV0ZkRGc4cm90?=
 =?utf-8?B?aFhoWncya3VpT3ZGRHRLeVZoSEVlTExzSCtUblloamtXcS80K2JHK3Nvd2Fz?=
 =?utf-8?B?OTI3bGV6ajh3Rm91V1E5UDdUNURRTFVjREpYUmVKNEZWRmN3Z0UvNWtrU1o1?=
 =?utf-8?B?TFZPQjJGenI2V3loUXA0SXNLbm12SXFMVnB6RS9OSnVHT2M3ZFFjSUhCd3Qv?=
 =?utf-8?B?WUU1dy8wMEU3WXRpWEY4KzdlaGlxVEd1WWhlSG5iQ2pLL2xRVGszMUZ2TUhk?=
 =?utf-8?B?U0xNZUdGaHFZc0NPUXgra0luUGxtYjFteHVLYWFrN1VsaGFyK0VING5lTlRt?=
 =?utf-8?B?aW9reER0NnM5NG1SQ2VRT2I3ajF6WThTc20zakw1Q21TSlg5RUVTalZpOFRP?=
 =?utf-8?B?T3M4bEl4a0Rjb0ZKcjR1L2lvZkpkdTBjamluS2RsVVg2SURFeSszVmVwUElH?=
 =?utf-8?B?UjdtVDdXN2JRakVmUnd1S2l0RDNETllXczNPREIvS1hicllHMlFtZWhxRmhw?=
 =?utf-8?B?SXl0NDNKSGxPQVdob2tZN20xVkZBaWFic2dZdlA2RXlwVEhDeE0wdUg0QVN5?=
 =?utf-8?B?WFdCZ0hFNDR4T1lnV3VSV0owY2x0eGFsRWFtY3Y4WnZkeWc0L2E0akJTVmsr?=
 =?utf-8?B?cTRWNERGb3U3RnZTUVdtMzU4dnp2VVAreGRkMGoyeFltcFdEN005aTNaYU1X?=
 =?utf-8?B?R0RVKzI4M2NYdEQ3VUNZak42N2k5QjJ4dkkzc1pGSEdaWlpkNC96MVZpTVkw?=
 =?utf-8?B?eGtWNUM1ZFp6bkRUeWZncStvNkdQa3pDYWlKUnVuT09VQjBRRjRyZk4zajZ3?=
 =?utf-8?B?TDBuaytyUE5PM2g3b2ZubG8vNUl6ZFVaMnFRVkxIUlBnWk1DcWVYU3NIY1lZ?=
 =?utf-8?B?NVBDRFY4VnUzOGREaW1EUDNMM016WWMwQzZobk83dFk5d3ZvR3JKMVZZWVpw?=
 =?utf-8?B?R1k2bVBrOEtZblRuRXlZQzN5QjFmdmxuTGt3eHpTWGhzZnlpVU9ZdmRCcHZ6?=
 =?utf-8?B?cTlzNno1OUhndDJkdEx0YlByb0NGbDYyS08wdmVzTEdhZXgvUHJPYTBNL2Ew?=
 =?utf-8?B?SjlPcUtlRE9KN1NkRkVIdXZNaDZEL1pkejgvYk9DRzZnZk5JQXliQlUySUJx?=
 =?utf-8?B?UnN5ekRhRXoyak8vRDFuakxKZ3FJaTkxZC8yYThLcGxuSjBqMWMwdFlGM2tu?=
 =?utf-8?B?Q0xjZmRTZmNPcGIzOFNvNE1XM0U3NmlOb1Z4VGV4QW0rdkU1Tm9pbEgyeUF5?=
 =?utf-8?B?YlNRWGNtTUxQRStlWVFlR3lHdFlCL2xseEVCdlk2VnpBV2dHZGVXUGFCcDV2?=
 =?utf-8?B?WGdteEJiZVFXbXlYdmdSSGtralBEN2R5SjlpenFoaGJlMkwxZkNlbDdqWGgz?=
 =?utf-8?B?VnBPR2t3MU56YjNxSGpJejJ3ajdtTXoyK0pSNS9XUVQ5UGpuclBPWTB4c1hO?=
 =?utf-8?B?am1lTnlsLzZzMFBtUWkreDliV2lwYUp1VXE2Vkt4aHFPVXUzaUl4Q1BqM1l3?=
 =?utf-8?B?WExiMEpTRStWcVBndzFMZWVwZEY3R3VOTU90akg0QVRGMjBjanMvS2RXbmlS?=
 =?utf-8?B?Q2VRdnlTeUw5ZlI1dDJIbmxGaFRFS3gvSXRpMjdSUkhqYnVKSDZRNUlNY1gw?=
 =?utf-8?B?NHRzdzhjWWpqMDUxNFVFbE5CY08zbm14L3JKNlBYR3Z4Nzhac056c0ZvM2o1?=
 =?utf-8?B?ZmdpT21FRDJiM0swMmpNV0JHTEVvcG52S3NqK0F1WHdpd09YMXExdTFrWjBS?=
 =?utf-8?B?eGI1azVGWlFGNCtCd0VaYWJ4TnhDd0J4MHh4ZWRHU2MwUGJJS3kwQkFHVklv?=
 =?utf-8?B?RmZJNS9KZWNFb2dKNEJVam1tdnJ2RzJGcG5JQlBia3NTVE9xQ1dBQUtQeTlB?=
 =?utf-8?B?a0QvK0NCNVhuUEZWOWhyUFd0K0pzVGMvSjFXWSt1QUZaTk1GSm42b0NDa2Er?=
 =?utf-8?B?amROeXY0NFB0MFc3N1BxaHdFb2o5L2hYTFVnVjl2NHlKc1luL1ZvdUU5UG9C?=
 =?utf-8?B?M0NnVCtmTytGRXd0UDBLNzFzaWdwM0xXR1VKTys0cEFjUnM1SE1PZzNKMGFC?=
 =?utf-8?Q?6d5ABCGUu6QziCZ1CtWdMhExE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR06MB7639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fc6a1b-5e1d-41da-f622-08da9cd9f0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 20:35:08.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvcyvu0QC2xI9yPYN/MUxyrlEt3DClTh1v6csghXgIiEf+OQohwd6Y8cQRzSvgA0MO5qRaJ9tHb8ku3BLYuXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR06MB7135
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSnVuaW8sDQoNCj4+IFVubGVzcyBJ4oCZbSBtaXN0YWtlbiwgdGhlIHByb2NlZHVyZSB0byBj
cmVhdGUgYSB6aXAgYXJjaGl2ZSByZWFkcyBsaWtlIGEgcmVjdXJzaXZlIGNvbGxlY3Rpb24gb2Yg
YWxsIHJlbGV2YW50IG9iamVjdHMsIGFuZCB0aGVuIHdyaXRpbmcgdGhlbSBvdXQgc2VxdWVudGlh
bGx5LCBpbiBhIHNpbmdsZSB0aHJlYWQuDQo+Pg0KPj4gSXMgdGhpcyBhc3Nlc3NtZW50IGNvcnJl
Y3Q/DQo+Pg0KPj4gSSB3YXMgd29uZGVyaW5nIGlmIGEgaGlnaGx5IGNvbmN1cnJlbnQgZmV0Y2hp
bmcgcGhhc2UgY291bGQgYmUgDQo+PiBvcHRpb25hbGx5IGFkZGVk4oCmDQo+DQo+IFRoZSBkZXRh
aWxzIG1hdHRlciBoZXJlLCBJIHRoaW5rLiAgRW51bWVyYXRpbmcgYW5kIHNsdXJwaW5nIGRvd24g
dGhlIGNvbnRlbnRzIHRvIGJlIGFyY2hpdmVkIG91dCBvZiB0aGUgcmVwb3NpdG9yeS9vYmplY3Qg
c3RvcmUgdG8gdGhlIGNvcmUgY2FuIGluZGVlZCBiZSBtYWRlIHBhcmFsbGVsLCBidXQgdGhlIGVu
ZCByZXN1bHQgcHJvZHVjdCBiZWluZyBhIHppcCBhcmNoaXZlIG9yIGEgdGFyYmFsbCwgd2hpY2gg
aXMgZmFpcmx5IGEgc2VyaWFsaXplZCBvdXRwdXQgZm9ybWF0LCB0aGVyZSBpcyBvbmx5IHNvIG11
Y2ggeW91IGNhbiBob2xkIGluIGNvcmUsIGFuZCBpdCBpcyBub3QgY2xlYXIgd2hhdCB5b3VyIHBs
YW4gaXMgdG8gZG8gdGhpcyB3aXRob3V0IGZpbGxpbmcgYWxsIHRoZSBtZW1vcnkuDQoNCiJjb3Jl
IiAocHJlc3VtYWJseSByZWZlcnJpbmcgdG8gdGhlIE9TIGtlcm5lbCBtZW1vcnkgZm9yIElPIGNh
Y2hpbmcpIGlzIG5vdCB0aGUgb25seSBjYWNoZSBpbiBwbGF5IGhlcmUuIA0KDQpBcyBtZW50aW9u
ZWQsIHRoZSB1c2UgY2FzZSB3b3VsZCBiZSByZXBvc2l0b3JpZXMgbGl2aW5nIG9uIHN0b3JhZ2Ug
c3lzdGVtcyBtZWFzdXJpbmcgaW4gYXQgYXJvdW5kIDUwMCBUQiBvbiB0aGUgZmlsZXN5c3RlbSAt
IGxpa2Ugd2hhdCBpcyBub3QgdW5jb21tb24gb24gaHlwZXJzY2FsZXJzIGFuZCBsYXJnZSBjb21t
ZXJjaWFsIHNjYWxlIGRldmVsb3BtZW50IGVudmlyb25tZW50cy4NCg0KVGhvc2UgZXh0ZXJuYWwg
ZmlsZXN5c3RlbXMgKHRoZSBmaWxlc3lzdGVtcyBkbyBOT1QgbGl2ZSBpbiAiY29yZSIpIHRlbmQg
dG8gaGF2ZSBzb21lIG1vcmUgb3IgbGVzcyBzb3BoaXN0aWNhdGVkIGZvcm0gb2YgdGllcmluZywg
ZGVzdGFnaW5nIGNvbGQgKGluZnJlcXVlbnRseSBhY2Nlc3NlZCkgZGF0YSBvdXQgdG8gaGlnaCBs
YXRlbmN5IGRldmljZXMuIEFtYXpvbiBHbGFjaWVyIGJlaW5nIGFuIGV4dHJlbWUgZXhhbXBsZSBo
ZXJlIChvbi1kZW1hbmQgYWNjZXNzIHRhcGUgZHJpdmVzLCB3aGljaCBuZWVkIHRvIGJlIGZldGNo
ZWQgYnkgYSByb2JvdCBhbmQgcHV0IGludG8gYSB0YXBlIGRyaXZlIHdoZW4gZGF0YSBzdG9yZWQg
dGhlcmUgaXMgbmVlZGVkKS4NCg0KVG8gYSBtb3JlIHJlYWxpc3RpYyBzY2VuYXJpbywgeW91IG1h
eSBoYXZlIDEwMCBUQiBpbiBTU0QsIGFuZCBhIGZldyBQQiBpbiBzcGlubmluZyBydXN0LCBleHRl
cm5hbGx5IGNvbm5lY3RlZCB0byB0aGUgcHJpbWFyeSB0aWVyLiANCg0KQW4gaW5pdGlhbCBwaGFz
ZSB0byBzaW1wbHkgZmV0Y2ggaW4gYXMgbWFueSBvYmplY3RzIGFuZCBzdWItdHJlZXMgYXMgcG9z
c2libGUgaW4gcGFyYWxsZWwgKGlkZWFsbHkgd2l0aCBJT3MgdG8gdGhlIG9iamVjdHMgaXNzdWVk
IGluIGEgbm9uLXNlcXVlbnRpYWwgb3JkZXIsIHRvIHByb21vdGUgdGhlbSBhbmQgdGhlaXIgbWV0
YWRhdGEgbm90IHRvIGdldCBldmljdGVkIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBmaXJzdCBmZXRj
aCkgd291bGQgaGVhdCB1cCB0aG9zZSBleHRlcm5hbCBjYWNoZXMgKHRvIHNvbWUgZXh0ZW50IHRo
ZSAiY29yZSIgZmlsZXN5c3RlbSBwYWdlIGNhY2hlIHRvbywgYnV0IHRoYXQgaXMgb2YgbWlub3Ig
Y29uY2VybikuIFRodXMgd2hlbiB0aGUgdHJlZSBpcyB0aGVuIHdhbGtlZCBpbiBhIGZ1bGx5IHNl
cXVlbnRpYWwsIHJlY3Vyc2l2ZSB3YXkganVzdCBsaWtlIGN1cnJlbnRseSwgdGhlIGhvdCBtZXRh
ZGF0YSwgYW5kIHNvbWUgaG90IGRhdGEgd291bGQgZHJhbWF0aWNhbGx5IGN1dCB0aGUgYWNjdW11
bGF0aW9uIG9mIGxhdGVuY3kuIA0KDQoNCkEgMm5kIHBoYXNlLCBoYXZpbmcgdGhlIHRyZWUgZmV0
Y2hlZCBpbiBwYXJhbGxlbCwgYW5kIHNlbnQgb3V0IHNlcmlhbCwgd291bGQgd29yayBldmVuIGJl
dHRlci4NCg0KQWxzbywgYXQgbGVhc3QgZm9yIFpJUCAobm90IHNvIG11Y2ggZm9yIFRBUiksIG9i
amVjdHMgcmVzaWRpbmcgaW4gZGlmZmVyZW50IHN1YmRpcmVjdG9yaWVzIGNhbiBiZSBzdG9yZWQg
aW4gYW55IG9yZGVyIC0gYW5kIG9ubHkgbmVlZCB0byBiZSByZWZlcmVuY2VkIHByb3Blcmx5IGlu
IHRoZSBjZW50cmFsIGRpcmVjdG9yeS4gVGh1cyB3aGVuZXZlciBhIHN1YnRocmVhZCBoYXMgY29t
cGxldGVkIHRoZSByZWFkaW5nIG9mIGEgKHN1ZmZpY2llbnRseSBzbWFsbCkgb2JqZWN0IHRvIGJl
IGluIChnaXQgcHJvZ3JhbSkgbWVtb3J5LCBpdCBzaG91bGQgYmUgc2VudCBpbW1lZGlhdGVseSB0
byB0aGUgWklQIHdyaXRlciB0aHJlYWQuIFRoZSByZXN1bHQgd291bGQgYmUgdGhhdCBzbWFsbCBh
bmQgaG90IGZpbGVzICh3aGljaCBjYW4gYmUgcmVhZCBpbiBxdWlja2x5KSBlbmQgdXAgYXQgdGhl
IGJlZ2lubmluZyBvZiB0aGUgemlwIGZpbGUsIGJ1dCB0aGUgcGFyYWxsZWwgdGhyZWFkcyBjYW4g
YWxyZWFkeSwgaW4gcGFyYWxsZWwsIHJlYWQtaW4gbGFyZ2VyIGFuZCBjb2xkZXIgb2JqZWN0IC0g
dGhlIGFic29sdXRlIHdhaXQgdGltZSB3aXRoaW4gdGhlIHdvcmtlciB0aHJlYWQgcmVhZGluZyB0
aG9zZSBvYmplY3RzIG1heSBiZSBzbGlnaHRseSBoaWdoZXIsIGJ1dCBhcyBtYW55IG9iamVjdHMg
YXJlIHJlYWQgaW4gaW4gcGFyYWxsZWwsIHRoZSBhYnNvbHV0ZSB0aW1lIHRvIGNyZWF0ZSB0aGUg
YXJjaGl2ZSB3b3VsZCBiZSBtaW5pbWl6ZWQuDQoNCkluIHNob3J0IC0gdGhlcmUgaXMgbm8gcmVh
bCBuZWVkIHdpdGggWklQIGZvciB0aGUgcmVjdXJzaXZlIHRyYXZlcnNhbCBvZiB0aGUgb2JqZWN0
cyBhbmQgdHJlZXMgdG8gZGVsaXZlciB0aGVtIGluLXNlcXVlbmNlIGF0IGFsbCAoYmVzaWRlLCB0
aGUgc2VxdWVuY2UgbWF5IGJlIGRldGVybWluZWQgYnkgdGhlIHVuZGVybHlpbmcgZmlsZXN5c3Rl
bSwgd2hpY2ggaXMgbm90IG5lY2Vzc2FyaWx5IGd1YXJhbnRlZWQgdG8gcHJvdmlkZSBhIHRyaXZp
YWxseSBzb3J0ZWQgbGlzdCBvZiBhbnkga2luZCAtIG9ubHkgdGhhdCB0aGUgb3JkZXJpbmcgb2Yg
ZmlsZXMgd2l0aGluIGEgZGlyZWN0b3J5IGlzIHN0YWJsZS4NCg0KSG9wZSB0aGlzIGNsYXJpZmll
cyB0aGUgYmFja2dyb3VuZCBvZiB0aGlzIGFzay4NCg0KQmVzdCByZWdhcmRzLA0KICBSaWNoYXJk
DQoNCg==
