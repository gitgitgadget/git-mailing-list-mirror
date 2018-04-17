Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645031F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbeDQQnF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:43:05 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:63456
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754415AbeDQQnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4B0LqFzv5C8M7nstHYU/J/xJPxuoyWWGAwAOcvP5qh0=;
 b=jnK4dW2j+v5QW/EWG9GfZKVtjgRutXP0U1nF3i6Jz2Pz7LYp2gogW+c/zjDzOcNqIaTvV2+hUGOGQXbbFKUcke/KtPYCxgj1fZxuTgQh4GSfXXK5WXeQiOXpCAD5VLaZX/jSi20zNSEprwhWO6/y8tx3kbg7db1hOJcWZL0H4bQ=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0916.namprd21.prod.outlook.com (52.132.23.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 16:43:01 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 16:43:01 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>
Subject: RE: [PATCH v4 0/3] Extract memory pool logic into reusable component
Thread-Topic: [PATCH v4 0/3] Extract memory pool logic into reusable component
Thread-Index: AQHT0cQzXrV3RyDdXkKxrOL4vNcsMqQFMZ6g
Date:   Tue, 17 Apr 2018 16:43:00 +0000
Message-ID: <BL0PR2101MB1106528350D2169FE22F3E4FCEB70@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
 <20180411183738.113809-1-jamill@microsoft.com>
In-Reply-To: <20180411183738.113809-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-17T16:42:59.1781385Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:65bf:4d22:3bed:8a3c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0916;7:rnPz9XcnRBwalgUpNHeLhkSXRf29uiGaIck9NEgQsV87DKD71oaSCDAn5TFX4QYUFqpdOMhuz5rETb2cTKzT0+ReLB4k+m5cEabGrDwr1FxCxLDI05I36SMn9x8vg6uQo3IBn6BLTaxgxTGuXQdqfqZ+Oz8CGjPAt4jgDed9EfBtmDKd1gldf5lPXIKteCanKA/VcPQIwMs3FOOx0f77AoM84BIX7aMjNty9C0UNVaAoIcTLzKPURgmHhb5kdo0l;20:kKSg9XOs7X6KDp08vVeBq8QBHQCXexOZxjEoU1GxmjACUIvQKZtEXw0sQhuxXCbYaKAEnhPpxzyKOz/HBu5CCl+AZJvpvs1Pa4fDdLvtRHdC2iip+rgoaHGtFPnOt4YsgZxFZJRWMVC/oKf98eXoSkhwQsdTOnlamfZGkBeE5RA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0916;
x-ms-traffictypediagnostic: BL0PR2101MB0916:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0916D61CD90731E0DF2B9759CEB70@BL0PR2101MB0916.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0916;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0916;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(13464003)(199004)(189003)(9686003)(6306002)(8990500004)(1730700003)(86612001)(55016002)(8676002)(10290500003)(81166006)(46003)(99286004)(81156014)(10090500001)(8656006)(102836004)(3660700001)(2351001)(97736004)(7736002)(3280700002)(6506007)(4326008)(53546011)(305945005)(74316002)(6246003)(33656002)(53936002)(76176011)(59450400001)(186003)(7696005)(106356001)(54906003)(86362001)(316002)(5660300001)(476003)(2906002)(14454004)(6916009)(25786009)(5250100002)(105586002)(6116002)(478600001)(966005)(8936002)(5640700003)(11346002)(229853002)(68736007)(2501003)(22452003)(2900100001)(446003)(6436002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0916;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: anW9ujovfVnXZ7RhFXFayo2jzeIyUTLkfKGblz6P1sQlrhwAQ8PrX5TjBkDXBIOF4bjxfXnIkE4fyFcswYUTri7bdU8G7n4tZKMYMdvRbf3fqe07CBhlkVro3l/Py7VTY2sl2Oa7jQh/i9Qz4LRuG4vQWOaS9lbSdVzElc+BJRk0FJBRLidaBrWomsXAfCK/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8a7dac37-d47e-45c8-ecdb-08d5a4824889
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7dac37-d47e-45c8-ecdb-08d5a4824889
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:43:00.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0916
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this version (V4) should reflect the latest round of feedback. Plea=
se let me know if there are any other questions or outstanding work to fini=
sh here.

I have submitted a patch series to have a second component use this memory =
pool [1].

Thank you

[1] https://public-inbox.org/git/20180417163400.3875-2-jamill@microsoft.com=
/

-----Original Message-----
From: Jameson Miller=20
Sent: Wednesday, April 11, 2018 2:38 PM
To: git@vger.kernel.org
Cc: gitster@pobox.com; peff@peff.net; sunshine@sunshineco.com; ramsay@ramsa=
yjones.plus.com; Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 0/3] Extract memory pool logic into reusable component

Thank you everyone for taking the time review and provide feedback on this =
patch series.

Changes from v3:

  - Based patch off of new commit, to resolve merge conflict.

  - Updated log message in 2/3 based on feedback.

  - Squashed patch from Ramsay Jones into 2/3 to fix warning from
    sparse.

  - Updated variable names in 2/3 to reflect updated usage of
    variable.

Jameson Miller (3):
  fast-import: rename mem_pool type to mp_block
  fast-import: introduce mem_pool type
  Move reusable parts of memory pool into its own file

 Makefile      |  1 +
 fast-import.c | 77 +++++++++++++------------------------------------------=
----
 mem-pool.c    | 55 ++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    | 34 ++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 61 deletions(-)  create mode 100644 me=
m-pool.c  create mode 100644 mem-pool.h

--
2.14.3

