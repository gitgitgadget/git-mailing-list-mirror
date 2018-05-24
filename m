Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E657F1F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033614AbeEXQ0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:11 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030897AbeEXQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpD8OBbb/JAesgdUVFzPvrPzySMlKAlB5K6buROzoNg=;
 b=GBoKZwfx3ogpgQGwskKC5iqOFhLgwdKowss9t0DMvqzMQW1D6+Y6tMbDO7WbTzX7LcZqC/wfNp5W+uYG9/zQc1U+pUQ/IxOd+uUjeTwLBhvNTUhWkGzfz7mLbFBzXHfu9eNrqkxc42X7/raitPFI+YHnGV7zWV2Ec3waCPn8Rk8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:56 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:56 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 12/20] commit-graph: verify parent list
Thread-Topic: [PATCH v3 12/20] commit-graph: verify parent list
Thread-Index: AQHT83vhXp5J+5M0G0eo2lSI4WEyLQ==
Date:   Thu, 24 May 2018 16:25:52 +0000
Message-ID: <20180524162504.158394-13-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:3kpP7iBbd0N59i4Ehz8T8vHTJuZIP85LTsxCqOzuCVVrdLEqZAJFC2eT0cTfIO39u61rr/zuyplSC3lDg9jYLIi0kC0HORT/HiVa++/UwqdKO+x8HI9mI/uy2lgn4PEu3iPH90vOxB46XFsRbDHbzDIecyPAi43M6o0ZC+7r4lMIBhTXSLuNsVuSzZjV3frk66DFA/xVPa7wQikfNhGtRHT/Zde02QVG3Dq9+phketgLYst+yNPY4MFTUzXGFpvA;20:QAvLO7UNzrAI1Fx+Amnp9OZi33AH92PiOVeUNIMH1VLJbiQWehU2/dRZhjugLQ7JHvz6qYvuR8149QI0aRg+bDZbioegVP3XithXwqFAPfT01eCTyK9F5x/PJw8DgTN3FMM81397eLlQ53xBQPggjBfREPsjba3nkibXOAmJ75c=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1091BAB23BD901280E50E928A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(575784001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6666003)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MDaG+RVNMHggBAC8Eap0sauXINXJ5FXU6ZfGZgmdM7lSsiDnDAuRF9VLOly6qVVhO7jAGC1muvg7bA1SPef+15g8BpqbJAhEc65NjsmsZg/XilzyxeQADH3OVC36/YgDZYJMIoyy0+qd2FCop4qzrYh1vNAuKDqBaObpyIj6UxIa6yLPkZPaQqTgn12E2foY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bb894145-2fe4-472f-d3e4-08d5c193040c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb894145-2fe4-472f-d3e4-08d5c193040c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:52.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file stores parents in a two-column portion of the
commit data chunk. If there is only one parent, then the second column
stores 0xFFFFFFFF to indicate no second parent.

The 'verify' subcommand checks the parent list for the commit loaded
from the commit-graph and the one parsed from the object database. Test
these checks for corrupt parents, too many parents, and wrong parents.

The octopus merge will be tested in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 25 +++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 19ea369fc6..fff22dc0c3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -921,6 +921,7 @@ int verify_commit_graph(struct commit_graph *g)
=20
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -938,6 +939,30 @@ int verify_commit_graph(struct commit_graph *g)
 				     oid_to_hex(&cur_oid),
 				     oid_to_hex(get_commit_tree_oid(graph_commit)),
 				     oid_to_hex(get_commit_tree_oid(odb_commit)));
+
+		graph_parents =3D graph_commit->parents;
+		odb_parents =3D odb_commit->parents;
+
+		while (graph_parents) {
+			if (odb_parents =3D=3D NULL) {
+				graph_report("commit-graph parent list for commit %s is too long",
+					     oid_to_hex(&cur_oid));
+				break;
+			}
+
+			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object=
.oid))
+				graph_report("commit-graph parent for %s is %s !=3D %s",
+					     oid_to_hex(&cur_oid),
+					     oid_to_hex(&graph_parents->item->object.oid),
+					     oid_to_hex(&odb_parents->item->object.oid));
+
+			graph_parents =3D graph_parents->next;
+			odb_parents =3D odb_parents->next;
+		}
+
+		if (odb_parents !=3D NULL)
+			graph_report("commit-graph parent list for commit %s terminates early",
+				     oid_to_hex(&cur_oid));
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 21cc8e82f3..12f0d7f54d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -269,6 +269,9 @@ GRAPH_BYTE_OID_LOOKUP_ORDER=3D`expr $GRAPH_OID_LOOKUP_O=
FFSET + $HASH_LEN \* 8`
 GRAPH_BYTE_OID_LOOKUP_MISSING=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN=
 \* 4 + 10`
 GRAPH_COMMIT_DATA_OFFSET=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* $=
NUM_COMMITS`
 GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
+GRAPH_BYTE_COMMIT_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
+GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 4`
+GRAPH_BYTE_COMMIT_WRONG_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 3`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -348,4 +351,19 @@ test_expect_success 'detect incorrect tree OID' '
 		"root tree OID for commit"
 '
=20
+test_expect_success 'detect incorrect parent int-id' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_PARENT "\01" \
+		"invalid parent"
+'
+
+test_expect_success 'detect extra parent int-id' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_EXTRA_PARENT "\00" \
+		"is too long"
+'
+
+test_expect_success 'detect incorrect tree OID' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
+		"commit-graph parent for"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

