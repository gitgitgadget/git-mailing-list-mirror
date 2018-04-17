Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C341F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDQSKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:52 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:13488
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752800AbeDQSKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=StFR8yqUC5KklrEhG2mvXcNHMeQOx2UaePsg+/cInm0=;
 b=LrJxbthMxx5S+SPFgETvCK0ilkcTnXPDf+SjzKc783tDuJwXDSLjKFfp+5d/WbCHyeg/K9ur9wjf8uFqPqxiQejWSbXOP1VGz84hhr/4pZGzhQBmNNPfFomJQVKe4sTRc8ZD4CmVBhXR6KW2NMIha0ebSiD2EFRGfP/1enlp9MQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:46 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:46 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 12/12] commit-graph: update design document
Thread-Topic: [RFC PATCH 12/12] commit-graph: update design document
Thread-Index: AQHT1ndnsjyBXn+m/UOQBF8GMGJWAA==
Date:   Tue, 17 Apr 2018 18:10:45 +0000
Message-ID: <20180417181028.198397-13-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:ilAqJL2u9Pb8GjnTiEY9nNdHt0f5fAPaG9XY5evr4gmFsINXIiNGfCzGshytwlE0xRcj2zCV/1ftgI2taX9U8KsDst9OtJWLUB05d2iw1lXk6b3XUVmL+aopDMPOu8uYYlRwndPPpENuCDK9mdu9J8fDsZAMxqBMeF0rxF6Guw8/clgnzHF9aLYPXX7Rg6ldN6pNwqOGlvvkHhsIxLJdptMm8+AGd1K6FdoNZyba+PQZhk41RZXQ7wSL0AqNkF5Y;20:2HBjEfFMqDqHVRRxpX78yPklIbzK6w+eRAqHbHAFSqJWP/mwd3kQ+CBCTvgHmJzE0uNisNb8Qr6nKWjrQak9NxPGaQq9Allz2Cz/4Fz5n+4qdcfQblis2bOxZbyuC1v8jad2VrnsQ+Xsld5Gk66995SG0xGxRTWuqksAlWEmk5M=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09947DEC154E556166FB32B4A1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(59450400001)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(15650500001)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3RntQoicFZHi353OOLKHvetKhwzxprmQxcd1L/KL+pPpBF8SVMRip1AdO5D0a/Q5a6hoe+eKQEDz1X4hYosI/2s4TIbBIhDB0Rf6pBFzrGfKhGXzDIDV09Zh2Nf7BXmapv2WQngaCoSfFr01Vo4Y7ecslh/o2CGnWmME7wBO+q3NXduRkhu+gCBMaSJgD36I
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ff5757b0-02fa-498d-d11a-08d5a48e8a4b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5757b0-02fa-498d-d11a-08d5a48e8a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:45.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is now integrated with 'fsck' and 'gc',
so remove those items from the "Future Work" section of the
commit-graph design document.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index d9f2713efa..d04657b781 100644
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
@@ -142,12 +139,6 @@ Future Work
   such as "ensure_tree_loaded(commit)" that fully loads a tree before
   using commit->tree.
=20
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
2.17.0.39.g685157f7fb

