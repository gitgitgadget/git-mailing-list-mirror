Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2961F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeFFLgl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:41 -0400
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:12016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeFFLgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK0+fqF9cmHmKr0Q786aeUxNyBxSZyZESI4Dygp0nbk=;
 b=QN9Shbm7XlAAk8+j1OiV2r0Ba3PMYOHKPWtFo3/BtCZOBPogR7K4jfTnQgMiQ7ApCf/TD/jmjqW1SIbOLp24Tw4txilry+M5V3XNaBtO4YefWVmm6JKGj3iYDyJl/JSGV4jGZ4mMlp/Tvxn5YT4JoPPRZsx3OLPqLg7r8BDUX5Y=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:31 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:31 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 10/21] commit-graph: verify objects exist
Thread-Topic: [PATCH v5 10/21] commit-graph: verify objects exist
Thread-Index: AQHT/YqdQdWi3GB4U0ixVs5n3swMvQ==
Date:   Wed, 6 Jun 2018 11:36:31 +0000
Message-ID: <20180606113611.87822-11-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:400vT91aQnWczOXwD4OoE2AplcoARZQsOEusPmxcHkOeTepMhpDHcqhFWyjns9RZ21RuhDptE2gjQMazVJbfDd9oB7i1XbI6r0LL2pigorZeh/sFfJgNCOhmy9UZ3wD9NLXmDudk0xYavj9504C+67ECqHyWweRCvlvJ7WK7kt/h9Zg9AgwlAa6OZ6b3fNQsC2BkH9Oluw/smB9Ev32F/GYF7niB3vV86SCDHocxD82w+GecoVtiTsCPoySOxjCj
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1044BEADEC2DBB01CB615379A1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WblfeLn+Suw0ADFWHn/S4AdZkEVsD7u2FPtUEHaAMLbu6imkoVnZlRmmjzMW/QB4FkztRI7ihyISD1C3EEPCDKoJSyQgZcq+bxyzRU3jh3il/2NLH+E8JjNfOPboyBHvcuur07F9G+sUzv83lA7FwCxRe753ou0Q1BHwkxisp+1RRR8uCPCE0Ymi3Pw2S2nG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 08de5f8c-ed42-4807-c62a-08d5cba1bf7e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08de5f8c-ed42-4807-c62a-08d5cba1bf7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:31.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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
index d7a5b50a6c..893cc2f346 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -242,6 +242,7 @@ static struct commit_list **insert_parent_or_die(struct=
 commit_graph *g,
 {
 	struct commit *c;
 	struct object_id oid;
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c =3D lookup_commit(&oid);
 	if (!c)
@@ -893,5 +894,21 @@ int verify_commit_graph(struct commit_graph *g)
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

