Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A459A1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966738AbeEJReQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:16 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966615AbeEJReO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GIiIvLvHCpFh6Bmx1otzHpP7BvB2rbpzbLIBMjZKCno=;
 b=L/fkolsIj+yiSc2V+n8T6JkGNWttu6I1WWN4aTz02aHHj8Bk0qqUPCtecnxpTMJMN35XxhHZi8fpgZqkYvk2sgbVrmDTWQyrgu0MhLdtvAMBsndtXU++e2oNF88d4O+091n+Q0dEEtMdwv6tc9/BOqAJ1kuJP6k9NHXLmfYKwzY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:11 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:11 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 07/12] commit-graph: verify commit contents against odb
Thread-Topic: [PATCH 07/12] commit-graph: verify commit contents against odb
Thread-Index: AQHT6IUbirpdxlDB+ESQ2zqKNDAXFg==
Date:   Thu, 10 May 2018 17:34:11 +0000
Message-ID: <20180510173345.40577-8-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:ywCWzjHWWC0D9DyPoyAPgRN/M6WImg9gL9XFRisp/bCWg/mC3VU0pmdkiu6RSo2ND0r3DPCl7AtQfRa162vfwXSFQTH914YEgQVUWWI8+jfyI4kRjXQ9DYlUFkmTZNR7XOxHeB6EMEUo0BcmTUZkS0i8QcuotMAqgjsMcQuVY8QmmpdwuumjFG/af8RiSiJ7ob13uLl4rSrlmCJNaC2rYG2vTjUz9l/7U6dEsG2f9VxULI5Clj0CBLNTpTRISb3i;20:EZuM2hthOVAwUZhg8uiH+xLG91M0Tg+MJFFYhmyfntrnRJ8XvVbhJAvSG7Fk3tFtbk07pWffT2poonHsEvgssMRDt1wornp/D9ISDJRdoEgszXgjeO0kTNBQWKGYPkiYcnKcMi2uriIk9kk7lAoR+Qyer3zueHu5NYtm1l4HUhI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962EE0AF131A67BB4102498A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(15650500001)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e2j0KBnd75f4XiCYPV2cAReSYINh9E0pvYB7PighRWnaUY3ZfwlQavUvYylEludpDqZ9KpHN8I10VQ0AEzMifTWSgdse/kRuRCNrv2aPhGtSUV7QUum0hU/eTPeseSHvcuUAezg1+D+K81cbouWKQQVXHMJZlSM+2NgRd/lKc4pO5ZlhMPn/Ke32JFWmTO7L
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fa20f990-8e36-468b-3b7b-08d5b69c3d8c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa20f990-8e36-468b-3b7b-08d5b69c3d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:11.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git commit-graph verify', compare the contents of the
commits that are loaded from the commit-graph file with commits that are
loaded directly from the object database. This includes checking the
root tree object ID, commit date, and parents.

Parse the commit from the graph during the initial loop through the
object IDs to guarantee we parse from the commit-graph file.

In addition, verify the generation number calculation is correct for all
commits in the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 88 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 8c636abba9..24f5031f3e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -863,6 +863,8 @@ int verify_commit_graph(struct commit_graph *g)
 		graph_report(_("commit-graph is missing the Commit Data chunk"));
=20
 	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit;
+
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
 		if (i > 0 && oidcmp(&prev_oid, &cur_oid) >=3D 0)
@@ -880,6 +882,10 @@ int verify_commit_graph(struct commit_graph *g)
=20
 			cur_fanout_pos++;
 		}
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		if (!parse_commit_in_graph_one(g, graph_commit))
+			graph_report(_("failed to parse %s from commit-graph"), oid_to_hex(&cur=
_oid));
 	}
=20
 	while (cur_fanout_pos < 256) {
@@ -892,5 +898,87 @@ int verify_commit_graph(struct commit_graph *g)
 		cur_fanout_pos++;
 	}
=20
+	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
+		int num_parents =3D 0;
+
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_commit=
_node());
+		if (parse_commit_internal(odb_commit, 0, 0))
+			graph_report(_("failed to parse %s from object database"), oid_to_hex(&=
cur_oid));
+
+		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+			   get_commit_tree_oid(odb_commit)))
+			graph_report(_("root tree object ID for commit %s in commit-graph is %s=
 !=3D %s"),
+				     oid_to_hex(&cur_oid),
+				     oid_to_hex(get_commit_tree_oid(graph_commit)),
+				     oid_to_hex(get_commit_tree_oid(odb_commit)));
+
+		if (graph_commit->date !=3D odb_commit->date)
+			graph_report(_("commit date for commit %s in commit-graph is %"PRItime"=
 !=3D %"PRItime""),
+				     oid_to_hex(&cur_oid),
+				     graph_commit->date,
+				     odb_commit->date);
+
+
+		graph_parents =3D graph_commit->parents;
+		odb_parents =3D odb_commit->parents;
+
+		while (graph_parents) {
+			num_parents++;
+
+			if (odb_parents =3D=3D NULL)
+				graph_report(_("commit-graph parent list for commit %s is too long (%d=
)"),
+					     oid_to_hex(&cur_oid),
+					     num_parents);
+
+			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object=
.oid))
+				graph_report(_("commit-graph parent for %s is %s !=3D %s"),
+					     oid_to_hex(&cur_oid),
+					     oid_to_hex(&graph_parents->item->object.oid),
+					     oid_to_hex(&odb_parents->item->object.oid));
+
+			graph_parents =3D graph_parents->next;
+			odb_parents =3D odb_parents->next;
+		}
+
+		if (odb_parents !=3D NULL)
+			graph_report(_("commit-graph parent list for commit %s terminates early=
"),
+				     oid_to_hex(&cur_oid));
+
+		if (graph_commit->generation) {
+			uint32_t max_generation =3D 0;
+			graph_parents =3D graph_commit->parents;
+
+			while (graph_parents) {
+				if (graph_parents->item->generation =3D=3D GENERATION_NUMBER_ZERO ||
+				    graph_parents->item->generation =3D=3D GENERATION_NUMBER_INFINITY)
+					graph_report(_("commit-graph has valid generation for %s but not its =
parent, %s"),
+						     oid_to_hex(&cur_oid),
+						     oid_to_hex(&graph_parents->item->object.oid));
+				if (graph_parents->item->generation > max_generation)
+					max_generation =3D graph_parents->item->generation;
+				graph_parents =3D graph_parents->next;
+			}
+
+			if (graph_commit->generation !=3D max_generation + 1)
+				graph_report(_("commit-graph has incorrect generation for %s"),
+					     oid_to_hex(&cur_oid));
+		} else {
+			graph_parents =3D graph_commit->parents;
+
+			while (graph_parents) {
+				if (graph_parents->item->generation)
+					graph_report(_("commit-graph has generation ZERO for %s but not its p=
arent, %s"),
+						     oid_to_hex(&cur_oid),
+						     oid_to_hex(&graph_parents->item->object.oid));
+				graph_parents =3D graph_parents->next;
+			}
+		}
+	}
+
 	return verify_commit_graph_error;
 }
--=20
2.16.2.329.gfb62395de6

