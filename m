Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5331F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeFFLhT (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:37:19 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:10314
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbeFFLgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h2SMfY24YIbfOX8nq953Kz18CbHBrpwvUpqE3Ro35I=;
 b=dQG+eCprMDF6phFE36HII3rt8k0g6dIT11J3IAzSBLs6aysZtIKdxMWRNFbsVzwnwo4H32M1Z4/vpO7rBIiqezKyd601dqR7bVh0rc+G9ue9ud8ZJsFkYtIK/sVU+/sY5gozfaRMt+smTYru+/hf9Uvk6dne9RXs80aJP9UchYM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:34 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:34 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 14/21] commit-graph: verify commit date
Thread-Topic: [PATCH v5 14/21] commit-graph: verify commit date
Thread-Index: AQHT/YqfoCrhpt0zY0a3AHXjvugp/A==
Date:   Wed, 6 Jun 2018 11:36:34 +0000
Message-ID: <20180606113611.87822-15-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:Nn62Rrw+bz1kDNPvldydLY+iF08+PfFMrFQmXoKToLnfPRDtogydIyp5XdqHsw8WYs0TYNQCeh9XG1nylqRwWCPQB1BxPzTIqoU5cUMMv2hfG0c5x6hm/7d39moDuhvW4h4uF1qeoq25RdTS5e5svvWvdS+ZJ2qk6V1kGewWQtBETxasXwIAur7rKdiCFXaXkQBB0Iwy61DHIGwdTT9ZDnhC8BfW8T+eCGAZCL7oxbUuF+YbpWQwfawK2Ir4BlCn
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1044302603DA0C2D0401746CA1650@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(199004)(189003)(2616005)(316002)(22452003)(10090500001)(105586002)(86612001)(10290500003)(107886003)(14454004)(8656006)(1730700003)(52116002)(76176011)(6506007)(386003)(8936002)(478600001)(8676002)(106356001)(102836004)(59450400001)(81156014)(25786009)(2351001)(486006)(11346002)(476003)(446003)(54906003)(4326008)(186003)(305945005)(7736002)(2900100001)(97736004)(46003)(2501003)(99286004)(81166006)(36756003)(39060400002)(15650500001)(6916009)(5660300001)(5250100002)(3280700002)(53936002)(68736007)(2906002)(86362001)(6116002)(6436002)(575784001)(6512007)(6486002)(1076002)(5640700003)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4vTaPfj2hDlPtgXujsRb0Fe7Y9CsOU1VODzDjSPPvvs056JCebLeIH7IMYDvKfY+8/nbIQ6kK3Do+1gxmuEirQgHgvrERPUT0GgdtKiLkYteFqE4yPiKeWgPGXaSl883MOUu3IUW22F6ebGtL8umNL1+KOhG1tnzhtGuuRLacMdACeuA/jfZq/s7WE3TCJS+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e09a8a86-8838-48e3-94b9-08d5cba1c1b5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09a8a86-8838-48e3-94b9-08d5cba1c1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:34.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
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
index b97fa05ec9..d83f0ce5d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -985,6 +985,12 @@ int verify_commit_graph(struct commit_graph *g)
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
index a6ea1341dc..6a873bfda8 100755
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

