Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B66F1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHYWah (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 18:30:37 -0400
Received: from mout.web.de ([212.227.15.4]:58807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeHYWah (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 18:30:37 -0400
Received: from [192.168.178.36] ([91.20.53.4]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1g9a5y0ACg-00G2Nk; Sat, 25
 Aug 2018 20:50:40 +0200
Subject: [PATCH v2 2/2] fsck: use oidset for skiplist
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ae61a845-16fa-e2d6-935d-ce5eb1e33e5a@web.de>
Date:   Sat, 25 Aug 2018 20:50:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wvUW1QMIyHVNIi0BSkpj9UWRl1jPLE9/WFRutZtdqww4+dovpzm
 GjVA/CYzIgVG7fkCqUBwy3Vj/mbr7QfmxJIVz/DS/fZZDEJacccsaiL/WKdHsfsMZCRNt8T
 yg4EjmwPr5cAoupl0vGu7JzQik5gAX3lUM0BUIctTSgWIOSKcT+LodjkExvO8Q6VRDhu4xx
 IMC5a4bcPLhEcrX6l4vag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9xVCz5LjCPQ=:ahv26IJAUJCaRA+rhMwH3/
 KzV7V/KKAB6D7MbKOJXoiZfYnkj/O94kEnA9MwSyXCPk6ru/n59ht4wND8/Ao5J9gl6PDcXZg
 zyy3WmAS5Lf0YQUPjZOF1mgK9hnwJY9Z9MGTQ5kVwYEv/Yr6+D0pytFe5yHFsbddawDh0ehCd
 wb6yxrHgcjlHSVyKIwqHgV3em+ugLXATlntLGTad5515GiQxnrg1dp9+XWgvp4IJViGU1/+6w
 k4QOEVfDlqeTM1SoWmy1Qhmv+NHNWzikOfU6h/bqSfGaEiVDmodcuxk+6Owhsj2cjN9wI7GdE
 1Oc6Bgi2rATa2xyrlbFRFgc4tMcuLKNhoPWSxU8ScwitbSEydYYkimBDgB5Z1CHihYG42l6OL
 FR9BKxrjLvf78rSV9jBN7iFq9CqxV1J+JSeic9cMrlXLtB8GqN/cuSLOv7CgJVIa4ChDeCC7J
 M8Ksk7TCY/BN1+Ih4mHTcxNs4vAKS9kFHxASJ9Q9tq3cAHhewpY4igjHFynRNSL+AkE9q7Rn6
 zdiS2ivKageRmseZQQk4AzvyujmP/nUvKlNM8mQNZkzUADTrn+c+keUsr3RU7fDDeRaMlkUBe
 xyWTSROfLJ9b9hTbWGJw/v5/xTcb6sE58nwFvw4cR6zuaNCh3lI45PmrchLwaUzy/QiCXyKvM
 stYfK5gr/MSMNBUZe1BD9pV5U09blA656eGOQJXFQlqsxFgvjni35HaGR0VPMf+CesZrQWS/1
 f7b8NDcObPq5G4fZ6Z2YPzNX78x2oKIgyEMQLf4vkNe2OWLZONWjH3hr/fF/pCVNRutr4vJ9j
 LqsiWqZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Object IDs to skip are stored in a shared static oid_array.  Lookups do
a binary search on the sorted array.  The code checks if the object IDs
are already in the correct order while loading and skips sorting in that
case.  Lookups are done before reporting a (non-fatal) corruption and
before checking .gitmodules files.

Simplify the code by using an oidset instead.  Memory usage is a bit
higher, but we don't need to worry about any sort order anymore.  Embed
the oidset into struct fsck_options to make its ownership clear (no
hidden sharing) and avoid unnecessary pointer indirection.

Performance on repositories with a low number of reported issues and
.gitmodules files (i.e. the usual case) won't be affected much.  The
oidset should be a bit quicker with higher numbers of bad objects in
the skipList.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Added small documentation update.

 Documentation/config.txt |  2 +-
 fsck.c                   | 23 ++---------------------
 fsck.h                   |  8 +++++---
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2fa65b7516..80ab570579 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1715,7 +1715,7 @@ doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
 
 fsck.skipList::
-	The path to a sorted list of object names (i.e. one SHA-1 per
+	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
 	be ignored. This feature is useful when an established project
 	should be accepted despite early commits containing errors that
diff --git a/fsck.c b/fsck.c
index 972a26b9ba..4c643f1d40 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,7 +10,6 @@
 #include "fsck.h"
 #include "refs.h"
 #include "utf8.h"
-#include "sha1-array.h"
 #include "decorate.h"
 #include "oidset.h"
 #include "packfile.h"
@@ -182,19 +181,10 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 
 static void init_skiplist(struct fsck_options *options, const char *path)
 {
-	static struct oid_array skiplist = OID_ARRAY_INIT;
-	int sorted;
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 
-	if (options->skiplist)
-		sorted = options->skiplist->sorted;
-	else {
-		sorted = 1;
-		options->skiplist = &skiplist;
-	}
-
 	fp = fopen(path, "r");
 	if (!fp)
 		die("Could not open skip list: %s", path);
@@ -202,19 +192,12 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		const char *p;
 		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
 			die("Invalid SHA-1: %s", sb.buf);
-		oid_array_append(&skiplist, &oid);
-		if (sorted && skiplist.nr > 1 &&
-				oidcmp(&skiplist.oid[skiplist.nr - 2],
-				       &oid) > 0)
-			sorted = 0;
+		oidset_insert(&options->skiplist, &oid);
 	}
 	if (ferror(fp))
 		die_errno("Could not read '%s'", path);
 	fclose(fp);
 	strbuf_release(&sb);
-
-	if (sorted)
-		skiplist.sorted = 1;
 }
 
 static int parse_msg_type(const char *str)
@@ -319,9 +302,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 
 static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
 {
-	if (opts && opts->skiplist && obj)
-		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
-	return 0;
+	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
 }
 
 __attribute__((format (printf, 4, 5)))
diff --git a/fsck.h b/fsck.h
index 0c7e8c9428..b95595ae5f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -1,6 +1,8 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
 
+#include "oidset.h"
+
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
 #define FSCK_IGNORE 3
@@ -35,12 +37,12 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	int *msg_type;
-	struct oid_array *skiplist;
+	struct oidset skiplist;
 	struct decoration *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.18.0
