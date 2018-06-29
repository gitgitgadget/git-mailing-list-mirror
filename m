Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F05B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966921AbeF2QNR (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:17 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:13680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966894AbeF2QNC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia2sWHDIf/M7hPWdkASU97d/vkIGvqcnd2WIsJxharY=;
 b=BBv5vZ8O1R/OXBbQhh+rTrBgzktcRtQ01DmHLWZ9BxTojHEKVn06cUCM+mn/F+DeNF2p+6L0umZxP9Z+v8IV2wznZ84OsdiLjICLZzQfgJ7OrOwlziMRD+MSsTyUXGK1oCfi4DBQ5vt6Xzzq1zLxjZo/QEJHaQZJvOXd50sDd4U=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:13:00 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:13:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 11/13] commit-reach: make can_all_from_reach... linear
Thread-Topic: [RFC PATCH 11/13] commit-reach: make can_all_from_reach...
 linear
Thread-Index: AQHUD8QMPYZqg2xbFE2OSpLFTms8nw==
Date:   Fri, 29 Jun 2018 16:13:00 +0000
Message-ID: <20180629161223.229661-12-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:PouDTYtRc+CkzmEm6EqgWZO0ooExelIP06gsRdwy28Qwju3D0V4ZGqMkQcuFc6aV2nSFzHmTcjQhXCG+HRsUrGTXqWiRYiZNzCIa+KUDLaNo+VsEoECtZ7PZyuLSjVmRNKHdtPQ8TdYf+jOIXTjyYgeAKVHGzIvT84RRiNl8NGezVOuDidGKIbA4hzDyC7zhnq/McnZCHXezV09JrqlYE4MGX381e3jdZmi/+4tbBTLqGnKQPnQjgmJrs2YnsV3t
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a53ba904-4f99-4e1b-42b9-08d5dddb2f17
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044B24490B85A75EFD6780BA14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: w1dGMaOHbgvgqlYkXPn4QaCwyMd2US6kzxYq0rUoj9r02LBG56TUva0I2AQSjxjv2RakezIl5O+lH4a7qOx2nSJqzYxJGyMlf0p6NMn6Dexv4mTJtU4sTR0mv5c+FBM9HPu5edDpqwSBuA5IdvZR5U+1yLaNPiXjOzyhge/+4u1g4evbaMSvE6Cukqw0AGRtcac+73+5oFeMFQQ7amo/cr5XPuyEV8J4MiHluXA4QT3CxiX7wXV+8YYN67M9wQQSVaat1E2en90mKkRXZbk+IZ0vGpBAuKwT9cR6UDRwUCL2b33WpAKkREHXHqkSdziqp8CfjF4870EICFmO2sZQ57cb3SEwy9SWvdfP2b//kEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53ba904-4f99-4e1b-42b9-08d5dddb2f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:13:00.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The can_all_from_reach_with_flags() algorithm is currently quadratic in
the worst case, because it calls the reachable() method for every 'from'
without tracking which commits have already been walked or which can
already reach a commit in 'to'.

Rewrite the algorithm to walk each commit a constant number of times.

We also add some optimizations that should work for the main consumer of
this method: fetch negotitation (haves/wants).

The first step includes using a depth-first-search (DFS) from each from
commit, sorted by ascending generation number. We do not walk beyond the
minimum generation number or the minimum commit date. This DFS is likely
to be faster than the existing reachable() method because we expect
previous ref values to be along the first-parent history.

If we find a target commit, then we mark everything in the DFS stack as
a RESULT. This expands the set of targets for the other from commits. We
also mark the visited commits using 'assign_flag' to prevent re-walking
the same code.

We still need to clear our flags at the end, which is why we will have a
total of three visits to each commit.

Performance was measured on the Linux repository using
'test-tool reach can_all_from_reach'. The input included rows seeded by
tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
v3 releases and want all major v4 releases." The "large" case included
X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
tags to the set, which does not greatly increase the number of objects
that are considered, but does increase the number of 'from' commits,
demonstrating the quadratic nature of the previous code.

Small Case
----------

Before: 1.45 s
 After: 0.34 s

Large Case
----------

Before: 5.83 s
 After: 0.37 s

Note how the time increases between the two cases in the two versions.
The new code increases relative to the number of commits that need to be
walked, but not directly relative to the number of 'from' commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 122 ++++++++++++++++++++++++++++++-------------------
 commit-reach.h |   3 +-
 upload-pack.c  |   5 +-
 3 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 992ad5cdc7..8e24455d9f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -530,64 +530,88 @@ int commit_contains(struct ref_filter *filter, struct=
 commit *commit,
 	return is_descendant_of(commit, list);
 }
=20
-static int reachable(struct commit *from, int with_flag, int assign_flag, =
time_t min_commit_date)
+static int compare_commits_by_gen(const void *_a, const void *_b)
 {
-	struct prio_queue work =3D { compare_commits_by_commit_date };
+	const struct commit *a =3D (const struct commit *)_a;
+	const struct commit *b =3D (const struct commit *)_b;
=20
-	prio_queue_put(&work, from);
-	while (work.nr) {
-		struct commit_list *list;
-		struct commit *commit =3D prio_queue_get(&work);
-
-		if (commit->object.flags & with_flag) {
-			from->object.flags |=3D assign_flag;
-			break;
-		}
-		if (!commit->object.parsed)
-			parse_object(&commit->object.oid);
-		if (commit->object.flags & TMP_MARK)
-			continue;
-		commit->object.flags |=3D TMP_MARK;
-		if (commit->date < min_commit_date)
-			continue;
-		for (list =3D commit->parents; list; list =3D list->next) {
-			struct commit *parent =3D list->item;
-			if (!(parent->object.flags & TMP_MARK))
-				prio_queue_put(&work, parent);
-		}
-	}
-	from->object.flags |=3D TMP_MARK;
-	clear_commit_marks(from, TMP_MARK);
-	clear_prio_queue(&work);
-	return (from->object.flags & assign_flag);
+	if (a->generation < b->generation)
+		return -1;
+	if (a->generation > b->generation)
+		return 1;
+	return 0;
 }
