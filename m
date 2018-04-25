Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFA41F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeDYOh5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:37:57 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:51008
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754074AbeDYOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WuAQxc/lqkqIB4VLt4S+Se7D/tR50sU+CFUI20jiFIM=;
 b=Wyu/rqRytXoXxE4jyQ+5UuLlx7OxyQgTgbZw/2A6IL/+dtoBTB+68AtYN/Zfva+KsIKWOqROjuRNQLpu7JEUE8qdvTQ8IA4wDwwduemYG36wIpYPJz2rN1vKFZhvafdBuTECBCDd37ZmckwZIpQdaalr8YYtqlOkHFY6jx7ugRE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Wed, 25 Apr 2018 14:37:53 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:37:53 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 00/10] Compute and consume generation numbers
Thread-Topic: [PATCH v4 00/10] Compute and consume generation numbers
Thread-Index: AQHT3KL+GD+ki3I16EeOYkdmhjzCWA==
Date:   Wed, 25 Apr 2018 14:37:53 +0000
Message-ID: <20180425143735.240183-1-dstolee@microsoft.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:405:70::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:VrB0HGCXxeS/6TxICYQi61UiOoKV4SlDb5FvsWortpOqIfGVBLy7wfYydH/2QWSbGjifX95Xk09G4fhbbymCX9OvEnNVeXPUQ6lJbkqasQuDPSpn20e3X+hfbbU+0M2GVA6UG9jimfpbBPJIaVA6wdwDRYWHLJeJycwP31qV2QRsAKgx8oUMCSlE1JpqgaoTyBPFPxdvJWpB8DIEPA6uRZqsBribBb1NE913uhwb6lghFawavVSfznr88nWN/ErS;20:v2p/ulUzbHvO/A8B0v/aRjXYh46XOSKedL3BWUU25P0jNgEiX/1s4zfSxgpVL7v7UgAheWEqODfJkI+zXofWWLucSYWUrxGnAIptfo/4MLzi1ZphQFd5EirKgPlf0UAiOox4zXrIrWRR2k066pMGLmJwfmaB5n3mcQks7kUZ610=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1044893D53241BB9682BD5EDA18F0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(376002)(39860400002)(189003)(199004)(51914003)(476003)(486006)(76176011)(2616005)(106356001)(446003)(11346002)(186003)(305945005)(99286004)(7736002)(6506007)(10290500003)(52116002)(2351001)(46003)(386003)(59450400001)(97736004)(5640700003)(25786009)(3280700002)(102836004)(478600001)(2906002)(105586002)(6512007)(14454004)(10090500001)(54906003)(39060400002)(4326008)(68736007)(107886003)(1076002)(6916009)(6116002)(6486002)(3660700001)(53936002)(8676002)(81156014)(1730700003)(81166006)(8936002)(2900100001)(316002)(8656006)(6436002)(22452003)(5660300001)(5250100002)(86612001)(86362001)(2501003)(36756003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YZoOvMYhTOvxiKUKYuD9LYgxI5atfMEbtKaijID6YFn2hYtPNkRcQ6Um1MsfAvSzcT4CKmemsUQi3yIlSi4JhE0HUmKI2LRUgBy2qhBC9glork2FxH/POGEumZL+8nIc7SCWvZDn/Md6j5bITbeHew3s9jZNNotKgNOY7eV7kCmZz/zFJFBJfgbGDqpU5gnx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8db0bc4f-897c-48eb-d636-08d5aaba2089
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db0bc4f-897c-48eb-d636-08d5aaba2089
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:53.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on the previous version. I think this series is
stabilizing nicely. I'll reply to this message with an inter-diff as it
is not too large to share but would clutter this cover letter.

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

This patch series is built on ds/lazy-load-trees.

Derrick Stolee (10):
  ref-filter: fix outdated comment on in_commit_list
  commit: add generation number to struct commmit
  commit-graph: compute generation numbers
  commit: use generations in paint_down_to_common()
  commit-graph: always load commit-graph information
  ref-filter: use generation number for --contains
  commit: use generation numbers for in_merge_bases()
  commit: add short-circuit to paint_down_to_common()
  merge: check config before loading commits
  commit-graph.txt: update design document

 Documentation/technical/commit-graph.txt | 30 ++++++--
 alloc.c                                  |  1 +
 builtin/merge.c                          |  7 +-
 commit-graph.c                           | 92 ++++++++++++++++++++----
 commit-graph.h                           |  8 +++
 commit.c                                 | 54 +++++++++++---
 commit.h                                 |  7 +-
 object.c                                 |  2 +-
 ref-filter.c                             | 26 +++++--
 sha1_file.c                              |  2 +-
 t/t5318-commit-graph.sh                  |  9 +++
 11 files changed, 198 insertions(+), 40 deletions(-)


base-commit: 7b8a21dba1bce44d64bd86427d3d92437adc4707
--=20
2.17.0.39.g685157f7fb

