Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6701F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeFDQwg (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:36 -0400
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:15301
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751473AbeFDQwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rm4ga7PhEFhvkOGawTzOQEzaDEfBf3Tl2/AywAkeG8=;
 b=KMfnVjRKdMin3V1eQBK+eUBrjerGVkPlCt9l8qTavvTcC+bel5ASUdr6L/RpUGD7HpwgXiXRsbtdI/7lW9ofU1aaEchD3xr3WAZRqmKA1NBMnNs7IrUdPUtCxhbAs11Im6h236Zo3a1YRMb6a939hVxy3+747ZiYIO8y84F9Mx8=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:52:31 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:31 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 08/21] commit-graph: verify required chunks are present
Thread-Topic: [PATCH v4 08/21] commit-graph: verify required chunks are
 present
Thread-Index: AQHT/CRtx2TYU5jCOkGRz3gxQ5DfYg==
Date:   Mon, 4 Jun 2018 16:52:30 +0000
Message-ID: <20180604165200.29261-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1129;7:nAbEeecHhWVPWNn92BZ1uy/aWqOZbEDM3Th2E4hmJtPx9PdUasjeOtuVhy/HbB404mXkhxqdRMuAnJUeqBPf2HLauVQ++BS6UG01be+Y1bbNA87kwguAayWGIeDebshGFiygGCsO50tzZSWPGDAecg8GiaiwRNpNtxjSKsooEOjnPewMXurnrzN+Gh0IGZYIuDzwNGazdjx0Ovkg6YgCOsxH12e/OJcBdyF0C/AelaL8I53rUsziacEwmyb8v4kL;20:2I60ygTXkpDS/b5a4Q9I6WOoLroV/DyjB09swOhtLGOfyKVkZ0yENaEjQxtbMLYFZgMIFW8x7GMz7hccCDC+v/bsPNe1JkiRnzROk0TCKhxDKSZa3/GT2vGbeYgj25+C5T1KzxjIF+eRtB0hYiXphuQ/S0N1He9bqfNDTUWaPpU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1129;
x-ms-traffictypediagnostic: MW2PR2101MB1129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB112976F4E9280991CA083D9CA1670@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1129;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1129;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(2616005)(86612001)(86362001)(106356001)(575784001)(105586002)(107886003)(22452003)(97736004)(53936002)(316002)(54906003)(6512007)(5660300001)(2900100001)(102836004)(305945005)(36756003)(2351001)(10090500001)(1076002)(10290500003)(478600001)(386003)(6916009)(14454004)(3280700002)(2906002)(5250100002)(68736007)(186003)(5640700003)(59450400001)(3660700001)(4326008)(2501003)(99286004)(1730700003)(6506007)(81156014)(52116002)(76176011)(81166006)(6116002)(8936002)(7736002)(25786009)(11346002)(8656006)(39060400002)(8676002)(6436002)(15650500001)(6486002)(486006)(446003)(46003)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rw4jHlg3oYs7VwCeWVp3tDpDXEuebi6rrSt1cFAMqHbaurJpbsv/KekQqgvEzlqH20g6Fh3RD2+2XnXq1R5AWyNIilaUULa6TiQvZCFplaI0170/frrhDF52rFjaGvgxdiG9gGQVxU7i4hJOE8OiyF/dyqU3AGY6nYXY2Jd3j4mteJ9NSSS8fWeJMmbDtCh7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fd4c1699-971b-4bde-fc65-08d5ca3b8f9b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c1699-971b-4bde-fc65-08d5ca3b8f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:30.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
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
index c860cbe721..25d5edea82 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -845,5 +845,14 @@ int verify_commit_graph(struct commit_graph *g)
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
index c0c1ff09b9..846396665e 100755
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
+			    1 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_BYTE_COMMIT_DATA_ID=3D$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+			     2 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
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

