Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7CE1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeDFTJe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:09:34 -0400
Received: from mail-sn1nam01on0123.outbound.protection.outlook.com ([104.47.32.123]:2304
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751329AbeDFTJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RxCkEj8aIj4dz6k0cwoo+VkrRfN4m0GcTewXdQQXYxI=;
 b=i76FfZtEO1HAhfJDJ5HSizBxaaJiSexv0tu0YH6jzFQL/HZvP5BC7YHkCFtdNGBDYkfObCFHHnTrA0Prg1AYMbog4O9ngw81TQrDDzepe/VyVpH46W/6xahbkMfx1FRESVsN/vrOTL1dDpXzzpsPTUFK0oPSC76LzJcgiquWpfM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1108.namprd21.prod.outlook.com (52.132.24.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Fri, 6 Apr 2018 19:09:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.000; Fri, 6 Apr 2018
 19:09:30 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
Thread-Topic: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
Thread-Index: AQHTzdrK493tjBKXsEi6gWTv7wRHPw==
Date:   Fri, 6 Apr 2018 19:09:30 +0000
Message-ID: <20180406190919.167092-1-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
In-Reply-To: <20180403120057.173849-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:400:4::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1108;7:aCVs45fl2nwula5T7/Bl5Wc3tVtZZD/RPtblajcvI2En7N7ET8xkAcLH81gQWW4CmuZCboET+qsH4PLMKCNQfARR7zGs/16kgMgIRsZ05LPACzSq+IEwjYTtGEvqixzn3Wg4g5Y10Sf93cluSNngtfvo1VGBlcuDDIwj1TnGz6s/qnud/FcqvN1xZ4hc2EVP9jw7Ozq45iObgw/CU7KyjLn406TIwYBnlL+KgNiB3VaLcX58BDDdIr5myvnAIXLc;20:+6myzbaVa0OI3z/6dC1rnqhPmkE3TR5FJk/U0pnEQoMMnRdzlkLLPRS1rAISmx6iE5VjaM3JvMaDlifEeFRRbH6ktt48O3IqCqK95DNtHXJe4vcWqq/ZpCGfJTBjfCTzVtsbbppyZCateBb5MzACnt7zehuhd6C9zKRbVnxuwdU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c7a7933-136a-431e-c773-08d59bf1ec49
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1108;
x-ms-traffictypediagnostic: BL0PR2101MB1108:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB110869D698F45323EF946BA1A1BA0@BL0PR2101MB1108.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1108;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1108;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(22452003)(105586002)(316002)(2906002)(2501003)(5250100002)(76176011)(59450400001)(25786009)(54906003)(3280700002)(106356001)(3660700001)(14454004)(102836004)(486006)(46003)(478600001)(52116002)(99286004)(4326008)(5660300001)(6506007)(386003)(2616005)(446003)(11346002)(10290500003)(476003)(86362001)(186003)(6486002)(2900100001)(97736004)(107886003)(39060400002)(5640700003)(6436002)(36756003)(8656006)(10090500001)(305945005)(7736002)(8676002)(6116002)(6916009)(53936002)(8936002)(1076002)(81166006)(1730700003)(86612001)(81156014)(6512007)(2351001)(68736007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1108;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +3DcnZTEe2wpFWfpbXjYJL7sscriNpfPyoANT7SUKvayzXcPThxuAc0aHr7nDEAx8A2gmx8iFruWZwwuVOHrdL/fmTKlEUgLCbiy3ZmdH1uTM1YHgO8GvleCMfCtC7aNqF7qKe1QtZpyfyurVY116ZjG21N0acHNRCAfjzPLKnGoQTBIlbNIEXHGkF5zl1hq0KG4yhqKDbsBSosRm6gaqgCKjWMiANdIR7gTle4HUUkt1CFFdl/zIkQDjmXdebzKSjLBgWXyuHCQKjbneSOQUD0otQrT0JXnifodHN11zS+r3tj36wIivCcE8Z6x2j92+PzSvk7toD+88AHMvl5HkzRiC6AmX/Ixw/KUgBNQ6cXC058MPmaASZYh0YPIFIfF/GVcgcSjZVkMZcxLbM0qI+LMrwx+xz78u2FiiueCAl8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7a7933-136a-431e-c773-08d59bf1ec49
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 19:09:30.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several commit-graph walks that require loading many commits
but never walk the trees reachable from those commits. However, the
current logic in parse_commit() requires the root tree to be loaded.
This only uses lookup_tree(), but when reading commits from the commit-
graph file, the hashcpy() to load the root tree hash and the time spent
checking the object cache take more time than parsing the rest of the
commit.

In this patch series, all direct references to accessing the 'tree'
member of struct commit are replaced instead by one of the following
methods:

        struct tree *get_commit_tree(struct commit *)
        struct object_id *get_commit_tree_oid(struct commit *)

This replacement was assisted by a Coccinelle script, but the 'tree'
member is overloaded in other types, so we first rename the 'tree'
member to 'maybe_tree' and use the compiler to ensure we caught all
examples. Then, contrib/coccinelle/commit.cocci generates the patch
to replace all accessors of 'maybe_tree' to the methods above.

After all access is restricted to use these methods, we can then
change the postcondition of parse_commit_in_graph() to allow 'maybe_tree'
to be NULL. If the tree is accessed later, we can load the tree's
OID from the commit-graph in constant time and perform the lookup_tree().

On the Linux repository, performance tests were run for the following
command:

    git log --graph --oneline -1000

    Before: 0.92s
    After:  0.66s
    Rel %: -28.3%

Adding '-- kernel/' to the command requires loading the root tree
for every commit that is walked. There was no measureable performance
change as a result of this patch.

This patch series depends on v7 of ds/commit-graph.

Derrick Stolee (4):
  treewide: rename tree to maybe_tree
  commit: create get_commit_tree() method
  treewide: replace maybe_tree with accessor methods
  commit-graph: lazy-load trees for commits

 blame.c                         | 18 +++++++++---------
 builtin/checkout.c              | 18 ++++++++++++------
 builtin/diff.c                  |  2 +-
 builtin/fast-export.c           |  6 +++---
 builtin/log.c                   |  4 ++--
 builtin/reflog.c                |  2 +-
 commit-graph.c                  | 27 +++++++++++++++++++++++----
 commit-graph.h                  |  7 +++++++
 commit.c                        | 18 +++++++++++++++++-
 commit.h                        |  5 ++++-
 contrib/coccinelle/commit.cocci | 30 ++++++++++++++++++++++++++++++
 fsck.c                          |  8 +++++---
 http-push.c                     |  2 +-
 line-log.c                      |  4 ++--
 list-objects.c                  | 10 +++++-----
 log-tree.c                      |  6 +++---
 merge-recursive.c               |  5 +++--
 notes-merge.c                   |  9 +++++----
 packfile.c                      |  2 +-
 pretty.c                        |  5 +++--
 ref-filter.c                    |  2 +-
 revision.c                      |  8 ++++----
 sequencer.c                     | 12 ++++++------
 sha1_name.c                     |  2 +-
 tree.c                          |  4 ++--
 walker.c                        |  2 +-
 26 files changed, 152 insertions(+), 66 deletions(-)
 create mode 100644 contrib/coccinelle/commit.cocci

--=20
2.17.0

