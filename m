Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7EE61F597
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966329AbeF1OAF (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:05 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:54048
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966094AbeF1OAE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRc8Ham4ymLAHZSKmgCuvNnN9S8Qa5ogFbkFSIs5mjg=;
 b=hxRw+LvMa50gNYBdDTQfeN8JJTQL9ZwFnYHb704HsKSy5pbFSn7eCbqYRzmI6KCkxyOOjyrJ7dJhob2cU/+Zh9MGhXHo7NyY6jIFcUWXuuylM79Qgbd9lPezNHlsFPu03C8aXeBRodssAOPQTyk82GbdIfir8rviehvZlEYEseE=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.5; Thu, 28 Jun 2018 14:00:02 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:02 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 0/8] Allocate cache entries from mem_pool
Thread-Topic: [PATCH v5 0/8] Allocate cache entries from mem_pool
Thread-Index: AQHUDuhPE0xng4CVAUm6UCGBT58AGQ==
Date:   Thu, 28 Jun 2018 14:00:02 +0000
Message-ID: <20180628135932.225288-1-jamill@microsoft.com>
References: <20180620201557.77155-1-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:405:6f::12) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0137;7:mGZnoMusPoe3emllBKhuK+0QGuyCWBH/ZBL49+X8HOr7RsTnUD+KHX5PK4AFx2RSHvDuQlVhWnrqwwPfkwrDnJH2E9U9B5EqoWQlXpMn+pl6PvSBvuMlfocYCtpgkR7t2wxGXAKUFl7bHvslqGPKhukoJpKGHR39Q2k3fYI64s8mFkcOLHHuHcptqzbErzS0ge7FtSRBU2p2woCVVRFT9Rb+3qbYUCD7E94Xi/7zubReC4HUiUBpvh4gg5lAIrbC
x-ms-office365-filtering-correlation-id: 7a4c53d3-da41-4f9d-ea9c-08d5dcff7184
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0137;
x-ms-traffictypediagnostic: DM5PR21MB0137:
x-microsoft-antispam-prvs: <DM5PR21MB0137EC1EC5CBB79AD26F5927CE4F0@DM5PR21MB0137.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0137;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0137;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(54906003)(86612001)(6306002)(25786009)(4326008)(10090500001)(6862004)(106356001)(256004)(39060400002)(14444005)(105586002)(53936002)(6512007)(6436002)(6486002)(36756003)(5660300001)(7049001)(2900100001)(97736004)(486006)(476003)(2616005)(11346002)(446003)(68736007)(81156014)(81166006)(8676002)(7736002)(305945005)(6200100001)(6116002)(1076002)(14454004)(966005)(8936002)(2906002)(316002)(22452003)(52116002)(99286004)(1511001)(5250100002)(37006003)(6506007)(102836004)(386003)(10290500003)(6346003)(46003)(575784001)(86362001)(478600001)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0137;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: 1aKpbMyWGbZPOAMfDDGH11l4GO3YdaRndauETzTX6GxSFr8wCf6P7qxYHFzKPystSeC15T/IddpW9YxxX85w/DMwnOQMvrl0NsypZsMFrjAWMaKd0ATDHc0moW1TsriZr4DbFCF1Kou8h7tbYo8QRjGUWWKDIEJyBzhpUYytTpt7daNJMhGe5j34ERTBj+3tyjJRHv2Div1mz8JZ2bu8aNEgvHn8248+gjd2aNw9io/BnTWbqTHziioHKxqBXSYqUkFVjRJMi4jKHEpkokLx5s2/h0/FxraJj2cjfXkqGNQfST88HvJcD4K1D3kUFqN8jQR5m09cSrdEvI1ymBsxvYBQhILS6IJgGUuSdjlT5lA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4c53d3-da41-4f9d-ea9c-08d5dcff7184
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:02.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0137
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v4 are minor code review feedback items:

  - Remove extern keyword from new function definitions in cache.h
  - Make_cache_entry(..) functions work with object_id instead of sha
  - Add details to commit message for "block alloc: allocate cache entries =
from mem_pool"
  - Add details to commit message for "mem-pool: only search head block for=
 available space"

The largest change is the new commit "read-cache: make_cache_entry should t=
ake object_id struct"

Base Ref: master
Web-Diff: https://github.com/jamill/git/compare/ed843436dd...55c9b9008f

Jameson Miller (8):
  read-cache: teach refresh_cache_entry() to take istate
  read-cache: make_cache_entry should take object_id struct
  block alloc: add lifecycle APIs for cache_entry structs
  mem-pool: only search head block for available space
  mem-pool: add life cycle management functions
  mem-pool: fill out functionality
  block alloc: allocate cache entries from mem-pool
  block alloc: add validations around cache_entry lifecyle

 apply.c                |  24 ++--
 blame.c                |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/difftool.c     |   6 +-
 builtin/reset.c        |   2 +-
 builtin/update-index.c |  26 ++--
 cache.h                |  64 +++++++++-
 git.c                  |   3 +
 mem-pool.c             | 114 ++++++++++++++++--
 mem-pool.h             |  23 ++++
 merge-recursive.c      |   4 +-
 read-cache.c           | 264 ++++++++++++++++++++++++++++++++++-------
 resolve-undo.c         |   4 +-
 split-index.c          |  58 +++++++--
 tree.c                 |   4 +-
 unpack-trees.c         |  40 ++++---
 16 files changed, 515 insertions(+), 134 deletions(-)


base-commit: ed843436dd4924c10669820cc73daf50f0b4dabd
--=20
2.17.1


