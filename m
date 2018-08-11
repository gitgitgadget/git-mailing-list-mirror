Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4821F404
	for <e@80x24.org>; Sat, 11 Aug 2018 15:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeHKSWn (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 14:22:43 -0400
Received: from mout.web.de ([217.72.192.78]:45303 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKSWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 14:22:43 -0400
Received: from [192.168.178.36] ([79.237.254.3]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzba-1fjcYc0tQA-00Dq2J; Sat, 11
 Aug 2018 17:48:00 +0200
Subject: [PATCH 2/2] fsck: use oidset for skiplist
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
Date:   Sat, 11 Aug 2018 17:47:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ww2G32tL50UbuBfxBdoVtB0cpYAhu5UQmr8HYon/LLxD5/9fJR1
 RRJE1BuVKpATeM6zvVOrujiWy/o0NH9BPMb0g1C6OHaUoLZWqP74tI+e5WZkZNV9sEQ4iwe
 JfK0rz8RE5K8+kqN/iFZ5rcco+jKnfuK8FmKN9hSLa4Ee1kvUnzgVO9psm3I75FpwM5hrVG
 K/uW2njtRKG1Rjys9ZJbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+0fLItF+wBs=:5NzqJbYcXNMqhHQOCoGT1n
 NY7oGvFVsoYRsdIyUkrl92N5Kfh88ZOppWtDt6UPamfnU/3/jDcJ4FeZSFGUM0S/voqN9I7YT
 kF26LOlbXIAVkWmnbxWlkh5bUHiubcyIOX/U+i2n9hDaUZa/ECqXj5e3BjYLY6mBsVHVt1du2
 kmf4GgqB1Vq3h0hprCd1dNDCfGgekSAtVfJ4OPcT6eQk7dyVkzm8z8YlMlsQmCmDDbeH+nWme
 yeInsoakeR5kLHxLWdqwllocMiakTWAD4Tj16yYM/anRTXNUIhMF3ZtuWJ47yPQtgxMxTYsvj
 r+Ib8YiXThkY3L2ogCl0O9Qm+YGxAQCjkxGKArxQOlEPtobFdKro+aTTKfaSRXyXaYX3ltuOI
 BTecsF2+2YBlGLi9h0CxxRO/+Av6kPbx0ETBHFuzPVCTwxXZVuWWbAnitWCafJzTmp9ul4rRc
 5xX9Xb69uC37cF/GJFy0NMMuPziOCXNAMXemnOCIXWGktm34nLya9o6qgnM0/uWBVC4MYOxlq
 hkZAiIgVy24YmoS+WXLlanLNTX4rX2t26ilphFwgG/oGyVAtxJUf71F5YP1H5gmGw+Nh6fNny
 YtzGT4grBxx7HXZxar1f9gN5lmc75QH4UV2t2KDOVfThcBhvMlGeHSNVzNlP5jppDMB/Li+U3
 kjGG3U3qynv9vcjnwo4gYWExrmhcLqEOJ4BQ3Rrj6MXCM8kaftGL5kUl29/ks7z4OqGzz/BC2
 Xzy6UtI4O/M8j5X1WDZVVpiMMT6TdVyjxg7ReFctEqiPu1akkgh23uUtxvSHeMB0N0EuDvlcY
 wNrsIJz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Object IDs to skip are stored in a shared static oid_array.  Lookups do
a binary search on the sorted array.  The code checks if the object IDs
are already in the correct order while loading and skips sorting in that
case.

Simplify the code by using an oidset instead.  Memory usage is a bit
higher, but lookups are done in constant time and there is no need to
worry about any sort order.

Embed the oidset into struct fsck_options to make its ownership clear
(no hidden sharing) and avoid unnecessary pointer indirection.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
  fsck.c | 23 ++---------------------
  fsck.h |  8 +++++---
  2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/fsck.c b/fsck.c
index 83f4562390..9246afee22 100644
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
@@ -202,17 +192,10 @@ static void init_skiplist(struct fsck_options *options, const char *path)
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
  	fclose(fp);
  	strbuf_release(&sb);
-
-	if (sorted)
-		skiplist.sorted = 1;
  }
  
  static int parse_msg_type(const char *str)
@@ -317,9 +300,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
  
  static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
  {
-	if (opts && opts->skiplist && obj)
-		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
-	return 0;
+	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
  }
  
  __attribute__((format (printf, 4, 5)))
diff --git a/fsck.h b/fsck.h
index c3cf5e0034..26120e6186 100644
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
@@ -34,12 +36,12 @@ struct fsck_options {
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
