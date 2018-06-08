Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD641F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeFHN4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:18 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:42112
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751643AbeFHN4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX+swzDctrL0y1U7LX6CaICybm842OAodyTZeopB6FU=;
 b=KGg/Mfcld4hVb5YlBt5BjhbVAHrlRc3J9W6MrWzi9tmt5Pm3hLGAMnmsWFxqG0/DfG9JcnEyaBZ1MFI0dMGgxzDy5glkn+zSqyS6t2NhA27q+4F+guPUJoKOfDDQKIymPW9lilANq+npQ/dcpvnKU6gzf+KcRAD5BdW0tdBSz8w=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:14 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:14 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 02/21] commit-graph: fix GRAPH_MIN_SIZE
Thread-Topic: [PATCH v6 02/21] commit-graph: fix GRAPH_MIN_SIZE
Thread-Index: AQHT/zB2RW7y8YVJhEWRLebL1eixVg==
Date:   Fri, 8 Jun 2018 13:56:14 +0000
Message-ID: <20180608135548.216405-3-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:VPLvGOuvQZBlpvU7zEJRHUMmabGzK0lrhkh0NZBmMSH7SEKsa6DkdTEZoNv4Fp2+n/THYol2Z5ITIxq0wgun3mxzIoSGiboQ2AmzHqog4C2NK286+T47owyAtPY68popjJntWIa2++SjsJOYF4cfhsReTO34AHEJMxPZXeOi8YHyCL/W6a0GvHteUe/sUBiOMVOPyOPW1a/K6YOUEkoqNxB5X3PvW4lfFeuoQzMazFuuOsKOki5Pnf4TlE4U/gwn
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096310F1A7DFA3280F3EC292A17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i0cn8uuXUaXky3a2ZPQ5gqeql8u+DTBpa+Xm2/MM+tOuxbxCMP+GpR5JUWsXK8S7mkGYYlRCcp4/N5G6WZvCSl1AatdRc4++RjjrWRLgoB3NT+W5prCI8GkiBpfy+YLAkqf5PRcC7QkoOqtQKTZRh+Y50y5gFaUjDIK7tzlG56J1+m448EV/0xXaopNc4QE2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1c6b7898-7c87-49bd-2e96-08d5cd479917
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6b7898-7c87-49bd-2e96-08d5cd479917
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:14.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GRAPH_MIN_SIZE macro should be the smallest size of a parsable
commit-graph file. However, the minimum number of chunks was wrong.
It is possible to write a commit-graph file with zero commits, and
that violates this macro's value.

Rewrite the macro, and use extra macros to better explain the magic
constants.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b63a1fc85e..f83f6d2373 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -35,10 +35,11 @@
=20
 #define GRAPH_LAST_EDGE 0x80000000
=20
+#define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
-#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + =
\
-			GRAPH_OID_LEN + 8)
+#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
+			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
=20
 char *get_commit_graph_filename(const char *obj_dir)
 {
--=20
2.18.0.rc1

