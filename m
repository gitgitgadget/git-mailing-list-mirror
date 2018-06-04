Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09681F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeFDQxl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:41 -0400
Received: from mail-dm3nam03on0098.outbound.protection.outlook.com ([104.47.41.98]:14992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeFDQwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjRk79VgXiYiWgJn12+SS2vxnO2qMd7k84Oi+uCQ9Bs=;
 b=bbjsgdOIEUXV1JCCOsekash5GjHHBCSyYW/mBZD6dh1feRF0cD4IxPCjjTG//GvcOYeVnXab0R85fWx+axKBDZaqAvJhGqw96//MWIGecaCCb4AVL5H7wJVzkbTikqgpDco27KKUYvparMhWKS41svwVHQ2vSQubkT/QtHx6hjc=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:21 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 04/21] commit: force commit to parse from object database
Thread-Topic: [PATCH v4 04/21] commit: force commit to parse from object
 database
Thread-Index: AQHT/CRnFhjZ0M8XUUurTJHkKtU7ww==
Date:   Mon, 4 Jun 2018 16:52:21 +0000
Message-ID: <20180604165200.29261-5-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:H0cTvwNYdECKcr3Te+qlIgGcdGycmIdNcn0Lgdqy6FTMlr46inpb6UXqee6cEDp5/GGtrLaTF6AZjrC1UX/QA0V7ZKTLe3GRSyYz7mwgj11FFzYWmQ5vWwihIAfC2oNHdr9gQqM5BADN686TQNtQig7isD/RBKi3fUH5MrmY79HTd6bNCMa4Ps7HwAuUVmbG9HVOTdCRfK0ASzSAe//3hR27diZgpaxJI4yN8Lt1g8/tLB/T4ihW5Y/zy52U+O4k;20:DRIYwgV9aKaYQGpgT/L/Pi8r8yv1ssJJSasUiQpif7mBN8miVnkeq4GCPQxCoOiedqrbpegXT47iBMMxrsMfUFaFEBDOOQUvMNTAvngsDwnHvFEx93GmyDTpeIsZgfJOWVv9pWm0b+yppxOcci1cS5Ayi29riWjybApukC8Nzxw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB108193C0B0B7C9C9C153B59FA1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3+ttRrenoBt6GdGqD0jZ23s1LP1IhB97UkDYT4p35ezaFZBr29wpyQN9eOLUHrLQXyqzfg/2jGI3RGRn601rAVsxwBoHnVSBJk28R9gPaXJ90Lm02L7fx7mEuFZUfpJCakuju6IyELR9IBvEbHGJ40vnXUKz9jRAdLWvOCe9vyA27AI3UDy0kEOh2EkLarhu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d2ff5076-cd05-4d54-74ab-08d5ca3b8a24
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff5076-cd05-4d54-74ab-08d5ca3b8a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:21.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of verifying commit-graph file contents against the
object database, create parse_commit_internal() to allow side-stepping
the commit-graph file and parse directly from the object database.

Due to the use of generation numbers, this method should not be called
unless the intention is explicit in avoiding commits from the
commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 9 +++++++--
 commit.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 1d28677dfb..6eaed0174c 100644
--- a/commit.c
+++ b/commit.c
@@ -392,7 +392,7 @@ int parse_commit_buffer(struct commit *item, const void=
 *buffer, unsigned long s
 	return 0;
 }
=20
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int u=
se_commit_graph)
 {
 	enum object_type type;
 	void *buffer;
@@ -403,7 +403,7 @@ int parse_commit_gently(struct commit *item, int quiet_=
on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer =3D read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
@@ -424,6 +424,11 @@ int parse_commit_gently(struct commit *item, int quiet=
_on_missing)
 	return ret;
 }
=20
+int parse_commit_gently(struct commit *item, int quiet_on_missing)
+{
+	return parse_commit_internal(item, quiet_on_missing, 1);
+}
+
 void parse_commit_or_die(struct commit *item)
 {
 	if (parse_commit(item))
diff --git a/commit.h b/commit.h
index b5afde1ae9..5fde74fcd7 100644
--- a/commit.h
+++ b/commit.h
@@ -73,6 +73,7 @@ struct commit *lookup_commit_reference_by_name(const char=
 *name);
 struct commit *lookup_commit_or_die(const struct object_id *oid, const cha=
r *ref_name);
=20
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned =
long size, int check_graph);
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int u=
se_commit_graph);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
--=20
2.18.0.rc1

