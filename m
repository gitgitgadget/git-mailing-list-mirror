Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63F701F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbeGTRWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:45 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388010AbeGTRWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfFinvHtQuEUNXq7PAoDty0ulTKZcnZ4BmL61XSk4gU=;
 b=V1yhIXpogzz7VlxGwnisLAiK91+rZx88G5xTGn3w5CS3UCpXRbNQvGl4EB+nnJOFgcyZgQjlnUgotXhlmzX/27gbgg3cwVhADsqvLRgfpc46elMVCtdgf2Ao/u+GxSXKOSOC4tbJM4E6V6mAFh4NV8Ld3DidTvqZaqf/ghgGvXc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:29 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:29 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
Thread-Topic: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
Thread-Index: AQHUIEdjzZ4ZcyR2CEqYiPIvNQG7Ag==
Date:   Fri, 20 Jul 2018 16:33:28 +0000
Message-ID: <20180720163227.105950-18-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:5nCFLtr1UjfEPLLgh39iVCAbzzFF3y7hf1NZFVOPzqB0AEm+bHoOv+iZvzR4wUGHvBEtCSOTMVnrTyTy15IM/57C8IC/shCWJXrfcwLfYsPZaRfQzx3mKnGbg9mpVRUTBnGlrh6lan/WJW2qH/NjE4GDaZvVXdCwSs9+1BMOtGGPQjT65OJmirYnXRPexrKUq0IimMQBbNd3cGa+oLqN+L0k2CsQz6Z19//n396ICx6zqeaTheRsHsM6eTTXASYBl9TmWoIFUqTW9LIv9JAmf0KemoLEJ1QarBUT/f3Cnsu2gF/8bGBf0f7WUBJJ6g7uPNtV7DjDdgCdhCmGsYNoHR4v5v8JAioy7aW3zKVqRSht5zvPmHAj6MbArqRDyDuj7SM1pbADHVi1tXQGRAJYi2xhvFIUTlNWF8TMhUTEe7Huxmk38Y5ioDMdggbTVbQDfVS7ibnkl2kSPl4J/gELdg==;5:K8vg2wHc5MGM6qwChHWG21QslUQo5Uvn03L8O8oZhi9fNst4xNCsvlis+5G7bFtiIx/K+VYgi6IE7qBmu2a/Sw/TUF6y2++/UFCKpMC86q6I2KVqLVSO/tEgJ2ob8mmlnafUJoel2vAZpuAYCYBuCm9LYMBfxlzSJWUe47RkFu8=;7:mX3IR5S3KxiT80xiE6ivhJz4luDCb07jAa8SdtG3/z4+BvLcltRAXSQymexju47++rTHudtp6bBqyJULZNckt2Rbn4FHhyL3sCK1zpCFINWxf1l6Gakj1wBM/9n0ZPU+ixndN3Ik2+kH8Mrw5YFPar8wl5fsAAPHl7u00rsfbujXp13mnLDwZpW2FUaBww1wM1hAc597T29GtbqR8YPM0KlyIlrRjFKm+AaaAbVwWPtFSjePxu8Euz8ntLcO+fIR
x-ms-office365-filtering-correlation-id: 76b13857-4880-4707-b142-08d5ee5e85f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929139B6E2CBB091DA73FC2A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n1wHCZmrYq97D14RU00qy+RBttZGyArGVow78FlRD7jrR3cQFsOEQ+2HaqO5wvTTUoEVomVp8aHCuoNrt561mQDsawzOMWirkZOIZpMnDQ7IHPAaR9lKE1NjmyKihUU1cZsd0g/OPEDAx+6U9r7Br08HjLXpguTnmsFCWsnCRyaBGEkXjGUvgDTlkRvJQP/tkAJb0KsNep+0U6S4sTNDbW3l3iarHJ952gFvw+wMYZt0IGBCrvKbGvyR12/R59pydG8M914jfwsKzliagyjnyeBUaVkw+dp64rr9g0nL3YBgd4VK1WCWnQuDjYMYcUwAi5uEGybfdssLtPplCUmZOH+Te0urNaduZbltvrcOD9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b13857-4880-4707-b142-08d5ee5e85f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:28.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
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

The first step includes using a depth-first-search (DFS) from each
'from' commit, sorted by ascending generation number. We do not walk
beyond the minimum generation number or the minimum commit date. This
DFS is likely to be faster than the existing reachable() method because
we expect previous ref values to be along the first-parent history.

