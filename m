Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB431F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966865AbeF2QMs (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:12:48 -0400
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:7270
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966039AbeF2QMo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVKfPlN5aJGiY1C2jgL7tgd/Nik/E3zSfIYo/5aVLNY=;
 b=PqHWcDG+qVpzIC6c+jcu7NbLekfeNyCzdtaT+56t+v0fzJ1Q3c+4QmY7EGeuWnnc4weW3iorW8cViL0d9nd5muRPpYqhgva9V2Cveham0q2IFfXDmCGPEEzEwmBS+Hngxrhp/DlxezQ5aEISLtqHUOo5meqczGIIrVR4X+3VcxE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:41 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:41 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 03/13] commit-reach: move commit_contains from ref-filter
Thread-Topic: [RFC PATCH 03/13] commit-reach: move commit_contains from
 ref-filter
Thread-Index: AQHUD8QBiU9uHxGyMUe5VQZ1IllLJg==
Date:   Fri, 29 Jun 2018 16:12:41 +0000
Message-ID: <20180629161223.229661-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:QItZAfx7gkP8KXJ1z2tICKpKLu2OLe0yL27GgUY9zR8AEguRqeFY+PseGnCWYXpS0D1zTKaUj8g4bvOQ83Z8DhEnM2gTzDGha5e1MIDusixAcmb+3CLbCOAOCu34P0Qk8KL8DLjbCLug2EOWh3FmjH9h+ZzoDkaf174o5YqG7ZDEAy/zACrEqooP840nGP67HI/RfGW9Ggl1/oeoU11HRuWrB9sBbXqxy83E4nJAvhM1w4e42N1iBZqIm3fscVUz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 049e46af-b0b1-443b-e3e8-08d5dddb2402
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB099411999A111E4306770277A14E0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(6346003)(486006)(476003)(97736004)(46003)(107886003)(575784001)(6506007)(386003)(186003)(446003)(86362001)(11346002)(86612001)(102836004)(6916009)(25786009)(6512007)(39060400002)(4326008)(2351001)(8936002)(1730700003)(14454004)(99286004)(81166006)(76176011)(81156014)(8676002)(5250100002)(256004)(10290500003)(305945005)(7736002)(2501003)(52116002)(478600001)(2616005)(53936002)(5660300001)(36756003)(54906003)(106356001)(105586002)(68736007)(1076002)(316002)(2906002)(6116002)(22452003)(10090500001)(6436002)(2900100001)(5640700003)(6486002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: wOYZH0M41YkEW+2F7zwOPgkbTZ9TOQs2uEcHXhxCzU8bp82MkEMYvP1jMg8R7pnXDq7ESKEpdttrEtqIRFpSMWdwEFESRPn0cUfK/TATpNLjhOSY3J0yyCwkK2wgRZI3BrR7RqbyDGH7z42SVdfDn1dQ3nWicjJorS29xMGY5Xw7yDAi0pSa2biRFxmFV9/8PrRxBkqsT85JjE9cklKkmtrzWvOD0Wp5QyneaFSaHNQfx9j2fubaYHNGA0sGiMJowSFsoXNdJ9MKgmcplq3JYknFRxJ3YENJaQYx0rHQnypWYT1Uj/GToXvGlVtc5d1H2QzMb/YI9Tc5Yjtty8Rxd3C7DI60g9QkCGyjy//qrpc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049e46af-b0b1-443b-e3e8-08d5dddb2402
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:41.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 119 +++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  44 +++++----------
 fast-import.c  |   1 +
 ref-filter.c   | 147 +++----------------------------------------------
 4 files changed, 141 insertions(+), 170 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 80cdb738f6..6cfd7379ce 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -409,3 +409,122 @@ int ref_newer(const struct object_id *new_oid, const =
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
+		load_commit_graph_info(c);
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
index 35ec9f0ddb..986fb388d5 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -2,42 +2,24 @@
 #define __COMMIT_REACH_H__
=20
 #include "commit.h"
+#include "commit-slab.h"
+#include "ref-filter.h"
=20
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos);
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos);
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two=
);
-struct commit_list *get_octopus_merge_bases(struct commit_list *in);
-
-/* To be used only when object flags after this call no longer matter */
-struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, =
struct commit **twos);
-
-int is_descendant_of(struct commit *commit, struct commit_list *with_commi=
t);
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct co=
mmit **reference);
-int in_merge_bases(struct commit *commit, struct commit *reference);
-
+int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
=20
 /*
- * Takes a list of commits and returns a new list where those
- * have been removed that can be reached from other commits in
- * the list. It is useful for, e.g., reducing the commits
- * randomly thrown at the git-merge command and removing
- * redundant commits that the user shouldn't have given to it.
- *
- * This function destroys the STALE bit of the commit objects'
- * flags.
+ * Unknown has to be "0" here, because that's the default value for
+ * contains_cache slab entries that have not yet been assigned.
  */
-struct commit_list *reduce_heads(struct commit_list *heads);
+enum contains_result {
+	CONTAINS_UNKNOWN =3D 0,
+	CONTAINS_NO,
+	CONTAINS_YES
+};
=20
-/*
- * Like `reduce_heads()`, except it replaces the list. Use this
- * instead of `foo =3D reduce_heads(foo);` to avoid memory leaks.
- */
-void reduce_heads_replace(struct commit_list **heads);
+define_commit_slab(contains_cache, enum contains_result);
=20
-int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
+int commit_contains(struct ref_filter *filter, struct commit *commit,
+		    struct commit_list *list, struct contains_cache *cache);
=20
 #endif
diff --git a/fast-import.c b/fast-import.c
index 4d55910ab9..49ce8e8426 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -171,6 +171,7 @@ Format of STDIN stream:
 #include "packfile.h"
 #include "object-store.h"
 #include "mem-pool.h"
+#include "commit-reach.h"
=20
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/ref-filter.c b/ref-filter.c
index fa3685d91f..f4f71728ae 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,7 +16,7 @@
 #include "trailer.h"
 #include "wt-status.h"
 #include "commit-slab.h"
-#include "commit-graph.h"
+#include "commit-reach.h"
=20
 static struct ref_msg {
 	const char *gone;
@@ -1620,144 +1620,6 @@ static int get_ref_atom_value(struct ref_array_item=
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
-		load_commit_graph_info(c);
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
@@ -1984,6 +1846,13 @@ static int filter_ref_kind(struct ref_filter *filter=
, const char *refname)
 	return ref_kind_from_refname(refname);
 }
=20
+struct ref_filter_cbdata {
+       struct ref_array *array;
+       struct ref_filter *filter;
+       struct contains_cache contains_cache;
+       struct contains_cache no_contains_cache;
+};
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
--=20
2.18.0.118.gd4f65b8d14

