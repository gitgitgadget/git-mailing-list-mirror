Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295671F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbeGTRWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:17 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387931AbeGTRWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlKuFVx4JjbEwVlUJkDua3C3XoDUyeLTtIBREHfsqT0=;
 b=fMD3o8oJqBwHtIYdZxeTF0nAW5cQj1YmHDtW5VK1Fj7+oCqJlolKPYizFD0KRbFYIHKBaY7W96/0b40/+AspL/NcqemD7R2l58ZRj+Tzylo94iXTbYT6pnfTfBGTTS416fYkG5hxBTIGYPniKyg4whGqWTUauI0Y+3AiH1wSgGQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:08 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 04/18] commit-reach: move commit_contains from ref-filter
Thread-Topic: [PATCH v2 04/18] commit-reach: move commit_contains from
 ref-filter
Thread-Index: AQHUIEdXKhegYzVn7EGycxbdE429tg==
Date:   Fri, 20 Jul 2018 16:33:08 +0000
Message-ID: <20180720163227.105950-5-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:0E8fOqh9PUOYiIrVfF+lXbDe4991S1LWN6xtMolkunIEcR3d8Yp8DMDn78PsbgiZGkGviN2F4AcoqX2ThDipl4TUv4LXUqMttq3oYhFK2U/qw/lJdLuaValcQRxBZRl2S8eiPC68U2XNLiCzvM+r9K4T+u1Mz3wanA0YPE1Gc9iBKTgrQOicWVQ85LfJpKOTLpgiDccJLrZaqQST3CqmE39zFOnVtjXnjH7peki/08vrvqsrcaRuRoG28lYWObfXci5d91Yx3X1gtVFha+OkkNayDzdNcpEQp4H7O4VdhjO3yemLVudfYodzKsgbH1azQBUvvwj5S/YLYwQxh6lKXa+0qDFPLvPeFHI05ptIzLtA5/rx615IudrreB/VkrdGYnqk33DLhFR8nLfhbOHlSHXUT3gPwGxOLrlmBcEW3QW6TuYdUkyMQKAsU0HQrjBDkqdJ5zRhckKxXLyba/xGtw==;5:hSYnkY6mlTS/wQgubI9+BLVdZgONRXdkMruWb9nYfXkFWUvP0ShueoZNrgWzTY1ulaYYnik8xYdXteQgkcA4MMJvTWvVa6XpkjKY0f6nKB0bcz9SNGCfYsAcr+iw/VrZJwBmpfNgt9jfjqBJGqxswOyDHRamY58WBY17G9wcbQ8=;7:s8WbCm1jpD538N8qMWhDLnP28sOcKSOPoYxrTu8UgECMBhrVzZJ1u98jf11yyNa0lHdp+IeNK9i5XEUEj96rYbBeZ/Kn+bpeOhXl0PuW5k4BRYUrtwvwLfe/w7btJpjyXXWbucxEAQs8exRpVuwkR9gjfXnxKbKeP7jIseokT5Xk4Wfe0QnSfsqJLwSTd1wkY4wNgILKucZavJt5rpBpOzgwSv4X+Lo63cT/KFeBuKMVyU0rAJy39nE0yh2yw0++
x-ms-office365-filtering-correlation-id: 000eb308-6784-413d-637e-08d5ee5e79a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929F3B9F50A9554093C2B76A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e9KAhmEHVzkTEXxypQstMH1SCIRwWcgQjp9u5eI9Ca0rCg1DuUwExhDz7VJRM9qwQYd3jnlreDdNuFLUzGHKYnm2h/ct08v0F13ZV7XhWOpK5xB1wujHRyrhMlXY6TUtoRsHhWaYQrcINJ+USw9LHFsz5011T8J/wypgRyWBCmIEpYVu6ujrGfIT9WtQKEzd4Tmf0UdHPmTvpVaK4RRrFUuQRtZb17sMs5WMt4xVI6b3Ckbo9InXibhWDrBVmq2rLny+OI3oiWWfB4nsYHUvfZG+VRgZafOp/Ty2QPCEejjoCRENaRS/N7XIlAA+jxdYgMkpx4Bs/T3P0dHSnN+9vpfsoZxQr5ENdY8f+zwapBc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000eb308-6784-413d-637e-08d5ee5e79a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:08.3110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several commit walks in the codebase. Group them together into
a new commit-reach.c file and corresponding header. After we group these
walks into one place, we can reduce duplicate logic by calling
equivalent methods.

