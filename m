Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6EC1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeDQQet (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:34:49 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:2128
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754127AbeDQQen (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P78WF6l3CwMNGT77hr6BOPJ+Q7R97c1UHIFeZaxAfSo=;
 b=Q3cmCHlV5lAJA4EEJMYoCJGb7iKd+Z5tyjBep5QgDBBmQECuvjgXxCWlMPaO1sx46hBqeqt+RgVldn+n7IbSIKakDNlacBOAes6lKF3VbG3yrymplUmpRtE0ZSJVBV9CEXuTqczcD8OfPd0NKYeJrAhnebI4TQ343AMPO8pQtJk=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 16:34:40 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 16:34:40 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v1 0/5] Allocate cache entries from memory pool
Thread-Topic: [PATCH v1 0/5] Allocate cache entries from memory pool
Thread-Index: AQHT1mn66C+jyweZV0SsXfcexF58UKQFJu2A
Date:   Tue, 17 Apr 2018 16:34:39 +0000
Message-ID: <20180417163400.3875-2-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:stN6SliJAKqp5FOdoFd8WBSpjSX6fEYEGJ71UcahAjEep2M5THxLZJMYoMnFSWVEWWl0XcgDzull+rdJcsVdANAJCnJ1fBzc+NY+e1+qhO6MdxVz/NWBRiKFtpIDRLB5PCp11HLkAzvpMh0uTZTmxIT9wAjXTnTOPbc0zEddLRmAy7sAj4GOHD25LPMvThw2WiNe9xaHXo0Btp13qNZk3ZiqL1MruB7rWysd8plv3yRzNvw/DQ+LgHvaZzZMvsZh;20:X8gySSmZurDDo1hjyMwrS/Tbp1rNTcMw2CZsPZSUJYFGxBEWTKzczfqqvbzzQKiBLShIaxro3VDlPS4ciNwrOOfZNsqEPN8X7JXPC1LswRoQpI2w48CinjupatEaAawODgtn7iz5RlPqKR2XBgl81xxyp6txpnPJB+4WAPZbAYM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10895A36F72BE8937A96BEB6CEB70@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(377424004)(199004)(189003)(7736002)(6116002)(5640700003)(2351001)(6306002)(14454004)(4001150100001)(6512007)(97736004)(8656006)(6486002)(53936002)(2906002)(4326008)(36756003)(5660300001)(106356001)(39060400002)(6436002)(107886003)(6916009)(305945005)(1076002)(3280700002)(99286004)(22452003)(478600001)(59450400001)(316002)(476003)(446003)(2616005)(486006)(54906003)(6506007)(5250100002)(11346002)(386003)(10290500003)(2900100001)(3660700001)(81166006)(81156014)(1730700003)(86362001)(966005)(8676002)(8936002)(10090500001)(186003)(68736007)(25786009)(46003)(86612001)(52116002)(76176011)(102836004)(105586002)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WIlPkGRYByAfezq/t6iu8CK8QXcBvmiE4lH+df6bYMqpeOwOjUKT8rFTdiLYFQnHJ8JI5ROW93p9b1sSnsi+3or55+6mUG/ZBVra7PryOm+FNCwo12etllKtiqz5rXVwuiJcI3EqsZ5xIMpNRjIFnls6DjYkUGlM365KHalzm6gOZfGm+llTQahylDTuRxPv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8d94c9b5-ed92-4cfb-b368-08d5a4811d5b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d94c9b5-ed92-4cfb-b368-08d5a4811d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:34:39.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series improves the performance of loading indexes by
reducing the number of malloc() calls. Loading the index from disk is
partly dominated by the time in malloc(), which is called for each
index entry. This patch series reduces the number of times malloc() is
called as part of loading the index, and instead allocates a block of
memory upfront that is large enough to hold all of the cache entries,
and chunks this memory itself. This change builds on [1], which is a
prerequisite for this change.

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

Test                                       baseline [4]       block_allocat=
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


100K is not a large enough sample size to show the perf impact of this
change, but we can see a perf improvement with 1M and 2M entries.

For completeness, here is the p0002-read-cache tests for git.git and
linux.git:

git.git:

Test                                          baseline [4]     block_alloca=
tion
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

Test                                       baseline [4]      tcmalloc      =
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

[4] baseline commit: 8b026eda Revert "Merge branch 'en/rename-directory-det=
ection'"

Jameson Miller (5):
  read-cache: teach refresh_cache_entry to take istate
  Add an API creating / discarding cache_entry structs
  mem-pool: fill out functionality
  Allocate cache entries from memory pools
  Add optional memory validations around cache_entry lifecyle

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
 read-cache.c           | 229 +++++++++++++++++++++++++++++++++++++++------=
----
 resolve-undo.c         |   6 +-
 split-index.c          |  31 +++++--
 tree.c                 |   4 +-
 unpack-trees.c         |  27 +++---
 16 files changed, 476 insertions(+), 117 deletions(-)


base-commit: cafaccae98f749ebf33495aec42ea25060de8682
--=20
2.14.3


