Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D191F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033637AbeEXQ0V (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:21 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:37267
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033605AbeEXQ0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymAw5bmm9t9h/AbXMEsG4Zmo9eJN1KtCiWT9fc7eC2k=;
 b=D3YrnHtnKyLo2S3V/kc3CkKbIxE9mqKlLZK63BmjfLvuzpfJvZ+gPVP0D4Hd+fnDQf/gqoiezMu8+Bnnl+2mefpC/bRyDpyQkj9BdmbJBa9ap9n6c30lbvsyIyfkrmZ+vz6tQJWuTwdx3KKpNO2tLRQOSAmLGmYeV11yfgn51Z4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1010.namprd21.prod.outlook.com (52.132.23.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:26:11 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:26:11 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 20/20] commit-graph: update design document
Thread-Topic: [PATCH v3 20/20] commit-graph: update design document
Thread-Index: AQHT83vtzlNGsv4/40ifNWrqgQIF/g==
Date:   Thu, 24 May 2018 16:26:11 +0000
Message-ID: <20180524162504.158394-21-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1010;7:8B1uF7GZd3C3suMfBt4rh26FraSLCsGCNn3yRy4S40chG7X3X2IaFA/5K/yVJTfktU2lq/OF6fvZKJd4yDZt6M+7AGiOjYjnDTduGcVTiBL242K7Hd8Izr+jaAf1O/xk2o9zMr6VUqX1WURznq/MF4wD8wq754W3JGl0pq0FqHoSoBjZ5CsafzRo/WEirK1CP7nk2SAKQNsPAJz0gIxUTl/gKRWgmOnYtx4MW4OHOxxTgbm/4Do85jnhtflkGnsc;20:5NG9Udq3g/juSqsdhTw+gI4FtPoCIWmVkXWf1ff/Gro2z23BFhZKJnPVOkPHeKg1GEfSkXKeLb3xuC/JYrC68jLAfvm7xA3FBtkv5KdpJ6jYT7RNgxGPeqQ5Kf5povQDI8xr+FT7qFQoXBVdnROSRk5JAJZrvTkxfkBNZ023dHw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1010;
x-ms-traffictypediagnostic: BL0PR2101MB1010:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1010B0284965A90F14FC54BDA16A0@BL0PR2101MB1010.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1010;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1010;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(305945005)(5640700003)(36756003)(6436002)(7736002)(68736007)(6116002)(6916009)(76176011)(46003)(5250100002)(2501003)(6486002)(5660300001)(446003)(25786009)(81156014)(1076002)(59450400001)(2616005)(476003)(6506007)(102836004)(386003)(14454004)(2900100001)(11346002)(486006)(81166006)(105586002)(1730700003)(4326008)(106356001)(10090500001)(6512007)(3280700002)(22452003)(8656006)(186003)(478600001)(97736004)(10290500003)(99286004)(316002)(54906003)(52116002)(8936002)(8676002)(2351001)(86612001)(39060400002)(53936002)(2906002)(3660700001)(15650500001)(107886003)(86362001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1010;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sRuI32JYo3OeP0MHWgZs+FKbz1jya5koUjgElc7AeM9WD22UN5Gt0eGBH6gpI51SdyM4lqrAI2MTmsPcTwQIqs4+dEirBiD7P2xTorZpJxGchAmxEvIa7CZoU9AJfov3+hHoMr5CMMVcI6mrWp5B/aS2Xsn8YMf7xLDb19Jnv+pzpsqyuwHq+uu59UWIuWWH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0b91b1de-1856-4458-e057-08d5c1930fa0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b91b1de-1856-4458-e057-08d5c1930fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:26:11.8754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1010
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
2.16.2.329.gfb62395de6