All methods are direct moves, except we also make the commit_contains()
method public so its consumers in ref-filter.c can still call it. We can
also test this method in a test-tool in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 121 +++++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  20 ++++++-
 ref-filter.c   | 145 +++----------------------------------------------
 3 files changed, 147 insertions(+), 139 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a6bc4781a6..01d796f011 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,8 +1,10 @@
 #include "cache.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "decorate.h"
 #include "prio-queue.h"
 #include "tree.h"
+#include "ref-filter.c"
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
@@ -411,3 +413,122 @@ int ref_newer(const struct object_id *new_oid, const =
struct object_id *old_oid)
 	unmark_and_free(used, TMP_MARK);
 	return found;
 }
+
+/*
+ * Mimicking the real stack, this stack lives on the heap, avoiding stack
+ * overflows.
+ *
+ * At each recursion step, the stack items points to the commits whose
+ * ancestors are to be inspected.
+ */
+struct contains_stack {
+	int nr, alloc;
+	struct contains_stack_entry {
+		struct commit *commit;
+		struct commit_list *parents;
+	} *contains_stack;
+};
+
+static int in_commit_list(const struct commit_list *want, struct commit *c=
)
+{
+	for (; want; want =3D want->next)
+		if (!oidcmp(&want->item->object.oid, &c->object.oid))
+			return 1;
+	return 0;
+}
+
+/*
+ * Test whether the candidate is contained in the list.
+ * Do not recurse to find out, though, but return -1 if inconclusive.
+ */
+static enum contains_result contains_test(struct commit *candidate,
+					  const struct commit_list *want,
+					  struct contains_cache *cache,
+					  uint32_t cutoff)
+{
+	enum contains_result *cached =3D contains_cache_at(cache, candidate);
+
+	/* If we already have the answer cached, return that. */
+	if (*cached)
+		return *cached;
+
+	/* or are we it? */
+	if (in_commit_list(want, candidate)) {
+		*cached =3D CONTAINS_YES;
+		return CONTAINS_YES;
+	}
+
+	/* Otherwise, we don't know; prepare to recurse */
+	parse_commit_or_die(candidate);
+
+	if (candidate->generation < cutoff)
+		return CONTAINS_NO;
+
+	return CONTAINS_UNKNOWN;
+}
+
+static void push_to_contains_stack(struct commit *candidate, struct contai=
ns_stack *contains_stack)
+{
+	ALLOC_GROW(contains_stack->contains_stack, contains_stack->nr + 1, contai=
ns_stack->alloc);
+	contains_stack->contains_stack[contains_stack->nr].commit =3D candidate;
+	contains_stack->contains_stack[contains_stack->nr++].parents =3D candidat=
e->parents;
+}
+
+static enum contains_result contains_tag_algo(struct commit *candidate,
+					      const struct commit_list *want,
+					      struct contains_cache *cache)
+{
+	struct contains_stack contains_stack =3D { 0, 0, NULL };
+	enum contains_result result;
+	uint32_t cutoff =3D GENERATION_NUMBER_INFINITY;
+	const struct commit_list *p;
+
+	for (p =3D want; p; p =3D p->next) {
+		struct commit *c =3D p->item;
+		load_commit_graph_info(the_repository, c);
+		if (c->generation < cutoff)
+			cutoff =3D c->generation;
+	}
+
+	result =3D contains_test(candidate, want, cache, cutoff);
+	if (result !=3D CONTAINS_UNKNOWN)
+		return result;
+
+	push_to_contains_stack(candidate, &contains_stack);
+	while (contains_stack.nr) {
+		struct contains_stack_entry *entry =3D &contains_stack.contains_stack[co=
ntains_stack.nr - 1];
+		struct commit *commit =3D entry->commit;
+		struct commit_list *parents =3D entry->parents;
+
+		if (!parents) {
+			*contains_cache_at(cache, commit) =3D CONTAINS_NO;
+			contains_stack.nr--;
+		}
+		/*
+		 * If we just popped the stack, parents->item has been marked,
+		 * therefore contains_test will return a meaningful yes/no.
+		 */
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
+		case CONTAINS_YES:
+			*contains_cache_at(cache, commit) =3D CONTAINS_YES;
+			contains_stack.nr--;
+			break;
+		case CONTAINS_NO:
+			entry->parents =3D parents->next;
+			break;
+		case CONTAINS_UNKNOWN:
+			push_to_contains_stack(parents->item, &contains_stack);
+			break;
+		}
+	}
+	free(contains_stack.contains_stack);
+	return contains_test(candidate, want, cache, cutoff);
+}
+
+int commit_contains(struct ref_filter *filter, struct commit *commit,
+		    struct commit_list *list, struct contains_cache *cache)
+{
+	if (filter->with_commit_tag_algo)
+		return contains_tag_algo(commit, list, cache) =3D=3D CONTAINS_YES;
+	return is_descendant_of(commit, list);
+}
diff --git a/commit-reach.h b/commit-reach.h
index f1cf9bfcd8..13dec25cee 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,8 +1,12 @@
 #ifndef __COMMIT_REACH_H__
 #define __COMMIT_REACH_H__
