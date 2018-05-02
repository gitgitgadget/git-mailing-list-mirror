Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BCE21847
	for <e@80x24.org>; Wed,  2 May 2018 18:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEBSHq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:07:46 -0400
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:52569
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751075AbeEBSHo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aOAFHMXLoEeiExdG4h8ULcfgqMCG57NWi3GJCp7RN10=;
 b=JvoWwmipwuymVH0AeVXhEBwU03cO85Nzw+Y3zA79QBzuvlPUfeWMPFwQ8ZNGlOV/eC1w/U9B3YD7hvRLZXo6P/jM8YKJrz20ApEV0YnAEbO1ejGsPdCv4hfrItgdEoFtOmqiHIhF9ZQx3HkhgAaDVHjPkQTtjPR1eaLjYKHEckg=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0897.namprd21.prod.outlook.com (52.132.23.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Wed, 2 May 2018 18:07:42 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.011; Wed, 2 May 2018
 18:07:42 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH 00/13] object store: alloc
Thread-Topic: [PATCH 00/13] object store: alloc
Thread-Index: AQHT4ZQkT0wTvjJ5ek2bMhaifDxhu6Qcq1QAgAAQHeA=
Date:   Wed, 2 May 2018 18:07:42 +0000
Message-ID: <BL0PR2101MB1106C07DEE184F8DA2C7CA62CE800@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <CACsJy8DKnBRDZC=oBd8nTOAVzQf3UtoLCeoGKjcMHgUmXf-KqQ@mail.gmail.com>
In-Reply-To: <CACsJy8DKnBRDZC=oBd8nTOAVzQf3UtoLCeoGKjcMHgUmXf-KqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-02T18:07:40.0024842Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:b2ec:da36:1ccf:fa06]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0897;7:siEf97EAxAgZmhWSUSP4E7Qv527YowA8snOYDanRwlHhgVs5oEpiW/BgQIbJKgKgWZ52vraENKcJ2yOp91d1z0KjxG+xfnxTiTUYeRIVRth4IFSaEfpx5dJNvpSiO0denne7uhMvh026XKJO7lMN1DdEA7tEGmvSsmT5qiFX07bRMFlxaxRywWNHZNEVs5wwWqJzBxc0A/wcjZfcXbdD9xTp+HMJ1T4Kg85L181902crgnnejWBYBa60Y9YycUuj;20:4yGIXKmrGgp09eOohWFnqs8JF6bL97Ut1lgNHcuK+IccoRBOxqrwFdIMJVNlYR/f0BKJo56QsMrkSbZmoVK/Fd7fO4kZAFOPfmVD8e1Y8mE2yv7jUODejP4HejH7wjL9JWxRCroOpEmhPFJwerY4OvoczSX8UAbaA101nxiikQs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0897;
x-ms-traffictypediagnostic: BL0PR2101MB0897:
x-microsoft-antispam-prvs: <BL0PR2101MB08978A4CD85BC25491A696D8CE800@BL0PR2101MB0897.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0897;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0897;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(13464003)(3280700002)(39060400002)(8990500004)(86612001)(2900100001)(14454004)(486006)(186003)(4326008)(97736004)(6246003)(10090500001)(5250100002)(102836004)(55016002)(9686003)(53546011)(6346003)(6116002)(53936002)(2906002)(476003)(8936002)(7736002)(6436002)(6506007)(229853002)(81156014)(68736007)(8676002)(99286004)(33656002)(478600001)(46003)(5660300001)(86362001)(11346002)(25786009)(110136005)(105586002)(7696005)(3660700001)(81166006)(22452003)(74316002)(305945005)(10290500003)(446003)(106356001)(316002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0897;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: JkqRZDUQ72iMapXCZuiVhq6zaitaSr9TKE+89ICQvPQ5fGQAKqZf7TDiIFTrrTOlIvPOpjJ4z0M5avtCpO3tDHQEyLsL+eur6hmgbqlRqGTcng6NX0NnOA1HKXkFd7MBxWGZ6ZmMs1J2G5r1bPE8fnFj8xKHy81UeJa8VM7oo7TZWdQa/eo0ulaisaiuyeZ9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5d30a521-25d8-45dd-64be-08d5b0579965
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d30a521-25d8-45dd-64be-08d5b0579965
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 18:07:42.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0897
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHV5IE5ndXllbiA8cGNs
b3Vkc0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIsIDIwMTggMTowMiBQTQ0K
PiBUbzogU3RlZmFuIEJlbGxlciA8c2JlbGxlckBnb29nbGUuY29tPg0KPiBDYzogR2l0IE1haWxp
bmcgTGlzdCA8Z2l0QHZnZXIua2VybmVsLm9yZz47IEphbWVzb24gTWlsbGVyDQo+IDxqYW1pbGxA
bWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xM10gb2JqZWN0IHN0b3Jl
OiBhbGxvYw0KPiANCj4gT24gVHVlLCBNYXkgMSwgMjAxOCBhdCAxMTozMyBQTSwgU3RlZmFuIEJl
bGxlciA8c2JlbGxlckBnb29nbGUuY29tPiB3cm90ZToNCj4gPiBJIGFsc28gZGViYXRlZCBpZiBp
dCBpcyB3b3J0aCBjb252ZXJ0aW5nIGFsbG9jLmMgdmlhIHRoaXMgcGF0Y2ggc2VyaWVzDQo+ID4g
b3IgaWYgaXQgbWlnaHQgbWFrZSBtb3JlIHNlbnNlIHRvIHVzZSB0aGUgbmV3IG1lbS1wb29sIGJ5
IEphbWVzb25bMV0uDQo+ID4NCj4gPiBJIHZhZ3VlbHkgd29uZGVyIGFib3V0IHRoZSBwZXJmb3Jt
YW5jZSBpbXBhY3QsIGFzIHRoZSBvYmplY3QNCj4gPiBhbGxvY2F0aW9uIGNvZGUgc2VlbWVkIHRv
IGJlIHJlbGV2YW50IGluIHRoZSBwYXN0Lg0KPiANCj4gSWYgSSByZW1lbWJlciBjb3JyZWN0bHks
IGFsbG9jLmMgd2FzIGFkZGVkIGJlY2F1c2UgbWFsbG9jKCkgaGFzIHRvbyBoaWdoDQo+IG92ZXJo
ZWFkIHBlciBhbGxvY2F0aW9uIChhbmQgd2UgY3JlYXRlIGxpa2UgbWlsbGlvbnMgb2YgdGhlbSku
IEFzIGxvbmcgYXMgeW91DQo+IGtlZXAgYWxsb2NhdGlvbiBvdmVyaGVhZCBsb3csIGl0IHNob3Vs
ZCBiZSBvay4gTm90ZSB0aGF0IHdlIGFsbG9jYXRlIGEgbG90IG1vcmUNCj4gdGhhbiB0aGUgbWVt
LXBvb2wncyBtYWluIHRhcmdldCAoY2FjaGUgZW50cmllcyBpZiBJIHJlbWVtYmVyIGNvcnJlY3Rs
eSkuIFdlDQo+IG1heSBoYXZlIGEgY291cGxlIHRob3VzYW5kcyBjYWNoZSBlbnRyaWVzLiAgV2Ug
YWxyZWFkeSBkZWFsIHdpdGggYSBjb3VwbGUNCj4gbWlsbGlvbiBvZiBzdHJ1Y3Qgb2JqZWN0Lg0K
DQpUaGUgd29yayB0byBtb3ZlIGNhY2hlIGVudHJ5IGFsbG9jYXRpb24gb250byBhIG1lbW9yeSBw
b29sIHdhcyBtb3RpdmF0ZWQgYnkNCnRoZSBmYWN0IHRoYXQgd2UgYXJlIGxvb2tpbmcgYXQgaW5k
ZXhlcyB3aXRoIG1pbGxpb25zIG9mIGVudHJpZXMuIElmIHRoZXJlIGlzIHNjYWxpbmcNCmNvbmNl
cm4gd2l0aCB0aGUgY3VycmVudCB2ZXJzaW9uIG9mIG1lbS1wb29sLCB3ZSB3b3VsZCBsaWtlIHRv
IGFkZHJlc3MgaXQgdGhlcmUNCmFzIHdlbGwuIE9yIGlmIHRoZXJlIGlzIGltcHJvdmVtZW50cyB0
aGF0IGNhbiBiZSBzaGFyZWQsIHRoYXQgd291bGQgYmUgbmljZSBhcyB3ZWxsLg0KDQo+IC0tDQo+
IER1eQ0K
