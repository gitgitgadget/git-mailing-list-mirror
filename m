Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3841F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeDQRAT (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:19 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:35280
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753298AbeDQRAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RlYI1g6sqGU9e+HW8SuJjbRSoDw5vFInhZYiPoNagCQ=;
 b=J3iwWzjxG792Zp5oKoXITicDeydJN0tUiqsgcPORd8/e/uomjsu4kODCazXJ4OeG5TZCSIwazenScwFfcf3d457xZPXdQfUHBeZZCCP0vClM8UyBiRFUuXj0LzZeL1ueQBuHHFD2XYV7b0tu9VUaWzyItGDRk/oJc8im9da3wHA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1073.namprd21.prod.outlook.com (52.132.24.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:13 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:13 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 0/9] Compute and consume generation numbers
Thread-Topic: [PATCH v3 0/9] Compute and consume generation numbers
Thread-Index: AQHT1m2MEUkDbJoQ3EConclopBNUNg==
Date:   Tue, 17 Apr 2018 17:00:13 +0000
Message-ID: <20180417170001.138464-1-dstolee@microsoft.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
In-Reply-To: <20180409164131.37312-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1073;7:5PQLVvhnBFyIbVUCnsI3G1PmD+bTUPbF3BCHn9V7MMUh6I2v9mNSqkO283pRWwgxzN6iaOVgN9dCE47IYkjUaxWLiyW7dm3L2V00nz3rHtz27H67kYpglI6dZ3jNSiuCz62a527a1t7sVmfGOz5HhdryyH76OGQ1G+j/M/JJKIr6J13Skl/tRQ7NlZB8C9Pgoc1cg/Sl+Lk2NR/zWUTVm95A9a0gHYk4Em2yZFeF7Yd4I3Pg0r2YvSIsymociNlv;20:0IyBazcVjqQjH2UqHeTxueCHeOLTKQophRcc2xNIpVVmcbV1fJ9Y0xscsSQBekuy7ezLzTA5Za/lGdl4No/aHiBW+PrQ3BdyQqEFFGq4Wf2boIm3GZjUJw5LiYBW+pJn1k0k8nfo+mda3gWL2pJcnF70BHZ8OItA83wrTs9fid0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1073;
x-ms-traffictypediagnostic: BL0PR2101MB1073:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1073256862166428A58C3DF5A1B70@BL0PR2101MB1073.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501359)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1073;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(39380400002)(69224002)(189003)(199004)(6436002)(5640700003)(6916009)(54906003)(8676002)(8656006)(5660300001)(36756003)(81156014)(99286004)(81166006)(2501003)(5250100002)(1730700003)(2351001)(3280700002)(316002)(97736004)(86362001)(2616005)(2900100001)(1076002)(86612001)(478600001)(446003)(486006)(476003)(10290500003)(2906002)(25786009)(11346002)(46003)(6116002)(22452003)(107886003)(39060400002)(386003)(6506007)(4326008)(186003)(68736007)(76176011)(6512007)(52116002)(105586002)(10090500001)(6486002)(305945005)(106356001)(8936002)(59450400001)(102836004)(53936002)(3660700001)(7736002)(14454004)(7416002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1073;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: um9dqcld7Y3ZqKr+L7p4hsY+zhTriCgy8V+uyC6zoVQfN/Px7GNwLZnRsuNhpRU1quGVXyucZpYJpEiVkqt7fxDE/ZUMETEJwR9uINsGR71YfUr/lAVWGmWToRrqRj/v3ZgD+MUO8IZd4R0M3JKMbCFbKUgceU2h8O85h9plWizIs9ytZUF6jMCLs9qmc75x
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d2438b53-aaa5-4d24-e4d9-08d5a484af39
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2438b53-aaa5-4d24-e4d9-08d5a484af39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:13.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the help on v2. Here are a few changes between versions:

* Removed the constant-time check in queue_has_nonstale() due to the
  possibility of a performance hit and no evidence of a performance
  benefit in typical cases.

* Reordered the commits about loading commits from the commit-graph.
  This way it is easier to demonstrate the incorrect checks. On my
  machine, every commit compiles and the test suite passes, but patches
  6-8 have the bug that is fixed in patch 9 "merge: check config before
  loading commits".

* The interaction with parse_commit_in_graph() from parse_object() is
  replaced with a new 'check_graph' parameter in parse_commit_buffer().
  This allows us to fill in the graph_pos and generation values for
  commits that are parsed directly from a buffer. This keeps the existing
  behavior that a commit parsed this way should match its buffer.

* There was discussion about making GENERATION_NUMBER_MAX assignable by
  an environment variable so we could add tests that exercise the behavior
  of capping a generation at that value. Perhaps the code around this is
  simple enough that we do not need to add that complexity.

Thanks,
-Stolee

-- >8 --

This is the one of several "small" patches that follow the serialized
Git commit graph patch (ds/commit-graph) and lazy-loading trees
(ds/lazy-load-trees).

As described in Documentation/technical/commit-graph.txt, the generation
number of a commit is one more than the maximum generation number among
its parents (trivially, a commit with no parents has generation number
one). This section is expanded to describe the interaction with special
generation numbers GENERATION_NUMBER_INFINITY (commits not in the commit-gr=
aph
file) and *_ZERO (commits in a commit-graph file written before generation
numbers were implemented).

This series makes the computation of generation numbers part of the
commit-graph write process.

Finally, generation numbers are used to order commits in the priority
queue in paint_down_to_common(). This allows a short-circuit mechanism
to improve performance of `git branch --contains`.

Further, use generation numbers for 'git tag --contains), providing a
significant speedup (at least 95% for some cases).

A more substantial refactoring of revision.c is required before making
'git log --graph' use generation numbers effectively.

This patch series is build on ds/lazy-load-trees.

Derrick Stolee (9):
  commit: add generation number to struct commmit
  commit-graph: compute generation numbers
  commit: use generations in paint_down_to_common()
  commit-graph.txt: update design document
  ref-filter: use generation number for --contains
  commit: use generation numbers for in_merge_bases()
  commit: add short-circuit to paint_down_to_common()
  commit-graph: always load commit-graph information
  merge: check config before loading commits

 Documentation/technical/commit-graph.txt | 30 +++++--
 alloc.c                                  |  1 +
 builtin/merge.c                          |  5 +-
 commit-graph.c                           | 99 +++++++++++++++++++-----
 commit-graph.h                           |  8 ++
 commit.c                                 | 54 +++++++++++--
 commit.h                                 |  7 +-
 object.c                                 |  2 +-
 ref-filter.c                             | 23 +++++-
 sha1_file.c                              |  2 +-
 t/t5318-commit-graph.sh                  |  9 +++
 11 files changed, 199 insertions(+), 41 deletions(-)


base-commit: 7b8a21dba1bce44d64bd86427d3d92437adc4707
--=20
2.17.0.39.g685157f7fb

