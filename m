Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78AD820286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbdIMRJT (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:09:19 -0400
Received: from mail-sn1nam02on0098.outbound.protection.outlook.com ([104.47.36.98]:63941
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751101AbdIMRJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pqS0ahifyvStAymvW0Ctj93ARAYmt/iEQJEn5OiZ28Q=;
 b=MTMCbY1RIaFsHlXcI9LYxme6haLipXMRGe9RfJ2t26VpzRbONmjmzI73X0iI5h9MXXXfy/Gqhv6gYL5u2aPHcYkPQ3puxqOpxk24QkFt1+NqyzhADCO/GA2rwCP54bdiRku/jW1gcXqXcZpkW3UzBdk55D3AtMv5o95EX0tGog8=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0064.namprd21.prod.outlook.com (10.161.254.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.5; Wed, 13 Sep 2017 17:09:16 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0077.005; Wed, 13 Sep 2017 17:09:16 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Jacob Keller <jacob.keller@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWy30gAAJb7CAAH5jR4AAB2mQgAMpW3CAAHk5AIABF7AQgACzS9CAAIOfgIAAA+EwgAAxKACAANhhEA==
Date:   Wed, 13 Sep 2017 17:09:15 +0000
Message-ID: <SN1PR21MB0014D30A30F70B7DEAA17478B76E0@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
 <20170908180050.25188-2-kewillf@microsoft.com>
 <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
 <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
 <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
 <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
 <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
 <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
 <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
 <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
In-Reply-To: <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-13T11:09:14.0548899-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0064;6:bt90f5T0ueK92Wkihg+2ruG55/SbNoE6Y9DLd8hJb+9XN+HaQxhFa2OJ7POOjknwghR1VSr46fLROcIUaugtnRPeDy7lnbtEDwcTTSiKffV1bWFsAPt2xu7uke8ixqenSe2tWlrUyIcfoxucrJIoC6hFa8nM8T5vnkvAHNKQUgCQCtpNjJ0baRBB9AzOx4pyc0e051bP4/U0qPfjyapvY6EmGAasPEp5kDAMIFAssrGx6GoBirAIEqBk/V0b73npyog1D5LyVMnUzT4ke9VERI7eLd17YZZTCHEKUCIBiG7VQD8t3QrBn03feAG7rbY70GoUObN7q87q2Xtz5AFzbA==;5:GXhhhrfsrOAHlboEiO28eZRwJuK7Zx/X4AEhg5leFYiKwkbQY2kYvWWLCAAIZ3yyDlNqB044+w8crdRuHnVqjTvq2Xf0vQGEKcmnUwXymT65yma09NNantRlhHSV3GCB27EJdzqSeBVOFVow8t4sKw==;24:gMJs7P5tbjmJFEjo3eeTtQbUicf1XBT6903gKE4iEuqQCfFqJ/KySOO5rkpSp3LhNymrQDy8C6c6M/9v/xUjd5YmXmrWhaAQZBdSWkI+5eY=;7:jonLWL/16qD1vgSSwyYJyYQlNJ2OXF8Z3IudrDqB79fYRnso4kjwuiojv9BEV5cc3wx3fRMHMPdBzrefmnpYfEpKDN5CxdlXmgL4UQxbIT5CcqZDy6+5Kfj4kU3himdqM58IbglFXpZE64mOYPS5zejf0oYK70JhvwTZDJS98asvl8Rz48JNFbvh1krlOqj3AlMYEqeeojyF1Yx89LApsJtWdRg3UG0hT+6ogyLTmMg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f0d4bf85-6e65-4372-2d95-08d4faca2a04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(300000502095)(300135100095)(22001)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0064;
x-ms-traffictypediagnostic: SN1PR21MB0064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(89211679590171);
x-microsoft-antispam-prvs: <SN1PR21MB006497DB384C6812585B1AD2B76E0@SN1PR21MB0064.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123558100)(20161123560025)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0064;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0064;
x-forefront-prvs: 042957ACD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(377454003)(189002)(199003)(24454002)(8666007)(110136004)(54906002)(8990500004)(74316002)(55016002)(99286003)(316002)(101416001)(54356999)(50986999)(76176999)(6246003)(53546010)(6916009)(2950100002)(8676002)(3846002)(14454004)(97736004)(6116002)(102836003)(10090500001)(9686003)(68736007)(7696004)(2900100001)(81156014)(105586002)(86612001)(53936002)(86362001)(5660300001)(189998001)(22452003)(77096006)(8936002)(8656003)(93886005)(6506006)(33656002)(478600001)(106356001)(10290500003)(7736002)(4326008)(305945005)(3280700002)(229853002)(3660700001)(39060400002)(81166006)(66066001)(2906002)(6436002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0064;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2017 17:09:15.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0064
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBKYWNvYiBLZWxsZXIgW21haWx0bzpqYWNvYi5rZWxsZXJAZ21haWwuY29tXQ0KPiBT
ZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMTcgNzozOSBQTQ0KPiANCj4gT24gVHVlLCBT
ZXAgMTIsIDIwMTcgYXQgNDozMCBQTSwgS2V2aW4gV2lsbGZvcmQgPGtld2lsbGZAbWljcm9zb2Z0
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTb3JyeS4gIEl0IHdhcyBub3QgaW4gdGhlIHNwYXJzZS1j
aGVja291dCBmaWxlLg0KPiA+ICQgZ2l0IGNvbmZpZyBjb3JlLnNwYXJzZWNoZWNrb3V0IHRydWUN
Cj4gPiAkIGVjaG8gL2kgPiAuZ2l0L2luZm8vc3BhcnNlLWNoZWNrb3V0DQo+ID4gJCBnaXQgY2hl
Y2tvdXQgLWYNCj4gPiB3YXMgcmFuIGluIHRoZSBtb2RpZmllZCBmaWxlIGNhc2UgYXMgd2VsbCBh
bmQgImkiIHdhcyB0aGUgb25seSBmaWxlIGluIHRoZQ0KPiA+IHdvcmtpbmcgZGlyZWN0b3J5IGJl
Zm9yZSByZXNldC4NCj4gPg0KPiANCj4gDQo+IEknbSBhc3N1bWluZyB0aGVuIHRoYXQgeW91IG1l
YW4gdGhhdCBzb21lIGZpbGUgIm0iIGlzIG1vZGlmaWVkIGJ5IHRoZQ0KPiBjb21taXQsIGFuZCBk
byBub3QgbWVhbiB0byBzYXkgdGhhdCBpdCBoYXMgbG9jYWwgbW9kaWZpY2F0aW9ucyBpbiB0aGUN
Cj4gd29ya2luZyB0cmVlPyBUaGF0IGlzIG5vdCB3aGF0IEkgaGFkIGluZmVycmVkIGZyb20gZWFy
bGllciwgc28gSSB3YXMNCj4gdmVyeSBtdWNoIGNvbmZ1c2VkLg0KPiANCg0KWWVzDQoNCj4gSW4g
dGhpcyBleGFtcGxlLCB0aGUgb25seSBmaWxlIGFjdHVhbGx5IGNoZWNrZWQgb3V0IGlzICJpIiwg
YXMNCj4gZXZlcnl0aGluZyBlbHNlIHdpbGwgaGF2ZSB0aGUgc2tpcC13b3JrdHJlZSBiaXQgc2V0
Li4/DQo+IA0KDQpZZXMNCg0KPiBTbyBkb2luZyBnaXQgcmVzZXQgSEVBRH4xIHdpbGwgcmVzZXQg
dGhlIGJyYW5jaCBiYWNrIG9uZSBjb21taXQsIGFuZA0KPiBub3cgYmVjYXVzZSBvZiB0aGlzIHJl
c2V0IGlzIGNsZWFyaW5nIHRoZSBza2lwIHdvcmt0cmVlIGZsYWcsIGFuZA0KPiBzaW5jZSB5b3Ug
bmV2ZXIgaGFkIGEgY29weSBvZiBpdCBjaGVja2VkIG91dCBpdCBpcyBub3RpZmllZCBhcw0KPiBk
ZWxldGVkLCBiZWNhdXNlIGl0J3Mgbm8gbG9uZ2VyIG1hcmtlZCBhcyBza2lwLXdvcmt0cmVlPw0K
PiANCg0KQ29ycmVjdA0KDQo+IA0KPiBJIHRoaW5rIHRoZSByZWFsIGZpeCBpcyB0byBzdG9wIGhh
dmluZyByZXNldCBjbGVhciBza2lwLXdvcmt0cmVlLCBubz8NCj4gDQo+IEJ5IGRlZmluaXRpb24g
aWYgeW91IGRvIGEgc3BhcnNlIGNoZWNrb3V0LCB5b3UncmUgdGVsbGluZyBnaXQgIkkgb25seQ0K
PiBjYXJlIGFib3V0IHRoZSBmaWxlcyBpbiB0aGlzIHNwYXJzZSBjaGVja291dCwgYW5kIGRvIG5v
dCBjb25jZXJuIG1lDQo+IHdpdGggYW55dGhpbmcgZWxzZSIuLi4gU28gdGhlIHByb3Bvc2VkIGZp
eCBpcyAic2luY2UgZ2l0IGNsZWFyZWQgdGhlDQo+IHNraXAtd29ya3RyZWUgZmxhZywgd2Ugc2hv
dWxkIGFjdHVhbGx5IGFsc28gY29weSB0aGUgZmlsZSBvdXQgYWdhaW4uIg0KPiBidXQgSSB0aGlu
ayB0aGUgcmVhbCBwcm9ibGVtIGlzIHRoYXQgd2UncmUgY2xlYXJpbmcgc2tpcCB3b3JrdHJlZSB0
bw0KPiBiZWdpbiB3aXRoPw0KDQpUaGlzIGNlcnRhaW5seSBpcyBhbiBvcHRpb24gYnV0IEkgd291
bGQgaGF2ZSBzb21lIHF1ZXN0aW9ucyB3aXRoIHRoaXMNCmFwcHJvYWNoLiAgRG9lcyB0aGlzIHN0
YXRlbWVudCwgIkkgb25seSBjYXJlIGFib3V0IHRoZSBmaWxlcyBpbiB0aGlzDQpzcGFyc2UgY2hl
Y2tvdXQsIGFuZCBkbyBub3QgY29uY2VybiBtZSB3aXRoIGFueXRoaW5nIGVsc2UiLCBtZWFuDQp0
aGF0IGdpdCBzaG91bGQgbm90IGNoYW5nZSBmaWxlcyBvdXRzaWRlIHRoZSBzcGFyc2UtY2hlY2tv
dXQgd2hldGhlcg0KdGhleSBhcmUgaW4gdGhlIHdvcmtpbmcgZGlyZWN0b3J5IG9yIHRoZSBpbmRl
eD8gIE9yIGRvZXMgdGhhdCBvbmx5DQphcHBseSB0byB0aGUgd29ya2luZyBkaXJlY3RvcnkgYW5k
IHRoZSBpbmRleCB2ZXJzaW9uIG9mIGZpbGVzIGNhbg0KY2hhbmdlIHRvIHdoYXRldmVyIGdpdCBk
ZWNpZGVzPyAgU28gaW4gdGhlIGV4YW1wbGUgYWJvdmUgd291bGQNCiJtIiBiZSB0aGUgSEVBRH4x
IHZlcnNpb24gb2YgdGhlIGZpbGUgaW4gdGhlIGluZGV4IG9yIHRoZSBIRUFEDQp2ZXJzaW9uIGJl
Zm9yZSB0aGUgcmVzZXQ/ICBEb2VzIHRoaXMgYXBwbHkgdG8gYWxsIGdpdCBjb21tYW5kcywNCm1l
cmdlLCByZWJhc2UsIGNoZXJyeS1waWNrLCBldGM/ICBXaGF0IGFib3V0IHdoZW4gdGhlcmUgaXMg
YSBtZXJnZQ0KY29uZmxpY3Qgd2l0aCBhIGZpbGUgdGhhdCBpcyBvdXRzaWRlIHRoZSBzcGFyc2Ug
Y2hlY2tvdXQ/DQoNClNlZW1zIHRvIG1lIGl0IGlzIGEgbG90IG1vcmUgY29tcGxleCB0aGFuIG9u
bHkgY2FyaW5nIGFib3V0IHRoZSBmaWxlcw0KaW4gdGhlIHNwYXJzZSBjaGVja291dCBhbmQgbm8g
Y29uY2VybiBmb3IgYW55dGhpbmcgZWxzZS4gIFBlcnNvbmFsbHkNCkkgd291bGQgbGlrZSB0byBl
cnJvciBvbiB0aGUgc2lkZSBvZiBsZXR0aW5nIHRoZSB1c2VyIGRlY2lkZSB3aGF0IHRoZXkNCndh
bnQgdG8gZG8sIGV2ZW4gaWYgdGhhdCBtZWFucyB0dXJuaW5nIG9mZiB0aGUgc2tpcC13b3JrdHJl
ZSBiaXQgYW5kDQpwdXR0aW5nIHRoZSB3b3JraW5nIGRpcmVjdG9yeSBpbnRvIGFuIGV4cGVjdGVk
IHN0YXRlLg0KDQoNCg==
