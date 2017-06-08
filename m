Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18991FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdFHSI0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 14:08:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36163 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdFHSIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 14:08:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so5343748pgb.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b9QnCWqqUG8nARpGHLjMqebTLjPCydtV6VMpcHS1QoM=;
        b=FvDzXzxVh9l/HfQcpq9B8fSXW3pNkPuhgyLbN6YIdiPdK7liZw9rr68qBK2LmVnD+Y
         mW3AFuSiIGblMIz4BQdejIDRLCyRVx2TOI+XgVra/oBD5R6MVeqzphLKNdwmXhkApbSd
         5qyLnpYSxvwyhDIa6O91hjymTjt487/MJnVKx+fMcEinhRylIwzNX6zwJ4XYu9cMreOY
         80SrQyv3EkZ3dvmUNg4YPohAHORO4xoAdvBZwSA4yLGlNNTWRfKToYcb65DAvRnlMbUP
         RSsVtyLb/AUIAouKy5J78XPN4Jgr9/71zgPdmMPiYP7pTcLNZYRVjdt3B22k3dO7m6uI
         C+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b9QnCWqqUG8nARpGHLjMqebTLjPCydtV6VMpcHS1QoM=;
        b=WEfLQDJ952bqco4L63LjJqn/Zk7I9kXendC2MpJaCkeNCSckY60EgnW/gug8eWH6x2
         /mSK3Bu3W8rKSDjlfn4dn9zTYjo0y0ncqtOP4Ulz8/dknQuYoS0jJkiqbVRRR3fo8Vcb
         KVQr4w7KB6TCsW480HOIssTLcS127a6rIfMIGg+mmBxmxfXrm9z6S5t5WbyCYDoRdM7D
         +J4JPERIiSJDp9uX66T3h14Argfv+HRdjhUaoHsVwCBXoXfWefNRSJpHlOoOHbuehxUu
         cb5jU2tJ/IgXBfuvxfMClJd9S3ugJLn8i5QKe4vGBLvCRvCIiAgL/Js4Lb11oJ3RxWHj
         jyJw==
X-Gm-Message-State: AODbwcCBF6ChY3OmZc1GXfam47Ot1cfx9DRfVGiDQEpOPhwXtaCS1P3b
        qANk1Ybi2nrnHI4n
X-Received: by 10.99.218.69 with SMTP id l5mr39971000pgj.88.1496945304425;
        Thu, 08 Jun 2017 11:08:24 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id 62sm6266375pfz.39.2017.06.08.11.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 11:08:23 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1] dir: create function count_slashes
Date:   Thu,  8 Jun 2017 23:38:12 +0530
Message-Id: <20170608180812.6678-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
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
---
In future, I intend to use this function in builtin/submodule--helper.c
as well, hence this change was introduced now.

The patch passes all the tests.
Complete build report of this patch is available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: count_slashes
Build #97

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

