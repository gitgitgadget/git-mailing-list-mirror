Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D8C1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeFHN5H (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:57:07 -0400
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:7405
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751643AbeFHN4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ+psWbWXp3EczlIHFoBaCjBA1y+Yy05/oZmn4hU/jQ=;
 b=FgzNkL2Abd6FK54rcFoP5Gq6bDplStC2OPhXkaVT9FM7I4nKltNgCsz/fz1rFw2xd6Y/NJttdMDl6X9XsUXbSRIvs5Gs6zx/RY9pBcqL4u+fibS8Y0M3n0wdzuT3yje0Xn3rKxJKTRHVCbHla2q6MgkcGb/RTM7lGRCxtkcrxfA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:19 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 08/21] commit-graph: verify required chunks are present
Thread-Topic: [PATCH v6 08/21] commit-graph: verify required chunks are
 present
Thread-Index: AQHT/zB5EhY+/z/KSUSaCHdjic3fOg==
Date:   Fri, 8 Jun 2018 13:56:19 +0000
Message-ID: <20180608135548.216405-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:RRpQrAD+laenqxzG28tb4WvphmhK//vOgMZiBOwhcHgud7mIfnd2G1sJY6TsSrcoCXlC1owcjssIO0eVAntNnOyMi2IOYe0D7oqJtpgLbYX/Ek1EAnvGGSqs4PCYHXDOkScXq3XnZCl3oqlKBjftTLkrMQlIhVUCt6o84WGKdCaX6iIeS/OOfXsMkWvSr+6PCwAfGYMe5uv3D8FK9W8VwYiTHwSOhE+BpMfRUYm0v+TtMo5mxUfLBCD/veqrvGig
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0979F73C6B5E32D0233B9A2BA17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(1076002)(186003)(3660700001)(2906002)(386003)(59450400001)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(15650500001)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FSUMyKtWp9CpYWGdehXoAY5LltzZFGCErveevjJcluru0/PsORS+Xr1lXhIEs25koutk27Q1N8/BawTuZTEL/GoTonNUupSYaFy5nd9EPT806VMXuRmlVUv4smXWiDnVJtAshX9dbRqvAnQJwtprJMIV/A0PgdsdH+6K2QXC5x9QLZa/R9hllWLQDMWEJssn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 324db8e8-50cf-48ae-92ce-08d5cd479c32
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324db8e8-50cf-48ae-92ce-08d5cd479c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:19.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
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
index 22ef696e18..f30b4ccee9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -848,5 +848,14 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
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
index 8f96e2636c..c03792a8ed 100755
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
+			    1 * $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_BYTE_COMMIT_DATA_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+			     2 * $GRAPH_CHUNK_LOOKUP_WIDTH))
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

