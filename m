Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18E61F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeDQSKl (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:41 -0400
Received: from mail-by2nam01on0097.outbound.protection.outlook.com ([104.47.34.97]:5120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752714AbeDQSKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SJoTBRAAYnWcDBTLVq0+TSsXC0sW819k1eHjJgDadBo=;
 b=G7znNaaavUhfEEjgzJxRquIcg1NphJ/FXBQ2GdWNlQrpNU5qHD9hxV3v0tD342iO0wzXXdKNFmV1qC3hEFb6RD0W4kGpZMjK4NEM6ECDT8p5iB5eHfbH5w5Swl2GZL+pPzrVIhuO6Ep/c8ZQv5nK7JOs9pFa9l7WCTj5juiYhQ4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 00/12] Integrate commit-graph into 'fsck' and 'gc'
Thread-Topic: [RFC PATCH 00/12] Integrate commit-graph into 'fsck' and 'gc'
Thread-Index: AQHT1ndjbq/PxCo0p0SqcyuqBfuNcA==
Date:   Tue, 17 Apr 2018 18:10:37 +0000
Message-ID: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:zn4n2hNoTT/ZV9NsqNiWFqCzRZrHLDwuZ9476IjFRJnATKUbFZij7a2paH4c8Fj3as4S/RHB5TVpxwzhO5d675gKehX00oOpFsWkkGMfHXSFtB4eEqFH0WMYpvz8m75PnLTDhRg/7Nb/GlYpXDXLutS8wbKNjCr6XuJbM768QvBqGTLKSnnmt7JNT/d8xBQShmf2uHfPmKCY1vhaGILoeFlmxQoaprTnOX3UHknwBpFSsoNAlWD6AAT5Hb39Mz/e;20:z+ZS7PD4Qj85d9H+eWCP+7gT+Sf2X89JHNcgbVXupi5RNic9XaRJzXwChBQSdgZYFjDHZzverJLUwc4ARqExyqwoTWZTTEPV9lvB08JydZSrUQ6tyqlnMbQ6MqOmE8PYNT0/QGlU2SlaWyKvkZUgMK86LyMOWQvF1o6SN1fQn/s=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1027E2A61D8CC653F87B36B7A1B70@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(6512007)(5660300001)(186003)(107886003)(6916009)(2900100001)(478600001)(10290500003)(105586002)(106356001)(2906002)(86612001)(86362001)(99286004)(53936002)(25786009)(22452003)(54906003)(316002)(5250100002)(6486002)(6506007)(97736004)(4326008)(8936002)(14454004)(102836004)(3660700001)(6436002)(36756003)(5640700003)(3280700002)(305945005)(10090500001)(81156014)(59450400001)(68736007)(2501003)(52116002)(2351001)(8676002)(476003)(1076002)(386003)(81166006)(2616005)(7736002)(486006)(46003)(6116002)(1730700003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2Xn7jF9Ge20R9DlaKfvdJmRN/gQ1cZL+81aWPNXFRVlW52qvVnmen/Zjv2DtvWtECvZnVTqRsGrZRjFsl8YdtQKwX73EUqYDAt1AKgQiVM3m5DM02OtsTufwU8PQZx7/lLMuSobbwJVc+DTKCHVG0BZMEHRJocNDfz6+VPhMowRHRWOeuFOgV/q5zoaJ2CGH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5ffd1757-1f8f-4c2f-2a4e-08d5a48e8568
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffd1757-1f8f-4c2f-2a4e-08d5a48e8568
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:37.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is not useful to end users until the
commit-graph file is maintained automatically by Git during normal
upkeep operations. One natural place to trigger this write is during
'git gc'.

Before automatically generating a commit-graph, we need to be able to
verify the contents of a commit-graph file. Integrate commit-graph
checks into 'fsck' that check the commit-graph contents against commits
in the object database.

Things to think about:

* Are these the right integration points?

* gc.commitGraph defaults to true right now for the purpose of testing,
  but may not be required to start. The goal is to have this default to
  true eventually, but we may want to delay that until the feature is
  stable.

* I implement a "--reachable" option to 'git commit-graph write' that
  iterates over all refs. This does the same as=20

	git show-ref -s | git commit-graph write --stdin-commits

  but I don't know how to pipe two child processes together inside of Git.
  Perhaps this is a better solution, anyway.

What other things should I be considering in this case? I'm unfamiliar
with the inner-workings of 'fsck' and 'gc', so this is a new space for me.

This RFC is based on v3 of ds/generation-numbers, and the first commit
is a fixup! based on a bug in that version that I caught while prepping
this series.

Thanks,
-Stolee

Derrick Stolee (12):
  fixup! commit-graph: always load commit-graph information
  commit-graph: add 'check' subcommand
  commit-graph: check file header information
  commit-graph: parse commit from chosen graph
  commit-graph: check fanout and lookup table
  commit: force commit to parse from object database
  commit-graph: load a root tree from specific graph
  commit-graph: verify commit contents against odb
  fsck: check commit-graph
  commit-graph: add '--reachable' option
  gc: automatically write commit-graph files
  commit-graph: update design document

 Documentation/git-commit-graph.txt       |  15 +-
 Documentation/git-gc.txt                 |   4 +
 Documentation/technical/commit-graph.txt |   9 --
 builtin/commit-graph.c                   |  79 +++++++++-
 builtin/fsck.c                           |  13 ++
 builtin/gc.c                             |   8 +
 commit-graph.c                           | 178 ++++++++++++++++++++++-
 commit-graph.h                           |   2 +
 commit.c                                 |  14 +-
 commit.h                                 |   1 +
 t/t5318-commit-graph.sh                  |  15 ++
 11 files changed, 311 insertions(+), 27 deletions(-)

--=20
2.17.0.39.g685157f7fb