If we find a target commit, then we mark everything in the DFS stack as
a RESULT. This expands the set of targets for the other 'from' commits.
We also mark the visited commits using 'assign_flag' to prevent re-
walking the same commits.

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

Small Case:

Before: 1.52 s
 After: 0.26 s

Large Case:

Before: 3.50 s
 After: 0.27 s

Note how the time increases between the two cases in the two versions.
The new code increases relative to the number of commits that need to be
walked, but not directly relative to the number of 'from' commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 122 ++++++++++++++++++++++++++++++-------------------
 commit-reach.h |   9 ++--
 upload-pack.c  |   5 +-
 3 files changed, 83 insertions(+), 53 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index f5858944fd..bc522d6840 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -514,66 +514,87 @@ int commit_contains(struct ref_filter *filter, struct=
 commit *commit,
 	return is_descendant_of(commit, list);
 }
=20
-int reachable(struct commit *from, unsigned int with_flag,
-	      unsigned int assign_flag, time_t min_commit_date)
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
-			parse_object(the_repository, &commit->object.oid);
-		if (commit->object.flags & REACHABLE)
-			continue;
-		commit->object.flags |=3D REACHABLE;
-		if (commit->date < min_commit_date)
-			continue;
-		for (list =3D commit->parents; list; list =3D list->next) {
-			struct commit *parent =3D list->item;
-			if (!(parent->object.flags & REACHABLE))
-				prio_queue_put(&work, parent);
-		}
-	}
-	from->object.flags |=3D REACHABLE;
-	clear_commit_marks(from, REACHABLE);
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
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
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
-		from_one =3D deref_tag(the_repository, from_one, "a from object", 0);
-		if (!from_one || from_one->type !=3D OBJ_COMMIT) {
-			/* no way to tell if this is reachable by
-			 * looking at the ancestry chain alone, so
-			 * leave a note to ourselves not to worry about
-			 * this object anymore.
-			 */
-			from->objects[i].item->flags |=3D assign_flag;
-			continue;
-		}
-		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
-			       min_commit_date))
+		if (parse_commit(list[i]) ||
+		    list[i]->generation < min_generation)
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
+					if (parse_commit(parent->item) ||
+					    parent->item->date < min_commit_date ||
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
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
@@ -583,6 +604,7 @@ int can_all_from_reach(struct commit_list *from, struct=
 commit_list *to,
 	time_t min_commit_date =3D cutoff_by_min_date ? from->item->date : 0;
 	struct commit_list *from_iter =3D from, *to_iter =3D to;
 	int result;
+	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
=20
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
@@ -590,6 +612,9 @@ int can_all_from_reach(struct commit_list *from, struct=
 commit_list *to,
 		if (!parse_commit(from_iter->item)) {
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date =3D from_iter->item->date;
+
+			if (from_iter->item->generation < min_generation)
+				min_generation =3D from_iter->item->generation;
 		}
=20
 		from_iter =3D from_iter->next;
@@ -599,6 +624,9 @@ int can_all_from_reach(struct commit_list *from, struct=
 commit_list *to,
 		if (!parse_commit(to_iter->item)) {
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date =3D to_iter->item->date;
+
+			if (to_iter->item->generation < min_generation)
+				min_generation =3D to_iter->item->generation;
 		}
=20
 		to_iter->item->object.flags |=3D PARENT2;
@@ -607,7 +635,7 @@ int can_all_from_reach(struct commit_list *from, struct=
 commit_list *to,
 	}
=20
 	result =3D can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
-					      min_commit_date);
+					      min_commit_date, min_generation);
=20
 	while (from) {
 		clear_commit_marks(from->item, PARENT1);
diff --git a/commit-reach.h b/commit-reach.h
index aa202c9703..7d313e2975 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -59,19 +59,18 @@ define_commit_slab(contains_cache, enum contains_result=
);
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
=20
-int reachable(struct commit *from, unsigned int with_flag,
-	      unsigned int assign_flag, time_t min_commit_date);
-
 /*
  * Determine if every commit in 'from' can reach at least one commit
  * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
  * as a marker for commits that are already visited. Do not walk
- * commits with date below 'min_commit_date'.
+ * commits with date below 'min_commit_date' or generation below
+ * 'min_generation'.
  */
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
-				 time_t min_commit_date);
+				 time_t min_commit_date,
+				 uint32_t min_generation);
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);
=20
diff --git a/upload-pack.c b/upload-pack.c
index 11c426685d..1e498f1188 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -338,11 +338,14 @@ static int got_oid(const char *hex, struct object_id =
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

