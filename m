Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC901F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966911AbeF2QNH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:07 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:63584
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966887AbeF2QNF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfUlH1bXN6yjOfmEGAbdcjqRr3brwTe6ubNRpXdiy5c=;
 b=ixtMe9ff0BZQJDCwZZO5Z39sBbFDXz+U0ftnbBS6bXV6gE7Sof0LKhFBf1QlT2WQR6MyZjCOugpslUIosnOCyopaWIvdQiIPHuIlYrxE0yzTxYKw+wf8X9EihHGKEmLLyxKs2p1kiEpw9DVF+hbH4rA7g1QnDd5/yCVeq6y+HlM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:13:03 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:13:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 13/13] commit-reach: use can_all_from_reach
Thread-Topic: [RFC PATCH 13/13] commit-reach: use can_all_from_reach
Thread-Index: AQHUD8QOPr6/UmZKNkqnwU6IG2ZtTg==
Date:   Fri, 29 Jun 2018 16:13:03 +0000
Message-ID: <20180629161223.229661-14-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:hhaj5ex7DeS2gC3oSPVERCp0222tAsfIC6OnYwqa5hOfjoQcnMozETCbkMe98G0ISw8xcNrB9EIBZvts9hYPVFK/zDGnmPB7KN683xAgBVKMyKU8q13Y50c13CuJIW1Owki8cRs+LmRCJZZDIuQPBq13gQz6qfl5+ARMQ61dHF3lcF1TzlzPrLhz6bymIPmpFaEQHMUQjdq4+Tr6wxT6DHjQpc1LOoYbN1A3x1gnoEh4Q9cW+H6FXkqHbxiZv+J1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba7c8d5a-dcc3-41e4-9ddd-08d5dddb30e7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB10446442EBE7A0104DE8D9CCA14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(14444005)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: ISS3Dz21SXB0GB6Lgtp7thLr+U1cINhjMOmdGi14Y1z7fXcC2rl6veEiagJkSoE2c84u15+PP9y189ukcNtQlFNQOXrQ7+BOsSmh2TJ0ootehbsU27hbjZG/u+Sb8rLUBiF+PMhAMdmmn6V/i/ho88RgrNZ5WHNJj39WrOUFH9Dr5Y7NyJhh1Ta0xp3EyO71de6wxK1sDNiMO5pUO1QQ6PPsFxah28OZ069LvZncjNGDO4UYsnQN6gGeBMm/W30wImMHoBVlR5bTIoMdT7nCOs4wkROltQm9rSQwl/e22KMX1TQ+5QdKync8S7NZcVGM++CZrJSrd4sZ8/+Pg5sYDIRVmK0x24El6lgyujYwaTc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7c8d5a-dcc3-41e4-9ddd-08d5dddb30e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:13:03.3817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_descendant_of method previously used in_merge_bases() to check if
the commit can reach any of the commits in the provided list. This had
two performance problems:

1. The performance is quadratic in worst-case.

2. A single in_merge_bases() call requires walking beyond the target
   commit in order to find the full set of boundary commits that may be
   merge-bases.

The can_all_from_reach method avoids this quadratic behavior and can
limit the search beyond the target commits using generation numbers. It
requires a small prototype adjustment to stop using commit-date as a
cutoff, as that optimization is no longer appropriate here.

Performance was meausured on a copy of the Linux repository using the
'test-tool reach is_descendant_of' command using this input:

A:v4.9
X:v4.10
X:v4.11
X:v4.12
X:v4.13
X:v4.14
X:v4.15
X:v4.16
X:v4.17
X.v3.0

Note that this input is tailored to demonstrate the quadratic nature of
the previous method, as it will compute merge-bases for v4.9 versus all
of the later versions before checking against v4.1.

Before: 0.31 s
 After: 0.27 s

Since we previously used the is_descendant_of method in the ref_newer
method, we also measured performance there using
'test-tool reach ref_newer':

