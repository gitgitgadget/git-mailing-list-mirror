Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5980F1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeFFLgg (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:36 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:22720
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751828AbeFFLga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtfrBBLg7hWXheX2hHCImgUiOTegzGUZonaOSe8ck+g=;
 b=XbZKku+n5my4Vns1JL9BTH1dUy0GjyPwub0WS1OiUUcLvgf+/EFe52NWXCeDr8DkDJnpxidqxlYyeaG4t9uXQ+mj24OjotMyS1b7RD1n5qwZPRpVJi14QJgaCdUjZ8ynJzw0zjeKeAXAYvOEJPtdkc+hWFKT+uwKsBiet81T308=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1075.namprd21.prod.outlook.com (52.132.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:26 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 04/21] commit: force commit to parse from object database
Thread-Topic: [PATCH v5 04/21] commit: force commit to parse from object
 database
Thread-Index: AQHT/YqZ64Ex5TsidUKjjYPFWAu0/Q==
Date:   Wed, 6 Jun 2018 11:36:25 +0000
Message-ID: <20180606113611.87822-5-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1075;7:2614iLJgQ2viF4w0xOkh3eDw5vuxwTWTa4ZnKafW0mDr9P0WibO0+h/V0fNI4x5GrFJWDlloumwIqKb51odhJRkaeSsDY6DKEdfBSbSnZr629cqYOm4YnwF0EQzeexzbVvjcyNrwxD1Q5BMbBwtVi8G4PCRtfa9d6/q1PMqJJNQzcq/IkbtyhDEGz7a4ORbPD4ZUMG+NH5WPtdgQHzR9r6Ejqj/h6gJiqK5XaBwDh7mr1HdybdYZ3+aK53/4v+AJ
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1075;
x-ms-traffictypediagnostic: BL0PR2101MB1075:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB107500DBBAE1F84A5789CC8AA1650@BL0PR2101MB1075.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1075;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(376002)(396003)(189003)(199004)(99286004)(476003)(22452003)(14454004)(8936002)(6916009)(97736004)(2351001)(5660300001)(486006)(6116002)(81166006)(86362001)(478600001)(8656006)(1730700003)(81156014)(54906003)(6436002)(446003)(86612001)(2616005)(5640700003)(10290500003)(8676002)(1076002)(11346002)(316002)(6486002)(186003)(4326008)(3280700002)(305945005)(25786009)(53936002)(105586002)(10090500001)(106356001)(2900100001)(7736002)(3660700001)(46003)(2906002)(6506007)(39060400002)(68736007)(386003)(36756003)(76176011)(102836004)(52116002)(107886003)(2501003)(6512007)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1075;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QAVEmc8UMbMCVzXeJZsYaIwRs83IusfKc/cMAmp/wuQNRYtLMvz4JRpdZPYIO2rEiT9u5GOA5NKiBn6cpJj0YeLl+8hlxlWcCpremW8M57WF7ftkXQhhgUWHZUUEiggqLDpX2QicD136sQ/JhNIuWwzaUyBCQJwda+qXyytG5KWeWyav4Gqa3aE6BtUwXxft
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e314d25a-87ac-430d-a264-08d5cba1bc60
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e314d25a-87ac-430d-a264-08d5cba1bc60
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:25.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1075
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
index 298ad747c6..922bb68741 100644
--- a/commit.c
+++ b/commit.c
@@ -405,7 +405,7 @@ int parse_commit_buffer(struct commit *item, const void=
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
@@ -416,7 +416,7 @@ int parse_commit_gently(struct commit *item, int quiet_=
on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer =3D read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
@@ -437,6 +437,11 @@ int parse_commit_gently(struct commit *item, int quiet=
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
index cb943013d0..4065fd12ac 100644
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

