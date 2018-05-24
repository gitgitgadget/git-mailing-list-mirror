Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9631F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033661AbeEXQ1I (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:27:08 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031148AbeEXQ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tmoaxtV+YksPUWbuXXnCfab6KHEWCGx3YmBGjmsY7E=;
 b=VtpfrxldMtdgduFH4Vmudt2A704GbNJ4fHHebFdFJr+e4j99Y3OBjGR2AimkpHYnkiiAZfKyHdlyP4Z8vdr7yWwWdtWMjSXD1lvmzc5ifLfbAQbZxwHEVG7RlKe4Bzrf4f0liLeme+SsTokNGQVVdfa07n8k91H3dQITWchAxJM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:57 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:57 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 13/20] commit-graph: verify generation number
Thread-Topic: [PATCH v3 13/20] commit-graph: verify generation number
Thread-Index: AQHT83vjHFHSHns840CvJzdFbZPb1g==
Date:   Thu, 24 May 2018 16:25:54 +0000
Message-ID: <20180524162504.158394-14-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:CMx8U77UQzfpY/bnQzaLTWfsZozv0W5o9UPXuX27KCfTRxb7wTwNgsiVN9QofyEa1YeCcl7OchUh5bx0JJGN2NvICrtkRivgM4502HEfct3rQ5YHhkM6/FB5nvpzcl5DJ8oSm7Ii9drK0Db3ojJ0WC6CdCnNXIgitQN/m6wNkKTQs7dYCL8aLGg5QeKaUeuEB2Wr4RBiI7H96PxTBUJ5TdzwSJqFhzJgi4llGhrfMcWh6EydCJzx6KIYe/B9/fr1;20:vFjBGBnYpB4MHzqc6uM6ytJE3ZI/a9uMbuh11iTrywMWqZYirqFnAqsIUNjx2SJFBex+/aiEBC6gpKsUGnz2NKf6c0nzUA46Dr+4n2jFabXMNy0O6xvqSwDoGQ4KCdtIh/ZLXkBeR9kWzDdS0zciKpUGZHMv8vuEz4S53hz754E=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB109141BE5F84422CC9FAE82BA16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(575784001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6666003)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +J0c39BlFEXVa4EHjQaNqck25aLCIKvdDIpQKbuzEv9BXqKz/x60F5GQONz9MfMOMeCbd3xnsZ42Fyy2f0IugSRPWLLucwEGXib7Jw8szjFTFa0zchPZujZZRjVdVcRX99mOZdJw/OkSranxDGUBR1eOMgDzZ9xSE+VIBf8zjzfcg5tTWvZg76fsdClfV4Tr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: eda76bba-6a77-422b-a4a5-08d5c19305aa
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda76bba-6a77-422b-a4a5-08d5c19305aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:54.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 18 ++++++++++++++++++
 t/t5318-commit-graph.sh |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index fff22dc0c3..ead92460c1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -922,6 +922,7 @@ int verify_commit_graph(struct commit_graph *g)
 	for (i =3D 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
+		uint32_t max_generation =3D 0;
=20
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
=20
@@ -956,6 +957,9 @@ int verify_commit_graph(struct commit_graph *g)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
=20
+			if (graph_parents->item->generation > max_generation)
+				max_generation =3D graph_parents->item->generation;
+
 			graph_parents =3D graph_parents->next;
 			odb_parents =3D odb_parents->next;
 		}
@@ -963,6 +967,20 @@ int verify_commit_graph(struct commit_graph *g)
 		if (odb_parents !=3D NULL)
 			graph_report("commit-graph parent list for commit %s terminates early",
 				     oid_to_hex(&cur_oid));
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
index 12f0d7f54d..673b0d37d5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -272,6 +272,7 @@ GRAPH_BYTE_COMMIT_TREE=3D$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 4`
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 3`
+GRAPH_BYTE_COMMIT_GENERATION=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN=
 + 8`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -366,4 +367,9 @@ test_expect_success 'detect incorrect tree OID' '
 		"commit-graph parent for"
 '
=20
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
+		"generation"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

