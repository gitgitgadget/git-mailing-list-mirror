Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227AD1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeHTVk7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:40:59 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:15584
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbeHTVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ckjpZtlMa0SfTZ6xqOrYZJooklyVZXKFxPlsTUZcBk=;
 b=SeeLuznH43l+2qV3AekAdAMjheLp4DH4WhvDr2R3FeUq0gh7XuRzKuWTmOfBQ5JDlBQqycZRhND4N6A8XIu9pUrEj7cI90RYHjE4XBZEzSG26AglVscUIBgxxpa6Cmx0VmpWDiSmF9ojQ6pmcWn8XE4VxEUHPbcsyFQxM4QNQY4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.1; Mon, 20 Aug 2018 18:24:14 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:14 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow
 incompatibilities
Thread-Topic: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow
 incompatibilities
Thread-Index: AQHUOLL/wXdTQ43BA0O8ps/Rr4RodA==
Date:   Mon, 20 Aug 2018 18:24:14 +0000
Message-ID: <20180820182359.165929-1-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;6:biEYc1DDNIn1USBNABiRFcrHl2XAGZ4lR97XjdNNbVhwlaHRRRG4PoL1L0RPu3rMkmoTAW16W+uVQ/5a/BOhtomsWZq3gi/RtAFxYWpx4TXFV3rA6VaRjy3YbtNek2JKDhSTgTOzV4f/qxqp8jVxbsE6+FUyCukt9nBrQoo9zz73SZ/7sxFT9Dm4L0naRfdRkiuIEm8RV2XtuqGd/XD5ijDuriesCJz/LQBdYI270Mx7yWFdGclMTKDBCuIIdPKspmiKG0gDJjuTMhUQNziyuRoFyFlohhWDgRwaAMl2JxDEG5dImOlDTrsET1lta2mlQtRQ8cPogLqyAFrlKqokwAjHWxpTbbGGXt5tRyHNri0bkkmBB92SuhOSlhaelFQHPZ11O+mH0MnkND5rJwPVan7lAs4yYMUOSVHYQZjmjnhHy9OQjRPYFl9IEMXcPXxGUz3jDpNcqelCTky4ki+jHg==;5:f/4NMwkULKHrQbXhjT+7WDJ7BRx68hOOlpJbM784c6A+DWCXlLrjcscMWsvU+bt7AonM+KCcFsw9QTcYCXLya3XwX6nfQS7T0+G/xb7L6rNRVTyG9zHd8UvOtSfgPElH01cGZbUV/pPEJunOhuT754R6lbWGqenvdvUMsaBX9GU=;7:H47r3EdvctV/qFF24V2iuB0oSEG/IdTS10uLSZWZtRv/QfgSeYRt+O3RdPj4cRTwiHukUbMPhyeFJZ4vsE3jq7b26T/pK7k7ij0Ris2U7hTMU9qCHBWsdSbIXMRwWSikX+2GvpKznD1mtVLmnrwYAOfJItm6LUnLMTolljfgu4+YYlIFuuloGoW3SST8kGxRJ+jLVJzggAV9UWxQQHAaYZR1D7nOKmYNjTH8Oif/JBR7GKEXoh/WpUrkZjQgkNSL
x-ms-office365-filtering-correlation-id: f377e3c8-6cfe-48f9-ddc1-08d606ca2196
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09951699E46C4D81F13C9F04A1320@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(1076002)(4326008)(8936002)(2616005)(105586002)(86362001)(6486002)(966005)(5640700003)(6436002)(106356001)(5660300001)(10090500001)(8676002)(11346002)(446003)(486006)(14454004)(39060400002)(305945005)(81166006)(86612001)(81156014)(10290500003)(7736002)(6916009)(1730700003)(478600001)(6116002)(107886003)(102836004)(25786009)(476003)(2906002)(46003)(68736007)(53936002)(6512007)(2900100001)(6306002)(5250100002)(2501003)(97736004)(2351001)(99286004)(22452003)(52116002)(14444005)(36756003)(256004)(76176011)(316002)(386003)(186003)(54906003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4gKZj/PYTirqE3q9SQ/87hjgls3qfWDm+MR1gjNb8nMrxDg7agP00jMk6bh/ORqxVScaWCwrGDORjw0MT8+YhORikK2Pv9xcHAG9TseHpa+pJZ8z0p9VjNqHTqvoDA4kXF8BftHfIpHPK++PuOEuUWtWxDNohUNQA+f3cn0o+N7vP3UtHgEBvWUTw8eYGsHByTSbIEb7Ri7ushYyc9KM4U5xEPti5hPPMy+1CYRoPTGhFmi+WVqoJmtb2iPDMgj1l27ndzi8Hf+0QiSrhInfcY7G1aWHv2bIXlWzAToZXnyzz8WrmKjLKWuyn/Le3zcZ6Aj0GP+7IGi6GjJ5pJcFuZNdrgaUbgaRcz3wMUNe9Nc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f377e3c8-6cfe-48f9-ddc1-08d606ca2196
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:14.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One unresolved issue with the commit-graph feature is that it can cause
issues when combined with replace objects, commit grafts, or shallow
clones. These are not 100% incompatible, as one could be reasonably
successful writing a commit-graph after replacing some objects and not
have issues. The problems happen when commits that are already in the
commit-graph file are replaced, or when git is run with the
`--no-replace-objects` option; this can cause incorrect parents or
incorrect generation numbers. Similar things occur with commit grafts
and shallow clones, especially when running `git fetch --unshallow` in a
shallow repo.

Instead of trying (and probably failing) to make these features work
together, default to making the commit-graph feature unavailable in these
situations. Create a new method 'commit_graph_compatible(r)' that checks
if the repository 'r' has any of these features enabled.

CHANGES IN V2:

* The first two commits regarding the ref iterators are unchanged, despite
  a lot of discussion on the subject [1].

* I included Peff's changes in jk/core-use-replace-refs, changing the base
  commit for the series to 1689c22c1c328e9135ed51458e9f9a5d224c5057 (the me=
rge
  that brought that topic into 'msater').

* I fixed the tests for the interactions with the graft feature.

Because of the change of base, it is hard to provide a side-by-side diff
from v1.

Thanks,
-Stolee

[1] https://public-inbox.org/git/CAGZ79kZ3PzqpGzXWcmxjzi98gA+LT2MBOf8KaA89h=
Oa-Qig=3DOg@mail.gmail.com/
    Stefan's response recommending we keep the first two commits.

Derrick Stolee (6):
  commit-graph: update design document
  test-repository: properly init repo
  commit-graph: not compatible with replace objects
  commit-graph: not compatible with grafts
  commit-graph: not compatible with uninitialized repo
  commit-graph: close_commit_graph before shallow walk

Stefan Beller (2):
  refs.c: migrate internal ref iteration to pass thru repository
    argument
  refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback

 Documentation/technical/commit-graph.txt | 18 +++++--
 builtin/commit-graph.c                   |  4 ++
 builtin/replace.c                        |  8 ++--
 commit-graph.c                           | 38 +++++++++++++--
 commit-graph.h                           |  1 +
 commit.c                                 |  2 +-
 commit.h                                 |  1 +
 refs.c                                   | 48 ++++++++++++++++---
 refs.h                                   | 12 ++++-
 refs/iterator.c                          |  6 +--
 refs/refs-internal.h                     |  5 +-
 replace-object.c                         |  7 +--
 replace-object.h                         |  2 +
 t/helper/test-repository.c               | 10 +++-
 t/t5318-commit-graph.sh                  | 60 ++++++++++++++++++++++++
 upload-pack.c                            |  2 +
 16 files changed, 194 insertions(+), 30 deletions(-)


base-commit: 1689c22c1c328e9135ed51458e9f9a5d224c5057
--=20
2.18.0.118.gd4f65b8d14