=20
 int can_all_from_reach_with_flag(struct object_array *from,
 				 int with_flag, int assign_flag,
-				 time_t min_commit_date)
+				 time_t min_commit_date,
+				 uint32_t min_generation)
 {
+	struct commit **list =3D NULL;
 	int i;
+	int result =3D 1;
=20
+	ALLOC_ARRAY(list, from->nr);
 	for (i =3D 0; i < from->nr; i++) {
-		struct object *from_one =3D from->objects[i].item;
+		list[i] =3D (struct commit *)from->objects[i].item;
=20
-		if (from_one->flags & assign_flag)
-			continue;
-		from_one =3D deref_tag(from_one, "a from object", 0);
-		if (!from_one || from_one->type !=3D OBJ_COMMIT) {
-			/* no way to tell if this is reachable by
-			 * looking at the ancestry chain alone, so
-			 * leave a note to ourselves not to worry about
-			 * this object anymore.
-			 */
-			from->objects[i].item->flags |=3D assign_flag;
-			continue;
-		}
-		if (!reachable((struct commit *)from_one, with_flag,
-			       assign_flag, min_commit_date))
+		parse_commit(list[i]);
+
+		if (list[i]->generation < min_generation)
 			return 0;
 	}
-	return 1;
+
+	QSORT(list, from->nr, compare_commits_by_gen);
+
+	for (i =3D 0; i < from->nr; i++) {
+		/* DFS from list[i] */
+		struct commit_list *stack =3D NULL;
+
+		list[i]->object.flags |=3D assign_flag;
+		commit_list_insert(list[i], &stack);
+
+		while (stack) {
+			struct commit_list *parent;
+
+			if (stack->item->object.flags & with_flag) {
+				pop_commit(&stack);
+				continue;
+			}
+
+			for (parent =3D stack->item->parents; parent; parent =3D parent->next) =
{
+				if (parent->item->object.flags & (with_flag | RESULT))
+					stack->item->object.flags |=3D RESULT;
+
+				if (!(parent->item->object.flags & assign_flag)) {
+					parent->item->object.flags |=3D assign_flag;
+
+					parse_commit(parent->item);
+
+					if (parent->item->date < min_commit_date ||
+					    parent->item->generation < min_generation)
+						continue;
+
+					commit_list_insert(parent->item, &stack);
+					break;
+				}
+			}
+
+			if (!parent)
+				pop_commit(&stack);
+		}
+
+		if (!(list[i]->object.flags & (with_flag | RESULT))) {
+			result =3D 0;
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	for (i =3D 0; i < from->nr; i++) {
+		clear_commit_marks(list[i], RESULT);
+		clear_commit_marks(list[i], assign_flag);
+	}
+	return result;
 }
=20
 int can_all_from_reach(struct commit_list *from, struct commit_list *to)
@@ -597,6 +621,7 @@ int can_all_from_reach(struct commit_list *from, struct=
 commit_list *to)
 	struct commit_list *from_iter =3D from;
 	struct commit_list *to_iter =3D to;
 	int result;
+	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
=20
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
@@ -608,16 +633,21 @@ int can_all_from_reach(struct commit_list *from, stru=
ct commit_list *to)
 	}
=20
 	while (to_iter) {
+		parse_commit(to_iter->item);
+
 		if (to_iter->item->date < min_commit_date)
 			min_commit_date =3D to_iter->item->date;
=20
+		if (to_iter->item->generation < min_generation)
+			min_generation =3D to_iter->item->generation;
+
 		to_iter->item->object.flags |=3D PARENT2;
=20
 		to_iter =3D to_iter->next;
 	}
=20
 	result =3D can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
-					      min_commit_date);
+					      min_commit_date, min_generation);
=20
 	while (from) {
 		clear_commit_marks(from->item, PARENT1);
diff --git a/commit-reach.h b/commit-reach.h
index 8ab06af2eb..3eb4c057e6 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -28,7 +28,8 @@ int commit_contains(struct ref_filter *filter, struct com=
mit *commit,
  * such commits with 'assign_flag'.
  */
 int can_all_from_reach_with_flag(struct object_array *from, int with_flag,
-				 int assign_flag, time_t min_commit_date);
+				 int assign_flag, time_t min_commit_date,
+				 uint32_t min_generation);
=20
 int can_all_from_reach(struct commit_list *from, struct commit_list *to);
=20
diff --git a/upload-pack.c b/upload-pack.c
index e59fbca257..95ba077e2b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -336,11 +336,14 @@ static int got_oid(const char *hex, struct object_id =
*oid)
=20
 static int ok_to_give_up(void)
 {
+	uint32_t min_generation =3D GENERATION_NUMBER_ZERO;
+
 	if (!have_obj.nr)
 		return 0;
=20
 	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
-					    COMMON_KNOWN, oldest_have);
+					    COMMON_KNOWN, oldest_have,
+					    min_generation);
 }
=20
 static int get_common_commits(void)
--=20
2.18.0.118.gd4f65b8d14

