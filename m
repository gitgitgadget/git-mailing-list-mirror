Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E408C1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbeGTRWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:16 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731000AbeGTRWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv70gji94lfmE9uB5nGQZCKxPDTeMAZueD2Z7GkhLDA=;
 b=ietKkFCjy6yUxYdNKTd0oYQmTMxCc1LzNvV+Ojf0CVC81Un+Nq9zYkuqdqrfsZooHPo6dIn0TlYpzd49rv9BTlgASle+hI5IuGko+ltCMUmoVXSj2QVoVosm93JgoKOgskVtpmW0O5HYftkNsSgf/foO0D9Xh3Un/GCzsMPk0TU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:06 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:06 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 03/18] commit-reach: move ref_newer from remote.c
Thread-Topic: [PATCH v2 03/18] commit-reach: move ref_newer from remote.c
Thread-Index: AQHUIEdWAE6SveBWa0eCZ1o/4bLm4A==
Date:   Fri, 20 Jul 2018 16:33:06 +0000
Message-ID: <20180720163227.105950-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:gWtTgjZ9Z9bcTMU1fX+vl00CJjpRClA4pl+dlKdhDZBKzYvqVEk/rhGcScOTCCdjv1cyFgJFKRO8JUwnQ2hIOcnw+VNs75p2lux3ezgJHKBhcfXzSYkuowJwhq4n1W7dgijNfRrgkMzVhGbqBrCat4MTX+8i10ehpwL3LuchpaIK4qXOqzM/Twl0WoKFgexwTxREGcTMdPNu3r7Jr8RSJfiP6vrbbyfNrKaF3h35eIQ3tQoB+BnMLo8srBw5BAhSNXIgjx9gQZ0FgvssuE0rlM/S2PUJvdhQmaIasXBeKI/5JKh6brILcvxDAVUrO9V93JrYzicF1Y6zjItEMpvYkC1+VAt3sJyXuE+jDBU1NueayWkxflL0JdXAJtiZaOZZeGEYqjKII4vTshG9zr8/3Mo8egADE4ECJzxhgcjmtAtJtKcwA9e2akCzO401nlM7SvqMVeG90GiGm9mrpyKzpQ==;5:K6arp/ED6pkiw9oOxzABp7iuwTcF2K0/kvi46jqB50JwpFSsIZDbAHruCvTJnnsREs2bjozY0jqUM4QISD3vmTDqaUupyLRyP5wYp1TTeiNeUJKOiBStXXPvxBRsN35zZj5UeMCi3nZMwxFx1qw2bM08KEy8qL60z1lfnwPP380=;7:0KgYWypBn2JBbjorHVf3um7gr2hyTW0Y9FaYCcQvPKhUNGOLClZleuevxd3/iMpxyXjjndfIYke8ocvVqZnlaoh5HttLt1qZkjOOlUDi4/xlMtDBGQ4GNt/fi0QSrGJqrl0nEcLof9WkMRv5+gPZfHjMwnX9fwNlj8/AUJRyQh6hFjoY5UYZbR07dh4g1NKZItgZnidQWkkZoXGbqFpEcCPb/cfeaqBkiyj9IYjgPLSwudD0NOM99Hf7I8TZLSfa
x-ms-office365-filtering-correlation-id: 3e8054e0-2c97-4c5e-f8ff-08d5ee5e78a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929E19C44B9A0A6BDDD53ECA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(575784001)(22452003)(1076002)(14444005)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004)(50194002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pQWFVZfS7MCFbUMpsQDRnsl0gyI+znihtsizEM/l8iCpfYWoyMHJHs+aPvkQu3qOpycOVgrcXtA0yOwFYteccbr2E1BhF7gw+mqUA5rIgUkRp2oUr64FpgAmuAj6Xf+/Ou826X6NN7CqF+WttMOTrH/qq8yLdt16ZMQeQ2H1LTBTlQvuTwpLvuYVXYuSkiQyOCcfBY37tItYQNpoxtE9oMAgA3WGxp+Yj5vs0immmJ16QIKSgUrg+MHKoZNyf8yb3iLvx4wFqKkvg2MwvKxkRq5pIlwAK302TRv4BQzy0uNwz1esvHwRhjmP1FxFuC+kgF9vXrTFLK4RJfKw+k8lg6V3XTV1G1EU+25uqae3iG0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8054e0-2c97-4c5e-f8ff-08d5ee5e78a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:06.5188
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

The ref_newer() method is used by 'git push -f' to check if a force-push
is necessary. By making the method public, we make it possible to test
the method directly without setting up an envieronment where a 'git
push' call makes sense.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/remote.c |  1 +
 commit-reach.c   | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
 commit-reach.h   |  2 ++
 remote.c         | 49 ------------------------------------------
 remote.h         |  1 -
 5 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c74ee88690..79b0326446 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -10,6 +10,7 @@
 #include "refspec.h"
 #include "object-store.h"
 #include "argv-array.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_remote_usage[] =3D {
 	N_("git remote [-v | --verbose]"),
diff --git a/commit-reach.c b/commit-reach.c
index 8ab6044414..a6bc4781a6 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,6 +1,10 @@
 #include "cache.h"
-#include "prio-queue.h"
 #include "commit.h"
+#include "decorate.h"
+#include "prio-queue.h"
+#include "tree.h"
+#include "revision.h"
+#include "tag.h"
 #include "commit-reach.h"
=20
 /* Remember to update object flag allocation in object.h */
@@ -358,3 +362,52 @@ void reduce_heads_replace(struct commit_list **heads)
 	free_commit_list(*heads);
 	*heads =3D result;
 }
