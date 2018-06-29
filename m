Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532411F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966867AbeF2QMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:12:51 -0400
Received: from mail-sn1nam01on0090.outbound.protection.outlook.com ([104.47.32.90]:3941
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966859AbeF2QMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqfaNPjK2R8rZ04l8PjmV5vGgq9aYfEEhfzqyuFDEoY=;
 b=nTHDqtSa5PS5ujLwoLMbz05rw8urgD4CR0UNgL0LDgYD0ycBRDReGdEyaIDTKu2XciIIAcWeInyieG01vHevs3Sg1vC5B9hP436UV9hXOWGEh7GMdiFKJgbRxKQmQ8AwXy/lcX2hJRiSCnh/DMVuwEoSmztpy6aPm5t/54i1kqA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:45 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:45 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 04/13] upload-pack: make reachable() more generic
Thread-Topic: [RFC PATCH 04/13] upload-pack: make reachable() more generic
Thread-Index: AQHUD8QD5mweM29P3UWxU2e6Re6hjA==
Date:   Fri, 29 Jun 2018 16:12:45 +0000
Message-ID: <20180629161223.229661-5-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:13KG09vas75rxYfeo1+E9/9PBjSTnU9srjIe/VLvfuxmXsR2qPyJFxKzxD2B5NVoPQLNMfnTZwxNqQicxhfzRHmpkF700LZEsjZ7LTiriMKrEdU1hFOPHtLagkAZGzwd0cJGwMyzILz0Dd3IeknzblRyYJxrwARg9bQxxSaDE0ZgPNWbRgkjQvZtS9Ha65N2aTbD8Xwu/6Q84gzpbtCJ63AEDnoAsb0kATAi0qkdTZ5i1Yp5T8yAxcvgnUc6uI9f
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e2c1434-954b-4d8a-64da-08d5dddb2611
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB10440B87359FBB0CF03755CEA14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: znd73OSjQuqNYHL/wtsj/d8Bi5tyAai6mNIwywSGkmVWr6MjlxMB4WhUZFEYir3BRJj21YKB6U3htdK613qe7wIlRD8udPvfjqZ8m6/3bkQX3pLSZrZuq9gjtC0eI7xnE3pHh8RmT30+BF6wWMfiDdhOT2W+WELjSGv6lqjkL3StORMA4wawhU5ACU036kB2Lc1eVzjTW0MFsO+qFaVAoYmrtTjp5Ap9URapS6TtsC4NIhlcbxUHk9FngSfbuiabMJzcvfMena7ROz5gv9DERHJ2MS1pJ6PUvx2YeEkcYFaWm0tO+KJzw8IMegbTHiaidIpqB+Y+niagQ8JyH68BPNNi2eDoRQboDAIg1ARL7pI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2c1434-954b-4d8a-64da-08d5dddb2611
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:45.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of moving the reachable() method to commit-reach.c,
modify the prototype to be more generic to flags known outside of
upload-pack.c. Also rename 'want' to 'from' to make the statement
more clear outside of the context of haves/wants negotiation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 87c6722ea5..95c56dc027 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -28,7 +28,6 @@
 #define OUR_REF		(1u << 12)
 #define WANTED		(1u << 13)
 #define COMMON_KNOWN	(1u << 14)
-#define REACHABLE	(1u << 15)
=20
 #define SHALLOW		(1u << 16)
 #define NOT_SHALLOW	(1u << 17)
@@ -334,36 +333,36 @@ static int got_oid(const char *hex, struct object_id =
*oid)
 	return 0;
 }
=20
-static int reachable(struct commit *want)
+static int reachable(struct commit *from, int with_flag, int assign_flag)
 {
 	struct prio_queue work =3D { compare_commits_by_commit_date };
=20
-	prio_queue_put(&work, want);
+	prio_queue_put(&work, from);
 	while (work.nr) {
 		struct commit_list *list;
 		struct commit *commit =3D prio_queue_get(&work);
=20
-		if (commit->object.flags & THEY_HAVE) {
-			want->object.flags |=3D COMMON_KNOWN;
+		if (commit->object.flags & with_flag) {
+			from->object.flags |=3D assign_flag;
 			break;
 		}
 		if (!commit->object.parsed)
 			parse_object(&commit->object.oid);
-		if (commit->object.flags & REACHABLE)
+		if (commit->object.flags & TMP_MARK)
 			continue;
-		commit->object.flags |=3D REACHABLE;
+		commit->object.flags |=3D TMP_MARK;
 		if (commit->date < oldest_have)
 			continue;
 		for (list =3D commit->parents; list; list =3D list->next) {
 			struct commit *parent =3D list->item;
-			if (!(parent->object.flags & REACHABLE))
+			if (!(parent->object.flags & TMP_MARK))
 				prio_queue_put(&work, parent);
 		}
 	}
-	want->object.flags |=3D REACHABLE;
-	clear_commit_marks(want, REACHABLE);
+	from->object.flags |=3D TMP_MARK;
+	clear_commit_marks(from, TMP_MARK);
 	clear_prio_queue(&work);
-	return (want->object.flags & COMMON_KNOWN);
+	return (from->object.flags & assign_flag);
 }
=20
 static int ok_to_give_up(void)
@@ -388,7 +387,7 @@ static int ok_to_give_up(void)
 			want_obj.objects[i].item->flags |=3D COMMON_KNOWN;
 			continue;
 		}
-		if (!reachable((struct commit *)want))
+		if (!reachable((struct commit *)want, THEY_HAVE, COMMON_KNOWN))
 			return 0;
 	}
 	return 1;
--=20
2.18.0.118.gd4f65b8d14

