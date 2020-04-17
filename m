Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0414C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 13:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA2A2087E
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 13:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="j2bFBtfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgDQNtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:49:13 -0400
Received: from smtppost.atos.net ([193.56.114.176]:1898 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730625AbgDQNtL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 09:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1587131348; x=1618667348;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=d3PQGx/wI4dHTEA0ItF5Eslnop8a2/GrJFE3i2tlT0k=;
  b=j2bFBtfcHIMXOX/WvotJjngFH8VwwmK+MM9eNv45/ocSmxcSsbJHG2Gj
   JIx1Mym8Knb+k8gt6jmmbJ0hhdbDOwqeQNYuWiEhRUF61enj9QcmcIIlg
   cHx8OU6T8MVaR8G3WrKKCluAc1McSbVVWe4Z4NoWpfcmn5BbJ8XdJVVX0
   A=;
IronPort-SDR: 7IFW2qZ9HqGq7hIxl49ryKKKjNgNA2CJl6aD8rq0KMhyttrTTYfib7Oc1FmMw1+DhUb7ZuLLtZ
 OkAiTTn5paNJ9pJ1scegjuCmf9N+4/kuHsy1O7wF1PRGLXGgzdscFRggXVQZ61QX7+ArCyQBSb
 puWYd9E1bnjx4U2UOssFaFdPQ+gGSiEWJuo7YRQnD79z7VdZ5t+Jp5oeP1jCTq2kBl2D37NADc
 zK9Vlx6QxKavD6t0zyafqEjq8Zm+QVLaz1OCfHOfx9suPIv6MvsmAaQqbPLYDT+G4o5lJ8dUIq
 +n73idbHGqE+fyqU1YyGFvI6
X-IronPort-AV: E=Sophos;i="5.72,395,1580770800"; 
   d="scan'208";a="46289613"
X-MGA-submission: =?us-ascii?q?MDFbIWodSet/TCVv/cBX2RcIAyf43FItE3YBNo?=
 =?us-ascii?q?ZvjlehmCrUqgfAdac5Yvas97lXVi1pICnH9+hnYFhoyoAiyWo66yez3O?=
 =?us-ascii?q?Px32zmDha68c22u8zVGC+hAEJkIcQDwXmRBAqXPnE3w0r/Ndt6XWlqKs?=
 =?us-ascii?q?mo?=
Received: from unknown (HELO DEERLM99ETUMSX.ww931.my-it-solutions.net) ([10.86.142.96])
  by smarthost3.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 17 Apr 2020 15:49:02 +0200
Received: from DEFTHW99ETSMSX.ww931.my-it-solutions.net (10.86.142.100) by
 DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Fri, 17 Apr 2020 15:49:01 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.100) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Fri, 17 Apr 2020 15:49:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwIS+LNC5OLbfgefX6xIMS5DrlN/GeDWvsE4D18Xjs37V5RsclP2FYBAWiqjQ6KjjhhShNQa17HLU97Jn94JOWWd6LhRNc1PGp5btaMSo/3CFjzzbB6c314qV0laD907JwHgh4K3GbN7CaqACMOJgy/WBUlmgB9ow4bg61EKkOYJ12viMy6B6UQkh80aJtD5WormG+IBzzrRkd5l68rXMnXWhl1waoHs6OfQZWVFUvbwUJsoYaMEf3byPIB+hKyVzqY798NGf8E8dTiruXUDZHJ5B5gLWTYIEe+bLr4Cu3kZ3Cj2M9OUer+3nZbL1W9RCu8mtYANlDXUPdC4QuSV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3PQGx/wI4dHTEA0ItF5Eslnop8a2/GrJFE3i2tlT0k=;
 b=ahXbC0EP6iRKVsjjAUZpMajvdWC2jyEFwpCGugZBK0/6doJ6owczv7t/iQhkn1YCUsKrlMEJzb2uQHz2jHizaHi9u9IWCfa2odVjqYdz/dYdcBvOcbiUFeC1bfw2yxGJNoGUM7epsg6E5klWhJoHRQof0qE/W2uVnutYlje2rlLn38pyc31ciwXsxCkDbVeAGLiXZrLPVDxPoe5pa/p+pa0a1EWDjgdah2DKKBgyT9eI9ltajzHWHN3J+HKaQAGw90Vv6hqmqRov1yzuPhXzAdJkPgWi7KXC7k5wOQ8FU620BdK9ZlnIp1/rg0NJrWtMcXWIS0x+Y+vyKc157wN85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (2603:10a6:208:42::13)
 by AM0PR02MB5075.eurprd02.prod.outlook.com (2603:10a6:208:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 13:48:58 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8%4]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 13:48:58 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Move some files, with all history, from one project into a new
 one
