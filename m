Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806F61F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeFHN4f (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:35 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752724AbeFHN4d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS/aZpQKvxwwTO340kycuvOlHmqh6D/7mZG41N1uy9M=;
 b=G1iUi0DVzbbnH9h5Dlhpvrh03YLTKpaNhDbsXhWAvjj4PHguovfyoRqXMAf/s2a9h3qoD/4Wqz6FYfEVyBtoj+/mE3e2IEt3J3CMh4urkBHz3mpM/CFnQBfyman98/nxlS18O0SJeOp2f7y7kZ32c7gCqD2C9L5fzpMtHs5HwyU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:26 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:26 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 16/21] commit-graph: verify contents match checksum
Thread-Topic: [PATCH v6 16/21] commit-graph: verify contents match checksum
Thread-Index: AQHT/zB9A8xvszybDkK2Icdfydt2hA==
Date:   Fri, 8 Jun 2018 13:56:26 +0000
Message-ID: <20180608135548.216405-17-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:5vuYywX0pl94fK7AeFGr2+w5aLexPfdbfSRom6MGSlf0AK73oXI2W9lMIs/wdhPVbAjvyt+zmZjJBwMfW0ThhoSnxyUbC0HoN3JcrPe0UeHjavpbUJmqWNeRFVfkO0LiW3KG7lYtrGQuooiZ8od6e+PehMly12y+v0gz8BfrvKCt7ex+jyY/zr2cHY5ax8jU9kAD5Pqy5QEaCIpBqs5NfdXylHm7Az1pJTjOD5JOYOfMfdAHw1lFaMLZjAm64zqV
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0963A5F83A16D346870822D3A17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(15650500001)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0HxK3yvab+mkQOIOqsj+Euuk0jeCpR/YiBSxUpOX28rez+rrkRnPbexS6F9r1D49NCAAw1UqEMlD3b4NlBCvGDaMIQpDQ0dJAexkZG++BTkwSJJxVCcktCB1i8dWHVE5P7rrWCZ3JHoCycJtsyFZbBCgJ4t5AMPd1JwMQDadY23V9nKBbno+3PD+Zpdy7rZi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c461cfa9-cbb0-4ea7-ffeb-08d5cd47a05c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c461cfa9-cbb0-4ea7-ffeb-08d5cd47a05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:26.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
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
index 6d6c6beff9..d926c4b59f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -833,6 +833,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
=20
 static void graph_report(const char *fmt, ...)
@@ -852,8 +853,10 @@ static void graph_report(const char *fmt, ...)
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
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
@@ -872,6 +875,15 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
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
@@ -909,7 +921,7 @@ int verify_commit_graph(struct repository *r, struct co=
mmit_graph *g)
 		cur_fanout_pos++;
 	}
=20
-	if (verify_commit_graph_error)
+	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
=20
 	for (i =3D 0; i < g->num_commits; i++) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index cbd6462226..bd5b8428af 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=3D$(($HASH_LEN + 16))
 GRAPH_OCTOPUS_DATA_OFFSET=3D$(($GRAPH_COMMIT_DATA_OFFSET + \
 			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
 GRAPH_BYTE_OCTOPUS=3D$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
+GRAPH_BYTE_FOOTER=3D$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES=
))
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

