Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1DF200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeECVNU (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:13:20 -0400
Received: from mail-bl2nam02on0096.outbound.protection.outlook.com ([104.47.38.96]:45025
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751108AbeECVNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eNBbATeI51Tta636rYCpBevr+WuN02iZYXzL7Myg9ns=;
 b=kP1zT5/8FNxi0Lzme8qLGMJAf2U9z1H/DnrL7QTJNeN0Drdm1rsqdP4SdjkA6GYWUnIfTVZkI+rFQuLbi2wZfJ3dgp9rC01vpRFs6rsu/cH7leXm++TUuujQlOts6Z15EFrxB0wMYYFtkSr5Ls3rpl4/1loZlnPT1V9dbrXuDzc=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (52.132.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.0; Thu, 3 May 2018 21:13:17 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.012; Thu, 3 May 2018
 21:13:16 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Subject: RE: [PATCH v2 0/5] Allocate cache entries from memory pool
Thread-Topic: [PATCH v2 0/5] Allocate cache entries from memory pool
Thread-Index: AQHT4JhV0dzHRL+PVEGEkpV57EhR96QeOGQAgAAM0wCAACBSgIAAHEoAgAABT3A=
Date:   Thu, 3 May 2018 21:13:16 +0000
Message-ID: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180430153122.243976-1-jamill@microsoft.com>
 <CACsJy8C3yZ6bSZGw1d5DjwcPgHMDE7iGGUOn9SvyLmshzs9DvQ@mail.gmail.com>
 <CAGZ79kbyPya0igC9v5JwNTsi0TSp-sj6v5SB4MOt625+yVB-Gg@mail.gmail.com>
 <CACsJy8DF40o3gesuNbHACK+NiE=iZuXxLacyEQjECYewDy_icw@mail.gmail.com>
 <CAGZ79kb1K9iysibzmn2SUfyTayXOn97wTsoL4s557j+_ievkBA@mail.gmail.com>
In-Reply-To: <CAGZ79kb1K9iysibzmn2SUfyTayXOn97wTsoL4s557j+_ievkBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-03T21:13:10.6785195Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:a578:cc60:3b18:15f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1060;7:o8rYg0Ag5KJoL4wtlTWIomhv2188byeKDtmvx/A39GVLtoWtMpqmYZy0A9KksL55oqbUUXvcDpoJzi0mEpUy9i3VDOn90N1wuBnOf4IBjMeOUuzhw8OVtU23EJCLvWTEewzWWZD903xNfF81Uv0MESid/xGDWhcls0Chw44CMo/hihBL7gvAmkVHHRe+j+v9HjmMtPwlL89z2yhX1SSAiDGF1TBM8FskJ8isC69hbzUmcPjGzBNamBo38qXCt7VL;20:kTlohS2EC9uxXL5rUH2G4nAyqdDgcVlJ97xBvSzmmcDSJRslmJ1qTh8GWboBxs9qUh4GYjZkNL+LgXm6QiBpJFTzzuzI/Ci2f2jIDA01DgNNlidJ9XvxlfAKyXH526tmwky4S3B3nJdQv36IszzFHbPu2OdPiPOHHtX8mQOHwhI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1060;
x-ms-traffictypediagnostic: BL0PR2101MB1060:
x-microsoft-antispam-prvs: <BL0PR2101MB10601888623EB894C26D9159CE870@BL0PR2101MB1060.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1060;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1060;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(39380400002)(13464003)(189003)(199004)(476003)(6346003)(106356001)(6246003)(446003)(74316002)(11346002)(3280700002)(2906002)(102836004)(486006)(10290500003)(39060400002)(54906003)(186003)(3660700001)(25786009)(316002)(97736004)(110136005)(4326008)(5250100002)(93886005)(7736002)(305945005)(33656002)(14454004)(86612001)(2900100001)(46003)(6436002)(59450400001)(22452003)(68736007)(8656006)(8936002)(81166006)(81156014)(8676002)(7696005)(99286004)(5660300001)(478600001)(6116002)(86362001)(8990500004)(9686003)(105586002)(55016002)(229853002)(10090500001)(6506007)(76176011)(53936002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1060;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: j+B8kiNYVgNzqdaVW+TgjiyzBb56NHpZs4Ho/nRHo8pKU7bmzm5FEGUCwYd+wbxZi9ZO1EJx2hDyaVauDTxFh+a+Kr28XutlQKNgzaRvMBDKCDUkzWNVN1QjYS6NkbLNnM+oFG/Dq7N1jN7qaU+mok6Olmk+FE6BpF0yHFyd8xvdhzW56/5FDO04msutFBWs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7569405d-8ebb-4588-c414-08d5b13ab03f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7569405d-8ebb-4588-c414-08d5b13ab03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 21:13:16.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ2l0LW93bmVyQHZnZXIu
a2VybmVsLm9yZyA8Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mDQo+IFN0
ZWZhbiBCZWxsZXINCj4gU2VudDogVGh1cnNkYXksIE1heSAzLCAyMDE4IDQ6NTkgUE0NCj4gVG86
IER1eSBOZ3V5ZW4gPHBjbG91ZHNAZ21haWwuY29tPg0KPiBDYzogSmFtZXNvbiBNaWxsZXIgPGph
bWlsbEBtaWNyb3NvZnQuY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZzsNCj4gZ2l0c3RlckBwb2Jv
eC5jb207IGpvbmF0aGFudGFubXlAZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDAvNV0gQWxsb2NhdGUgY2FjaGUgZW50cmllcyBmcm9tIG1lbW9yeSBwb29sDQo+IA0KPiBPbiBU
aHUsIE1heSAzLCAyMDE4IGF0IDEyOjE3IFBNLCBEdXkgTmd1eWVuIDxwY2xvdWRzQGdtYWlsLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPj4gVG8gbWUgaXQgaXMgYWxzbyBhIGNsZWFyIHllcyB3aGVuIGl0
IGNvbWVzIHRvIGNvbWJpbmluZyB0aGVzZSB0d28NCj4gPj4gbWVtb3J5IHBvb2xzLg0KPiA+DQo+
ID4gSSBhbHNvIGRpZCBub3Qgbm90aWNlIHRoYXQgam0vbWVtLXBvb2wgYWxyZWFkeSBsYW5kZWQg
aW4gbWFzdGVyLg0KPiANCj4gT2gsIHRoYW5rcyBmb3IgdGVsbGluZyEgTm93IHRoYXQgSSBsb29r
IGF0IGl0LCBJIGFtIGRvdWJ0aW5nIGl0Ow0KPiANCj4gVGhlIHJlYXNvbiBmb3IgbXkgZG91YnQg
aXMgdGhlIHBvdGVudGlhbCBxdWFkcmF0aWMgYmVoYXZpb3IgZm9yIG5ldyBhbGxvY2F0aW9ucywN
Cj4gaW4gbWVtX3Bvb2xfYWxsb2MoKSB3ZSB3YWxrIGFsbCBtcF9ibG9ja3MgdG8gc2VlIGlmIHdl
IGNhbiBmaXQgdGhlIHJlcXVlc3RlZA0KPiBhbGxvY2F0aW9uIGluIG9uZSBvZiB0aGUgbGF0ZXIg
YmxvY2tzLg0KPiBTbyBpZiB3ZSBjYWxsIG1lbV9wb29sX2FsbG9jIGEgbWlsbGlvbiB0aW1lcywg
d2UgZ2V0IGEgTyhuKSBtcF9ibG9ja3Mgd2hpY2gNCj4gd2UnZCBoYXZlIHRvIHdhbGsgaW4gZWFj
aCBjYWxsLg0KDQpXaXRoIHRoZSBjdXJyZW50IGRlc2lnbiwgd2hlbiBhIG5ldyBtcF9ibG9jayBp
cyBhbGxvY2F0ZWQsIGl0IGlzDQpwbGFjZWQgYXQgdGhlIGhlYWQgb2YgdGhlIGxpbmtlZCBsaXN0
LiBUaGlzIG1lYW5zIHRoYXQgdGhlIG1vc3QNCnJlY2VudGx5IGFsbG9jYXRlZCBtcF9ibG9jayBp
cyB0aGUgMXN0IGJsb2NrIHRoYXQgaXMNCnNlYXJjaGVkLiBUaGUgKnZhc3QqIG1ham9yaXR5IG9m
IGFsbG9jYXRpb25zIHNob3VsZCBiZSBmdWxmaWxsZWQNCmZyb20gdGhpcyAxc3QgYmxvY2suIEl0
IGlzIG9ubHkgd2hlbiB0aGUgYmxvY2sgaXMgZnVsbCB0aGF0IHdlDQpzZWFyY2ggb3RoZXIgbXBf
YmxvY2tzIGluIHRoZSBsaXN0LiBJZiB0aGlzIGlzIGEgY29uY2VybiwgSSB0aGluaw0Kd2UgaGF2
ZSBhIGNvdXBsZSBsb3cgY29zdCBvcHRpb25zIHRvIG1pdGlnYXRlIGl0IChtYXliZSBhIGZsYWcg
dG8NCmNvbnRyb2wgd2hldGhlciB3ZSBzZWFyY2ggcGFzdCB0aGUgMXN0IG1wX2Jsb2NrIGZvciBz
cGFjZSwgb3INCmxvZ2ljIHRvIG1vdmUgYmxvY2tzIG91dCBvZiB0aGUgc2VhcmNoIHF1ZXVlIHdo
ZW4gdGhleSBhcmUNCmZ1bGwgb3IgZmFsbCBiZWxvdyBhIHRocmVzaG9sZCBmb3IgYXZhaWxhYmxl
IHNwYWNlKS4NCg0KSWYgdGhpcyBpcyBvZiBpbnRlcmVzdCwgSSBjb3VsZCBjb250cmlidXRlIGEg
cGF0Y2ggdG8gZW5hYmxlIG9uZQ0Kb2YgdGhlc2UgYmVoYXZpb3JzPw0KDQo+IA0KPiBIb3dldmVy
IGluIGFsbG9jLmMgd2UgZG8ga25vdyB0aGF0IGEgc2xhYiBpcyBmdWxsIGFzIHNvb24gYXMgd2Ug
bG9vayB0YWtlIHRoZQ0KPiBuZXh0IHNsYWIuIFRoYXQgaXMgdGhlIGJlYXV0eSBvZiBrbm93aW5n
ICdsZW4nIGF0IGNvbnN0cnVjdGlvbiB0aW1lIG9mIHRoZQ0KPiBhbGxvY2F0b3IuDQo+IA0KPiBT
byBJIGd1ZXNzIEknbGwganVzdCByZS11c2UgdGhlIG1wX2Jsb2NrIGFuZCBpbnRyb2R1Y2UgYW5v
dGhlciBzdHJ1Y3QNCj4gZml4ZWRfc2l6ZWRfbWVtX3Bvb2wsIHdoaWNoIHdpbGwgbm90IGxvb2sg
aW50byBvdGhlciBtcF9ibG9ja3MgYnV0IHRoZQ0KPiBjdXJyZW50Lg0KPiANCj4gDQo+ID4gSGF2
ZQ0KPiA+IHlvdSB0cmllZCBtZWFzdXJlIChib3RoIG1lbW9yeSB1c2FnZSBhbmQgYWxsb2NhdGlv
biBzcGVlZCkgb2YgaXQgYW5kDQo+ID4gYWxsb2MuYz8NCj4gDQo+IE5vLCBJIHdhcyBhYm91dCB0
bywgYnV0IHRoZW4gc3RhcnRlZCByZWFkaW5nIHRoZSBjb2RlIGluIGFuIGF0dGVtcHQgdG8gcmVw
bGFjZQ0KPiBhbGxvYy5jIGJ5IGEgbWVtcG9vbCBhbmQgc2F3IHRoZSBxdWFkcmF0aWMgYmVoYXZp
b3IuDQo+IA0KPiA+IEp1c3QgdGFrZSBzb21lIGJpZyByZXBvIGFzIGFuIGV4YW1wbGUgYW5kIGRv
IGNvdW50LW9iamVjdHMgLXYgdG8gc2VlDQo+ID4gaG93IG1hbnkgYmxvYnMvdHJlZXMvY29tbWl0
cyBpdCBoYXMsIHRoZW4gYWxsb2NhdGUgdGhlIHNhbWUgYW1vdW50DQo+ID4gd2l0aCBib3RoIGFs
bG9jLmMgYW5kIG1lbS1wb29sLmMgYW5kIG1lYXN1cmUgYm90aCBzcGVlZC9tZW0uDQo+ID4gSSdt
IHByZXR0eSBzdXJlIHlvdSdyZSByaWdodCB0aGF0IG1lbS1wb29sLmMgaXMgYSBjbGVhciB5ZXMu
IEkgd2FzDQo+ID4ganVzdCBiZWluZyBtb3JlIGNvbnNlcnZhdGl2ZSBiZWNhdXNlIHdlIGRvIChz
bGlnaHRseSkgY2hhbmdlDQo+ID4gYWxsb2NhdG9yJ3MgYmVoYXZpb3Igd2hlbiB3ZSBtYWtlIHRo
ZSBzd2l0Y2guIEJ1dCBpdCdzIGFsc28gdmVyeQ0KPiA+IGxpa2VseSB0aGF0IGFueSBwZXJmb3Jt
YW5jZSBkaWZmZXJlbmNlIHdpbGwgYmUgaW5zaWduaWZpY2FudC4NCj4gPg0KPiA+IEknbSBhc2tp
bmcgdGhpcyBiZWNhdXNlIGlmIG1lbS1wb29sLmMgaXMgYSBjbGVhciB3aW5uZXIsIHlvdSBjYW4g
c3RhcnQNCj4gPiB0byB1cGRhdGUgeW91IHNlcmllcyB0byB1c2UgaXQgbm93IGFuZCBraWxsIGFs
bG9jLmMgaW4gdGhlIHByb2Nlc3MuDQo+IA0KPiBJJ2xsIGltcGxlbWVudCB0aGUgZml4ZWRfc2l6
ZWRfbWVtX3Bvb2wgYW5kIHRha2Ugc29tZSBtZWFzdXJlbWVudHMuDQo+IA0KPiA+DQo+ID4gUFMu
IElzIEplZmYgYmFjayB5ZXQ/DQo+IA0KPiBIaXMgbGFzdCBlbWFpbCBvbiB0aGUgcHVibGljIGxp
c3QgaXMgQXByIDEwdGgsIHN0YXRpbmcgdGhhdCBoZSdsbCBiZSBvZmZsaW5lIGZvciAiYSBmZXcN
Cj4gd2Vla3MiLCBpbiA8MjAxODA0MDYxNzUzNDkuR0IzMjIyOEBzaWdpbGwuaW50cmEucGVmZi5u
ZXQ+IGhlIHNhaWQgdGhlDQo+IHZhY2F0aW9uIHBhcnQgaXMgMyB3ZWVrcy4gU28gSSB0aGluayBo
ZSBpcyBkb25lIHdpdGggdmFjYXRpb24gYW5kIGlzIGp1c3QgaGlkaW5nIHRvDQo+IGZpZ3VyZSBv
dXQgYSBuaWNlIGNvbWViYWNrLiA7LSkNCj4gDQo+ID4gSSdtIHN1cmUgSnVuaW8gaXMgbGlzdGVu
aW5nIGFuZCBhbGwgYnV0IEknbSBhZnJhaWQgaGUncyB0b28gYnVzeSBiZWluZw0KPiA+IGEgbWFp
bnRhaW5lciBzbyBKZWZmJ3Mgb3BpbmlvbiBpbiB0aGlzIGFyZWEgaXMgcmVhbGx5IHZhbHVhYmxl
LiBIZSBoYXMNCj4gPiBhbGwgdGhlIGZ1biBhbmQgd2VpcmQgdXNlIGNhc2VzIHRvIHBsYXkgd2l0
aCBhdCBnaXRodWIuDQo+IA0KPiBvay4gSSdsbCBjYyBoaW0gZm9yIHRoZXNlIHBhdGNoZXMuDQo+
IA0KPiBUaGFua3MsDQo+IFN0ZWZhbg0K
