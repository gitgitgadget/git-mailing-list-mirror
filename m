Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773C01F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeDQSKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:46 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:60462
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752774AbeDQSKo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=X52z0mro80U1VG+jhh0S5vyA3zelSiMLKW5Mfot01Nc=;
 b=Wg2D9T7f5H27dDwtXCbg+lRqVp5dQuQv06Tlj++D7fkPGQc6UjcJdxt4qhWmWDkEMuJIjC3m5LWX0ANH/G5UqXR4xE6D4Bk1FFCUu5B27qUcB0DBtLTpQFROqxZKeutYhieV2hz2BpH5wzo+2ZspuY17mN67WPM8hCfVHSWL7GE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:42 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:42 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 06/12] commit: force commit to parse from object database
Thread-Topic: [RFC PATCH 06/12] commit: force commit to parse from object
 database
Thread-Index: AQHT1ndlLhqggPFubkmWOEWauoiNcw==
Date:   Tue, 17 Apr 2018 18:10:41 +0000
Message-ID: <20180417181028.198397-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:mcDvqlUWoX9wvzyRbidfNpII6xHFYDPyTmnthbwRFNd5/iGlU99QiloRE1ZNTvmxJ5z4JWDOALO0Xe8+4WtT06e7l6Fh5OSt+Xx4votakRMCllWDIkvKZspVnWKi7t0EQ4Drrv1x732nwcY2+lFkqaZdeRQPEBnzYEUEX9pofzzYVCAyK3h748lpihePAGIM8avCV+/NtZupSwSMGSmjVI58zAMaeEIi6U63INEm2u8MCrMwMJ3m+CsZ6FykIGWZ;20:6SVieQ7McA/seRF5Ls9GW/matrM4jblFf2oruhLVaI5YqPLyf8hYr7GaeDMqmPGj321bFr+wGWoazGt8cbs5K02KqNtd2eeeaX5S3YeRRPiaxu6efSo925lxQP6cv4MmaidO6PSR5P8vGHqrIkcgZIhCTVuCQqOYFNOQTxAuv1s=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09948DE5B6D869D192C337ACA1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1SxwYKRTLEQ1FPOyfB+qM/EaeiVg2uqFWuAPDVKANWRZxyfQtF1mU6Tkdd/yQ+3aog9sCPaLYHj4k8ZrRdPWDy6hLUB1EIjlYXY9DRGZdLzzyIGV+eRegINn1VZMSr1K0MAXooByElmhu6sh80EedKjUmYKRdSfGupRyG8ISueyEb57jufw5OveqpFwN6n7v
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c7530a84-557e-4e37-9527-08d5a48e87f1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7530a84-557e-4e37-9527-08d5a48e87f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:41.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of checking commit-graph file contents against the
object database, create parse_commit_internal() to allow side-stepping
the commit-graph file and parse directly from the object database.

Due to the use of generation numbers, this method should not be called
unless the intention is explicit in avoiding commits from the
commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 14 ++++++++++----
 commit.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 9ef6f699bd..07752d8503 100644
--- a/commit.c
+++ b/commit.c
@@ -392,7 +392,8 @@ int parse_commit_buffer(struct commit *item, const void=
 *buffer, unsigned long s
 	return 0;
 }
=20
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int u=
se_commit_graph)
 {
 	enum object_type type;
 	void *buffer;
@@ -403,17 +404,17 @@ int parse_commit_gently(struct commit *item, int quie=
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
@@ -424,6 +425,11 @@ int parse_commit_gently(struct commit *item, int quiet=
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
2.17.0.39.g685157f7fb

