Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1631F406
	for <e@80x24.org>; Fri, 11 May 2018 21:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeEKVP3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 17:15:29 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:55296
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751865AbeEKVPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 17:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GdHJnlLtB0uOcf6Qxhdjst+3Qtk636GBSY3zCmVxGM=;
 b=if8sZMmHwIj+Ezany0QGDmOUyewWDU2GjasUEAlLRdmvar/9eDfSSSz3InXwwR5/pMkSevxcRHLACtX0YU5YBVRRFXJrhqrQXpNJwH9Nkq/s3oyn7yQ+9hpHyKgc+UWIvlbM9sPU9Bxwa9/WbKCKZLpdBbaV94kNtJZAJ26/Dkk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Fri, 11 May 2018 21:15:19 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Fri, 11 May 2018
 21:15:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 05/12] commit-graph: verify fanout and lookup table
Thread-Topic: [PATCH v2 05/12] commit-graph: verify fanout and lookup table
Thread-Index: AQHT6W0p5WHPwUf5nkuRfsoGkKrhUQ==
Date:   Fri, 11 May 2018 21:15:19 +0000
Message-ID: <20180511211504.79877-6-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:9vHXHJbMlnMubSsBVcr93aalxNoHLYHIR3kyhg+W+1ave3Wpw3WnFVIGX/Ret1EYyttLUAtaF74E1SAZjJ0f4VhdN9LvZtD3CAu4oH7UyKMnp9PU+qzPo63WHSWCkZhx9bmhnKnkyuu0MtiRsGGZ7ZbU1PYEgJ2Ze53Gu0Hd9S6zjVCAmbvOVs9/erTE5OBvZMAfzyxeztVA61AfByoDIWOTy3WNedwYlUkN7COcXbg4qTgX41y2ECFjrKtKVhjw;20:QooDXZpfi7fybAUkXUDpNl70+dNPsbNF9pOBDHP0pf9kszZcJkNH+eucV/PUQKUpdWApt5uBaH9OUwa+kOjb8d6Gt6Pr9XBTTusk36XzW1Ih2R8o6bmAcBOZJNJ3wQA6raGwN6M1u8JDUI+Ce1auTVOW0qp1cYnlxQF+EianjZE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09626F40EA5D08C6166A59EEA19F0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(5660300001)(39060400002)(316002)(305945005)(6116002)(7736002)(6506007)(52116002)(386003)(81166006)(81156014)(186003)(3660700001)(5640700003)(46003)(76176011)(54906003)(1730700003)(15650500001)(68736007)(6436002)(446003)(102836004)(3280700002)(1076002)(59450400001)(97736004)(2351001)(11346002)(22452003)(106356001)(99286004)(2616005)(476003)(2501003)(36756003)(14454004)(2906002)(8936002)(105586002)(107886003)(4326008)(8676002)(86612001)(6486002)(486006)(25786009)(10090500001)(53936002)(478600001)(2900100001)(86362001)(6916009)(575784001)(6512007)(10290500003)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DtsMA8NSnP5B7LDq8073MlDRomhJq8SIXfKkoE+u9jmbXq1FE7EcM6J/adjPfmGlYwQ+lLLjnESYuq2GU8DztKIiP0Xb6W2lm339A7oZCoEL5msNsgwEggzesD2PdNMRcdfLhSKsSpUUsM5blVYkTQ+wF6qrCqMh6WY3gzy1BUl9W2aHOnhVaYIoE4TyfYK+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9ca3f218-8816-4836-a5e7-08d5b7844c37
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca3f218-8816-4836-a5e7-08d5b7844c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:15:19.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While running 'git commit-graph verify', verify that the object IDs
are listed in lexicographic order and that the fanout table correctly
navigates into that list of object IDs.

Add tests that check these corruptions are caught by the verify
subcommand. Most of the tests check the full output matches the exact
error we inserted, but since our OID order test triggers incorrect
fanout values (with possibly different numbers of output lines) we
focus only that the correct error is written in that case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 4dfff7e752..b0fd1d5320 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -848,6 +848,9 @@ static void graph_report(const char *fmt, ...)
=20
 int verify_commit_graph(struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
@@ -862,5 +865,38 @@ int verify_commit_graph(struct commit_graph *g)
 	if (!g->chunk_commit_data)
 		graph_report("commit-graph is missing the Commit Data chunk");
=20
+	if (verify_commit_graph_error)
+		return 1;
+
+	for (i =3D 0; i < g->num_commits; i++) {
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
+			graph_report("commit-graph has incorrect oid order: %s then %s",
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
index 0cb88232fa..6fb306b0da 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -293,4 +293,35 @@ test_expect_success 'detect too small chunk-count' '
 	grep "missing the Commit Data chunk" verify-errors
 '
=20
+test_expect_success 'detect incorrect chunk lookup value' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 25 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep -v "^\+" err > verify-errors &&
+	test_line_count =3D 1 verify-errors &&
+	grep "improper chunk offset" verify-errors
+'
+
+test_expect_success 'detect incorrect fanout' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 128 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep -v "^\+" err > verify-errors &&
+	test_line_count =3D 1 verify-errors &&
+	grep "fanout value" verify-errors
+'
+
+test_expect_success 'detect incorrect OID order' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 1272 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep "incorrect oid order" err
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

