Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFE41F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeFDQxZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:25 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:13120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751554AbeFDQww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF6Kz5NiB0xUnv34WCGaPfqcZn0v6kZDrulggaJSpAM=;
 b=kpvwxKcRh4Y99tTX7vXxpBX+OckgYtUAcZyhsK/pxLFi14bk7Zs3z5ixE8cPDmKUtYMnYkim6gmRO+tcLU0g4+2YKXyKoZ8gn55vCggc6RuabOER9N/pahusCSUUMOvS8C7GgIQIvi8c8ACv4mrbd4EpmUQHX8p2JRxF6TQE60I=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:50 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:50 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 16/21] commit-graph: verify contents match checksum
Thread-Topic: [PATCH v4 16/21] commit-graph: verify contents match checksum
Thread-Index: AQHT/CR5hbr3WlEOvkqpDKHwOeVs/g==
Date:   Mon, 4 Jun 2018 16:52:50 +0000
Message-ID: <20180604165200.29261-17-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:p+/Mg7jGGKW2L/KY5ga3ji1IC+02lARPinlcM5AO1wX1jQxDGYqluB7GpN8sBTUv1djZ04CZoAat8PbZXErh1Qa9NVrku0JUZz8Irz+Iywj3JvNEJS8hHAVXJ1zh6bHnATQUz2uFrhBHfUBAyCA6P3xz+1j2he5diP39wl/pMGGrzTe2YE3p922jFJpwu7GxMTei97C0nXYIAHnt/snnGHRUlcWrAKp2gPtHbZ/8WjCDDodlM6RmFQHXtI0U7lxW;20:hqW6bQ6HhsWmETmKl2GRAxX/YfqfFVLUt1Q6ArBUQ8IXoFxoV7IRC7unEMskkEz8+Lg2dAcmZfMH+P56eVq6coO32DHG323y/XpTgsoTU/2Cya3oc/D0s7JCebN7he/Klci4hju8G/QMrbqumkEuuSDBMdK/LYtukqLX9ItywUw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB108162B507D3DC7F349ED916A1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(59450400001)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(15650500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0gl+U7V10A/lvVvz+7VkDwL7ID1jjTFA5rvMx8yElpRtGxEMBfzfuxwfr/r2IaEW/4BZ+ZbumUMyddMdL4JRVGyoUMG7RHha4GJtV+N+LiqhH5EmcZOgrsgHUjMTUwhkLM8QW02Kt2yMQackpAYW3Oxgusm1qqfh21d7t8mcUA2vN/jYHOv4EUioTR/Fko/S
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 203934aa-af7e-482c-3dd4-08d5ca3b9b5f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203934aa-af7e-482c-3dd4-08d5ca3b9b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:50.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
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
index 47fdd62e88..05879de26c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -829,6 +829,7 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
=20
 static void graph_report(const char *fmt, ...)
@@ -848,8 +849,10 @@ static void graph_report(const char *fmt, ...)
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
@@ -868,6 +871,15 @@ int verify_commit_graph(struct commit_graph *g)
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
@@ -905,7 +917,7 @@ int verify_commit_graph(struct commit_graph *g)
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

