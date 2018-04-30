Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF708215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeD3Pbn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:31:43 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:22710
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753980AbeD3Pbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LUwwojfh/Ff9Fb0sAqQUWsZCa7fAyy6SZxoA5rTcM6I=;
 b=JGbJRmSdmFXEl7qByTdFQPQhfNqGYZx3oz1d3goZFK8cK10wlSB29s+uDAF+JzrZ6DupcciaCzJgOQCPHHOokMr7auAGuhkEzyzCzLNU65xx8vCM9C5Y49Ltm5CqHfQH1/RfylPW/d7NUuvQFr8lS37HN+M/XLxKIHbBV2kk8iA=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Mon, 30 Apr 2018 15:31:40 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.002; Mon, 30 Apr 2018
 15:31:40 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 0/5] Allocate cache entries from memory pool
Thread-Topic: [PATCH v2 0/5] Allocate cache entries from memory pool
Thread-Index: AQHT4JhV0dzHRL+PVEGEkpV57EhR9w==
Date:   Mon, 30 Apr 2018 15:31:40 +0000
Message-ID: <20180430153122.243976-1-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN4PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:403:3::17) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:bN2H2eRGkJjRI4B/VlEdllxIikVM2JC5fLDJqZWKGOowStein4+jkkKeMoZoJryrv8t27ygqUE1hFLJ9umvQH/cY37p2v/gMCqK7Q07toeMeQLQYYc3l1RaWvLZGZFxFr8wI0/V/DXTEHFcAiOyZjVytLmoCHf55ffQeuF0DDPBvjKPyQzFJaCtWjRUvsISILKHjSV1JBwoxQmLdPj73d71hTPu0hraPR1kbOsdSg7EaKjetdWH4Z6keeLS/9cZT;20:w+tS2V1mah4oSE+iVhF/Bb2r/4vbXta5m/K7faIWwQYHnRtB2vmh0QTuabMp8GF9qFNSS4ikbUdWM1LaPM4eGFgGTDsT8P8relWkAsj8FXMSe6AbSmyMK0K704bf3ZSogYAfWh3CPo+5fBU1STzYdQHXpyOyPwDRIRtgkcFlVPE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10126B6CDB0632D66D4F4FCFCE820@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(366004)(396003)(377424004)(199004)(189003)(10090500001)(6506007)(966005)(3660700001)(386003)(59450400001)(1730700003)(7736002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8936002)(8676002)(186003)(3280700002)(476003)(2616005)(97736004)(446003)(11346002)(6116002)(86612001)(106356001)(46003)(99286004)(4326008)(102836004)(6916009)(105586002)(76176011)(1076002)(107886003)(2351001)(14454004)(4001150100001)(54906003)(2906002)(6512007)(2900100001)(53936002)(36756003)(5640700003)(10290500003)(316002)(25786009)(39060400002)(6306002)(8656006)(478600001)(68736007)(22452003)(5250100002)(486006)(6486002)(575784001)(86362001)(2501003)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0bky//DtZbOdqFZCI+BqIKyEP/I4VN1ZrgloUshiYKkDc2+uWBI54ZI9mVmmJa+ZmF8OnHLx88VmJjQbAgzipx2pkPCAfbwqAveG3jGFRnOobqSlefQuNmlcWcgj4QYNGTHOSkOMr8hfyVOuZBpBLe5be6UvAQjbKS+oY5qXr0XnViIcRE5uGswnV41VQGSd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2553afe1-454b-4181-4cb8-08d5aeaf77c4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2553afe1-454b-4181-4cb8-08d5aeaf77c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:31:40.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V1:

 - Based patch series off of commit in master

 - Minor updates based on initial code review feedback

Summary:

This patch series improves the performance of loading indexes by
reducing the number of malloc() calls. Loading the index from disk is
partly dominated by the time in malloc(), which is called for each
index entry. This patch series reduces the number of times malloc() is
called as part of loading the index, and instead allocates a block of
memory upfront that is large enough to hold all of the cache entries,
and chunks this memory itself. This change builds on [1].


Git previously allocated block of memory for the index cache entries
until [2].

This 5 part patch series is broken up as follows:

  1/5, 2/5 - Move cache entry lifecycle methods behind an API

  3/5 - Fill out memory pool API to include lifecycle and other
      	methods used in later patches

  4/5 - Allocate cache entry structs from memory pool

  5/5 - Add extra optional validation

Performance Benchmarks:

To evaluate the performance of this approach, the p0002-read-cache.sh
test was run with several combinations of allocators (glibc default,
tcmalloc, jemalloc), with and without block allocation, and across
several different index sized (100K, 1M, 2M entries). The details on
how these repositories were constructed can be found in [3].The
p0002-read-cache.sh was run with the iteration count set to 1 and
$GIT_PERF_REPEAT_COUNT=3D10.

