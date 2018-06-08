Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C968B1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFHN4d (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:33 -0400
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:7405
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752680AbeFHN4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Evq1eUq9yHvSBPjUtjc9kZK+8YMsf/ZPOdrPSMQNOU=;
 b=KyK0H++qzQ/oPDNVxoNkTmIoi9feLzz0R1jRAGKCN0nYTurksNwc+3D9yAkd1dQQ22/HXamIFfo2bh93kWBfG2fQ2BiJ5JSMkROq+PNVXKh3P5OYUU6yKWhGihKO3gXRzKt/h5TfJ1INu0txWpmCgUnMy4y7uF1lTi4yYwQaFpQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:21 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 10/21] commit-graph: verify objects exist
Thread-Topic: [PATCH v6 10/21] commit-graph: verify objects exist
Thread-Index: AQHT/zB6QnCkKm47iE+SC9TJJkNAOg==
Date:   Fri, 8 Jun 2018 13:56:21 +0000
Message-ID: <20180608135548.216405-11-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:UnjODyMHqFb1cMoI6tc6+0iwJfIoF43nhyN/BAm3TSL1/Jd+83LabU4abLwYKVdGic+D4HGgPjrPCmKKoo0AnqdMrHnlP72HVwSyGSrBuTezqgfBZfcvvVfl7Ir97R33ew0MQ4Ox57nK+xU2lf65Tefkw6A4OumK7zyNORuRrUZE6eQrjMEuVTeADVz5E21nWKCjxixVyoTFlUUYBen3ztNubWzJuJ1z50p6hMidQm63/fYVEyRgCtXXHtRd90Op
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09799625909B45E8FE350B35A17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(575784001)(1076002)(186003)(3660700001)(2906002)(386003)(59450400001)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(15650500001)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +lcEamB+evz4GORlSclMNfbRHJsFzImSyYFljGlrKl22JhwqrhrnXX6O+lm7HpcE1vZuwdMmyFcCBXfpnad8l/97CoG8EV1vbDFNiMVnUO1aC2X4hmiUbwolnK63APJtGIk9Lr8rPZ7inWOFIyxKl00o5UEBlKSem0hQfjJWt34vqykIMYs8TvWko+/auBR4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 26051c92-21d3-474b-8b8b-08d5cd479d35
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26051c92-21d3-474b-8b8b-08d5cd479d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:21.0890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the 'verify' subcommand, load commits directly from the object
database to ensure they exist. Parse by skipping the commit-graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 18 ++++++++++++++++++
 t/t5318-commit-graph.sh |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 866a9e7e41..00e89b71e9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -11,6 +11,7 @@
 #include "sha1-lookup.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "alloc.h"
=20
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -242,6 +243,7 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
 {
 	struct commit *c;
 	struct object_id oid;
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c =3D lookup_commit(&oid);
 	if (!c)
@@ -893,5 +895,21 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
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
+		odb_commit =3D (struct commit *)create_object(r, cur_oid.hash, alloc_com=
mit_node(r));
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
index 4809cc881f..af5e34c0cb 100755
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
@@ -265,6 +266,7 @@ GRAPH_BYTE_FANOUT1=3D$(($GRAPH_FANOUT_OFFSET + 4 * 4))
 GRAPH_BYTE_FANOUT2=3D$(($GRAPH_FANOUT_OFFSET + 4 * 255))
 GRAPH_OID_LOOKUP_OFFSET=3D$(($GRAPH_FANOUT_OFFSET + 4 * 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8)=
)
+GRAPH_BYTE_OID_LOOKUP_MISSING=3D$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * =
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

