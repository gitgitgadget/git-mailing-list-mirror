Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58251F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeFFLge (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:34 -0400
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:12016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751852AbeFFLgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH0K70rCYgjBInIijBIF8McVz6v87Rx23KiEWHseCVA=;
 b=CDcQuJ9Xvp2Kg5jPsRezp8Bv3ePMa+Ovtgg+hJaG6yt1oJp46+FOMvSf59/llrAkXjhGUxLqNNltSCKYq444r+Ux1GvFon/TyZX5EDD54Pc114syshsEJCC4/PV/7zpnZ0R6JzcToaK/7FaaSek0CyFbNbYGl7BHIJSYTtZ5blI=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:29 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:29 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 08/21] commit-graph: verify required chunks are present
Thread-Topic: [PATCH v5 08/21] commit-graph: verify required chunks are
 present
Thread-Index: AQHT/YqcdIHpCZ78ZU+MtvSEhbZFug==
Date:   Wed, 6 Jun 2018 11:36:29 +0000
Message-ID: <20180606113611.87822-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:07DOFkRoF2KbpKL0MOlZwLh6HzVLUIHhYSD08s7KBKxujT/Wb14aQY09yXt9huSthPEs+2YBXsGyMgqa/oWq/vojotDJqRQ4YgWQbaThhJSVQlVdMx5acAlZuzr/A6F5MT/mIJK5X6lkoQan/Eh5tWG7SmZ+GFcmhUxWtO6v6InjmK9Q9I97FL9Oxt4rIq7OUN+PudVv6j7Kk9ev3RhdkMVea42ORTSSTYpEF/4f7F8gr1VEhqZDOjmvKqqMe2p9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10440F33BE792EB8666822ABA1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(575784001)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nzuHomb9Lw5boAzI9rgW+d/xVgBR01kgs8ZdZsgftAn4nusQP1tERX7TNuycoMSpVYzK9xiN+JOLYFN7A3lR2ZXpga9d7vIlU01XZVuBAimSjKDDSK5CHTvyNt1lxrQalqufe9Usu4knEAEByqBcj2sZDlUtpPkzh55it4Tr8AEHVQOTop/Dva8GSoDxa1Yt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 84ab27d9-b9b8-4a24-be32-08d5cba1be83
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ab27d9-b9b8-4a24-be32-08d5cba1be83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:29.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file requires the following three chunks:

* OID Fanout
* OID Lookup
* Commit Data

If any of these are missing, then the 'verify' subcommand should
report a failure. This includes the chunk IDs malformed or the
chunk count is truncated.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          |  9 +++++++++
 t/t5318-commit-graph.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 432920ad2a..f41d5a0504 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -848,5 +848,14 @@ int verify_commit_graph(struct commit_graph *g)
 		return 1;
 	}
=20
+	verify_commit_graph_error =3D 0;
+
+	if (!g->chunk_oid_fanout)
+		graph_report("commit-graph is missing the OID Fanout chunk");
+	if (!g->chunk_oid_lookup)
+		graph_report("commit-graph is missing the OID Lookup chunk");
+	if (!g->chunk_commit_data)
+		graph_report("commit-graph is missing the Commit Data chunk");
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c0c1ff09b9..846396665e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -249,6 +249,15 @@ test_expect_success 'git commit-graph verify' '
=20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
+GRAPH_BYTE_CHUNK_COUNT=3D6
+GRAPH_CHUNK_LOOKUP_OFFSET=3D8
+GRAPH_CHUNK_LOOKUP_WIDTH=3D12
+GRAPH_CHUNK_LOOKUP_ROWS=3D5
+GRAPH_BYTE_OID_FANOUT_ID=3D$GRAPH_CHUNK_LOOKUP_OFFSET
+GRAPH_BYTE_OID_LOOKUP_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+			    1 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_BYTE_COMMIT_DATA_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+			     2 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -283,4 +292,24 @@ test_expect_success 'detect bad hash version' '
 		"hash version"
 '
=20
+test_expect_success 'detect low chunk count' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
+		"missing the .* chunk"
+'
+
+test_expect_success 'detect missing OID fanout chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_FANOUT_ID "\0" \
+		"missing the OID Fanout chunk"
+'
+
+test_expect_success 'detect missing OID lookup chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ID "\0" \
+		"missing the OID Lookup chunk"
+'
+
+test_expect_success 'detect missing commit data chunk' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATA_ID "\0" \
+		"missing the Commit Data chunk"
+'
+
 test_done
--=20
2.18.0.rc1