+
+static void unmark_and_free(struct commit_list *list, unsigned int mark)
+{
+	while (list) {
+		struct commit *commit =3D pop_commit(&list);
+		commit->object.flags &=3D ~mark;
+	}
+}
+
+int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid)
+{
+	struct object *o;
+	struct commit *old_commit, *new_commit;
+	struct commit_list *list, *used;
+	int found =3D 0;
+
+	/*
+	 * Both new_commit and old_commit must be commit-ish and new_commit is de=
scendant of
+	 * old_commit.  Otherwise we require --force.
+	 */
+	o =3D deref_tag(the_repository, parse_object(the_repository, old_oid),
+		      NULL, 0);
+	if (!o || o->type !=3D OBJ_COMMIT)
+		return 0;
+	old_commit =3D (struct commit *) o;
+
+	o =3D deref_tag(the_repository, parse_object(the_repository, new_oid),
+		      NULL, 0);
+	if (!o || o->type !=3D OBJ_COMMIT)
+		return 0;
+	new_commit =3D (struct commit *) o;
+
+	if (parse_commit(new_commit) < 0)
+		return 0;
+
+	used =3D list =3D NULL;
+	commit_list_insert(new_commit, &list);
+	while (list) {
+		new_commit =3D pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new_commit, &used);
+		if (new_commit =3D=3D old_commit) {
+			found =3D 1;
+			break;
+		}
+	}
+	unmark_and_free(list, TMP_MARK);
+	unmark_and_free(used, TMP_MARK);
+	return found;
+}
diff --git a/commit-reach.h b/commit-reach.h
index 1ea2696e40..f1cf9bfcd8 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -39,4 +39,6 @@ struct commit_list *reduce_heads(struct commit_list *head=
s);
  */
 void reduce_heads_replace(struct commit_list **heads);
=20
+int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
+
 #endif
diff --git a/remote.c b/remote.c
index 8e99b9888a..f0c23bae48 100644
--- a/remote.c
+++ b/remote.c
@@ -1784,55 +1784,6 @@ int resolve_remote_symref(struct ref *ref, struct re=
f *list)
 	return 1;
 }
=20
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit *commit =3D pop_commit(&list);
-		commit->object.flags &=3D ~mark;
-	}
-}
-
-int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid)
-{
-	struct object *o;
-	struct commit *old_commit, *new_commit;
-	struct commit_list *list, *used;
-	int found =3D 0;
-
-	/*
-	 * Both new_commit and old_commit must be commit-ish and new_commit is de=
scendant of
-	 * old_commit.  Otherwise we require --force.
-	 */
-	o =3D deref_tag(the_repository, parse_object(the_repository, old_oid),
-		      NULL, 0);
-	if (!o || o->type !=3D OBJ_COMMIT)
-		return 0;
-	old_commit =3D (struct commit *) o;
-
-	o =3D deref_tag(the_repository, parse_object(the_repository, new_oid),
-		      NULL, 0);
-	if (!o || o->type !=3D OBJ_COMMIT)
-		return 0;
-	new_commit =3D (struct commit *) o;
-
-	if (parse_commit(new_commit) < 0)
-		return 0;
-
-	used =3D list =3D NULL;
-	commit_list_insert(new_commit, &list);
-	while (list) {
-		new_commit =3D pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new_commit, &used);
-		if (new_commit =3D=3D old_commit) {
-			found =3D 1;
-			break;
-		}
-	}
-	unmark_and_free(list, TMP_MARK);
-	unmark_and_free(used, TMP_MARK);
-	return found;
-}
-
 /*
  * Lookup the upstream branch for the given branch and if present, optiona=
lly
  * compute the commit ahead/behind values for the pair.
diff --git a/remote.h b/remote.h
index 45ecc6cefa..56fb9cbb27 100644
--- a/remote.h
+++ b/remote.h
@@ -149,7 +149,6 @@ extern struct ref **get_remote_refs(int fd_out, struct =
packet_reader *reader,
 				    const struct string_list *server_options);
=20
 int resolve_remote_symref(struct ref *ref, struct ref *list);
-int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
=20
 /*
  * Remove and free all but the first of any entries in the input list
--=20
2.18.0.118.gd4f65b8d14

