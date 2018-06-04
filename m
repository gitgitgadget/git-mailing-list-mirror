Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936E91F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeFDQw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:29 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:62688
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751366AbeFDQw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s21hdIcjsZGjZSECrh2xLymJG3Ga1lXWeRm+qG1Hi/Y=;
 b=CwlYM19OMzt5EqK4I5oWbXpqutoS3iVdI7vdwidNfeLJ4zWA5X002jZGDZ/hl61r6yVDrnvRdES6WsHtlywTd8W/G0fYvAfCZGYDNpkOngckhcavAu4F8QjdLezV1W5xQ0qa0EN2/qKGUv/rg4yCBd6TCTFbIiJ23i9rznG8yCs=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:24 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 05/21] commit-graph: load a root tree from specific graph
Thread-Topic: [PATCH v4 05/21] commit-graph: load a root tree from specific
 graph
Thread-Index: AQHT/CRp/E/DLcJY7U6nrt8hEP/6uw==
Date:   Mon, 4 Jun 2018 16:52:24 +0000
Message-ID: <20180604165200.29261-6-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:5oiL2q5zIzs/t4Nft0gfsBApfu6IuOOGKit445fbPQ02mkJnWcJe3iPewl7y46mXt3EtLQhswFpNekiH8+upEZUjuYzWXg8itsW/IU+EFKBbAsARvzXJj5kWQYqDuDxhPX5gr555FcHG9YlGz0U0G1UEIYY4jn22A+xcWrMhS8h0rYNIxxsKXpa+5PMFiK35VfcakrF4jzIUj/IXo1nFUsRDximg4tw2xudW0HtTlqV29BkU3dnmczpxpnsIZtjz;20:RpOXv8Ve/nDCgVG+6twcR4IszTvWKQjhDjlYLIIJpogQbHd9jGZjQkgswV/ScRUCs/KcN4uDaIgpRSW4S/O1OLfcsIIFrwL95alLCUi66Fhim0NnhTEEhlRfKh9u3kZ26M3Udhb3bkfyDbECxR7UX8wMWL0QAYpyiEhJngvxmz0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB112984079893950B1A6FA1BEA1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xZpNzvyzU55rJfTWKNAb5VuSabaxzdLftUU20eT7CEVr4ZLfoE46GayX+Gr3VxxgbuHOCkVqFWhjxg3zRm6YgYUo+odZWiCuEa46pHpOoq5yG7cqQOH424aLol3mXKLSyVNubP0gSzZo7rALrG8DqQiHQ/4AQqc070JW+KfFtpXmo1HXOLzYhJ8HCUY1gV6I
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 13278fb3-975e-4a07-a10f-08d5ca3b8b74
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13278fb3-975e-4a07-a10f-08d5ca3b8b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:24.1069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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
index 472b41ec30..fee8437ce3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -359,14 +359,20 @@ static struct tree *load_tree_for_commit(struct commi=
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

