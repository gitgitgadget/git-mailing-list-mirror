Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1FF1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeFAT4g (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:56:36 -0400
Received: from prvmx05.microfocus.com ([130.57.1.220]:11914 "EHLO
        prvmx05.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeFAT4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:56:35 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jun 2018 15:56:35 EDT
Received: from prvxcaht03.microfocus.com (Not Verified[137.65.248.137]) by prvmx05.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5b11a16f0000>; Fri, 01 Jun 2018 13:41:35 -0600
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (137.65.224.21)
 by mail.microfocus.com (137.65.248.137) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Fri, 1 Jun 2018 13:41:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-microfocus-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTwKfBKbcGzirdyOe8gHX8ALN3HuGGw6UxahDLUZZXM=;
 b=T1HM8w2GBvnBxg5MadNi1Osa4hDdDiuzLNf0DPCT6k+34Jydq/sODWlKDZmqCt9tdGswgmL9jGJQt12Awz9h4XZZa4HgfTNoB2xw7gvdLyis3bEtVg62aViFUj+tLy5V6uba5ERK8jrtaGHcXVuXDdVFTZdkaZnUMls8dWnKsTA=
Received: from MW2PR18MB2284.namprd18.prod.outlook.com (52.132.183.149) by
 MW2PR18MB2300.namprd18.prod.outlook.com (52.132.183.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.797.11; Fri, 1 Jun 2018 19:41:33 +0000
Received: from MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::3578:79db:ad07:8bce]) by MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::3578:79db:ad07:8bce%13]) with mapi id 15.20.0797.020; Fri, 1 Jun 2018
 19:41:33 +0000
From:   Isaac Chou <Isaac.Chou@microfocus.com>
To:     =?utf-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: RE: [PATCH v3] fast-export: fix regression skipping some
 merge-commits
Thread-Topic: [PATCH v3] fast-export: fix regression skipping some
 merge-commits
Thread-Index: AQHT2PTXTyCh0ZhfU0ya0Uk3uyTvrqQKk/G4gAA2+4CAQT7dwA==
Date:   Fri, 1 Jun 2018 19:41:33 +0000
Message-ID: <MW2PR18MB22845EE9631BB6586BA4E8E8E5620@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180420221231.4131611-1-martin.agren@gmail.com>
 <xmqqh8o5b4ww.fsf@gitster-ct.c.googlers.com>
 <CAN0heSqQckJT-4mHbwoP_XjbE2-UH8+k2nG6mnN76_t3nzO_xw@mail.gmail.com>
