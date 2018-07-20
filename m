Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C701F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeGTRWf (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:35 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:31488
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387732AbeGTRWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aeIQiuAQnliLXwNlEbeFoFkFsc/DCfa4j1xlvOWYKs=;
 b=SKosONTBFu0NFNmDqi0wqyhevloeQAk/Z9PYK8Ez4qRhiiOzu/1B0aqSeDe/gjcz+OYI5IActDzJ9SX3PMftJdSf4bZatmMcwk90yclNxxzRnH0aH3ti8l+wiCAMO5GpNNk7LKVvEdonoUsvPZ9mwBMv4+5vn0+MH5V7NZT3PPU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:13 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:13 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 08/18] commit-reach: move can_all_from_reach_with_flags
Thread-Topic: [PATCH v2 08/18] commit-reach: move
 can_all_from_reach_with_flags
Thread-Index: AQHUIEdaByDVN8eDJ06QMs/6kMURbg==
Date:   Fri, 20 Jul 2018 16:33:13 +0000
Message-ID: <20180720163227.105950-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:mGpFtiby7t5+52eh3ktejA+I8neL9tYfdEuqXTKx4ENHUr3lXp3b9ihYhp3DDpAHru2UoucEAEuiQo9KOWzr24iuQ1XgLJEWOgUQ50PnwZ/400FWSa11i+JFp5eQn/U3wNj5hJpTA42QVfKsIVuTs2b2W5WDYJNP9fjk+s29NOfroaPqoS3NZpa3JTemINmDab+v/bbXn+d1FPvvuUvVE0H4LhaaZ6VgBHyJCWFi1uqld4dU03aYWl0Kira4vGtrQE1DXMvFC/XiDDfB4mKk8m6XCb8QQ/d+r9ioVAkfVdhi1VpCw0KydrCaoiEZn/Lm+bmWGyY05ZGceaLSYX1XjcauHBZMOsb3Inm1WcPUSTp01bVPPQVVFdsUJD84DWfe75Hdv6M57DRUr2lV2YmID+HmlnYcpo4B00i7C+BcNSx7W0LEcfxUZeg5VGLw9vZkKUjh2QJThr2wNP6QT+J2bQ==;5:WUmrErWtZw6Nw9ZigqQMiR143v1rB7mj3nk98dWX316qHXr56zXIQprqG6e8zgI0s5Gw2NY35bMaJWuCDfbk8ckagD+mXtoU2igekg6kupQc+e2Z6eKjlrtTpieE46kE1vNdcmALLkmn1/aFlg/NcyaqvZlHHhOQD+CcRa1M6kY=;7:BSja+y4KqOadGGyS8c0kjYLp3nQiQJZ4z1raN3aAo6iRwouDgNHgNocULdYoOokvoAa2yGZhjmLQl3VivNMBInQDFRfFg8oxTI/joIhuNFXCNIZoH2nndF5j1vJIznwJ0RT6rAENM+rgdpHGqH7bEjW5XvLzdplU93OXxi71C+PLeRDN1xRbgYq9vBb+5bsfcITQy6XftCOD1EdwLKe/J+AgVWoKs2lWUCmsnTQIdSww8dmUyo0CAoStn/S2g//r
x-ms-office365-filtering-correlation-id: cf1a7b85-a155-4eda-d7b6-08d5ee5e7cec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09293157F5CBD69F97172B8FA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(14444005)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /ooy+ukDK5EdVB0P1LXtWwkVutbkK7HQzHYwjsQUqm5fUotD4Gov0M/Wg2fQqlc8yAddX9NhpVHQz1qN0FZVRlHLJkYtXKQob0WYaV19x1setpsOYpDUbrFpt9XG00r90ibVf9730GHOKVuA2I0VPXti/lq4Hp9y7MFrAZlp8U3BnXBcqU7OUdYbYWhvhPV1O7u2jyEixt1yI7tlcu6JZxbuSmHag7kBb0ARgxU4acvAYJ2H8llr8rpjmOF0QrZ0j8dZ+y8gUDAjpP+d94wtTfIEyH8WfHvZEHlOCOlq957lgANAP+hgrMk8vpBm8eIAVPUQeBhR6CSQyZfNw4vaOD0p/q/Q7trmE5FLu3srj9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a7b85-a155-4eda-d7b6-08d5ee5e7cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:13.8790
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

The can_all_from_reach_with_flags method is used in a stateful way by
upload-pack.c. The parameters are very flexible, so we will be able to
use its commit walking logic for many other callers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h | 14 ++++++++++
 object.h       |  4 +--
 upload-pack.c  | 70 +-------------------------------------------------
 4 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 01d796f011..d806291d5d 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -10,6 +10,7 @@
 #include "commit-reach.h"
=20
 /* Remember to update object flag allocation in object.h */
+#define REACHABLE       (1u<<15)
 #define PARENT1		(1u<<16)
 #define PARENT2		(1u<<17)
 #define STALE		(1u<<18)
