Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06A71F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDQSLB (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:11:01 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:9760
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752682AbeDQSKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WdakhPdAgKUkHvcitBm+qWzVRi576zQ4zRYdQDnyXoc=;
 b=SrLmSQrSZqwOreHL2fQ8zb0tn+sQFm1rnxCeue5LRi6GazfBKbM2otjPskr1VvVE/01Qd9c6EZeiRX8V4F6qWuh+/+TQVH33LC5fg0TrQ99PWV2egPF7MWstPdgIoc/b2Nd6QdVPrQR/aCsSUuDTl5WZEn0nA+nHAhA3J1pE0HU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:44 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:44 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 09/12] fsck: check commit-graph
Thread-Topic: [RFC PATCH 09/12] fsck: check commit-graph
Thread-Index: AQHT1ndmQFG+l5GUBUCcFs016GKVVA==
Date:   Tue, 17 Apr 2018 18:10:44 +0000
Message-ID: <20180417181028.198397-10-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:Ss8HBvtji9hu1Jde2Gv9IR7jYMmzpL9//h37CZLrgfeKfBkBWeUblIoZxeHxJjRH97nH8QEAq1XjDCJuF7oCmxi7W1eY3UECIqpV3Dr+VZQJOmn9/1IIkY8Aufmweum53XrWLE2sMWiu+4bjGXLP9S/ngXBjBvQmpnQWg4/Gm4xwixfDUkWeA5YT0QbLjTUS9iNsMmdS16oQGtDKue3kmuMo67lG6ANuF1hCG6KX2LqO+nM/qo1aNbswXpFfUzHi;20:yUmuyhkSuK8siXiGWHy3mRYdx1svc3IMjv6xb3BPv1+hVjZhHDFGypJnwZv894c/Xr8+wpMZ/wGBY5/UereUg1Xwptz1tNGesRMz8Xh2HVVrb/h7c0R4rlKrZn1tHcG/hsYKOQdLSTByQhuR3oM3s+3lTh6qffNkWQcw0o32dOU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0994036CBA3A769ED4C67ED9A1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ufnitJl8yFj0QpQEvt0VwPo1L6Q0zeqarJiN875HRJg8NKfPGX0cr/slY9Dy/VWCHSWD+kEvSnvZfxZQv71FzIyr/s/gPpRf8lA1b0ulsf84apLnK3M0Oxnp1Wr1DlEC+yWK53gESL1AF+SVo45oDKLF24wRiVSntddiHbBORhv9PZ03pgWERSrBFjdFwJ4N
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d47cc546-a770-4c7b-a9f9-08d5a48e892d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47cc546-a770-4c7b-a9f9-08d5a48e892d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:44.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit-graph file exists, check its contents during 'git fsck'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fsck.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ef78c6c00c..9712f230ba 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "run-command.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -45,6 +46,7 @@ static int name_objects;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 #define ERROR_REFS 010
+#define ERROR_COMMIT_GRAPH 020
=20
 static const char *describe_object(struct object *obj)
 {
@@ -815,5 +817,16 @@ int cmd_fsck(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	check_connectivity();
+
+	if (core_commit_graph) {
+		struct child_process commit_graph_check =3D CHILD_PROCESS_INIT;
+		const char *check_argv[] =3D { "commit-graph", "check", NULL, NULL };
+		commit_graph_check.argv =3D check_argv;
+		commit_graph_check.git_cmd =3D 1;
+
+		if (run_command(&commit_graph_check))
+			errors_found |=3D ERROR_COMMIT_GRAPH;
+	}
+
 	return errors_found;
 }
--=20
2.17.0.39.g685157f7fb

