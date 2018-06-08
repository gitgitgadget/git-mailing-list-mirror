Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8A31F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeFHN5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:57:00 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751898AbeFHN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cppiyIKf0SnvSx++zJfkvCXqZsL2A6PTBmPxz0k9w6w=;
 b=Ln6lOSpiBpifzJOcHnDraVgCAXdf8lVBJMKYvzaEERosnTo24QLaCubES/OSuhS2rfNnEsz1Rm62DE0cOyYS3nZ0UmGupJMKrytwb9tvjD7t3LN6G9ANKMH7kh+gTX18N6TQSpoYR72VZnMQChCgXiIvff6EMDLlUY7YP8xtILg=
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
Subject: [PATCH v6 14/21] commit-graph: verify commit date
Thread-Topic: [PATCH v6 14/21] commit-graph: verify commit date
Thread-Index: AQHT/zB8G7tcvnqJHUmbublID7b8yA==
Date:   Fri, 8 Jun 2018 13:56:24 +0000
Message-ID: <20180608135548.216405-15-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:LL5B+jy4Lb+EiNCPwpFt/K0k4gMzgVURsUjUVQYdQF02J25ta8YIvBld2qH5OfLyg6+0/pithEv1Di0zD4ALgpgBPM1ueSIFX1RnXDIqDkohjIBxWdzn+1vMJ92K4DBbAZMJUwPLKl17tt8eHIVxf3W7LMrR4fHy4WuSsEJA+K/HxQPa6Tc+BA9Pj6uIdWAgfbiu9zBupqoSiRJ29J6Sh1gvXZHiZYnKwDF9B0uJLCz0mdih33nVak6l0v5XHpDN
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0963410DC1FB5068E938F336A17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(15650500001)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(575784001)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QOs7Npq8Udy272H92SBivkyYw79/Z45U/9b5cIazeFTrCJt5g6GVP9hXRNBgl9Qje43+3BXq2ffuwn6pwbPO364B3a3Pvl0Il/J61uwxNse9RrPtkiZF31ZATktqen4Itm/2HeP2lCZQh2fSc41FredqqcVUETcYQX+7roJtWKlMCmCcTQoUNZ7kdmxzyFen
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 323de5f9-2269-4886-454b-08d5cd479f4e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323de5f9-2269-4886-454b-08d5cd479f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:24.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 6 ++++++
 t/t5318-commit-graph.sh | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index e0f71658da..6d6c6beff9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -986,6 +986,12 @@ int verify_commit_graph(struct repository *r, struct c=
ommit_graph *g)
 				     oid_to_hex(&cur_oid),
 				     graph_commit->generation,
 				     max_generation + 1);
+
+		if (graph_commit->date !=3D odb_commit->date)
+			graph_report("commit date for commit %s in commit-graph is %"PRItime" !=
=3D %"PRItime,
+				     oid_to_hex(&cur_oid),
+				     graph_commit->date,
+				     odb_commit->date);
 	}
=20
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5b75c4dca2..b7b4410e75 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -273,6 +273,7 @@ GRAPH_BYTE_COMMIT_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET=
 + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
 GRAPH_BYTE_COMMIT_GENERATION=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + =
11))
+GRAPH_BYTE_COMMIT_DATE=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -377,4 +378,9 @@ test_expect_success 'detect incorrect generation number=
' '
 		"non-zero generation number"
 '
=20
+test_expect_success 'detect incorrect commit date' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
+		"commit date"
+'
+
 test_done
--=20
2.18.0.rc1

