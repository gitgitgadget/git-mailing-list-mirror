Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F33AC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJKNDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKND3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:03:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26067C750
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxkIb/ooy9T+ExNbMV+5OgnnKy/o2E5746PIC/RNSH/L2gpVNJjl5KvDi2sty+dabZegx8hrbXBh1cSRpT4ZTpjhuAdZ0fa8FANLdjgmOG/X56uJJgsihBWvRo9h4oht0vicZQ4mIZiyZaFA9TUlAFMnzPQw/6CEzKpCsAJQcrZZ6sIW7lvy+1XtVGj2ZVr011eFlt6xTv7uyJrLM3RwqvoL9QeT3s9iYlbl4OxRNSLaIvF9BcaI0dzoR1U61s29pxrcK+WhHF8rWHjVOufc8om8tMj27fuo202ARYNkeCcF/gEyMbIHff9rt7yvXmfkvu+lvdxJBqCO1+sYg9dJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WRiRHTClY12MWUU6A7UkIovtTICRSwthDYD9M0ufJM=;
 b=a14XSxQbPN1ZlmcHLyV96zl7Avf/+3UegwzYQiAzN1EPb9+5c2eXb+3vn+0+zMzWW2vBvO34RAlEH+wK46sN3CPYOOFDskb5IsGzv3wiE7jqnlS/Ojv5N2YJs6PbDc+Ndol1Qxs34aCOW9k8FmM8AJO7QDiZLpgELvY9z0dXv3F85CbPeMPz8BqE54ljU/SwASfkboM+BmM9aqnLPNKQZ3nOma0wjNhiFPi1Wy2T7hzWUIvsIHj0Fb1X+XEvJqp6XiEXamNdDHjpfCR+5PL/e6alU5Cu3wVJLV0W4tODooDVXFkQ3ZhAfGwC8rpyyIOqq+9/64GyB/0DNVZSw5uTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sidn.nl; dmarc=pass action=none header.from=sidn.nl; dkim=pass
 header.d=sidn.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sidn.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WRiRHTClY12MWUU6A7UkIovtTICRSwthDYD9M0ufJM=;
 b=LmvURRR4iUr0/d76jj1rM4sizZBH1hfQLr3t02XyXZGW379hYnlOHP35WFbDcp1LywhqGcgxU17F6IV1rca69uNGifQsmj41UDp8lpAaQmOijgDO5vhUfojo2EJA0V+ZVFReKFpIsQJFPwV9QAr59NtS4mbXzRvsLzDyu1sbHPY=
Received: from DU2P194MB1584.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:271::9) by
 PR3P194MB0569.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:3f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.19; Tue, 11 Oct 2022 13:03:20 +0000
