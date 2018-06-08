Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7396F1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeFHN5G (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:57:06 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751604AbeFHN42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFQ9pddjlvzVyBjHqC2bWF3vMGzZdri4DFPcbErxsCw=;
 b=IWw4V+n4v3pXPXwhLm0GHVqTTDoRXJxzJM/crpmy4JjVnNvs1m+J/2srkiK24SWmqI2UEYJQfVi+iTM8FM0dK4g2S6IkJrH5gmfnWUqZZBvlbWtMh64C+/VfqE2JcEa44tNQrnRh/peocVvdEUuK1yYw1Ypb3qk2+C8cPEsKi6s=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:24 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 13/21] commit-graph: verify generation number
Thread-Topic: [PATCH v6 13/21] commit-graph: verify generation number
Thread-Index: AQHT/zB84oDekE91RkCGqVPvSLPk9A==
Date:   Fri, 8 Jun 2018 13:56:23 +0000
Message-ID: <20180608135548.216405-14-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:EiIlpvQR6BOGEUThe4ioO7hZCWauyP03mTy823dP156+aVsK/t7x4Al8WX0YvL7ciwbXVZNqP5fs8lvoFmmW2qsPeQfgDuPH3V+d6oPTGipiBlshksUmwvCoLWWig9BbxOdHfq+kVkg7WAqd7YCVyW5gtfJk5gyaRXQR4+mHtQ4UXEOmcqzIGcTwH8lA+zjN+49SZfv/9/FV2KRaAtNfvwadH8GVSLXJK5c/9k9oC+gBpAXrnKahneHLHjH/88XE
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0963B9A1F3052166A02F8961A17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(15650500001)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(575784001)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RmBULXdDNmBqJk/JIswxjuiso/WT9BDBy81OMMSTi9Nf6Ztt3FBfJq31GFxvYVfhOrH38lTrtOCz4Jz0O9KYllYGt6PbCnAoWo0iVuUGhriNXj5L9jQkkpUI0g/0/bL+u8Uieq6mgHaDw2S6IimEafhLjL1ZQWyi58d2hfGm7rB8Htpr7Vl4Ls5vyBx8WL4a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9086dae8-2ceb-498d-3e06-08d5cd479ecd
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9086dae8-2ceb-498d-3e06-08d5cd479ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:23.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While iterating through the commit parents, perform the generation
number calculation and compare against the value stored in the
commit-graph.

The tests demonstrate that having a different set of parents affects
the generation number calculation, and this value propagates to
descendants. Hence, we drop the single-line condition on the output.

Since Git will ship with the commit-graph feature without generation
numbers, we need to accept commit-graphs with all generation numbers
equal to zero. In this case, ignore the generation number calculation.

However, verify that we should never have a mix of zero and non-zero
generation numbers. Create a test that sets one commit to generation
zero and all following commits report a failure as they have non-zero
generation in a file that contains generation number zero.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 34 ++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 6d8d774eb0..e0f71658da 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -846,10 +846,14 @@ static void graph_report(const char *fmt, ...)
 	va_end(ap);
 }
=20
+#define GENERATION_ZERO_EXISTS 1
+#define GENERATION_NUMBER_EXISTS 2
+
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos =3D 0;
 	struct object_id prev_oid, cur_oid;
+	int generation_zero =3D 0;
=20
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -911,6 +915,7 @@ int verify_commit_graph(struct repository *r, struct co=
mmit_graph *g)
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
+		uint32_t max_generation =3D 0;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -945,6 +950,9 @@ int verify_commit_graph(struct repository *r, struct co=
mmit_graph *g)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
=20
+			if (graph_parents->item->generation > max_generation)
+				max_generation =3D graph_parents->item->generation;
+
 			graph_parents =3D graph_parents->next;
 			odb_parents =3D odb_parents->next;
 		}
@@ -952,6 +960,32 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
 		if (odb_parents !=3D NULL)
 			graph_report("commit-graph parent list for commit %s terminates early",
 				     oid_to_hex(&cur_oid));
+
+		if (!graph_commit->generation) {
+			if (generation_zero =3D=3D GENERATION_NUMBER_EXISTS)
+				graph_report("commit-graph has generation number zero for commit %s, b=
ut non-zero elsewhere",
+					     oid_to_hex(&cur_oid));
+			generation_zero =3D GENERATION_ZERO_EXISTS;
+		} else if (generation_zero =3D=3D GENERATION_ZERO_EXISTS)
+			graph_report("commit-graph has non-zero generation number for commit %s=
, but zero elsewhere",
+				     oid_to_hex(&cur_oid));
+
+		if (generation_zero =3D=3D GENERATION_ZERO_EXISTS)
+			continue;
+
+		/*
+		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
+		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
+		 * extra logic in the following condition.
+		 */
+		if (max_generation =3D=3D GENERATION_NUMBER_MAX)
+			max_generation--;
+
+		if (graph_commit->generation !=3D max_generation + 1)
+			graph_report("commit-graph generation for commit %s is %u !=3D %u",
+				     oid_to_hex(&cur_oid),
+				     graph_commit->generation,
+				     max_generation + 1);
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 9a3481c30f..5b75c4dca2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -272,6 +272,7 @@ GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
+GRAPH_BYTE_COMMIT_GENERATION=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + =
11))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -366,4 +367,14 @@ test_expect_success 'detect wrong parent' '
 		"commit-graph parent for"
 '
=20
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\070" \
+		"generation for commit"
+'
+
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
+		"non-zero generation number"
+'
+
 test_done
--=20
2.18.0.rc1

