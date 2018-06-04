Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E721F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeFDQwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:46 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:45509
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751305AbeFDQwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wok4oHXR1zkcap3OSO25xYd5vNuVSo8vXf+DwzTFDks=;
 b=Q5RUANm+h+iONIEKGFJd28BTD5X4w0sYMdEm5kERrpglKL8QQH1h8A/PoU6ubTnbanMpGx9jsifVsE6ji7H/jLztPArRhQwJi+TBt1mQaP4pOUtqWlM93XUoeuB03xEH8MGGI4ygROTEgGmNZaKX2iey3DifA+Cg67VIm7YBG10=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:41 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:41 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 12/21] commit-graph: verify parent list
Thread-Topic: [PATCH v4 12/21] commit-graph: verify parent list
Thread-Index: AQHT/CRz8Ux58u1YIUWVbPDNFSvLzQ==
Date:   Mon, 4 Jun 2018 16:52:41 +0000
Message-ID: <20180604165200.29261-13-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:JGmS5nU2ci0xB2glb+KDN5EgHG2iXhv3sP+TLs2Fchnrz6rCxFXEBmnXwl90sgFjBe++DW0PgspVFnkIb4Yl+v25HGTsNxsk+GNETTeAzRYEhTyP3hAMXRKpBvhRuWT3g04nyGh935MgH1EWMvwK+6L/ls65Prj3Pcu9vtbBdf31UEK2186ewwMUMEG4e6KxLyXRxiRtjuaH80mJ7sC7wp2FK+uCxu56PzWF6DiHzdG7oDDCNJYgUZNqrLfTejbb;20:fiCONQyj8fdbQ2BFQnxwJFpRQr4jnnAa+AVNFaEspW+55QED+UE6hXK8mRc2P6w1sQ1A8cc6ZAc3brJYovot/vD+tQyRH+Bc6ZIx0rQPX69E8S0tlTqPtOpZJ8BMW1qpY3j6ZjoIclXZO9da/xL1eMFe/YungME1YpwEw2TE3Iw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1129F91C3CB3957C4AC9C337A1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(575784001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(15650500001)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2xAVpc6+u9oxFNtcphjU1Qi+hVN1CtniQRDh3uCf2zdFZWe53nbluiuTjmXFC52pbWTz67+UbvRp5/c9sb9HTmbLLkqAMhUaFDjBk4AnWIs2AWmPn/QCfI0S9uGHRRC6ihq7aklVYy6pGhj+J59lFexhQPb5LIcqOBPR3zGno7cFyH3hKPfSOxbHjzI+COp0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cc6a267f-25ae-4a1c-7c2a-08d5ca3b95cd
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a267f-25ae-4a1c-7c2a-08d5ca3b95cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:41.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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

Add a boundary check to insert_parent_or_die() for when the parent
position value is out of range.

The octopus merge will be tested in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 28 ++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 50a8e27910..d2a86e329e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -240,6 +240,9 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
 	struct commit *c;
 	struct object_id oid;
=20
+	if (pos >=3D g->num_commits)
+		die("invalid parent position %"PRIu64, pos);
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c =3D lookup_commit(&oid);
 	if (!c)
@@ -903,6 +906,7 @@ int verify_commit_graph(struct commit_graph *g)
=20
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -920,6 +924,30 @@ int verify_commit_graph(struct commit_graph *g)
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
index c0c1248eda..ec0964112a 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -269,6 +269,9 @@ GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFS=
ET + $HASH_LEN \* 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \*=
 4 + 10))
 GRAPH_COMMIT_DATA_OFFSET=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* $NUM=
_COMMITS))
 GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
+GRAPH_BYTE_COMMIT_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
+GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 4))
+GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
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
+test_expect_success 'detect wrong parent' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
+		"commit-graph parent for"
+'
+
 test_done
--=20
2.18.0.rc1

