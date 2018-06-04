Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B18C1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeFDQwx (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:53 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:4992
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751473AbeFDQwi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yiYGuzAg6grcah83hjZYBikGZE/tDRIb6bdu3tPmCY=;
 b=H2f4l1LKz91Rv9OFLJdTRNDe1I5pFG7fHTyOxOmOoHTi8VVcDjnqrIGPuTgK5FBX7Avkow2vxDPeRjY3ULj+1NeSnJ1qdiBHgCPqGgvFeTx7wz/jOMKDEPXdH+461at5dFwZZq/vOLylfaIOx77eVw1aMNIjBmzSsF359WftWNo=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:35 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:35 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 10/21] commit-graph: verify objects exist
Thread-Topic: [PATCH v4 10/21] commit-graph: verify objects exist
Thread-Index: AQHT/CRwqw0Mlx441keUWlaAd5LWzw==
Date:   Mon, 4 Jun 2018 16:52:35 +0000
Message-ID: <20180604165200.29261-11-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:tDPBCN6I4alLe+/1edxczv5NTwaMVo8wa047ljjigQU3SoApJ3VEiFM5Nxx2saiyZ/50yuV8lVRJjfYIkKKThgesx/n4AFbp7rlg/EmM+QTMz6SUCdbIajbgU0EuUtOlRRYyrqzf34+YnKIOB8NbJhLupWjgihq1n0WjDzEUJYCrxfe062yxetcce8dRAZfJ8RRR1i9cZLGrM2cHAZE5ENMXgB03BxC0tgkrBe/QwJxbM3ZgbH/m2C2M6GdHIbbe;20:wymsxdWvPPDlSdpz15k+8elI08N4hjKjZQDCuWRbNjAxWNwTLp8j+vEEyoMSdPr9WtA8LmtGsultaSveHjlcH42d8l2U/8clKLEjDBlJGWpdRGZDlv60BPy6OypIrJPdaTVYRrABEb0zCk8PvDKgWMOXVhhlq2vWvoAKUTg6CeU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1129897899EBFAFDAEC2DFB2A1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(15650500001)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iDMYH6yfvSj7w/D3Qah9hza6/kkaekBAiKhgcvj+qGa6sGBN1zd2G796JXm3c5rNHp9HCxpBlBa0z89KzxqfRQb+c3ovQ+WRe37sNtYH1SlYvM0qk7yPkTa16Szeb+HXCBHmkMxhHSeekRMwfpTZQ0Isw5BVTN+ReA27ngfH9rUw1sFFXZhhIFcJ9MhtCKMh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dc49afb2-7f9c-45ec-0300-08d5ca3b928b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc49afb2-7f9c-45ec-0300-08d5ca3b928b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:35.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the 'verify' subcommand, load commits directly from the object
database to ensure they exist. Parse by skipping the commit-graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 17 +++++++++++++++++
 t/t5318-commit-graph.sh |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index a90cc2e6f4..0cf1b61d80 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -239,6 +239,7 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
 {
 	struct commit *c;
 	struct object_id oid;
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c =3D lookup_commit(&oid);
 	if (!c)
@@ -890,5 +891,21 @@ int verify_commit_graph(struct commit_graph *g)
 		cur_fanout_pos++;
 	}
=20
+	if (verify_commit_graph_error)
+		return verify_commit_graph_error;
+
+	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *odb_commit;
+
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_commit=
_node());
+		if (parse_commit_internal(odb_commit, 0, 0)) {
+			graph_report("failed to parse %s from object database",
+				     oid_to_hex(&cur_oid));
+			continue;
+		}
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c29eae47c9..cf60e48496 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
=20
+NUM_COMMITS=3D9
 HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
@@ -265,6 +266,7 @@ GRAPH_BYTE_FANOUT1=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 4))
 GRAPH_BYTE_FANOUT2=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 255))
 GRAPH_OID_LOOKUP_OFFSET=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8=
))
+GRAPH_BYTE_OID_LOOKUP_MISSING=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \*=
 4 + 10))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -334,4 +336,9 @@ test_expect_success 'detect incorrect OID order' '
 		"incorrect OID order"
 '
=20
+test_expect_success 'detect OID not in object database' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_MISSING "\01" \
+		"from object database"
+'
+
 test_done
--=20
2.18.0.rc1

