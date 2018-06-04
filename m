Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1DB1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeFDQwj (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:39 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:10240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751305AbeFDQwg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA6kQm60pflnAAe/1Nqi1Uvtv3oOZonU2mzUBwxFKoo=;
 b=mACcdmK5U5RUzT27QaNrVpPvDiTeOAhe6VpkJNrNhhgo4Gdy8OyvCaS9t8reJIsgEA5ezVYnnpauN4X+WAw5e8ygUSwgX1HDzHaoygrWfcmrdJiwOxK+1PA10N29K6oNuPSTHIAf4MoFfq77+tT09OPGqxu21SP2UY0FP7rOLuI=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:33 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:33 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 09/21] commit-graph: verify corrupt OID fanout and lookup
Thread-Topic: [PATCH v4 09/21] commit-graph: verify corrupt OID fanout and
 lookup
Thread-Index: AQHT/CRuGfBgqO0lIk2m/ux8wei2OA==
Date:   Mon, 4 Jun 2018 16:52:33 +0000
Message-ID: <20180604165200.29261-10-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:ezbgix3M3KeNl+IguQ1mnvjmJE2xWI37jrsAIajj6xmDTBgiqJHUwhqQiYjlJQIMK5Erv+DJqTgFVQuVLAg81Rt9k5rPRQbhu00Mvck0QCjVSrMl0S0MZjwjFjcLB+LJhEI6xjYpqzmMQXSnAy5fIUEMPxJT/dqkQTwirssHZUOKkSI5Q0N81CRvUezqZOoYzaeTcQEwnVYoKr2eL1MMxs/bcHoU/iGoWCryaHIdlT/RmSWluQqtf+E4U6EytCah;20:Q+zdDCLaE7lNqy1K+/pwAX7EOAuK8GGB4dXPUR8imXUATy93myV7HQY8Rmbc2FzQ7MVmB3BKkjSJW/hleSDYqCVVcRY/UwScOWiD/JLYG9hhAl9+EB+1iW3HHzahL+OQyR6jRNqmOWBTVxyfjjN89GU7g8GhFTEyUU8V/VNWAQo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1129E91300CB9AE298F042C7A1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(15650500001)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JG4y1v9oC3ynnvGXD/TGwY8QxC3Y9/TczJWth1nUpp6UvJYofxNV9d6KYCvEZVuXjjsZrRiGY9kp3t4hm5mFuUk0domCOQgFvZxjlsiY6pGK4vk8G7XMbSNof+jAHPZDBh9JfFX124EYC3sNVGxbBvBEdiz32io2iQ6IZj/Uj8UkqxNn6YgKehtPOTEgN3z/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f376373b-d00b-41cf-8b2a-08d5ca3b90ee
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f376373b-d00b-41cf-8b2a-08d5ca3b90ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:33.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commit-graph file, the OID fanout chunk provides an index into
the OID lookup. The 'verify' subcommand should find incorrect values
in the fanout.

Similarly, the 'verify' subcommand should find out-of-order values in
the OID lookup.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 25d5edea82..a90cc2e6f4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -840,6 +840,9 @@ static void graph_report(const char *fmt, ...)
=20
 int verify_commit_graph(struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
@@ -854,5 +857,38 @@ int verify_commit_graph(struct commit_graph *g)
 	if (!g->chunk_commit_data)
 		graph_report("commit-graph is missing the Commit Data chunk");
=20
+	if (verify_commit_graph_error)
+		return verify_commit_graph_error;
+
+	for (i =3D 0; i < g->num_commits; i++) {
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
+			graph_report("commit-graph has incorrect OID order: %s then %s",
+				     oid_to_hex(&prev_oid),
+				     oid_to_hex(&cur_oid));
+
+		oidcpy(&prev_oid, &cur_oid);
+
+		while (cur_oid.hash[0] > cur_fanout_pos) {
+			uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos=
);
+			if (i !=3D fanout_value)
+				graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D =
%u !=3D %u",
+					     cur_fanout_pos, fanout_value, i);
+
+			cur_fanout_pos++;
+		}
+	}
+
+	while (cur_fanout_pos < 256) {
+		uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos)=
;
+
+		if (g->num_commits !=3D fanout_value)
+			graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D %=
u !=3D %u",
+				     cur_fanout_pos, fanout_value, i);
+
+		cur_fanout_pos++;
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 846396665e..c29eae47c9 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
=20
+HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
 GRAPH_BYTE_CHUNK_COUNT=3D6
@@ -258,6 +259,12 @@ GRAPH_BYTE_OID_LOOKUP_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFS=
ET + \
 			    1 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
 GRAPH_BYTE_COMMIT_DATA_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
 			     2 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_FANOUT_OFFSET=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+		       $GRAPH_CHUNK_LOOKUP_WIDTH \* $GRAPH_CHUNK_LOOKUP_ROWS))
+GRAPH_BYTE_FANOUT1=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 4))
+GRAPH_BYTE_FANOUT2=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 255))
+GRAPH_OID_LOOKUP_OFFSET=3D$(($GRAPH_FANOUT_OFFSET + 4 \* 256))
+GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8=
))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -312,4 +319,19 @@ test_expect_success 'detect missing commit data chunk'=
 '
 		"missing the Commit Data chunk"
 '
=20
+test_expect_success 'detect incorrect fanout' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT1 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect fanout final value' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect OID order' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ORDER "\01" \
+		"incorrect OID order"
+'
+
 test_done
--=20
2.18.0.rc1

