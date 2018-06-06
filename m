Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24EB1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFFLgb (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:31 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:45037
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751911AbeFFLg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1IEcbXjwpxvSRWLWcr7BriXrWxpXH/Vgre/GlnHOKU=;
 b=CQO7W+qNHb5wv1ZbpDDKtSS1YGVIuWoqhaG16jppz9ueJbKwsyD2KHYyLOeokOFK9FqS3EWZnJ+IwRVNNttJvlNkiqyxqNG1/V38N26X6ofLVeUBLYPlR1rlLVMchdYtRDO585bg5KONwvVN9IgWvQOMoSPAAK6ctVjgoaUtG68=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:26 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:26 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 05/21] commit-graph: load a root tree from specific graph
Thread-Topic: [PATCH v5 05/21] commit-graph: load a root tree from specific
 graph
Thread-Index: AQHT/Yqa0sGNk5s4zUuigY6Qhtw2zQ==
Date:   Wed, 6 Jun 2018 11:36:26 +0000
Message-ID: <20180606113611.87822-6-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
In-Reply-To: <20180606113611.87822-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:403:1::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:gpkxma19fYG8ZbtOx7HqMr1y155B6g3A7A+VfwAqm0p//DAVnbpDd+KD7GfiUWCiI4rVomBnYGN2Iy6a2keoGrYEABoJGix63TQX6VpuOrSNETI0BROSAN42L+7yzuwzmfr5AI1RJl7XtViWWWMt1gZduHJLiWx1zF5kROhxG/aZVA5df/IHyIGTudwEJ+dqg/wrdhirsq61i09twz3Be5+N3t/98/BdyC2xgMbIVBbvqsFcU/ceJJcz33CpIWCo
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB104401BF95451129A764DC74A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cyD1yYlRNDBFaBc6yCxaGPRRfnwadAWuq9zoe0WrA+eGiEz8CURFR4SJ5TyD6JfhRh4pZxDlff5JNj2WXzHz8PeEv2Xxs/FS+l/Q+FQjHiN+WW6tvV2gCR1rhRDJclmrpxSxgnEsvpKNiwDLzbVPgdv/IpwDWRlU/BjvGW4TwokKWnuaH1fLQrmYArevHvWd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 77ad3019-dc4c-42db-4a82-08d5cba1bcf4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad3019-dc4c-42db-4a82-08d5cba1bcf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:26.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When lazy-loading a tree for a commit, it will be important to select
the tree from a specific struct commit_graph. Create a new method that
specifies the commit-graph file and use that in
get_commit_tree_in_graph().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e77b19971d..9e228d3bb5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -362,14 +362,20 @@ static struct tree *load_tree_for_commit(struct commi=
t_graph *g, struct commit *
 	return c->maybe_tree;
 }
=20
-struct tree *get_commit_tree_in_graph(const struct commit *c)
+static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
+						 const struct commit *c)
 {
 	if (c->maybe_tree)
 		return c->maybe_tree;
 	if (c->graph_pos =3D=3D COMMIT_NOT_FROM_GRAPH)
-		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
+		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
+
+	return load_tree_for_commit(g, (struct commit *)c);
+}
=20
-	return load_tree_for_commit(commit_graph, (struct commit *)c);
+struct tree *get_commit_tree_in_graph(const struct commit *c)
+{
+	return get_commit_tree_in_graph_one(commit_graph, c);
 }
=20
 static void write_graph_chunk_fanout(struct hashfile *f,
--=20
2.18.0.rc1

