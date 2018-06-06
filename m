Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3314A1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeFFLhL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:37:11 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:10314
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751911AbeFFLgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5gsHRKDBbomD/aT5nanEXiT7oS+ND6PQ9WUZHEIzEg=;
 b=cN8Ek82lpwZns+qv0jikGko5bW6nvAhwk+3VuhpT3Et4LEj/xveosYxTQ4ZdK4dKSgDTFOhZr8/oWSQ2gkpY9tegfDPn6h9Q5wkEtYQhu/JxeiMmNs/6im9IiTq/+gTUZqt1Xo7y0oR3ELzOPjWTQHvKSQW3TF9BBRj9UjOlj3o=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:36 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:36 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 16/21] commit-graph: verify contents match checksum
Thread-Topic: [PATCH v5 16/21] commit-graph: verify contents match checksum
Thread-Index: AQHT/YqgfJB4xR5EOkW/H1n5BZ7Wgw==
Date:   Wed, 6 Jun 2018 11:36:36 +0000
Message-ID: <20180606113611.87822-17-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:/Qfvfbw7cR8GQWyb3Toi23Pnv/41I+a3BB+uo6LVPv0UA5O8uWgw8D/CCnxwelJ3+wQthXwuBTzGVTSd3MeyF4ksqKwW8P3n5Da6ZJEZR8mABAwNu+QNwv+KDBWix3N7L35qOTFpPMXgJgTpsps5zf3YhZpVFfosqHZt4kHFGVJq2hdOLTJPn60Fiog7oyxK8KW6s7Gvj64/jI6EI0C1qRr4fBImU9ktMUMhnk1cTY8EJipxatXUphuSyzDIPulf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10441479983D9C4DF1071E35A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(575784001)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cq10LpvPqtF6wkAoX7W2j0wFXtF0PcNbO2KabWixYLPt595Jb6qY7fgjscypU05IQ91VD9HCoUO0oj5goPw02NQFMuTNQ5zDVPS8eZ8+vZ2Dpc1suv8LCYG5Y1QWPXmmNEpgODyvGzL+QyPbJV+JN69Sn0NC4zFG6IZPARrZlsMBmuD6oUtrf4/iPn8h6e5c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9cb08640-f75d-4f93-8377-08d5cba1c2b3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb08640-f75d-4f93-8377-08d5cba1c2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:36.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file ends with a SHA1 hash of the previous contents. If
a commit-graph file has errors but the checksum hash is correct, then we
know that the problem is a bug in Git and not simply file corruption
after-the-fact.

Compute the checksum right away so it is the first error that appears,
and make the message translatable since this error can be "corrected" by
a user by simply deleting the file and recomputing. The rest of the
errors are useful only to developers.

Be sure to continue checking the rest of the file data if the checksum
is wrong. This is important for our tests, as we break the checksum as
we modify bytes of the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 16 ++++++++++++++--
 t/t5318-commit-graph.sh |  6 ++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d83f0ce5d5..0f93d5d864 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -832,6 +832,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
=20
 static void graph_report(const char *fmt, ...)
@@ -851,8 +852,10 @@ static void graph_report(const char *fmt, ...)
 int verify_commit_graph(struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos =3D 0;
-	struct object_id prev_oid, cur_oid;
+	struct object_id prev_oid, cur_oid, checksum;
 	int generation_zero =3D 0;
+	struct hashfile *f;
+	int devnull;
=20
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -871,6 +874,15 @@ int verify_commit_graph(struct commit_graph *g)
 	if (verify_commit_graph_error)
 		return verify_commit_graph_error;
=20
+	devnull =3D open("/dev/null", O_WRONLY);
+	f =3D hashfd(devnull, NULL);
+	hashwrite(f, g->data, g->data_len - g->hash_len);
+	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
+	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
+		graph_report(_("the commit-graph file has incorrect checksum and is like=
ly corrupt"));
+		verify_commit_graph_error =3D VERIFY_COMMIT_GRAPH_ERROR_HASH;
+	}
+
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
=20
@@ -908,7 +920,7 @@ int verify_commit_graph(struct commit_graph *g)
 		cur_fanout_pos++;
 	}
=20
-	if (verify_commit_graph_error)
+	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index cf67fb391a..2297a44e7d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=3D$(($HASH_LEN + 16))
 GRAPH_OCTOPUS_DATA_OFFSET=3D$(($GRAPH_COMMIT_DATA_OFFSET + \
 			     $GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS))
 GRAPH_BYTE_OCTOPUS=3D$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
+GRAPH_BYTE_FOOTER=3D$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 \* $NUM_OCTOPUS_EDGE=
S))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -393,4 +394,9 @@ test_expect_success 'detect incorrect parent for octopu=
s merge' '
 		"invalid parent"
 '
=20
+test_expect_success 'detect invalid checksum hash' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum"
+'
+
 test_done
--=20
2.18.0.rc1