@@ -532,3 +533,65 @@ int commit_contains(struct ref_filter *filter, struct =
commit *commit,
 		return contains_tag_algo(commit, list, cache) =3D=3D CONTAINS_YES;
 	return is_descendant_of(commit, list);
 }
+
+int reachable(struct commit *from, unsigned int with_flag,
+	      unsigned int assign_flag, time_t min_commit_date)
+{
+	struct prio_queue work =3D { compare_commits_by_commit_date };
+
+	prio_queue_put(&work, from);
+	while (work.nr) {
+		struct commit_list *list;
+		struct commit *commit =3D prio_queue_get(&work);
+
+		if (commit->object.flags & with_flag) {
+			from->object.flags |=3D assign_flag;
+			break;
+		}
+		if (!commit->object.parsed)
+			parse_object(the_repository, &commit->object.oid);
+		if (commit->object.flags & REACHABLE)
+			continue;
+		commit->object.flags |=3D REACHABLE;
+		if (commit->date < min_commit_date)
+			continue;
+		for (list =3D commit->parents; list; list =3D list->next) {
+			struct commit *parent =3D list->item;
+			if (!(parent->object.flags & REACHABLE))
+				prio_queue_put(&work, parent);
+		}
+	}
+	from->object.flags |=3D REACHABLE;
+	clear_commit_marks(from, REACHABLE);
+	clear_prio_queue(&work);
+	return (from->object.flags & assign_flag);
+}
+
+int can_all_from_reach_with_flag(struct object_array *from,
+				 unsigned int with_flag,
+				 unsigned int assign_flag,
+				 time_t min_commit_date)
+{
+	int i;
+
+	for (i =3D 0; i < from->nr; i++) {
+		struct object *from_one =3D from->objects[i].item;
+
+		if (from_one->flags & assign_flag)
+			continue;
+		from_one =3D deref_tag(the_repository, from_one, "a from object", 0);
+		if (!from_one || from_one->type !=3D OBJ_COMMIT) {
+			/* no way to tell if this is reachable by
+			 * looking at the ancestry chain alone, so
+			 * leave a note to ourselves not to worry about
+			 * this object anymore.
+			 */
+			from->objects[i].item->flags |=3D assign_flag;
+			continue;
+		}
+		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
+			       min_commit_date))
+			return 0;
+	}
+	return 1;
+}
diff --git a/commit-reach.h b/commit-reach.h
index 13dec25cee..b28bc22fcd 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -59,4 +59,18 @@ define_commit_slab(contains_cache, enum contains_result)=
;
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
=20
+int reachable(struct commit *from, unsigned int with_flag,
+	      unsigned int assign_flag, time_t min_commit_date);
+
+/*
+ * Determine if every commit in 'from' can reach at least one commit
+ * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
+ * as a marker for commits that are already visited. Do not walk
+ * commits with date below 'min_commit_date'.
+ */
+int can_all_from_reach_with_flag(struct object_array *from,
+				 unsigned int with_flag,
+				 unsigned int assign_flag,
+				 time_t min_commit_date);
+
 #endif
diff --git a/object.h b/object.h
index 18c2b073e3..b132944c51 100644
--- a/object.h
+++ b/object.h
@@ -60,12 +60,12 @@ struct object_array {
  * revision.h:               0---------10                                2=
6
  * fetch-pack.c:             0----5
  * walker.c:                 0-2
- * upload-pack.c:                4       11----------------19
+ * upload-pack.c:                4       11-----14  16-----19
  * builtin/blame.c:                        12-13
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                                     16-----19
- * commit-reach.c:                                  16-----19
+ * commit-reach.c:                                15-------19
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
  * builtin/fsck.c:           0--3
diff --git a/upload-pack.c b/upload-pack.c
index 427de461d8..11c426685d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -24,13 +24,13 @@
 #include "quote.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "commit-reach.h"
=20
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
 #define OUR_REF		(1u << 12)
 #define WANTED		(1u << 13)
 #define COMMON_KNOWN	(1u << 14)
-#define REACHABLE	(1u << 15)
=20
 #define SHALLOW		(1u << 16)
 #define NOT_SHALLOW	(1u << 17)
@@ -336,74 +336,6 @@ static int got_oid(const char *hex, struct object_id *=
oid)
 	return 0;
 }
=20
-static int reachable(struct commit *from, unsigned int with_flag,
-		     unsigned int assign_flag, time_t min_commit_date)
-{
-	struct prio_queue work =3D { compare_commits_by_commit_date };
-
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
-}
-
-/*
- * Determine if every commit in 'from' can reach at least one commit
- * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
- * as a marker for commits that are already visited. Do not walk
- * commits with date below 'min_commit_date'.
- */
-static int can_all_from_reach_with_flag(struct object_array *from,
-					unsigned int with_flag,
-					unsigned int assign_flag,
-					time_t min_commit_date)
-{
-	int i;
-
-	for (i =3D 0; i < from->nr; i++) {
-		struct object *from_one =3D from->objects[i].item;
-
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
-			return 0;
-	}
-	return 1;
-}
-
 static int ok_to_give_up(void)
 {
 	if (!have_obj.nr)
--=20
2.18.0.118.gd4f65b8d14

