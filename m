Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0651F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbeGTRW5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:57 -0400
Received: from mail-eopbgr690101.outbound.protection.outlook.com ([40.107.69.101]:52345
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731939AbeGTRW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo4yxh6sRYU3YubHeKJURBN6BH1Y6z5UemJf3vAClLM=;
 b=OfF4Op+ltQGA0ITO1jntiDZK3/a9AeG9fSleEgDbQw7b74sgh8A47NZAL856KwX/Sxt6CuLFFYiu5PB5gYBff+MUmcC7lhvxr8it3rOStxmfY5RWZrgxOoPlX/YNpyu6teyllhM3uJLP067YypkkB8i/MpPL8OppIW/Qspcexf8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.1; Fri, 20 Jul 2018 16:33:00 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 00/18] Consolidate reachability logic
Thread-Topic: [PATCH v2 00/18] Consolidate reachability logic
Thread-Index: AQHUIEdSemqDJAjal068c7TOJ6Y3CA==
Date:   Fri, 20 Jul 2018 16:33:00 +0000
Message-ID: <20180720163227.105950-1-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;6:TkRwpobNBgMxn/4FCt7M5Ur5Z0aMHHoZWdLukbs7hJtiJBX6aIQ51RGQtQ8ljuJBIvgXwrJFAq+OrCakOq6Rz+00gxLNw1QRsNZe2S7i33NvmAC7U0DiazTqU12JEmRGswI1Cd3LUH7iZi1/jwtx3HrSedkomv+jNKtxE4O9xyxO1wnF3H994FtTqMIsT5oTJSv5JzSU3rSjxZrM4yNKdsytNMO3aMjEJbVAYKtVugxT5lcp1tjlcBhWLnKZCRPg+HyI0JGe5E2sYAt8D/VViYRDUD5muKsYZPCa+9OwTqFJXP4ZES9Fr7FtNI5aDHfh1pzyjXL2jfanEAHdVyNfMOkwRiwQvbVvTCZw4oIv/dmAZMuWqTQEgQl0uXamRx73/CXE+LzbamGdy3nfqnK+jWzjwsmrKZdmEtHlnRO2DCdyXLlpr9b1/LYB7Xwlzngt9NLneSGnyVu5G89bQc2ymA==;5:L9m+PciFLcefk4x2sPEYGhciMgnrQ34pbhU6J8znnVgvHJoKkOLe13JPtmGnnV3Ktkjen4JsvyJQw+Vr1hGAX3UkE++XPNfIygX68ZiRBEQopIPTe7XtaeuouKzjPSiwlnrEuM91qkkaGqS3FPhFLnzQa469GEXC6JrrcVtx2Vs=;7:iDEaqzkROgYFGhWtaklQEwkREb5lyxmMJ6dBRrL6l0Swlb1ZYcaPRZKm8C+KIwt+JHlNBs3n8chechILBqCUrQoFArzvsKuYt26+3VPVFUtC7j4/WbuKBEzEjZ+yMadF2ZSh8R34hj3uWgHk8SeDLBKN4tHScgGqnVkrAClUWy6o/G5v4HWNhbCV2C+bZlcYRtPljUs5HtdInWTBpjY2HxQKXmy/FohD40s3IRCMjjUxl3whHVvoRy2Pn6xb+7QV
x-ms-office365-filtering-correlation-id: b62098e4-0c62-4f88-53dc-08d5ee5e74d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096339FEEE426A4E10BDAD0EA1510@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(102836004)(446003)(11346002)(6116002)(7736002)(386003)(6506007)(105586002)(10290500003)(305945005)(97736004)(2616005)(476003)(106356001)(486006)(1076002)(53936002)(2501003)(186003)(81156014)(1730700003)(81166006)(8936002)(5250100002)(8676002)(86362001)(14444005)(256004)(86612001)(107886003)(46003)(6436002)(5660300001)(68736007)(2906002)(99286004)(14454004)(6486002)(25786009)(10090500001)(4326008)(54906003)(36756003)(6916009)(39060400002)(2900100001)(22452003)(478600001)(76176011)(6512007)(5640700003)(316002)(2351001)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wWjKA+1NHHFYTKenSLDXmfyluT0cdTb6sTIarCZVosLoGLuJgTp4I+DhzqlVjCcCgU9dg5k/fhE91D8MXnYDi0d2FP2QliPnB8BIxqYYLu5udPYBkH66yIyFqt+chPPyevyz+y/RmyqTJrLSZIo2xOsK3Xh8wP/0YL/US8d8RRQlb8/h9wjbGeQt1ON/xlwZC0aLHcTPHzuMtOatrRB8i63Ubxhuk3UfnvfLFBz1yo/rya0yu+9933GdF/OryNMGIEf0nZ0A0gr4n8dPC1x2azH/+XRxTlHEol8uzzE3rJqBKHDJnfI7uOUWGq1JlqfjFtOldkjxPmuUF5eFUxACYw8Ah2gvmxLzad8qAbeG5aQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62098e4-0c62-4f88-53dc-08d5ee5e74d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:00.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many places in Git that use a commit walk to determine
reachability between commits and/or refs. A lot of this logic is
duplicated.

