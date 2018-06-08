Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790341F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeFHN5a (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:57:30 -0400
Received: from mail-eopbgr730112.outbound.protection.outlook.com ([40.107.73.112]:2144
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751719AbeFHN4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0owqcj3hgRL3j+r6qVBo8P+nY2PqBmBuLeHfzFKCSlM=;
 b=ZNIaNbtPV71zYaoBJbnvZ4yMoxRrs6wSYMUESk9hFYgrcD7ft7/x74BCHzm7LZqRoc0gd45Y/x/E9kjSjpGLLJzJCnATOsKddZiDVWdmUf+ZI5qq6GFm7Nd0iSuoUA5PEktx/TrFzPlhImNSCOouAnNRqmndLQqAWCQaFlckERc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 04/21] commit: force commit to parse from object database
Thread-Topic: [PATCH v6 04/21] commit: force commit to parse from object
 database
Thread-Index: AQHT/zB3B+bRvYIb406WvCqkbV7Vug==
Date:   Fri, 8 Jun 2018 13:56:15 +0000
Message-ID: <20180608135548.216405-5-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0979;7:2A1bDHTSuoqJKp5eM0hsJO4FMO458yb2Era5tPlNwAe1/+8A6BcptBO4pveI0zJyKQ9Nbl0hL8wJEC2IXsP9kUcjzJMDiJ/LzimoZWa39FN2q4Zu+x5xfZGi/9eHA6Xq0wL8/F6OuUut9kkTd5lbv1WTwzKJZ0S1upHIWHz+4q2ScjEGyhQgKe2KCkkvJxR0/fSS3rjSxVTAGuALn0wRqgcZWNGgw13U+76MAA5qdOJhv1eHd29FfCZRLxJtxkna
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0979;
x-ms-traffictypediagnostic: BL0PR2101MB0979:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0979AFDA0E7B9254569810F4A17B0@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0979;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0979;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(36756003)(8676002)(10290500003)(22452003)(2351001)(81166006)(1730700003)(8656006)(99286004)(5660300001)(6916009)(97736004)(14454004)(6116002)(305945005)(478600001)(5640700003)(86362001)(81156014)(476003)(316002)(54906003)(6486002)(6436002)(7736002)(2616005)(86612001)(575784001)(1076002)(186003)(3660700001)(2906002)(386003)(76176011)(6506007)(105586002)(46003)(2900100001)(4326008)(446003)(3280700002)(25786009)(102836004)(106356001)(68736007)(2501003)(39060400002)(6512007)(11346002)(8936002)(10090500001)(52116002)(107886003)(5250100002)(53936002)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cWcEl/G0yPFx02CS//9SyWzEtQ/c7C4Ura2xKZIGZ2zmOZNPuxXDOBkF4RqiiDTLFcSZJTs2P6ihgTvOYlxUncSu6fAJLU85Geaz4bhfC9MPGsCbqQOpAG1y+iY4346O9u26eYf6iBjRi3wYXQXgvYMB+EZmfue59YARiuxQzfYr0NudxQLNCJ5HXGRqLZSP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 45c99301-2615-4001-a822-08d5cd479a14
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c99301-2615-4001-a822-08d5cd479a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:15.8643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
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
index d53dc16d72..720c6acddf 100644
--- a/commit.c
+++ b/commit.c
@@ -418,7 +418,7 @@ int parse_commit_buffer(struct commit *item, const void=
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
@@ -429,7 +429,7 @@ int parse_commit_gently(struct commit *item, int quiet_=
on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer =3D read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
@@ -450,6 +450,11 @@ int parse_commit_gently(struct commit *item, int quiet=
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
index 3ad07c2e3d..7e0f273720 100644
--- a/commit.h
+++ b/commit.h
@@ -77,6 +77,7 @@ struct commit *lookup_commit_reference_by_name(const char=
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

