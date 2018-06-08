Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EEF1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHN4W (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:22 -0400
Received: from mail-eopbgr730112.outbound.protection.outlook.com ([40.107.73.112]:2144
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751643AbeFHN4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1IEcbXjwpxvSRWLWcr7BriXrWxpXH/Vgre/GlnHOKU=;
 b=KMkoJYbVFzg2/lNJVE0VEBegWQMHHOqBhP8SxmzbAoZt4fwU0Z9LWDgRGIPf6yr+PVwshX+rypkQ4a5RZ9RlJfUOR0gG7HSCjikHhtTdR3Fp2a/G/g+s3WRjteWkyGth61hOWK4y7LaBss0QqiLjHoi9rNdlt9CVwLbJ43UKWMQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:17 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 05/21] commit-graph: load a root tree from specific graph
Thread-Topic: [PATCH v6 05/21] commit-graph: load a root tree from specific
 graph
Thread-Index: AQHT/zB4z6L3mFscuEiPBPkgT/hjhA==
Date:   Fri, 8 Jun 2018 13:56:16 +0000
Message-ID: <20180608135548.216405-6-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:XfOenxjyDkY+eQmR2S6yzRBHVPQWw7KUR4R5RKfYMg7wrGkpWSU5KaOByK4dXyic8BKIr+S8TfEdCM4BaTG3A88EdfCtmSghmjKF/doSVAQ6AyXXFmdHH9hkwLtn3E+6IPz7K57tbTJSyjz5wz5a8oPNv/q7y2pvZM4/cFDxtbTmw6eEI1fyBDT0pnOVJwwa9IPvpEEnonNmXYo7m2HYkEQt5jcPzkzyWujPp7OQrkJycRa9zyvIqE7nK5m4V3gW
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB097919BDF1B8129CB57E3133A17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(1076002)(186003)(3660700001)(2906002)(386003)(59450400001)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hJmb+cO06jLdk6yMQnOYZfYDbkaoUdIcnDK6f2TuraaLXBZuJAtkFFY6K59Z3qiNdq5P6nuk48F5XCmI1BSkE2LIOhMG1XyUNwDc9mVC06hBFbrE/KsaVnselwdgOco8cCZqVA7RsL8kKUSBl5H44zhvAJiDN1/4ZfCbSydhAwTZsYkcyQGJJcxEZzZ3SOwz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 981a87a3-530c-4daf-20a8-08d5cd479a98
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981a87a3-530c-4daf-20a8-08d5cd479a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:16.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
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