Before: 0.12 s
 After: 0.11 s

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

One thing I know is missing from this commit is a special-case to use
the old logic when there is no commit-graph present. The
can_all_from_reach() algorithm can be worse when we do not have good
generation number cutoffs. In the previous case of
can_all_from_reach_with_flags(), we already had an established pattern
of using commit date as a cutoff, so the generation number is only a
second cutoff and the algorithm cannot walk more commits than before.

 commit-reach.c        | 34 +++++++++++++++++-----------------
 commit-reach.h        |  3 ++-
 t/helper/test-reach.c |  2 +-
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 249e9a4fac..a823d6965c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -273,17 +273,15 @@ struct commit_list *get_merge_bases(struct commit *on=
e, struct commit *two)
  */
 int is_descendant_of(struct commit *commit, struct commit_list *with_commi=
t)
 {
+	struct commit_list *from_list =3D NULL;
+	int result;
 	if (!with_commit)
 		return 1;
-	while (with_commit) {
-		struct commit *other;
=20
-		other =3D with_commit->item;
-		with_commit =3D with_commit->next;
-		if (in_merge_bases(other, commit))
-			return 1;
-	}
-	return 0;
+	commit_list_insert(commit, &from_list);
+	result =3D can_all_from_reach(from_list, with_commit, 0);
+	free_commit_list(from_list);
+	return result;
 }
=20
 /*
@@ -605,10 +603,11 @@ int can_all_from_reach_with_flag(struct object_array =
*from,
 	return result;
 }
=20
-int can_all_from_reach(struct commit_list *from, struct commit_list *to)
+int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+		       int cutoff_by_min_date)
 {
 	struct object_array from_objs =3D OBJECT_ARRAY_INIT;
-	time_t min_commit_date =3D from->item->date;
+	time_t min_commit_date =3D cutoff_by_min_date ? from->item->date : 0;
 	struct commit_list *from_iter =3D from;
 	struct commit_list *to_iter =3D to;
 	int result;
@@ -617,20 +616,21 @@ int can_all_from_reach(struct commit_list *from, stru=
ct commit_list *to)
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
=20
-		if (from_iter->item->date < min_commit_date)
+		if (!parse_commit(from_iter->item) &&
+		    from_iter->item->date < min_commit_date)
 			min_commit_date =3D from_iter->item->date;
=20
 		from_iter =3D from_iter->next;
 	}
=20
 	while (to_iter) {
-		parse_commit(to_iter->item);
-
-		if (to_iter->item->date < min_commit_date)
-			min_commit_date =3D to_iter->item->date;
+		if (!parse_commit(to_iter->item)) {
+			if (to_iter->item->date < min_commit_date)
+				min_commit_date =3D to_iter->item->date;
=20
-		if (to_iter->item->generation < min_generation)
-			min_generation =3D to_iter->item->generation;
+			if (to_iter->item->generation < min_generation)
+				min_generation =3D to_iter->item->generation;
+		}
=20
 		to_iter->item->object.flags |=3D PARENT2;
=20
diff --git a/commit-reach.h b/commit-reach.h
index 3eb4c057e6..180f865d7d 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -31,6 +31,7 @@ int can_all_from_reach_with_flag(struct object_array *fro=
m, int with_flag,
 				 int assign_flag, time_t min_commit_date,
 				 uint32_t min_generation);
=20
-int can_all_from_reach(struct commit_list *from, struct commit_list *to);
+int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+		       int cutoff_by_min_date);
=20
 #endif
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 14aaef5bff..c05137c9f3 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -120,7 +120,7 @@ int cmd__reach(int ac, const char **av)
 			list =3D list->next;
 		}
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
-		int result =3D can_all_from_reach(list_X, list_Y);
+		int result =3D can_all_from_reach(list_X, list_Y, 1);
 		printf("%s(X,Y):%d\n", av[1], result);
 	}
=20
--=20
2.18.0.118.gd4f65b8d14

