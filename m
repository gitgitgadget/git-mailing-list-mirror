Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3AC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E24613E1
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhDVRTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:19:00 -0400
Received: from mail-eopbgr640107.outbound.protection.outlook.com ([40.107.64.107]:57440
        "EHLO NAM06-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238234AbhDVRS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 13:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0wpfyTO2mXV1fBIqDzl9dmmXCUGjY+8aHIjnvZzygH1j1T7ggo9BXcuc6kRHQqOTrwqMEJrRbZ9LUux91RSHw+HsDU3ybyo84TWxMq23240FQdp1hQKurIsXzJYPm6JipvM2vQhRy2KJOW2zab1FXvaayeeNPutAmxMnThonj5bX4pQ68qeOlqScjw88XdTFtbIrtKKZB7HWo22fskKyG9bNTIXL36/KUOWbHrSZ9z0RVy44L1VumP12kO/p2zfGXjfRTwAP3WZhV5FZKqQtRltRrE43Yu8oi17guEw/RSeA0XiCUhIAKlSYymlT4qA+NzqVjvIse7nKaVZu/HcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fou8yCbHKumcMcl9KEszla7q57DxEzqNW4+Iwb5K6co=;
 b=Tssh7iY6GF2CEbm4k+wMUbvX+4saey8K4DhQ5Wsu7x9eDBerXJH9GzPqOoZd5lKmFY0RDVeBE+jQ4bgIF7PR4ZcyqnGNlhu8O/0doOS2JAwv8MQcEy4OBRig78Pn7mpJysoo8+eIMatCnR8XOabP34g4br5PYPgWkp8yuoGK3g7WrF2KGosowlTZVzwuGmm3sfZor61LDUBj9w3/wn/GShkrKYTbfASfGYYe79r/dpLzz9xHTb+idMff7lQAxpNeIQw5if4uAP9w+fewkBN6FsiD+ydCFfe/aijzknoidcUTOiXRPK9+WWrBZdfw3aBA9THFhvLdepEPpXOinIjK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fou8yCbHKumcMcl9KEszla7q57DxEzqNW4+Iwb5K6co=;
 b=ZNCMB+tQvM1RNW04Fb6nmp3qJnEkA6XkiGnrUEMlHQ7KSCL+tnV5OLaLQn7kqkwuKOg1m44cPBGBiw8Kyu7s5IAqnQfHD6Cch4R5XvfO9vnsVe2PODc6eP9xk9nRI2FUDEl71ZTqn4CG5xIgrGsQacdvmvkM85rDFxy1q7grkPw=
Received: from MN2PR00MB0688.namprd00.prod.outlook.com (2603:10b6:208:199::23)
 by MN2PR00MB0719.namprd00.prod.outlook.com (2603:10b6:208:1d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4109.0; Thu, 22 Apr
 2021 17:18:19 +0000
Received: from MN2PR00MB0688.namprd00.prod.outlook.com
 ([fe80::c9ee:9d16:4583:7b06]) by MN2PR00MB0688.namprd00.prod.outlook.com
 ([fe80::c9ee:9d16:4583:7b06%8]) with mapi id 15.20.4107.000; Thu, 22 Apr 2021
 17:18:19 +0000
From:   Jason Gore <Jason.Gore@microsoft.com>
To:     "peff@peff.net" <peff@peff.net>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com" <newren@gmail.com>
Subject: RE: Git clean enumerates ignored directories (since 2.27)
Thread-Topic: Git clean enumerates ignored directories (since 2.27)
Thread-Index: AdcxUgqlSmq2pC0fTZ2/uCXJJ9dNuAAL1QMAABTLcIABcbH2AA==
Date:   Thu, 22 Apr 2021 17:18:19 +0000
Message-ID: <MN2PR00MB068886B8F36DFC645138DA0489469@MN2PR00MB0688.namprd00.prod.outlook.com>
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net>
 <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
In-Reply-To: <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=24ad3223-5eb5-4150-a237-18a9dbbf3a17;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-22T17:17:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [23.252.49.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c7cbe6c-2f37-48d4-9d2a-08d905b2a026
x-ms-traffictypediagnostic: MN2PR00MB0719:
x-microsoft-antispam-prvs: <MN2PR00MB071966D0DE86FB20F100E71589469@MN2PR00MB0719.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJtj5jWxczSOQQcLbw6bBZiAXsg98VwsBGDlUyB7+DD29/9RVquD5Z/iX9si/6hcQinnv7aCTEWKkfpEwlGaUTXvJfY2RVxDp5n2DugFdaTWdZhm4yEMatt7oNuVTaSriSUnP85Zh3bpzdZnDFhlfw38ZC+DedMtmQ8WjCVOHHbDebrdnks4MHhLpqPoNMyW+GqOEMmZJYQjXE7vzGoYio7gc37c0zYvPBWykIW+EPMhZxVSeS8l6NOieourKpnNAn7EUPJXkLOjh4uyPp2bPlxi0pPvmdUXLaH42pIg4oF4th1OhYjMvUk4xHbNAABZe8s9d9qbpBoYNjmE0O5M7cvRYFhWhcAF+Na+rGABqJKJC60MwQKk1GC+8GJaQE68gZlyiItg9qpARE79I+InTmg+oYb3bC76rAnbRV05epO30KD+CEOQPDGjhPC+G0nWX6cJVeD4ly0Xs0BvY27o6b1tg6jgArOhjJjG6YuEpGR2Zb1kTpAYAxT8wqAIS235OGSCuK0zGMySHF6docpFG9z+v9YhWINLa0irMKs0Y0Zmbi0Xypy8nRWSzRH14GHGMGc+/f8KojC1GW/8OwAQXFu4LLImOSSg4WhmOjntCXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR00MB0688.namprd00.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66476007)(76116006)(110136005)(66556008)(64756008)(66946007)(8936002)(66446008)(55016002)(54906003)(7696005)(478600001)(83380400001)(10290500003)(38100700002)(71200400001)(9686003)(82960400001)(5660300002)(8676002)(86362001)(52536014)(82950400001)(53546011)(2906002)(6506007)(4326008)(26005)(316002)(33656002)(186003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnFNcmw4eEFjN3ZYcUQ2ZEVSNE96eHR4eGhiZmc0WGJUcnpteXhjZGNzS2FT?=
 =?utf-8?B?T2tlcXBYL0hWRW11aEpzWGQxaW1SeEJNWGRYM2FiWG5CeEthV3hjVVVQSGxq?=
 =?utf-8?B?QllaODd3czdBRlQ3QVhZTEtqSFVTSnJENVdkazF6NSsxZ0ZuaDNYUUt3L3g1?=
 =?utf-8?B?RzBYNHB6MVZGRnNEM1dvcWNpZDlXeFFMWjJ2bll4UmdWS25wdTZZbVpiT3hH?=
 =?utf-8?B?SytBdU9TdGpkY2M1NkdzdWRMQjEzVDRjN0Q4dGx6THJMcjRoamlMOGV5Nmxn?=
 =?utf-8?B?WGo3SVNpOGJmV1dBMUcxUUJCZUpmWnJMRm1OTXN1T25ibXFFb0FCeHZ5YjRR?=
 =?utf-8?B?ejdyZGYycGxoRDZ5QmMxWERIODZ0ZzNZSzhEeFZIdnNFVEh4TzVETEJvRFYr?=
 =?utf-8?B?MW1FNUxSUFJoSDQwZWk3YTZsQUlaaFhLejFMM1dvMGRIcjBwSEZTQmxUTnFT?=
 =?utf-8?B?UzZ3cG8waEFIdERHRXRLNUpXUlBkQ1hMV3hWNE5STlZxTi9QWEozY3k1clN5?=
 =?utf-8?B?WG9QZ01EU1ViZldMRFVDU3F4c0FvZEdKclVEeFNrV3B4VjhIZlVPNGhTemQ5?=
 =?utf-8?B?Q0ZTcTZsK1F0Y1V3SnZBbitpL0xyb1RCTHlvTDUxcitIcTljVUhhWWxUbGtM?=
 =?utf-8?B?VHNMWk41R2dOOU1vS1Rib21TU0hmL1hqNWZMOEJVYkwzbmJMOVZDc1F4OE9i?=
 =?utf-8?B?UlVZTkRxbUs5cCtUSTNGd1g1d1RZT1h3cXloZnVBdXUvTXVsRCs1SDBZUHk4?=
 =?utf-8?B?M1AyT0tvQzBpUHZHeFFHWU9uMEd1cDFFYll3b0pvTlZwT1NZdkNoem02ZmdR?=
 =?utf-8?B?YSt6MVhxdkppQ25NNFd0R1Qrdkl3SEpoOXlMVCtqOUlxdzEyTjYwb3AxU1Y3?=
 =?utf-8?B?TEZGNUVDcW1iREJsN0dpbjllVFg5OWZDK0RVN0V3d0YrL1ZEZm0rclBwNVZl?=
 =?utf-8?B?TlRXc1NMeUROenZnOUxYUWlzNTdNYzRLSEdNckpGazRPYVZ5TGV5STRYLzgx?=
 =?utf-8?B?T0Q3enBkSCtFQkp3YWRGSThzNVlNMlZhaDlNMGRzTzZBVlMxLzN5Z2YxUkRR?=
 =?utf-8?B?QjUydnRLdXM4b0F3T0lIMlZiMjlSc1dlL1NGQTB1OUhsOURLY3lMYTA0dXFS?=
 =?utf-8?B?dXdCN095TUpwQmYrUDQ1ZDcxdWlJU3ZuL2ZKOVBXV1FwRmxkOTM1dEhhUGk2?=
 =?utf-8?B?dXJHNzFOTmVtMkFSbFJhcmllZG5QODNhdTEzdEdqRXk2cWJZdG5VN3hLMmVO?=
 =?utf-8?B?cjQwakNFUGZKSC9SZkE1ODVrbWQ2a0hGMk9WTCs3NDhXUzY4c21kdTFycjkx?=
 =?utf-8?B?bjFrSjU3cFRZNlQzSkNTejd6MWN6YXl0dDhpOHprQnVuMWlrbHZ4cVNSUWhL?=
 =?utf-8?B?YXNvUC83aEtjNC9hN2ZBMzFudTJzemZsNTlXT29GN1NSK055MGtyNWtKdlEy?=
 =?utf-8?B?YjFMQVMvZ1ZLN0RpQVRGT2FqbFpZTVhPVnlBQVRRUEZZNVVsZ2lQM1RXSkoz?=
 =?utf-8?B?dHpsdSt6YjZZRXJDZjZURDZhc0lUelV3cXNpTlhiUEM0eTVZc0xObmZyaWpU?=
 =?utf-8?B?ODZOUUdkUUFpVXJ2VVh0NW9kVzQwbUdZZ2N5ZXA2cjlNcllUSk9tZExSNHkv?=
 =?utf-8?B?OVlzMjdmU0t4WnFVMmVGODlhR0dYeFF6bmFFQzFlcldFUDY4OW1vMXZiRXVP?=
 =?utf-8?B?NTFXRnNKSXFSOXErUnZsMllJTjM4OHBYNHlzTllOQkRCaEZvcVU4Wk4vUXhF?=
 =?utf-8?Q?8HC8PPGBqo3Hto5jJo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR00MB0688.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7cbe6c-2f37-48d4-9d2a-08d905b2a026
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 17:18:19.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LJBI35xsJx44mTJOI/Z/hTsPTVkNImZjkg8e8jvD0fSBI3Q3f3I7+9cM2pluaJ+p36K4aJXthlSz0PNpf7wQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR00MB0719
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U29ycnkgdG8gYWRkIG5vaXNlIHRvIHRoaXMgdGhyZWFkIGJ1dCBzaW5jZSB0aGUgZ2l0aHViIGlz
c3VlIHdhcyBjbG9zZWQgSSB3YW50ZWQgdG8gbWFrZSBzdXJlIEknbSBub3QgbWlzc2luZyBhbnkg
dXBkYXRlcyBoZXJlLiBXb3VsZCBhbnkgdXBkYXRlcyBjb21lIHRocm91Z2ggb24gdGhpcyB0aHJl
YWQ/IFRoYW5rcyENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2lu
ZyA8cGVmZkBwZWZmLm5ldD4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMTUsIDIwMjEgMTo1MiBB
TQ0KVG86IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+DQpD
YzogSmFzb24gR29yZSA8SmFzb24uR29yZUBtaWNyb3NvZnQuY29tPjsgZ2l0QHZnZXIua2VybmVs
Lm9yZzsgRWxpamFoIE5ld3JlbiA8bmV3cmVuQGdtYWlsLmNvbT4NClN1YmplY3Q6IFJlOiBHaXQg
Y2xlYW4gZW51bWVyYXRlcyBpZ25vcmVkIGRpcmVjdG9yaWVzIChzaW5jZSAyLjI3KQ0KDQpPbiBX
ZWQsIEFwciAxNCwgMjAyMSBhdCAxMDo1NjoxNFBNICswMDAwLCBicmlhbiBtLiBjYXJsc29uIHdy
b3RlOg0KDQo+IC0tLS0NCj4gIyEvYmluL3NoDQo+IA0KPiBnaXQgaW5pdCB0ZXN0LXJlcG8NCj4g
Y2QgdGVzdC1yZXBvDQo+IGxvbmduYW1lPSJkaXJlY3RvcnkiDQo+IHRvdWNoICIkbG9uZ25hbWUu
dHh0Ig0KPiBsYXN0PTQwMA0KPiBmb3IgeCBpbiAkKHNlcSAxICRsYXN0KTsgZG8NCj4gICBta2Rp
ciAieCRsb25nbmFtZSR4Ig0KPiAgIG12IGRpcmVjdG9yeSogIngkbG9uZ25hbWUkeCINCj4gICBt
diAieCRsb25nbmFtZSR4IiAiJGxvbmduYW1lJHgiDQo+IGRvbmUNCj4gZ2l0IGNsZWFuIC1mZmR4
biAtZSBkaXJlY3RvcnkkbGFzdA0KPiAtLS0tDQo+IA0KPiBXaGVuIGl0IGZhaWxzLCBpdCB3aWxs
IGNvbXBsYWluIHRoYXQgaXQgd2Fzbid0IGFibGUgdG8gb3BlbiB0aGUgDQo+IGRpcmVjdG9yeS4g
IEl0IHN0aWxsIGV4aXRzIHplcm8sIGhvd2V2ZXIuDQo+IA0KPiBJIGhhdmVuJ3QgYmlzZWN0ZWQg
dGhpcywgc28gSSBkb24ndCBrbm93IGlmIHRob3NlIHBhdGNoZXMgYXJlIHJlbGF0ZWQgDQo+IHRv
IHRoZSBwcm9ibGVtIG9yIG5vdC4gIEknbSBhIGxpdHRsZSBzaG9ydCBvbiB0aW1lIHRvZGF5IHRv
IA0KPiBpbnZlc3RpZ2F0ZSBmdXJ0aGVyLCBidXQgaG9wZWZ1bGx5IHRoaXMgY2FuIGdldCBzb21l
b25lIG9uIHRoZSByaWdodCANCj4gcGF0aCB3aXRoIGEgbW9kaWZpZWQgdmVyc2lvbiBhbmQgZ2l0
IGJpc2VjdCBydW4gaWYgbm90aGluZyBlbHNlLg0KDQpJdCBiaXNlY3RzIHRvIDhkOTJmYjI5Mjcg
KGRpcjogcmVwbGFjZSBleHBvbmVudGlhbCBhbGdvcml0aG0gd2l0aCBhIGxpbmVhciBvbmUsIDIw
MjAtMDQtMDEpLiBJIHdvbid0IHByZXRlbmQgdG8gdW5kZXJzdGFuZCBldmVyeXRoaW5nIGdvaW5n
IG9uIGluIHRoYXQgY29tbWl0LCB0aG91Z2guDQoNCi1QZWZmDQo=
