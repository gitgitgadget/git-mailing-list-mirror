Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B021F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966766AbeEJRej (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:39 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966701AbeEJReM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cHdu8xp3Z6KBBsKICYRlSCh+mgHn7rWm6HNYZXeL9CQ=;
 b=PT1tgk4inus6FKWTcCim7gS46NMTkcplib41Dz3lbvo06B1loqN8VrvF7mF+MAmL4jQ4BuLDcHhCSJx20tjCupQpAnzLa+LtrYxoW5Ju46qWGnxZviPAJgIYCyCkVnu+x9XBXXDriRH3lz0Cx9ZIakrdn9nxV2keltuPqplFLOA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:08 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 05/12] commit: force commit to parse from object database
Thread-Topic: [PATCH 05/12] commit: force commit to parse from object database
Thread-Index: AQHT6IUZvPoScHrs1U2hvc+nD9tOWg==
Date:   Thu, 10 May 2018 17:34:08 +0000
Message-ID: <20180510173345.40577-6-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:d4b0oKz0+YUvaYnatGyf1QUCnP5q2NQoxvy4PuRyn8ShkIgsXs0XQlHq0WPe+pMWgfHRVfKfSyKxmAga79Nmmx3RpF/tzt1JJO57WHbk5jozshe/CXukXb86B0QvFccB2QweGCaRDxGpCpDgPIGD3tb/gbw6PwW42FponfntwrqsjxPcyo+rVEngbMDf0NZH1/HDR8Y50FGTkOCLrKceHdFs7D2BjI0TrsKTEbsupUJzWSi/mLbwVcM4CL7k8BpV;20:PQznM6RXJpdpG7kvfrW4GR2rhDw6ahv3n7WUtzxFO+Cfm1Fvzy9PHggN4t/9RBr6DSIKvKHuc+bYUHMkyyFYMes1qf8RXXwYDZf3XP++44WQywaeIt+rt9T/KPzUPwTEXtpT9Eb9y88y6BAeU0WK1BQkKrJYh/Y213/3/WNgo0c=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09627426241FCAAC83C7E709A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7I8J5guZWYDaLrYWxk2og9ppfu8P74s05cJ8oj33unHY+MwTiTBzf5meI3L02u4QsgnzSpTWbODdlUdYjQKaD+bdsl1nSGWZxdF2UqSI6BtxkyE9uN0RgWGf6Nv9slm3fYCwHlxYYUXWABvu9njK/zvJqY3UpJjH86wekVzOS0IMmJj1iBVvcTWt2/9nzFCb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 727b1088-d6f4-4519-46a5-08d5b69c3c02
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b1088-d6f4-4519-46a5-08d5b69c3c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:08.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of verifying commit-graph file contents against the
object database, create parse_commit_internal() to allow side-stepping
the commit-graph file and parse directly from the object database.

Most consumers expect that if a commit exists in the commit-graph, then
the commit was loaded from the commit-graph so values such as generation
numbers are loaded. Hence, this method should not be called unless the
intention is explicit in avoiding commits from the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 13 +++++++++----
 commit.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 1d28677dfb..7c92350373 100644
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
@@ -403,17 +403,17 @@ int parse_commit_gently(struct commit *item, int quie=
t_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer =3D read_sha1_file(item->object.oid.hash, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
-			     oid_to_hex(&item->object.oid));
+					oid_to_hex(&item->object.oid));
 	if (type !=3D OBJ_COMMIT) {
 		free(buffer);
 		return error("Object %s not a commit",
-			     oid_to_hex(&item->object.oid));
+				oid_to_hex(&item->object.oid));
 	}
 	ret =3D parse_commit_buffer(item, buffer, size, 0);
 	if (save_commit_buffer && !ret) {
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
2.16.2.329.gfb62395de6

