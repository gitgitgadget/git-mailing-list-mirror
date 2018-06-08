Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535761F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeFHN4i (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:38 -0400
Received: from mail-eopbgr730133.outbound.protection.outlook.com ([40.107.73.133]:45030
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752733AbeFHN4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJCP73Wywm4yQNuU2PmIeZEJO/N/fjmMKyTbHj4MV1g=;
 b=ZzImHuNQKcqS/AyFxOvymTbqFxKT82AKlw1aoGG8RC7hhzcmK4ylPexIHBzJtxEnn0ObnxWdICCJtF/lQVJRHujTW3f7ZEX/782WN5gng5maBoq73rvErFHTOKkqqSU/9n2hZe7wRZWvahtIrVQN7s4P+W0xf0u7735cyPQEapg=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1121.namprd21.prod.outlook.com (52.132.18.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:31 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:31 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 21/21] commit-graph: update design document
Thread-Topic: [PATCH v6 21/21] commit-graph: update design document
Thread-Index: AQHT/zCA4Y0t2y6W5UyXQC9gznww7A==
Date:   Fri, 8 Jun 2018 13:56:30 +0000
Message-ID: <20180608135548.216405-22-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1121;7:CtIxn1gNqurHT/D3R5PS7D2qbqyW5cSGGp8FL7gVx/CGFyQtuBndknUCdbgeHXTZbq3KxcKpQ4Bgffv9WLAEZACb4pw4FxvelD57K0G9AC8u0nZQAoy/pglfUriJOV9kVU869P4fVIceU+W50UUNJSRJkUQvHsWVySGcHFX1Gw0arUIoV5kVUB1IeNWANDczll/Vb6n8VC5/NywRhQQhQjE78inbyvTe5MaNP0zQbJVK4fG121hRJRy9aE0HFnrb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1121;
x-ms-traffictypediagnostic: BL0PR2101MB1121:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB11218866AD9B0A5186259021A17B0@BL0PR2101MB1121.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1121;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1121;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(2900100001)(15650500001)(1076002)(4326008)(2906002)(86362001)(6116002)(1730700003)(8936002)(14454004)(25786009)(3660700001)(105586002)(6506007)(386003)(59450400001)(10090500001)(478600001)(107886003)(6512007)(68736007)(86612001)(76176011)(305945005)(8676002)(81156014)(39060400002)(3280700002)(53936002)(186003)(46003)(6916009)(6486002)(446003)(5250100002)(11346002)(6436002)(5640700003)(2501003)(99286004)(8656006)(316002)(22452003)(106356001)(54906003)(102836004)(36756003)(2351001)(5660300001)(7736002)(97736004)(10290500003)(81166006)(52116002)(476003)(486006)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1121;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NTBj87aqJEV2YsN53YJDAQD+AczGZnu/x+MgpqtReOVSl5LvSanNQsdZ5fjTayPD8Rxc2G3J44Y7ctHdkhBdIEc7Ghr3YG9CACuR51L3fzkwNgbEBvYXpl0lKmkzOrux2aId3q/0dv5PcZ56bmTj1jOAskE7H4qlA7aiA/fNHfbfwz1PjADij4azSHHdK6IZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fc22a6b0-a341-4332-a8d0-08d5cd47a2ee
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc22a6b0-a341-4332-a8d0-08d5cd47a2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:30.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1121
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is now integrated with 'fsck' and 'gc',
so remove those items from the "Future Work" section of the
commit-graph design document.

Also remove the section on lazy-loading trees, as that was completed
in an earlier patch series.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index e1a883eb46..c664acbd76 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -118,9 +118,6 @@ Future Work
 - The commit graph feature currently does not honor commit grafts. This ca=
n
   be remedied by duplicating or refactoring the current graft logic.
=20
-- The 'commit-graph' subcommand does not have a "verify" mode that is
-  necessary for integration with fsck.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-order=
ed
@@ -130,25 +127,6 @@ Future Work
     - 'log --topo-order'
     - 'tag --merged'
=20
-- Currently, parse_commit_gently() requires filling in the root tree
-  object for a commit. This passes through lookup_tree() and consequently
-  lookup_object(). Also, it calls lookup_commit() when loading the parents=
.
-  These method calls check the ODB for object existence, even if the
-  consumer does not need the content. For example, we do not need the
-  tree contents when computing merge bases. Now that commit parsing is
-  removed from the computation time, these lookup operations are the
-  slowest operations keeping graph walks from being fast. Consider
-  loading these objects without verifying their existence in the ODB and
-  only loading them fully when consumers need them. Consider a method
-  such as "ensure_tree_loaded(commit)" that fully loads a tree before
-  using commit->tree.
-
-- The current design uses the 'commit-graph' subcommand to generate the gr=
aph.
-  When this feature stabilizes enough to recommend to most users, we shoul=
d
-  add automatic graph writes to common operations that create many commits=
.
-  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
-  commands.
-
 - A server could provide a commit graph file as part of the network protoc=
ol
   to avoid extra calculations by clients. This feature is only of benefit =
if
   the user is willing to trust the file, because verifying the file is cor=
rect
--=20
2.18.0.rc1

