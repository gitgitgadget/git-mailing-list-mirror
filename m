Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10B720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 18:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeLLSau (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 13:30:50 -0500
Received: from mail-eopbgr810045.outbound.protection.outlook.com ([40.107.81.45]:9120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727888AbeLLSau (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 13:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlIWi/B7rFDfu/61FR35tUEAiPE3+zdWxY0kIdsGjTI=;
 b=FIw3rkeGxtL+PNYeC/KJTkj26x69SeKVzKhvRGKI8nADb0q/kQ4IOrfiHYlKPDigFlkJt1zN/xbiJ2m5qg7F4fzMt6rZ5/iBFSH9gACEDSEiO/x2VvjnIqyXXa55AoqIcBgfNpHiShZJUSLphEctVbZzjt0aTlhC3NC8/LULAEg=
Received: from SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) by
 SN1PR12MB0656.namprd12.prod.outlook.com (10.163.208.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 18:30:47 +0000
Received: from SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693]) by SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 18:30:47 +0000
From:   "Iucha, Florin" <Florin.Iucha@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: RE: High locking contention during repack?
Thread-Topic: High locking contention during repack?
Thread-Index: AQHUkcZ+f0+V0Wt6CUuFEjrDC9wzQqV69toAgABaC1CAABTh8IAABuDA
Date:   Wed, 12 Dec 2018 18:30:47 +0000
Message-ID: <SN1PR12MB2384587486B6D10F2784CEB795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <20181212112409.GB30673@sigill.intra.peff.net>
 <SN1PR12MB23849A5B991FB7D9213FB64595A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <SN1PR12MB2384362EE5BA4980322931B795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2384362EE5BA4980322931B795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Florin.Iucha@amd.com; 
x-originating-ip: [165.204.24.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0656;20:LkRpyF9yoHg8L1p3QPy5bS+AtgQnUyiv4T49i38Jp6m6kCkFWLc1PTlRHcoXcfrBn2VRcoDxC5UL3dQ7GynywuWHQJwEt4kXr6UvlpYg3Iv8JHy+UWqvnJ2huTki1Mzb+lSh/auhMG0CumAM0p6safvLfXCR+YIReZVxfsC80/jLYckEt3KX/rSWc58fj+cJf23psp388X4AW832cq4NZgeY5qSQopB1kVhdvb31pdbwoceb+MEEs08gsIyi2RKq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c25675e6-9149-4b9a-9ba2-08d6605fefb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0656;
x-ms-traffictypediagnostic: SN1PR12MB0656:
x-microsoft-antispam-prvs: <SN1PR12MB0656803FE850469127B6C20595A70@SN1PR12MB0656.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0656;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0656;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(3846002)(99286004)(8676002)(9686003)(106356001)(4326008)(55016002)(39060400002)(6116002)(2351001)(105586002)(305945005)(6246003)(25786009)(97736004)(2940100002)(316002)(71190400001)(66066001)(54906003)(53936002)(33656002)(11346002)(476003)(486006)(6436002)(446003)(26005)(93886005)(72206003)(6916009)(7696005)(71200400001)(14454004)(74316002)(102836004)(93156006)(86362001)(478600001)(68736007)(2906002)(2501003)(229853002)(81156014)(5640700003)(186003)(7736002)(76176011)(256004)(6506007)(8936002)(5660300001)(1730700003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0656;H:SN1PR12MB2384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4zZomqt1l8vNlSrCuDmMccLZzeJ+gxzR+IePuY3gCxmzRba9m8JZQee3aHwofLI6q7qhlhKYEIlg1rDpb/WlU9pRaNAiK2kVGSL3g4mhOv2tYnmeSM+gkZUsrNHNpU8sURTE7wEVmASfjZnjtYFgDVC6Xy/xCY7HDsofGcoBIR9aVoBfJD5iuchP2Tjwd+DI21MgNdfFlqUAKs3FKlHRe/+m4RE5mpTHbE4qyGC4woKnIVA/+muq6hmmjJnBf89qqGHHoh0KbxsvtVvILQY8GEs+Y8/IJefKQgx4Zjx1z5z1uBgy/AuVdqi/N8Nkh3RD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25675e6-9149-4b9a-9ba2-08d6605fefb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:30:47.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0656
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SXQgc2VlbXMgdG8gYmUgc3BlbmRpbmcgYSBsb3Qgb2YgdGltZSBpbiBjcmVhdGVfZGVsdGEuIEkg
aGF2ZSBhZGRlZCBhIGJyZWFrcG9pbnQgb24gY2FsbGluZyBjcmVhdGVfZGVsdGEgYW5kIGEgZmV3
IGdvb2QgbWludXRlcyBwYXNzIGJldHdlZW4gdGhlIGJyZWFrcG9pbnQgYmVpbmcgaGl0LiBUaGUg
bGFyZ2UgbG9vcCBpbiBjcmVhdGVfZGVsdGEgaGFzIHByYWN0aWNhbGx5IG5vIG91dGdvaW5nIGZ1
bmN0aW9uIGNhbGxzIChzYXZlIGZvciB0aGUgcmVhbGxvYyBvbiBsaW5lIDQ3NiksIHNvIEkgc3Rp
bGwgZG9uJ3QgdW5kZXJzdGFuZCBob3cgZHN0YXQgY291bGQgcmVwb3J0IDAlIHVzZXIgdGltZS4g
aHRvcCBpbmRpY2F0ZXMgdGhlIHdvcmtlciB0aHJlYWRzIGFyZSB1c2luZyAxMDAlIENQVSB0aW1l
Lg0KDQpmbG9yaW4NCg==