I wanted to achieve the following:

Consolidate several different commit walks into one file
Reduce duplicate reachability logic
Increase testability (correctness and performance)
Improve performance of reachability queries
My approach is mostly in three parts:

I. Move code to a new commit-reach.c file.
II. Add a 'test-tool reach' command to test these methods directly.
III. Modify the logic by improving performance and calling methods with
similar logic but different prototypes.

The 'test-tool reach' command is helpful to make sure I don't break
anything as I change the logic, but also so I can test methods that are
normally only exposed by other more complicated commands. For instance,
ref_newer() is part of 'git push -f' and ok_to_give_up() is buried deep
within fetch negotiation. Both of these methods have some problematic
performance issues that are corrected by this series. As I discovered
them, it was clear that it would be better to consolidate walk logic
instead of discovering a new walk in another file hidden somewhere.

For the ok_to_give_up() method, I refactored the method so I could pull
the logic out of the depths of fetch negotiation. In the commit
"commit-reach: make can_all_from_reach... linear" I discuss how the
existing algorithm is quadratic and how we can make it linear. Also, we
can use heuristic knowledge about the shape of the commit graph and the
usual haves/wants to get some extra performance bonus. (The heuristic is
to do a DFS with first-parents first, and stop on first found result. We
expect haves/wants to include ref tips, which typically have their
previous values in their first-parent history.)

One major difference in this series versus the RFC is that I added a new
method 'generation_numbers_enabled()' to detect if we have a commit-graph
file with non-zero generation numbers. Using can_all_from_reach in
is_descendant_of is only faster if we have generation numbers as a cutoff.

V2 Update: The biggest material change in this version is that we drop the
method declarations from commit.h, which requires adding a lot of reference=
s
to commit-reach.h across the codebase. This change is in a commit on its ow=
n.
In addition, we have the following smaller changes:

* Use 'unsigned int' for the flag variables.

* Properly align the here-doc test input data.

* Use single rev-parse commands in test output, and pipe the OIDs through '=
sort'

* Check output of parse_commit()

* Update flag documentation in object.h

* Add tests for commit_contains() including both algorithms.

* Reduce size of "mixed-mode" commit-graph to ensure we start commit walks
  'above' the graph and then walk into the commits with generation numbers.

Thanks,
-Stolee

This series is based on jt/commit-graph-per-object-store

Derrick Stolee (18):
  commit-reach: move walk methods from commit.c
  commit.h: remove method declarations
  commit-reach: move ref_newer from remote.c
  commit-reach: move commit_contains from ref-filter
  upload-pack: make reachable() more generic
  upload-pack: refactor ok_to_give_up()
  upload-pack: generalize commit date cutoff
  commit-reach: move can_all_from_reach_with_flags
  test-reach: create new test tool for ref_newer
  test-reach: test in_merge_bases
  test-reach: test is_descendant_of
  test-reach: test get_merge_bases_many
  test-reach: test reduce_heads
  test-reach: test can_all_from_reach_with_flags
  test-reach: test commit_contains
  commit-reach: replace ref_newer logic
  commit-reach: make can_all_from_reach... linear
  commit-reach: use can_all_from_reach

 Makefile                |   2 +
 bisect.c                |   1 +
 builtin/branch.c        |   1 +
 builtin/commit.c        |   1 +
 builtin/fetch.c         |   1 +
 builtin/fmt-merge-msg.c |   1 +
 builtin/log.c           |   1 +
 builtin/merge-base.c    |   1 +
 builtin/merge.c         |   1 +
 builtin/pull.c          |   1 +
 builtin/receive-pack.c  |   1 +
 builtin/remote.c        |   1 +
 builtin/rev-parse.c     |   1 +
 commit-graph.c          |  18 ++
 commit-graph.h          |   6 +
 commit-reach.c          | 662 ++++++++++++++++++++++++++++++++++++++++
 commit-reach.h          |  77 +++++
 commit.c                | 358 ----------------------
 commit.h                |  29 --
 fast-import.c           |   1 +
 http-push.c             |   2 +-
 merge-recursive.c       |   1 +
 notes-merge.c           |   1 +
 object.h                |   4 +-
 pack-bitmap-write.c     |   1 +
 ref-filter.c            | 146 +--------
 remote.c                |  50 +--
 remote.h                |   1 -
 revision.c              |   1 +
 sequencer.c             |   1 +
 sha1-name.c             |   1 +
 shallow.c               |   1 +
 submodule.c             |   1 +
 t/helper/test-reach.c   | 130 ++++++++
 t/helper/test-tool.c    |   1 +
 t/helper/test-tool.h    |   1 +
 t/t6600-test-reach.sh   | 242 +++++++++++++++
 upload-pack.c           |  58 +---
 38 files changed, 1177 insertions(+), 631 deletions(-)
 create mode 100644 commit-reach.c
 create mode 100644 commit-reach.h
 create mode 100644 t/helper/test-reach.c
 create mode 100755 t/t6600-test-reach.sh

--=20
2.18.0.118.gd4f65b8d14

