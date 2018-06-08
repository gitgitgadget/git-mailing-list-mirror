Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1331F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeFHN4v (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:51 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752712AbeFHN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOXmNT87k1nRtaXfG7Frjm4dyYCbnCWxcWStj2uerVY=;
 b=BU5lDm8wlA9OsK4ovH35/u5qB2qmJDAEW1JOYvKy2CJA+zwZJfWwgZejh8uTAyYa7RZHQqRY4UkmzkHjrMXdI/eP3VqUlhvsR3O4aa+tgV80XRb5kOQUCy91U5sADjMzw2H8XpVPIxeSp3VqAulN9QSRmB+4Z/AyjLDaX/G1xDY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:25 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 15/21] commit-graph: test for corrupted octopus edge
Thread-Topic: [PATCH v6 15/21] commit-graph: test for corrupted octopus edge
Thread-Index: AQHT/zB9SOmlj7KtIEqyq3iu8aBXag==
Date:   Fri, 8 Jun 2018 13:56:25 +0000
Message-ID: <20180608135548.216405-16-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:Y5OywTqsGAOghS/8iHhImiYpAX6DOLdsOa1JFUSfAGc6da5C92O1TXvO7R6Bdh3Z6yIgudFu496BBjsa62SXIDDeareSYjd7i5d51W2YR+WDq6tjgzbSS5SmsDlMpPLCyvZJI/IkHpgQP+xESqH7yMScILtNmQ9tHTDFiyZdSRfVWsgR3uyDiLWt6+jTN1qDm6ajJ3QQFvft8PUfpUwe1j/yzhrPle64JYPvk9RPrXtWGZWw2JD5xM02dp2rbelz
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096379298D056F5D4D5593DBA17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7VVEr5apCAbC5Ca75l7VvbE/zI3gC5uD1gSwzSLNqA6fIvjAEdw6mdPl7ohEyYQGiM7pydtYNCZ0qz54/fI/kfpjr8oe/zIvgWruMvFamsZNkhGmAAvxUSrdB9OHjuS0vD9Mi3JV1srDpBCNgIVpkJyE2ufEBE2CEE0LgBighzEwQ0TgifiBa6Z9M960qlV2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f99ac5ec-3ebf-40fe-7375-08d5cd479fcf
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99ac5ec-3ebf-40fe-7375-08d5cd479fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:25.5421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file has an extra chunk to store the parent int-ids for
parents beyond the first parent for octopus merges. Our test repo has a
single octopus merge that we can manipulate to demonstrate the 'verify'
subcommand detects incorrect values in that chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b7b4410e75..cbd6462226 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -248,6 +248,7 @@ test_expect_success 'git commit-graph verify' '
 '
=20
 NUM_COMMITS=3D9
+NUM_OCTOPUS_EDGES=3D2
 HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
@@ -274,6 +275,10 @@ GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D$(($GRAPH_COMMIT_DATA=
_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN =
+ 3))
 GRAPH_BYTE_COMMIT_GENERATION=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + =
11))
 GRAPH_BYTE_COMMIT_DATE=3D$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
+GRAPH_COMMIT_DATA_WIDTH=3D$(($HASH_LEN + 16))
+GRAPH_OCTOPUS_DATA_OFFSET=3D$(($GRAPH_COMMIT_DATA_OFFSET + \
+			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
+GRAPH_BYTE_OCTOPUS=3D$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -383,4 +388,9 @@ test_expect_success 'detect incorrect commit date' '
 		"commit date"
 '
=20
+test_expect_success 'detect incorrect parent for octopus merge' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OCTOPUS "\01" \
+		"invalid parent"
+'
+
 test_done
--=20
2.18.0.rc1

