Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40911F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbeGTSJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:09:06 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:28154
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387950AbeGTSJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgZ3NDf8X2L+R1eBWp9bIRSD5AFwJLG75gf4dMXi9To=;
 b=HhFYequ5Xb7D28YBUVmLojUSD5F4PmHnQLfKuljYTxYylV8DQ6D7EQbGERMmzZ7ZGGHjx441JgqyAeoy+EUCOcJV0EjX8BfOD2Mci/FgmaqGVdr85sH7cfAnZc/gdZw6VVtJANyRMjGFHoCqp/orYAgfd0XsBJyLNSpMYWRh5r0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1092.namprd21.prod.outlook.com (52.132.24.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.1; Fri, 20 Jul 2018 17:18:43 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 17:18:43 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
Thread-Topic: [PATCH v2 00/18] Consolidate reachability logic
Thread-Index: AQHUIEdSemqDJAjal068c7TOJ6Y3CKSYWtMA
Date:   Fri, 20 Jul 2018 17:18:43 +0000
Message-ID: <20180720171836.106091-1-dstolee@microsoft.com>
References: <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR10CA0023.namprd10.prod.outlook.com (2603:10b6:403::33)
 To BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;6:TVKxlPBSY/GwVgPyIjiPMy0BwFbftphXyV0iSPtEdvuZwynF53ma1usEcNY0/z+eUpRhrWU4XufwvpP52OfYHmDYvGhCiQ1LFN8DjSxGiy9OyEYHDGFO1ziPBeRBXWUbLe0nRX6dhR/c0ZrAif35+ki0hD18HLoXjJqr9GAYax9Nw6rYy90RG7zKtDFURMYk00r1WKGKbMb1wcNQUahQ+JJ4QiDFUYxmFpQSHJgcz+Bc1PO6TG2yLpnRTM20S0COdbFsVEENUVUI0B1Al6+jtcctjm0/L64lUhEmtRXBcTxS672QhkVHqdIbMOfTO/5qvUnZ9f/PC8maM3ccP2bGJM5vqZPM3N9rBaHUZZg27T06ZIfm5ht+zq9je5ynC62gVzEVk+Xtzo6R0phDIAAI5Xh24mV54xCsrTokhsI1jI1ybU8kGYbXuCKTUX/ie2/oDNQiYYEje5DbYKtyUEqgEQ==;5:mWp9sWM7lfmGz1s179bHCEBrBl0ZsLlypaRbeBK8BfOx8usSOJhZB7qul4xwc/chj78DvZG9YxXt9CNW3kEjbJ5R1SPK73+e3qfMaaLQnat1yr8Kpjp4L1KoaI1Z8n3yMTiuNHlg0WMk8BEdM7+LTjMCOBfDpLJ2IBiXfWvIlYM=;7:q55kepVCZUS+iQGWCi/0r1CTJNhN2RKQw0UlRWSCw7z54UD6FPrwC6euGQ+60Mlbpddeh427Xg+btggWMbniDNmXiN8LKA7klh8FQzVC4Rx+h9TFsRlh0V1HIDW2I6lOLU+QfOA7S7hzEeghksmM/IwxDgSc8sHGF7vl3yEcPpnraz+9gjTMB/hOVyKgGau/tesoELXDo9M0ieLbZNKEVcWkaivziW4fvX2cjON1H0VzapjSP9i7FNSxrCZkDm6h
x-ms-office365-filtering-correlation-id: 1472fe5f-beca-4972-296b-08d5ee64d7ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB109238A5C2F39E453521E85EA1510@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(476003)(186003)(2616005)(11346002)(446003)(99286004)(486006)(316002)(39060400002)(8936002)(2351001)(4326008)(54906003)(53946003)(53936002)(22452003)(305945005)(46003)(5660300001)(6436002)(6512007)(6916009)(1076002)(86362001)(575784001)(36756003)(478600001)(229853002)(6116002)(86612001)(5640700003)(10290500003)(6486002)(10090500001)(97736004)(14454004)(106356001)(105586002)(2900100001)(68736007)(5250100002)(2501003)(6246003)(102836004)(386003)(6506007)(14444005)(256004)(7736002)(76176011)(81166006)(81156014)(8676002)(1730700003)(25786009)(52116002)(2906002)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7IXFPsOsEE6IpUpEbtM2jzYKVAmsux6WBRbEjav5XQrBTL833pLQrlzVQI+h+/cNNQcR6/PhVdQ/ZV6bukf7iVCkIRPccvwXp5B4moZ4MaCgJUUvvP96LgljeHbx5lK2jor4lw4XcqNblfAyjJeSQnR2pnC1FmtmtVkTlA9K5q2JsWDShonyceI5txUH9qXa3jbRxy294aPh5tyS7LJ+JWsBWsYC6eJPKj6mVMa3hD7L+ss6fYtFH1+Hk3oHbxSaD0CJ3FEUgGkvShwwtIdHm3Ae2qMZDGMDBNPauaAKaOW9A8O7fQqT1VGF/oTbOzw5s5i8nRAWewOk4gn5jPwlaTZGElzVIyTdZATOC1ImvMM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1472fe5f-beca-4972-296b-08d5ee64d7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 17:18:43.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the diff between v1 and v2.

Thanks,
-Stolee

---

diff --git a/bisect.c b/bisect.c
index e1275ba79e..d023543c91 100644
--- a/bisect.c
+++ b/bisect.c
@@ -13,6 +13,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "commit-slab.h"
+#include "commit-reach.h"
=20
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
diff --git a/builtin/branch.c b/builtin/branch.c
index a50632fb23..9a787447f4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -23,6 +23,7 @@
 #include "ref-filter.h"
 #include "worktree.h"
 #include "help.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f843a..b5c608458e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "mailmap.h"
 #include "help.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	N_("git commit [<options>] [--] <pathspec>..."),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f5d960baec..7de234774b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -22,6 +22,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_fetch_usage[] =3D {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index ff165c0fcd..7277d557b2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,6 +12,7 @@
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 static const char * const fmt_merge_msg_usage[] =3D {
 	N_("git fmt-merge-msg [-m <message>] [--log[=3D<n>] | --no-log] [--file <=
file>]"),
diff --git a/builtin/log.c b/builtin/log.c
index 55a6286d7f..333d97c692 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@
 #include "progress.h"
 #include "commit-slab.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 #define MAIL_DEFAULT_WRAP 72
=20
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08d91b1f0c..1c92099070 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "parse-options.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
diff --git a/builtin/merge.c b/builtin/merge.c
index d1b547d973..4c601c40a2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -36,6 +36,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "commit-reach.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/pull.c b/builtin/pull.c
index 4e78935392..15ad010968 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -22,6 +22,7 @@
 #include "tempfile.h"
 #include "lockfile.h"
 #include "wt-status.h"
+#include "commit-reach.h"
=20
 enum rebase_type {
 	REBASE_INVALID =3D -1,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 400d31c18c..d8467f9734 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,6 +27,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "protocol.h"
+#include "commit-reach.h"
=20
 static const char * const receive_pack_usage[] =3D {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 0f09bbbf65..455f62246d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -14,6 +14,7 @@
 #include "revision.h"
 #include "split-index.h"
 #include "submodule.h"
+#include "commit-reach.h"
=20
 #define DO_REVS		1
 #define DO_NOREV	2
diff --git a/commit-reach.c b/commit-reach.c
index 9eb6225403..c996524032 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -4,6 +4,7 @@
 #include "decorate.h"
 #include "prio-queue.h"
 #include "tree.h"
+#include "ref-filter.c"
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
@@ -536,7 +537,8 @@ static int compare_commits_by_gen(const void *_a, const=
 void *_b)
 }
=20
 int can_all_from_reach_with_flag(struct object_array *from,
-				 int with_flag, int assign_flag,
+				 unsigned int with_flag,
+				 unsigned int assign_flag,
 				 time_t min_commit_date,
 				 uint32_t min_generation)
 {
@@ -548,9 +550,8 @@ int can_all_from_reach_with_flag(struct object_array *f=
rom,
 	for (i =3D 0; i < from->nr; i++) {
 		list[i] =3D (struct commit *)from->objects[i].item;
=20
-		parse_commit(list[i]);
-
-		if (list[i]->generation < min_generation)
+		if (parse_commit(list[i]) ||
+		    list[i]->generation < min_generation)
 			return 0;
 	}
=20
@@ -578,9 +579,8 @@ int can_all_from_reach_with_flag(struct object_array *f=
rom,
 				if (!(parent->item->object.flags & assign_flag)) {
 					parent->item->object.flags |=3D assign_flag;
=20
-					parse_commit(parent->item);
-
-					if (parent->item->date < min_commit_date ||
+					if (parse_commit(parent->item) ||
+					    parent->item->date < min_commit_date ||
 					    parent->item->generation < min_generation)
 						continue;
=20
diff --git a/commit-reach.h b/commit-reach.h
index 482d9eb5dd..7d313e2975 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,9 +1,12 @@
 #ifndef __COMMIT_REACH_H__
 #define __COMMIT_REACH_H__
=20
-#include "commit.h"
 #include "commit-slab.h"
-#include "ref-filter.h"
+
+struct commit;
+struct commit_list;
+struct contains_cache;
+struct ref_filter;
=20
 struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
@@ -56,9 +59,6 @@ define_commit_slab(contains_cache, enum contains_result);
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
=20
-int reachable(struct commit *from, int with_flag, int assign_flag,
-	      time_t min_commit_date);
-
 /*
  * Determine if every commit in 'from' can reach at least one commit
  * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
@@ -67,7 +67,8 @@ int reachable(struct commit *from, int with_flag, int ass=
ign_flag,
  * 'min_generation'.
  */
 int can_all_from_reach_with_flag(struct object_array *from,
-				 int with_flag, int assign_flag,
+				 unsigned int with_flag,
+				 unsigned int assign_flag,
 				 time_t min_commit_date,
 				 uint32_t min_generation);
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
diff --git a/commit.h b/commit.h
index da0db36eba..e2c99d9b04 100644
--- a/commit.h
+++ b/commit.h
@@ -204,13 +204,6 @@ struct commit_graft *read_graft_line(struct strbuf *li=
ne);
 int register_commit_graft(struct repository *r, struct commit_graft *, int=
);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struc=
t object_id *oid);
=20
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct com=
mit *rev2);
-extern struct commit_list *get_merge_bases_many(struct commit *one, int n,=
 struct commit **twos);
-extern struct commit_list *get_octopus_merge_bases(struct commit_list *in)=
;
-
-/* To be used only when object flags after this call no longer matter */
-extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, =
int n, struct commit **twos);
-
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
=20
@@ -258,32 +251,10 @@ extern int delayed_reachability_test(struct shallow_i=
nfo *si, int c);
 extern void prune_shallow(int show_only);
 extern struct trace_key trace_shallow;
=20
-int is_descendant_of(struct commit *, struct commit_list *);
-int in_merge_bases(struct commit *, struct commit *);
-int in_merge_bases_many(struct commit *, int, struct commit **);
-
 extern int interactive_add(int argc, const char **argv, const char *prefix=
, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mod=
e,
 			       const struct pathspec *pathspec);
=20
-/*
- * Takes a list of commits and returns a new list where those
- * have been removed that can be reached from other commits in
- * the list. It is useful for, e.g., reducing the commits
- * randomly thrown at the git-merge command and removing
- * redundant commits that the user shouldn't have given to it.
- *
- * This function destroys the STALE bit of the commit objects'
- * flags.
- */
-extern struct commit_list *reduce_heads(struct commit_list *heads);
-
-/*
- * Like `reduce_heads()`, except it replaces the list. Use this
- * instead of `foo =3D reduce_heads(foo);` to avoid memory leaks.
- */
-extern void reduce_heads_replace(struct commit_list **heads);
-
 struct commit_extra_header {
 	struct commit_extra_header *next;
 	char *key;
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.co=
cci
index a7e9215ffc..aec3345adb 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -12,7 +12,7 @@ expression c;
=20
 // These excluded functions must access c->maybe_tree direcly.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph|load_tree_for_=
commit)$";
+identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_=
for_commit)$";
 expression c;
 @@
   f(...) {...
diff --git a/http-push.c b/http-push.c
index e007cb5a6b..91fdc7e1d5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -16,7 +16,6 @@
 #include "object-store.h"
 #include "commit-reach.h"
=20
-
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
 #else
diff --git a/merge-recursive.c b/merge-recursive.c
index 1dd6ec384d..8155dee9a9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -27,6 +27,7 @@
 #include "dir.h"
 #include "submodule.h"
 #include "revision.h"
+#include "commit-reach.h"
=20
 struct path_hashmap_entry {
 	struct hashmap_entry e;
diff --git a/notes-merge.c b/notes-merge.c
index 76ab19e702..12dfdf6c17 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -12,6 +12,7 @@
 #include "notes-merge.h"
 #include "strbuf.h"
 #include "notes-utils.h"
+#include "commit-reach.h"
=20
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
diff --git a/object.h b/object.h
index fa5ca97567..b132944c51 100644
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
- * commit.c:                                        16-----19
+ * commit-reach.c:                                15-------19
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
  * builtin/fsck.c:           0--3
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 953c5dd84d..55bcab907c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -11,6 +11,7 @@
 #include "pack-bitmap.h"
 #include "sha1-lookup.h"
 #include "pack-objects.h"
+#include "commit-reach.h"
=20
 struct bitmapped_commit {
 	struct commit *commit;
diff --git a/ref-filter.c b/ref-filter.c
index 35b2d25ce5..495e830fa5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -18,6 +18,7 @@
 #include "trailer.h"
 #include "wt-status.h"
 #include "commit-slab.h"
+#include "commit-graph.h"
 #include "commit-reach.h"
=20
 static struct ref_msg {
diff --git a/revision.c b/revision.c
index 4dbe406bed..3205a3947a 100644
--- a/revision.c
+++ b/revision.c
@@ -24,6 +24,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "argv-array.h"
+#include "commit-reach.h"
=20
 volatile show_early_output_fn_t show_early_output;
=20
diff --git a/sequencer.c b/sequencer.c
index d1d07bed5b..97bdfd48b4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -30,6 +30,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "commit-reach.h"
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
=20
diff --git a/sha1-name.c b/sha1-name.c
index 009faab4ae..7215b30b88 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 static int get_oid_oneline(const char *, struct object_id *, struct commit=
_list *);
=20
diff --git a/shallow.c b/shallow.c
index dbe8a2a290..99fd2d1ba0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "commit-slab.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 void set_alternate_shallow_file(struct repository *r, const char *path, in=
t override)
 {
diff --git a/submodule.c b/submodule.c
index 6688dd5d45..6650ed7aa0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 #include "worktree.h"
 #include "parse-options.h"
 #include "object-store.h"
+#include "commit-reach.h"
=20
 static int config_update_recurse_submodules =3D RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_names =3D STRING_LIST_INIT_DUP=
;
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index dc97100992..eb21103998 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,10 +1,31 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
 #include "parse-options.h"
+#include "ref-filter.h"
+#include "string-list.h"
 #include "tag.h"
=20
+static void print_sorted_commit_ids(struct commit_list *list)
+{
+	int i;
+	struct string_list s =3D STRING_LIST_INIT_DUP;
+
+	while (list) {
+		string_list_append(&s, oid_to_hex(&list->item->object.oid));
+		list =3D list->next;
+	}
+
+	string_list_sort(&s);
+
+	for (i =3D 0; i < s.nr; i++)
+		printf("%s\n", s.items[i].string);
+
+	string_list_clear(&s, 0);
+}
+
 int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
@@ -77,7 +98,7 @@ int cmd__reach(int ac, const char **av)
 	strbuf_release(&buf);
=20
 	if (!strcmp(av[1], "ref_newer"))
-		printf("%s:%d\n", av[1], ref_newer(&oid_A, &oid_B));
+		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_bases"))
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
 	else if (!strcmp(av[1], "is_descendant_of"))
@@ -85,19 +106,24 @@ int cmd__reach(int ac, const char **av)
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
 		struct commit_list *list =3D get_merge_bases_many(A, X_nr, X_array);
 		printf("%s(A,X):\n", av[1]);
-		while (list) {
-			printf("%s\n", oid_to_hex(&list->item->object.oid));
-			list =3D list->next;
-		}
+		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
 		struct commit_list *list =3D reduce_heads(X);
 		printf("%s(X):\n", av[1]);
-		while (list) {
-			printf("%s\n", oid_to_hex(&list->item->object.oid));
-			list =3D list->next;
-		}
+		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
 		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
+	} else if (!strcmp(av[1], "commit_contains")) {
+		struct ref_filter filter;
+		struct contains_cache cache;
+		init_contains_cache(&cache);
+
+		if (ac > 2 && !strcmp(av[2], "--tag"))
+			filter.with_commit_tag_algo =3D 1;
+		else
+			filter.with_commit_tag_algo =3D 0;
+
+		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache)=
);
 	}
=20
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index cb07c64310..d139a00d1d 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -23,7 +23,7 @@ test_description=3D'basic commit reachability tests'
 #              \    /
 #              (1,1)
 #
-# We use branch 'comit-x-y' to refer to (x,y).
+# We use branch 'commit-x-y' to refer to (x,y).
 # This grid allows interesting reachability and
 # non-reachability queries: (x,y) can reach (x',y')
 # if and only if x' <=3D x and y' <=3D y.
@@ -48,7 +48,7 @@ test_expect_success 'setup' '
 	done &&
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
-	git show-ref -s commit-7-7 | git commit-graph write --stdin-commits &&
+	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
 	mv .git/objects/info/commit-graph commit-graph-half &&
 	git config core.commitGraph true
 '
@@ -67,142 +67,176 @@ test_three_modes () {
=20
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
-		A:commit-5-7
-		B:commit-4-9
+	A:commit-5-7
+	B:commit-4-9
 	EOF
-	printf "ref_newer:0\n" >expect &&
+	echo "ref_newer(A,B):0" >expect &&
 	test_three_modes ref_newer
 '
=20
 test_expect_success 'ref_newer:hit' '
 	cat >input <<-\EOF &&
-		A:commit-5-7
-		B:commit-2-3
+	A:commit-5-7
+	B:commit-2-3
 	EOF
-	printf "ref_newer:1\n" >expect &&
+	echo "ref_newer(A,B):1" >expect &&
 	test_three_modes ref_newer
 '
=20
 test_expect_success 'in_merge_bases:hit' '
-	cat >input <<- EOF &&
-		A:commit-5-7
-		B:commit-8-8
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	B:commit-8-8
 	EOF
-	printf "in_merge_bases(A,B):1\n" >expect &&
+	echo "in_merge_bases(A,B):1" >expect &&
 	test_three_modes in_merge_bases
 '
=20
 test_expect_success 'in_merge_bases:miss' '
-	cat >input <<- EOF &&
-		A:commit-6-8
-		B:commit-5-9
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	B:commit-5-9
 	EOF
-	printf "in_merge_bases(A,B):0\n" >expect &&
+	echo "in_merge_bases(A,B):0" >expect &&
 	test_three_modes in_merge_bases
 '
=20
 test_expect_success 'is_descendant_of:hit' '
 	cat >input <<-\EOF &&
-		A:commit-5-7
-		X:commit-4-8
-		X:commit-6-6
-		X:commit-1-1
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-1-1
 	EOF
-	printf "is_descendant_of(A,X):1\n" >expect &&
+	echo "is_descendant_of(A,X):1" >expect &&
 	test_three_modes is_descendant_of
 '
=20
 test_expect_success 'is_descendant_of:miss' '
 	cat >input <<-\EOF &&
-		A:commit-6-8
-		X:commit-5-9
-		X:commit-4-10
-		X:commit-7-6
+	A:commit-6-8
+	X:commit-5-9
+	X:commit-4-10
+	X:commit-7-6
 	EOF
-	printf "is_descendant_of(A,X):0\n" >expect &&
+	echo "is_descendant_of(A,X):0" >expect &&
 	test_three_modes is_descendant_of
 '
=20
 test_expect_success 'get_merge_bases_many' '
 	cat >input <<-\EOF &&
-		A:commit-5-7
-		X:commit-4-8
-		X:commit-6-6
-		X:commit-8-3
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-8-3
 	EOF
 	{
-		printf "get_merge_bases_many(A,X):\n" &&
-		git rev-parse commit-5-6 &&
-		git rev-parse commit-4-7
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse commit-5-6 \
+			      commit-4-7 | sort
 	} >expect &&
 	test_three_modes get_merge_bases_many
 '
=20
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
-		X:commit-1-10
-		X:commit-2-8
-		X:commit-3-6
-		X:commit-4-4
-		X:commit-1-7
-		X:commit-2-5
-		X:commit-3-3
-		X:commit-5-1
+	X:commit-1-10
+	X:commit-2-8
+	X:commit-3-6
+	X:commit-4-4
+	X:commit-1-7
+	X:commit-2-5
+	X:commit-3-3
+	X:commit-5-1
 	EOF
 	{
-		printf "reduce_heads(X):\n" &&
-		git rev-parse commit-5-1 &&
-		git rev-parse commit-4-4 &&
-		git rev-parse commit-3-6 &&
-		git rev-parse commit-2-8 &&
-		git rev-parse commit-1-10
+		echo "reduce_heads(X):" &&
+		git rev-parse commit-5-1 \
+			      commit-4-4 \
+			      commit-3-6 \
+			      commit-2-8 \
+			      commit-1-10 | sort
 	} >expect &&
 	test_three_modes reduce_heads
 '
=20
 test_expect_success 'can_all_from_reach:hit' '
 	cat >input <<-\EOF &&
-		X:commit-2-10
-		X:commit-3-9
-		X:commit-4-8
-		X:commit-5-7
-		X:commit-6-6
-		X:commit-7-5
-		X:commit-8-4
-		X:commit-9-3
-		Y:commit-1-9
-		Y:commit-2-8
-		Y:commit-3-7
-		Y:commit-4-6
-		Y:commit-5-5
-		Y:commit-6-4
-		Y:commit-7-3
-		Y:commit-8-1
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	Y:commit-1-9
+	Y:commit-2-8
+	Y:commit-3-7
+	Y:commit-4-6
+	Y:commit-5-5
+	Y:commit-6-4
+	Y:commit-7-3
+	Y:commit-8-1
 	EOF
-	printf "can_all_from_reach(X,Y):1\n" >expect &&
+	echo "can_all_from_reach(X,Y):1" >expect &&
 	test_three_modes can_all_from_reach
 '
=20
 test_expect_success 'can_all_from_reach:miss' '
 	cat >input <<-\EOF &&
-		X:commit-2-10
-		X:commit-3-9
-		X:commit-4-8
-		X:commit-5-7
-		X:commit-6-6
-		X:commit-7-5
-		X:commit-8-4
-		X:commit-9-3
-		Y:commit-1-9
-		Y:commit-2-8
-		Y:commit-3-7
-		Y:commit-4-6
-		Y:commit-5-5
-		Y:commit-6-4
-		Y:commit-8-5
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	Y:commit-1-9
+	Y:commit-2-8
+	Y:commit-3-7
+	Y:commit-4-6
+	Y:commit-5-5
+	Y:commit-6-4
+	Y:commit-8-5
 	EOF
-	printf "can_all_from_reach(X,Y):0\n" >expect &&
+	echo "can_all_from_reach(X,Y):0" >expect &&
 	test_three_modes can_all_from_reach
 '
=20
+test_expect_success 'commit_contains:hit' '
+	cat >input <<-\EOF &&
+	A:commit-7-7
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	EOF
+	echo "commit_contains(_,A,X,_):1" >expect &&
+	test_three_modes commit_contains &&
+	test_three_modes commit_contains --tag
+'
+
+test_expect_success 'commit_contains:miss' '
+	cat >input <<-\EOF &&
+	A:commit-6-5
+	X:commit-2-10
+	X:commit-3-9
+	X:commit-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	EOF
+	echo "commit_contains(_,A,X,_):0" >expect &&
+	test_three_modes commit_contains &&
+	test_three_modes commit_contains --tag
+'
+
 test_done