The tests were run with iteration count set to 1 because this best
approximates the real behavior. The read_cache/discard_cache test will
load / free the index N times, and the performance of this logic is
different between N =3D 1 and N > 1. As the production code does not
read / discard the index in a loop, a better approximation is when N =3D
1.

100K

Test                                       baseline           block_allocat=
ion
 --------------------------------------------------------------------------=
----------
0002.1: read_cache/discard_cache 1 times   0.03(0.01+0.01)    0.02(0.01+0.0=
1) -33.3%

1M:

Test                                       baseline           block_allocat=
ion
 --------------------------------------------------------------------------=
----------
0002.1: read_cache/discard_cache 1 times   0.23(0.12+0.11)    0.17(0.07+0.0=
9) -26.1%

2M:

Test                                       baseline           block_allocat=
ion
 --------------------------------------------------------------------------=
----------
0002.1: read_cache/discard_cache 1 times   0.45(0.26+0.19)    0.39(0.17+0.2=
0) -13.3%

With 100K entries, it only takes 0.3 seconds to read the entries even
without using block allocation, so there is only a small change in the
wall clock time. We can see a larger wall clack improvement with 1M
and 2M entries.

For completeness, here is the p0002-read-cache tests for git.git and
linux.git:

git.git:

Test                                          baseline          block_alloc=
ation
 --------------------------------------------------------------------------=
-------------------
0002.1: read_cache/discard_cache 1000 times   0.30(0.26+0.03)   0.17(0.13+0=
.03) -43.3%

linux.git:

Test                                          baseline          block_alloc=
ation
 --------------------------------------------------------------------------=
-------------------
0002.1: read_cache/discard_cache 1000 times   7.05(6.01+0.84)   4.61(3.74+0=
.66) -34.6%=20


We also investigated the performance of just using different
allocators. We can see that there is not a consistent performance
gain.

100K

Test                                       baseline          tcmalloc      =
            jemalloc
 --------------------------------------------------------------------------=
----------------------------------------
0002.1: read_cache/discard_cache 1 times   0.03(0.01+0.01)   0.03(0.01+0.01=
) +0.0%     0.03(0.02+0.01) +0.0%=20

1M:

Test                                       baseline          tcmalloc      =
            jemalloc
 --------------------------------------------------------------------------=
----------------------------------------
0002.1: read_cache/discard_cache 1 times   0.23(0.12+0.11)   0.21(0.10+0.10=
) -8.7%     0.27(0.16+0.10) +17.4%

2M:

Test                                       baseline          tcmalloc      =
            jemalloc
 --------------------------------------------------------------------------=
----------------------------------------
0002.1: read_cache/discard_cache 1 times   0.45(0.26+0.19)   0.46(0.25+0.21=
) +2.2%     0.57(0.36+0.21) +26.7%



[1] https://public-inbox.org/git/20180321164152.204869-1-jamill@microsoft.c=
om/

[2] debed2a629 (read-cache.c: allocate index entries individually - 2011-10=
-24)

[3] Constructing test repositories:

The test repositories were constructed with t/perf/repos/many_files.sh with=
 the following parameters:

100K:	 many-files.sh 4 10 9
1M:	 many-files.sh 5 10 9
2M:	 many-files.sh 6 8 7

Base Ref: master
Web-Diff: git@github.com:jamill/git.git/commit/2152d28016
Checkout: git fetch git@github.com:jamill/git.git users/jamill/block_alloca=
tion-v2 && git checkout 2152d28016

Jameson Miller (5):
  read-cache: teach refresh_cache_entry() to take istate
  block alloc: add lifecycle APIs for cache_entry structs
  mem-pool: fill out functionality
  block alloc: allocate cache entries from mem_pool
  block alloc: add validations around cache_entry lifecyle

 apply.c                |  26 +++---
 blame.c                |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/difftool.c     |   8 +-
 builtin/reset.c        |   6 +-
 builtin/update-index.c |  26 +++---
 cache.h                |  40 ++++++++-
 git.c                  |   3 +
 mem-pool.c             | 136 ++++++++++++++++++++++++++++-
 mem-pool.h             |  34 ++++++++
 merge-recursive.c      |   4 +-
 read-cache.c           | 232 +++++++++++++++++++++++++++++++++++++++------=
----
 resolve-undo.c         |   6 +-
 split-index.c          |  31 +++++--
 tree.c                 |   4 +-
 unpack-trees.c         |  27 +++---
 16 files changed, 479 insertions(+), 117 deletions(-)


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
--=20
2.14.3


