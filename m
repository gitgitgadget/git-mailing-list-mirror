From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH][GSoC] parse-options: Add OPT_SET_INT_NONEG.
Date: Tue, 11 Mar 2014 10:50:16 +0000
Message-ID: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 11:50:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNKGi-0008UA-S7
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 11:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbaCKKuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 06:50:40 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:62548 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaCKKuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 06:50:39 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so8354308pde.24
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pBZlBVVniZxUgT40rOEoEG29esS7DUfnZxpLHbgVj/Q=;
        b=MPgmOu8cwBJIBQq4eG0hnXZksEmxCOVsXlSkGZp7has9ETeeLBvewoG9ylMYaymNEp
         Tdahqoja/U0cRZERLm1jVWGQIXMvJzXhSWRoBHVtMtdIUJGoi+r8/4SC2ykH58GMBxcQ
         9R96Jg0ygmabb5VJLEscZNavDgGmeROKZAfDWNCgfTZYqalKjjmLpOMjs4H1mEi3u1sZ
         o8/ssA8vYXB5mrCrziyFDx7vrRGaPZVqcipdls1sZT+vRRfgKnkDKLJf0caSM/C7/Ika
         5u6C6BDtbrKWdW5PE7l/RNkXwNwZSZN5hxcEO8AlslIxzvHeQMy+m9VhMUpgEK6zvZn+
         IouQ==
X-Received: by 10.68.143.231 with SMTP id sh7mr47076852pbb.7.1394535038970;
        Tue, 11 Mar 2014 03:50:38 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.232.37])
        by mx.google.com with ESMTPSA id yo9sm105360476pab.16.2014.03.11.03.50.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Mar 2014 03:50:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243854>

Reference: http://git.github.io/SoC-2014-Microprojects.html
Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 builtin/fetch.c        |  5 ++---
 builtin/merge.c        |  5 ++---
 builtin/notes.c        | 10 ++++------
 builtin/pack-objects.c | 15 ++++++---------
 builtin/update-index.c | 20 ++++++++------------
 parse-options.h        |  4 ++++
 6 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..37c2a9d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -97,9 +97,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
-	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
-		   N_("convert to a complete repository"),
-		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
+	OPT_SET_INT_NONEG(0, "unshallow", &unshallow,
+		   N_("convert to a complete repository"), 1),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	{ OPTION_STRING, 0, "recurse-submodules-default",
diff --git a/builtin/merge.c b/builtin/merge.c
index f0cf120..cf9a157 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -203,9 +203,8 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
-	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
-		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
+	OPT_SET_INT_NONEG(0, "ff-only", &fast_forward,
+		N_("abort if fast-forward is not possible"), FF_ONLY),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("Verify that the named commit has a valid GPG signature")),
diff --git a/builtin/notes.c b/builtin/notes.c
index 2b24d05..02a554d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -739,13 +739,11 @@ static int merge(int argc, const char **argv, const char *prefix)
 			   N_("resolve notes conflicts using the given strategy "
 			      "(manual/ours/theirs/union/cat_sort_uniq)")),
 		OPT_GROUP(N_("Committing unmerged notes")),
-		{ OPTION_SET_INT, 0, "commit", &do_commit, NULL,
-			N_("finalize notes merge by committing unmerged notes"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+		OPT_SET_INT_NONEG(0, "commit", &do_commit,
+			N_("finalize notes merge by committing unmerged notes"), 1),
 		OPT_GROUP(N_("Aborting notes merge resolution")),
-		{ OPTION_SET_INT, 0, "abort", &do_abort, NULL,
-			N_("abort notes merge"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+		OPT_SET_INT_NONEG(0, "abort", &do_abort,
+			N_("abort notes merge"), 1),
 		OPT_END()
 	};
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..2e2b12a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2579,15 +2579,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not create an empty pack output")),
 		OPT_BOOL(0, "revs", &use_internal_rev_list,
 			 N_("read revision arguments from standard input")),
-		{ OPTION_SET_INT, 0, "unpacked", &rev_list_unpacked, NULL,
-		  N_("limit the objects to those that are not yet packed"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
-		{ OPTION_SET_INT, 0, "all", &rev_list_all, NULL,
-		  N_("include objects reachable from any reference"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
-		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
-		  N_("include objects referred by reflog entries"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_SET_INT_NONEG(0, "unpacked", &rev_list_unpacked,
+		  N_("limit the objects to those that are not yet packed"), 1),
+		OPT_SET_INT_NONEG(0, "all", &rev_list_all,
+		  N_("include objects reachable from any reference"), 1),
+		OPT_SET_INT_NONEG(0, "reflog", &rev_list_reflog,
+		  N_("include objects referred by reflog entries"), 1),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d12ad95..807e853 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -749,18 +749,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			chmod_callback},
-		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
-			N_("mark files as \"not changing\""),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
-		{OPTION_SET_INT, 0, "no-assume-unchanged", &mark_valid_only, NULL,
-			N_("clear assumed-unchanged bit"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
-		{OPTION_SET_INT, 0, "skip-worktree", &mark_skip_worktree_only, NULL,
-			N_("mark files as \"index-only\""),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
-		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NULL,
-			N_("clear skip-worktree bit"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		OPT_SET_INT_NONEG(0, "assume-unchanged", &mark_valid_only,
+			N_("mark files as \"not changing\""), MARK_FLAG),
+		OPT_SET_INT_NONEG(0, "no-assume-unchanged", &mark_valid_only,
+			N_("clear assumed-unchanged bit"), UNMARK_FLAG),
+		OPT_SET_INT_NONEG(0, "skip-worktree", &mark_skip_worktree_only,
+			N_("mark files as \"index-only\""), MARK_FLAG),
+		OPT_SET_INT_NONEG(0, "no-skip-worktree", &mark_skip_worktree_only,
+			N_("clear skip-worktree bit"), UNMARK_FLAG),
 		OPT_SET_INT(0, "info-only", &info_only,
 			N_("add to index only; do not add content to object database"), 1),
 		OPT_SET_INT(0, "force-remove", &force_remove,
diff --git a/parse-options.h b/parse-options.h
index d670cb9..7d20cf9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -125,6 +125,10 @@ struct option {
 				      (h), PARSE_OPT_NOARG }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_SET_INT_NONEG(s, l, v, h, i)  \
+				      { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+				      NULL, (i) }
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-- 
1.9.0