=20
+#include "commit-slab.h"
+
 struct commit;
 struct commit_list;
+struct contains_cache;
+struct ref_filter;
=20
 struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
@@ -20,7 +24,6 @@ int is_descendant_of(struct commit *commit, struct commit=
_list *with_commit);
 int in_merge_bases_many(struct commit *commit, int nr_reference, struct co=
mmit **reference);
 int in_merge_bases(struct commit *commit, struct commit *reference);
=20
-
 /*
  * Takes a list of commits and returns a new list where those
  * have been removed that can be reached from other commits in
@@ -41,4 +44,19 @@ void reduce_heads_replace(struct commit_list **heads);
=20
 int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
=20
+/*
+ * Unknown has to be "0" here, because that's the default value for
+ * contains_cache slab entries that have not yet been assigned.
+ */
+enum contains_result {
+	CONTAINS_UNKNOWN =3D 0,
+	CONTAINS_NO,
+	CONTAINS_YES
+};
+
+define_commit_slab(contains_cache, enum contains_result);
+
+int commit_contains(struct ref_filter *filter, struct commit *commit,
+		    struct commit_list *list, struct contains_cache *cache);
+
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index fca3ad040a..495e830fa5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1624,144 +1624,6 @@ static int get_ref_atom_value(struct ref_array_item=
 *ref, int atom,
 	return 0;
 }