Thread-Topic: Move some files, with all history, from one project into a new
 one
Thread-Index: AdYS/5siN6K1VEonQ5i65mManIbGnQAOIfYAAAFWIQAAHeaUgABCDBcg
Date:   Fri, 17 Apr 2020 13:48:58 +0000
Message-ID: <AM0PR02MB37156EF466D56AAD182666609CD90@AM0PR02MB3715.eurprd02.prod.outlook.com>
References: <AM0PR02MB3715F9566BD9FEFAF832F0749CDB0@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <20200415151128.GA2464307@coredump.intra.peff.net>
 <20200415154944.GA22823@syl.local>
 <CABPp-BF7o1ba4=qqkqYjMm=YzuH5A=YU+C5zbd41g4pNY4yRKQ@mail.gmail.com>
In-Reply-To: <CABPp-BF7o1ba4=qqkqYjMm=YzuH5A=YU+C5zbd41g4pNY4yRKQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-04-17T13:48:56.6423510Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=ce20d6b9-f33e-4082-9ef6-9924de7f625a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-04-17T13:48:56.6423510Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=ce20d6b9-f33e-4082-9ef6-9924de7f625a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7d4c1c6-2b88-4f96-cee9-08d7e2d61400
x-ms-traffictypediagnostic: AM0PR02MB5075:
x-microsoft-antispam-prvs: <AM0PR02MB50753B2C98B1902E5CEC010D9CD90@AM0PR02MB5075.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3715.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(66446008)(64756008)(52536014)(316002)(478600001)(55016002)(966005)(66476007)(45080400002)(76116006)(9686003)(71200400001)(110136005)(7696005)(2906002)(53546011)(8676002)(6506007)(66946007)(26005)(83080400001)(8936002)(81156014)(86362001)(66556008)(33656002)(186003)(5660300002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHm3rZd81zBekEt7B4p5rQYodzX+6ftpJ7ZZJXxzQrPVpzd2Ki05tnMbU/PeVGkzEze4VAm5fvW16UP5kqbImBBl78VJUCgCMopid6eM/dLw28XvXaxVbKdKfCUQzMr5jl2W9IBt/J8L04FKWXTTCiq1JFmLp1ch189HcxZ0lFunZuxcbJHTKU8V9CLvfdpXSSBPiCKeIt4KJiZzU/lQs6ouPDwJUIGdWMmCCR/UPy+1ti6PKjztuVAQW3NGZtZDqFolMtlpVAIz+y1F5KBW1ydmLnGwASZo5SpxGQ9qEv4ezKA1MVX2EEOhcKmaD1MBI1lTBeSzKULWgPn5nYsjf0Daht9MjQ90zsKPLanMhtXsuy1/lzaC81QOIph34E8OvOBc2nXDenQR73Tdise4mNy7YBboBu11uaSmYwQzfX67THSj9XpQyIbmLICd5tZg4G1KCOOLOh5p6XQgCZu9xSbKopigVS5XJScFgnFcMXVXh9hwyH7gIcyKgw9U4I9D
x-ms-exchange-antispam-messagedata: bs9wIWC4KguIs6RNQM8nZsFvi1wpwyBcCkXMrIsGVKczqwJ3HOrQNToYx3CXhLkmXnyTD4takOvALDdPt2lPm8/MWM/vyvLRjYPTGRs6wORMYnWKiDnWVYBCK58Ragc+r8lKoxaBmMI8BBgxD4vn+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d4c1c6-2b88-4f96-cee9-08d7e2d61400
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 13:48:58.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBaRM56U8/G5hbM0aSxIa/x/zuYRMIGZam+PVkH936BnDkteawpwC2FtWjm6wPCFoJzcBYBvP6n9ssANjPkvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5075
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpUaGFua3MgQWxsLg0KSSd2ZSBjbG9uZWQgZ2l0LWZpbHRlci1yZXBvIGFuZCBJIHNoYWxsIHNo
b3J0bHkgZ2l2ZSBpdCBhIHRyeS4NCg0KRmlyc3Qgc3RlcCBpcyB0byBnZXQgUHl0aG9uIDMgaW5z
dGFsbGVkIChJJ20gb24gV2luZG93cykuDQoNClJlZ2FyZHMsDQpSaWNoYXJkLg0KDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEVsaWphaCBOZXdyZW4gPG5ld3JlbkBnbWFp
bC5jb20+IA0KU2VudDogMTYgQXByaWwgMjAyMCAwNzowNg0KVG86IFRheWxvciBCbGF1IDxtZUB0
dGF5bG9yci5jb20+DQpDYzogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PjsgS2VycnksIFJpY2hh
cmQgPHJpY2hhcmQua2VycnlAYXRvcy5uZXQ+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogTW92ZSBzb21lIGZpbGVzLCB3aXRoIGFsbCBoaXN0b3J5LCBmcm9tIG9uZSBwcm9qZWN0
IGludG8gYSBuZXcgb25lDQoNCkNhdXRpb24hIEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBh
dHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBh
IGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KT24gV2Vk
LCBBcHIgMTUsIDIwMjAgYXQgODo0OSBBTSBUYXlsb3IgQmxhdSA8bWVAdHRheWxvcnIuY29tPiB3
cm90ZToNCj4NCj4gT24gV2VkLCBBcHIgMTUsIDIwMjAgYXQgMTE6MTE6MjhBTSAtMDQwMCwgSmVm
ZiBLaW5nIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXByIDE1LCAyMDIwIGF0IDA4OjMxOjM1QU0gKzAw
MDAsIEtlcnJ5LCBSaWNoYXJkIHdyb3RlOg0KPiA+DQo+ID4gPiBJIHdvdWxkIGxpa2UgdG8gbW92
ZSBzb21lIGZpbGVzLCBmcm9tIHRoZSBwcm9qZWN0IGluIHdoaWNoIHRoZXkgDQo+ID4gPiBoYXZl
IGFsd2F5cyByZXNpZGVkIGludG8gIGEgbmV3IHByb2plY3QuICBJIHdvdWxkIGxpa2UgdG8ga2Vl
cCBhbGwgDQo+ID4gPiB0aGVpciBoaXN0b3J5LiAgSSBkb24ndCB3YW50IHRvIHdhc3RlIHNwYWNl
IGJ5IGFsc28gbW92aW5nIHRoZSANCj4gPiA+IHJlc3Qgb2YgdGhlIG9sZCBwcm9qZWN0J3MgaGlz
dG9yeSwgb3IgaGlzdG9yaWNhbCBmaWxlIGNvbnRlbnRzLg0KPiA+DQo+ID4gVHJ5IGdpdC1maWx0
ZXItYnJhbmNoJ3MgLS1zdWJkaXJlY3RvcnkgcmVwb3NpdG9yeSwgd2hpY2ggaXMgZGVzaWduZWQg
DQo+ID4gdG8gZG8gZXhhY3RseSB0aGlzLg0KPiA+DQo+ID4gT3IgdGhlIG11Y2ggbmV3ZXIgKGFu
ZCBmYXN0ZXIpIGdpdC1maWx0ZXItcmVwbzoNCj4gPg0KPiA+ICAgDQo+ID4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2kN
Cj4gPiB0aHViLmNvbSUyRm5ld3JlbiUyRmdpdC1maWx0ZXItcmVwbyZhbXA7ZGF0YT0wMiU3QzAx
JTdDcmljaGFyZC5rZXJyeQ0KPiA+ICU0MGF0b3MubmV0JTdDZjI4Yjk0NDYyNGUwNDA4NDM5NWYw
OGQ3ZTFjYzdiMzUlN0MzMzQ0MGZjNmI3Yzc0MTJjYmI3DQo+ID4gMzBlNzBiMDE5OGQ1YSU3QzAl
N0MwJTdDNjM3MjI2MTQwNjY0OTYyMjY3JmFtcDtzZGF0YT1wYjJFbkVBRHVDOUJkaTUNCj4gPiBK
VTJTbzNESzZWeUVjc0VINVg1a3liRkF3OSUyRk0lM0QmYW1wO3Jlc2VydmVkPTANCj4NCj4gRm9y
IHdoYXQgaXQncyB3b3J0aCwgRWxpamFoIGhhcyBwcm92aWRlZCBzb21lIGV4Y2VsbGVudCBkb2N1
bWVudGF0aW9uIA0KPiBvbiBob3cgdG8gdXNlIGdpdC1maWx0ZXItcmVwbyB0byBkbyBleGFjdGx5
IHRoaXMgaGVyZToNCj4NCj4gICANCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aA0KPiB1Yi5jb20lMkZuZXdyZW4l
MkZnaXQtZmlsdGVyLXJlcG8lMjNzb2x2aW5nLXRoaXMtd2l0aC1maWx0ZXItcmVwbyZhbXA7DQo+
IGRhdGE9MDIlN0MwMSU3Q3JpY2hhcmQua2VycnklNDBhdG9zLm5ldCU3Q2YyOGI5NDQ2MjRlMDQw
ODQzOTVmMDhkN2UxY2MNCj4gN2IzNSU3QzMzNDQwZmM2YjdjNzQxMmNiYjczMGU3MGIwMTk4ZDVh
JTdDMCU3QzAlN0M2MzcyMjYxNDA2NjQ5NjIyNjcmYQ0KPiBtcDtzZGF0YT1oMDNGb2dYWDBpdXFI
QjlkNDlDbHRPbXpOa3dHSzY2Y2hDNVp2aE95V2ZzJTNEJmFtcDtyZXNlcnZlZD0wDQoNClRoYXQg
cGFydGljdWxhciBleGFtcGxlIG1pZ2h0IGJlIGZvciBhIGRpZmZlcmVudCBjYXNlIHRoYW4gd2hh
dCBSaWNoYXJkIHJlcXVlc3RlZCwgdGhvdWdoLiAgTGV0J3Mgc2F5IHRoZSBvcmlnaW5hbCByZXBv
IGhhZCBhIGZpbGUgc3RydWN0dXJlIGxpa2UgdGhlIGZvbGxvd2luZzoNCg0KICAgbW9kdWxlLw0K
ICAgICAgZm9vLmMNCiAgICAgIGJhci5jDQogICBvdGhlckRpci8NCiAgICAgIGJsYWguY29uZmln
DQogICAgICBzdHVmZi50eHQNCiAgIHplYnJhLmpwZw0KDQpJZiB0aGUgcmVxdWVzdCBpcyB0byBl
LmcuIHRha2UgbW9kdWxlLyBhbmQgYWxsIGZpbGVzIHdpdGhpbiBpdCB3aXRoIHRoZWlyIGhpc3Rv
cnkgYW5kIG1ha2UgYSBuZXcgcmVwb3NpdG9yeSBvdXQgb2YgaXQsIHdpdGggbW9kdWxlLyBiZWlu
ZyByZW1hcHBlZCB0byB0aGUgcm9vdCBvZiB0aGUgcmVwb3NpdG9yeSwgdGhlbiB5b3Ugd291bGQg
d2FudDoNCiAgIGdpdCBmaWx0cmVyLXJlcG8gLS1zdWJkaXJlY3RvcnktZmlsdGVyIG1vZHVsZSBh
bmQgeWVzLCB0aGlzIGxvb2tzIGV4YWN0bHkgbGlrZSBmaWx0ZXItYnJhbmNoOyB0aGF0J3MgdGhl
IG9uZSBmbGFnIEkgY29waWVkIGZyb20gaXQuICBTbyB0aGlzIG9uZSB1c2VjYXNlIG1hcHMgZGly
ZWN0bHkgYmV0d2VlbiB0aGUgdHdvIHRvb2xzLg0KDQpJbiBjb250cmFzdCwgaWYgeW91IHdhbnRl
ZCB0byBrZWVwIGFsbCBmaWxlcyBmcm9tIHRoZSBvcmlnaW5hbCByZXBvIGJ1dCBtb3ZlIGV2ZXJ5
dGhpbmcgaW50byBhIHN1YmRpcmVjdG9yeSBuYW1lZCAibXlQcm9qZWN0IiAoc28gdGhhdCBlLmcu
IG1vZHVsZS9mb28uYyBiZWNhbWUgbXlQcm9qZWN0L21vZHVsZS9mb28uYyksIHBvc3NpYmx5IGlu
IHByZXBhcmF0aW9uIGZvciBtZXJnaW5nIHlvdXIgcmVwbyBpbnRvIHNvbWUgbGFyZ2VyIG1vbm9y
ZXBvLCB0aGVuIHlvdSdkIHdhbnQgdG8gcGFzcyBgLS10by1zdWJkaXJlY3RvcnktZmlsdGVyIG15
UHJvamVjdGAgYXMgaW4gdGhlIGxpbmsgeW91IHBvaW50ZWQgb3V0LiAgZmlsdGVyLWJyYW5jaCBk
b2Vzbid0IGhhdmUgYW4gZXF1aXZhbGVudC4NCg0KDQpIb3BlIHRoYXQgaGVscHMsDQpFbGlqYWgN
Cg==
