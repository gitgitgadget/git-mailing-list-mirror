Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED9C6FA8E
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 13:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIUNDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 09:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIUND1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 09:03:27 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64278E99E
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663765403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PudwC1lSTE2osroOcLlpAN0jBZt6l7FmNCGgY3nW9s=;
        b=Ek+bdM0PnyUcgTJ+/5ZQh/Gk4g8M66/rq8SMACS21XS/WNtS6VlUeCCcXUWR3bHwNhgECh
        uhKh8fVf6itl2Ix1ih85zecnzxsvPtUSd7nWfZkQIYPZxuG3G2xE3bnac13bcTv3khH1P2
        MPJrShJSlXEJ7xpQ8Rygl3FVlYYPc0I=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-sws9MLUoNEyXOvDkqCoEnw-1; Wed, 21 Sep 2022 09:03:22 -0400
X-MC-Unique: sws9MLUoNEyXOvDkqCoEnw-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MWHPR05MB2896.namprd05.prod.outlook.com (2603:10b6:300:65::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.7; Wed, 21 Sep
 2022 13:03:18 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5654.012; Wed, 21 Sep 2022
 13:03:18 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v10 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Thread-Topic: [PATCH v10 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Thread-Index: AQHYzTA4XmGAZBoEBUO9fDD0kQfgja3pvm4AgAAa/JA=
Date:   Wed, 21 Sep 2022 13:03:18 +0000
Message-ID: <BL0PR05MB557160F62C59B02E116BC219D94F9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
 <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
 <8f6c1fbacbfd3df67d1a7591788d98f1af0e26f4.1663705986.git.gitgitgadget@gmail.com>
 <28d36af9-f493-f4a5-4aaf-18758e1c46db@jeffhostetler.com>
In-Reply-To: <28d36af9-f493-f4a5-4aaf-18758e1c46db@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MWHPR05MB2896:EE_
x-ms-office365-filtering-correlation-id: c6dad635-d972-41bc-ead3-08da9bd1a764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: s7LJZFfC1WB5xuR2wl1vNs+bAXoA7aONW8mVUdXZXuZLDS2TjQVanWVVIV2ZPYHcSVB5WZpGu/PWqYeBga4AOCT7GqxteyhptrekGdmeRiw8O4bZqisWxtqTKAVOz5BdxDMVV0AmC2UAPMqWzaaOVQ2f9A8bRNNcSzpUToFrycYzrnfZ3nRGhuQd+apCnCxl3UplQcDMvdR6v2yxr7P8PIIp0NgTTeOglELrFBhqYYcyXebg4JaECPO6JElJ46i6cYEJfFurbARkdyl5olHDAcoHUCaNH3Vm/737itczUBRKfhzMnLpbO4Tiwt9DZer7rJJEiuYyQLwHgSzpGz3JeVsRhqbOAe+taoeOgREI1zty2UX1VcIWeO0IQ1zycKJoBLLR2wZnj2VDT83ZSbVOBftQICxa5cFmNMJmVIXnJO5s2nHeuOth/sKotOy0/WTEpzmUd8gK4yUnLNe0GrBO/7SbpbRayn8KbpXlvDvvdXi3fpIwOixPofNNZ3U2utILaOAcTyzwEG1Pn0anB4kV7ZL+psdmdqUxOb6LYrMj/WqkDE2254t/u8/AInkAt8719Y2cbuYBmSm8iiU9iDBpKn89hWJN+kHR6vjGpUL9J37Z+8ibi/luolFku6Jh/obCanj+vA4Muwr8e/jVKg7QIL8KfrDhztyPQAtlqWNyCcutigCYhSbtHSIEFpTlcYP5zbxsyZlk5fTMsD2wlWOsp/ZcusbZo/Xs0CHjBLkidZfFKDrJSGKM+06/10Y3HvutJIO4PN/WWwv+haYLvFdfsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(186003)(6506007)(83380400001)(53546011)(66574015)(9686003)(7696005)(26005)(64756008)(52536014)(66946007)(66476007)(66446008)(55016003)(66556008)(5660300002)(4326008)(76116006)(8676002)(478600001)(41300700001)(71200400001)(86362001)(122000001)(316002)(110136005)(54906003)(38070700005)(8936002)(2906002)(33656002)(38100700002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmZ6bWlWNXVwYnBuc3BwOVJNR0VkUno2eEgzd2VYVUpUWlBtaThtMVFRbkp2?=
 =?utf-8?B?Z2NJT0ZhaHl3M2ppUTBHYldJTkdYYlFKNGdxZ0JNV1hPY2I3QnJIUFM5cDlk?=
 =?utf-8?B?TXI4TW1JQ3dGMTd0TGRLZjFkZG9UV1NRdVdxcmo0ZEM1bWRQVDF0VFFjS1Vi?=
 =?utf-8?B?YU5aeDBpUjBRZlFtaUc0ek5PcWJ0emFLc2R2L3FORm9OZUZOSTFTaTNka21s?=
 =?utf-8?B?Ym1OTk10UTFFSXJlVTd4NzN1VnM2dHlZOHpKNUkyeGlvSE9Rem1makdBbkhX?=
 =?utf-8?B?cWdKbXVEbW1IRERGY2NRMjVGZ2tra2o3WFVrRjlDQWJxQTl2WU9XSFhJbm44?=
 =?utf-8?B?OCt2VTlXK0xWbjk1UitIVS9iazI2UFRJRk5sOW9rUHZiTHVIekNXTDlwNklY?=
 =?utf-8?B?Wmw2YVNWLzZwbkltM3BxbGdhY2lEZEgxd1FYc2p0Mkl5NmdKWlFmZlVnTW5N?=
 =?utf-8?B?b1FDblo0TzZqVTRnV0x6bzllQ21qTUg5VzRGSStlaXZMNmNjZkQrVW0yZ3dW?=
 =?utf-8?B?aHlKTWV3ajQ1V2J1TzNJdGp2SjRFb1ZEN0dyd08xbEk3WnlmL2NUcFl0bHJK?=
 =?utf-8?B?V05BV1doMk5jR1ZCNzZYMDdwcUl0RWV5LzB0QUJnL3BxYlZmSHN0WlhyWW03?=
 =?utf-8?B?V2Q2bzJLYkZsUFF1b3RDcXh5bDF1UVpzblhQdXh3M0hvQWg1ampCLyszd1Na?=
 =?utf-8?B?UEFzM3REV0drdFRFL3NPVUtHcEcvaUN2OUlnUXFibksyMGprVSt3ZU1qdVdQ?=
 =?utf-8?B?clNVaWRiRFllK1lkZ1pDcHVadWFxWm1WTkZrVHpZWmwwRVRlcEVpWTBkQ0Nu?=
 =?utf-8?B?RDhENkpURG9UUGo0WERNL2ZDRkp0cldKdkRGcWZLeVNUVlJ2YWp2UnNoNkZT?=
 =?utf-8?B?dGxMd2pFTmJQMkgvMUc3UWtCaWxXejhFOWR6ZFRUNWJvU3RPLzNoNTlqL3VE?=
 =?utf-8?B?clpQNW9jYzVrS2hVbE9kZi9wanJIUkJNc0pBbm5xc3RsTzJJN0Y0R2xoUTVZ?=
 =?utf-8?B?UmI0TWVxT3pVRW9kWlI2alNmbGJ0eEQwTmFmT0tSY1krV09VUzNvZG9KQ21X?=
 =?utf-8?B?Y1doZFpKTmllUDZQUk5qZVlUTUJqVzhJR2JZYmZwcGVpSzRlcS84RVNiaHhB?=
 =?utf-8?B?T2J6b0kydWlHSmNxNjUxU216ZWRNM1pVZkhxWC8wQ1lqTXZqMkxzTXVLY3Z1?=
 =?utf-8?B?YnVIbFh4bkg2bVowVVltOVcwdldhMGxlN3JTZTgzL2N4QTlOdFdGdXlxa1RW?=
 =?utf-8?B?V1YrbGRyWGU1R0lIT2x1d1U0NC9rTFNHeVRMa3QyLzNycnpXSk0vR21EV1g0?=
 =?utf-8?B?SUd4dkIyaWh2UW5RVWplUGRnK2lOUjNabDRYb2RDZDNhV2oxNFE5TXdQVWZz?=
 =?utf-8?B?RUczeEpIWm1LSy8yclNBSEhOUGMySVVXc0RNMmhwd3BWN2JvdzRkSmw4WjNr?=
 =?utf-8?B?OVNCZVZRRUw1RnU0ZTJoclRwUEFvczJXUGFBZy9aMmZaSnhhWWd5eTRtc3dT?=
 =?utf-8?B?UmRBTFczVUM4VDIvL3daUjI0QStIY2I0Wksxb1Q4SU9kTjlHUFNEVnlNK1lJ?=
 =?utf-8?B?VVJwRlJ6djhiQ3Z3ZkR6M241cW9wdCtrc1BkWU13akdZYTBKUDNmZG5Xd3Y0?=
 =?utf-8?B?NDhCdGFVcGpISEFBeFl1dHU5Z2tXZFRHSGNBNHp5TmxCTmJ5QUVjTjBNNTJC?=
 =?utf-8?B?VVBGZDNhbnJiQ2c3V0ZBbDVMWnJsdDFwUk55ZzlsVGF1QzFIQVQvMWtqMi9V?=
 =?utf-8?B?UE1xc3YrVXZlVThKWnN0a09aaE5KellxaGpLTVRGeHV1YjgwSnFxK3l1anpy?=
 =?utf-8?B?eHVQQWtPRTN5bXJsSHJVbGF0YVh1NWhMbTZsRmNYT0RETTdUbkl2V3licVkz?=
 =?utf-8?B?S085V1pRWnpHVU9IWENYdUgvVGd4eThUa0pZSDhGQ055UW9JTytFQStHa1lS?=
 =?utf-8?B?WVdCeUdZeWs0cWdSb2EzRDRDWXZRUDA3OWt1aVE1VWNXb2E0d2wrMlRGTmM5?=
 =?utf-8?B?ZHIzNzJRSk9LbmNPTDI2VkNsTFVNNmhYVWJYeUM2bGo4bEIrRXUxbE9xaUhZ?=
 =?utf-8?B?dXhVRzUvS2hVcTNEbnA4WVpKZmUrelNGTXJiLzE5NVo3aG5wRFIzQ1hvWVNK?=
 =?utf-8?Q?a6Uma/PPU1mQOPnCWSQF8HL7/?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dad635-d972-41bc-ead3-08da9bd1a764
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 13:03:18.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32EI6tfYCBiYFiVTaTMgiEKtUKcjLWMq5X6CBRePkDoGYRrvYyMjNj+DKFLN3ppKFCFZuIIcgpIJz2UPuF/oVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2896
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBIb3N0ZXRsZXIg
PGdpdEBqZWZmaG9zdGV0bGVyLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjEs
IDIwMjIgNzoyMiBBTQ0KPiBUbzogRXJpYyBEZUNvc3RhIHZpYSBHaXRHaXRHYWRnZXQgPGdpdGdp
dGdhZGdldEBnbWFpbC5jb20+Ow0KPiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IENjOiBFcmljIFN1
bnNoaW5lIDxzdW5zaGluZUBzdW5zaGluZWNvLmNvbT47IFRvcnN0ZW4gQsO2Z2Vyc2hhdXNlbg0K
PiA8dGJvZWdpQHdlYi5kZT47IMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIDxhdmFyYWJAZ21h
aWwuY29tPjsgUmFtc2F5DQo+IEpvbmVzIDxyYW1zYXlAcmFtc2F5am9uZXMucGx1cy5jb20+OyBK
b2hhbm5lcyBTY2hpbmRlbGluDQo+IDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5kZT47IEVyaWMg
RGVDb3N0YSA8ZWRlY29zdGFAbWF0aHdvcmtzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MTAgNS82XSBmc21vbml0b3I6IGNoZWNrIGZvciBjb21wYXRhYmlsaXR5IGJlZm9yZQ0KPiBjb21t
dW5pY2F0aW5nIHdpdGggZnNtb25pdG9yDQo+IA0KPiANCj4gDQo+IE9uIDkvMjAvMjIgNDozMyBQ
TSwgRXJpYyBEZUNvc3RhIHZpYSBHaXRHaXRHYWRnZXQgd3JvdGU6DQo+ID4gRnJvbTogRXJpYyBE
ZUNvc3RhIDxlZGVjb3N0YUBtYXRod29ya3MuY29tPg0KPiA+DQo+ID4gSWYgZnNtb25pdG9yIGlz
IG5vdCBpbiBhIGNvbXBhdGlibGUgc3RhdGUsIGRpZSB3aXRoIGFuIGFwcHJvcHJpYXRlDQo+ID4g
ZXJyb3IgbWVzc2dlLg0KPiBbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS9mc21vbml0b3Itc2V0dGlu
Z3MuYyBiL2ZzbW9uaXRvci1zZXR0aW5ncy5jIGluZGV4DQo+ID4gNTMxYTFiNmY5NTYuLjI0NDgw
Yjk4MDZkIDEwMDY0NA0KPiA+IC0tLSBhL2ZzbW9uaXRvci1zZXR0aW5ncy5jDQo+ID4gKysrIGIv
ZnNtb25pdG9yLXNldHRpbmdzLmMNCj4gWy4uLl0NCj4gPiArY2hhciAqZnNtX3NldHRpbmdzX19n
ZXRfaW5jb21wYXRpYmxlX21zZyhzdHJ1Y3QgcmVwb3NpdG9yeSAqciwNCj4gPiAgIAkJCQkJIGVu
dW0gZnNtb25pdG9yX3JlYXNvbiByZWFzb24pDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IHN0cmJ1
ZiBtc2cgPSBTVFJCVUZfSU5JVDsNCj4gPiArCWNvbnN0IGNoYXIgKnNvY2tldF9kaXI7DQo+ID4N
Cj4gPiAgIAlzd2l0Y2ggKHJlYXNvbikgew0KPiA+ICAgCWNhc2UgRlNNT05JVE9SX1JFQVNPTl9V
TlRFU1RFRDoNCj4gPiBAQCAtMjgxLDkgKzI4MywxMSBAQCBjaGFyICpmc21fc2V0dGluZ3NfX2dl
dF9pbmNvbXBhdGlibGVfbXNnKGNvbnN0DQo+IHN0cnVjdCByZXBvc2l0b3J5ICpyLA0KPiA+ICAg
CQlnb3RvIGRvbmU7DQo+ID4NCj4gPiAgIAljYXNlIEZTTU9OSVRPUl9SRUFTT05fTk9TT0NLRVRT
Og0KPiA+ICsJCXNvY2tldF9kaXIgPSBkaXJuYW1lKChjaGFyICopZnNtb25pdG9yX2lwY19fZ2V0
X3BhdGgocikpOw0KPiA+ICAgCQlzdHJidWZfYWRkZigmbXNnLA0KPiA+IC0JCQkgICAgXygicmVw
b3NpdG9yeSAnJXMnIGlzIGluY29tcGF0aWJsZSB3aXRoIGZzbW9uaXRvcg0KPiBkdWUgdG8gbGFj
ayBvZiBVbml4IHNvY2tldHMiKSwNCj4gPiAtCQkJICAgIHItPndvcmt0cmVlKTsNCj4gPiArCQkJ
ICAgIF8oInNvY2tldCBkaXJlY3RvcnkgJyVzJyBpcyBpbmNvbXBhdGlibGUgd2l0aA0KPiBmc21v
bml0b3IgZHVlIiksDQo+ID4gKwkJCSAgICBzb2NrZXRfZGlyKTsNCj4gPiArCQlzdHJidWZfYWRk
KCZtc2csIF8oIiB0byBsYWNrIG9mIFVuaXggc29ja2V0cyBzdXBwb3J0IiksIDMyKTsNCj4gPiAg
IAkJZ290byBkb25lOw0KPiANCj4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgc3BsaXQgdGhlIGVy
cm9yIG1lc3NhZ2UgYmV0d2VlbiB0d28gY2FsbHMgdG8NCj4gc3RyYnVmX2FkZCgpLiAgSSByZWFs
aXplIHRoYXQgdGhpcyB3YXMgcHJvYmFibHkgZG9uZSBiZWNhdXNlIG9mIGxpbmUgbGVuZ3RoDQo+
IGNvbmNlcm5zLiAgQnV0IHRoaXMgbWFrZXMgYXNzdW1wdGlvbnMgb24gbGFuZ3VhZ2Ugd29yZCBv
cmRlciBkdXJpbmcNCj4gdHJhbnNsYXRpb25zLg0KPiANCj4gSW5zdGVhZCwgd2UgY2FuIHVzZSBD
IHN0cmluZyBsaXRlcmFsIGpvaW5pbmcgYmVmb3JlIHBhc3NpbmcgaXQgdG8gdGhlIHRyYW5zbGF0
aW9uDQo+IG1hY3JvLiAgU29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJc3RyYnVmX2FkZGYoJm1zZywN
Cj4gCQlfKCJzb2NrZXQgZGlyZWN0b3J5ICclcycgaXMgaW5jb21wYXRpYmxlIHdpdGggIg0KPiAJ
CSAgImZzbW9uaXRvciBkdWUgdG8gbGFjayBvZiBVbml4IHNvY2tldHMgc3VwcG9ydCIpLA0KPiAJ
CXNvY2tldF9kaXIpOw0KPiANCj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvZnNtb25pdG9yLmMg
Yi9mc21vbml0b3IuYyBpbmRleCA1N2Q2YTQ4M2JlZS4uNDNkNTgwMTMyZmINCj4gPiAxMDA2NDRm
DQo+ID4gLS0tIGEvZnNtb25pdG9yLmMNCj4gPiArKysgYi9mc21vbml0b3IuYw0KPiA+IEBAIC0z
MDUsNiArMzA1LDEwIEBAIHZvaWQgcmVmcmVzaF9mc21vbml0b3Ioc3RydWN0IGluZGV4X3N0YXRl
ICppc3RhdGUpDQo+ID4gICAJaW50IGlzX3RyaXZpYWwgPSAwOw0KPiA+ICAgCXN0cnVjdCByZXBv
c2l0b3J5ICpyID0gaXN0YXRlLT5yZXBvID8gaXN0YXRlLT5yZXBvIDogdGhlX3JlcG9zaXRvcnk7
DQo+ID4gICAJZW51bSBmc21vbml0b3JfbW9kZSBmc21fbW9kZSA9IGZzbV9zZXR0aW5nc19fZ2V0
X21vZGUocik7DQo+ID4gKwllbnVtIGZzbW9uaXRvcl9yZWFzb24gcmVhc29uID0gZnNtX3NldHRp
bmdzX19nZXRfcmVhc29uKHIpOw0KPiA+ICsNCj4gPiArCWlmIChyZWFzb24gPiBGU01PTklUT1Jf
UkVBU09OX09LKQ0KPiA+ICsJCWRpZSgiJXMiLCBmc21fc2V0dGluZ3NfX2dldF9pbmNvbXBhdGli
bGVfbXNnKHIsIHJlYXNvbikpOw0KPiANCj4gV2UgZG9uJ3Qgd2FudCB0byBjYWxsIGRpZSgpIGhl
cmUuICBNYXliZSBqdXN0IHNpbGVudGx5IHJldHVybiB3aXRob3V0IGRvaW5nDQo+IGFueXRoaW5n
IG9yIGlzc3VlIGEgd2FybmluZygpIGFuZCByZXR1cm4uICAoQnV0IEknbSBmYXZvcmluZyBhIHNp
bGVudCByZXR1cm4NCj4gaGVyZS4pDQo+IA0KPiAgRnJvbSB0aGUgY2xpZW50cycgKGBnaXQgc3Rh
dHVzYCwgYGdpdCBkaWZmYCwgZXRjLikgcG9pbnQgb2YgdmlldywgdGhleSBqdXN0IHdhbnQgYQ0K
PiBzcGVlZC11cCwgaWYgcG9zc2libGUsIGJ1dCB3ZSBzaG91bGRuJ3Qga2lsbCB0aGVtOyB3ZSBz
aG91bGQganVzdCBsZXQgdGhlbSBkbw0KPiB0aGUgbm9ybWFsIHNjYW4gdGhhdCB3b3VsZCBoYXZl
IGRvbmUgaWYgdGhlIGZlYXR1cmUgd2VyZSB0dXJuZWQgb2ZmLg0KPiANCj4gSmVmZg0KDQpJZiB3
ZSBqdXN0IHNpbGVudGx5IHJldHVybiB0aGVuIGZzbW9uaXRvciBpcyBpbiBhIHBlcnBldHVhbCBp
bmNvbXBhdGlibGUgc3RhdGUgYW5kIHRoZSB1c2VyIGdldHMgbm8gYmVuZWZpdCBmcm9tIGZzbW9u
aXRvciAoaW4gZmFjdCBpdCBjb3VsZCBiZSB3b3JzZSBhcyBmc21vbml0b3Igd2lsbCBhdHRlbXB0
IHRvIHNwYXduIG92ZXIgYW5kIG92ZXIgYWdhaW4pLiBJIHdvdWxkIHRoaW5rIHRoYXQgaXQgd291
bGQgYmUgYmV0dGVyIHRvIGF0IGxlYXN0IGluZm9ybSB0aGUgdXNlciBzbyB0aGF0IHRoZXkgY2Fu
IHVwZGF0ZSBmc21vbml0b3IncyBzZXR0aW5ncyBhbmQgaGF2ZSBhIG1vcmUgcGxlYXNhbnQgZXhw
ZXJpZW5jZSBnb2luZyBmb3J3YXJkLg0KDQotRXJpYw0K

