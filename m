Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF871F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966313AbeF1OMP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:12:15 -0400
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:31628
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965894AbeF1OMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhhcNQEi7yB/5uXl3dTCwWvevp8VwP90C10JF86fIho=;
 b=hOZjrNagIV4vZMUNPJqDcBj/2j4G4gjz2PZE8V66818Wlq1+PDDZ1F60oiOdQ7skLw9QCg9szDiSiYFCzykXIpDlk17ZSVOrQLO33ecXWaffXdPg+efIJHTdGQYkXiXuBvMyFEcjZNPy7MVtWYvMymsYNBh1os0nG4fDQ+ul32k=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0778.namprd21.prod.outlook.com (10.173.172.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:12:12 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:12:12 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Stefan Beller <sbeller@google.com>
CC:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Subject: RE: [PATCH v4 3/8] mem-pool: only search head block for available
 space
Thread-Topic: [PATCH v4 3/8] mem-pool: only search head block for available
 space
Thread-Index: AQHUCNO1rafalOyaE0mVB/U/f+pp4qRrPXKAgAqDiFA=
Date:   Thu, 28 Jun 2018 14:12:12 +0000
Message-ID: <DM5PR21MB07803918120F4CC5B340230ACE4F0@DM5PR21MB0780.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180620201557.77155-1-jamill@microsoft.com>
 <20180620201557.77155-4-jamill@microsoft.com>
 <CAGZ79kbL5wjJvKj-=gtGgtMFCPs+zTwSAV-Aeo_2GNC_h=1nNA@mail.gmail.com>
In-Reply-To: <CAGZ79kbL5wjJvKj-=gtGgtMFCPs+zTwSAV-Aeo_2GNC_h=1nNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-28T14:12:10.5654291Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:e2c7:22eb:b533:fb94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0778;7:UlDqsN5xeQr1YNCq3RrsnOGfML/ZXbvm6gcfEgYG2EmBS3Fn0crFf4Wk6p93Yo3u656ezZRGxltOYF+nrrbuC7DUlqw8y7mLfGhXVtLuhKJCl6QgVwA0a1d4MpP91FZXLxapSntgqK960m4QBbHNwvkDnUhICMGAAhagilktB6KDfewmq2ofUfs8Pnsk/3HRP3FFmS/Ma6B3IPj/yvWxAUwBr52Un3qi2SfT9q+uvEKM1LSBd/aA940Ah3uYWiGo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 817db4d6-6e62-4746-e09d-08d5dd0124cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0778;
x-ms-traffictypediagnostic: DM5PR21MB0778:
x-microsoft-antispam-prvs: <DM5PR21MB077821AA82A2E4587519C746CE4F0@DM5PR21MB0778.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0778;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0778;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(8936002)(186003)(86612001)(93886005)(102836004)(46003)(81156014)(81166006)(8676002)(105586002)(106356001)(10290500003)(14454004)(478600001)(33656002)(97736004)(6916009)(76176011)(6506007)(2906002)(7696005)(6346003)(6116002)(229853002)(55016002)(6246003)(5660300001)(53936002)(25786009)(39060400002)(10090500001)(446003)(476003)(11346002)(14444005)(256004)(486006)(9686003)(4326008)(305945005)(86362001)(2900100001)(99286004)(74316002)(54906003)(7736002)(68736007)(22452003)(8990500004)(316002)(5250100002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0778;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: UrwLF+HRMsR72sv69zQ/K7Kfj+T6DzE6uDPDuXBuJowZ7e4+eZZkqEILBV0cF+gTwzFYuWO/o/Uer1RqUiuhFnwEVbBPO+Y+UKnqdGojNTSuXNvN79oXTGw1JzLlJhRaHmG60XIHjzUmwaf8+HCuzFcqT8Mgf2GQ9DMBiTy8MyAF6MSYWBTW0TUi90yTo5ZR7gMlgaI3/UC6b8pE6+/gjOe91Qf5rfTnjHGRoSxJR+ITPyMgw9BT01KVq22b/EpkT2BHrv5EDwUerVE5kRMwDhbpcFMnsQwm8PdQuhKi1MeUePA/o5zN6Em1ndkhBQU+Jk0zitk5CF32yzyJaKiMuO4Q5bBImVWH6FbWDhjRhpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817db4d6-6e62-4746-e09d-08d5dd0124cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:12:12.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0778
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBEbyB3ZSBoYXZlIGFueSBudW1iZXJzIG9uIHBlcmZvcm1hbmNlIG9yIG1lbW9yeSBwcmVzc3Vy
ZSBoZXJlPw0KPiAoSSB3b3VsZCB0aGluayBiZW5jaG1hcmtpbmcgZmFzdC1pbXBvcnQgd291bGQg
c3VmZmljZSBhcyB0aGF0IGlzIHdoZXJlIHRoZSBtZW0NCj4gcG9vbCBvcmlnaW5hdGVkKQ0KDQpJ
IHJhbiBmYXN0LWltcG9ydCBvbiB0aGUgZ2l0LmdpdCBhbmQgbGludXguZ2l0IHJlcG9zaXRvcmll
cyAtIHRoaXMgYWN0aW9uIHJlcG9ydHMgdGhlIA0Kb3ZlcmFsbCBtZW1vcnkgYWxsb2NhdGVkIHRv
IHBvb2xzLiBUaGUgb3ZlcmFsbCBtZW1vcnkgdXNlZCBieSBwb29scyBkaWQgbm90IGNoYW5nZQ0K
aW4gbXkgdGVzdHMgKGdpdC5naXQgdXNlZCAyIGJsb2NrcywgYW5kIGxpbnV4LmdpdCB1c2VkIDEy
IGJsb2NrcykuIEkgaW5jbHVkZWQgdGhpcyBpbmZvcm1hdGlvbg0KaW4gdGhlIGNvcnJlc3BvbmRp
bmcgY29tbWl0IG1lc3NhZ2UuDQoNCj4gDQo+ID4gVGhpcyBwYXR0ZXJuIHdpbGwgYmVuZWZpdCBj
b25zdW1lcnMgdGhhdCBhcmUgYWJsZSB0byBnZW5lcmF0ZSBhIGdvb2QNCj4gPiBlc3RpbWF0ZSBm
b3IgaG93IG11Y2ggbWVtb3J5IHdpbGwgYmUgbmVlZGVkLCBvciBpZiB0aGV5IGFyZSBwZXJmb3Jt
aW5nDQo+ID4gZml4ZWQgc2l6ZWQgYWxsb2NhdGlvbnMsIHNvIHRoYXQgb25jZSBhIGJsb2NrIGlz
IGV4aGF1c3RlZCBpdCB3aWxsDQo+ID4gbmV2ZXIgYmUgYWJsZSB0byBmdWxmaWxsIGEgZnV0dXJl
IHJlcXVlc3QuDQo+IA0KPiBXb3VsZCB0aGlzIGJlIGEgZ29vZCBjYW5kaWRhdGUgdG8gY29udGFp
biBwYXJ0cyBvZg0KDQpJIGluY2x1ZGVkIHRoZXNlIGRldGFpbHMgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlIHRoYXQgYWRkcyB0aGUgZmllbGQgaW5kaWNhdGluZyB0aGUNCmNhY2hlX2VudHJ5IHdhcyBh
bGxvY2F0ZWQgZnJvbSBhIG1lbS1wb29sLg0K
