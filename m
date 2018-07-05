Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084951F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeGEPWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 11:22:41 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:6368
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753186AbeGEPVA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 11:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr2WNl42eR4eafUB/hEl7kfU4sC629yfMxxvUEJ2uk0=;
 b=N91cof0FLFPYM7rmkg87Y24gXyDFg9YhYU9frih+HCxvQZHxE8ZizUIz4DuBS7gwPMP5oaV6+EpIC3RNHN7wL/0wLgJVdZoi/cGinmMe7QOeCLIcFd4iVtaExLS8Cqa1LX7xKczvqbrGn9v6E1lRDL87yvG9opFE9YdtAecEzRE=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0282.namprd21.prod.outlook.com (10.173.174.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.6; Thu, 5 Jul 2018 15:20:58 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.008; Thu, 5 Jul 2018
 15:20:58 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Stefan Beller <sbeller@google.com>
CC:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Subject: RE: [PATCH v6 2/8] read-cache: teach make_cache_entry to take
 object_id
Thread-Topic: [PATCH v6 2/8] read-cache: teach make_cache_entry to take
 object_id
Thread-Index: AQHUEj3KLFK9/ZY4YEax/9O0g9XTJaR8cTsAgARRE8A=
Date:   Thu, 5 Jul 2018 15:20:58 +0000
Message-ID: <DM5PR21MB0780A4D3EFECC8FAE2A031DACE400@DM5PR21MB0780.namprd21.prod.outlook.com>
References: <20180628135932.225288-1-jamill@microsoft.com>
 <20180702193745.8940-1-jamill@microsoft.com>
 <20180702193745.8940-3-jamill@microsoft.com>
 <CAGZ79kYDyGg8z5FiYNXWAr+wT3r6Qm2Y_hh=o7xEKRkonO8Jaw@mail.gmail.com>
In-Reply-To: <CAGZ79kYDyGg8z5FiYNXWAr+wT3r6Qm2Y_hh=o7xEKRkonO8Jaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-05T15:20:57.2067180Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:bdaa:4600:46be:9a02]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0282;7:G8bNOL0Q8dnTpf5d5D0pp0J0ODarSMsEUrZhtJqjph8nRRU1rowxhp3lkYxXhf3wNf90kzxuEqlhQHRGoLmscjg9S9Q8cifJ2Z7qB1qHsUpYegU7eeljdfEEiotJhMtF/2wl5we+5PVQZ8vmfXpcSeHgxjhkDWUHE8Lsf0ohQ6BV7wBGluvwSWoU533/2s6vJURZCY13HNbOwSdoBgg46qOXpHQ2xPGzOs2AhDx7BmDfhNV3s9/b3PL9j7D6FQUa
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00a415de-dbb4-4eed-6234-08d5e28ae8fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:DM5PR21MB0282;
x-ms-traffictypediagnostic: DM5PR21MB0282:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0282C0541D2E95958CDD0A6FCE400@DM5PR21MB0282.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231280)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0282;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0282;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(76176011)(4326008)(81166006)(8676002)(6246003)(39060400002)(9686003)(7736002)(305945005)(53936002)(46003)(93886005)(6506007)(6116002)(68736007)(2906002)(81156014)(86362001)(186003)(102836004)(25786009)(74316002)(256004)(7696005)(8936002)(55016002)(5250100002)(86612001)(105586002)(106356001)(5660300001)(8990500004)(6436002)(476003)(10090500001)(486006)(10290500003)(22452003)(33656002)(478600001)(99286004)(6916009)(14454004)(316002)(97736004)(229853002)(11346002)(446003)(2900100001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0282;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +qAG5I15zbvE0DlFU6Dnak3CP9eW3Bkbbb2mL5Xn7NEBeRsZT84IXKXmZY/jskBrM06ghEtQ12GOkjC3dpxHnhDZEFvMcc1Yi/iKrrvtZWIUUJnyhS2DurUlyjhzj3s74LSX0n71jfTN7RrCEE9AugZz31S79z6hUXQKa/McNbQGQFI3hmvOwv2L0HNIAt/LvsUP8rG5pT07x5PTGsLIGroNHwa5cvHaibTekOQgpwK0uhrM0Fh5eYPF1CK9+lzRdselgFqb/aOK2+WMiomVod1vX4kanIhw4sfBHLRBFY5ZBXn5QQjSI4XAGkkl+Osts8UocAbUQ018rwbNrxC1eC5Zp9ZzO7CXAMastQA+ycU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a415de-dbb4-4eed-6234-08d5e28ae8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 15:20:58.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0282
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiA+DQo+ID4gVGVhY2ggbWFrZV9jYWNoZV9lbnRyeSBmdW5jdGlvbiB0byB0YWtlIG9iamVjdF9p
ZCBpbnN0ZWFkIG9mIGEgU0hBLTEuDQo+IA0KPiBUaGlzIHJlcGVhdHMgdGhlIHN1YmplY3QgbGlu
ZT8NCj4gDQo+IFNpZ24gb2ZmIG1pc3NpbmcuDQoNClRoYW5rIHlvdSBTdGVmYW4gZm9yIHBvaW50
aW5nIHRoaXMgb3V0LiBUaGlzIGRvZXMgbm90IGFkZCBtdWNoIGluZm9ybWF0aW9uIHRvIHRoZSBz
dWJqZWN0IGxpbmUuIEkgY291bGQgY2xlYW4gaXQgdXAgaWYgSSByZS1yb2xsIHRvIGZpeCB1cCB0
aGUgbWlzc2luZyBzaWduIG9mZi4NCg0KSnVuaW8gLSB3b3VsZCB5b3UgbGlrZSBtZSB0byByZS1y
b2xsIHRoaXMgcGF0Y2ggc2VyaWVzIGFuZCBpbmNsdWRlIHRoZSBjb3JyZWN0IHNpZ24gb2ZmLCBv
ciB3b3VsZCB5b3UgYmUgYWJsZSB0byBjb3JyZWN0IHRoaXM/IEkgY2FuIGRvIHdoaWNoZXZlciBp
cyBlYXNpZXN0IGZvciB5b3UuDQo=