=20
-/*
- * Unknown has to be "0" here, because that's the default value for
- * contains_cache slab entries that have not yet been assigned.
- */
-enum contains_result {
-	CONTAINS_UNKNOWN =3D 0,
-	CONTAINS_NO,
-	CONTAINS_YES
-};
-
-define_commit_slab(contains_cache, enum contains_result);
-
-struct ref_filter_cbdata {
-	struct ref_array *array;
-	struct ref_filter *filter;
-	struct contains_cache contains_cache;
-	struct contains_cache no_contains_cache;
-};
-
-/*
- * Mimicking the real stack, this stack lives on the heap, avoiding stack
- * overflows.
- *
- * At each recursion step, the stack items points to the commits whose
- * ancestors are to be inspected.
- */
-struct contains_stack {
-	int nr, alloc;
-	struct contains_stack_entry {
-		struct commit *commit;
-		struct commit_list *parents;
-	} *contains_stack;
-};
-
-static int in_commit_list(const struct commit_list *want, struct commit *c=
)
-{
-	for (; want; want =3D want->next)
-		if (!oidcmp(&want->item->object.oid, &c->object.oid))
-			return 1;
-	return 0;
-}
-
-/*
- * Test whether the candidate is contained in the list.
- * Do not recurse to find out, though, but return -1 if inconclusive.
- */
-static enum contains_result contains_test(struct commit *candidate,
-					  const struct commit_list *want,
-					  struct contains_cache *cache,
-					  uint32_t cutoff)
-{
-	enum contains_result *cached =3D contains_cache_at(cache, candidate);
-
-	/* If we already have the answer cached, return that. */
-	if (*cached)
-		return *cached;
-
-	/* or are we it? */
-	if (in_commit_list(want, candidate)) {
-		*cached =3D CONTAINS_YES;
-		return CONTAINS_YES;
-	}
-
-	/* Otherwise, we don't know; prepare to recurse */
-	parse_commit_or_die(candidate);
-
-	if (candidate->generation < cutoff)
-		return CONTAINS_NO;
-
-	return CONTAINS_UNKNOWN;
-}
-
-static void push_to_contains_stack(struct commit *candidate, struct contai=
ns_stack *contains_stack)
-{
-	ALLOC_GROW(contains_stack->contains_stack, contains_stack->nr + 1, contai=
ns_stack->alloc);
-	contains_stack->contains_stack[contains_stack->nr].commit =3D candidate;
-	contains_stack->contains_stack[contains_stack->nr++].parents =3D candidat=
e->parents;
-}
-
-static enum contains_result contains_tag_algo(struct commit *candidate,
-					      const struct commit_list *want,
-					      struct contains_cache *cache)
-{
-	struct contains_stack contains_stack =3D { 0, 0, NULL };
-	enum contains_result result;
-	uint32_t cutoff =3D GENERATION_NUMBER_INFINITY;
-	const struct commit_list *p;
-
-	for (p =3D want; p; p =3D p->next) {
-		struct commit *c =3D p->item;
-		load_commit_graph_info(the_repository, c);
-		if (c->generation < cutoff)
-			cutoff =3D c->generation;
-	}
-
-	result =3D contains_test(candidate, want, cache, cutoff);
-	if (result !=3D CONTAINS_UNKNOWN)
-		return result;
-
-	push_to_contains_stack(candidate, &contains_stack);
-	while (contains_stack.nr) {
-		struct contains_stack_entry *entry =3D &contains_stack.contains_stack[co=
ntains_stack.nr - 1];
-		struct commit *commit =3D entry->commit;
-		struct commit_list *parents =3D entry->parents;
-
-		if (!parents) {
-			*contains_cache_at(cache, commit) =3D CONTAINS_NO;
-			contains_stack.nr--;
-		}
-		/*
-		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful yes/no.
-		 */
-		else switch (contains_test(parents->item, want, cache, cutoff)) {
-		case CONTAINS_YES:
-			*contains_cache_at(cache, commit) =3D CONTAINS_YES;
-			contains_stack.nr--;
-			break;
-		case CONTAINS_NO:
-			entry->parents =3D parents->next;
-			break;
-		case CONTAINS_UNKNOWN:
-			push_to_contains_stack(parents->item, &contains_stack);
-			break;
-		}
-	}
-	free(contains_stack.contains_stack);
-	return contains_test(candidate, want, cache, cutoff);
-}
-
-static int commit_contains(struct ref_filter *filter, struct commit *commi=
t,
-			   struct commit_list *list, struct contains_cache *cache)
-{
-	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, list, cache) =3D=3D CONTAINS_YES;
-	return is_descendant_of(commit, list);
-}
-
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
@@ -1988,6 +1850,13 @@ static int filter_ref_kind(struct ref_filter *filter=
, const char *refname)
 	return ref_kind_from_refname(refname);
 }
=20
+struct ref_filter_cbdata {
+	struct ref_array *array;
+	struct ref_filter *filter;
+	struct contains_cache contains_cache;
+	struct contains_cache no_contains_cache;
+};
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
--=20
2.18.0.118.gd4f65b8d14

