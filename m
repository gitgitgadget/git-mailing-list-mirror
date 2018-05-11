Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B9F1F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeEKVPh (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:37 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com ([104.47.36.114]:34789
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751012AbeEKVP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibvqd87tcVOSR/t+VZOcrrSeBcio/eJWxo7HDxhwQXs=;
 b=KfzWJ4d9O//RKPCNbSCnCmtFMQzjzxnVvaqvy2F2iap7XFMMjpDtKzGtM76Gjp/uBWVCYXKwqZQi1IPs92nlsl/ouzo/ghK/SIEuh2kyXaEdz16H7CtUK5Kre412jw4CuwRh9Eg3Lq57gr4IA0Mj36kdLYYI/zFr5HrNWBosq6w=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:25 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 07/12] commit-graph: load a root tree from specific graph
Thread-Topic: [PATCH v2 07/12] commit-graph: load a root tree from specific
 graph
Thread-Index: AQHT6W0rEVwh6Jwk5k+LbOvh1J7S2Q==
Date:   Fri, 11 May 2018 21:15:21 +0000
Message-ID: <20180511211504.79877-8-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
In-Reply-To: <20180511211504.79877-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:404:8e::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:Fukomv7+xBXQyiQ1GYtQnpPfRkrJo2mK+MQRg03J8p8wGVtR0aY+loTlZE7q5rYidH9+CQkq0Ve5UfuNJAVzDRtuWu+7IXEWCstcKmn5HOJWd0lJ1x3h3GC5SUzvYSUSDYdYHZNR53mOgK1v4hT2NQcUBJzaOS9cL3dcDjpAo+zUgnmzLTug6wgADDI19AfN0MHFKpeirD5/ra9ycTLCNw1JmyeUsTRI+ZTtgsA8DscMPT4hS5jmvczB48X37f01;20:5q/fTOSRzTzmpa5UGznzf+7NtpaeEA25MQYIC4JJH/4xAzb7YS4jZLkMQGAFwau95JZHtxC0v3r8ha4AJVNwbYETPRSPG+OlKHSOw0MlXC2Q16fKJ6hyL0QixvysY8kRoB89uNoXsHt5hPj8FPHA+JDIdjBKST2raW7ydaUYlJk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962F3AF97E59918F924272BA19F0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(5660300001)(39060400002)(316002)(305945005)(6116002)(7736002)(6506007)(52116002)(386003)(81166006)(81156014)(186003)(3660700001)(5640700003)(46003)(76176011)(54906003)(1730700003)(68736007)(6436002)(446003)(102836004)(3280700002)(1076002)(59450400001)(97736004)(2351001)(11346002)(22452003)(106356001)(99286004)(2616005)(476003)(2501003)(36756003)(14454004)(2906002)(8936002)(6666003)(105586002)(107886003)(4326008)(8676002)(86612001)(6486002)(486006)(25786009)(10090500001)(53936002)(478600001)(2900100001)(86362001)(6916009)(575784001)(6512007)(10290500003)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3pKMUjLqw4lanU5EFBLlkmNXwJ/87hiqErRDEm/icKXmPfxBs2629QnW+11fRPBs3IT/Fd3KgfZHqSdaKL+5d3iOK+SijLsVlasmPO3UWllJUhJG07KfwFsFFN5d6E6EW1AoqghGhH0F1X594LZUTR0RbZzGB9TPvkNWh+3C1z7jCyi5QqQW4rf3NtAvynco
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2cf88331-fc3f-4302-a8d2-08d5b7844d86
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf88331-fc3f-4302-a8d2-08d5b7844d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:21.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
 commit-graph.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b0fd1d5320..5bb93e533c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -357,14 +357,20 @@ static struct tree *load_tree_for_commit(struct commi=
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
 		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
=20
-	return load_tree_for_commit(commit_graph, (struct commit *)c);
+	return load_tree_for_commit(g, (struct commit *)c);
+}
+
+struct tree *get_commit_tree_in_graph(const struct commit *c)
+{
+	return get_commit_tree_in_graph_one(commit_graph, c);
 }
=20
 static void write_graph_chunk_fanout(struct hashfile *f,
--=20
2.16.2.329.gfb62395de6

