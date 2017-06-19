Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE72C1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdFSVut (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:50:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35376 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbdFSVus (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:50:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so19442276pfs.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cGM4MjJKxqx4NEmESUJ0cuFSzCvc0TPQICPNtD5+18w=;
        b=CgHWanE6VExgUb5M5O2PgLk1a11V+R3cMBlZaT1d+kpcmrXmaw6RKPp0z2CcWoFy2f
         M5UfRTGx/PXmvyYy4hyWwjr3YhJSGErABS7KphAxnHvM8r5b2cZ2G8nbhqlLdXjV3vWL
         BErSju9Iuy+vTIn9X8EeG/IkcMm7USN1I9AzPZuk9NPvxZT/ipiOGCGMPv63aSA92zWD
         DGB3kCGs+iSAGn46GbnBicSqBmH+SV1tm0tadLRIehCIH3yB5oY7humvLr/SPu6n9s0A
         V4JIib6RMorzKxIoG98MlTATCCarZkjdKBwFv7mUCt1G0yqTmdPXF+oVa0iKhss3Xkyu
         //ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cGM4MjJKxqx4NEmESUJ0cuFSzCvc0TPQICPNtD5+18w=;
        b=FUq/9hNgd4edYUybdnUI5l8IL6St+dHbwqtMzCJQf2+L2SIZ+ZsCgDsSE4owNTVCb7
         ib/4nBzRx6raT378dmRd/PvoWeF7fnQmZhTLO2L6YsW9RmGi+0zGpq1KUmqMdIa/RS54
         CVi+SL1A6VKuTz8d/n0PYHcpYyH8CJRxzyJTpRvZjifPrbXiiF5T2sXo5YZ1XHXI4Ja8
         HMKo/I4cqTnaAd4dDOIXkNP97lS/06dX+jVkac2LxIgnlfA7OjtQmurxkgAAVxWL2pnu
         E/60yvCTbYZMF7WzWS3Vv9BODlHFBw3dtvD2M/6hqnWRqX7RwR6AMo+j8Ssn8+/VHk8n
         J2vQ==
X-Gm-Message-State: AKS2vOxTidtrYlEendAyEE3Ms6eQSKRjnGEVobOERJ5uW9n7es6CO7GA
        tIK9ciixv2Smyi3W
X-Received: by 10.99.119.198 with SMTP id s189mr22779436pgc.32.1497909047197;
        Mon, 19 Jun 2017 14:50:47 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id 5sm20744309pfe.60.2017.06.19.14.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 14:50:46 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH 1/6] dir: create function count_slashes
Date:   Tue, 20 Jun 2017 03:20:20 +0530
Message-Id: <20170619215025.10086-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar functions exist in apply.c and builtin/show-branch.c for
counting the number of slashes in a string. Also in the later
patches, we introduce a third caller for the same. Hence, we unify
it now by cleaning the existing functions and declaring a common
function count_slashes in dir.h and implementing it in dir.c to
remove this code duplication.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
The complete build report of this is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: All-patch-series
Build #111

 apply.c               | 11 -----------
 builtin/show-branch.c | 13 +++----------
 dir.c                 |  9 +++++++++
 dir.h                 |  3 +++
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index c49cef063..121e53406 100644
--- a/apply.c
+++ b/apply.c
@@ -762,17 +762,6 @@ static char *find_name_traditional(struct apply_state *state,
 	return find_name_common(state, line, def, p_value, line + len, 0);
 }
 
-static int count_slashes(const char *cp)
-{
-	int cnt = 0;
-	char ch;
-
-	while ((ch = *cp++))
-		if (ch == '/')
-			cnt++;
-	return cnt;
-}
-
 /*
  * Given the string after "--- " or "+++ ", guess the appropriate
  * p_value for the given patch.
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4a6cc6f49..3636a0559 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -5,6 +5,7 @@
 #include "color.h"
 #include "argv-array.h"
 #include "parse-options.h"
+#include "dir.h"
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
@@ -421,14 +422,6 @@ static int append_tag_ref(const char *refname, const struct object_id *oid,
 
 static const char *match_ref_pattern = NULL;
 static int match_ref_slash = 0;
-static int count_slash(const char *s)
-{
-	int cnt = 0;
-	while (*s)
-		if (*s++ == '/')
-			cnt++;
-	return cnt;
-}
 
 static int append_matching_ref(const char *refname, const struct object_id *oid,
 			       int flag, void *cb_data)
@@ -438,7 +431,7 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 	 * refs/tags/v0.99.9a and friends.
 	 */
 	const char *tail;
-	int slash = count_slash(refname);
+	int slash = count_slashes(refname);
 	for (tail = refname; *tail && match_ref_slash < slash; )
 		if (*tail++ == '/')
 			slash--;
@@ -529,7 +522,7 @@ static void append_one_rev(const char *av)
 		int saved_matches = ref_name_cnt;
 
 		match_ref_pattern = av;
-		match_ref_slash = count_slash(av);
+		match_ref_slash = count_slashes(av);
 		for_each_ref(append_matching_ref, NULL);
 		if (saved_matches == ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
diff --git a/dir.c b/dir.c
index 9efcf1eab..4a953c16a 100644
--- a/dir.c
+++ b/dir.c
@@ -52,6 +52,15 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 static int get_dtype(struct dirent *de, struct index_state *istate,
 		     const char *path, int len);
 
+int count_slashes(const char *s)
+{
+	int cnt = 0;
+	while (*s)
+		if (*s++ == '/')
+			cnt++;
+	return cnt;
+}
+
 int fspathcmp(const char *a, const char *b)
 {
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
diff --git a/dir.h b/dir.h
index a89c13e27..e3717055d 100644
--- a/dir.h
+++ b/dir.h
@@ -197,6 +197,9 @@ struct dir_struct {
 	unsigned unmanaged_exclude_files;
 };
 
+/*Count the number of slashes for string s*/
+extern int count_slashes(const char *s);
+
 /*
  * The ordering of these constants is significant, with
  * higher-numbered match types signifying "closer" (i.e. more
-- 
2.13.0