Received: from DU2P194MB1584.EURP194.PROD.OUTLOOK.COM
 ([fe80::85a6:7ae8:c5da:2032]) by DU2P194MB1584.EURP194.PROD.OUTLOOK.COM
 ([fe80::85a6:7ae8:c5da:2032%8]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 13:03:20 +0000
From:   Bart Kuster <bart.kuster@sidn.nl>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Seemingly inconsistent checkout behaviour
Thread-Topic: Seemingly inconsistent checkout behaviour
Thread-Index: AdjdY0G6Z+ux8H0rQpG1Bvxj06huLwAB8YaAAAFeGRA=
Date:   Tue, 11 Oct 2022 13:03:20 +0000
Message-ID: <DU2P194MB15841850A17436C7AE34C149E3239@DU2P194MB1584.EURP194.PROD.OUTLOOK.COM>
References: <DU2P194MB1584B11245DF0DE7515297B6E3239@DU2P194MB1584.EURP194.PROD.OUTLOOK.COM>
 <221011.86tu4ao8im.gmgdl@evledraar.gmail.com>
In-Reply-To: <221011.86tu4ao8im.gmgdl@evledraar.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: ce6b514c-793f-4e8d-a757-cc40c96e322c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sidn.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2P194MB1584:EE_|PR3P194MB0569:EE_
x-ms-office365-filtering-correlation-id: 3289f66f-e143-40b5-ac75-08daab88f8f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sK7MzaqYOxY+6Xpb9vLwsfBRUbZLbH7/P0xFsHSdp+h+pUlFiheCl8sDGKGeFCglBeihnLseUh3uW/9wf/cQThMDYkJOFhj8hI+/F1ajqYjx4/sp6pYUQNgfEfgEy2oa68/dbUhUw3Q8YImpDNY0Pa5ZekgNmxOsfIVYuP8bIZhuegFWVx31i+5ACpd3fnZPR9NerguOjYsDREXK4P0JiGp97zaUQ/aO+GPahSVrIfnqc0qtnihLglIH1geQffYDipUSeUa2HboSlncfJU38P8lIWPuuV0+7tnAkx/DJoDGRfmLFGBFNBT998XlOR2EkrB3JpksaBrSgyawxdEOcOu8g7Hp063dpyDHkTZ9XN/3V272iE/VaFNkBMOibOP2+kQoSp6Z+HngJhGwCETyzQS1YJRx8buwqg98oFgNTK5brET9cTmu91peQPGf9DADiDUhE1fWcaPtyEAE/B6bcYvFDK4e01niPD+V49qV+saMC1N4oRmaAdsuxBzQHX0azaGyIhK6PCsUW51sRn0x5j7MbPeVlIsBXHyC+9/BvNXHTnjdb8LjWDOmvdS1/TKWsbhSPFicti0+f1cu/xExh0GLvfUqulJwP+TiB4H9HEh6dnyCI65ECdrEfIcZjEalHG/MJQLf42NCNJpccuV7bdYSbbkc+W70vwlSpf7h70wUgmZVdOvjmHx7TaSy3MBmYUFbKNOW6UAB4MS/cB2xOcI2kF9G8IdgK84jn8fuLGdWqE3C/KI8QRyl9NPEeAbg2LY/f0a2T4zp+G3khrR7qkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2P194MB1584.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39850400004)(136003)(346002)(396003)(451199015)(3480700007)(186003)(38070700005)(83380400001)(122000001)(44832011)(38100700002)(5660300002)(41300700001)(2906002)(8936002)(52536014)(55016003)(316002)(9686003)(26005)(8676002)(6506007)(7696005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(478600001)(71200400001)(6916009)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2U5d2dNdlgzLzFua2xNdE15MGN6RGxTUTYxbkVoaWpwRlorT3Q5MVFnVUkz?=
 =?utf-8?B?TmhMejZGQ0lia3EzMzhnR2JHTHEyNXFjRVFzK2dybnhaOUtBcFlaWjF1RzVT?=
 =?utf-8?B?VEliNTEybHNmYzVXRlVBZ0lWM3h0S0VSbCtnZ0Y1eHFKZEFxemF3OCt5QTVN?=
 =?utf-8?B?UU9LSEFLN2UrdVpHZjR3RGQ3a3I3Qkh6dkJEUU5vcHhBenU2MnpEYXhuaVZp?=
 =?utf-8?B?ZU5wdXVjNTJBdFNlRVRLR20wLzdvSWN1aWdVdCsyNnlkb2x3czFHcS9tQTNO?=
 =?utf-8?B?M2l1TkZXTzJsWU1QZDU2bVlLU2Zrd09DQnhxd1NBcDk2WTk0R1dnY3JuYzA0?=
 =?utf-8?B?UGJTWEROMVVoNHBwVzVyeHhNNlFIYWJCUEh5Nk1JTElBU3dpQk15WUR1N2Zh?=
 =?utf-8?B?TXNVWnZxbThudHJLSUczNWRvTFNwbGNyWXprSVNmVG5OL0drSDNVeWI3ZGU4?=
 =?utf-8?B?MDNiTjJiWFFJUEdYcWZ0MlJIRlRKUFozWVF5TnQzQjVWcVZyU3Z4bXhQOUpM?=
 =?utf-8?B?VndyTTBTSWRZcXREN0xpcE5TaEdaQmJOTHg5OExzaDB5ZHcxVHgyU2c1SGlh?=
 =?utf-8?B?MFlVL3Zpb0dhVlJBZjMzQ2hIeHhubEtIbE14MzVMOTYxRDJtUmI2U0FMUjUx?=
 =?utf-8?B?OC82NVR2RlNxZXdOM1pYTE4yS2J2aGxPaGtMSHA4SUtCRHV6bEhJc0lHcDUr?=
 =?utf-8?B?RkY0S2h6eDQvOGFGTDkzY3ZoNXRaQmdiYVg4OTQ0ZGRwZW1yejlPNGo4UzRp?=
 =?utf-8?B?cnhVelFwQ2xqZkMzQ2Z1SXkwVVZlM2hYSTV3V3hVQ2oza0xVV1A4dmdaZm0z?=
 =?utf-8?B?ZHZwMFUzM1doV2hkYmUrRFg1NzJxUk5JRUNtenJwUWUvUjRXOEp5QS91eXZw?=
 =?utf-8?B?L3l6aUQyQXRKVllUd2xFdHVhRkUxTjMvUzdjNW91VG1odkFlcDZkckZNWFVQ?=
 =?utf-8?B?QkcramxISjRUejZ2aGJ4Mno1MHJmeHF2WDI5dGlleHF0dFh2UTlpWDUyRWgz?=
 =?utf-8?B?NjUyTThqbUJWc0M1WVdKdnFoNVhKZkRzeU40eVNUMVNaMWJNYkxrQkNhS0NM?=
 =?utf-8?B?UkE4U1Q3eng0SkExRDVDeXFEQm1VKytSbWk0Tm5ZNjM4UlNQcC9rVUJWRVJC?=
 =?utf-8?B?Y0FhL010aUgwdEcrYXYyVEhYMWxuaW5JZkhyZEZ2QklIdWtDR3QwdWp2Nmh6?=
 =?utf-8?B?eWUwT0FWQmRvZlNPU0VyNlcxNE9RemYxOUJPUUpiZUNhTEFDQU1PS1c5ZEdX?=
 =?utf-8?B?M2dVQzdGUFc5M2hib2ZSb2lZb2d1dGF5R3pQNFIweDRTK1hFQVR5UVhzVnBN?=
 =?utf-8?B?VkdEd1p1WW50bHpWdXA5WkVDYWc1RHhIZDhvY1lxV2dmeDhMRUN3ekN5WDBE?=
 =?utf-8?B?T3lJQmM3Y2xSNTRUY2U2ZTlpdVQ0MnFtc3owaE1FaURVb0JQeGR3cGJJYnhI?=
 =?utf-8?B?Rnd5aXFmTEdkaTh6aG82Y20wMVR0MHgxTHhvNVJyMUE3L2ZLNDlhNVdmOTBZ?=
 =?utf-8?B?dndqQ1Iza3FqS0NETnA5d0podHN3UVMvVFg3V2ZTSmZ4SXZlMitvODUrbjZq?=
 =?utf-8?B?aHlORXlvUGVRWjA1ZWFVYkQrY0FoSmhrTUVjWUdoMjdmTlB6bktWcEdkNEUv?=
 =?utf-8?B?RUFDbk1SWnZIL2s2VTNFSGdhR0Fua25xaWMwcm5JU1hpMUl3VXVIYVZ6Wis2?=
 =?utf-8?B?L0UyVmdtOHFyazhtT0JjbUZ3OGdoQlRPSWhYNHpvTjFVMDBTTVNMdkREZWdx?=
 =?utf-8?B?NjJzOFh0UUtqSkx0cWJGME4rSlU0WHJiQWVXNFR0bHZKeUxFMnIzcnVPMEZI?=
 =?utf-8?B?Y0FTN3VoTDQxRXRsS1N6S1ZmVHloazRSeWFGQVJ4QlBQSkFETUF3ek9BeEVC?=
 =?utf-8?B?T3h3R1NsMzZNTDIrQXF0RGkrWTlWNlJxOStteVNoQjFlTDhGeExMNzhtVDhq?=
 =?utf-8?B?M2J5SzVPeTZmVStJUGxXRE9FZzRNTVE1ZEt0TW45R0VGMWphZUszcXVCMDBE?=
 =?utf-8?B?N1ZpSkVoaGlDNm9nTnpjcVJ0dU1QNGtHeXd2a3JpSzc4VlJMeUc4Wm9sSjFi?=
 =?utf-8?B?T0RFUFlDa3VyUEhBV0FoZTVWTEhHeXc2TnppK1UzZ3ZMSlNKZlZ5M3pBRGpV?=
 =?utf-8?Q?VKasZlb+yS/KTMOAjnYf41pMN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sidn.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2P194MB1584.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3289f66f-e143-40b5-ac75-08daab88f8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 13:03:20.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ab4d3626-c1c5-4a75-ab85-427f1a644a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JI2ZgAF/d3co5VOxHKmoNX9YXwsIxO4XChfZD2WOaZHvczf6MIJpxoB9sZOJYpyCMrLsbDTz6dX75ag73i4kSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0569
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpPbiBUdWUsIE9jdCAxMSAyMDIyLCDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiB3cm90ZToN
Cg0KPk9uIFR1ZSwgT2N0IDExIDIwMjIsIEJhcnQgS3VzdGVyIHdyb3RlOg0KPg0KPj4gRGVhciBQ
ZW9wbGUgb2YgR2l0LA0KPj4NCj4+IEkgaGFkIHNvbWUgdHJvdWJsZSBnZXR0aW5nIG91dCBvZiBh
IGRldGFjaGVkIEhFQUQgc3RhdGUgdXNpbmcgZ2l0IGNoZWNrb3V0LiBJ4oCZdmUgc29sdmVkIGl0
IG5vdyBidXQgdGhlIGJlaGF2aW91ciBvZiBjaGVja291dCB3aGVuIGRvaW5nIHNvIGxlYXZlcyBt
ZSBhIGJpdCBwdXp6bGVkLg0KPj4NCj4+IEnigJlkIGV4cGVjdCB0aGUgYmVoYXZpb3VyIG9mIHRo
ZSBjb21tYW5kcyBiZWxvdyB0byBiZSBlcXVpdmFsZW50Og0KPj4NCj4+ICAgIGdpdCBjaGVja291
dCBvcmlnaW4vbWFpbg0KPj4NCj4+IHZzDQo+Pg0KPj4gICAgZ2l0IGNvbmZpZyBjaGVja291dC5k
ZWZhdWx0UmVtb3RlIG9yaWdpbg0KPj4gICAgZ2l0IGNoZWNrb3V0IG1haW4NCj4+DQo+PiBCdXQg
dGhleSBhcmUgbm90OyB0aGUgZm9ybWVyIGxlYXZlcyB0aGUgSEVBRCBkZXRhY2hlZCB3aGlsZSB0
aGUgbGF0dGVyIA0KPj4gc2V0cyBpdCB0byBtYWluLiBJIGZhaWxlZCB0byBmaW5kIGFuIGV4cGxh
bmF0aW9uIGluIHRoZSBnaXQtY2hlY2tvdXQgDQo+PiBkb2N1bWVudGF0aW9uLCB3aGljaCBzZWVt
cyB0byBpbmRpY2F0ZSB0aGF0IGNoZWNrb3V0IGFsd2F5cyB1cGRhdGVzIA0KPj4gSEVBRC4NCj4N
Cj5UaGV5J3JlIG5vdCBlcXVpdmFsZW50LCB0aGUgZG9jdW1lbnRhdGlvbiB0aGF0IGRlc2NyaWJl
cyBpdCBpcyB0aGUgZGlzY3Vzc2lvbiBvZiB0aGUgLS1ndWVzcyBvcHRpb24uDQo+DQo+SS5lLiB0
aGVzZSBhcmUgZXF1aXZhbGVudDoNCj4NCj4JZ2l0IGNoZWNrb3V0IG1haW4NCj4JZ2l0IGNoZWNr
b3V0IC0tZ3Vlc3MgbWFpbg0KPg0KPkFuZCB0aGUgbGF0dGVyIG9mIHRob3NlIHJlc29sdmVzIHRv
IChpbiB0aGlzIGNhc2UpOg0KPg0KPglnaXQgY2hlY2tvdXQgLWIgbWFpbiAtdCBvcmlnaW4vbWFp
bg0KPg0KPlRoZSAiaW4gdGhpcyBjYXNlIiBiZWluZyB0aGF0IGl0J3MgYWN0dWFsbHkgKHBzZXVk
b2NvZGUpOg0KPg0KPglnaXQgY2hlY2tvdXQgLWIgbWFpbiAtdCAkKGZpbmQtdGhlLW9ubHktcmVt
b3RlLXRoYXQtaGFzLWEtYnJhbmNoLW5hbWVkIG1haW4pL21haW4NCj4NCj5BbmQgdGhlICJjaGVj
a291dC5kZWZhdWx0UmVtb3RlPW9yaWdpbiIgaXMgYSBzZXR0aW5nIHRoYXQgZGlzYW1iaWd1YXRl
cyB0aGF0ICJmaW5kIHRoZSBvbmx5IiBkb3duIHRvICJvcmlnaW4iLCBpZiB5b3UgaGFwcGVuIHRv
IGhhdmUgbXVsdGlwbGUgc3VjaCByZW1vdGVzLg0KPg0KPkJ1dCBJJ20gc3RpbGwgdW5jbGVhciBv
biB0aGUgIkkgaGFkIHNvbWUgdHJvdWJsZSBnZXR0aW5nIG91dCBvZiBhIGRldGFjaGVkIEhFQUQg
c3RhdGUgdXNpbmcgZ2l0IGNoZWNrb3V0IiBwYXJ0IG9mIHlvdXIgcXVlc3Rpb24sIGlzbid0IHRo
ZToNCj4NCj4JZ2l0IGNvbmZpZyBjaGVja291dC5kZWZhdWx0UmVtb3RlIG9yaWdpbg0KPglnaXQg
Y2hlY2tvdXQgbWFpbg0KPg0KPkV4YWN0bHkgd2hhdCB5b3Ugd2FudCB0aGVuPw0KPg0KPklmIHlv
dSdyZSB0cnlpbmcgdG8gZ2V0IGEgIm5vbi1kZXRhY2hlZCByZW1vdGUgdHJhY2tpbmcgYnJhbmNo
IiwgaS5lLiB0byBoYXZlIHRoaXMgc29tZWhvdyBjaGVja291dCBhIGJyYW5jaDoNCj4NCj4JZ2l0
IGNoZWNrb3V0IG9yaWdpbi9tYWluDQo+DQo+VGhlbiB0aGVyZSdzIG5vIHN1Y2ggdGhpbmcuIFdl
IHRyZWF0IHRoZW0gc3BlY2lhbGx5LCBhbmQgZG9uJ3QgYWxsb3cgeW91IHRvIGNoZWNrIHRoZW0g
b3V0IGFzIGEgbm9ybWFsIGJyYW5jaCwgc28gd2hlbiB5b3UgZG8gc28geW91IGVuZCB1cCB3aXRo
IGEgZGV0YWNoZWQgSEVBRCBwb2ludGluZyB0byB3aGVyZXZlciB0aGF0IGJyYW5jaCBwb2ludHMg
dG8uIElPVzoNCj4NCj4JZ2l0IGNoZWNrb3V0IG9yaWdpbi9tYWluDQo+DQo+SXMgYWx3YXlzIHRo
ZSBzYW1lIGFzOg0KPg0KPglnaXQgY2hlY2tvdXQgb3JpZ2luL21haW5ee30NCj4NCj5HaXZlbiB0
aGF0IHlvdSBoYXZlIGFuICJvcmlnaW4iIHJlbW90ZSwgYSAibWFpbiIgYnJhbmNoLCBpdCdzIG5v
dCBhbWJpZ3VvdXMsIG9yIHRoZSByaWdodCBjb25maWcgYmxhaCBibGFoLg0KPg0KPlRoYXQncyBh
bHNvIGRvY3VtZW50ZWQgc29tZXdoZXJlLCBidXQgSSBkaWRuJ3QgZGlnIHVwIHdoZXJlIHRoYXQg
aXMuLi4NCj4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5ISBJIHVuZGVyc3RhbmQgdGhl
IHNpdHVhdGlvbiBub3cuDQoNCldoYXQgcHV0IG1lIG9uIHRoZSB3cm9uZyB0cmFjaywgaXMgdGhh
dCBnaXQgY2hlY2tvdXQgPHJlbW90ZT4vPGJyYW5jaD4gaXMgbm90IGV4cGxpY2l0bHkgZGlzY3Vz
c2VkIGluIHRoZSBnaXQtY2hlY2tvdXQgZG9jdW1lbnRhdGlvbiwgbGVhZGluZyBtZSB0byBiZWxp
ZXZlIHRoZSBkZWZhdWx0IHVzZSBjYXNlIHdvdWxkIGFwcGx5IHRvIGl0IHdoaWxlIGl0IGRvZXMg
bm90LiBUaGUgbGFzdCBwYXJ0IG9mIHlvdXIgZXhwbGFuYXRpb24gY2xhcmlmaWVzIHdoYXQncyBy
ZWFsbHkgZ29pbmcgb24uIFRoYW5rcyENCg==