In-Reply-To: <CAN0heSqQckJT-4mHbwoP_XjbE2-UH8+k2nG6mnN76_t3nzO_xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [74.122.108.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR18MB2300;7:7LyyD8fnsOOgQZ6OARl9WZoVVIWXjZt7l97mwJtpK53l85WxUnSFVNJwkE8tqD4p6D8N3xvAW/cDf+IPt9xUZu0AhvNxDuLgNCFXL38toGwnR8urtnAuV3//6vKnR7l3qoOWWCHIo+B17I8XolCmBBpTTsNQPifKyOTmvcoNLY3yeI1myfQdC4H6riM55Yu+O9zqToOHOOGSy0ArAy7sLE+idTRHiAWprPMhrNV5vHgQ1lqBJjW5Up80hOTKmulU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR18MB2300;
x-ms-traffictypediagnostic: MW2PR18MB2300:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Isaac.Chou@microfocus.com; 
x-microsoft-antispam-prvs: <MW2PR18MB230006AAEDE7AA6C53C05C43E5620@MW2PR18MB2300.namprd18.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(85827821059158)(211936372134217)(153496737603132)(100324003535756);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR18MB2300;BCL:0;PCL:0;RULEID:;SRVR:MW2PR18MB2300;
x-forefront-prvs: 0690E5FF22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(13464003)(3660700001)(81166006)(9686003)(39060400002)(68736007)(8936002)(99286004)(105586002)(33656002)(25786009)(26005)(5660300001)(72206003)(86362001)(305945005)(76176011)(106356001)(5250100002)(3280700002)(81156014)(3846002)(6116002)(2906002)(74316002)(53936002)(8676002)(55016002)(8666007)(7736002)(6246003)(14454004)(2900100001)(66066001)(229853002)(478600001)(186003)(4326008)(6506007)(6436002)(446003)(93886005)(54906003)(7696005)(97736004)(8656006)(11346002)(110136005)(476003)(486006)(316002)(53546011)(102836004)(14547495005)(554374003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR18MB2300;H:MW2PR18MB2284.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microfocus.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mhpeMheLih51p+TZ3PqffLTYihLbTfh4KK8jxZLn2QYMYXobsOSadDwCHhhQjP8/u8F5KDrwhyxXkR4zCgoNOnr7aUhdJbrhLCTBy72lMc1RBr3JexRrQxo2v7YXcf9GQ7+APuLRvw+Mz8rotDRBx1A5QfKGWXPigF7g6UEdE56XZeEqI3bt3sF/5UHNTV5o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b7958537-bce2-462a-9708-08d5c7f7ae08
X-MS-Exchange-CrossTenant-Network-Message-Id: b7958537-bce2-462a-9708-08d5c7f7ae08
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2018 19:41:33.2347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2300
X-OriginatorOrg: microfocus.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sIEkgbmVlZCBoZWxwIG9uIHRoaXMgdG9waWMgYWdhaW4uICBJIG5lZWQgdG8gaW5mb3Jt
IG91ciBjdXN0b21lcnMgd2hhdCByZWxlYXNlIHRoaXMgaXNzdWUgd2lsbCBiZSBhZGRyZXNzZWQg
aW4uICBJIGNoZWNrZWQgdGhlIDIuMTcuMSBiaW5hcnkgcmVsZWFzZSByZWNlbnRseSBhbmQgZm91
bmQgdGhhdCB0aGUgZml4IGlzIG5vdCBpbmNsdWRlZC4gIENhbiBzb21lb25lIGhlbHAgbWUgd2l0
aCB0aGF0IGluZm9ybWF0aW9uIG9yIHBvaW50IG1lIHRvIGEgZG9jdW1lbnQgdGhhdCBJIGNhbiB1
c2UgdG8gZGV0ZXJtaW5lIGl0IG15c2VsZj8NCg0KVGhhbmtzLA0KDQpJc2FhYw0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFydGluIMOFZ3JlbiBbbWFpbHRvOm1hcnRpbi5h
Z3JlbkBnbWFpbC5jb21dIA0KU2VudDogU2F0dXJkYXksIEFwcmlsIDIxLCAyMDE4IDM6MDAgQU0N
ClRvOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+DQpDYzogR2l0IE1haWxpbmcg
TGlzdCA8Z2l0QHZnZXIua2VybmVsLm9yZz47IEpvaGFubmVzIFNjaGluZGVsaW4gPGpvaGFubmVz
LnNjaGluZGVsaW5AZ214LmRlPjsgSXNhYWMgQ2hvdSA8SXNhYWMuQ2hvdUBtaWNyb2ZvY3VzLmNv
bT47IEpvbmF0aGFuIFRhbiA8am9uYXRoYW50YW5teUBnb29nbGUuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gZmFzdC1leHBvcnQ6IGZpeCByZWdyZXNzaW9uIHNraXBwaW5nIHNvbWUgbWVy
Z2UtY29tbWl0cw0KDQpPbiAyMSBBcHJpbCAyMDE4IGF0IDA1OjQzLCBKdW5pbyBDIEhhbWFubyA8
Z2l0c3RlckBwb2JveC5jb20+IHdyb3RlOg0KPiBidXQgSSBkbyBub3QgdGhpbmsgdGhlIHVwZGF0
ZWQgImZpeCIgYmVsb3cgaXMgYmV0dGVyLiAgSXQgbWlnaHQgYmUgDQo+IGp1c3QgYWVzdGhldGlj
cyBhbmQgSSBzdXNwZWN0IEkgd29uJ3QgZmluZCBpdCBhcyBkaXN0dXJiaW5nIGlmIHdlIA0KPiBj
b3VsZCBwdXNoIHdpdGgNCj4NCj4gICAgICAgICBvYmplY3RfYXJyYXlfcHVzaChjb21taXRzLCAo
c3RydWN0IG9iamVjdCAqKWNvbW1pdCk7DQo+DQo+IG9yIHNvbWV0aGluZyB0aGF0IGlzIG1vcmUg
Y2xlYXJseSBzeW1tZXRyaWMgdG8gb2JqZWN0X2FycmF5X3BvcCgpLg0KPiBUaGUgIlF1ZXVlIGFn
YWluIiBjb21tZW50IGlzIG5lZWRlZCBvbmx5IGJlY2F1c2UgdXNlIG9mICJhZGQiDQo+IGhpZ2hs
aWdodHMgdGhlIGxhY2sgb2Ygc3ltbWV0cnkuDQo+DQo+IFdpdGggYWRkX29iamVjdF9hcnJheSgp
LCBpdCBsb29rcyBzb21ld2hhdCBtb3JlIG9kZCB0aGFuIHlvdXIgcHJldmlvdXMNCj4NCj4gICAg
ICAgICBwZWVrIGl0IHRvIGNoZWNrOw0KPiAgICAgICAgIGlmIChpdCBzaG91bGQgbm90IGJlIG1v
bGVzdGVkKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgIHBvcCB0byBtYXJr
IGl0IGNvbnN1bWVkOw0KPiAgICAgICAgIGNvbnN1bWUgaXQ7DQo+DQo+IHNlcXVlbmNlLCBpbiB3
aGljaCBwZWVrKCkgYW5kIHBvcCgpIHdlcmUgbW9yZSBvYnZpb3VzbHkgcmVsYXRlZCANCj4gb3Bl
cmF0aW9ucyBvbiB0aGUgc2FtZSAiYXJyYXkiIG9iamVjdC4NCj4NCj4gQW5kIEkgZG8gbm90IHRo
aW5rIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGludHJvZHVjZSBfcHVzaCgpIG9ubHkgZm9yIA0KPiBz
eW1tZXRyeSAoaXQgd291bGQgbWVyZWx5IGJlIGEgbGVzcyBjYXBhYmxlIHZlcnNpb24gb2YgYWRk
IHdob3NlIG5hbWUgDQo+IGlzIHNwZWxsZWQgZGlmZmVyZW50bHkpLiAgSGVuY2UgbXkgcHJlZmVy
ZW5jZSBmb3IgcGVlay1jaGVjay1wb3Agb3ZlciANCj4gcG9wLW9vcHMtcHVzaC1hZ2Fpbi1idXQt
cHVzaC1zcGVsbGVkLWFzLWFkZC4NCj4NCj4gTm90IHdvcnRoIGEgcmVyb2xsLCB0aG91Z2guICBJ
IGp1c3Qgd2FudGVkIHRvIHNwcmVhZCBiZXR0ZXIgZGVzaWduIA0KPiBzZW5zZSB0byBjb250cmli
dXRvcnMgOy0pDQoNClRoYW5rcyBmb3IgeW91ciB3aXNlIHdvcmRzLiA6LSkgT25lIHRoaW5nIHRo
YXQganVzdCBvY2N1cnJlZCB0byBtZSBpcyB0aGF0IGlmIHRoZSBvcmlnaW5hbCBzaXRlIHdoZXJl
IHdlIGBhZGRfb2JqZWN0X2FycmF5KClgIGFsbCBvYmplY3RzIHN0YXJ0cyBhZGRpbmcgYSBub24t
TlVMTCBgbmFtZWAgZm9yIHNvbWUgcmVhc29uLCB0aGVuIHdlIG5lZWQgdG8gcmVtZW1iZXIgdG8g
ZG8gdGhlIHNhbWUgd2l0aCB0aGlzIG5ldyBjYWxsZXIuIEkgc3VzcGVjdCB0aGF0IGF0IHRoYXQg
dGltZSwgYXQgdGhlIGxhdGVzdCwgd2Ugd2lsbCBiZSBzd2l0Y2hpbmcgdG8gcGVlay1jaGVjay1w
b3AuDQoNClRoYW5rcyBmb3Igc2hhcmluZyB5b3VyIHRob3VnaHRzLg0KDQpNYXJ0aW4NCg==
