Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E998D20899
	for <e@80x24.org>; Tue, 15 Aug 2017 04:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbdHOEXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 00:23:54 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:65119
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750888AbdHOEXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 00:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fsSggCq9YgkI/m62nDMz9XvMGVdNXn3GCD6bfwoh2T4=;
 b=JrCkscg7yaT7Hum+YpRFQ62EAVtD1HtRyGyWnudKndGPG/sE+ZtCatTVPQ4T2jRGG7TP5Kh78QnPfIRZrNWUfHOtbWYE9pKRGyu24G8zcQDc5ZK3IZoIJs2NKJzUBr9Ja1gejHBL8wYkj15qznKBnfyWVV4oUmmOPNEUzI7VG84=
Received: from DM2PR21MB0041.namprd21.prod.outlook.com (10.161.140.19) by
 DM2PR21MB0106.namprd21.prod.outlook.com (10.161.141.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1385.0; Tue, 15 Aug 2017 04:23:50 +0000
Received: from DM2PR21MB0041.namprd21.prod.outlook.com
 ([fe80::bcf3:638e:5a6c:7b71]) by DM2PR21MB0041.namprd21.prod.outlook.com
 ([fe80::bcf3:638e:5a6c:7b71%14]) with mapi id 15.01.1385.003; Tue, 15 Aug
 2017 04:23:50 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: RE: [PATCH v2] commit: skip discarding the index if there is no
 pre-commit hook
Thread-Topic: [PATCH v2] commit: skip discarding the index if there is no
 pre-commit hook
Thread-Index: AQHTFUfwE6zBS/Ak0kKJOI8Bg7ydDKKEanYAgAAE0LA=
Date:   Tue, 15 Aug 2017 04:23:50 +0000
Message-ID: <DM2PR21MB004160EA994A445A89BD50F7B78D0@DM2PR21MB0041.namprd21.prod.outlook.com>
References: <20170810185416.8224-1-kewillf@microsoft.com>
 <20170814215425.23784-1-kewillf@microsoft.com>
 <20170814221309.tg7wizmvx3gtzfc7@sigill.intra.peff.net>
In-Reply-To: <20170814221309.tg7wizmvx3gtzfc7@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-08-14T22:23:48.4911186-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [67.60.94.116]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR21MB0106;6:u6HYQyTEMTgoBUuZGTDfj8JZbkWHGNpPTByZongm7K0KbNHcEXuAZGLQzkq69kmqoOpmvvl0Z5XRYPYd9v6FPNMH0d83BhM91m9rq9LzWExQzLG/yV6nGXcVcVtIX178zDpqdY3CIeLZuuBUV3rgjLfs2ZaETRid+sEUfhzY9fWHp9qWa0Bl5UGC2G9Q+YHfpOlgnWPSB3YW36NAfxp+JJt4gN+nYZN9o61JLuFXuGH5w2KLHeDp9wnfZnHLIrxCUjZj8KCB/4WPd9sFuB51USTueoENnXE5djuYVM2noQzoJjJIQvV75eNhHmxMRRszA3XCmvVxdasg8y7wReH4jg==;5:ncpTOIsLAP9YYdYpBSkczVJppBxaoagUiF98tLRqctoCcYcZrSv4CjtDAvkDl3GJ8U0PxhX/Fj6YzIAHkmDAyDmezQOXixpk/XAuWwwdggzfebTS0WdAc0WjrFSc5vQvexwY8NP/W1zLTtGXbXTwaA==;24:/fzLwIvMrY8yAPKY2IHGuoZjnID/qWjx4SpEmOZD1Y1A8zqUF7CVgKQOz75R/aiYvGAtKgmAht4BdEGFB39VDqRsO5Eyc13MX8B0+Ymxl4c=;7:wuX2XYujGPwAUB1Mc0Neu0zJl8qIsIqBTqCP86kyF4R94IP6dljChMm4k9oSJkUcJwtp/uQEryL8wQ1N8Op88L88BGdDb8bFOH+v5RN3s+HmuTV/eC/kIkzYOHdURua9EqvjLzMsEWY4QmGd9jbvb+unJIHtIYSQ9oSowJ2x4d8YRk1m1PGLd9nYNNjqsG+pHhUQtOOkpXxDsH4ntXoCh45pCN7nptWehZuO72j4UwU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 702322f9-fede-4d04-1d37-08d4e3956e5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603144)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR21MB0106;
x-ms-traffictypediagnostic: DM2PR21MB0106:
x-exchange-antispam-report-test: UriScan:(89211679590171)(166708455590820);
x-microsoft-antispam-prvs: <DM2PR21MB01066213B93C01EE85E2FAF4B78D0@DM2PR21MB0106.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(601004)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0106;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0106;
x-forefront-prvs: 04004D94E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(24454002)(199003)(189002)(5005710100001)(99286003)(6246003)(105586002)(4326008)(74316002)(966005)(6116002)(102836003)(3846002)(54906002)(14454004)(106356001)(9686003)(68736007)(8656003)(10090500001)(5660300001)(33656002)(229853002)(7696004)(2900100001)(2950100002)(6916009)(8990500004)(25786009)(10290500003)(478600001)(50986999)(54356999)(76176999)(101416001)(3660700001)(305945005)(3280700002)(2906002)(8936002)(7736002)(5250100002)(6506006)(81166006)(8676002)(86362001)(575784001)(81156014)(86612001)(6436002)(97736004)(6306002)(110136004)(53936002)(189998001)(55016002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0106;H:DM2PR21MB0041.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2017 04:23:50.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPbiBNb24sIEF1ZyAxNCwgMjAxNyBhdCAwMzo1NDoyNVBNIC0wNjAwLCBLZXZpbiBXaWxsZm9y
ZCB3cm90ZToNCj4gDQo+ID4gSWYgdGhlcmUgaXMgbm90IGEgcHJlLWNvbW1pdCBob29rLCB0aGVy
ZSBpcyBubyByZWFzb24gdG8gZGlzY2FyZA0KPiA+IHRoZSBpbmRleCBhbmQgcmVyZWFkIGl0Lg0K
PiA+DQo+ID4gVGhpcyBjaGFuZ2UgY2hlY2tzIHRvIHByZXNlbmNlIG9mIGEgcHJlLWNvbW1pdCBo
b29rIGFuZCB0aGVuIG9ubHkNCj4gPiBkaXNjYXJkcyB0aGUgaW5kZXggaWYgdGhlcmUgd2FzIG9u
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdpbGxmb3JkIDxrZXdpbGxmQG1pY3Jv
c29mdC5jb20+DQo+ID4gLS0tDQo+ID4gIGJ1aWx0aW4vY29tbWl0LmMgfCAxNSArKysrKysrKyst
LS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IFRoYW5rcywgdGhpcyBsb29rcyBuaWNlIGFuZCBzaW1wbGUuDQo+IA0KPiA+IGRp
ZmYgLS1naXQgYS9idWlsdGluL2NvbW1pdC5jIGIvYnVpbHRpbi9jb21taXQuYw0KPiA+IGluZGV4
IGU3YTJjYjYyODUuLmFiNzFiOTM1MTggMTAwNjQ0DQo+ID4gLS0tIGEvYnVpbHRpbi9jb21taXQu
Yw0KPiA+ICsrKyBiL2J1aWx0aW4vY29tbWl0LmMNCj4gPiBAQCAtOTQwLDEyICs5NDAsMTUgQEAg
c3RhdGljIGludCBwcmVwYXJlX3RvX2NvbW1pdChjb25zdCBjaGFyICppbmRleF9maWxlLA0KPiBj
b25zdCBjaGFyICpwcmVmaXgsDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4gIAl9DQo+ID4NCj4gPiAt
CS8qDQo+ID4gLQkgKiBSZS1yZWFkIHRoZSBpbmRleCBhcyBwcmUtY29tbWl0IGhvb2sgY291bGQg
aGF2ZSB1cGRhdGVkIGl0LA0KPiA+IC0JICogYW5kIHdyaXRlIGl0IG91dCBhcyBhIHRyZWUuICBX
ZSBtdXN0IGRvIHRoaXMgYmVmb3JlIHdlIGludm9rZQ0KPiA+IC0JICogdGhlIGVkaXRvciBhbmQg
YWZ0ZXIgd2UgaW52b2tlIHJ1bl9zdGF0dXMgYWJvdmUuDQo+ID4gLQkgKi8NCj4gPiAtCWRpc2Nh
cmRfY2FjaGUoKTsNCj4gPiArCWlmICghbm9fdmVyaWZ5ICYmIGZpbmRfaG9vaygicHJlLWNvbW1p
dCIpKSB7DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBSZS1yZWFkIHRoZSBpbmRleCBhcyBwcmUtY29t
bWl0IGhvb2sgY291bGQgaGF2ZSB1cGRhdGVkIGl0LA0KPiA+ICsJCSAqIGFuZCB3cml0ZSBpdCBv
dXQgYXMgYSB0cmVlLiAgV2UgbXVzdCBkbyB0aGlzIGJlZm9yZSB3ZSBpbnZva2UNCj4gPiArCQkg
KiB0aGUgZWRpdG9yIGFuZCBhZnRlciB3ZSBpbnZva2UgcnVuX3N0YXR1cyBhYm92ZS4NCj4gPiAr
CQkgKi8NCj4gPiArCQlkaXNjYXJkX2NhY2hlKCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmVh
ZF9jYWNoZV9mcm9tKGluZGV4X2ZpbGUpOw0KPiANCj4gVGhpcyByZWFkX2NhY2hlX2Zyb20oKSBz
aG91bGQgYmUgYSBub29wLCByaWdodCwgYmVjYXVzZSBpdCBpbW1lZGlhdGVseQ0KPiBzZWVzIGlz
dGF0ZS0+aW5pdGlhbGl6ZWQgaXMgc2V0PyBTbyBpdCBzaG91bGRuJ3QgbWF0dGVyIHRoYXQgaXQg
aXMgbm90DQo+IGluIHRoZSBjb25kaXRpb25hbCB3aXRoIGRpc2NhcmRfY2FjaGUoKS4gVGhvdWdo
IGlmIGl0cyBvbmx5IHB1cnBvc2UgaXMNCj4gdG8gcmUtcmVhZCB0aGUganVzdC1kaXNjYXJkZWQg
Y29udGVudHMsIHBlcmhhcHMgaXQgbWFrZXMgc2Vuc2UgdG8gcHV0IGl0DQo+IHRoZXJlIGZvciBy
ZWFkYWJpbGl0eS4NCj4gDQo+IC1QZWZmDQoNCkkgdGhvdWdodCBhYm91dCB0aGF0IGFuZCBkaWRu
J3Qga25vdyBpZiB0aGVyZSB3ZXJlIGNhc2VzIHdoZW4gdGhpcyB3b3VsZCBiZSBjYWxsZWQNCmFu
ZCB0aGUgY2FjaGUgaGFzIG5vdCBiZWVuIGxvYWRlZC4gIEl0IGRpZG4ndCBsb29rIGxpa2UgaXQg
c2luY2UgaXQgaXMgb25seSBjYWxsZWQgZnJvbSANCmNtZF9jb21taXQgYW5kIHByZXBhcmVfaW5k
ZXggaXMgY2FsbGVkIGJlZm9yZSBpdC4gIEFsc28gaWYgaW4gdGhlIGZ1dHVyZSB0aGlzIGNhbGwg
d291bGQNCmJlIG1hZGUgd2hlbiBpdCBoYWQgbm90IHJlYWQgdGhlIGluZGV4IHlldCBzbyB0aG91
Z2h0IGl0IHdhcyBzYWZlc3QganVzdCB0byBsZWF2ZQ0KdGhpcyBhcyBhbHdheXMgYmVpbmcgY2Fs
bGVkIHNpbmNlIGl0IGlzIGJhc2ljYWxseSBhIG5vb3AgaWYgdGhlIGlzdGF0ZS0+aW5pdGlhbGl6
ZWQgaXMgc2V0Lg0KDQpBbHNvIGJhc2VkIG9uIHRoaXMgY29tbWl0DQpodHRwczovL2dpdGh1Yi5j
b20vZ2l0L2dpdC9jb21taXQvMjg4ODYwNWM2NDljY2Q0MjMyMzIxNjExODZkNzJjMGU2YzQ1OGE0
OA0KaXQgbG9va2VkIGxpa2UgdGhlIGRpc2NhcmRfY2FjaGUgd2FzIGFkZGVkIGluZGVwZW5kZW50
IG9mIHRoZSByZWFkX2NhY2hlX2Zyb20gY2FsbCwNCndoaWNoIG1hZGUgbWUgdGhpbmsgdGhhdCB0
aGUgdHdvIHdlcmUgbm90IHRpZWQgdG9nZXRoZXIuDQoNCktldmluDQo=
