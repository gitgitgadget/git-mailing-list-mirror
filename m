Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716291F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755809AbeEaRkn (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:40:43 -0400
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:45240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755749AbeEaRkm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzVfkZFpSLRAfzsNGN+ssct9AcAu/BGUBLVeoLuug/Q=;
 b=FN5EC3OA0bNLKLt/MMbgf63H9dhPGHnOe9U8HbOwa5lCQ+QWxKDxns7YvkDhYga16Ar5M9Y/Z+0W2Ri6n+lJ4/JvYTZ9Cn025SmKC3ml1Q/m8mXkl8RCG46fxM373uEZM4i8q/MVqGYgRf0CcMuLgd0lP9rTblUoNhIEvKmjY+Y=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.6; Thu, 31 May 2018 17:40:39 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1%5]) with mapi id 15.20.0841.006; Thu, 31 May 2018
 17:40:39 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo
Thread-Topic: [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo
Thread-Index: AQHT+QZ9VNVWlgRJtkCMmb4/kEHCyg==
Date:   Thu, 31 May 2018 17:40:39 +0000
Message-ID: <20180531174024.124488-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:Ohzsx66RKCZ0x6f8DaqOxdMTqSQJgi/iy2aEx+2+7zvghIKs2WiwvMkNOSr0o6TjAfoRoaGzjbHVgm5Wh8nQxD6Q9lcSn7uwTnza4gdHxTK9W/EkPM7bkpk623RJmvvUpG3GVMomzbwUI9tizWQ4h7F09+vidgc7vdAKJsYiGsF2I8KzaOYG9elgEotIjybionk5+fKqsPc1E43gx+He/rpgn4IPBB+xYtkcjQVnvwFVdEtr3QQGdNkUm98p4j9S;20:bADEHh5Rt6ldCEBAlamzLxL3b+gR5sJaXVSI5rTdF0ixYDfciAZONC/H5Hc6Sd6I+nv9W11DgH/a/2LVHZ97NazPB+sv1Hwgu/+QzAaou70MnQbEvzvW4XgsRE3HSf4fLeCFtRMWhNxQWyTYH5UX3NYuQYWhD814eTS6y2aVHY8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09778BC1205AEE31340C0D9EA1630@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(39380400002)(376002)(189003)(199004)(5250100002)(2351001)(6512007)(10090500001)(97736004)(186003)(3660700001)(54906003)(68736007)(3280700002)(2900100001)(46003)(53936002)(86612001)(86362001)(6486002)(36756003)(6116002)(1076002)(478600001)(99286004)(14454004)(102836004)(316002)(2616005)(6506007)(25786009)(8936002)(305945005)(386003)(6916009)(6436002)(5660300001)(2906002)(81156014)(81166006)(476003)(5640700003)(8676002)(59450400001)(107886003)(22452003)(2501003)(1730700003)(486006)(52116002)(106356001)(7736002)(10290500003)(105586002)(39060400002)(4326008)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CpTl1OZSoKupm0p/U2CTqYGWAIlq442kCg6L/NCd4y/QpGo3zZvBKhBv6seDNyh+zvVRisopGSxyhtSJtzITsPvbYbI7l6seEvcWjc0wfy0cQDiGo2hJeFFX6yI5VBO1Pll3Q8W2XjTUz9zDp9M7DamFzOd6NR9mdzwzRKn56cZ/jRpfZMIkgAjNeKWt7HmE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d40abecc-a287-41bc-6883-08d5c71d9f9d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40abecc-a287-41bc-6883-08d5c71d9f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 17:40:39.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file stores a condensed version of the commit history.
This helps speed up several operations involving commit walks. This
feature does not work well if those commits "change" using features like
commit grafts, replace objects, or shallow clones.

Since the commit-graph feature is optional, hidden behind the
'core.commitGraph' config option, and requires manual maintenance (until
ds/commit-graph-fsck' is merged), these issues only arise for expert
users who decided to opt-in.

This RFC is a first attempt at rectify the issues that come up when
these features interact. I have not succeeded entirely, as I will
discuss below.

The first two "DO NOT MERGE" commits are not intended to be part of the
main product, but are ways to help the full test suite run while
computing and consuming commit-graph files. This is acheived by calling
write_commit_graph_reachable() from `git fetch` and `git commit`. I
believe this is the only dependence on ds/commit-graph-fsck. The other
commits should only depend on ds/commit-graph-lockfile-fix.

Running the full test suite after these DO NO MERGE commits results in
the following test failures, which I categorize by type of failure.

The following tests are red herrings. Most work by deleting a commit
from the object database and trying to demonstrate a failure. Others
rely on how certain objects are loaded. These are not bugs, but will
add noise if you run the tests suite with this patch.

t0410-partial-clone.sh			Failed tests:  5, 8
t5307-pack-missing-commit.sh		Failed tests:  3-4
t6011-rev-list-with-bad-commit.sh	Failed test:  4
t6024-recursive-merge.sh		Failed test:  4

The following tests are fixed in "commit-graph: enable replace-object
and grafts".

t6001-rev-list-graft.sh			Failed tests:  3, 5, 7, 9, 11, 13
t6050-replace.sh			Failed tests:  11-15, 23-24, 29

The following tests involve shallow clones.

t5500-fetch-pack.sh			Failed tests:  30-31, 34, 348-349
t5537-fetch-shallow.sh			Failed tests:  4-7, 9
t5802-connect-helper.sh			Failed test:  3

These tests are mostly fixed by three commits:

* commit-graph: avoid writing when repo is shallow
* fetch: destroy commit graph on shallow parameters
* commit-graph: revert to odb on missing parents

Each of these cases cover a different interaction that occurs with
shallow clones. Some are due to a commit becoming shallow, while others
are due to a commit becoming unshallow (and hence invalidating its
generation number).

After these changes, there is one test case that still fails, and I
cannot understand why:

t5500-fetch-pack.sh			Failed test:  348

This test fails when performing a `git fetch --shallow-exclude`. When I
halt the test using `t5500-fetch-pack.sh -d -i` and navigate to the
directory to replay the fetch it performs as expected. After struggling
with it for a while, I figured I should just put this series up for
discussion. Maybe someone with more experience in shallow clones can
point out the obvious issues I'm having.

Thanks,
-Stolee

Derrick Stolee (6):
  DO NOT MERGE: compute commit-graph on every commit
  DO NOT MERGE: write commit-graph on every fetch
  commit-graph: enable replace-object and grafts
  commit-graph: avoid writing when repo is shallow
  fetch: destroy commit graph on shallow parameters
  commit-graph: revert to odb on missing parents

 builtin/commit.c  |  5 +++++
 builtin/fetch.c   | 10 +++++++++
 builtin/gc.c      |  2 +-
 builtin/replace.c |  3 +++
 commit-graph.c    | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 commit-graph.h    |  9 ++++++++
 commit.c          |  5 +++++
 environment.c     |  2 +-
 8 files changed, 95 insertions(+), 6 deletions(-)

--=20
2.16.2.338.gcfe06ae955

