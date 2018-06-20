Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177071F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933140AbeFTUR1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:27 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:9494
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932742AbeFTUR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8WHOvDqaLg6JeJh2lW+Jy+iWs/PBS6cbwCGO9yN+0o=;
 b=NYisaTIYtPzMW2pi3XwZzLBql/KWITrVokNpS1pZ2mxPTK1NIPq3cqwgN0Huk+uRK83JQLPpmsc/979tYIOglwR+YJHsYvJiGzH7CHeCC1XEhMiYoWU1Er8mNTBoosTCnuyfWMRNpdNx6LwyinNdpCPe1iMlHD/vkUGb9FdS8IU=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0283.namprd21.prod.outlook.com (10.173.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.10; Wed, 20 Jun 2018 20:17:23 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:23 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 0/8] Allocate cache entries from mem_pool
Thread-Topic: [PATCH v4 0/8] Allocate cache entries from mem_pool
Thread-Index: AQHUCNOyQnqI2w+W4kSXAg+jIncjIQ==
Date:   Wed, 20 Jun 2018 20:17:23 +0000
Message-ID: <20180620201557.77155-1-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0283;7:1/UzeP4Mi/dSIPgjWUyaheQmvwLMa/S0qkOJWdlbr+iBOGrn5Y3mGoD0IRaUZJi19NF2WwZ7SdQkIObQDXU9rRIA5nPM3KUjq/w09eZE9m/+FKrqyRfIy5iRozdjBJTjd72Fnznm1ZFxDeP1OTAslI2qHhxwJuqZLhaXr1qEOAIJ26SVjwQ4DgnuwzhpdwTebVZRuiUMyXbb9ign+gLZK3pYbVShPOzO0l1sH7rRx+dBFqE43IkgaHrZNG60TkxK
x-ms-office365-filtering-correlation-id: 2f68cc52-962d-4461-d86e-08d5d6ead52c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0283;
x-ms-traffictypediagnostic: DM5PR21MB0283:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB028354E82C0FB2AE5637DF1BCE770@DM5PR21MB0283.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0283;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0283;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(189003)(199004)(102836004)(2906002)(186003)(3660700001)(476003)(11346002)(486006)(2616005)(446003)(36756003)(5660300001)(3280700002)(76176011)(6506007)(386003)(68736007)(6916009)(59450400001)(5250100002)(2351001)(2501003)(25786009)(52116002)(4326008)(39060400002)(8656006)(7736002)(6436002)(6486002)(6116002)(305945005)(2900100001)(316002)(106356001)(105586002)(22452003)(10090500001)(81156014)(1730700003)(8676002)(81166006)(54906003)(53936002)(86612001)(10290500003)(478600001)(8936002)(97736004)(86362001)(99286004)(14454004)(46003)(966005)(5640700003)(107886003)(6512007)(6306002)(1076002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0283;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PnrNxu3RVmJjSjnroXMOPMOiz0hlO7QUFqo8Hcr1B97BvOy8Q7u6OK1DEWuM+OjggXtQxyR+dQMs+Uf27MIO49qeovOGNvP97PKSXL6/k8+IuWOJSRuNUUjwmKFP1NswuiXieocMQbsLDIiEchW/ixHpAjOrSYEj/YXuYHT8A7vueS9zrWlvSddm1euQEp+f5iBIM3M+NgX0+jpNoXOtMYnRpxerKNgU2FWLFul6jMZB+y9x1IdmdBT/gH2mPOtOvm3q0NzJeS//FfL+ItqNiyWmG54X9ykMmmeJZJpPtbdfCaJkJQEJgKzDq4uQHnXrbPfKs3jiZgSgnYVf/amxnw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f68cc52-962d-4461-d86e-08d5d6ead52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:23.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0283
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V3:

Mainly changes from last round of feedback:

  - Rename make_index_cache_entry -> make_cache_entry

  - Rename make_empty_index_cache_entry -> make_empty-cache_entry

  - Remove tail pointer in mem_pool

  - Small code tweaks

  - More accurately calculate mp_block size for platforms that do not
    support flexible arrays


One thing that came up with my testing is that the current automated
tests do not fully cover the code path of "large" allocations from a
memory pool. I was able to force this condition by manually tweaking
some variables and then running the automated tests, but this is not
ideal for preventing regressions in the future.

One way I can think of testing this is to add a test-helper and
directly test the memory pool struct. This will allow me to control
the parameters and different conditions. I was hoping for some
guidance before I actually implemented these tests.

Either way, I would like to do the additional tests in a separate
patch series to have a more focused discussion. I am not sure if these
tests would prevent inclusion of this patch series - I am open to
guidance here.

Base Ref: master
Web-Diff: https://github.com/jamill/git/compare/242ba98e44...667b8de06c

Jameson Miller (8):
  read-cache: teach refresh_cache_entry() to take istate
  block alloc: add lifecycle APIs for cache_entry structs
  mem-pool: only search head block for available space
  mem-pool: tweak math on mp_block allocation size
  mem-pool: add lifecycle management functions
  mem-pool: fill out functionality
  block alloc: allocate cache entries from mem_pool
  block alloc: add validations around cache_entry lifecyle

 apply.c                |  24 +++--
 blame.c                |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/difftool.c     |   6 +-
 builtin/reset.c        |   2 +-
 builtin/update-index.c |  26 +++--
 cache.h                |  53 +++++++++-
 git.c                  |   3 +
 mem-pool.c             | 124 +++++++++++++++++++----
 mem-pool.h             |  23 +++++
 merge-recursive.c      |   4 +-
 read-cache.c           | 259 ++++++++++++++++++++++++++++++++++++++++-----=
----
 resolve-undo.c         |   4 +-
 split-index.c          |  58 ++++++++---
 tree.c                 |   4 +-
 unpack-trees.c         |  40 ++++----
 16 files changed, 504 insertions(+), 139 deletions(-)


base-commit: 242ba98e44d8314fb184d240939614a3c9b424db
--=20
2.14.3


